Return-Path: <linux-kernel+bounces-17957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F1825609
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE891C23120
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67732187;
	Fri,  5 Jan 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Puo/44md"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBC321AA;
	Fri,  5 Jan 2024 14:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC52C433CA;
	Fri,  5 Jan 2024 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465889;
	bh=OHPcplZ81GT6KxTDCk+j8y4NVPp8sAm0w54kgePhJ9M=;
	h=From:To:Cc:Subject:Date:From;
	b=Puo/44mdXd2pe2xac3wIMHS6NohZuA9lIrPawJccxf7WEJg2oHRWO3U6dYrYVd69v
	 ir7il7wMrAC4DpdUfbHGfh5E82DJJBQc6ffpkI3WlNCdnqmBdS5G5p3/6Eri+Xwxbh
	 V9Jf9NlmHdonN2eNugBFlV2d2u39Gheoxco5+wLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.71
Date: Fri,  5 Jan 2024 15:42:39 +0100
Message-ID: <2024010539-litter-mutt-bdc2@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.71 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                          |    2 
 arch/arm/boot/dts/am33xx.dtsi     |    1 
 drivers/base/property.c           |   11 
 drivers/iio/imu/adis16475.c       |  117 ++--
 drivers/spi/spi-atmel.c           |   82 ++-
 drivers/spi/spi.c                 |   92 ++-
 drivers/usb/host/fotg210-hcd.c    |    3 
 fs/namei.c                        |  125 +++-
 fs/nfsd/nfsctl.c                  |    9 
 fs/nfsd/nfsd.h                    |    8 
 fs/nfsd/nfssvc.c                  |   57 --
 fs/smb/common/smb2pdu.h           |    1 
 fs/smb/server/Kconfig             |   10 
 fs/smb/server/asn1.c              |   27 
 fs/smb/server/auth.c              |   11 
 fs/smb/server/connection.c        |   74 --
 fs/smb/server/connection.h        |    2 
 fs/smb/server/ksmbd_netlink.h     |    4 
 fs/smb/server/ksmbd_work.c        |  100 +++
 fs/smb/server/ksmbd_work.h        |   36 -
 fs/smb/server/mgmt/share_config.h |   29 -
 fs/smb/server/mgmt/tree_connect.c |   53 +
 fs/smb/server/mgmt/tree_connect.h |   14 
 fs/smb/server/mgmt/user_config.h  |    1 
 fs/smb/server/mgmt/user_session.c |   38 -
 fs/smb/server/mgmt/user_session.h |    3 
 fs/smb/server/oplock.c            |  147 ++++-
 fs/smb/server/oplock.h            |    8 
 fs/smb/server/server.c            |   36 -
 fs/smb/server/smb2misc.c          |   19 
 fs/smb/server/smb2ops.c           |   19 
 fs/smb/server/smb2pdu.c           | 1033 ++++++++++++++++----------------------
 fs/smb/server/smb2pdu.h           |    3 
 fs/smb/server/smb_common.c        |   19 
 fs/smb/server/smb_common.h        |   14 
 fs/smb/server/smbacl.c            |   20 
 fs/smb/server/smbacl.h            |    2 
 fs/smb/server/transport_ipc.c     |    4 
 fs/smb/server/transport_rdma.c    |   44 +
 fs/smb/server/unicode.c           |  193 ++++---
 fs/smb/server/vfs.c               |  608 +++++++++++-----------
 fs/smb/server/vfs.h               |   52 -
 fs/smb/server/vfs_cache.c         |   63 +-
 fs/smb/server/vfs_cache.h         |   18 
 include/linux/blkdev.h            |    2 
 include/linux/export-internal.h   |    1 
 include/linux/module.h            |    9 
 include/linux/namei.h             |    7 
 include/linux/property.h          |    7 
 include/linux/spi/spi.h           |   23 
 kernel/module/kallsyms.c          |    2 
 kernel/trace/ring_buffer.c        |  140 +----
 kernel/trace/trace.c              |   20 
 kernel/trace/trace_kprobe.c       |   25 
 mm/filemap.c                      |    9 
 mm/memory-failure.c               |    8 
 mm/migrate.c                      |    9 
 net/netfilter/nf_tables_api.c     |    2 
 58 files changed, 1981 insertions(+), 1495 deletions(-)

Al Viro (1):
      fs: introduce lock_rename_child() helper

Amit Kumar Mahapatra (1):
      spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Andy Shevchenko (2):
      spi: Introduce spi_get_device_match_data() helper
      device property: Allow const parameter to dev_fwnode()

Atte Heikkilä (1):
      ksmbd: fix `force create mode' and `force directory mode'

Baokun Li (1):
      mm/filemap: avoid buffered read/write race to read inconsistent data

Charan Teja Kalla (1):
      mm: migrate high-order folios in swap cache correctly

Cheng-Han Wu (1):
      ksmbd: Remove unused field in ksmbd_user struct

Christoph Hellwig (1):
      block: renumber QUEUE_FLAG_HW_WC

Colin Ian King (1):
      ksmbd: Fix spelling mistake "excceed" -> "exceeded"

