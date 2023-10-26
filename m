Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122FC7D8C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJZXxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:53:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0281B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:53:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2800dfa0dd6so17474a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698364414; x=1698969214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPUJt5LRLkoFKrQkmKdp/52n5DApmDpEURBE+GDif+k=;
        b=U1uVzOHLgjnaMObqCQUAxFH44jDScFZYnGqiN9owq64G+lCoFCImC6FqPkGDYoER9/
         1fZlTBlOTH0vLAKjYtWuty1qD3j4C7ubos5W623nj3oDWzVq9YCjeBJDKDDLJeBQqYfB
         DIpJJo/lWlYpMhBqtnT6UdTl+ICT/tCFbm8tHGqrJBeSGexShYa0yGa1PBvm4eaXyvYK
         dz/4uhe8J2AzQ+YbgYu/tr/MDrZ+5l8GOMZAV8yEeqr5seyTbYHdJFKs8Tygjq/tHFvM
         VVgo+rLaJqOw8uuLGpKATuo6XWZbZOabL89iEmiceAMrMvv8mxcurfbCoRiKY9BOPfhM
         PQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364414; x=1698969214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPUJt5LRLkoFKrQkmKdp/52n5DApmDpEURBE+GDif+k=;
        b=Dt+ghAq4VKys2f7BPqA6xN6c59Jq+758q2qogPPG+os0Ghk+tdmmH0kBEL5bEsXaow
         IiCUowLVHVusjCN8Dlm/3Hk5WC6vwhcYijl2ZjQSdxB4zt3WjKZ6pysXdi6UdE917cHe
         u1xCde9sIsRb6198gf3BWGS4vlMxybmdhQ+QVydjpqMBJ3Y+OQ2K+1zQshRbcFNXB9yZ
         RBkF91Hxub8Jcmnd0ZFsIsJMUZKeVid65s1liLvSwTs2Su07/uSbA+sLIjOI0tWHL1gz
         SbntRAgIPp64JKUGTf7GIusiTsoN4qR6/MItNP4c5alht1Q9uUk1iUHXwYi+0dRmxFeA
         JjCw==
X-Gm-Message-State: AOJu0Yyr03BGpdU0DyOxxCxZ1d0viEs3s16TWItQUQi1a7qQekrbfkxe
        66/4C41yjjbEooHHYA/AcOd8zHqt9Vc=
X-Google-Smtp-Source: AGHT+IFLnUzRReWC4Vcbn/QeHEdJNZLFaU8EP32LJnB4+aXTtBHRKUxLHnL3IiJFDRCmJxi2XzOA0A==
X-Received: by 2002:a17:90a:d388:b0:27d:515d:94f0 with SMTP id q8-20020a17090ad38800b0027d515d94f0mr974677pju.24.1698364413651;
        Thu, 26 Oct 2023 16:53:33 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:85a4:5aef:279b:f31e])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a750100b0027ce34334f5sm123657pjk.37.2023.10.26.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:53:33 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs-tools: make six open zone check resilient
Date:   Thu, 26 Oct 2023 16:53:16 -0700
Message-ID: <20231026235316.1189315-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We need to make sure to finish all the zones except six open zones. In
a case of that the previous mount wasn't successfully unmounted, we have
to change all the current segments.

Signed-off-by: Daeho Jeong <daehojeong@google.com>

---
v2: skip write pointer check after fixing it.
---
 fsck/fsck.c         | 107 +++++++++++++++++++-------------------------
 include/f2fs_fs.h   |   1 +
 lib/libf2fs_zoned.c |  28 ++++++++++++
 3 files changed, 75 insertions(+), 61 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index dc8e282..46cc2e5 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2600,10 +2600,9 @@ static int check_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct blk_zone blkz;
-	block_t cs_block, wp_block, zone_last_vblock;
+	block_t cs_block, wp_block;
 	uint64_t cs_sector, wp_sector;
 	int i, ret;
-	unsigned int zone_segno;
 	int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 
 	/* get the device the curseg points to */
@@ -2637,49 +2636,28 @@ static int check_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		(blk_zone_wp_sector(&blkz) >> log_sectors_per_block);
 	wp_sector = blk_zone_wp_sector(&blkz);
 
-	if (cs_sector == wp_sector)
-		return 0;
-
-	if (cs_sector > wp_sector) {
+	if (cs_sector == wp_sector) {
+		if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG))
+			return 0;
+		MSG(0, "Correct write pointer. But, we can't trust it, "
+		    "since the previous mount wasn't safely unmounted: "
+		    "curseg %d[0x%x,0x%x]\n",
+		    type, curseg->segno, curseg->next_blkoff);
+	} else if (cs_sector > wp_sector) {
 		MSG(0, "Inconsistent write pointer with curseg %d: "
 		    "curseg %d[0x%x,0x%x] > wp[0x%x,0x%x]\n",
 		    type, type, curseg->segno, curseg->next_blkoff,
+		    GET_SEGNO(sbi, wp_block),
+		    OFFSET_IN_SEG(sbi, wp_block));
+		if (!c.fix_on)
+			fsck->chk.wp_inconsistent_zones++;
+	} else {
+		MSG(0, "Write pointer goes advance from curseg %d: "
+		    "curseg %d[0x%x,0x%x] wp[0x%x,0x%x]\n",
+		    type, type, curseg->segno, curseg->next_blkoff,
 		    GET_SEGNO(sbi, wp_block), OFFSET_IN_SEG(sbi, wp_block));
-		fsck->chk.wp_inconsistent_zones++;
-		return -EINVAL;
-	}
-
-	MSG(0, "Write pointer goes advance from curseg %d: "
-	    "curseg %d[0x%x,0x%x] wp[0x%x,0x%x]\n",
-	    type, type, curseg->segno, curseg->next_blkoff,
-	    GET_SEGNO(sbi, wp_block), OFFSET_IN_SEG(sbi, wp_block));
-
-	zone_segno = GET_SEG_FROM_SEC(sbi,
-				      GET_SEC_FROM_SEG(sbi, curseg->segno));
-	zone_last_vblock = START_BLOCK(sbi, zone_segno) +
-		last_vblk_off_in_zone(sbi, zone_segno);
-
-	/*
-	 * If valid blocks exist between the curseg position and the write
-	 * pointer, they are fsync data. This is not an error to fix. Leave it
-	 * for kernel to recover later.
-	 * If valid blocks exist between the curseg's zone start and the curseg
-	 * position, or if there is no valid block in the curseg's zone, fix
-	 * the inconsistency between the curseg and the writ pointer.
-	 * Of Note is that if there is no valid block in the curseg's zone,
-	 * last_vblk_off_in_zone() returns -1 and zone_last_vblock is always
-	 * smaller than cs_block.
-	 */
-	if (cs_block <= zone_last_vblock && zone_last_vblock < wp_block) {
-		MSG(0, "Curseg has fsync data: curseg %d[0x%x,0x%x] "
-		    "last valid block in zone[0x%x,0x%x]\n",
-		    type, curseg->segno, curseg->next_blkoff,
-		    GET_SEGNO(sbi, zone_last_vblock),
-		    OFFSET_IN_SEG(sbi, zone_last_vblock));
-		return 0;
 	}
 
-	fsck->chk.wp_inconsistent_zones++;
 	return -EINVAL;
 }
 
@@ -2693,7 +2671,7 @@ static int check_curseg_write_pointer(struct f2fs_sb_info *UNUSED(sbi),
 
 #endif
 
-int check_curseg_offset(struct f2fs_sb_info *sbi, int type)
+int check_curseg_offset(struct f2fs_sb_info *sbi, int type, bool check_wp)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2727,30 +2705,30 @@ int check_curseg_offset(struct f2fs_sb_info *sbi, int type)
 		}
 	}
 
-	if (c.zoned_model == F2FS_ZONED_HM)
+	if (check_wp && c.zoned_model == F2FS_ZONED_HM)
 		return check_curseg_write_pointer(sbi, type);
 
 	return 0;
 }
 
-int check_curseg_offsets(struct f2fs_sb_info *sbi)
+int check_curseg_offsets(struct f2fs_sb_info *sbi, bool check_wp)
 {
 	int i, ret;
 
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
-		ret = check_curseg_offset(sbi, i);
+		ret = check_curseg_offset(sbi, i, check_wp);
 		if (ret)
 			return ret;
 	}
 	return 0;
 }
 
