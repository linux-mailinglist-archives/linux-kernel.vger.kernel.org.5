Return-Path: <linux-kernel+bounces-17959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE482560E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1A2B23B61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EC34545;
	Fri,  5 Jan 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VP2SxqrZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A328C6;
	Fri,  5 Jan 2024 14:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D3C433C9;
	Fri,  5 Jan 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465895;
	bh=ZVFyWSVPsZB6p53THvMYbfxJIys8W6RRlzv+QruBZaA=;
	h=From:To:Cc:Subject:Date:From;
	b=VP2SxqrZp8AFDuLaSNyiE1/i16+jmk2fjSvo/c0eK8tUgtEOHXPvDxVNlWDOYzQ4Q
	 CMX9B7x5yWeDYZcI46MbiTuNbugo371k+3+mBrqmIkUM/dkC0OkwmcSSIRKhB3czDC
	 d+VyClgk5tAxfOzHyqHBBhaPhdsuivP6IoLPoKsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.10
Date: Fri,  5 Jan 2024 15:42:47 +0100
Message-ID: <2024010547-tanning-ogle-0916@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.10 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 arch/powerpc/Kconfig                      |    4 
 arch/riscv/Kconfig                        |    4 
 arch/s390/Kconfig                         |    4 
 arch/x86/Kconfig                          |    4 
 drivers/nvme/host/fc.c                    |   21 ---
 drivers/platform/x86/intel/pmc/adl.c      |    9 -
 drivers/platform/x86/intel/pmc/cnp.c      |   26 +++-
 drivers/platform/x86/intel/pmc/core.c     |   12 +
 drivers/platform/x86/intel/pmc/core.h     |    7 -
 drivers/platform/x86/intel/pmc/mtl.c      |    9 -
 drivers/platform/x86/intel/pmc/tgl.c      |    9 -
 drivers/virtio/virtio_ring.c              |    6 
 fs/libfs.c                                |   41 ++++--
 fs/smb/client/file.c                      |   18 +-
 fs/smb/client/fscache.h                   |    6 
 fs/smb/client/inode.c                     |   17 +-
 fs/smb/client/smb2ops.c                   |    6 
 fs/smb/common/smb2pdu.h                   |    1 
 fs/smb/server/connection.c                |   16 --
 fs/smb/server/ksmbd_work.c                |   51 ++++----
 fs/smb/server/mgmt/user_config.h          |    1 
 fs/smb/server/oplock.c                    |  118 ++++++++++++++++--
 fs/smb/server/oplock.h                    |    8 +
 fs/smb/server/smb2misc.c                  |   15 +-
 fs/smb/server/smb2ops.c                   |    9 -
 fs/smb/server/smb2pdu.c                   |  156 +++++++++++++------------
 fs/smb/server/transport_rdma.c            |   40 ++++--
 fs/smb/server/unicode.c                   |  187 ++++++++++++++++++++++--------
 fs/smb/server/vfs.c                       |   14 +-
 fs/smb/server/vfs_cache.c                 |   30 ++--
 fs/smb/server/vfs_cache.h                 |    9 -
 include/linux/blkdev.h                    |    2 
 include/linux/export-internal.h           |    6 
 include/linux/fs.h                        |   85 +++++++++++--
 kernel/Kconfig.kexec                      |    2 
 kernel/trace/ftrace.c                     |  100 +++++++---------
 kernel/trace/ring_buffer.c                |   12 +
 kernel/trace/trace.c                      |   20 ++-
 lib/maple_tree.c                          |   11 +
 mm/filemap.c                              |    9 +
 mm/memory-failure.c                       |    8 -
 mm/migrate.c                              |    9 +
 net/mptcp/protocol.c                      |   27 +++-
 net/mptcp/protocol.h                      |   63 ++++++++--
 net/mptcp/sockopt.c                       |    5 
 net/mptcp/subflow.c                       |   29 ++--
 net/netfilter/nf_tables_api.c             |    2 
 net/wireless/core.h                       |    1 
 net/wireless/nl80211.c                    |   56 +++++---
 tools/testing/radix-tree/maple.c          |    2 
 tools/testing/selftests/mm/memfd_secret.c |    3 
 52 files changed, 884 insertions(+), 428 deletions(-)

Arnd Bergmann (2):
      kexec: fix KEXEC_FILE dependencies
      kexec: select CRYPTO from KEXEC_FILE instead of depending on it

Baokun Li (1):
      mm/filemap: avoid buffered read/write race to read inconsistent data

Charan Teja Kalla (1):
      mm: migrate high-order folios in swap cache correctly

Cheng-Han Wu (1):
      ksmbd: Remove unused field in ksmbd_user struct

Christoph Hellwig (1):
      block: renumber QUEUE_FLAG_HW_WC

David E. Box (3):
      platform/x86/intel/pmc: Add suspend callback
      platform/x86/intel/pmc: Allow reenabling LTRs
      platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback

Greg Kroah-Hartman (1):
      Linux 6.6.10

Helge Deller (2):
      linux/export: Fix alignment for 64-bit ksymtab entries
      linux/export: Ensure natural alignment of kcrctab array

Jeff Layton (2):
      fs: new accessor methods for atime and mtime
      client: convert to new timestamp accessors

Johannes Berg (1):
      wifi: cfg80211: fix CQM for non-range use

Kangjing Huang (1):
      ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()

Keith Busch (1):
      Revert "nvme-fc: fix race between error recovery and creating association"

Léo Lam (1):
      wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)

Matthew Wilcox (Oracle) (2):
      mm/memory-failure: cast index to loff_t before shifting it
      mm/memory-failure: check the mapcount of the precise page

Muhammad Usama Anjum (1):
      selftests: secretmem: floor the memory size to the multiple of page_size

Namjae Jeon (17):
      ksmbd: reorganize ksmbd_iov_pin_rsp()
      ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
      ksmbd: add support for surrogate pair conversion
      ksmbd: no need to wait for binded connection termination at logoff
      ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
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
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip set commit for deleted/destroyed sets

Paolo Abeni (3):
      mptcp: refactor sndbuf auto-tuning
      mptcp: fix possible NULL pointer dereference on close
      mptcp: fix inconsistent state on fastopen race

Shin'ichiro Kawasaki (2):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
      Revert "platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe"

Sidhartha Kumar (1):
      maple_tree: do not preallocate nodes for slot stores

Steven Rostedt (Google) (3):
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      ftrace: Fix modification of direct_function hash while in use
      tracing: Fix blocked reader of snapshot buffer

Xuan Zhuo (1):
      virtio_ring: fix syncs DMA memory with different direction

Zizhi Wo (1):
      fs: cifs: Fix atime update check

Zongmin Zhou (1):
      ksmbd: prevent memory leak on error return


