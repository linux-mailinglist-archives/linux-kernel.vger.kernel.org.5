Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B237C04B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJJTgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjJJTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:36:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50CC9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:36:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c888b3a25aso38318635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696966591; x=1697571391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INY/SzLXsAM+QGsHgo0WCQKlaTJNpU+Xp7b/wSnGcRY=;
        b=fUQYTCX46eC8LA5jxNu8a2fC9PSVsQ0tjdACwXgxvAw47FntdDWFXi2m0IamVXIav8
         BaAqX7SGLRCl4guNONr3vPDIG7V93pGvSPYG20ZVtxtLFl3Zy5VLowgZVcMutbBvr9wE
         SxgSHQsSWbNA283DijCdu2/HYaLuX8zQvdYw1LSVG7ov+fF5WshsdN4WLE5ZBJk30k7H
         /0uSqy4mP0+bzNPIAYFQoN0AS5w5kqeOFzMQvbnEfJ1XEVHcwyRbuqUGrjM57pK/XJTt
         bGS7mXNwxgiaV2PyYGd8M7UmLE86HbtdLyldxJi+SyprSg1TFeGPGXRd+Z4g6JxLkhX5
         HqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966591; x=1697571391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INY/SzLXsAM+QGsHgo0WCQKlaTJNpU+Xp7b/wSnGcRY=;
        b=WgK1jfixK3twuYCUPHv//wkTyDUIBWwlJcflPdm0LTsdOLw3mdf4sg69P4EuOxRPnx
         sEbI+0lhEBgFRXMZDwmvylfBj4isCky36rVTYBY7ogB/3Q/OE5eyDTzVY9zvZNNb9KxJ
         Ah/U0HILle4Sw7fqXCtUYPwsMdYgqrcjpmcsYueUotgRVe2qu48BX6kgiHIW+pcQds+W
         Kl04kNo2cC/OJwlGp3HN5V6edBCKIeBpwYb0w+xPx390HoZRWpAd4atP2O/1+8SK4sHj
         DB4AUF1Dsgc3lmvL//HLoWvw7myLa9ZN0aUm/ToggppqxonQ4N1JR9oY+zKshiufK3pw
         3WeQ==
X-Gm-Message-State: AOJu0Yyi3j62IMU14UYzgFgoIk4SNbHRFWcFg+1ErnfajiHSDTHDSXso
        hOyTbZuz1p7u/7H8pyI0fImzto5ia2Y=
X-Google-Smtp-Source: AGHT+IGy6D6GOlaIAhGMMOonaJooiC82u2oFSkvNb9FV19mJHBuMBfhfHgdV9Vw51g2lGIiNd+CZ6A==
X-Received: by 2002:a17:903:22cb:b0:1c4:5e9e:7865 with SMTP id y11-20020a17090322cb00b001c45e9e7865mr19584082plg.0.1696966591381;
        Tue, 10 Oct 2023 12:36:31 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b6de:85b9:6077:28b4])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902c19400b001b890009634sm12142703pld.139.2023.10.10.12.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:36:31 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: clean up zones when not successfully unmounted
Date:   Tue, 10 Oct 2023 12:36:28 -0700
Message-ID: <20231010193628.2629168-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We can't trust write pointers when the previous mount was not
successfully unmounted.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 92 ++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d05b41608fc0..727d016318f9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4910,22 +4910,31 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	}
 
 	/*
-	 * The write pointer matches with the valid blocks or
-	 * already points to the end of the zone.
+	 * When safely unmounted in the previous mount, we can trust write
+	 * pointers. Otherwise, finish zones.
 	 */
-	if ((last_valid_block + 1 == wp_block) ||
-			(zone->wp == zone->start + zone->len))
-		return 0;
-
-	if (last_valid_block + 1 == zone_block) {
+	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 		/*
-		 * If there is no valid block in the zone and if write pointer
-		 * is not at zone start, reset the write pointer.
+		 * The write pointer matches with the valid blocks or
+		 * already points to the end of the zone.
 		 */
-		f2fs_notice(sbi,
-			    "Zone without valid block has non-zero write "
-			    "pointer. Reset the write pointer: wp[0x%x,0x%x]",
-			    wp_segno, wp_blkoff);
+		if ((last_valid_block + 1 == wp_block) ||
+				(zone->wp == zone->start + zone->len))
+			return 0;
+	}
+
+	if (last_valid_block + 1 == zone_block) {
+		if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+			/*
+			 * If there is no valid block in the zone and if write
+			 * pointer is not at zone start, reset the write
+			 * pointer.
+			 */
+			f2fs_notice(sbi,
+			      "Zone without valid block has non-zero write "
+			      "pointer. Reset the write pointer: wp[0x%x,0x%x]",
+			      wp_segno, wp_blkoff);
+		}
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
@@ -4935,18 +4944,20 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 		return ret;
 	}
 
-	/*
-	 * If there are valid blocks and the write pointer doesn't
-	 * match with them, we need to report the inconsistency and
-	 * fill the zone till the end to close the zone. This inconsistency
-	 * does not cause write error because the zone will not be selected
-	 * for write operation until it get discarded.
-	 */
-	f2fs_notice(sbi, "Valid blocks are not aligned with write pointer: "
-		    "valid block[0x%x,0x%x] wp[0x%x,0x%x]",
-		    GET_SEGNO(sbi, last_valid_block),
-		    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
-		    wp_segno, wp_blkoff);
+	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+		/*
+		 * If there are valid blocks and the write pointer doesn't match
+		 * with them, we need to report the inconsistency and fill
+		 * the zone till the end to close the zone. This inconsistency
+		 * does not cause write error because the zone will not be
+		 * selected for write operation until it get discarded.
+		 */
+		f2fs_notice(sbi, "Valid blocks are not aligned with write "
+			    "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x]",
+			    GET_SEGNO(sbi, last_valid_block),
+			    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
+			    wp_segno, wp_blkoff);
+	}
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
@@ -5020,18 +5031,27 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
-	wp_segno = GET_SEGNO(sbi, wp_block);
-	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-	wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
-
-	if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
-		wp_sector_off == 0)
-		return 0;
+	/*
+	 * When safely unmounted in the previous mount, we could use current
+	 * segments. Otherwise, allocate new sections.
+	 */
+	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+		wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
+		wp_segno = GET_SEGNO(sbi, wp_block);
+		wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
+		wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
+
+		if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
+				wp_sector_off == 0)
+			return 0;
 
-	f2fs_notice(sbi, "Unaligned curseg[%d] with write pointer: "
-		    "curseg[0x%x,0x%x] wp[0x%x,0x%x]",
-		    type, cs->segno, cs->next_blkoff, wp_segno, wp_blkoff);
+		f2fs_notice(sbi, "Unaligned curseg[%d] with write pointer: "
+			    "curseg[0x%x,0x%x] wp[0x%x,0x%x]", type, cs->segno,
+			    cs->next_blkoff, wp_segno, wp_blkoff);
+	} else {
+		f2fs_notice(sbi, "Not successfully unmounted in the previous "
+			    "mount");
+	}
 
 	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
 		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
-- 
2.42.0.609.gbb76f46606-goog

