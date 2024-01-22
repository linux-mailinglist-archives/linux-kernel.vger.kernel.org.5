Return-Path: <linux-kernel+bounces-33125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6F8364FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B3DB271CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017283DB99;
	Mon, 22 Jan 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bucdMhRI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C693DB85;
	Mon, 22 Jan 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932149; cv=none; b=Ab6DCJTUKo/CHJyC7z26676c3Tsgllk6QNpSFLiZw7TGCNOtv09W3XIbDLDankLYO76kO0J7OanRJ7dEkSJuFqCyDEu8P810QerMjqVnpOLavNvQpo+QVk7316f3nDxn++hIiZm1It8nvH1OBF7yP+FXdf6s26EPZe1eOAbzb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932149; c=relaxed/simple;
	bh=IudtWyOxinWnl6LMIfCneUAvzLA9Hbbkx69DLR7GJl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKjQI2U+Tx71SkBkqg9sttSZyFPiFylnzahj9IHm4kzosP9kUEtgut1QugOdCRAGKeKPNK2hd5pc79v/ibzTpvvOcRXglH+nMfL18ZOUS1ala8zDujM64U/tKsySomz8T8CC+3YSawyZCzOQaWeYXnEPuj1TY+F7yLwno53hmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bucdMhRI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so1523537b3a.1;
        Mon, 22 Jan 2024 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932147; x=1706536947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alZcxKZkQD4ACA9S37ZutEnmpFpfckKyvR2o/CXMERQ=;
        b=bucdMhRIo22Umco4hkh/xPFwwvax492Hk4PbxT86wYFrhMWEDKfVAIJKIHLIyL4Knt
         Bv6pCrFmcPu7eSvk1ARXOr7jL5KjwV3bgylNzxrKNPHa3RtS+YjeWH5HJ0jGYf5967rd
         k5iTKruVcI6ee4nQbbAE+QScPf0g6+6qgDSvhvXsxz415L/i7AF+6Jz7kmTZml5oXF9R
         iewMOmAdWQhx2195fXtmipoo6EXiBwxFmJxByQMK3EhezID3uqgRqTHFmns9L/oFS1/6
         9n+dPHImwjVmhay1Nf9t3uAZl2KtEPXbTFMpYzAHNVOTuOX9/IqpV6ZMz6FJHKa3rh+M
         7RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932147; x=1706536947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alZcxKZkQD4ACA9S37ZutEnmpFpfckKyvR2o/CXMERQ=;
        b=Q9Gw8RygFPbeGdaSjP5eDO6ije3oticD6sV+jwRTW7rWKJn5XvWvL3/PnNm0n8p8to
         OJ7vSIUADXj5Avb5aUbrVgBLYMltW6GxXX41mCGuOXEMQ41vKgvg3875N6r3QvfiuXkK
         OG2dayfcWFYyIrEHaAn2TDEHq1uXMzd86RuL3dnAWWEeGFgcqQDJXfTTgWFCvAFK+dRH
         CJU/MtYOpa4JI+GrdHwdTOEJB82SJ8S9Pog/LkkR55VGITV/TPoDt3GKnvpjgufKLfs/
         LVu+V3BBxjVNMIGcsds2n2M0QrU1zx10jENIkx3/xW82UhDKdBx9DPXGEi9Hoidap88p
         ftkQ==
X-Gm-Message-State: AOJu0YzsTLN9UOcdoNmp2PDOJLRMU5EnUsa4T4uw4rfkrFAyTEhXZWr1
	d8cwy60Z7cb8UzMc/zxzdBq3pI4CpHcsloL1tZM1xzOiRmnwPje5JvF6fGUM
