Return-Path: <linux-kernel+bounces-27465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76982F090
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446221C23372
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243751BF2D;
	Tue, 16 Jan 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dla/Q3AF"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3781BF26
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cec32dedf3so4471343a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705415679; x=1706020479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVLeCLs+UC4LCws3JCkyo7iN6KY4LoEJi4nfZy2Uvf0=;
        b=dla/Q3AFbrjHtLCE6mravsOD8rJxf9R975TBaD4tzH8ducKywK0BMeWgWf8Zp2PdyK
         fcS2TwHBUKjN8GsVeJqd7VWtpHzYx2eVDesDw5XArgm+4U7AGzOvdx6m9n/sbG/kmgXa
         h3ZR/70OiHORJ65cSh4yWymHM7fHfN0UVGaNeE90NCz28fY/acg/ZBH5pLubbNuWz3BI
         +CrMsFiLKy13S1F8gDybymCVEZEfM7gBGKW+Heye+kYINTUojreztLYzc1xRVrJcd4Sx
         ehis4WsfnmYUJLnMP7awxZad7kcZ3LlogLhKDmowsJTBNDi4WmBtyI9N6lex4+6Xf4VX
         6wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705415679; x=1706020479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVLeCLs+UC4LCws3JCkyo7iN6KY4LoEJi4nfZy2Uvf0=;
        b=OzTO4FG1dTm3fT2omFkLjoQ/1dXKtrL+TV0hnzmGaxQkS9DSiQ8mWNPZDvVziVnfKF
         DlGKsL+eawL8/QSEZXa/Xaped18f5BlOss7wUd3b0L34dsxEQKuNgUUFKVKZXKX4beWG
         dg7dGGgtX8zcw9Ye5Jq/7EKswU+1DW9dBtTd7ddLfM7bNPW7qNkxBwNY7K+9myz5YPn9
         UmWEktHBxJRgG6bfv4yaGqvDGP1uHdtxdca47KhzGZpqE9V1DPJB98Tm3ok/2V1uA+Wv
         FpPJv0OamXv6QQMW1oJ0MPXooaP53GvSmck77yu4uccA5MuiEN66swNuzKa+VciU4u3U
         SpBg==
X-Gm-Message-State: AOJu0Yw8+Z+VKG+3CoQMwDeKDj/3K32bHkuk2nmRpvGZN53A7ji9p85S
	ZzqJNDYH+ZO7hH4vIjb9PWU=
X-Google-Smtp-Source: AGHT+IGHaN9YxTeIzJrPa8gr5TI0NPSj8v/Q4JIkg6Iko/WVK14HfcXfvs1OU5hQ9bSc8XXrKZKWHg==
X-Received: by 2002:a17:902:c409:b0:1d4:f77c:a8e4 with SMTP id k9-20020a170902c40900b001d4f77ca8e4mr4207509plk.79.1705415679435;
        Tue, 16 Jan 2024 06:34:39 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:8dd2:f82d:e185:367f])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902f74d00b001d3c23a6862sm9402603plw.25.2024.01.16.06.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:34:39 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v1] f2fs: fix max open zone constraints
Date: Tue, 16 Jan 2024 22:34:22 +0800
Message-ID: <20240116143422.1268-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can get the number of remaining available zone
resources by subtracting the number of active logs from
the number of max active zones of zoned devices. We can
use these available zone resources to reduce the number
of pending bio when switching zones.
If max active zones is 0, there is no limit.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c  | 32 +++++++++++++++++++++++++-------
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/super.c | 11 +++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..0b62ca296074 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *bio)
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
+	atomic_inc(&sbi->available_active_zones);
+	f2fs_write_end_io(bio);
+}
 #endif
 
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
@@ -1085,14 +1098,19 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		goto next;
 out:
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
+	if (f2fs_sb_has_blkzoned(sbi) && sbi->max_active_zones && btype < META &&
 			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
-		bio_get(io->bio);
-		reinit_completion(&io->zone_wait);
-		io->bi_private = io->bio->bi_private;
-		io->bio->bi_private = io;
-		io->bio->bi_end_io = f2fs_zone_write_end_io;
-		io->zone_pending_bio = io->bio;
+		if (!atomic_add_negative(-1, &sbi->available_active_zones)) {
+			io->bio->bi_end_io = f2fs_zone_write_end_io_nowait;
+		} else {
+			atomic_inc(&sbi->available_active_zones);
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
index 65294e3b0bef..2aade367ac66 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
+	atomic_t available_active_zones;	/* remaining zone resources for zone switch */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..6711283ff187 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2385,6 +2385,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_active_zones)
+		atomic_set(&sbi->available_active_zones,
+				sbi->max_active_zones - F2FS_OPTION(sbi).active_logs);
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3932,6 +3938,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	sbi->max_active_zones = bdev_max_active_zones(bdev);
+	if (sbi->max_active_zones)
+		atomic_set(&sbi->available_active_zones,
+				sbi->max_active_zones - F2FS_OPTION(sbi).active_logs);
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1