Dan Carpenter (1):
      usb: fotg210-hcd: delete an incorrect bounds test

David Disseldorp (3):
      ksmbd: set NegotiateContextCount once instead of every inc
      ksmbd: avoid duplicate negotiate ctx offset increments
      ksmbd: remove unused compression negotiate ctx packing

Dawei Li (3):
      ksmbd: Implements sess->rpc_handle_list as xarray
      ksmbd: fix typo, syncronous->synchronous
      ksmbd: Remove duplicated codes

Geert Uytterhoeven (1):
      spi: Constify spi parameters of chip select APIs

Greg Kroah-Hartman (1):
      Linux 6.1.71

Gustavo A. R. Silva (3):
      ksmbd: replace one-element arrays with flexible-array members
      ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
      ksmbd: Replace one-element array with flexible-array member

Helge Deller (1):
      linux/export: Ensure natural alignment of kcrctab array

Jeff Layton (1):
      ksmbd: use F_SETLK when unlocking a file

Jiapeng Chong (1):
      ksmbd: Fix parameter name and comment mismatch

Jiri Olsa (1):
      kallsyms: Make module_kallsyms_on_each_symbol generally available

Kangjing Huang (1):
      ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()

Louis Chauvet (1):
      spi: atmel: Fix clock issue when using devices with different polarities

Lu Hongfei (2):
      ksmbd: Change the return value of ksmbd_vfs_query_maximal_access to void
      ksmbd: Replace the ternary conditional operator with min()

Marios Makassikis (2):
      ksmbd: Fix resource leak in smb2_lock()
      ksmbd: fix recursive locking in vfs helpers

Matthew Wilcox (Oracle) (2):
      mm/memory-failure: cast index to loff_t before shifting it
      mm/memory-failure: check the mapcount of the precise page

Namjae Jeon (46):
      ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data encryption for this share
      ksmbd: delete asynchronous work from list
      ksmbd: fix racy issue from using ->d_parent and ->d_name
      ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
      ksmbd: fix uninitialized pointer read in smb2_create_link()
      ksmbd: call putname after using the last component
      ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
      ksmbd: add mnt_want_write to ksmbd vfs functions
      ksmbd: remove unused ksmbd_tree_conn_share function
      ksmbd: use kzalloc() instead of __GFP_ZERO
      ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()
      ksmbd: use kvzalloc instead of kvmalloc
      ksmbd: check if a mount point is crossed during path lookup
      ksmbd: add support for read compound
      ksmbd: fix wrong interim response on compound
      ksmbd: add missing calling smb2_set_err_rsp() on error
      ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
      ksmbd: fix passing freed memory 'aux_payload_buf'
      ksmbd: return invalid parameter error response if smb2 request is invalid
      ksmbd: check iov vector index in ksmbd_conn_write()
      ksmbd: fix race condition with fp
      ksmbd: fix race condition from parallel smb2 logoff requests
      ksmbd: fix race condition from parallel smb2 lock requests
      ksmbd: fix race condition between tree conn lookup and disconnect
      ksmbd: fix wrong error response status by using set_smb2_rsp_status()
      ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
      ksmbd: fix potential double free on smb2_read_pipe() error path
      ksmbd: reorganize ksmbd_iov_pin_rsp()
      ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
      ksmbd: add support for surrogate pair conversion
      ksmbd: no need to wait for binded connection termination at logoff
      ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
      ksmbd: fix possible deadlock in smb2_open
      ksmbd: separately allocate ci per dentry
      ksmbd: move oplock handling after unlock parent dir
      ksmbd: release interim response after sending status pending response
      ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
      ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
      ksmbd: set epoch in create context v2 lease
      ksmbd: set v2 lease capability
      ksmbd: downgrade RWH lease caching state to RH for directory
      ksmbd: send v2 lease break notification for directory
      ksmbd: lazy v2 lease break on smb2_write()
      ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
      ksmbd: fix wrong allocation size update in smb2_open()
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

NeilBrown (3):
      nfsd: separate nfsd_last_thread() from nfsd_put()
      nfsd: call nfsd_last_thread() before final nfsd_put()
      NFSD: fix possible oops when nfsd/pool_stats is closed.

Nuno Sa (1):
      iio: imu: adis16475: add spi_device_id table

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip set commit for deleted/destroyed sets

Shin'ichiro Kawasaki (2):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
      Revert "platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe"

Steve French (2):
      ksmbd: update Kconfig to note Kerberos support and fix indentation
      ksmbd: remove experimental warning

Steven Rostedt (Google) (4):
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
      ring-buffer: Fix slowpath of interrupted event

Tom Rix (1):
      ksmbd: remove unused is_char_allowed function

Tony Lindgren (1):
      ARM: dts: Fix occasional boot hang for am3 usb

Tudor Ambarus (1):
      spi: Reintroduce spi_set_cs_timing()

Wang Ming (1):
      ksmbd: Fix unsigned expression compared with zero

Yang Li (1):
      ksmbd: Fix one kernel-doc comment

Yang Yingliang (1):
      ksmbd: switch to use kmemdup_nul() helper

Zongmin Zhou (1):
      ksmbd: prevent memory leak on error return

ye xingchen (1):
      ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs


