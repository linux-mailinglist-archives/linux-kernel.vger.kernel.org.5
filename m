Return-Path: <linux-kernel+bounces-19422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E020D826CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E3E2835DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9029423;
	Mon,  8 Jan 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zdp42oOp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C8219E2;
	Mon,  8 Jan 2024 11:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25DDC433D9;
	Mon,  8 Jan 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704713183;
	bh=O2+sahjlyDACaf0tpZwPgubJkEXIDHR2sZeJ5df5m38=;
	h=From:To:Cc:Subject:Date:From;
	b=Zdp42oOpxJZxHOYq+PFcdxHRuiUi2zSwUJNqsbmXM7h5TexpyBZksza1Sd3nT0J+0
	 mJqNR9bKqdie+s7pWeZBNFab8EVQR1FCDsPEX7tZysegF6v1ZMXe4EBTSqXkDNCwKm
	 RwEN6FKJWLrHpaqjR6kZClH8p2v7ujPSLdJVGyio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.335
Date: Mon,  8 Jan 2024 12:26:18 +0100
Message-ID: <2024010819-audition-creative-f1dc@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.14.335 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                        |    2 
 arch/arm/mach-omap2/id.c                        |    5 +
 arch/s390/include/asm/fpu/api.h                 |    2 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c  |    4 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      |    4 -
 drivers/input/keyboard/ipaq-micro-keys.c        |    3 
 drivers/md/dm-integrity.c                       |   11 +--
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c |    5 +
 drivers/usb/serial/ftdi_sio.c                   |    6 -
 drivers/usb/serial/ftdi_sio_ids.h               |    6 -
 drivers/usb/serial/option.c                     |    5 +
 fs/block_dev.c                                  |    9 +-
 net/9p/protocol.c                               |   17 +++-
 net/bluetooth/hci_event.c                       |    3 
 net/ife/ife.c                                   |    1 
 net/mac80211/mesh_plink.c                       |   10 +-
 net/rfkill/rfkill-gpio.c                        |    8 ++
 net/wireless/certs/wens.hex                     |   87 ++++++++++++++++++++++++
 18 files changed, 158 insertions(+), 30 deletions(-)

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Eric Dumazet (1):
      net: sched: ife: fix potential use-after-free

Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Greg Kroah-Hartman (1):
      Linux 4.14.335

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Javier Carrasco (1):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Johannes Berg (2):
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources


