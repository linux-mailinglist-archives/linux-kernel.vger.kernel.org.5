Return-Path: <linux-kernel+bounces-18549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD698825F12
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C50E283736
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B663C5;
	Sat,  6 Jan 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF8DtmsV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05C63AB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d45f182fa2so2785735ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704535115; x=1705139915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlHS4M7ROAgh/OrBv7SqmMmdHtmybRqgH56XCuetaD4=;
        b=bF8DtmsVjug3vo4l8s/dEYNBwD0MT/rKzXm/4LfbKDkhk5Wgp8q1kUMgmACmIcMwA+
         7HS3dtRRWxKOCSI4T49yVlnpXm/lRd4PPAEC9YeEIbc+eE8UfIa+82CSYujQeVz3LtLj
         uknHGwvi53SxDK0TbcoH7U8cgDXvdgvmDwGSqJcN3048/mE8GUfkQN3NmptJD6YFo0MF
         sR7tL28KmJr7BJ/6XsXxU4juX1+mBR8f4dbV2wvesJKuRjGCFfZ1Ae0B7KSfdf12urdI
         lHMSG4/fzWalMnny+Bmm0jF+8jU0DIJMi4FGOQUidZ6sPnI2gqh6mrumU0QgqJGVzeTS
         EMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704535115; x=1705139915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlHS4M7ROAgh/OrBv7SqmMmdHtmybRqgH56XCuetaD4=;
        b=aIGj2LfmU4ZqhwSCSvyUMBCum7jp5dUuGBlhB7XuD6kRoRTVJUHQv/YYvSOVokVxUR
         JVqrypCgH8APCemLRzd4vAjLfo++MXVCoiIgG149InKVoAP1x9qm9nU1jQAN7KNXI1T3
         4a0HC+7hYgB0C+TIlmv+kLkXfBnudJSas+VBe3J622MUu7ITbrF4TN0VD1jgm3mF1bxC
         xUAexkCr0+TnTQYXbgccKLDOzLlUBwYItuXuSrnCI3x2/roLGg/xV1tAs00XBNUzpbHC
         MAV315c50mlVzPQMIk28/bSW5QIINw/tzI1squVYj2Gi/le6jc+BLgGcf5d3z9lqbumj
         3lSA==
X-Gm-Message-State: AOJu0YxUbjcEoa9odsb2QcKMqiLXDwgexwMMfwpUg+MN5p5nMjaIKdoX
	qT20XeXuGQCigNj2A2SdnzE=
X-Google-Smtp-Source: AGHT+IGVH3QQm4SSQO0xRDLyK8MGlYUxsqyqDwCoxboEzSbn7vP7ZX/sTjaZWv+mO9A1+cJEyZOl8g==
X-Received: by 2002:a17:902:e549:b0:1d4:e0e:fa1b with SMTP id n9-20020a170902e54900b001d40e0efa1bmr780852plf.57.1704535114599;
        Sat, 06 Jan 2024 01:58:34 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:7d2f:b593:5038:2a88])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090ad58600b0028c72951de9sm2697730pju.20.2024.01.06.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 01:58:34 -0800 (PST)
From: Wenjie <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH] f2fs: fix max open zone constraints
Date: Sat,  6 Jan 2024 17:57:56 +0800
Message-ID: <20240106095756.1093-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

1. If the max active zones of zoned devices are less than the active logs of F2FS, the device may error due to insufficient zone resources when multiple active logs are being written at the same time.

2. We can get the number of remaining available zone resources by subtracting the number of active logs from the number of max active zones of zoned devices.  We can use these available zone resources to reduce the number of pending bio when switching zones.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c  | 35 +++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 11 +++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..b6809a619171 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,6 +392,21 @@ static void f2fs_zone_write_end_io(struct bio *bio)
 	complete(&io->zone_wait);
 	f2fs_write_end_io(bio);
 }
+
+static void f2fs_zone_write_end_io_nowait(struct bio *bio)
+{
+#ifdef CONFIG_F2FS_IOSTAT
+	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
+#else
+	struct f2fs_sb_info *sbi = (struct f2fs_sb_info *)bio->bi_private;
+#endif
+	
+	spin_lock(&sbi->available_active_zones_lock);
+	sbi->available_active_zones++;
+	spin_unlock(&sbi->available_active_zones_lock);
+	f2fs_write_end_io(bio);
+}
 #endif
 
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
@@ -1087,12 +1102,20 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
 			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
-		bio_get(io->bio);
-		reinit_completion(&io->zone_wait);
-		io->bi_private = io->bio->bi_private;
-		io->bio->bi_private = io;
-		io->bio->bi_end_io = f2fs_zone_write_end_io;
-		io->zone_pending_bio = io->bio;
+		spin_lock_bh(&sbi->available_active_zones_lock);
+		if (sbi->available_active_zones > 0){
+			sbi->available_active_zones--;
+			spin_unlock_bh(&sbi->available_active_zones_lock);
+			io->bio->bi_end_io = f2fs_zone_write_end_io_nowait;
+		}else{
+			spin_unlock_bh(&sbi->available_active_zones_lock);
+			bio_get(io->bio);
+			reinit_completion(&io->zone_wait);
+			io->bi_private = io->bio->bi_private;
+			io->bio->bi_private = io;
+			io->bio->bi_end_io = f2fs_zone_write_end_io;
+			io->zone_pending_bio = io->bio;
+		}
 		__submit_merged_bio(io);
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..8637eea1dfb8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,9 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
+	unsigned int available_active_zones;		/* remaining available zone resources for active logs */
+	spinlock_t available_active_zones_lock;		/* for available zone resources */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..84f390e4ef49 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3932,6 +3932,17 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	sbi->max_active_zones = bdev_max_active_zones(bdev);
+	if (sbi->max_active_zones && (sbi->max_active_zones < F2FS_OPTION(sbi).active_logs)) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
+	sbi->available_active_zones = sbi->max_active_zones - F2FS_OPTION(sbi).active_logs;
+	spin_lock_init(&sbi->available_active_zones_lock);
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1