X-Google-Smtp-Source: AGHT+IFGRsWE0m3/mYANyApH0MQNZYBDD6S3mG4V5ht5ZjqPqL59L4uiv9H2OMLBK9maXXSMPx7Wwg==
X-Received: by 2002:a05:6a20:6ba6:b0:19a:d8d2:c645 with SMTP id bu38-20020a056a206ba600b0019ad8d2c645mr4510454pzb.109.1705932145406;
        Mon, 22 Jan 2024 06:02:25 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:24 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] nilfs2: convert persistent object allocator to use kmap_local
Date: Mon, 22 Jan 2024 23:01:53 +0900
Message-Id: <20240122140202.6950-7-konishi.ryusuke@gmail.com>
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

Regarding the allocator code that is commonly used in the ondisk inode
metadata file ifile and the disk address translation metadata file
DAT, convert the parts that use the deprecated kmap_atomic() and kmap()
to use kmap_local.

Most can be converted directly, but only
nilfs_palloc_prepare_alloc_entry() needs to be rewritten to change mapping
sections so that multiple kmap_local/kunmap_local calls are nested and
disk I/O can be avoided within the mapping sections.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/alloc.c | 91 ++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 7342de296ec3..89caef7513db 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -525,54 +525,55 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 		ret = nilfs_palloc_get_desc_block(inode, group, 1, &desc_bh);
 		if (ret < 0)
 			return ret;
-		desc_kaddr = kmap(desc_bh->b_page);
+		desc_kaddr = kmap_local_page(desc_bh->b_page);
 		desc = nilfs_palloc_block_get_group_desc(
 			inode, group, desc_bh, desc_kaddr);
 		n = nilfs_palloc_rest_groups_in_desc_block(inode, group,
 							   maxgroup);
-		for (j = 0; j < n; j++, desc++, group++) {
+		for (j = 0; j < n; j++, desc++, group++, group_offset = 0) {
 			lock = nilfs_mdt_bgl_lock(inode, group);
-			if (nilfs_palloc_group_desc_nfrees(desc, lock) > 0) {
-				ret = nilfs_palloc_get_bitmap_block(
-					inode, group, 1, &bitmap_bh);
-				if (ret < 0)
-					goto out_desc;
-				bitmap_kaddr = kmap(bitmap_bh->b_page);
-				bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
-				pos = nilfs_palloc_find_available_slot(
-					bitmap, group_offset,
-					entries_per_group, lock);
-				if (pos >= 0) {
-					/* found a free entry */
-					nilfs_palloc_group_desc_add_entries(
-						desc, lock, -1);
-					req->pr_entry_nr =
-						entries_per_group * group + pos;
-					kunmap(desc_bh->b_page);
-					kunmap(bitmap_bh->b_page);
-
-					req->pr_desc_bh = desc_bh;
-					req->pr_bitmap_bh = bitmap_bh;
-					return 0;
-				}
-				kunmap(bitmap_bh->b_page);
-				brelse(bitmap_bh);
+			if (nilfs_palloc_group_desc_nfrees(desc, lock) == 0)
+				continue;
+
+			kunmap_local(desc_kaddr);
+			ret = nilfs_palloc_get_bitmap_block(inode, group, 1,
+							    &bitmap_bh);
+			if (unlikely(ret < 0)) {
+				brelse(desc_bh);
+				return ret;
 			}
 
-			group_offset = 0;
+			desc_kaddr = kmap_local_page(desc_bh->b_page);
+			desc = nilfs_palloc_block_get_group_desc(
+				inode, group, desc_bh, desc_kaddr);
+
+			bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
+			bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
+			pos = nilfs_palloc_find_available_slot(
+				bitmap, group_offset, entries_per_group, lock);
+			kunmap_local(bitmap_kaddr);
+			if (pos >= 0)
+				goto found;
+
+			brelse(bitmap_bh);
 		}
 
-		kunmap(desc_bh->b_page);
+		kunmap_local(desc_kaddr);
 		brelse(desc_bh);
 	}
 
 	/* no entries left */
 	return -ENOSPC;
 
- out_desc:
-	kunmap(desc_bh->b_page);
-	brelse(desc_bh);
-	return ret;
+found:
+	/* found a free entry */
+	nilfs_palloc_group_desc_add_entries(desc, lock, -1);
+	req->pr_entry_nr = entries_per_group * group + pos;
+	kunmap_local(desc_kaddr);
+
+	req->pr_desc_bh = desc_bh;
+	req->pr_bitmap_bh = bitmap_bh;
+	return 0;
 }
 
 /**
@@ -606,10 +607,10 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	spinlock_t *lock;
 
 	group = nilfs_palloc_group(inode, req->pr_entry_nr, &group_offset);
-	desc_kaddr = kmap(req->pr_desc_bh->b_page);
+	desc_kaddr = kmap_local_page(req->pr_desc_bh->b_page);
 	desc = nilfs_palloc_block_get_group_desc(inode, group,
 						 req->pr_desc_bh, desc_kaddr);
-	bitmap_kaddr = kmap(req->pr_bitmap_bh->b_page);
+	bitmap_kaddr = kmap_local_page(req->pr_bitmap_bh->b_page);
 	bitmap = bitmap_kaddr + bh_offset(req->pr_bitmap_bh);
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
@@ -621,8 +622,8 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
-	kunmap(req->pr_bitmap_bh->b_page);
-	kunmap(req->pr_desc_bh->b_page);
+	kunmap_local(bitmap_kaddr);
+	kunmap_local(desc_kaddr);
 
 	mark_buffer_dirty(req->pr_desc_bh);
 	mark_buffer_dirty(req->pr_bitmap_bh);
@@ -647,10 +648,10 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	spinlock_t *lock;
 
 	group = nilfs_palloc_group(inode, req->pr_entry_nr, &group_offset);
-	desc_kaddr = kmap(req->pr_desc_bh->b_page);
+	desc_kaddr = kmap_local_page(req->pr_desc_bh->b_page);
 	desc = nilfs_palloc_block_get_group_desc(inode, group,
 						 req->pr_desc_bh, desc_kaddr);
-	bitmap_kaddr = kmap(req->pr_bitmap_bh->b_page);
+	bitmap_kaddr = kmap_local_page(req->pr_bitmap_bh->b_page);
 	bitmap = bitmap_kaddr + bh_offset(req->pr_bitmap_bh);
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
@@ -662,8 +663,8 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
-	kunmap(req->pr_bitmap_bh->b_page);
-	kunmap(req->pr_desc_bh->b_page);
+	kunmap_local(bitmap_kaddr);
+	kunmap_local(desc_kaddr);
 
 	brelse(req->pr_bitmap_bh);
 	brelse(req->pr_desc_bh);
@@ -755,7 +756,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		/* Get the first entry number of the group */
 		group_min_nr = (__u64)group * epg;
 
-		bitmap_kaddr = kmap(bitmap_bh->b_page);
+		bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
 		bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
 		lock = nilfs_mdt_bgl_lock(inode, group);
 
@@ -801,7 +802,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			entry_start = rounddown(group_offset, epb);
 		} while (true);
 
-		kunmap(bitmap_bh->b_page);
+		kunmap_local(bitmap_kaddr);
 		mark_buffer_dirty(bitmap_bh);
 		brelse(bitmap_bh);
 
@@ -815,11 +816,11 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 					   inode->i_ino);
 		}
 
-		desc_kaddr = kmap_atomic(desc_bh->b_page);
+		desc_kaddr = kmap_local_page(desc_bh->b_page);
 		desc = nilfs_palloc_block_get_group_desc(
 			inode, group, desc_bh, desc_kaddr);
 		nfree = nilfs_palloc_group_desc_add_entries(desc, lock, n);
-		kunmap_atomic(desc_kaddr);
+		kunmap_local(desc_kaddr);
 		mark_buffer_dirty(desc_bh);
 		nilfs_mdt_mark_dirty(inode);
 		brelse(desc_bh);
-- 
2.34.1


