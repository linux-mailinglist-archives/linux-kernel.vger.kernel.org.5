Return-Path: <linux-kernel+bounces-106495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1587EF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747821F23531
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49157872;
	Mon, 18 Mar 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hga6v1TA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FE57862
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784953; cv=none; b=LTV+KnnrmEZPJFhoc1c70QabTuhySsGoDPm+jMj4EN0iJbD93jm/HgIUybAUTwJyTfTZBTqLO1m21jjA2R5ve3BbcIZdCFmz6QNxVcXcMgg9cHee0LXLIApJT49f9OIP7PZ3h7OmHTKIVkVX5MxKi6DUVsHzM0o/wFa2SKPq8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784953; c=relaxed/simple;
	bh=+JAH1mBsMESLs3MwMiRGxq6NxSHuEAFGRULjvG0Mhr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JVcplCBIL+I1QdRrpr+SMWdzwRuzz7Og+bq0l+jqUSGcySvFZeBFM2IX8roiToiYTFrgG9V3b3x8lmVCxlhtli8PCmit0q8whGqy5/rESHy3iQCHlaiUUoVXdFJdYN+CSpkSxZTRZcatyknSBz72p1Y/ksfocg3jCD4nrjdzm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hga6v1TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360AEC433F1;
	Mon, 18 Mar 2024 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710784953;
	bh=+JAH1mBsMESLs3MwMiRGxq6NxSHuEAFGRULjvG0Mhr4=;
	h=Date:From:To:Cc:Subject:From;
	b=hga6v1TALUxc8qjnxy9FOWozsLh8+6tDVZu7/Wm5O2OVFN8akL4GBoRvkx/yPe26d
	 4giQ5RCm7AVJYxnXyJYsh5husS+FkG+8A8DCDNVKhFqPjfjX0ecVX3P19urSnZtnho
	 xYiR6POW3L2h2dGsU9WV8i7s71JZLG/O9vZLnLx+9oO7PI5/oB1zSJ7hRrjOZ7aFPO
	 U11/CFv220tl/UXDXci3N9z5BUxc3bfjeB9ujEFYBE59p/nFCaoO4JDdZP2b3yYC9p
	 NU89s/o/Ugg5i0hpLoDx6hu5bKG4EA+D0Jgr81R3d+g5MAXGqIsfBTKgsXLE030RHV
	 gte8pdr1DPM2Q==
Date: Mon, 18 Mar 2024 11:02:31 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.9-rc1
Message-ID: <ZfiBt0gRe_Elp7hE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.9-rc1

for you to fetch changes up to eb70d5a6c932d9d23f4bb3e7b83782c21ac4b064:

  f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault (2024-03-14 09:14:53 -0700)

----------------------------------------------------------------
f2fs update for 6.9-rc1

In this round, there are a number of updates on mainly two areas: Zoned block
device support and Per-file compression. For example, we've found several issues
to support Zoned block device especially having large sections regarding to GC
and file pinning used for Android devices. In compression side, we've fixed many
corner race conditions that had broken the design assumption.

Enhancement:
 - Support file pinning for Zoned block device having large section
 - Enhance the data recovery after sudden power cut on Zoned block device
 - Add more error injection cases to easily detect the kernel panics
 - add a proc entry show the entire disk layout
 - Improve various error paths paniced by BUG_ON in block allocation and GC
 - support SEEK_DATA and SEEK_HOLE for compression files

Bug fix:
 - fix to avoid use-after-free issue in f2fs_filemap_fault
 - fix some race conditions to break the atomic write design assumption
 - fix to truncate meta inode pages forcely
 - resolve various per-file compression issues wrt the space management and
   compression policies
 - fix some swap-related bugs

In addition, we removed deprecated codes such as io_bits and heap_allocation,
and also fixed minor error handling routines with neat debugging messages.

----------------------------------------------------------------
Chao Yu (29):
      f2fs: compress: fix to guarantee persisting compressed blocks by CP
      f2fs: compress: fix to cover normal cluster write with cp_rwsem
      f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
      f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
      f2fs: introduce FAULT_BLKADDR_CONSISTENCE
      f2fs: zone: fix to wait completion of last bio in zone correctly
      f2fs: support printk_ratelimited() in f2fs_printk()
      f2fs: use f2fs_err_ratelimited() to avoid redundant logs
      f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
      f2fs: fix to avoid potential panic during recovery
      f2fs: fix to create selinux label during whiteout initialization
      f2fs: compress: fix to check zstd compress level correctly in mount option
      f2fs: introduce get_available_block_count() for cleanup
      f2fs: delete f2fs_get_new_segment() declaration
      f2fs: fix to handle segment allocation failure correctly
      f2fs: compress: fix to check compress flag w/ .i_sem lock
      f2fs: introduce FAULT_NO_SEGMENT
      f2fs: fix to use correct segment type in f2fs_allocate_data_block()
      f2fs: fix to check return value in f2fs_insert_range()
      f2fs: ro: compress: fix to avoid caching unaligned extent
      f2fs: ro: don't start discard thread for readonly image
      f2fs: fix blkofs_end correctly in f2fs_migrate_blocks()
      f2fs: relocate f2fs_precache_extents() in f2fs_swap_activate()
      f2fs: clean up new_curseg()
      f2fs: fix to reset fields for unloaded curseg
      f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup
      f2fs: fix to truncate meta inode pages forcely
      f2fs: zone: fix to remove pow2 check condition for zoned block device
      f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault

Daeho Jeong (4):
      f2fs: separate f2fs_gc_range() to use GC for a range
      f2fs: support SEEK_DATA and SEEK_HOLE for compression files
      f2fs: support file pinning for zoned devices
      f2fs: prevent atomic write on pinned file

HuangXiaojia (1):
      f2fs: Use folio in f2fs_read_merkle_tree_page

Jaegeuk Kim (10):
      f2fs: remove unnecessary f2fs_put_page in f2fs_rename
      f2fs: deprecate io_bits
      f2fs: use BLKS_PER_SEG, BLKS_PER_SEC, and SEGS_PER_SEC
      f2fs: kill heap-based allocation
      f2fs: prevent an f2fs_gc loop during disable_checkpoint
      f2fs: check number of blocks in a current section
      f2fs: fix write pointers all the time
      f2fs: print zone status in string and some log
      f2fs: allow to mount if cap is 100
      f2fs: add a proc entry show disk layout

Jeffrey Hugo (1):
      f2fs: doc: Fix bouncing email address for Sahitya Tummala

Sheng Yong (1):
      f2fs: compress: fix to check unreleased compressed cluster

Sunmin Jeong (2):
      f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
      f2fs: truncate page cache before clearing flags when aborting atomic write

Wenjie Qi (1):
      f2fs: fix NULL pointer dereference in f2fs_submit_page_write()

Wu Bo (1):
      f2fs: check free sections before disable checkpoint

Xiuhong Wang (2):
      f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
      f2fs: compress: fix reserve_cblocks counting error when out of space

Zhiguo Niu (8):
      f2fs: compress: remove some redundant codes in f2fs_cache_compressed_page
      f2fs: use IS_INODE replace IS_DNODE in f2fs_flush_inline_data
      f2fs: stop checkpoint when get a out-of-bounds segment
      f2fs: fix to do sanity check in update_sit_entry
      f2fs: fix to check return value __allocate_new_segment
      f2fs: fix to check return value of f2fs_gc_range
      f2fs: unify the error handling of f2fs_is_valid_blkaddr
      f2fs: fix to handle error paths of {new,change}_curseg()

 Documentation/ABI/testing/sysfs-fs-f2fs |  52 ++--
 Documentation/filesystems/f2fs.rst      |  54 ++--
 fs/f2fs/checkpoint.c                    |  74 +++---
 fs/f2fs/compress.c                      |  55 ++--
 fs/f2fs/data.c                          | 191 +++++---------
 fs/f2fs/debug.c                         |  11 +-
 fs/f2fs/dir.c                           |  10 +-
 fs/f2fs/extent_cache.c                  |   5 +-
 fs/f2fs/f2fs.h                          | 241 ++++++++++-------
 fs/f2fs/file.c                          | 171 +++++++-----
 fs/f2fs/gc.c                            | 129 +++++-----
 fs/f2fs/gc.h                            |   4 +-
 fs/f2fs/namei.c                         |  36 +--
 fs/f2fs/node.c                          |  26 +-
 fs/f2fs/node.h                          |   4 +-
 fs/f2fs/recovery.c                      |  56 ++--
 fs/f2fs/segment.c                       | 444 ++++++++++++++++++++------------
 fs/f2fs/segment.h                       |  90 ++++---
 fs/f2fs/super.c                         | 208 +++++----------
 fs/f2fs/sysfs.c                         |  52 +++-
 fs/f2fs/verity.c                        |  16 +-
 include/linux/f2fs_fs.h                 |   8 +-
 22 files changed, 1054 insertions(+), 883 deletions(-)

