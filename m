Return-Path: <linux-kernel+bounces-73698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4C85C617
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E7928365C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD571509BC;
	Tue, 20 Feb 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCo4DI85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB98612D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462316; cv=none; b=RkmTip05ePXsqqYMCQLuVG/O1a5+HvX870dMcAL7qR63Z8RsbfW0uFnV7dHiXhD1n+j/LZhCC3j+imrlPdd08pGfR02J//9BsoGszg/ToZXf5Fhsfk3U2mISXSD+ZiBudTZ/SupMF6cSRbGP9npS3dVRrKX4ZajV6Ewf5UDjL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462316; c=relaxed/simple;
	bh=WX3M+NK2w1RQOB+/tfNTaya3uy5Fw2qPkTlrIq3dzzQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJH13QTV28iWDjieosKXeJor9hIh3fXUlbcKSqtRWzyiJA28tTbU06W1XuMQD+3SS2FJa2j8tjnXd362oUfqZW9LpV6B/d6SiL56GNjZOwglOM8eWRIyKlpsghn7ew86AUorEV+c9cEBVUdFSNfvYKwjN8Q7FWqbMMclfJ6mbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCo4DI85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68CFC433F1;
	Tue, 20 Feb 2024 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708462315;
	bh=WX3M+NK2w1RQOB+/tfNTaya3uy5Fw2qPkTlrIq3dzzQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=nCo4DI85BHJ69QR3bY5sKbV3Xgu6NRQANtmhWSnfFBBbzqPCmF+UUrjQGWqLV3+R7
	 O+Gz226ByOpb3xBylqqA9I93XQ25BONUY5/UNX1Jwj8yX4iyzPXTwutmbqaRNhhDRV
	 Vazi7ElC4/D/zKGNqlX/TKbkUjUn3+L0fUUHLzR27HiKSzwJ+4I8iGlemDtH1s7WFa
	 UXPk8SB09d867g0wBQXUEBONMb6XJG6DDaSzpin7jrr1aeOCYIREbSL7OirGLLnH77
	 BOa0CgbIljp+86fqdnv8ZW9BpypXRd6xpo0wzATWCZqR+T3ulxr+Xai4gDeKPGc4oX
	 bwIiQ17PgaAlg==
Date: Tue, 20 Feb 2024 12:51:54 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: kill heap-based allocation
Message-ID: <ZdUQ6uKYyfzn5Fhv@google.com>
References: <20240207164620.1536038-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207164620.1536038-1-jaegeuk@kernel.org>

No one uses this feature. Let's kill it.

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - keep mount options but give warnings instead

 Documentation/filesystems/f2fs.rst |  4 +--
 fs/f2fs/gc.c                       |  5 ++-
 fs/f2fs/segment.c                  | 54 ++++--------------------------
 fs/f2fs/segment.h                  | 10 ------
 fs/f2fs/super.c                    |  9 +----
 5 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 9ac5083dae8e..c30a800604fd 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -126,9 +126,7 @@ norecovery		 Disable the roll-forward recovery routine, mounted read-
 discard/nodiscard	 Enable/disable real-time discard in f2fs, if discard is
 			 enabled, f2fs will issue discard/TRIM commands when a
 			 segment is cleaned.
-no_heap			 Disable heap-style segment allocation which finds free
-			 segments for data from the beginning of main area, while
-			 for node from the end of main area.
+no_heap			 Deprecated.
 nouser_xattr		 Disable Extended User Attributes. Note: xattr is enabled
 			 by default if CONFIG_F2FS_FS_XATTR is selected.
 noacl			 Disable POSIX Access Control List. Note: acl is enabled
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 501b93b45b6c..a089a938355b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -280,12 +280,11 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
-	/* let's select beginning hot/small space first in no_heap mode*/
+	/* let's select beginning hot/small space first. */
 	if (f2fs_need_rand_seg(sbi))
 		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
 						SEGS_PER_SEC(sbi));
-	else if (test_opt(sbi, NOHEAP) &&
-		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
+	else if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		p->offset = 0;
 	else
 		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 94c4f7b16c19..09af17af4e7a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2634,16 +2634,14 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
  * This function should be returned with success, otherwise BUG
  */
 static void get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir)
