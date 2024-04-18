Return-Path: <linux-kernel+bounces-150806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE18AA4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F15281117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B75194C9C;
	Thu, 18 Apr 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLvUDy8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220E181D1E;
	Thu, 18 Apr 2024 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475909; cv=none; b=sHNrrdGpD+cncdnMzxObFCd8UI94c6s46m4po3LClRFTA0zpnZ1cN6ZAHBaZ1kCXtKd3myx84UozCRlEz21AvAtJUeYistqLOu8NAjYWZoFF6PxnP8OLUc15uD+zcq25KEVZN3A4KilUd3pYvq+PEs6DwQXd/oIHD9Mpes0DdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475909; c=relaxed/simple;
	bh=Jq9UiSYmoP/hUb1oc1xt0fa0f85qV0bqJGIW/rrDDSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXrVeaULugnTuxt9wnNEnfYQ/arlzscQe2K1YeOax3GVbP/6arMpZovo3u+uegNbKdFARi7qOzgorv/TQgwx2Yy+znO93nH57HJR5Z8OqQwJYsM3N6ZZXElgeiMEpM7jVpHCOJ0DWrbsuVZ8Iop4+hRghARmDjYj5w8iXzh9ON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLvUDy8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB984C113CC;
	Thu, 18 Apr 2024 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713475909;
	bh=Jq9UiSYmoP/hUb1oc1xt0fa0f85qV0bqJGIW/rrDDSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLvUDy8jnDljx2fyG/dk+gL5lbcECNpf+rrDZXTmf13607jjGmZmuC7MaFbWzrDaG
	 KwLGnubCKOtWpadIQ+LKRJu0p2S5c2h7M7z4hshQCXWCXlQNqnFI7KhPaKOgevkGNl
	 70UMvfFDu6vTblu0BRBLoZyBc8B/DfuCW4rBfPb2Oj3cEPnp/R1Sj1kQp+coYxQERZ
	 tUJOl8tKD7vV8SDXObWnTjAwGAIPy9DzpE/IlIm62i8b4NJUVZDVPujOE03vmnWtvY
	 yd+aUsYMHkeV9pmY5UXGlbP9d2037dBRZ0Lvh4wA2gWNX/FmX8dcABEEF60Yj7baJh
	 LeTgstZIeGAwQ==
Date: Thu, 18 Apr 2024 18:31:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH][RFT] Re: linux-next: build failure after merge of the perf
 tree
Message-ID: <ZiGRQZQGl0REHm9A@x1>
References: <20240402094116.79751030@canb.auug.org.au>
 <ZhlRn0TUkcDaAZT5@x1>
 <20240413124340.4d48c6d8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413124340.4d48c6d8@canb.auug.org.au>

On Sat, Apr 13, 2024 at 12:43:40PM +1000, Stephen Rothwell wrote:
> Hi Arnaldo,
> 
> On Fri, 12 Apr 2024 12:22:07 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Tue, Apr 02, 2024 at 09:41:16AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the perf tree, today's linux-next build (native i.e. ppc64le
> > > perf) failed like this:
> > > 
> > > make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.  
> > 
> > How is this built? Using O=/home/sfr/next/perf?
> 
> Yes.  The actual command line is:
> 
> make -C tools/perf -f Makefile.perf -s -O -j60 O=/home/sfr/next/perf NO_BPF_SKEL=1
> 
> The source directory is /home/sfr/next/next.  This is a PowerPC 64 little endian
> build (on a PowerPC 64 little endian host).
> 
> OK, I just tested on my x86_64 laptop:
> (I started with a clone of Linus' current tree)

Ok, I did that sequence:

1. checkout torvalds/master
2. use the make command line above
3. git merge perf-tools-next
4. use the make command line above

And reproduced the problem, find below a patch that reverts the patch
that removes tools/include/uapi/linux/stat.h, with it applied in the
sequence above right after the merge of perf-tools-next it seems to
work, i.e. it builds without problems.

Can you please test this so that I can get it into perf-tools-next?

Thanks again for the report!

- Arnaldo

From cec45ef1ad23059aac607d0db959c73c2198bc2a Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 18 Apr 2024 18:15:33 -0300
Subject: [PATCH 1/1] Revert "tools headers: Remove almost unused copy of
 uapi/stat.h, add few conditional defines"

This reverts commit a672af9139a843eb7a48fd7846bb6df8f81b5f86.

By now it is not used for building tools/perf, but Stephen Rothwell
reported that when building on a O= directory that had been built with
torvalds/master and this perf build command line:

  $ make -C tools/perf -f Makefile.perf -s -O -j60 O=/home/sfr/next/perf NO_BPF_SKEL=1

If we then merge perf-tools-next, as he did for linux-next, then we end
up with a build failure for libbpf:

    PERF_VERSION = 6.9.rc3.g42c4635c8dee
  make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.
  make[2]: *** [Makefile:157: /home/sfr/next/perf/libbpf/staticobjs/libbpf-in.o] Error 2
  make[1]: *** [Makefile.perf:892: /home/sfr/next/perf/libbpf/libbpf.a] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile.perf:264: sub-make] Error 2

