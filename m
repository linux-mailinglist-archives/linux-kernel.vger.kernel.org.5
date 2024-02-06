Return-Path: <linux-kernel+bounces-55692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393784C01A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC29B23E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F41CD27;
	Tue,  6 Feb 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf3xVRwd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E841C2BE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258789; cv=none; b=k9zUZfaKaahbk31/Wu6ZLwltdiCEI8tq6bPpG07bbEIMj/gfCccV++HAW1+xx8zvU6IZlXIgDp6y4XtBftJsPTGUMfts6/SvlXPEJ+2Jni81oP9gssb4bXfbkziHEGCqIO2D4QBnnoLkYDAqUZ4CGzl74HaVew7zq37Yn5hbYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258789; c=relaxed/simple;
	bh=gfsVpmwhRu8HTKpAYGChUTLFL+Kp+83MHsCmT5S9RM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/+mzTPR8I9Mv/5931GZtF0K5F5Ln5DKDl5ly1qBoEU0ykn5GT6vwqHH9ZLw4GCkyDtNCRdb0+7YruPAmSqI+dJTbo3yVO251Hjw4H+qdiiWW1g3QDturpflWCq4loTrP4LwkbPJUOBmkjR9/KaazOXMrnWK9G1qQrVkKr0FLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf3xVRwd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d98fc5ebceso263515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258786; x=1707863586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVd6xrn9TMNrvJaedeT5HJ5aap1fph73205495XGdnA=;
        b=Wf3xVRwdRawsygnOV8han1Ytrdm4/Htgj+cVGUSHAY8Ujc3nxfbwYOtH7BEoqGjPKO
         C2RjB8HfoyLJKw6vFCxw1hrrlrxkk1EKZ4L8U7emB3BwZny3vLLRSEWa3hi9iQ+nWLcx
         Dw6wi5w7mvSdvwI1Xf1EQ7UQU9NqOks8LzuXno1/a7J3mcE+GQMVTMVI7U8LHlKuEF7G
         CpbKUepm2RRXLgsQ/uMcAn4VRbkA3ddhisQouteIpl/Kne/TzAvMC4/9fpcxFvAMKoxk
         3tm+CzEmyiIUt1gqssBxJ81y7EMtbnB5VI8KZSSJi5d6zJ4SmPvm5tEM+vs1PilzFTqj
         lY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258786; x=1707863586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVd6xrn9TMNrvJaedeT5HJ5aap1fph73205495XGdnA=;
        b=GO7sQ+CFlaL8Xb9NYs15OfPbFXyfdr/PbkjnwlEnw+iCNl9irP/WaSrOuGTlJ//c4n
         NuE/tIjZEu2IHE4ahyiNLPSCsLoxc3zB6Pm2JdcqbsJjmHjvoHGz+nMhlXlI0dgsglfV
         UVmG9QpSWdHQid747cIE7wjTQj5Cye45PhMPwyTg2R0JMGL6zjDksBnzZ9AjFQBBVAhR
         axD6JTYzl4oYVDSRVjQMdvDig3YRNL2taNdzqycLgdnptLGUboKEVNddACVEJT3jQN8P
         F7PyD88Z/9UBwFi95HBvTbado72s3l2LKedDkIBfDcIE9MjP/DyfJgyKP7TYOdO44XCY
         Qeew==
X-Gm-Message-State: AOJu0YxdfcpKpW2F8/Hz/U3C6uoB0MhP0AoGdPrng3vXbwMMno+/nUHY
	6rSXinWDa9e/pMmBqYs02tBVRdPedNc6PjPG5/nAbXxf57T7zar9mHLlPJTq
X-Google-Smtp-Source: AGHT+IH6UEA4hxydRSoFtVeVirqAnHesA5Z7tbM/OPK/nita++SgODnG0JRhIqmNJ999L2H3TNGvAg==
X-Received: by 2002:a17:902:7406:b0:1d8:ed67:c360 with SMTP id g6-20020a170902740600b001d8ed67c360mr2837481pll.65.1707258785913;
        Tue, 06 Feb 2024 14:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4Y5JNu1CAKFjge2yJIaLgiUcGpSyXnxnZWHumvqm5xHT9aPmENYYvGjRjDJomle+RDUhL1traW2GuUxD6IMxBPfgzV5nhSLXV7kUA1VihvW/trsb0jyhPm/80vAlIw2ex4bfgcYxeGy5Laztoj22+7LdtlTBLSz4YSu0a/RQrfxx5Kg==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:6e38:9e6f:4818:7d04])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b001d6f091ca04sm32371pld.13.2024.02.06.14.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:33:05 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: support file pinning for zoned devices
Date: Tue,  6 Feb 2024 14:32:56 -0800
Message-ID: <20240206223257.3461359-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240206223257.3461359-1-daeho43@gmail.com>
References: <20240206223257.3461359-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Support file pinning with conventional storage area for zoned devices

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 14 +++++++++-
 fs/f2fs/file.c    | 24 ++++++++++++----
 fs/f2fs/gc.c      | 14 +++++++---
 fs/f2fs/segment.c | 71 +++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/segment.h | 10 +++++++
 5 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 543898482f8b..9b8b4d6a0d61 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3708,7 +3708,8 @@ void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
 			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
+int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
+int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
@@ -3886,6 +3887,9 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
+int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg,
+		bool dry_run, unsigned int dry_run_sections);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
@@ -4540,6 +4544,14 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
+static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
+					  block_t blkaddr)
+{
+	int devi = f2fs_target_device_index(sbi, blkaddr);
+
+	return !bdev_is_zoned(FDEV(devi).bdev);
+}
+
 static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 25b119cf3499..4078e7616aef 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1735,9 +1735,11 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		f2fs_down_write(&sbi->pin_sem);
 
-		f2fs_lock_op(sbi);
-		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
-		f2fs_unlock_op(sbi);
+		err = f2fs_allocate_pinning_section(sbi);
+		if (err) {
+			f2fs_up_write(&sbi->pin_sem);
+			goto out_err;
+		}
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
 		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
@@ -3187,6 +3189,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	__u32 pin;
 	int ret = 0;
 
@@ -3196,7 +3199,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
 	ret = mnt_want_write_file(filp);
@@ -3209,9 +3212,18 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
 		goto done;
+	} else if (f2fs_is_pinned_file(inode)) {
+		goto done;
 	}
 
-	if (f2fs_should_update_outplace(inode, NULL)) {
+	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	/* Let's allow file pinning on zoned device. */
+	if (!f2fs_sb_has_blkzoned(sbi) &&
+	    f2fs_should_update_outplace(inode, NULL)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3233,7 +3245,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	set_inode_flag(inode, FI_PIN_FILE);
 	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
 done:
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a46d5053f965..100695540087 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1983,10 +1983,12 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	init_atgc_management(sbi);
 }
 
-static int f2fs_gc_range(struct f2fs_sb_info *sbi,
-		unsigned int start_seg, unsigned int end_seg, bool dry_run)
+int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg,
+		bool dry_run, unsigned int dry_run_sections)
 {
 	unsigned int segno;
+	unsigned int gc_secs = dry_run_sections;
 
 	for (segno = start_seg; segno <= end_seg; segno += sbi->segs_per_sec) {
 		struct gc_inode_list gc_list = {
@@ -1994,11 +1996,15 @@ static int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
+						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
 			return -EAGAIN;
+		if (dry_run && dry_run_sections &&
+		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
+			break;
 
 		if (fatal_signal_pending(current))
 			return -ERESTARTSYS;
@@ -2036,7 +2042,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7901ede58113..7d5e9476d8d5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2640,7 +2640,8 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
  * This function should be returned with success, otherwise BUG
  */
 static void get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir)
+			unsigned int *newseg, bool new_sec, int dir,
+			bool pinning)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno, secno, zoneno;
@@ -2660,6 +2661,17 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
 			goto got_it;
 	}
+
+	/*
+	 * If we format f2fs on zoned storage, let's try to get pinned sections
+	 * from beginning of the storage, which should be a conventional one.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		segno = pinning ?
+			0 : max(first_zoned_segno(sbi), *newseg);
+		left_start = hint = GET_SEC_FROM_SEG(sbi, segno);
+	}
+
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
@@ -2788,12 +2800,13 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
  * Allocate a current working segment.
  * This function always allocates a free segment in LFS manner.
  */
-static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
+static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned short seg_type = curseg->seg_type;
 	unsigned int segno = curseg->segno;
 	int dir = ALLOC_LEFT;
+	bool pinning = type == CURSEG_COLD_DATA_PINNED;
 
 	if (curseg->inited)
 		write_sum_page(sbi, curseg->sum_blk,
@@ -2805,13 +2818,21 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 		dir = ALLOC_RIGHT;
 
 	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec, dir);
+	get_new_segment(sbi, &segno, new_sec, dir, pinning);
+
+	if (new_sec && pinning &&
+	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
+		__set_free(sbi, segno);
+		return -EAGAIN;
+	}
+
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
 	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
 		curseg->fragment_remained_chunk =
 				get_random_u32_inclusive(1, sbi->max_fragment_chunk);
+	return 0;
 }
 
 static int __next_free_blkoff(struct f2fs_sb_info *sbi,
@@ -3084,7 +3105,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
+static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 						bool new_sec, bool force)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -3094,21 +3115,49 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 	    !curseg->next_blkoff &&
 	    !get_valid_blocks(sbi, curseg->segno, new_sec) &&
 	    !get_ckpt_valid_blocks(sbi, curseg->segno, new_sec))
-		return;
+		return 0;
 
 	old_segno = curseg->segno;
-	new_curseg(sbi, type, true);
+	if (new_curseg(sbi, type, true))
+		return -EAGAIN;
 	stat_inc_seg_type(sbi, curseg);
 	locate_dirty_segment(sbi, old_segno);
+	return 0;
 }
 
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force)
+int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force)
 {
+	int ret;
+
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	down_write(&SIT_I(sbi)->sentry_lock);
-	__allocate_new_segment(sbi, type, true, force);
+	ret = __allocate_new_segment(sbi, type, true, force);
 	up_write(&SIT_I(sbi)->sentry_lock);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+
+	return ret;
+}
+
+int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
+{
+	int err;
+	bool gc_required = true;
+
+retry:
+	f2fs_lock_op(sbi);
+	err = f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
+	f2fs_unlock_op(sbi);
+
+	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
+		f2fs_down_write(&sbi->gc_lock);
+		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		f2fs_up_write(&sbi->gc_lock);
+
+		gc_required = false;
+		goto retry;
+	}
+
+	return err;
 }
 
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
@@ -3474,6 +3523,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * new segment.
 	 */
 	if (segment_full) {
+		if (type == CURSEG_COLD_DATA_PINNED &&
+		    !((curseg->segno + 1) % sbi->segs_per_sec))
+			goto skip_new_segment;
+
 		if (from_gc) {
 			get_atssr_segment(sbi, type, se->type,
 						AT_SSR, se->mtime);
@@ -3485,6 +3538,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			stat_inc_seg_type(sbi, curseg);
 		}
 	}
+
+skip_new_segment:
 	/*
 	 * segment dirty status should be updated after segment allocation,
 	 * so we just need to update status only one time after previous
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8129be788bd5..8b6996ddc9ba 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -969,3 +969,13 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 	dcc->discard_wake = true;
 	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
+
+static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
+{
+	int devi;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++)
+		if (bdev_is_zoned(FDEV(devi).bdev))
+			return GET_SEGNO(sbi, FDEV(devi).start_blk);
+	return 0;
+}
-- 
2.43.0.594.gd9cf4e227d-goog