-static void fix_curseg_info(struct f2fs_sb_info *sbi)
+static void fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
 {
 	int i, need_update = 0;
 
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
-		if (check_curseg_offset(sbi, i)) {
+		if (check_curseg_offset(sbi, i, check_wp)) {
 			update_curseg_info(sbi, i);
 			need_update = 1;
 		}
@@ -3219,10 +3197,8 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	block_t zone_block, wp_block, wp_blkoff;
 	unsigned int zone_segno, wp_segno;
-	struct curseg_info *cs;
-	int cs_index, ret, last_valid_blkoff;
+	int ret, last_valid_blkoff;
 	int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
-	unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
 
 	if (blk_zone_conv(blkz))
 		return 0;
@@ -3238,14 +3214,6 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 	wp_segno = GET_SEGNO(sbi, wp_block);
 	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
 
-	/* if a curseg points to the zone, skip the check */
-	for (cs_index = 0; cs_index < NO_CHECK_TYPE; cs_index++) {
-		cs = &SM_I(sbi)->curseg_array[cs_index];
-		if (zone_segno <= cs->segno &&
-		    cs->segno < zone_segno + segs_per_zone)
-			return 0;
-	}
-
 	last_valid_blkoff = last_vblk_off_in_zone(sbi, zone_segno);
 
 	/*
@@ -3281,10 +3249,27 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 	if (last_valid_blkoff + zone_block > wp_block) {
 		MSG(0, "Unexpected invalid write pointer: wp[0x%x,0x%x]\n",
 		    wp_segno, wp_blkoff);
+		if (!c.fix_on)
+			fsck->chk.wp_inconsistent_zones++;
+	}
+
+	if (!c.fix_on)
 		return 0;
+
+	ret = f2fs_finish_zone(wpd->dev_index, blkz);
+	if (ret) {
+		u64 fill_sects = blk_zone_length(blkz) -
+			(blk_zone_wp_sector(blkz) - blk_zone_sector(blkz));
+		printf("[FSCK] Finishing zone failed: %s\n", dev->path);
+		ret = dev_fill(NULL, wp_block * F2FS_BLKSIZE,
+			(fill_sects >> log_sectors_per_block) * F2FS_BLKSIZE);
+		if (ret)
+			printf("[FSCK] Fill up zone failed: %s\n", dev->path);
 	}
 
-	return 0;
+	if (!ret)
+		fsck->chk.wp_fixed = 1;
+	return ret;
 }
 
 static void fix_wp_sit_alignment(struct f2fs_sb_info *sbi)
@@ -3330,8 +3315,8 @@ void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
 	if (c.zoned_model != F2FS_ZONED_HM)
 		return;
 
-	if (check_curseg_offsets(sbi) && c.fix_on) {
-		fix_curseg_info(sbi);
+	if (check_curseg_offsets(sbi, true) && c.fix_on) {
+		fix_curseg_info(sbi, true);
 		fsck->chk.wp_fixed = 1;
 	}
 
@@ -3525,7 +3510,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	printf("[FSCK] next block offset is free                     ");
-	if (check_curseg_offsets(sbi) == 0) {
+	if (check_curseg_offsets(sbi, false) == 0) {
 		printf(" [Ok..]\n");
 	} else {
 		printf(" [Fail]\n");
@@ -3578,7 +3563,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			fix_nat_entries(sbi);
 			rewrite_sit_area_bitmap(sbi);
 			fix_wp_sit_alignment(sbi);
-			fix_curseg_info(sbi);
+			fix_curseg_info(sbi, false);
 			fix_checksum(sbi);
 			fix_checkpoints(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 772a6a5..d94e447 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1749,6 +1749,7 @@ extern int f2fs_report_zones(int, report_zones_cb_t *, void *);
 extern int f2fs_check_zones(int);
 int f2fs_reset_zone(int, void *);
 extern int f2fs_reset_zones(int);
+int f2fs_finish_zone(int i, void *blkzone);
 extern uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb);
 
 #define SIZE_ALIGN(val, size)	(((val) + (size) - 1) / (size))
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 2ab2497..ba9286f 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -502,6 +502,28 @@ out:
 	return ret;
 }
 
+int f2fs_finish_zone(int i, void *blkzone)
+{
+	struct blk_zone *blkz = (struct blk_zone *)blkzone;
+	struct device_info *dev = c.devices + i;
+	struct blk_zone_range range;
+	int ret;
+
+	if (!blk_zone_seq(blkz) || blk_zone_empty(blkz))
+		return 0;
+
+	/* Non empty sequential zone: finish */
+	range.sector = blk_zone_sector(blkz);
+	range.nr_sectors = blk_zone_length(blkz);
+	ret = ioctl(dev->fd, BLKFINISHZONE, &range);
+	if (ret != 0) {
+		ret = -errno;
+		ERR_MSG("ioctl BLKFINISHZONE failed: errno=%d\n", errno);
+	}
+
+	return ret;
+}
+
 uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
 {
 #ifdef HAVE_BLK_ZONE_REP_V2
@@ -588,6 +610,12 @@ int f2fs_reset_zones(int i)
 	return -1;
 }
 
+int f2fs_finish_zone(int i, void *UNUSED(blkzone))
+{
+	ERR_MSG("%d: Unsupported zoned block device\n", i);
+	return -1;
+}
+
 uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
 {
 	return get_sb(segment_count_main);
-- 
2.42.0.820.g83a721a137-goog

