Return-Path: <linux-kernel+bounces-33133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D140883650A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ECB1C24550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FCB3FB2C;
	Mon, 22 Jan 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfVDWldh"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08613FB15;
	Mon, 22 Jan 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932166; cv=none; b=GMuh+fPvQEnugdzpZx7FvQRsZxdoDXRtmU1SjbQzqI778170o2vTuDhSTm7bQ2HHsilbeTdCjJEm5i+HVcBDCQFx6AKnby+SORUTbMcwf+MOd5OUKGOlHQAijHdL0sXHlL9CDxczzvrqbBf8ncPGTQF4Mr94y2pdLPaoF7Aup60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932166; c=relaxed/simple;
	bh=RvX1yH3PhG5hvyZ0xNP55eRwWEtASwgMOXVneFnR+f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=soeDS0Re3FU9YEzO4BG7QGzJVYwSc/GmSYBxkrf4N23JObfE4pdLSgx1EMuoXxeOp3IwpflCjHk1b1aouBqj4L95Nk+yR937/tkEqbH+z0d4/ARUcrmorE6FZ2v9KVtNTQhPN8JCAuKYZ1rzLB8fwnUH9MsUo/KH91WXngxEn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfVDWldh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so1523927b3a.1;
        Mon, 22 Jan 2024 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932164; x=1706536964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toceYKuZw57Tb3AnyUgBAG/I6VP3Dk2Ys2J2hjEm8Zk=;
        b=WfVDWldhhlDfZYfUeGTP0eJhhrGLxemibp/KzYV9CwwB7OTHIfJq2vfM3XBppQ8ru+
         uA1D8s0YwX0lao/a3KuflsXbQnUbNhAPJymsc9nYJ0cljuBhJi79BpL0mja6+SdHtdVb
         B57GUcSlBetGCP1x6a67AnMpaahuXI9oeBN6lgnPluZEWHZG+Eh2wyEgsn2hP/cP8wMo
         SX7etFP85xYEolSo0j26AqXCAHkoU5b6ojzlZ1+o8bqaUEOLgtpImU4J4e3LJxBy981C
         W89JGQlbMT6HdcAI7lvWfcjfytwIyZooVgU0bl2JS2RwlvOm/Tpt1jrOtzg35JNeCRte
         ClNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932164; x=1706536964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toceYKuZw57Tb3AnyUgBAG/I6VP3Dk2Ys2J2hjEm8Zk=;
        b=TwmlBNLbmV0955VVr1+kRldVTsAdx5nc5IrnU88NWh/mcxmGi2g2T1IykP9yi9mRU9
         qM5hHLDdSy93ZGI8mGPty8fAIbZlcjSGnowkRp3mYYx8I78iEGh4gyhq8yj3OrWz55X6
         vogm6ZFhHrE8dVtkOTizFFqyo7kPYfv+o0F12D0Vi3F1068kC8/j9vrKyN2hQNoHpZ8l
         OeTgtxF7y63i+CMHpigqYjVW3IwGVc9/Qdai8TKgFxCG7TrPOp2WAGhIKwJoiqI/Ybmn
         sqxdD3h2s3tecS3alc/8incRGvE7IJCX5Wf1cgy37L7JfuJ5X+1RbOlDtr11emJQ5Po3
         C+mA==
X-Gm-Message-State: AOJu0Yx18VFqEgANqN+l/RAYAhQQjXxbAbclbGkP3+FGABCyZ7ZQz4bA
	QJzcrsFZ9ofOlkRULhrRtS9tIeTiR30u6zBmZ2OQcP9T4ml+A5Uiq+nsV1+I
X-Google-Smtp-Source: AGHT+IG51yISbPsHWA6r5GEnVJKNtrnblr39VZpZwgadP/uYDwojKc/WkOzUFl1veucsVPYnMifGxQ==
X-Received: by 2002:a05:6a20:7fa0:b0:19b:5f7:e142 with SMTP id d32-20020a056a207fa000b0019b05f7e142mr5930524pzj.30.1705932163878;
        Mon, 22 Jan 2024 06:02:43 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:42 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] nilfs2: localize highmem mapping for checkpoint reading within cpfile
Date: Mon, 22 Jan 2024 23:02:00 +0900
Message-Id: <20240122140202.6950-14-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the code for reading from a checkpoint entry that is performed
in nilfs_attach_checkpoint() to the cpfile side, and make the page
mapping local and temporary.  And use kmap_local instead of kmap
to access the checkpoint entry page.

