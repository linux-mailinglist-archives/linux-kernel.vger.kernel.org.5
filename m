Return-Path: <linux-kernel+bounces-104914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5448E87D59F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109E92866FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D65EE74;
	Fri, 15 Mar 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+k8NQe7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19745EE60;
	Fri, 15 Mar 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535732; cv=none; b=FBpEkWinPF1xw3QTV1enFgZnyJmGYvu7kXCmhb6S8P/ltScXDYrr4fy3CT3Dyavsyla9yEl9ejrXORImw+4nPeqKrh9cv5xeKFV7LFt3+IeXo45p6fNrHW3K2QBEV6QGTKYkj7okcF3th5zDTVYqn6TPFPbhIKLYAa3zgRTOT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535732; c=relaxed/simple;
	bh=a5dsjq2Egj8y6oU68ygPX+LM9s+jPGmdE+pbm18Z6d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU4S35+K0uPeoI4ADiRD3+z8vxg0UTd3lmoiFNG1MYcHl2cWNRfLKClHh4i7zoAtZ1E5c9WXHOsvR8UYZj/VhkAZC9EekFUp6Oabs/zAQtkHAwB81LH9i+5MVjMhcVQJuNXnS2Q7JyO+lRunl0MxZnbqwUATP7kYKcHeSY0w0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+k8NQe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA72C433A6;
	Fri, 15 Mar 2024 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535732;
	bh=a5dsjq2Egj8y6oU68ygPX+LM9s+jPGmdE+pbm18Z6d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+k8NQe7Md/7eX4UdFtIvdxk6i0ydrAM4qHLLvr4OEyajZ/Np3wm+PZ16roC0deXA
	 rbv+6PmXlE4eJMO8rTjBG6MljajWqeLQiayu19CU7tQRaiRZ5MQCVgQBdeQyxeVK64
	 VzXB38EIT6myV4ZSY5U6rVn9zAUG7XB6rzHlNLk7NlpvIWycf8aoM9RzPXQ1jytwLj
	 cPdapv1l/swfNdnN7VNQbTJNJfQZpGh6Az8W64hv+NKDMwhZ8pC2FOZJhWTFoxPXTC
	 IQGadwt0t0fN9iARx88z/9GE+cl5/KSAmrs2ssoD46CHTm9KTfq8sIYo/dMC3J82M6
	 WObyAP4BfJ1dA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/5] tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and asm/fcntl.h
Date: Fri, 15 Mar 2024 17:48:34 -0300
Message-ID: <20240315204835.748716-5-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315204835.748716-1-acme@kernel.org>
References: <20240315204835.748716-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These were used to build perf to provide defines not available in older
distros, but this was back in 2017, nowadays all the distros that are
supported and I have build containers for work using just the system
headers, so ditch them.

Some of these older distros may not have things that are used in 'perf
trace', but then they also don't have libtraceevent packages, so don't
build 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/fcntl.h | 221 -------------------------
 tools/include/uapi/linux/fcntl.h       | 123 --------------
 tools/include/uapi/linux/openat2.h     |  43 -----
 tools/perf/check-headers.sh            |   2 -
 4 files changed, 389 deletions(-)
 delete mode 100644 tools/include/uapi/asm-generic/fcntl.h
 delete mode 100644 tools/include/uapi/linux/fcntl.h
 delete mode 100644 tools/include/uapi/linux/openat2.h

diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
deleted file mode 100644
index 1c7a0f6632c09e33..0000000000000000
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ /dev/null
@@ -1,221 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_GENERIC_FCNTL_H
-#define _ASM_GENERIC_FCNTL_H
-
-#include <linux/types.h>
-
-/*
- * FMODE_EXEC is 0x20
- * FMODE_NONOTIFY is 0x4000000
- * These cannot be used by userspace O_* until internal and external open
- * flags are split.
- * -Eric Paris
- */
-
-/*
- * When introducing new O_* bits, please check its uniqueness in fcntl_init().
- */
-
-#define O_ACCMODE	00000003
-#define O_RDONLY	00000000
-#define O_WRONLY	00000001
-#define O_RDWR		00000002
-#ifndef O_CREAT
-#define O_CREAT		00000100	/* not fcntl */
-#endif
-#ifndef O_EXCL
-#define O_EXCL		00000200	/* not fcntl */
-#endif
-#ifndef O_NOCTTY
-#define O_NOCTTY	00000400	/* not fcntl */
-#endif
-#ifndef O_TRUNC
-#define O_TRUNC		00001000	/* not fcntl */
-#endif
-#ifndef O_APPEND
-#define O_APPEND	00002000
-#endif
-#ifndef O_NONBLOCK
-#define O_NONBLOCK	00004000
-#endif
-#ifndef O_DSYNC
-#define O_DSYNC		00010000	/* used to be O_SYNC, see below */
-#endif
-#ifndef FASYNC
-#define FASYNC		00020000	/* fcntl, for BSD compatibility */
-#endif
-#ifndef O_DIRECT
-#define O_DIRECT	00040000	/* direct disk access hint */
-#endif
-#ifndef O_LARGEFILE
-#define O_LARGEFILE	00100000
-#endif
-#ifndef O_DIRECTORY
-#define O_DIRECTORY	00200000	/* must be a directory */
-#endif
-#ifndef O_NOFOLLOW
-#define O_NOFOLLOW	00400000	/* don't follow links */
-#endif
-#ifndef O_NOATIME
-#define O_NOATIME	01000000
-#endif
-#ifndef O_CLOEXEC
-#define O_CLOEXEC	02000000	/* set close_on_exec */
-#endif
-
-/*
- * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
- * the O_SYNC flag.  We continue to use the existing numerical value
- * for O_DSYNC semantics now, but using the correct symbolic name for it.
- * This new value is used to request true Posix O_SYNC semantics.  It is
- * defined in this strange way to make sure applications compiled against
- * new headers get at least O_DSYNC semantics on older kernels.
- *
- * This has the nice side-effect that we can simply test for O_DSYNC
- * wherever we do not care if O_DSYNC or O_SYNC is used.
- *
- * Note: __O_SYNC must never be used directly.
- */
-#ifndef O_SYNC
-#define __O_SYNC	04000000
-#define O_SYNC		(__O_SYNC|O_DSYNC)
-#endif
-
-#ifndef O_PATH
-#define O_PATH		010000000
-#endif
-
-#ifndef __O_TMPFILE
-#define __O_TMPFILE	020000000
-#endif
-
-/* a horrid kludge trying to make sure that this will fail on old kernels */
-#define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-
-#ifndef O_NDELAY
-#define O_NDELAY	O_NONBLOCK
-#endif
-
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
-#ifndef F_GETLK
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-#endif
-#ifndef F_SETOWN
-#define F_SETOWN	8	/* for sockets. */
-#define F_GETOWN	9	/* for sockets. */
-#endif
-#ifndef F_SETSIG
-#define F_SETSIG	10	/* for sockets. */
-#define F_GETSIG	11	/* for sockets. */
-#endif
-
-#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
-#ifndef F_GETLK64
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-#endif
-#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
-
-#ifndef F_SETOWN_EX
-#define F_SETOWN_EX	15
-#define F_GETOWN_EX	16
-#endif
-
-#ifndef F_GETOWNER_UIDS
-#define F_GETOWNER_UIDS	17
-#endif
-
-/*
- * Open File Description Locks
- *
- * Usually record locks held by a process are released on *any* close and are
- * not inherited across a fork().
- *
- * These cmd values will set locks that conflict with process-associated
- * record  locks, but are "owned" by the open file description, not the
- * process. This means that they are inherited across fork() like BSD (flock)
- * locks, and they are only released automatically when the last reference to
- * the open file against which they were acquired is put.
- */
-#define F_OFD_GETLK	36
-#define F_OFD_SETLK	37
-#define F_OFD_SETLKW	38
-
-#define F_OWNER_TID	0
-#define F_OWNER_PID	1
-#define F_OWNER_PGRP	2
-
-struct f_owner_ex {
-	int	type;
-	__kernel_pid_t	pid;
-};
-
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
-/* for posix fcntl() and lockf() */
-#ifndef F_RDLCK
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-#endif
-
-/* for old implementation of bsd flock () */
-#ifndef F_EXLCK
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-#endif
-
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-/*
- * LOCK_MAND support has been removed from the kernel. We leave the symbols
- * here to not break legacy builds, but these should not be used in new code.
- */
-#define LOCK_MAND	32	/* This is a mandatory flock ... */
-#define LOCK_READ	64	/* which allows concurrent read operations */
-#define LOCK_WRITE	128	/* which allows concurrent write operations */
-#define LOCK_RW		192	/* which allows concurrent read & write ops */
-
-#define F_LINUX_SPECIFIC_BASE	1024
-
-#ifndef HAVE_ARCH_STRUCT_FLOCK
-struct flock {
-	short	l_type;
-	short	l_whence;
-	__kernel_off_t	l_start;
-	__kernel_off_t	l_len;
-	__kernel_pid_t	l_pid;
-#ifdef	__ARCH_FLOCK_EXTRA_SYSID
-	__ARCH_FLOCK_EXTRA_SYSID
-#endif
-#ifdef	__ARCH_FLOCK_PAD
-	__ARCH_FLOCK_PAD
-#endif
-};
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	__kernel_loff_t l_start;
-	__kernel_loff_t l_len;
-	__kernel_pid_t  l_pid;
-#ifdef	__ARCH_FLOCK64_PAD
-	__ARCH_FLOCK64_PAD
-#endif
-};
-#endif /* HAVE_ARCH_STRUCT_FLOCK */
-
-#endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
deleted file mode 100644
index 282e90aeb163c028..0000000000000000
--- a/tools/include/uapi/linux/fcntl.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_FCNTL_H
-#define _UAPI_LINUX_FCNTL_H
-
-#include <asm/fcntl.h>
-#include <linux/openat2.h>
-
-#define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
-#define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
-
-/*
- * Cancel a blocking posix lock; internal use only until we expose an
- * asynchronous lock api to userspace:
- */
-#define F_CANCELLK	(F_LINUX_SPECIFIC_BASE + 5)
-
-/* Create a file descriptor with FD_CLOEXEC set. */
-#define F_DUPFD_CLOEXEC	(F_LINUX_SPECIFIC_BASE + 6)
-
-/*
- * Request nofications on a directory.
- * See below for events that may be notified.
- */
-#define F_NOTIFY	(F_LINUX_SPECIFIC_BASE+2)
-
-/*
- * Set and get of pipe page size array
- */
-#define F_SETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 7)
-#define F_GETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 8)
-
-/*
- * Set/Get seals
- */
-#define F_ADD_SEALS	(F_LINUX_SPECIFIC_BASE + 9)
-#define F_GET_SEALS	(F_LINUX_SPECIFIC_BASE + 10)
-
-/*
- * Types of seals
- */
-#define F_SEAL_SEAL	0x0001	/* prevent further seals from being set */
-#define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
-#define F_SEAL_GROW	0x0004	/* prevent file from growing */
-#define F_SEAL_WRITE	0x0008	/* prevent writes */
-#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
-#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
-/* (1U << 31) is reserved for signed error codes */
-
-/*
- * Set/Get write life time hints. {GET,SET}_RW_HINT operate on the
- * underlying inode, while {GET,SET}_FILE_RW_HINT operate only on
- * the specific file.
- */
-#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
-#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
-#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
-#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
-
-/*
- * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
- * used to clear any hints previously set.
- */
-#define RWH_WRITE_LIFE_NOT_SET	0
-#define RWH_WRITE_LIFE_NONE	1
-#define RWH_WRITE_LIFE_SHORT	2
-#define RWH_WRITE_LIFE_MEDIUM	3
-#define RWH_WRITE_LIFE_LONG	4
-#define RWH_WRITE_LIFE_EXTREME	5
-
-/*
- * The originally introduced spelling is remained from the first
- * versions of the patch set that introduced the feature, see commit
- * v4.13-rc1~212^2~51.
- */
-#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
-
-/*
- * Types of directory notifications that may be requested.
- */
-#define DN_ACCESS	0x00000001	/* File accessed */
-#define DN_MODIFY	0x00000002	/* File modified */
-#define DN_CREATE	0x00000004	/* File created */
-#define DN_DELETE	0x00000008	/* File removed */
-#define DN_RENAME	0x00000010	/* File renamed */
-#define DN_ATTRIB	0x00000020	/* File changed attibutes */
-#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
-
-/*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
- * unlinkat.  The two functions do completely different things and therefore,
- * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
- * faccessat would be undefined behavior and thus treating it equivalent to
- * AT_EACCESS is valid undefined behavior.
- */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
-#define AT_EACCESS		0x200	/* Test access permitted for
-                                           effective IDs, not real IDs.  */
-#define AT_REMOVEDIR		0x200   /* Remove directory instead of
-                                           unlinking file.  */
-#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
-#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
-#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
-
-#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
-#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
-#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
-#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
-
-#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
-
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
-#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-					compare object identity and may not
-					be usable to open_by_handle_at(2) */
-#if defined(__KERNEL__)
-#define AT_GETATTR_NOSEC	0x80000000
-#endif
-
-#endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/include/uapi/linux/openat2.h b/tools/include/uapi/linux/openat2.h
deleted file mode 100644
index a5feb7604948791c..0000000000000000
--- a/tools/include/uapi/linux/openat2.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_OPENAT2_H
-#define _UAPI_LINUX_OPENAT2_H
-
-#include <linux/types.h>
-
-/*
- * Arguments for how openat2(2) should open the target path. If only @flags and
- * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
- *
- * However, unlike openat(2), unknown or invalid bits in @flags result in
- * -EINVAL rather than being silently ignored. @mode must be zero unless one of
- * {O_CREAT, O_TMPFILE} are set.
- *
- * @flags: O_* flags.
- * @mode: O_CREAT/O_TMPFILE file mode.
- * @resolve: RESOLVE_* flags.
- */
-struct open_how {
-	__u64 flags;
-	__u64 mode;
-	__u64 resolve;
-};
-
-/* how->resolve flags for openat2(2). */
-#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
-					(includes bind-mounts). */
-#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
-					"magic-links". */
-#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
-					(implies OEXT_NO_MAGICLINKS) */
-#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
-					"..", symlinks, and absolute
-					paths which escape the dirfd. */
-#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
-					be scoped inside the dirfd
-					(similar to chroot(2)). */
-#define RESOLVE_CACHED		0x20 /* Only complete if resolution can be
-					completed through cached lookup. May
-					return -EAGAIN if that's not
-					possible. */
-
-#endif /* _UAPI_LINUX_OPENAT2_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 03d00110a48fcb9a..4ea674df11f8afd5 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -10,12 +10,10 @@ FILES=(
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
   "include/uapi/linux/fadvise.h"
-  "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fscrypt.h"
   "include/uapi/linux/kcmp.h"
   "include/uapi/linux/kvm.h"
   "include/uapi/linux/in.h"
-  "include/uapi/linux/openat2.h"
   "include/uapi/linux/perf_event.h"
   "include/uapi/linux/sched.h"
   "include/uapi/linux/seccomp.h"
-- 
2.43.2


