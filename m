Return-Path: <linux-kernel+bounces-33131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57A836506
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540571C23B94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE93F8CE;
	Mon, 22 Jan 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAZCBw/M"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBA3F8C7;
	Mon, 22 Jan 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932160; cv=none; b=quS0DrIsvNgjr9h37H0Ew+1Ito0spsyhM6WAYmCgkxlPI58owAohQtj5BJY3UfDVCR5wzxfAGnOo7tPB0RK/XRkbAJng6JuWjhP15dYhT2Bf4tViOSJAgaH/NC/oWnKlmiW1iCLJ3tVZixcvD6fR4SBwqyY23s57boNKnbzDqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932160; c=relaxed/simple;
	bh=e/iLIlcctS3PDZ091P5efHc5/xKQVjvmaKqlsDBvd1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fug4qH/ad9j9Lt9mfjNgo+Ov6vH8sLByybZOJw2kRCdu9dGGB4HTRXGhc2g/jCh8JSXtQsLGSohjtCBZ1aMxiJkaCH0XI+sZgY/poqvP9CLR7RSGUHjq5kjIuvX5BEbAGQyZbKprcQoszV8zlISC6QWCH4xWu9eSsS3/IWXRpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAZCBw/M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so2523891b3a.2;
        Mon, 22 Jan 2024 06:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932159; x=1706536959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+w/aJizGDBPVm90ztc+RWb/54sTDDL5EzZlenZ1mc=;
        b=FAZCBw/MOjUiX1SZDkYx1wxJb+I5KDZIE8cf7wnQjqse869G+Snx+XIocmDrEmCrho
         GgjphfyIjQgFr+6xk0rctcaBzVhBtP15mraxArn257FBHCthI8HnMIoTjpL8Kxdceq4/
         WzH4E4m5zYA75H2igBBo+MIfV52vvCwDO3OpSNAzgVUBJ0JJV6ZPTazAcNVxZ0HZTjWD
         4fmbNnEvpGh6v8A5Yv8td0Q/iUJP6hr5WsCIjWDi58mwQo+EgLpAGH55WQaN3aE9ECyX
         aUOVrioqDis1BLKZasTROHgO/kOg06N124yHjUWZm6AeSn+qIcNMQEriM7JlmZMTWSDi
         TFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932159; x=1706536959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s+w/aJizGDBPVm90ztc+RWb/54sTDDL5EzZlenZ1mc=;
        b=xVTNHs2mXH52CpIoc8hzdeFwLVwccyJuad1z37gYiTMWnwXkzOtenB2jU/aa5Prhul
         eYeYQpNH3SOHJiV+qbeMOKgo6bZGFlKG2onuLvTJJW6rrA3JxZFc/e8WF2EqKI29G3e7
         ymucw0kZoYlZ5XOSoIc38zRhMDbbNZhml4tEykbBDuttSmbVEiJFoDsx1lrxjisD0CcH
         wyNzbrjk6AslzGExZrUsz2pkYdTI9qh2ab74qhKdLH1pn8Gi+MgLnBgOjsqf4ebQyfPq
         eNM9jg26LRZECqbzoly51gqWoW8YiXb9D8hPNdZFVaQzc6rJJvCQMyEYYO31WMdqxsu1
         JJDQ==
X-Gm-Message-State: AOJu0Yxz4qUj6svdfF2mDLgetKhxt+XNCFezvdmWwx6malesJ2zaG04C
	UB5rTUZUlatxCou39nsCKk0mT/qxWf9/yVyUrrGrgvXZiRtEZNa3M7TFgM3x
X-Google-Smtp-Source: AGHT+IE7xu7hBDmaNyZtElbdywS3DdhY2gpsg68skh4ABh7cazRTrsKEAwfcqYaRi140dqaWhwQkag==
X-Received: by 2002:a05:6a00:23d6:b0:6db:cb94:e8d3 with SMTP id g22-20020a056a0023d600b006dbcb94e8d3mr6146035pfc.23.1705932158820;
        Mon, 22 Jan 2024 06:02:38 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:36 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] nilfs2: localize highmem mapping for checkpoint creation within cpfile
Date: Mon, 22 Jan 2024 23:01:58 +0900
Message-Id: <20240122140202.6950-12-konishi.ryusuke@gmail.com>
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

In order to convert kmap() used in cpfile to kmap_local, first move the
checkpoint creation routine, which is one of the places where kmap is
used, to the cpfile side and make the page mapping local and temporary.
And use kmap_local instead of kmap to access the checkpoint entry page
(and header block page) when generating a checkpoint.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/cpfile.h  |  1 +
 fs/nilfs2/segment.c | 31 ++-----------------
 3 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 39136637f715..f62da80e530a 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -272,6 +272,80 @@ int nilfs_cpfile_get_checkpoint(struct inode *cpfile,
 	return ret;
 }
 
+/**
+ * nilfs_cpfile_create_checkpoint - create a checkpoint entry on cpfile
+ * @cpfile: checkpoint file inode
+ * @cno:    number of checkpoint to set up
+ *
+ * This function creates a checkpoint with the number specified by @cno on
+ * cpfile.  If the specified checkpoint entry already exists due to a past
+ * failure, it will be reused without returning an error.
+ * In either case, the buffer of the block containing the checkpoint entry
+ * and the cpfile inode are made dirty for inclusion in the write log.
+ *
+ * Return: 0 on success, or the following negative error code on failure.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EIO	- I/O error (including metadata corruption).
+ * * %-EROFS	- Read only filesystem
+ */
+int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno)
+{
+	struct buffer_head *header_bh, *cp_bh;
+	struct nilfs_cpfile_header *header;
+	struct nilfs_checkpoint *cp;
+	void *kaddr;
+	int ret;
+
+	if (WARN_ON_ONCE(cno < 1))
+		return -EIO;
+
+	down_write(&NILFS_MDT(cpfile)->mi_sem);
+	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
+	if (unlikely(ret < 0)) {
+		if (ret == -ENOENT) {
+			nilfs_error(cpfile->i_sb,
+				    "checkpoint creation failed due to metadata corruption.");
+			ret = -EIO;
+		}
+		goto out_sem;
+	}
+	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 1, &cp_bh);
+	if (unlikely(ret < 0))
+		goto out_header;
+
+	kaddr = kmap_local_page(cp_bh->b_page);
+	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
+	if (nilfs_checkpoint_invalid(cp)) {
+		/* a newly-created checkpoint */
+		nilfs_checkpoint_clear_invalid(cp);
+		if (!nilfs_cpfile_is_in_first(cpfile, cno))
+			nilfs_cpfile_block_add_valid_checkpoints(cpfile, cp_bh,
+								 kaddr, 1);
+		kunmap_local(kaddr);
+
+		kaddr = kmap_local_page(header_bh->b_page);
+		header = nilfs_cpfile_block_get_header(cpfile, header_bh,
+						       kaddr);
+		le64_add_cpu(&header->ch_ncheckpoints, 1);
+		kunmap_local(kaddr);
+		mark_buffer_dirty(header_bh);
+	} else {
+		kunmap_local(kaddr);
+	}
+
+	/* Force the buffer and the inode to become dirty */
+	mark_buffer_dirty(cp_bh);
+	brelse(cp_bh);
+	nilfs_mdt_mark_dirty(cpfile);
+
+out_header:
+	brelse(header_bh);
+
+out_sem:
+	up_write(&NILFS_MDT(cpfile)->mi_sem);
+	return ret;
+}
+
 /**
  * nilfs_cpfile_put_checkpoint - put a checkpoint
  * @cpfile: inode of checkpoint file
diff --git a/fs/nilfs2/cpfile.h b/fs/nilfs2/cpfile.h
index edabb2dc5756..fcb1a94097b3 100644
--- a/fs/nilfs2/cpfile.h
+++ b/fs/nilfs2/cpfile.h
@@ -19,6 +19,7 @@
 int nilfs_cpfile_get_checkpoint(struct inode *, __u64, int,
 				struct nilfs_checkpoint **,
 				struct buffer_head **);
+int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno);
 void nilfs_cpfile_put_checkpoint(struct inode *, __u64, struct buffer_head *);
 int nilfs_cpfile_delete_checkpoints(struct inode *, __u64, __u64);
 int nilfs_cpfile_delete_checkpoint(struct inode *, __u64);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3657918328ea..37d06eacec63 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -880,34 +880,6 @@ static void nilfs_segctor_clear_metadata_dirty(struct nilfs_sc_info *sci)
 	nilfs_mdt_clear_dirty(nilfs->ns_dat);
 }
 
-static int nilfs_segctor_create_checkpoint(struct nilfs_sc_info *sci)
-{
-	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
-	struct buffer_head *bh_cp;
-	struct nilfs_checkpoint *raw_cp;
-	int err;
-
-	/* XXX: this interface will be changed */
-	err = nilfs_cpfile_get_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, 1,
-					  &raw_cp, &bh_cp);
-	if (likely(!err)) {
-		/*
-		 * The following code is duplicated with cpfile.  But, it is
-		 * needed to collect the checkpoint even if it was not newly
-		 * created.
-		 */
-		mark_buffer_dirty(bh_cp);
-		nilfs_mdt_mark_dirty(nilfs->ns_cpfile);
-		nilfs_cpfile_put_checkpoint(
-			nilfs->ns_cpfile, nilfs->ns_cno, bh_cp);
-	} else if (err == -EINVAL || err == -ENOENT) {
-		nilfs_error(sci->sc_super,
-			    "checkpoint creation failed due to metadata corruption.");
-		err = -EIO;
-	}
-	return err;
-}
-
 static int nilfs_segctor_fill_in_checkpoint(struct nilfs_sc_info *sci)
 {
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
@@ -1261,7 +1233,8 @@ static int nilfs_segctor_collect_blocks(struct nilfs_sc_info *sci, int mode)
 			break;
 		nilfs_sc_cstage_inc(sci);
 		/* Creating a checkpoint */
-		err = nilfs_segctor_create_checkpoint(sci);
+		err = nilfs_cpfile_create_checkpoint(nilfs->ns_cpfile,
+						     nilfs->ns_cno);
 		if (unlikely(err))
 			break;
 		fallthrough;
-- 
2.34.1


