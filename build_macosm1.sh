#!/bin/sh
#

if [ ! -e configure ];then 
    printf "\n --------------AUTOGEN----------------\n"
    sleep 5
    ./autogen.sh
fi

printf "\n -----------------CLEAN---------------\n"
sleep 5

make clean
make distclean

printf "\n -----------------CONFIGURE----------------\n"
sleep 5
export MACOS_VERSION_MIN=10.10
export CFLAGS="-O2 -arch arm64 -mmacosx-version-min=${MACOS_VERSION_MIN}"
export LDFLAGS="-arch arm64 -mmacosx-version-min=${MACOS_VERSION_MIN}"
export PREFIX="$(pwd)/libsodium-apple"
export MACOS_ARM64_PREFIX="${PREFIX}/tmp/macos-arm64"
export LIBSODIUM_ENABLE_MINIMAL_FLAG="--enable-minimal"

rm -rf $PREFIX

./configure --host=arm-apple-darwin20 --prefix="$MACOS_ARM64_PREFIX" ${LIBSODIUM_ENABLE_MINIMAL_FLAG}

printf "\n ------------------MAKE-----------------\n"
sleep 5
make

printf "\n -----------------INSTALL----------------\n"
sleep 5
make install

printf "\n ------------------DONE-----------------\n"
sleep 5
find -L $PREFIX -type f -name 'libsodium.*'
