Return-Path: <linux-kernel+bounces-33132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249BD836508
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2268A1C23F42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242C3FB0B;
	Mon, 22 Jan 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITwtnguZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82583F8F0;
	Mon, 22 Jan 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932163; cv=none; b=E3xqaWJao2V/PRct4P803EQu58SwZUmzGNs7gusEmQcv19WV4KmUbjIvXlgIg5p18LWhFTYZ1kCjX1yTbUtW8IZOaQHXyUaI1WXp2Zti+HQEHJRCC+TP/34UwswD/7dNiEovaDyuT3JzdWlhMaoCL5Sm4Aqk3xT6uCGKkPRqcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932163; c=relaxed/simple;
	bh=p/yd1EZVbBYz8Cn1Wm0AFG+QOuhgUVMQeApB8P/8MYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehDu/hKp9qqhYTkWsKh7IyDV58MIAU0iqHqBN21De2VZUwvmppx8KBJKL99lGawMa+FkP/xfM7/C+SHrsLnTrMw8fFUQWd1m4DuOjufJ6pdTl8snurvf2YwXFvN9tWkzB9yqvrrxNRWLdGwUbIVpslpakAvhZlCvBfYIQ+2bvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITwtnguZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dbb003be79so2814924b3a.0;
        Mon, 22 Jan 2024 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932161; x=1706536961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwcnEI8d06MKkzqOiryGzrgEAR3rkNftR1wOMkqp6nU=;
        b=ITwtnguZSd9VQREgCvWunsoRh9MqtFx4w3Z8gL3mui1pHGsKpq8vv4nxeDATkkvOEq
         2591Ie3Gc0KdnMPj3ZMOYjQKuS8Nc0qt7XuXEPpRqz2H70iDglmhNrtAxf/o67ltEqMW
         Mgj4Bolj37kw6IbAWPEpBcm7ykWbMQOM92GCYisl4XVis0Jiyr76TuybNLPqQMgJUoF9
         p6mCxI5T4GqPZyH8c10S9QZQMrQx6B6doOe+SLwutfXdbRcg9JWZL7OWgqZB9pjWv2K6
         3Oam8efbXd2ktkd4CviBrH5NXsfnZQQlXNMs5EUZErUaiZVz9nmGfRYHwZ3jeAgnYgOr
         j8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932161; x=1706536961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwcnEI8d06MKkzqOiryGzrgEAR3rkNftR1wOMkqp6nU=;
        b=cWcql9TAXg5bQOq5ZhOnsQP3hqHYWXuT/kGeT71wv4ca5Vdv7dWDRzsvM2iKPh1En/
         oebqIqXbXPAUeSrMIdkPWR4zXsz0HyJu89Qx5G0lnjDpJHjp1vF66W3smEtDRpRQfjDp
         x1PLNi/VL8tXB6qhuUXBs8xwhwYVYzJZ/+kizQjbiLBWTj/4ZqCUqSVKoFGiwLXmR7/Z
         XlJhAIYUW8PC8ya+BMqFmfLgL2zf6q9xiHVBSeon9I7gpjmdsJBmbn4k344D8FFXUHh+
         VBLG2iWvKl0AUhqKJvi7p5V9nNZS+oQn9F/bJbyaua8LhvngV5qiy986R2Y2I195qqNT
         +iDA==
X-Gm-Message-State: AOJu0Yw1F56XtfeMMi/fhHHKlS6+/BNAT9zsDOFqCnwmUE2lgcHlnnbh
	YkjCsULfyCgFi8RcJYxquLz4+KgQMBy9soa1R9JLI2LoHFLcV58wEtBEWqCG
X-Google-Smtp-Source: AGHT+IHzmdcoU2csoUV9fAQBXoWvirql5/womugkroSHP5M+w8FjbGbyE+E021Unf52Yif2XTVMAYw==
X-Received: by 2002:a05:6a20:72a9:b0:19c:4d16:4d3c with SMTP id o41-20020a056a2072a900b0019c4d164d3cmr1163931pzk.29.1705932161296;
        Mon, 22 Jan 2024 06:02:41 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:40 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] nilfs2: localize highmem mapping for checkpoint finalization within cpfile
