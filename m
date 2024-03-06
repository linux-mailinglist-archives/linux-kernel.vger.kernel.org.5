Return-Path: <linux-kernel+bounces-94115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39270873A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB71C2201F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442F137904;
	Wed,  6 Mar 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/94v3DE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE67134738;
	Wed,  6 Mar 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737540; cv=none; b=O7tTr8bJP/RHrZGEdtjMEsQsRHjDXy7xEnfO9k4lmvlhPQ9p34aGDC1b7e/SbGFEcHLvsW5NlFgQa8xw4zigaxGy9VC9MLvr3lKgM7VYuCYnr6ytkaUJPrgR3Xv5c6n7EgRUECHOCSQ9jwDSwYULvaeQgieqYA6QzmOMBX4sO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737540; c=relaxed/simple;
	bh=xhfWyunDWc55B8i1Bgv5qsbhlkWAm+qBXVsXbA/nBZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbvVD4OHar3sKwXEc2XBIHRQsPMqHXTPmRTWOLiKEuRfnFtKUGakqCD1Sf5qQJx2WtNKdBHFb1HBKyYHki0zqHTxaKNqA3tW0hz7QM/ts7Xtknv/8JdOOJFaKm5V2DwXmfh6VPPsYL+WDownZ3Lug1zADpEIKFTaiRs4/kORBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/94v3DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5C7C433F1;
	Wed,  6 Mar 2024 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737540;
	bh=xhfWyunDWc55B8i1Bgv5qsbhlkWAm+qBXVsXbA/nBZs=;
	h=From:To:Cc:Subject:Date:From;
	b=U/94v3DEnN6grUKJAzMwFiD8+PZPNbzaeeGVtEgcLRUnzeJ4HRzPHgf6R85Xkg8IK
	 4m4YQLCX1t1Lyej4zjbxObqRoDlJL2KlumsGJM80Al+AidCNnIJCNxeCXHItwVmr98
	 t5ojRfXbs9nEtkxKKoNYNwV/GaV8yC6UkS3PiQDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.212
Date: Wed,  6 Mar 2024 15:05:34 +0000
Message-ID: <2024030635-stylishly-tackle-b393@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.212 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/riscv/include/asm/pgtable.h                    |    2 
 arch/x86/kernel/cpu/intel.c                         |  178 ++++++++++----------
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c |    5 
 drivers/dma/fsl-qdma.c                              |   21 +-
 drivers/firmware/efi/capsule-loader.c               |    2 
 drivers/gpio/gpio-74x164.c                          |    4 
 drivers/gpio/gpiolib.c                              |   10 -
 drivers/mmc/core/mmc.c                              |    2 
 drivers/mmc/host/sdhci-xenon-phy.c                  |   48 ++++-
 drivers/mtd/nand/spi/gigadevice.c                   |   81 +++++++--
 drivers/net/gtp.c                                   |   12 -
 drivers/net/tun.c                                   |    1 
 drivers/net/usb/dm9601.c                            |    2 
 drivers/net/usb/lan78xx.c                           |    3 
 drivers/platform/x86/touchscreen_dmi.c              |    4 
 drivers/power/supply/bq27xxx_battery_i2c.c          |    4 
 drivers/soc/qcom/rpmhpd.c                           |    7 
 fs/afs/dir.c                                        |    4 
 fs/btrfs/dev-replace.c                              |   24 ++
 fs/cachefiles/bind.c                                |    3 
 fs/ext4/mballoc.c                                   |   39 ++--
 fs/hugetlbfs/inode.c                                |    6 
 net/bluetooth/hci_core.c                            |    7 
 net/bluetooth/hci_event.c                           |   13 +
 net/bluetooth/l2cap_core.c                          |    8 
 net/core/rtnetlink.c                                |   11 -
 net/ipv4/ip_tunnel.c                                |   28 ++-
 net/ipv6/addrconf.c                                 |    7 
 net/mptcp/diag.c                                    |    3 
 net/mptcp/protocol.c                                |   49 +++++
 net/netfilter/nft_compat.c                          |   20 ++
 net/netlink/af_netlink.c                            |    2 
 net/wireless/nl80211.c                              |    2 
 security/tomoyo/common.c                            |    3 
 sound/core/Makefile                                 |    1 
 36 files changed, 426 insertions(+), 192 deletions(-)

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Andy Shevchenko (1):
      gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Baokun Li (2):
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
      cachefiles: fix memory leak in cachefiles_add_cache()

Bartosz Golaszewski (1):
      gpio: fix resource unwinding order in error path

Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Chuanhong Guo (1):
      mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Elad Nachman (2):
      mmc: sdhci-xenon: add timeout for PHY init complete
      mmc: sdhci-xenon: fix PHY init clock stability

Eric Dumazet (1):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Florian Westphal (1):
      net: ip_tunnel: prevent perpetual headroom growth

Greg Kroah-Hartman (1):
      Linux 5.10.212

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Hans de Goede (2):
      platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Oleksij Rempel (1):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Paolo Abeni (1):
      mptcp: fix possible deadlock in subflow diag

Paolo Bonzini (1):
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Reto Schneider (1):
      mtd: spinand: gigadevice: Support GD5F1GQ5UExxG

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Takashi Iwai (1):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Tetsuo Handa (1):
      tomoyo: fix UAF write bug in tomoyo_write_control()

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Zijun Hu (1):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

zhenwei pi (1):
      crypto: virtio/akcipher - Fix stack overflow on memcpy


