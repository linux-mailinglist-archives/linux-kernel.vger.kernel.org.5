Return-Path: <linux-kernel+bounces-82423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049C868402
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83FD287446
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A22135413;
	Mon, 26 Feb 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyGRqihJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F231E878
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987951; cv=none; b=XR6ubW/qZAXoYB7wDhGj5PaFmSPoOvuW0XgilkLNWwx2Cm7Jom7vX6SugKDouFLU4oe7OxxiAFYZ1HxcdmM1rJtXcp8hIHkaI4vxo8pKx1E2qWVjgdwTDV40dItzwrMTPB9uxf23fxfIge36OIZBegLFGX/DSdOsUqDfqzUCQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987951; c=relaxed/simple;
	bh=eARabO0/cgBRc/UGX8Aec460i0lvUced5HQ7ISeVL7M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X16JBG8Y/HYgzbYsR2iAfBXMWLmS2JL7UE6unydnR0PD2Jn/5AGFwYT1Fb26bMgsOyhmTcptKMFnrtKVvuMYjacSIxZQEPaTlEqmMAGY8RrE7cVkEDC0WXQ5XQsA7f+8mKLTVqS5dNUf+i/G0s/LCSFuTkuyH6PRD+qjTChdUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyGRqihJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6B9C433C7;
	Mon, 26 Feb 2024 22:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708987950;
	bh=eARabO0/cgBRc/UGX8Aec460i0lvUced5HQ7ISeVL7M=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=TyGRqihJlxSZxTTQOuDtehdRX8prJI0IhnlMRM9L4OSfv/eAnOTpr247UMlKX0fZw
	 TfTs6BtkMhZn0Hg5NfBnw8x/BiRoQbftZcrfif9gFbDygojg4b3gOQT6u0klEJizNB
	 zasRDGdmRGOgep0i80t8apeQJBPmEbAaf1Tl/pZK2bqE90F+4VoAYUP+uBC/+QG/Ji
	 cNtVup4kF06tzgbQitj4wQRREOfaiLmSjS+d31GeCcm+9VrGAVsMoLtYQt9NyYFd0Q
	 iiUWl1vhoVT80FQj1ICVh57Sum7SNY6O6mkFg88SMGAdB1VAtTw3iaXiX3uXdtRTYZ
	 /2tyQdZOgxRtA==
Date: Mon, 26 Feb 2024 14:52:28 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5 v2] f2fs: print zone status in string and some log
Message-ID: <Zd0WLOe89pByO7yX@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-3-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205535.307307-3-jaegeuk@kernel.org>

No functional change, but add some more logs.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 from v1:
  - avoid unnecessary log per Daeho's comment

 fs/f2fs/segment.c | 27 +++++++++++++++++++++------
 fs/f2fs/super.c   |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d4f228e6f771..31a9e7db19e3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4912,6 +4912,16 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
+const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
+	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
+	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
+	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
+	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
+	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
+	[BLK_ZONE_COND_READONLY]	= "READONLY",
+	[BLK_ZONE_COND_FULL]		= "FULL",
+	[BLK_ZONE_COND_OFFLINE]		= "OFFLINE",
+};
 
 static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
@@ -4932,14 +4942,19 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 * Skip check of zones cursegs point to, since
 	 * fix_curseg_write_pointer() checks them.
 	 */
-	if (zone_segno >= MAIN_SEGS(sbi) ||
-	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
+	if (zone_segno >= MAIN_SEGS(sbi))
 		return 0;
 
 	/*
 	 * Get # of valid block of the zone.
 	 */
 	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
+	if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno))) {
+		f2fs_notice(sbi, "Open zones: valid block[0x%x,0x%x] cond[%s]",
+				zone_segno, valid_block_cnt,
+				f2fs_zone_status[zone->cond]);
+		return 0;
+	}
 
 	if ((!valid_block_cnt && zone->cond == BLK_ZONE_COND_EMPTY) ||
 	    (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
@@ -4947,8 +4962,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 
 	if (!valid_block_cnt) {
 		f2fs_notice(sbi, "Zone without valid block has non-zero write "
-			    "pointer. Reset the write pointer: cond[0x%x]",
-			    zone->cond);
+			    "pointer. Reset the write pointer: cond[%s]",
+			    f2fs_zone_status[zone->cond]);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
@@ -4965,8 +4980,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 * selected for write operation until it get discarded.
 	 */
 	f2fs_notice(sbi, "Valid blocks are not aligned with write "
-		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
-		    zone_segno, valid_block_cnt, zone->cond);
+		    "pointer: valid block[0x%x,0x%x] cond[%s]",
+		    zone_segno, valid_block_cnt, f2fs_zone_status[zone->cond]);
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4d03ce1109ad..fc7f1a9fbbda 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4674,6 +4674,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * check zoned block devices' write pointer consistency.
 	 */
 	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
+		f2fs_notice(sbi, "Checking entire write pointers");
 		err = f2fs_check_write_pointer(sbi);
 		if (err)
 			goto free_meta;
-- 
2.44.0.rc1.240.g4c46232300-goog


