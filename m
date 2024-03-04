Return-Path: <linux-kernel+bounces-91314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BBD870D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3871428FBA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888497B3C3;
	Mon,  4 Mar 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UXajFTCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2A1C687;
	Mon,  4 Mar 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588110; cv=none; b=Yy2gSWyLGyNUMCHsW96CQTrugRSr2ooow90dd6e/s0Ke+g/gEvUxtu/ed4c+QDO//LoOU8OGbVmiLEUC40Hev9JKu+UkINQ2gGN+DwrOVnUXIz/ZQJUSGwverZj8qsxfJdJekKrl3mm4odSRc+q09z3KEpN+uOT6uLOZPK1mZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588110; c=relaxed/simple;
	bh=m3/l97d1KV6pxXLCeeHyzh+bdY55e3mOtUvM88K00oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqFXIvHntx0hYqyt62W0oRCdfoDQqmgHRjsgolr8SwZR8Xa34S47MdsgX/xVYG0gQxmPuqJZTKxOASgxrM9LwK2/vTrsY+vYgdCD21sufGsGj8sAjimFxdXbtAGPi272LNYFZomeFHdCO4RGX9hQnOA0zNT3fVHjxWRze41xBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UXajFTCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1584C433C7;
	Mon,  4 Mar 2024 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588110;
	bh=m3/l97d1KV6pxXLCeeHyzh+bdY55e3mOtUvM88K00oM=;
	h=From:To:Cc:Subject:Date:From;
	b=UXajFTCmlYXf8V0YJFC9Up895ZGBdlXTb8B/7t2tNJsIi4qX5jN54R3c6yn5RToZY
	 89+vNHt2DpNCW2Svuhk/VLHpVxOYMtJ9wbqGozCb3uyOmyfvbYZV+LUrJI5ivds496
	 o+AWgSz1KZWPldHBQw6nENGYNB2ORB3Z2nLmt6lo=
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
Subject: [PATCH 5.10 00/42] 5.10.212-rc1 review
Date: Mon,  4 Mar 2024 21:23:27 +0000
Message-ID: <20240304211537.631764077@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.212-rc1
X-KernelTest-Deadline: 2024-03-06T21:15+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.212 release.
There are 42 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.212-rc1

Davide Caratti <dcaratti@redhat.com>
    mptcp: fix double-free on socket dismantle

Chuanhong Guo <gch981213@gmail.com>
    mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: fix resource unwinding order in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arturas Moskvinas <arturas.moskvinas@gmail.com>
    gpio: 74x164: Enable output pins after registers are reset

Oscar Salvador <osalvador@suse.de>
    fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Baokun Li <libaokun1@huawei.com>
    cachefiles: fix memory leak in cachefiles_add_cache()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible deadlock in subflow diag

Paolo Bonzini <pbonzini@redhat.com>
    x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Bjorn Andersson <quic_bjorande@quicinc.com>
    pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Zong Li <zong.li@sifive.com>
    riscv: add CALLER_ADDRx support

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: fix PHY init clock stability

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov <ivan@semenov.dev>
    mmc: core: Fix eMMC initialization with 1-bit bus connection

Curtis Klein <curtis.klein@hpe.com>
    dmaengine: fsl-qdma: init irq after reg initialization

Peng Ma <peng.ma@nxp.com>
    dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

David Sterba <dsterba@suse.com>
    btrfs: dev-replace: properly validate device names

Johannes Berg <johannes.berg@intel.com>
    wifi: nl80211: reject iftype change with mesh ID change

Alexander Ofitserov <oficerovas@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fix UAF write bug in tomoyo_write_control()

Dimitris Vlachos <dvlachos@ics.forth.gr>
    riscv: Sparse-Memory/vmemmap out-of-bounds fix

David Howells <dhowells@redhat.com>
    afs: Fix endless loop in directory parsing

Takashi Iwai <tiwai@suse.de>
    ALSA: Drop leftover snd-rtctimer stuff from Makefile

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx-i2c: Do not free non existing IRQ

Arnd Bergmann <arnd@arndb.de>
    efi/capsule-loader: fix incorrect allocation size

Lin Ma <linma@zju.edu.cn>
    rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Ignat Korchagin <ignat@cloudflare.com>
    netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid potential use-after-free in hci_error_reset

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Oleksij Rempel <linux@rempel-privat.de>
    lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Yunjian Wang <wangyunjian@huawei.com>
    tun: Fix xdp_rxq_info's queue_index when detaching

Florian Westphal <fw@strlen.de>
    net: ip_tunnel: prevent perpetual headroom growth

Ryosuke Yasuoka <ryasuoka@redhat.com>
    netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Han Xu <han.xu@nxp.com>
    mtd: spinand: gigadevice: Fix the get ecc status issue

Reto Schneider <reto.schneider@husqvarnagroup.com>
    mtd: spinand: gigadevice: Support GD5F1GQ5UExxG

zhenwei pi <pizhenwei@bytedance.com>
    crypto: virtio/akcipher - Fix stack overflow on memcpy

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/riscv/include/asm/ftrace.h                    |   5 +
 arch/riscv/include/asm/pgtable.h                   |   2 +-
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/return_address.c                 |  48 ++++++
 arch/x86/kernel/cpu/intel.c                        | 178 +++++++++++----------
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |   5 +-
 drivers/dma/fsl-qdma.c                             |  25 +--
 drivers/firmware/efi/capsule-loader.c              |   2 +-
 drivers/gpio/gpio-74x164.c                         |   4 +-
 drivers/gpio/gpiolib.c                             |  12 +-
 drivers/mmc/core/mmc.c                             |   2 +
 drivers/mmc/host/sdhci-xenon-phy.c                 |  48 ++++--
 drivers/mtd/nand/spi/gigadevice.c                  |  81 ++++++++--
 drivers/net/gtp.c                                  |  12 +-
 drivers/net/tun.c                                  |   1 +
 drivers/net/usb/dm9601.c                           |   2 +-
 drivers/net/usb/lan78xx.c                          |   3 +-
 drivers/platform/x86/touchscreen_dmi.c             |   4 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   4 +-
 drivers/soc/qcom/rpmhpd.c                          |   7 +-
 fs/afs/dir.c                                       |   4 +-
 fs/btrfs/dev-replace.c                             |  24 ++-
 fs/cachefiles/bind.c                               |   3 +
 fs/ext4/mballoc.c                                  |  39 ++---
 fs/hugetlbfs/inode.c                               |   6 +-
 net/bluetooth/hci_core.c                           |   7 +-
 net/bluetooth/hci_event.c                          |  13 +-
 net/bluetooth/l2cap_core.c                         |   8 +-
 net/core/rtnetlink.c                               |  11 +-
 net/ipv4/ip_tunnel.c                               |  28 +++-
 net/ipv6/addrconf.c                                |   7 +-
 net/mptcp/diag.c                                   |   3 +
 net/mptcp/protocol.c                               |  49 ++++++
 net/netfilter/nft_compat.c                         |  20 +++
 net/netlink/af_netlink.c                           |   2 +-
 net/wireless/nl80211.c                             |   2 +
 security/tomoyo/common.c                           |   3 +-
 sound/core/Makefile                                |   1 -
 39 files changed, 485 insertions(+), 196 deletions(-)