Date: Mon, 22 Jan 2024 23:01:59 +0900
Message-Id: <20240122140202.6950-13-konishi.ryusuke@gmail.com>
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

Move the checkpoint finalization routine to the cpfile side, and make the
page mapping local and temporary.  And use kmap_local instead of kmap to
access the checkpoint entry page when finalizing a checkpoint.

In this conversion, some of the information on the checkpoint entry being
rewritten is passed through the arguments of the newly added method
nilfs_cpfile_finalize_checkpoint().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/cpfile.h  |  3 ++
 fs/nilfs2/segment.c | 51 +++----------------------------
 3 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index f62da80e530a..3af77252e081 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -363,6 +363,80 @@ void nilfs_cpfile_put_checkpoint(struct inode *cpfile, __u64 cno,
 	brelse(bh);
 }
 
+/**
+ * nilfs_cpfile_finalize_checkpoint - fill in a checkpoint entry in cpfile
+ * @cpfile: checkpoint file inode
+ * @cno:    checkpoint number
+ * @root:   nilfs root object
+ * @blkinc: number of blocks added by this checkpoint
+ * @ctime:  checkpoint creation time
+ * @minor:  minor checkpoint flag
+ *
+ * This function completes the checkpoint entry numbered by @cno in the
+ * cpfile with the data given by the arguments @root, @blkinc, @ctime, and
+ * @minor.
+ *
+ * Return: 0 on success, or the following negative error code on failure.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EIO	- I/O error (including metadata corruption).
+ */
+int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
+				     struct nilfs_root *root, __u64 blkinc,
+				     time64_t ctime, bool minor)
+{
+	struct buffer_head *cp_bh;
+	struct nilfs_checkpoint *cp;
+	void *kaddr;
+	int ret;
+
+	if (WARN_ON_ONCE(cno < 1))
+		return -EIO;
+
+	down_write(&NILFS_MDT(cpfile)->mi_sem);
+	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
+	if (unlikely(ret < 0)) {
+		if (ret == -ENOENT)
+			goto error;
+		goto out_sem;
+	}
+
+	kaddr = kmap_local_page(cp_bh->b_page);
+	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	if (unlikely(nilfs_checkpoint_invalid(cp))) {
+		kunmap_local(kaddr);
+		brelse(cp_bh);
+		goto error;
+	}
+
+	cp->cp_snapshot_list.ssl_next = 0;
+	cp->cp_snapshot_list.ssl_prev = 0;
+	cp->cp_inodes_count = cpu_to_le64(atomic64_read(&root->inodes_count));
+	cp->cp_blocks_count = cpu_to_le64(atomic64_read(&root->blocks_count));
+	cp->cp_nblk_inc = cpu_to_le64(blkinc);
+	cp->cp_create = cpu_to_le64(ctime);
+	cp->cp_cno = cpu_to_le64(cno);
+
+	if (minor)
+		nilfs_checkpoint_set_minor(cp);
+	else
+		nilfs_checkpoint_clear_minor(cp);
+
+	nilfs_write_inode_common(root->ifile, &cp->cp_ifile_inode);
+	nilfs_bmap_write(NILFS_I(root->ifile)->i_bmap, &cp->cp_ifile_inode);
+
+	kunmap_local(kaddr);
+	brelse(cp_bh);
+out_sem:
+	up_write(&NILFS_MDT(cpfile)->mi_sem);
+	return ret;
+
+error:
+	nilfs_error(cpfile->i_sb,
+		    "checkpoint finalization failed due to metadata corruption.");
+	ret = -EIO;
+	goto out_sem;
+}
+
 /**
  * nilfs_cpfile_delete_checkpoints - delete checkpoints
  * @cpfile: inode of checkpoint file
diff --git a/fs/nilfs2/cpfile.h b/fs/nilfs2/cpfile.h
index fcb1a94097b3..aa1408a3af01 100644
--- a/fs/nilfs2/cpfile.h
+++ b/fs/nilfs2/cpfile.h
@@ -21,6 +21,9 @@ int nilfs_cpfile_get_checkpoint(struct inode *, __u64, int,
 				struct buffer_head **);
 int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno);
 void nilfs_cpfile_put_checkpoint(struct inode *, __u64, struct buffer_head *);
+int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
+				     struct nilfs_root *root, __u64 blkinc,
+				     time64_t ctime, bool minor);
 int nilfs_cpfile_delete_checkpoints(struct inode *, __u64, __u64);
 int nilfs_cpfile_delete_checkpoint(struct inode *, __u64);
 int nilfs_cpfile_change_cpmode(struct inode *, __u64, int);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 37d06eacec63..ecf778f44bbc 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -880,51 +880,6 @@ static void nilfs_segctor_clear_metadata_dirty(struct nilfs_sc_info *sci)
 	nilfs_mdt_clear_dirty(nilfs->ns_dat);
 }
 
-static int nilfs_segctor_fill_in_checkpoint(struct nilfs_sc_info *sci)
-{
-	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
-	struct buffer_head *bh_cp;
-	struct nilfs_checkpoint *raw_cp;
-	struct inode *ifile;
-	int err;
-
-	err = nilfs_cpfile_get_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, 0,
-					  &raw_cp, &bh_cp);
-	if (unlikely(err)) {
-		if (err == -EINVAL || err == -ENOENT) {
-			nilfs_error(sci->sc_super,
-				    "checkpoint finalization failed due to metadata corruption.");
-			err = -EIO;
-		}
-		goto failed_ibh;
-	}
-	raw_cp->cp_snapshot_list.ssl_next = 0;
-	raw_cp->cp_snapshot_list.ssl_prev = 0;
-	raw_cp->cp_inodes_count =
-		cpu_to_le64(atomic64_read(&sci->sc_root->inodes_count));
-	raw_cp->cp_blocks_count =
-		cpu_to_le64(atomic64_read(&sci->sc_root->blocks_count));
-	raw_cp->cp_nblk_inc =
-		cpu_to_le64(sci->sc_nblk_inc + sci->sc_nblk_this_inc);
-	raw_cp->cp_create = cpu_to_le64(sci->sc_seg_ctime);
-	raw_cp->cp_cno = cpu_to_le64(nilfs->ns_cno);
-
-	if (test_bit(NILFS_SC_HAVE_DELTA, &sci->sc_flags))
-		nilfs_checkpoint_clear_minor(raw_cp);
-	else
-		nilfs_checkpoint_set_minor(raw_cp);
-
-	ifile = sci->sc_root->ifile;
-	nilfs_write_inode_common(ifile, &raw_cp->cp_ifile_inode);
-	nilfs_bmap_write(NILFS_I(ifile)->i_bmap, &raw_cp->cp_ifile_inode);
-
-	nilfs_cpfile_put_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, bh_cp);
-	return 0;
-
- failed_ibh:
-	return err;
-}
-
 static void nilfs_fill_in_file_bmap(struct inode *ifile,
 				    struct nilfs_inode_info *ii)
 
@@ -2103,7 +2058,11 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 
 		if (mode == SC_LSEG_SR &&
 		    nilfs_sc_cstage_get(sci) >= NILFS_ST_CPFILE) {
-			err = nilfs_segctor_fill_in_checkpoint(sci);
+			err = nilfs_cpfile_finalize_checkpoint(
+				nilfs->ns_cpfile, nilfs->ns_cno, sci->sc_root,
+				sci->sc_nblk_inc + sci->sc_nblk_this_inc,
+				sci->sc_seg_ctime,
+				!test_bit(NILFS_SC_HAVE_DELTA, &sci->sc_flags));
 			if (unlikely(err))
 				goto failed_to_write;
 
-- 
2.34.1


