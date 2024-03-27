Return-Path: <linux-kernel+bounces-120890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D088E039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F384C1C29281
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2A14535B;
	Wed, 27 Mar 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcQCyoIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2A14534C;
	Wed, 27 Mar 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541504; cv=none; b=IWSSu+ekUUNHyCmoj3brS4RPlyCwVFZOIr9c4zForviaUL2vBmK/zafZe3xj50S9cLjEvH1vtSJgeHYlI4SjLNiXKoz0bX1sWmZTw5ituOBi7nNlbWEtGwlbRfNrMPns9I5M7YMMWfPvJvu7qhjXm6p5FW1TdI7+RgHg1zzcq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541504; c=relaxed/simple;
	bh=N+bok/TdpI2DmjaL8yQCg/Whx6nBQqHHX7+lwM+IHQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYOnDQm+oQkoe6Rf+Wsjn2bulzAyo394n2TKM+uA43f9HFMc9KLtaQE0cSos0mVeJ6rn2v7G7/i89+yms/VZYNCtP0ZY29LG3r5OzmztCXpHQe7LEOaS7qKtgcG3MRf7yR2Vx5qstLAx/89fLed5hZtAyPEkRd5/s6nD301fuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcQCyoIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A5C433C7;
	Wed, 27 Mar 2024 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541503;
	bh=N+bok/TdpI2DmjaL8yQCg/Whx6nBQqHHX7+lwM+IHQE=;
	h=From:To:Cc:Subject:Date:From;
	b=RcQCyoIAtDGlLqXlvmg0YmhmmoFIgEVtbRQHmy49M/wgMLxV0v9w1dcqTiNPtz54v
	 FpEpkjdcWRHdZx3gjEO3bvQjP/m2C9JSOV8nCQXgqmNQSkfqcrmFpiz7suNf0DYfKD
	 57RCxS+ndgvcJU5q72VKCbOvbxbHaGRbqiaO8hX6G7i7R0Cs/x325hVcFl8xPHCR8r
	 XPRFv3uYYaybxICh4xo6J+Z3xt5KsvcgPT5wCiXyp1NuWRPRy98HKJKhO3f4QxgRz8
	 U9yFZ1vs/33zKrcC7RcrRx8LQh7tBxSfho3TOeDwZV3eUbO7YEenxZ+/3mX/BBA8o2
	 KQIFk+EuA9amw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bharathsm@microsoft.com
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: prevent updating file size from server if we have a read/write lease" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:11:41 -0400
Message-ID: <20240327121142.2828930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4b61f3b1c67f5068590965f64ea6e8d5d5bd961 Mon Sep 17 00:00:00 2001
From: Bharath SM <bharathsm@microsoft.com>
Date: Thu, 29 Feb 2024 23:09:52 +0530
Subject: [PATCH] cifs: prevent updating file size from server if we have a
 read/write lease

In cases of large directories, the readdir operation may span multiple
round trips to retrieve contents. This introduces a potential race
condition in case of concurrent write and readdir operations. If the
readdir operation initiates before a write has been processed by the
server, it may update the file size attribute to an older value.
Address this issue by avoiding file size updates from readdir when we
have read/write lease.

Scenario:
1) process1: open dir xyz
2) process1: readdir instance 1 on xyz
3) process2: create file.txt for write
4) process2: write x bytes to file.txt
5) process2: close file.txt
6) process2: open file.txt for read
7) process1: readdir 2 - overwrites file.txt inode size to 0
8) process2: read contents of file.txt - bug, short read with 0 bytes

Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/cifsproto.h |  6 ++++--
 fs/smb/client/file.c      |  8 +++++---
 fs/smb/client/inode.c     | 13 +++++++------
 fs/smb/client/readdir.c   |  2 +-
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a841bf4967fa4..58cfbd450a55e 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -144,7 +144,8 @@ extern int cifs_reconnect(struct TCP_Server_Info *server,
 extern int checkSMB(char *buf, unsigned int len, struct TCP_Server_Info *srvr);
 extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
 extern bool backup_cred(struct cifs_sb_info *);
-extern bool is_size_safe_to_change(struct cifsInodeInfo *, __u64 eof);
+extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 eof,
+				   bool from_readdir);
 extern void cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 			    unsigned int bytes_written);
 extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, int);
@@ -201,7 +202,8 @@ extern void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
 				     struct cifs_sb_info *cifs_sb);
 extern void cifs_dir_info_to_fattr(struct cifs_fattr *, FILE_DIRECTORY_INFO *,
 					struct cifs_sb_info *);
-extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr);
+extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+			       bool from_readdir);
 extern struct inode *cifs_iget(struct super_block *sb,
 			       struct cifs_fattr *fattr);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f391c9b803d84..9cff5f7dc062e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -329,7 +329,7 @@ int cifs_posix_open(const char *full_path, struct inode **pinode,
 		}
 	} else {
 		cifs_revalidate_mapping(*pinode);
-		rc = cifs_fattr_to_inode(*pinode, &fattr);
+		rc = cifs_fattr_to_inode(*pinode, &fattr, false);
 	}
 
 posix_open_ret:
@@ -4738,12 +4738,14 @@ static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
    refreshing the inode only on increases in the file size
    but this is tricky to do without racing with writebehind
    page caching in the current Linux kernel design */
-bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file)
+bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
+			    bool from_readdir)
 {
 	if (!cifsInode)
 		return true;
 
-	if (is_inode_writable(cifsInode)) {
+	if (is_inode_writable(cifsInode) ||
+		((cifsInode->oplock & CIFS_CACHE_RW_FLG) != 0 && from_readdir)) {
 		/* This inode is open for write at least once */
 		struct cifs_sb_info *cifs_sb;
 
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d02f8ba29cb5b..7f28edf4b20f3 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -147,7 +147,8 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 
 /* populate an inode with info from a cifs_fattr struct */
 int
-cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
+cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+		    bool from_readdir)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -199,7 +200,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 * Can't safely change the file size here if the client is writing to
 	 * it due to potential races.
 	 */
-	if (is_size_safe_to_change(cifs_i, fattr->cf_eof)) {
+	if (is_size_safe_to_change(cifs_i, fattr->cf_eof, from_readdir)) {
 		i_size_write(inode, fattr->cf_eof);
 
 		/*
@@ -368,7 +369,7 @@ static int update_inode_info(struct super_block *sb,
 		CIFS_I(*inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	return cifs_fattr_to_inode(*inode, fattr);
+	return cifs_fattr_to_inode(*inode, fattr, false);
 }
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
@@ -403,7 +404,7 @@ cifs_get_file_info_unix(struct file *filp)
 	} else
 		goto cifs_gfiunix_out;
 
-	rc = cifs_fattr_to_inode(inode, &fattr);
+	rc = cifs_fattr_to_inode(inode, &fattr, false);
 
 cifs_gfiunix_out:
 	free_xid(xid);
@@ -934,7 +935,7 @@ cifs_get_file_info(struct file *filp)
 	fattr.cf_uniqueid = CIFS_I(inode)->uniqueid;
 	fattr.cf_flags |= CIFS_FATTR_NEED_REVAL;
 	/* if filetype is different, return error */
-	rc = cifs_fattr_to_inode(inode, &fattr);
+	rc = cifs_fattr_to_inode(inode, &fattr, false);
 cgfi_exit:
 	cifs_free_open_info(&data);
 	free_xid(xid);
@@ -1491,7 +1492,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		}
 
 		/* can't fail - see cifs_find_inode() */
-		cifs_fattr_to_inode(inode, fattr);
+		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
 		if (inode->i_state & I_NEW) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index b520eea7bfce8..132ae7d884a97 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -148,7 +148,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 						rc = -ESTALE;
 					}
 				}
-				if (!rc && !cifs_fattr_to_inode(inode, fattr)) {
+				if (!rc && !cifs_fattr_to_inode(inode, fattr, true)) {
 					dput(dentry);
 					return;
 				}
-- 
2.43.0