In order to load the ifile inode information included in the checkpoint
entry within the inode lock section of nilfs_ifile_read(), the newly
added checkpoint reading method nilfs_cpfile_read_checkpoint() is called
indirectly via nilfs_ifile_read() instead of from
nilfs_attach_checkpoint().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/cpfile.h |  2 ++
 fs/nilfs2/ifile.c  | 17 ++++++++----
 fs/nilfs2/ifile.h  |  3 +-
 fs/nilfs2/super.c  | 31 ++++-----------------
 5 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 3af77252e081..56e38843536b 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -186,6 +186,74 @@ static inline int nilfs_cpfile_delete_checkpoint_block(struct inode *cpfile,
 				      nilfs_cpfile_get_blkoff(cpfile, cno));
 }
 
+/**
+ * nilfs_cpfile_read_checkpoint - read a checkpoint entry in cpfile
+ * @cpfile: checkpoint file inode
+ * @cno:    number of checkpoint entry to read
+ * @root:   nilfs root object
+ * @ifile:  ifile's inode to read and attach to @root
+ *
+ * This function imports checkpoint information from the checkpoint file and
+ * stores it to the inode file given by @ifile and the nilfs root object
+ * given by @root.
+ *
+ * Return: 0 on success, or the following negative error code on failure.
+ * * %-EINVAL	- Invalid checkpoint.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EIO	- I/O error (including metadata corruption).
+ */
+int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
+				 struct nilfs_root *root, struct inode *ifile)
+{
+	struct buffer_head *cp_bh;
+	struct nilfs_checkpoint *cp;
+	void *kaddr;
+	int ret;
+
+	if (cno < 1 || cno > nilfs_mdt_cno(cpfile))
+		return -EINVAL;
+
+	down_read(&NILFS_MDT(cpfile)->mi_sem);
+	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
+	if (unlikely(ret < 0)) {
+		if (ret == -ENOENT)
+			ret = -EINVAL;
+		goto out_sem;
+	}
+
+	kaddr = kmap_local_page(cp_bh->b_page);
+	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	if (nilfs_checkpoint_invalid(cp)) {
+		ret = -EINVAL;
+		goto put_cp;
+	}
+
+	ret = nilfs_read_inode_common(ifile, &cp->cp_ifile_inode);
+	if (unlikely(ret)) {
+		/*
+		 * Since this inode is on a checkpoint entry, treat errors
+		 * as metadata corruption.
+		 */
+		nilfs_err(cpfile->i_sb,
+			  "ifile inode (checkpoint number=%llu) corrupted",
+			  (unsigned long long)cno);
+		ret = -EIO;
+		goto put_cp;
+	}
+
+	/* Configure the nilfs root object */
+	atomic64_set(&root->inodes_count, le64_to_cpu(cp->cp_inodes_count));
+	atomic64_set(&root->blocks_count, le64_to_cpu(cp->cp_blocks_count));
+	root->ifile = ifile;
+
+put_cp:
+	kunmap_local(kaddr);
+	brelse(cp_bh);
+out_sem:
+	up_read(&NILFS_MDT(cpfile)->mi_sem);
+	return ret;
+}
+
 /**
  * nilfs_cpfile_get_checkpoint - get a checkpoint
  * @cpfile: inode of checkpoint file
diff --git a/fs/nilfs2/cpfile.h b/fs/nilfs2/cpfile.h
index aa1408a3af01..2cfa14011bc8 100644
--- a/fs/nilfs2/cpfile.h
+++ b/fs/nilfs2/cpfile.h
@@ -19,6 +19,8 @@
 int nilfs_cpfile_get_checkpoint(struct inode *, __u64, int,
 				struct nilfs_checkpoint **,
 				struct buffer_head **);
+int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
+				 struct nilfs_root *root, struct inode *ifile);
 int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno);
 void nilfs_cpfile_put_checkpoint(struct inode *, __u64, struct buffer_head *);
 int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index e9538fa46ff2..612e609158b5 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -15,6 +15,7 @@
 #include "mdt.h"
 #include "alloc.h"
 #include "ifile.h"
+#include "cpfile.h"
 
 /**
  * struct nilfs_ifile_info - on-memory private data of ifile
@@ -173,14 +174,18 @@ int nilfs_ifile_count_free_inodes(struct inode *ifile,
  * nilfs_ifile_read - read or get ifile inode
  * @sb: super block instance
  * @root: root object
+ * @cno: number of checkpoint entry to read
  * @inode_size: size of an inode
- * @raw_inode: on-disk ifile inode
- * @inodep: buffer to store the inode
+ *
+ * Return: 0 on success, or the following negative error code on failure.
+ * * %-EINVAL	- Invalid checkpoint.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EIO	- I/O error (including metadata corruption).
  */
 int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
-		     size_t inode_size, struct nilfs_inode *raw_inode,
-		     struct inode **inodep)
+		     __u64 cno, size_t inode_size)
 {
+	struct the_nilfs *nilfs;
 	struct inode *ifile;
 	int err;
 
@@ -201,13 +206,13 @@ int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
 
 	nilfs_palloc_setup_cache(ifile, &NILFS_IFILE_I(ifile)->palloc_cache);
 
-	err = nilfs_read_inode_common(ifile, raw_inode);
+	nilfs = sb->s_fs_info;
+	err = nilfs_cpfile_read_checkpoint(nilfs->ns_cpfile, cno, root, ifile);
 	if (err)
 		goto failed;
 
 	unlock_new_inode(ifile);
  out:
-	*inodep = ifile;
 	return 0;
  failed:
 	iget_failed(ifile);
diff --git a/fs/nilfs2/ifile.h b/fs/nilfs2/ifile.h
index b71ab0a81dc4..625545cc2a98 100644
--- a/fs/nilfs2/ifile.h
+++ b/fs/nilfs2/ifile.h
@@ -38,7 +38,6 @@ int nilfs_ifile_get_inode_block(struct inode *, ino_t, struct buffer_head **);
 int nilfs_ifile_count_free_inodes(struct inode *, u64 *, u64 *);
 
 int nilfs_ifile_read(struct super_block *sb, struct nilfs_root *root,
-		     size_t inode_size, struct nilfs_inode *raw_inode,
-		     struct inode **inodep);
+		     __u64 cno, size_t inode_size);
 
 #endif	/* _NILFS_IFILE_H */
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index df8674173b22..5e630c179a1e 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -544,8 +544,6 @@ int nilfs_attach_checkpoint(struct super_block *sb, __u64 cno, int curr_mnt,
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_root *root;
-	struct nilfs_checkpoint *raw_cp;
-	struct buffer_head *bh_cp;
 	int err = -ENOMEM;
 
 	root = nilfs_find_or_create_root(
@@ -557,38 +555,19 @@ int nilfs_attach_checkpoint(struct super_block *sb, __u64 cno, int curr_mnt,
 		goto reuse; /* already attached checkpoint */
 
 	down_read(&nilfs->ns_segctor_sem);
-	err = nilfs_cpfile_get_checkpoint(nilfs->ns_cpfile, cno, 0, &raw_cp,
-					  &bh_cp);
+	err = nilfs_ifile_read(sb, root, cno, nilfs->ns_inode_size);
 	up_read(&nilfs->ns_segctor_sem);
-	if (unlikely(err)) {
-		if (err == -ENOENT || err == -EINVAL) {
-			nilfs_err(sb,
-				  "Invalid checkpoint (checkpoint number=%llu)",
-				  (unsigned long long)cno);
-			err = -EINVAL;
-		}
+	if (unlikely(err))
 		goto failed;
-	}
-
-	err = nilfs_ifile_read(sb, root, nilfs->ns_inode_size,
-			       &raw_cp->cp_ifile_inode, &root->ifile);
-	if (err)
-		goto failed_bh;
-
-	atomic64_set(&root->inodes_count,
-			le64_to_cpu(raw_cp->cp_inodes_count));
-	atomic64_set(&root->blocks_count,
-			le64_to_cpu(raw_cp->cp_blocks_count));
-
-	nilfs_cpfile_put_checkpoint(nilfs->ns_cpfile, cno, bh_cp);
 
  reuse:
 	*rootp = root;
 	return 0;
 
- failed_bh:
-	nilfs_cpfile_put_checkpoint(nilfs->ns_cpfile, cno, bh_cp);
  failed:
+	if (err == -EINVAL)
+		nilfs_err(sb, "Invalid checkpoint (checkpoint number=%llu)",
+			  (unsigned long long)cno);
 	nilfs_put_root(root);
 
 	return err;
-- 
2.34.1


