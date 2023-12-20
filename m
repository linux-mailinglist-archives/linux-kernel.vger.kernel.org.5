Return-Path: <linux-kernel+bounces-7256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2D81A3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA1B20AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421114A981;
	Wed, 20 Dec 2023 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQAuhgMY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAB495DA;
	Wed, 20 Dec 2023 16:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2592C433C8;
	Wed, 20 Dec 2023 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088512;
	bh=E+SJjPiQiAC7iq6cZaVCrRlJyU86ZtRDHw+rEkItXE8=;
	h=From:To:Cc:Subject:Date:From;
	b=xQAuhgMYqv+H2Y7LlY8bLfbT5C41XowRSNpMe0YDhVqzk8iATnWHHfkphREOZrAva
	 hDVvxyxYrQ7SGFiAApuH5mshFSq3RR1B4It+L/zIMwj6Nf5qalLREfM/stqu0sssvW
	 FslWlxBJ13Rpu5Q7l3gpXzUWDw8h8aWkX+0K0ntM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.334
Date: Wed, 20 Dec 2023 17:08:17 +0100
Message-ID: <2023122017-twirl-specks-ac1f@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.14.334 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |    9 ++-
 block/blk-throttle.c                           |    2 
 drivers/atm/solos-pci.c                        |    8 +--
 drivers/hid/hid-asus.c                         |   25 ++++++++-
 drivers/hid/hid-multitouch.c                   |    5 +
 drivers/md/bcache/btree.c                      |    7 ++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c      |    1 
 drivers/net/ethernet/qualcomm/qca_debug.c      |   17 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c        |   20 +++++++
 drivers/net/team/team.c                        |    4 +
 drivers/net/usb/qmi_wwan.c                     |    1 
 drivers/platform/x86/intel_telemetry_core.c    |    4 -
 fs/ext4/mballoc.c                              |    4 +
 include/asm-generic/qspinlock.h                |    2 
 include/linux/cred.h                           |    6 +-
 kernel/cred.c                                  |   66 ++++++++++++-------------
 kernel/trace/ring_buffer.c                     |    2 
 net/appletalk/ddp.c                            |    9 +--
 net/atm/ioctl.c                                |    7 +-
 net/ipv4/tcp_output.c                          |    6 ++
 net/rose/af_rose.c                             |    4 +
 net/vmw_vsock/virtio_transport_common.c        |    2 
 scripts/sign-file.c                            |   12 ++--
 24 files changed, 151 insertions(+), 74 deletions(-)

Andy Shevchenko (1):
      platform/x86: intel_telemetry: Fix kernel doc descriptions

Aoba K (1):
      HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Baokun Li (1):
      ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Chengfeng Ye (2):
      atm: solos-pci: Fix potential deadlock on &cli_queue_lock
      atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Coly Li (1):
      bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()

Denis Benato (2):
      HID: hid-asus: reset the backlight brightness level on resume
      HID: hid-asus: add const to read-only outgoing usb buffer

Dinghao Liu (1):
      qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Dong Chenchen (1):
      net: Remove acked SYN flag from packet in the transmit queue correctly

Florent Revest (1):
      team: Fix use-after-free when an option instance allocation fails

Greg Kroah-Hartman (1):
      Linux 4.14.334

Hyunwoo Kim (3):
      atm: Fix Use-After-Free in do_vcc_ioctl
      net/rose: Fix Use-After-Free in rose_ioctl
      appletalk: Fix Use-After-Free in atalk_ioctl

Jens Axboe (1):
      cred: switch to using atomic_long_t

Lech Perczak (1):
      net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Linus Torvalds (1):
      asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Ming Lei (1):
      blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

Naveen N Rao (2):
      powerpc/ftrace: Create a dummy stackframe to fix stack unwind
      powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Nikolay Kuratov (1):
      vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Stefan Wahren (3):
      qca_debug: Prevent crash on TX ring changes
      qca_debug: Fix ethtool -G iface tx behavior
      qca_spi: Fix reset behavior

Steven Rostedt (Google) (1):
      ring-buffer: Fix memory leak of free page

Yusong Gao (1):
      sign-file: Fix incorrect return values check


