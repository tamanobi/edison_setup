#!/bin/sh

# update repository
OPKG_FEEDS = base-feeds.conf
OPKG_IOTKIT = iotkit.conf
cat << EOS > $OPKG_FEEDS
src/gz all http://repo.opkg.net/edison/repo/all
src/gz edison http://repo.opkg.net/edison/repo/edison
src/gz core2-32 http://repo.opkg.net/edison/repo/core2-32
EOS

cat << EOS > $OPKG_IOTKIT
src iotkit http://iotdk.intel.com/repos/2.0/intelgalactic
src iotdk-all http://iotdk.intel.com/repos/2.0/iotdk/all
src iotdk-i586 http://iotdk.intel.com/repos/2.0/iotdk/i586
src iotdk-x86 http://iotdk.intel.com/repos/2.0/iotdk/x86
EOS

OPKG_DIRECTORY = /etc/opkg/
mv -b $OPKG_FEEDS $OPKG_DIRECTORY
mv -b $OPKG_IOTKIT $OPKG_DIRECTORY

# install
opkg update
opkg upgrade
opkg install sudo bash less git vim glibc-locale-ja glibc-localedata-ja-jp glibc-charmap-utf-8 localedef screen
# set timezone
timedatectl set-timezone Asia/Tokyo
# set locale
localedef -i ja_JP -f UTF-8 ja_JP.utf8
