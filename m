Return-Path: <linux-kernel+bounces-19426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBAA826CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75941C21F26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86431A9E;
	Mon,  8 Jan 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oFYVVvE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F2358B7;
	Mon,  8 Jan 2024 11:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A371CC433C8;
	Mon,  8 Jan 2024 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704713197;
	bh=j5fQHg9wLurVxNOop//meMscRBPL77BkwbwtIDIhMgc=;
	h=From:To:Cc:Subject:Date:From;
	b=1oFYVVvElgcB/ZqLe6vZBYEl+1pVvrB6Ol88DVK14x6u4k5/CvjP3m+LOGnBd97D1
	 uOiqbBhPj671LVO6+8NQoMemlN8yuKo1b5KWILlrQ93yM72Zd+BdXdemPlcMeaDEdR
	 kKNzxpHXJRmnLs9wAVNdJC3lwwQcTddkKW159NrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.266
Date: Mon,  8 Jan 2024 12:26:29 +0100
Message-ID: <2024010830-helping-boasting-1c28@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.266 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/arm/mach-omap2/id.c                                 |    5 
 arch/s390/include/asm/fpu/api.h                          |    2 
 arch/x86/kernel/alternative.c                            |    2 
 drivers/i2c/busses/i2c-aspeed.c                          |   48 +++++---
 drivers/iio/adc/ti_am335x_adc.c                          |    4 
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c           |    4 
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c               |    4 
 drivers/input/keyboard/ipaq-micro-keys.c                 |    3 
 drivers/interconnect/core.c                              |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c          |    5 
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c      |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |    2 
 drivers/pinctrl/pinctrl-at91-pio4.c                      |    8 +
 drivers/reset/core.c                                     |    3 
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                        |    9 -
 drivers/usb/host/fotg210-hcd.c                           |    3 
 drivers/usb/serial/ftdi_sio.c                            |    6 -
 drivers/usb/serial/ftdi_sio_ids.h                        |    6 -
 drivers/usb/serial/option.c                              |    5 
 fs/afs/cell.c                                            |    6 -
 fs/afs/dynroot.c                                         |   31 ++---
 fs/block_dev.c                                           |    9 +
 fs/btrfs/ioctl.c                                         |    9 +
 fs/cifs/misc.c                                           |    4 
 fs/cifs/smb2misc.c                                       |   26 +---
 fs/cifs/smb2pdu.h                                        |    2 
 kernel/trace/ring_buffer.c                               |    9 +
 net/8021q/vlan_core.c                                    |    9 +
 net/9p/protocol.c                                        |   17 ++
 net/bluetooth/hci_event.c                                |    3 
 net/core/dev.c                                           |    8 +
 net/ife/ife.c                                            |    1 
 net/mac80211/mesh_plink.c                                |   10 -
 net/rfkill/rfkill-gpio.c                                 |    8 +
 net/rose/af_rose.c                                       |   39 +++++-
 net/wireless/certs/wens.hex                              |   87 +++++++++++++++
 sound/pci/hda/patch_hdmi.c                               |    2 
 sound/pci/hda/patch_realtek.c                            |    1 
 40 files changed, 319 insertions(+), 100 deletions(-)

Alexis Lothoré (1):
      pinctrl: at91-pio4: use dedicated lock class for IRQ

Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Bin Li (1):
      ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Dan Carpenter (1):
      usb: fotg210-hcd: delete an incorrect bounds test

David Howells (3):
      afs: Fix the dynamic root's d_delete to always delete unused dentries
      afs: Fix dynamic root lookup DNS check
      afs: Fix overwriting of result of DNS query

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

Geert Uytterhoeven (1):
      reset: Fix crash when freeing non-existent optional resets

Greg Kroah-Hartman (1):
      Linux 5.4.266

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

Heiko Carstens (1):
      s390/vx: fix save/restore of fpu kernel context

Heiner Kallweit (1):
      net: warn if gso_type isn't set for a GSO SKB

Hu Haowen (1):
      net/mlx5: improve some comments

Javier Carrasco (1):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table

Johannes Berg (2):
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

Kai Vehmanen (2):
      ALSA: hda/hdmi: Add quirk to force pin connectivity on NUC10
      ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB

Kunwu Chan (1):
      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init

Liu Jian (1):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Namjae Jeon (1):
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Paulo Alcantara (2):
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smbCalcSize()

Quan Nguyen (1):
      i2c: aspeed: Handle the coalesced stop conditions with the start conditions.

Rahul Rameshbabu (1):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

Steven Rostedt (Google) (1):
      ring-buffer: Fix wake ups when buffer_percent is set to 100

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Thomas Gleixner (1):
      x86/alternatives: Sync core before enabling interrupts

Vlad Buslov (1):
      Revert "net/mlx5e: fix double free of encap_header"

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

Wei Yongjun (1):
      scsi: bnx2fc: Fix skb double free in bnx2fc_rcv()

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources


