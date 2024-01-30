Return-Path: <linux-kernel+bounces-44768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F23842724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DA3B21AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3517CF29;
	Tue, 30 Jan 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjaKvfM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B516BB2B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626187; cv=none; b=O/gCkQsqBoIU4UQRaVLtjNSLfNKXl98Xg8kzH5gNC9zRceZqhrFB2fpF5tcxeFXjtiOaVCU0UujrOR4905vzFW1fVGYRDq41nGFGLzQZVT4q9PfYFY9uuE1izOno6DkUg3OgF9MDbukfjkMzmWFzrFrJ7guUc0lgeuz4e3VMK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626187; c=relaxed/simple;
	bh=B62oaFM0vBB+o7VxltDa38Ve4oQtWNobEnD6Wez7Ycg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TcU6RcZ43YafsIFY1okfyXzZKsEr5aoskBaH+w3Lzyfn57qeaxkuK4YhBm5MZIUBFPE2656OUfJd+u9RON7168/n/qwEGvFDPw131T23Ch7U7Zi+lN/PoW9vDox+Sxgw25coNf/hI+x9gpgFcnbN6r+SCDuvsi070hV5Mo2em+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjaKvfM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05099C43390;
	Tue, 30 Jan 2024 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626187;
	bh=B62oaFM0vBB+o7VxltDa38Ve4oQtWNobEnD6Wez7Ycg=;
	h=Date:From:To:Cc:Subject:From;
	b=CjaKvfM/j4hULH69Rq0aCR273Y9BsgX2+vr1lvcixGTAqFCfWScfGhVCGI4iAQ9kO
	 Bsplxfh/4E0mPxzpcHruA5lWM95gd4imlu4+Cvp+RspnBuqh6eo9PWr+bnJOU6GmSJ
	 j+Jk1oO6D2tCYMXNJrMFrm1Nse3Px6lLa5xzevtZp494wpbMOEU3Gfd6wuIjw927/4
	 vO8+Zittp3GseHvwcJKWkbA5mQ36i7r3oa+yAb37wsvZwN1Vn26htyZ5kVHmj41R8N
	 MXBCnvXMBfzWjIAT2tzBgHhuD/t3HcoB1SKQPnya6NfZmzkW2GI2mvJpo1n27G4DTH
	 maqkFkUsQou3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 915A240441; Tue, 30 Jan 2024 11:49:44 -0300 (-03)
Date: Tue, 30 Jan 2024 11:49:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/mount.h copy with the
 kernel sources
Message-ID: <ZbkMiB7ZcOsLP2V5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes from:

  35e27a5744131996 ("fs: keep struct mnt_id_req extensible")
  b4c2bea8ceaa50cd ("add listmount(2) syscall")
  46eae99ef73302f9 ("add statmount(2) syscall")

That doesn't change anything in tools this time as nothing that is
harvested by the beauty scripts got changed:

  $ ls -1 tools/perf/trace/beauty/*mount*sh
  tools/perf/trace/beauty/fsmount.sh
  tools/perf/trace/beauty/mount_flags.sh
  tools/perf/trace/beauty/move_mount_flags.sh
  $

This addresses this perf build warning.

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mount.h | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index bb242fdcfe6b29bf..ad5478dbad007341 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -138,4 +138,74 @@ struct mount_attr {
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
 
+
+/*
+ * Structure for getting mount/superblock/filesystem info with statmount(2).
+ *
+ * The interface is similar to statx(2): individual fields or groups can be
+ * selected with the @mask argument of statmount().  Kernel will set the @mask
+ * field according to the supported fields.
+ *
+ * If string fields are selected, then the caller needs to pass a buffer that
+ * has space after the fixed part of the structure.  Nul terminated strings are
+ * copied there and offsets relative to @str are stored in the relevant fields.
+ * If the buffer is too small, then EOVERFLOW is returned.  The actually used
+ * size is returned in @size.
+ */
+struct statmount {
+	__u32 size;		/* Total size, including strings */
+	__u32 __spare1;
+	__u64 mask;		/* What results were written */
+	__u32 sb_dev_major;	/* Device ID */
+	__u32 sb_dev_minor;
+	__u64 sb_magic;		/* ..._SUPER_MAGIC */
+	__u32 sb_flags;		/* SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
+	__u32 fs_type;		/* [str] Filesystem type */
+	__u64 mnt_id;		/* Unique ID of mount */
+	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
+	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;		/* MOUNT_ATTR_... */
+	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
+	__u64 mnt_peer_group;	/* ID of shared peer group */
+	__u64 mnt_master;	/* Mount receives propagation from this ID */
+	__u64 propagate_from;	/* Propagation from in current namespace */
+	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
+	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
+	__u64 __spare2[50];
+	char str[];		/* Variable size part containing strings */
+};
+
+/*
+ * Structure for passing mount ID and miscellaneous parameters to statmount(2)
+ * and listmount(2).
+ *
+ * For statmount(2) @param represents the request mask.
+ * For listmount(2) @param represents the last listed mount id (or zero).
+ */
+struct mnt_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 mnt_id;
+	__u64 param;
+};
+
+/* List of all mnt_id_req versions. */
+#define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * @mask bits for statmount(2)
+ */
+#define STATMOUNT_SB_BASIC		0x00000001U     /* Want/got sb_... */
+#define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
+#define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
+#define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
+#define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
+#define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+
+/*
+ * Special @mnt_id values that can be passed to listmount
+ */
+#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.43.0