+			unsigned int *newseg, bool new_sec)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno, secno, zoneno;
 	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
 	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
 	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
-	unsigned int left_start = hint;
 	bool init = true;
-	int go_left = 0;
 	int i;
 
 	spin_lock(&free_i->segmap_lock);
@@ -2657,30 +2655,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
-		if (dir == ALLOC_RIGHT) {
-			secno = find_first_zero_bit(free_i->free_secmap,
+		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
-			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
-		} else {
-			go_left = 1;
-			left_start = hint - 1;
-		}
-	}
-	if (go_left == 0)
-		goto skip_left;
-
-	while (test_bit(left_start, free_i->free_secmap)) {
-		if (left_start > 0) {
-			left_start--;
-			continue;
-		}
-		left_start = find_first_zero_bit(free_i->free_secmap,
-							MAIN_SECS(sbi));
-		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
-		break;
+		f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
 	}
-	secno = left_start;
-skip_left:
 	segno = GET_SEG_FROM_SEC(sbi, secno);
 	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
 
@@ -2691,21 +2669,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		goto got_it;
 	if (zoneno == old_zoneno)
 		goto got_it;
-	if (dir == ALLOC_LEFT) {
-		if (!go_left && zoneno + 1 >= total_zones)
-			goto got_it;
-		if (go_left && zoneno == 0)
-			goto got_it;
-	}
 	for (i = 0; i < NR_CURSEG_TYPE; i++)
 		if (CURSEG_I(sbi, i)->zone == zoneno)
 			break;
 
 	if (i < NR_CURSEG_TYPE) {
 		/* zone is in user, try another */
-		if (go_left)
-			hint = zoneno * sbi->secs_per_zone - 1;
-		else if (zoneno + 1 >= total_zones)
+		if (zoneno + 1 >= total_zones)
 			hint = 0;
 		else
 			hint = (zoneno + 1) * sbi->secs_per_zone;
@@ -2763,8 +2733,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
 
-	if (test_opt(sbi, NOHEAP) &&
-		(seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type)))
+	if (seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
@@ -2784,21 +2753,12 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	unsigned short seg_type = curseg->seg_type;
 	unsigned int segno = curseg->segno;
-	int dir = ALLOC_LEFT;
 
 	if (curseg->inited)
-		write_sum_page(sbi, curseg->sum_blk,
-				GET_SUM_BLOCK(sbi, segno));
-	if (seg_type == CURSEG_WARM_DATA || seg_type == CURSEG_COLD_DATA)
-		dir = ALLOC_RIGHT;
-
-	if (test_opt(sbi, NOHEAP))
-		dir = ALLOC_RIGHT;
-
+		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
 	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec, dir);
+	get_new_segment(sbi, &segno, new_sec);
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 6fadfb634aac..0f1a5210c163 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -131,16 +131,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define SECTOR_TO_BLOCK(sectors)					\
 	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
 
-/*
- * indicate a block allocation direction: RIGHT and LEFT.
- * RIGHT means allocating new sections towards the end of volume.
- * LEFT means the opposite direction.
- */
-enum {
-	ALLOC_RIGHT = 0,
-	ALLOC_LEFT
-};
-
 /*
  * In the victim_sel_policy->alloc_mode, there are three block allocation modes.
  * LFS writes data sequentially with cleaning operations.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5aaf44c4698b..916e82e9c307 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -733,10 +733,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			clear_opt(sbi, DISCARD);
 			break;
 		case Opt_noheap:
-			set_opt(sbi, NOHEAP);
-			break;
 		case Opt_heap:
-			clear_opt(sbi, NOHEAP);
+			f2fs_warn(sbi, "heap/no_heap options were deprecated");
 			break;
 #ifdef CONFIG_F2FS_FS_XATTR
 		case Opt_user_xattr:
@@ -1962,10 +1960,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	} else {
 		seq_puts(seq, ",nodiscard");
 	}
-	if (test_opt(sbi, NOHEAP))
-		seq_puts(seq, ",no_heap");
-	else
-		seq_puts(seq, ",heap");
 #ifdef CONFIG_F2FS_FS_XATTR
 	if (test_opt(sbi, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
@@ -2142,7 +2136,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-	set_opt(sbi, NOHEAP);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-- 
2.44.0.rc0.258.g7320e95886-goog


