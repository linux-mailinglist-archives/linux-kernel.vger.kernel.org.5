Return-Path: <linux-kernel+bounces-91299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E19870C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D5B1F26EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D844086B;
	Mon,  4 Mar 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJTghnHF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18361CA94;
	Mon,  4 Mar 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587573; cv=none; b=iyirjt0p6GOI1MaASR5tPiR4K4xuIw/tBS7hqKy70yxs03nvLjpsbJLlyXzJbBRPIsBecZJbm6ae3xFiAxKptVYrszCVnAlMEHeXFkcsMt5YQ3jheiTLKHlbAHT1P9njJGJTqc7jekBPZFkvlfg4fk8ddE1/4OmiYoorFYf7N8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587573; c=relaxed/simple;
	bh=j3/VuXcdAAUeB/9osjvAgkL6rASQvBSAah7VCvAx5wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvGSFS0I72WqvU+wkH9jONpOb8sPn/DzpZz/q/UeEKGHFl4LE+86E/eaSVyvRWQlQCJWr9kUAKU56oarAan02y8nqj7EYrG00ZCEObgQKlMBbwj/rf+GJB3rZnnmRfVql/Y6hq4XeuZ1mBhB6NgVSzPOAWWdXHAf01hRHetgRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJTghnHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC1C433C7;
	Mon,  4 Mar 2024 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587573;
	bh=j3/VuXcdAAUeB/9osjvAgkL6rASQvBSAah7VCvAx5wg=;
	h=From:To:Cc:Subject:Date:From;
	b=AJTghnHFzAZkVVOP3bTPWb0PI/JGS7hXwJuVBRfdKlN9FgW3WHe3Vz07oRnrljkcp
	 9cVguoS36kVFCueuuhNdSP66VM/hihp8RmxIaXOqnpnIfT4JJwQuhj4/Vu0cT/YS0r
	 rCq+wvoEp9w5siDgSdZLKhQZKydWCspuMJoAdlmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 4.19 00/16] 4.19.309-rc1 review
Date: Mon,  4 Mar 2024 21:23:21 +0000
Message-ID: <20240304211534.328737119@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.309-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.309-rc1
X-KernelTest-Deadline: 2024-03-06T21:15+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.309 release.
There are 16 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.309-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.309-rc1

Arturas Moskvinas <arturas.moskvinas@gmail.com>
    gpio: 74x164: Enable output pins after registers are reset

Baokun Li <libaokun1@huawei.com>
    cachefiles: fix memory leak in cachefiles_add_cache()

Ivan Semenov <ivan@semenov.dev>
    mmc: core: Fix eMMC initialization with 1-bit bus connection

David Sterba <dsterba@suse.com>
    btrfs: dev-replace: properly validate device names

Johannes Berg <johannes.berg@intel.com>
    wifi: nl80211: reject iftype change with mesh ID change

Alexander Ofitserov <oficerovas@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Takashi Iwai <tiwai@suse.de>
    ALSA: Drop leftover snd-rtctimer stuff from Makefile

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx-i2c: Do not free non existing IRQ

Arnd Bergmann <arnd@arndb.de>
    efi/capsule-loader: fix incorrect allocation size

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid potential use-after-free in hci_error_reset

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Oleksij Rempel <o.rempel@pengutronix.de>
    lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Yunjian Wang <wangyunjian@huawei.com>
    tun: Fix xdp_rxq_info's queue_index when detaching

Ryosuke Yasuoka <ryasuoka@redhat.com>
    netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter


-------------

Diffstat:

 Makefile                                   |  4 ++--
 drivers/firmware/efi/capsule-loader.c      |  2 +-
 drivers/gpio/gpio-74x164.c                 |  4 ++--
 drivers/mmc/core/mmc.c                     |  2 ++
 drivers/net/gtp.c                          | 12 ++++++------
 drivers/net/tun.c                          |  1 +
 drivers/net/usb/dm9601.c                   |  2 +-
 drivers/net/usb/lan78xx.c                  |  3 ++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  4 +++-
 fs/btrfs/dev-replace.c                     | 24 ++++++++++++++++++++----
 fs/cachefiles/bind.c                       |  3 +++
 net/bluetooth/hci_core.c                   |  7 ++++---
 net/bluetooth/hci_event.c                  |  9 ++++++++-
 net/bluetooth/l2cap_core.c                 |  8 +++++++-
 net/netlink/af_netlink.c                   |  2 +-
 net/wireless/nl80211.c                     |  2 ++
 sound/core/Makefile                        |  1 -
 17 files changed, 65 insertions(+), 25 deletions(-)



