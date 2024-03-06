Return-Path: <linux-kernel+bounces-94113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9D873A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C33A289687
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE461136643;
	Wed,  6 Mar 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V44h9chS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264321361BC;
	Wed,  6 Mar 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737535; cv=none; b=pz6y1JzyP0sKbxwhG6IpLbWkW/6ShackiArg/mF2PLaJ7Kbmdk0k9mmKD9eGRPYh72DX6FuvlTw0x9g676KV0X3ytMVBFUFbMtVFsKlU8D380Kf2LA4LP0RUBGpbbAvDYIy7W+W/323/QXXbvR77pHpeF0QBfDyCztCAarAMMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737535; c=relaxed/simple;
	bh=gKwTeReT90lDsga3wRh0gjEfRLtys49UxhehYgBI+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnMS3giv2ZPGRGxBr5qZnPDqZVnGTv0b3HUxhYbwiceTO4mFKgPo8mLRkacTrbfh1vWXlztVNlXgaLhIB5JE4PiXeu5hmsmFldpZkc4tUVEpeGZds4xmQa5o+gC0hU+Zxnxj+ANhH+x2UW6zr2dVelhjvu8I3seElCVVYUASMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V44h9chS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68757C43390;
	Wed,  6 Mar 2024 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737534;
	bh=gKwTeReT90lDsga3wRh0gjEfRLtys49UxhehYgBI+lY=;
	h=From:To:Cc:Subject:Date:From;
	b=V44h9chSGzk0S8YkkiL3twR/tWo1FFEka3tlF5nIPcHhjdM79U3htuDqG5aG5olY4
	 Z4yaOPiN2WouKfOQ5bT7UaYxpyPwde8AmtA1bYkC+/hsNT8M/wEk2oAD96pbzox+Hs
	 X6Deyv2MByn3m0dP4r7odRAGdtHt9RkWpH3iecHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.271
Date: Wed,  6 Mar 2024 15:05:28 +0000
Message-ID: <2024030629-bunkbed-stabilize-1cdd@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.271 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 
 arch/x86/kernel/cpu/intel.c                |  178 ++++++++++++++---------------
 drivers/dma/fsl-qdma.c                     |   21 +--
 drivers/firmware/efi/capsule-loader.c      |    2 
 drivers/gpio/gpio-74x164.c                 |    4 
 drivers/mmc/core/mmc.c                     |    2 
 drivers/net/gtp.c                          |   12 -
 drivers/net/tun.c                          |    1 
 drivers/net/usb/dm9601.c                   |    2 
 drivers/net/usb/lan78xx.c                  |    3 
 drivers/power/supply/bq27xxx_battery_i2c.c |    4 
 fs/afs/dir.c                               |    4 
 fs/btrfs/dev-replace.c                     |   24 +++
 fs/cachefiles/bind.c                       |    3 
 fs/hugetlbfs/inode.c                       |    6 
 net/bluetooth/hci_core.c                   |    7 -
 net/bluetooth/hci_event.c                  |    9 +
 net/bluetooth/l2cap_core.c                 |    8 +
 net/core/rtnetlink.c                       |   11 -
 net/ipv4/ip_tunnel.c                       |   28 +++-
 net/ipv6/addrconf.c                        |    7 -
 net/netfilter/nft_compat.c                 |   20 +++
 net/netlink/af_netlink.c                   |    2 
 net/wireless/nl80211.c                     |    2 
 sound/core/Makefile                        |    1 
 25 files changed, 223 insertions(+), 140 deletions(-)

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Baokun Li (1):
      cachefiles: fix memory leak in cachefiles_add_cache()

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Eric Dumazet (1):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Florian Westphal (1):
      net: ip_tunnel: prevent perpetual headroom growth

Greg Kroah-Hartman (1):
      Linux 5.4.271

Hans de Goede (1):
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

Paolo Bonzini (1):
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Takashi Iwai (1):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching


