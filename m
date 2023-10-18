Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF37CEB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJRWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:39:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63DAB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:39:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af604c3f8fso4631571b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697668769; x=1698273569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FA/44rrrKJfOSdSAs/vXRSMvSX8/gNGQepCR0pRiqOs=;
        b=aJaF+eSul3Pp7ZyjBYsYxateek7QHU69Cken8alPDYzDGgXOWqkx39xlCzABDkHScG
         Zuljc70Hh+GAaVfdX4S51Nj7tY8afdMmt8Zsf0eqlSbGs5JJp6jOiUU39SQ40KZzr901
         PBv8SrUKGUMYkhjY22Tp8cWlvmnYA9g0oySEMg4hcDpV4v3NcOWlmOLNEKDmFOO98lbP
         tB0wxO+V/He0sQwvdYv+gvZOCutL/mJ3gp5hvRWWjeIj+osp/pkzr1QUFfofpTfbLRfh
         jaBBy05DtUQW4w/hdt2SyXFynl6aWtLM1zrbKSgbXamk7T+hI5YQAeTB44Ylxs/9o1v4
         tovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668769; x=1698273569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA/44rrrKJfOSdSAs/vXRSMvSX8/gNGQepCR0pRiqOs=;
        b=gbjat5H3uFQGSquOmW2rirg7rsANZcAiFL9qOFfCDG42fMO7ITwNAJiJpB8wh8Ox+x
         /7+K8zq3aDl2qWlDQWePGxYRBb+Y/UJEWahipQaP8Y9XWAhzvEHHAIqlbHldJkX7gHiG
         oe809OUpYyj7lNw7DCWB13fKBgM7tNk1eL9CqVy/5N34oL7o0gXpHGOVuYGeeq0DcaQe
         1p0uNuFhiBe5sLC0AEZjMyHQ/j5HZsVCCjRzN33apxBo4ni6TBvBZXlq0wM57qfAn4c3
         wh17w5ssTqw4hBDB5mz+TaL+aEGv2q5ZfEdV4CFNLk9LyWNNNihG76UBnoAoOJZV9Tjq
         ug4Q==
X-Gm-Message-State: AOJu0YydfxtTAGii/lXwVCT8sr9dR1J+RTg5EcSJaddMrbApAo5O0Lvq
        J/i6BlNWqoO7IPeV95ornYc9liu1iCw=
X-Google-Smtp-Source: AGHT+IEySXzMt1s+Xln0avpHebs85AOOUvLjr83cUrLOPBHev+lYE//fluWo09G9sH9iRGGy1+/C+A==
X-Received: by 2002:a05:6808:282:b0:3ae:a81:55ba with SMTP id z2-20020a056808028200b003ae0a8155bamr600470oic.22.1697668769302;
        Wed, 18 Oct 2023 15:39:29 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1664:8fb8:8a75:8d07])
        by smtp.gmail.com with ESMTPSA id m10-20020a056a00080a00b00690ca4356f1sm3860602pfk.198.2023.10.18.15.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:39:28 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: make six open zone check resilient
Date:   Wed, 18 Oct 2023 15:39:25 -0700
Message-ID: <20231018223925.2135987-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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
 fsck/fsck.c         | 87 +++++++++++++++++++--------------------------
 include/f2fs_fs.h   |  1 +
 lib/libf2fs_zoned.c | 28 +++++++++++++++
 3 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 99cface..890b536 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2587,10 +2587,9 @@ static int check_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
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
@@ -2624,49 +2623,28 @@ static int check_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
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
 
@@ -3155,10 +3133,8 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
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
@@ -3174,14 +3150,6 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
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
@@ -3217,10 +3185,27 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
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
2.42.0.655.g421f12c284-goog