This needs to be further investigated to figure out how to check if
libbpf really needs something that is in that
tools/include/uapi/linux/stat.h file and if not to remove that file in a
way that we don't break the build in any situation, to avoid requiring
doing a 'make clean'.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20240413124340.4d48c6d8@canb.auug.org.au
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 195 ++++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh     |   1 +
 2 files changed, 196 insertions(+)
 create mode 100644 tools/include/uapi/linux/stat.h

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
new file mode 100644
index 0000000000000000..2f2ee82d55175d05
--- /dev/null
+++ b/tools/include/uapi/linux/stat.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STAT_H
+#define _UAPI_LINUX_STAT_H
+
+#include <linux/types.h>
+
+#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+
+#define S_IFMT  00170000
+#define S_IFSOCK 0140000
+#define S_IFLNK	 0120000
+#define S_IFREG  0100000
+#define S_IFBLK  0060000
+#define S_IFDIR  0040000
+#define S_IFCHR  0020000
+#define S_IFIFO  0010000
+#define S_ISUID  0004000
+#define S_ISGID  0002000
+#define S_ISVTX  0001000
+
+#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
+#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
+#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
+#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
+#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
+#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
+#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
+
+#define S_IRWXU 00700
+#define S_IRUSR 00400
+#define S_IWUSR 00200
+#define S_IXUSR 00100
+
+#define S_IRWXG 00070
+#define S_IRGRP 00040
+#define S_IWGRP 00020
+#define S_IXGRP 00010
+
+#define S_IRWXO 00007
+#define S_IROTH 00004
+#define S_IWOTH 00002
+#define S_IXOTH 00001
+
+#endif
+
+/*
+ * Timestamp structure for the timestamps in struct statx.
+ *
+ * tv_sec holds the number of seconds before (negative) or after (positive)
+ * 00:00:00 1st January 1970 UTC.
+ *
+ * tv_nsec holds a number of nanoseconds (0..999,999,999) after the tv_sec time.
+ *
+ * __reserved is held in case we need a yet finer resolution.
+ */
+struct statx_timestamp {
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
+};
+
+/*
+ * Structures for the extended file attribute retrieval system call
+ * (statx()).
+ *
+ * The caller passes a mask of what they're specifically interested in as a
+ * parameter to statx().  What statx() actually got will be indicated in
+ * st_mask upon return.
+ *
+ * For each bit in the mask argument:
+ *
+ * - if the datum is not supported:
+ *
+ *   - the bit will be cleared, and
+ *
+ *   - the datum will be set to an appropriate fabricated value if one is
+ *     available (eg. CIFS can take a default uid and gid), otherwise
+ *
+ *   - the field will be cleared;
+ *
+ * - otherwise, if explicitly requested:
+ *
+ *   - the datum will be synchronised to the server if AT_STATX_FORCE_SYNC is
+ *     set or if the datum is considered out of date, and
+ *
+ *   - the field will be filled in and the bit will be set;
+ *
+ * - otherwise, if not requested, but available in approximate form without any
+ *   effort, it will be filled in anyway, and the bit will be set upon return
+ *   (it might not be up to date, however, and no attempt will be made to
+ *   synchronise the internal state first);
+ *
+ * - otherwise the field and the bit will be cleared before returning.
+ *
+ * Items in STATX_BASIC_STATS may be marked unavailable on return, but they
+ * will have values installed for compatibility purposes so that stat() and
+ * co. can be emulated in userspace.
+ */
+struct statx {
+	/* 0x00 */
+	__u32	stx_mask;	/* What results were written [uncond] */
+	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
+	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* 0x10 */
+	__u32	stx_nlink;	/* Number of hard links */
+	__u32	stx_uid;	/* User ID of owner */
+	__u32	stx_gid;	/* Group ID of owner */
+	__u16	stx_mode;	/* File mode */
+	__u16	__spare0[1];
+	/* 0x20 */
+	__u64	stx_ino;	/* Inode number */
+	__u64	stx_size;	/* File size */
+	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
+	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* 0x40 */
+	struct statx_timestamp	stx_atime;	/* Last access time */
+	struct statx_timestamp	stx_btime;	/* File creation time */
+	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
+	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* 0x80 */
+	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_minor;
+	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+	__u32	stx_dev_minor;
+	/* 0x90 */
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	/* 0xa0 */
+	__u64	__spare3[12];	/* Spare space for future expansion */
+	/* 0x100 */
+};
+
+/*
+ * Flags to be stx_mask
+ *
+ * Query request/result mask for statx() and struct statx::stx_mask.
+ *
+ * These bits should be set in the mask argument of statx() to request
+ * particular items when calling statx().
+ */
+#define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
+#define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
+#define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
+#define STATX_UID		0x00000008U	/* Want/got stx_uid */
+#define STATX_GID		0x00000010U	/* Want/got stx_gid */
+#define STATX_ATIME		0x00000020U	/* Want/got stx_atime */
+#define STATX_MTIME		0x00000040U	/* Want/got stx_mtime */
+#define STATX_CTIME		0x00000080U	/* Want/got stx_ctime */
+#define STATX_INO		0x00000100U	/* Want/got stx_ino */
+#define STATX_SIZE		0x00000200U	/* Want/got stx_size */
+#define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
+#define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
+#define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+
+#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
+
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
+/*
+ * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
+ *
+ * These give information about the features or the state of a file that might
+ * be of use to ordinary userspace programs such as GUIs or ls rather than
+ * specialised tools.
+ *
+ * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
+ * semantically.  Where possible, the numerical value is picked to correspond
+ * also.  Note that the DAX attribute indicates that the file is in the CPU
+ * direct access state.  It does not correspond to the per-inode flag that
+ * some filesystems support.
+ *
+ */
+#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
+#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
+#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
+#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
+#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
+#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
+#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
+#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+
+
+#endif /* _UAPI_LINUX_STAT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 95a3a404bc6fddde..9c84fd0490707452 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -16,6 +16,7 @@ FILES=(
   "include/uapi/linux/in.h"
   "include/uapi/linux/perf_event.h"
   "include/uapi/linux/seccomp.h"
+  "include/uapi/linux/stat.h"
   "include/linux/bits.h"
   "include/vdso/bits.h"
   "include/linux/const.h"
-- 
2.44.0


