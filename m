Return-Path: <linux-kernel+bounces-33135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6F83650E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F381C250C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCD3FE42;
	Mon, 22 Jan 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpV+HH09"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6283FE26;
	Mon, 22 Jan 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932171; cv=none; b=MPDuAhDhc+ba9WIjamG1As012cqX/BwT1x/ONspEJNsOW/wUBdw9SgE0HYKwWWqxFabt6UOC8LbyJ9XL782cPzd1JK/2gfbtEP0JVqT9/WAJX9gyRZacJHzXRUBVG/eW4AEH5rYdHiUh+nXHzbU77R3tZ2wiq4mAdTyfrtSshPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932171; c=relaxed/simple;
	bh=abVJlLCiIaNc5QIF/gaRMd8qQILBr2IIg2RhhVvxzXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7+Y0WwDEQpr6geIXgIBGzoTxSE4Rr4zvFRdjuzUsIkcfK7rE8OfFSqQE7GVPzKNNJeTow0hVnm3N1TjR081akkfB82XsMpwoh+2Hw6fNt0sEKnvVv7jdWurDiJ7EqAzX4HQwPJMyL1b3r5DKb/Y5O0TMz7kgb+gMhRBiq0qOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpV+HH09; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dbda9a4facso537883b3a.3;
        Mon, 22 Jan 2024 06:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932169; x=1706536969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx6Eqp/Z/8D4++HfhzHbL5OppGmVQ8YzvKDGo+VO4iI=;
        b=gpV+HH09eBpA25ybrWKaXM5fSZVcWrl2TM90eoffxD2WWqRBezDzjdmmBR5RedL1es
         2bFJxAbnwoMtrxqtNxLlRICIe9gTynXGaQKPbUqDtw6G8yGl+WBPiJ97oEDwcyyjQuo/
         Iutl0kW9xFJQcEmfYrTBG4d6Ppsdci/mpxZi8ObqZURGMGjN4z9V+bEw76Yk+gcNnRpT
         qL5/830OGxx9nGlvHtGh0OtZOhLTyu90by2uQoxfydSOjfilr02WSRMUySyvIY1l7SmC
         uyKFl8CWzOufBoX50/1Lg+39dqJXdtBWNcd1+ZB64fMJrY4QlX2IdDo38m2H+parVwu8
         jujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932169; x=1706536969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx6Eqp/Z/8D4++HfhzHbL5OppGmVQ8YzvKDGo+VO4iI=;
        b=Srtk18scNMSu/clojzYN20nlPc3myUh79UFPM9mNSdM195SfP3uGIlhaz/wz96G0pT
         kJ88GtD11LoivjWakWbUWvoPt8rT6s4FDWoUhUcc877T5NYb5IGHO2a80OeX7sd2fHkp
         1bobrlZq3xHm0aEwxWFO2TRV3oOfAV0dIY32iS0OfoEZXhlCXHQ1nV2rREoLR3dfckXO
         R1PRlW69b+UxmDmZnnpO0mV2quKdShwaVUcXW1Gys+pne1MzXnVs01BEQ9C/bMQNNRD5
         NsE9KszxP3O/7dzmoKoOUojIvp+DBIuq5zKLttgq3AtX/wuxbbkz4fdIC/cEmfahfUew
         XLjg==
X-Gm-Message-State: AOJu0YxYMX4mKCHKMJM1UTowerM/fLHFY+RMYizNwg7jdSJ3dA3whXI+
	0FiIKHBs79VbIpBoxfep70/kNcJP7cQy8ERrathVvi9AwYn8Y01ntzfu4E+5
X-Google-Smtp-Source: AGHT+IH28SyCCmeX1mMxLVFBci0lEXhYZBfSbSirTFk1cxXOUAjRIM5vpw7thBHbgH0A+4Wm8r651w==
X-Received: by 2002:a05:6a20:92a3:b0:19a:46b8:fd1e with SMTP id q35-20020a056a2092a300b0019a46b8fd1emr1461254pzg.43.1705932169128;
        Mon, 22 Jan 2024 06:02:49 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:47 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] nilfs2: convert cpfile to use kmap_local
Date: Mon, 22 Jan 2024 23:02:02 +0900
Message-Id: <20240122140202.6950-16-konishi.ryusuke@gmail.com>
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

Convert all remaining usages of kmap_atomic in cpfile to kmap_local.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index b5bad332d630..2c57132584de 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -460,7 +460,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 			continue;
 		}
 
-		kaddr = kmap_atomic(cp_bh->b_page);
+		kaddr = kmap_local_page(cp_bh->b_page);
 		cp = nilfs_cpfile_block_get_checkpoint(
 			cpfile, cno, cp_bh, kaddr);
 		nicps = 0;
