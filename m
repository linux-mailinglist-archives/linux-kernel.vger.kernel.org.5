Return-Path: <linux-kernel+bounces-18570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE8825F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D60B22789
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD127483;
	Sat,  6 Jan 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as7p+QMJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077ED6FC3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dad22e13dcso226046b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 04:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704544810; x=1705149610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPeNVsPEKJJfJSMWWv6gaBxyuyB9PvhzhkwKwIyGk5g=;
        b=as7p+QMJv61nQxABKKIWeQsOam9WkR1hy93ZSlA343wvMeL3F4zQdC25lSQXBeuI63
         nLYYh9aVYPbtgQGl8Thqq61sKZayPSiwrcLAVA2+x+AWCmp1XAHcdaByKHgAoyWA+/p6
         v3g1mDuRwEmpTO3NYnQFpW7qJdQRNkDbHaw62snHlhcdUJZpUATeJa7wT43ag7NTb143
         Nap754OOasmvxvoAacLHo/p3C9sveu8cw8vL/cz6S1IcnDwA2yT7EMBJkaOnrYHPhI1f
         u2HwkuYL93x9Dy5FEhJS7MbWHN1iYEELtdFmOVw9WZw9kR1h3urXeb0W2JWPVe4cYZYC
         znCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704544810; x=1705149610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPeNVsPEKJJfJSMWWv6gaBxyuyB9PvhzhkwKwIyGk5g=;
        b=ppAi2LLwfk3AZhNmEoOSpb4jZDStmC2Koc0Wo6mNy/WM8auQ/IlMNp+5ek32jW8S4u
         yusHzNHCEGn9zL/FkODPWYbusNHYA67dGwaH/Vneqv0fY+PBhQeFRzVw5LIEtef2gqbU
         iKyoCdJ5pohuhfhBp0FUU+qokOHuW+mC2QqY1lxtyL6DecL87UGgNEd8tJuCFvkA0swE
         zN9Wok0y+HPE++D7eRxFm1v/CnaTwVguX0/Pu3GCAg7DYFvC3ILnOEwbllg+rDlblUFb
         iukYxul6TAT1Vdo0LFiiNO7plicCN1reuPyF6ssYCkLAE0x7WU9JJbUyAbYJNPBmOoKs
         Y3jA==
X-Gm-Message-State: AOJu0YwTa9OHtdd1FBpNEHMqqsoW3Sz0Ulu3Sxq9DwGPiRhdjuWvWdSy
	+UIG2uWrxCsjvss0IySOSbw=
X-Google-Smtp-Source: AGHT+IGvEZTMpQzsIqNh+T15JF/mo2qYG4YZjLhgdPAGGCzH5pEua0w4Tbb2FrhnSZeseOkIBq1uGw==
X-Received: by 2002:a05:6a20:2592:b0:199:4c31:9383 with SMTP id k18-20020a056a20259200b001994c319383mr216524pzd.26.1704544809879;
        Sat, 06 Jan 2024 04:40:09 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:7d2f:b593:5038:2a88])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902e9d500b001d40cc2c9c3sm2987250plk.35.2024.01.06.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 04:40:09 -0800 (PST)
From: Wenjie <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH] f2fs: fix max open zone constraints
Date: Sat,  6 Jan 2024 20:39:35 +0800
Message-ID: <20240106123935.586-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

1. If the max active zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs are
being written at the same time.

2. We can get the number of remaining available zone
resources by subtracting the number of active logs from
the number of max active zones of zoned devices.  We can
use these available zone resources to reduce the number
of pending bio when switching zones.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c  | 35 +++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 11 +++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..1896928cae77 100644
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
+		if (sbi->available_active_zones > 0) {
+			sbi->available_active_zones--;
+			spin_unlock_bh(&sbi->available_active_zones_lock);
+			io->bio->bi_end_io = f2fs_zone_write_end_io_nowait;
+		} else {
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
index 65294e3b0bef..32163d57511c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,9 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
+	unsigned int available_active_zones;		/* remaining zone resources */
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


