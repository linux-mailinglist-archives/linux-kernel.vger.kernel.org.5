Return-Path: <linux-kernel+bounces-94111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11756873A26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD283288A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93A135A47;
	Wed,  6 Mar 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s01/oEpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B61353FE;
	Wed,  6 Mar 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737528; cv=none; b=gugozh6W02lYTBgDDurRgOVQ6W9fKbvEu86QuOUb9WV3wAEcpRmHdW8Ega/HVjmLlFP1fjhHdpHcdZtvlbh5lHFBkVzuAoeBYn+id86bpZS8iECnWVw76mYE/s7gODz/8x5TjlBEzeienc5tY27C8MZQWexxX1GfIRIAuNybxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737528; c=relaxed/simple;
	bh=J8V2Ue/EveMP/xUu2tKT/2KwvcPblsAhpW1Y2dwqIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsN63WbF7AuartvNAb4xQAvavqTQdJD3fbXWkt+DLbOTypupt3At2WzyjafGF0RTLnvFNHsEKqXHqCxgTdP5m3To3GKAQT7Y19PfMj9iMdsglBB7rgIEzOfqpAakV8nEvZ2MDKKaXLD5H2Xq2i7ttHicVscHO/qqs+LJwRfwkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s01/oEpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43188C43390;
	Wed,  6 Mar 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737527;
	bh=J8V2Ue/EveMP/xUu2tKT/2KwvcPblsAhpW1Y2dwqIy0=;
	h=From:To:Cc:Subject:Date:From;
	b=s01/oEpRy+LAXu6jlqCJvRtYDbh5nTyaCYGLFLFd9GADJZe6wfJitEnFFrxLfP3Zg
	 74opq0/DiYl/r/6nLnsCq5bEADg05OY4etRoR9S/yiQD+kxrhk+C5mBaN5uQDiyJQ9
	 21HAKEQnbrJi+FzWnQj46oLKvSomIAtfJw95Cl0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.309
Date: Wed,  6 Mar 2024 15:05:23 +0000
Message-ID: <2024030624-arise-voltage-4cf5@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.309 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 +-
 drivers/firmware/efi/capsule-loader.c      |    2 +-
 drivers/gpio/gpio-74x164.c                 |    4 ++--
 drivers/mmc/core/mmc.c                     |    2 ++
 drivers/net/gtp.c                          |   12 ++++++------
 drivers/net/tun.c                          |    1 +
 drivers/net/usb/dm9601.c                   |    2 +-
 drivers/net/usb/lan78xx.c                  |    3 ++-
 drivers/power/supply/bq27xxx_battery_i2c.c |    4 +++-
 fs/btrfs/dev-replace.c                     |   24 ++++++++++++++++++++----
 fs/cachefiles/bind.c                       |    3 +++
 net/bluetooth/hci_core.c                   |    7 ++++---
 net/bluetooth/hci_event.c                  |    9 ++++++++-
 net/bluetooth/l2cap_core.c                 |    8 +++++++-
 net/netlink/af_netlink.c                   |    2 +-
 net/wireless/nl80211.c                     |    2 ++
 sound/core/Makefile                        |    1 -
 17 files changed, 64 insertions(+), 24 deletions(-)

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Baokun Li (1):
      cachefiles: fix memory leak in cachefiles_add_cache()

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Greg Kroah-Hartman (1):
      Linux 4.19.309

Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Oleksij Rempel (1):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Takashi Iwai (1):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching


