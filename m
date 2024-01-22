Return-Path: <linux-kernel+bounces-33124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A162A8364FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B36C1F2536F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA33D99D;
	Mon, 22 Jan 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6p0tElo"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEE3D985;
	Mon, 22 Jan 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932145; cv=none; b=l3xXCOVdOLFPQ6h8HLJurlt9eF03BiNiicajjLx5CMInQB+MA+mlyIG9n0TefzFQHLNYfA592giq6bMyH7NX8A0I9tzOLCdd6IV0DrT1gZTTMsfMD3D4R3oit/Fhoo9+lgxBROwveaYMJ815qCPWAwJDVXUvU7hGB2mo6dDn0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932145; c=relaxed/simple;
	bh=Mp2VIsqkwD4hLiDLSGQW3qmjllga42IwY6fWlAt2/3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SihRzpDD+jyvuWew9ppUD5sa5jxv+mW1nbJ+vPWX4GHtYZYRFXyZJb7epTSMhYPcnfwdLz8XiM4wufJP4erpO0M7l/yozjq+6lxdOsz4/HiD+e1axq8HByBkvMugsn9cPhyqa5XmWXgS3662iCHdD579Qqdz4nxlEUhHlz4tECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6p0tElo; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbcfef55dcso1694347b3a.1;
        Mon, 22 Jan 2024 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932143; x=1706536943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYkeoBVPgdA7v3QtKkZP+t5mhLWLzGQfUgZIGHOAXts=;
        b=a6p0tElolffh3YBFq1i1oha4GijDjLDne4t5sJA8o9JtuuJlGfQoO8FaKHvjHuRsXX
         4QJgtaFgv4P1cvI/jVrsyTDPygadcdJb7m5qHgRhIYMBFzVxaITQhW7Xgm8b7EotADl+
         7RpzoDH+J7qeUm7zTyZ5oGjfbgWhutewJKBvQXcL6+sd1BJ4tPvWU4dkp8EvixsFrC4f
         w20h3HHj04W6Ghhjxna08yAkBKacbsZjsAFUXMHzZmNrNZ0aF4hmIk+qhFStkdtCgaW4
         VxfvZ7WUWECBOQtjfi5pN5euMhxe56qcrv838Ya1CVnBx7cR/G7TK9UDjZQsKIIyM8Ot
         GZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932143; x=1706536943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYkeoBVPgdA7v3QtKkZP+t5mhLWLzGQfUgZIGHOAXts=;
        b=szxZE0pOU9aNwWDlOEk2MvTP8Ga+iOzAoUzjrhv8DoQj1QZQ2YAYPQGouxFtWckPvT
         kDzLJ/mYMa8A2JGLhvqIaKqcGJ3jTozEg0WTgQHb3hxyIm4kAB5hjp5eZTrRIIDWxRDh
         cTO2ScIno1ScAJB/UwkVFKFHzx8VT0f6v1rGL3tY6NRCErbqjSO1qTsGfoqWCl9zMXVp
         wWR1kwiE2vH9gYFzxaI9t8HAMKtDcJq93TuworBFcaSl0By75H14cN9MNsIxPfMRzAl6
         +Qi9VUPvZBpUkl6N/rG5R9SNu4V9hq2nBJpDYilzwLKiwo7dx9U3Iu51efxl1yBwDLlp
         icRg==
X-Gm-Message-State: AOJu0YzxUHLy70kSfbxbVVZx6rL99wIEtcR+W1q+jMAnpZSUxiOBAE3Q
	244/5Ka2FVfrFg7WfiwHM2+PD0iirZbfuIzqnChJGbiBRa0+mhz3jjBWbKMg
X-Google-Smtp-Source: AGHT+IEciWaO7N++fpa/J6ruB+PPAAK95Xd59KK0CytVD71cAbSh2CPSVXsjhVhG7WtR90TgxoOgDw==
X-Received: by 2002:a05:6a00:1a88:b0:6d9:b15f:8ffe with SMTP id e8-20020a056a001a8800b006d9b15f8ffemr6554426pfv.6.1705932142844;
        Mon, 22 Jan 2024 06:02:22 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:21 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] nilfs2: convert sufile to use kmap_local
Date: Mon, 22 Jan 2024 23:01:52 +0900
Message-Id: <20240122140202.6950-6-konishi.ryusuke@gmail.com>
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

Concerning the code of the metadata file sufile for segment management,
convert all parts that uses the deprecated kmap_atomic() to use kmap_local.
All transformations are directly possible here.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sufile.c | 86 +++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 0a8119456c21..abf05dc5750c 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -107,11 +107,11 @@ static void nilfs_sufile_mod_counter(struct buffer_head *header_bh,
 	struct nilfs_sufile_header *header;
 	void *kaddr;
 
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
 	le64_add_cpu(&header->sh_ncleansegs, ncleanadd);
 	le64_add_cpu(&header->sh_ndirtysegs, ndirtyadd);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(header_bh);
 }
@@ -315,10 +315,10 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 	ret = nilfs_sufile_get_header_block(sufile, &header_bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
 	last_alloc = le64_to_cpu(header->sh_last_alloc);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nsegments = nilfs_sufile_get_nsegments(sufile);
 	maxsegnum = sui->allocmax;
@@ -352,7 +352,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 							   &su_bh);
 		if (ret < 0)
 			goto out_header;
-		kaddr = kmap_atomic(su_bh->b_page);
+		kaddr = kmap_local_page(su_bh->b_page);
 		su = nilfs_sufile_block_get_segment_usage(
 			sufile, segnum, su_bh, kaddr);
 
@@ -363,14 +363,14 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 				continue;
 			/* found a clean segment */
 			nilfs_segment_usage_set_dirty(su);
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 
-			kaddr = kmap_atomic(header_bh->b_page);
+			kaddr = kmap_local_page(header_bh->b_page);
 			header = kaddr + bh_offset(header_bh);
 			le64_add_cpu(&header->sh_ncleansegs, -1);
 			le64_add_cpu(&header->sh_ndirtysegs, 1);
 			header->sh_last_alloc = cpu_to_le64(segnum);
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 
 			sui->ncleansegs--;
 			mark_buffer_dirty(header_bh);
@@ -384,7 +384,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 			goto out_header;
 		}
 
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(su_bh);
 	}
 
@@ -406,16 +406,16 @@ void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
 	struct nilfs_segment_usage *su;
 	void *kaddr;
 
-	kaddr = kmap_atomic(su_bh->b_page);
+	kaddr = kmap_local_page(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (unlikely(!nilfs_segment_usage_clean(su))) {
 		nilfs_warn(sufile->i_sb, "%s: segment %llu must be clean",
 			   __func__, (unsigned long long)segnum);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		return;
 	}
 	nilfs_segment_usage_set_dirty(su);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nilfs_sufile_mod_counter(header_bh, -1, 1);
 	NILFS_SUI(sufile)->ncleansegs--;
@@ -432,11 +432,11 @@ void nilfs_sufile_do_scrap(struct inode *sufile, __u64 segnum,
 	void *kaddr;
 	int clean, dirty;
 
-	kaddr = kmap_atomic(su_bh->b_page);
+	kaddr = kmap_local_page(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (su->su_flags == cpu_to_le32(BIT(NILFS_SEGMENT_USAGE_DIRTY)) &&
 	    su->su_nblocks == cpu_to_le32(0)) {
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		return;
 	}
 	clean = nilfs_segment_usage_clean(su);
@@ -446,7 +446,7 @@ void nilfs_sufile_do_scrap(struct inode *sufile, __u64 segnum,
 	su->su_lastmod = cpu_to_le64(0);
 	su->su_nblocks = cpu_to_le32(0);
 	su->su_flags = cpu_to_le32(BIT(NILFS_SEGMENT_USAGE_DIRTY));
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nilfs_sufile_mod_counter(header_bh, clean ? (u64)-1 : 0, dirty ? 0 : 1);
 	NILFS_SUI(sufile)->ncleansegs -= clean;
@@ -463,12 +463,12 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 	void *kaddr;
 	int sudirty;
 
-	kaddr = kmap_atomic(su_bh->b_page);
+	kaddr = kmap_local_page(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (nilfs_segment_usage_clean(su)) {
 		nilfs_warn(sufile->i_sb, "%s: segment %llu is already clean",
 			   __func__, (unsigned long long)segnum);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		return;
 	}
 	if (unlikely(nilfs_segment_usage_error(su)))
@@ -481,7 +481,7 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 			   (unsigned long long)segnum);
 
 	nilfs_segment_usage_set_clean(su);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	mark_buffer_dirty(su_bh);
 
 	nilfs_sufile_mod_counter(header_bh, 1, sudirty ? (u64)-1 : 0);
@@ -509,12 +509,12 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 	if (ret)
 		goto out_sem;
 
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
 	if (unlikely(nilfs_segment_usage_error(su))) {
 		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
 
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(bh);
 		if (nilfs_segment_is_active(nilfs, segnum)) {
 			nilfs_error(sufile->i_sb,
@@ -532,7 +532,7 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 		ret = -EIO;
 	} else {
 		nilfs_segment_usage_set_dirty(su);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		mark_buffer_dirty(bh);
 		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
@@ -562,7 +562,7 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 	if (ret < 0)
 		goto out_sem;
 
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
 	if (modtime) {
 		/*
@@ -573,7 +573,7 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 		su->su_lastmod = cpu_to_le64(modtime);
 	}
 	su->su_nblocks = cpu_to_le32(nblocks);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(bh);
 	nilfs_mdt_mark_dirty(sufile);
@@ -614,7 +614,7 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 	if (ret < 0)
 		goto out_sem;
 
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
 	sustat->ss_nsegs = nilfs_sufile_get_nsegments(sufile);
 	sustat->ss_ncleansegs = le64_to_cpu(header->sh_ncleansegs);
@@ -624,7 +624,7 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 	spin_lock(&nilfs->ns_last_segment_lock);
 	sustat->ss_prot_seq = nilfs->ns_prot_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(header_bh);
 
  out_sem:
@@ -640,15 +640,15 @@ void nilfs_sufile_do_set_error(struct inode *sufile, __u64 segnum,
 	void *kaddr;
 	int suclean;
 
-	kaddr = kmap_atomic(su_bh->b_page);
+	kaddr = kmap_local_page(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (nilfs_segment_usage_error(su)) {
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		return;
 	}
 	suclean = nilfs_segment_usage_clean(su);
 	nilfs_segment_usage_set_error(su);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (suclean) {
 		nilfs_sufile_mod_counter(header_bh, -1, 0);
@@ -717,7 +717,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 			/* hole */
 			continue;
 		}
-		kaddr = kmap_atomic(su_bh->b_page);
+		kaddr = kmap_local_page(su_bh->b_page);
 		su = nilfs_sufile_block_get_segment_usage(
 			sufile, segnum, su_bh, kaddr);
 		su2 = su;
@@ -726,7 +726,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 			     ~BIT(NILFS_SEGMENT_USAGE_ERROR)) ||
 			    nilfs_segment_is_active(nilfs, segnum + j)) {
 				ret = -EBUSY;
-				kunmap_atomic(kaddr);
+				kunmap_local(kaddr);
 				brelse(su_bh);
 				goto out_header;
 			}
@@ -738,7 +738,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
 				nc++;
 			}
 		}
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		if (nc > 0) {
 			mark_buffer_dirty(su_bh);
 			ncleaned += nc;
@@ -823,10 +823,10 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 		sui->allocmin = 0;
 	}
 
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
 	header->sh_ncleansegs = cpu_to_le64(sui->ncleansegs);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(header_bh);
 	nilfs_mdt_mark_dirty(sufile);
@@ -891,7 +891,7 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 			continue;
 		}
 
-		kaddr = kmap_atomic(su_bh->b_page);
+		kaddr = kmap_local_page(su_bh->b_page);
 		su = nilfs_sufile_block_get_segment_usage(
 			sufile, segnum, su_bh, kaddr);
 		for (j = 0; j < n;
@@ -904,7 +904,7 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 				si->sui_flags |=
 					BIT(NILFS_SEGMENT_USAGE_ACTIVE);
 		}
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(su_bh);
 	}
 	ret = nsegs;
@@ -973,7 +973,7 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 		goto out_header;
 
 	for (;;) {
-		kaddr = kmap_atomic(bh->b_page);
+		kaddr = kmap_local_page(bh->b_page);
 		su = nilfs_sufile_block_get_segment_usage(
 			sufile, sup->sup_segnum, bh, kaddr);
 
@@ -1010,7 +1010,7 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 			su->su_flags = cpu_to_le32(sup->sup_sui.sui_flags);
 		}
 
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 
 		sup = (void *)sup + supsz;
 		if (sup >= supend)
@@ -1115,7 +1115,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 			continue;
 		}
 
-		kaddr = kmap_atomic(su_bh->b_page);
+		kaddr = kmap_local_page(su_bh->b_page);
 		su = nilfs_sufile_block_get_segment_usage(sufile, segnum,
 				su_bh, kaddr);
 		for (i = 0; i < n; ++i, ++segnum, su = (void *)su + susz) {
@@ -1145,7 +1145,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 			}
 
 			if (nblocks >= minlen) {
-				kunmap_atomic(kaddr);
+				kunmap_local(kaddr);
 
 				ret = blkdev_issue_discard(nilfs->ns_bdev,
 						start * sects_per_block,
@@ -1157,7 +1157,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 				}
 
 				ndiscarded += nblocks;
-				kaddr = kmap_atomic(su_bh->b_page);
+				kaddr = kmap_local_page(su_bh->b_page);
 				su = nilfs_sufile_block_get_segment_usage(
 					sufile, segnum, su_bh, kaddr);
 			}
@@ -1166,7 +1166,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 			start = seg_start;
 			nblocks = seg_end - seg_start + 1;
 		}
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		put_bh(su_bh);
 	}
 
@@ -1246,10 +1246,10 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 		goto failed;
 
 	sui = NILFS_SUI(sufile);
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
 	sui->ncleansegs = le64_to_cpu(header->sh_ncleansegs);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(header_bh);
 
 	sui->allocmax = nilfs_sufile_get_nsegments(sufile) - 1;
-- 
2.34.1