@@ -482,7 +482,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 						cpfile, cp_bh, kaddr, nicps);
 				if (count == 0) {
 					/* make hole */
-					kunmap_atomic(kaddr);
+					kunmap_local(kaddr);
 					brelse(cp_bh);
 					ret =
 					  nilfs_cpfile_delete_checkpoint_block(
@@ -497,18 +497,18 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 			}
 		}
 
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(cp_bh);
 	}
 
 	if (tnicps > 0) {
-		kaddr = kmap_atomic(header_bh->b_page);
+		kaddr = kmap_local_page(header_bh->b_page);
 		header = nilfs_cpfile_block_get_header(cpfile, header_bh,
 						       kaddr);
 		le64_add_cpu(&header->ch_ncheckpoints, -(u64)tnicps);
 		mark_buffer_dirty(header_bh);
 		nilfs_mdt_mark_dirty(cpfile);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 	}
 
 	brelse(header_bh);
@@ -560,7 +560,7 @@ static ssize_t nilfs_cpfile_do_get_cpinfo(struct inode *cpfile, __u64 *cnop,
 		}
 		ncps = nilfs_cpfile_checkpoints_in_block(cpfile, cno, cur_cno);
 
-		kaddr = kmap_atomic(bh->b_page);
+		kaddr = kmap_local_page(bh->b_page);
 		cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, bh, kaddr);
 		for (i = 0; i < ncps && n < nci; i++, cp = (void *)cp + cpsz) {
 			if (!nilfs_checkpoint_invalid(cp)) {
@@ -570,7 +570,7 @@ static ssize_t nilfs_cpfile_do_get_cpinfo(struct inode *cpfile, __u64 *cnop,
 				n++;
 			}
 		}
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(bh);
 	}
 
@@ -604,10 +604,10 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 		ret = nilfs_cpfile_get_header_block(cpfile, &bh);
 		if (ret < 0)
 			goto out;
-		kaddr = kmap_atomic(bh->b_page);
+		kaddr = kmap_local_page(bh->b_page);
 		header = nilfs_cpfile_block_get_header(cpfile, bh, kaddr);
 		curr = le64_to_cpu(header->ch_snapshot_list.ssl_next);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(bh);
 		if (curr == 0) {
 			ret = 0;
@@ -625,7 +625,7 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 			ret = 0; /* No snapshots (started from a hole block) */
 		goto out;
 	}
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	while (n < nci) {
 		cp = nilfs_cpfile_block_get_checkpoint(cpfile, curr, bh, kaddr);
 		curr = ~(__u64)0; /* Terminator */
@@ -641,7 +641,7 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 
 		next_blkoff = nilfs_cpfile_get_blkoff(cpfile, next);
 		if (curr_blkoff != next_blkoff) {
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 			brelse(bh);
 			ret = nilfs_cpfile_get_checkpoint_block(cpfile, next,
 								0, &bh);
@@ -649,12 +649,12 @@ static ssize_t nilfs_cpfile_do_get_ssinfo(struct inode *cpfile, __u64 *cnop,
 				WARN_ON(ret == -ENOENT);
 				goto out;
 			}
-			kaddr = kmap_atomic(bh->b_page);
+			kaddr = kmap_local_page(bh->b_page);
 		}
 		curr = next;
 		curr_blkoff = next_blkoff;
 	}
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(bh);
 	*cnop = curr;
 	ret = n;
@@ -763,24 +763,24 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_atomic(cp_bh->b_page);
+	kaddr = kmap_local_page(cp_bh->b_page);
 	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
 	if (nilfs_checkpoint_invalid(cp)) {
 		ret = -ENOENT;
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		goto out_cp;
 	}
 	if (nilfs_checkpoint_snapshot(cp)) {
 		ret = 0;
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		goto out_cp;
 	}
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
 	if (ret < 0)
 		goto out_cp;
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
 	list = &header->ch_snapshot_list;
 	curr_bh = header_bh;
@@ -792,13 +792,13 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 		prev_blkoff = nilfs_cpfile_get_blkoff(cpfile, prev);
 		curr = prev;
 		if (curr_blkoff != prev_blkoff) {
-			kunmap_atomic(kaddr);
+			kunmap_local(kaddr);
 			brelse(curr_bh);
 			ret = nilfs_cpfile_get_checkpoint_block(cpfile, curr,
 								0, &curr_bh);
 			if (ret < 0)
 				goto out_header;
-			kaddr = kmap_atomic(curr_bh->b_page);
+			kaddr = kmap_local_page(curr_bh->b_page);
 		}
 		curr_blkoff = prev_blkoff;
 		cp = nilfs_cpfile_block_get_checkpoint(
@@ -806,7 +806,7 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 		list = &cp->cp_snapshot_list;
 		prev = le64_to_cpu(list->ssl_prev);
 	}
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (prev != 0) {
 		ret = nilfs_cpfile_get_checkpoint_block(cpfile, prev, 0,
@@ -818,29 +818,29 @@ static int nilfs_cpfile_set_snapshot(struct inode *cpfile, __u64 cno)
 		get_bh(prev_bh);
 	}
 
-	kaddr = kmap_atomic(curr_bh->b_page);
+	kaddr = kmap_local_page(curr_bh->b_page);
 	list = nilfs_cpfile_block_get_snapshot_list(
 		cpfile, curr, curr_bh, kaddr);
 	list->ssl_prev = cpu_to_le64(cno);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(cp_bh->b_page);
+	kaddr = kmap_local_page(cp_bh->b_page);
 	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
 	cp->cp_snapshot_list.ssl_next = cpu_to_le64(curr);
 	cp->cp_snapshot_list.ssl_prev = cpu_to_le64(prev);
 	nilfs_checkpoint_set_snapshot(cp);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(prev_bh->b_page);
+	kaddr = kmap_local_page(prev_bh->b_page);
 	list = nilfs_cpfile_block_get_snapshot_list(
 		cpfile, prev, prev_bh, kaddr);
 	list->ssl_next = cpu_to_le64(cno);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
 	le64_add_cpu(&header->ch_nsnapshots, 1);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(prev_bh);
 	mark_buffer_dirty(curr_bh);
@@ -881,23 +881,23 @@ static int nilfs_cpfile_clear_snapshot(struct inode *cpfile, __u64 cno)
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &cp_bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_atomic(cp_bh->b_page);
+	kaddr = kmap_local_page(cp_bh->b_page);
 	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
 	if (nilfs_checkpoint_invalid(cp)) {
 		ret = -ENOENT;
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		goto out_cp;
 	}
 	if (!nilfs_checkpoint_snapshot(cp)) {
 		ret = 0;
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		goto out_cp;
 	}
 
 	list = &cp->cp_snapshot_list;
 	next = le64_to_cpu(list->ssl_next);
 	prev = le64_to_cpu(list->ssl_prev);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
 	if (ret < 0)
@@ -921,29 +921,29 @@ static int nilfs_cpfile_clear_snapshot(struct inode *cpfile, __u64 cno)
 		get_bh(prev_bh);
 	}
 
-	kaddr = kmap_atomic(next_bh->b_page);
+	kaddr = kmap_local_page(next_bh->b_page);
 	list = nilfs_cpfile_block_get_snapshot_list(
 		cpfile, next, next_bh, kaddr);
 	list->ssl_prev = cpu_to_le64(prev);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(prev_bh->b_page);
+	kaddr = kmap_local_page(prev_bh->b_page);
 	list = nilfs_cpfile_block_get_snapshot_list(
 		cpfile, prev, prev_bh, kaddr);
 	list->ssl_next = cpu_to_le64(next);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(cp_bh->b_page);
+	kaddr = kmap_local_page(cp_bh->b_page);
 	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
 	cp->cp_snapshot_list.ssl_next = cpu_to_le64(0);
 	cp->cp_snapshot_list.ssl_prev = cpu_to_le64(0);
 	nilfs_checkpoint_clear_snapshot(cp);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
-	kaddr = kmap_atomic(header_bh->b_page);
+	kaddr = kmap_local_page(header_bh->b_page);
 	header = nilfs_cpfile_block_get_header(cpfile, header_bh, kaddr);
 	le64_add_cpu(&header->ch_nsnapshots, -1);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(next_bh);
 	mark_buffer_dirty(prev_bh);
@@ -1002,13 +1002,13 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
 	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, 0, &bh);
 	if (ret < 0)
 		goto out;
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, bh, kaddr);
 	if (nilfs_checkpoint_invalid(cp))
 		ret = -ENOENT;
 	else
 		ret = nilfs_checkpoint_snapshot(cp);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(bh);
 
  out:
@@ -1085,12 +1085,12 @@ int nilfs_cpfile_get_stat(struct inode *cpfile, struct nilfs_cpstat *cpstat)
 	ret = nilfs_cpfile_get_header_block(cpfile, &bh);
 	if (ret < 0)
 		goto out_sem;
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	header = nilfs_cpfile_block_get_header(cpfile, bh, kaddr);
 	cpstat->cs_cno = nilfs_mdt_cno(cpfile);
 	cpstat->cs_ncps = le64_to_cpu(header->ch_ncheckpoints);
 	cpstat->cs_nsss = le64_to_cpu(header->ch_nsnapshots);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(bh);
 
  out_sem:
-- 
2.34.1


