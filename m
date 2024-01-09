Return-Path: <linux-kernel+bounces-20353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF49827D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F391F23477
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1453BE;
	Tue,  9 Jan 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqbaxTuc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBF468B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3ef33e68dso17277395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704772700; x=1705377500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+JGySNzF1TxXICx+IoE0CwzPZDyIzoBhgAgBf0mPnw=;
        b=kqbaxTuckHiRilmT77WHdjC1tzwBpgKTLgZPh+1N83FzQZQH4gFPDIWlHCCuVo13CO
         FLc2XVh9ifuV/UH39jgqgG86BMpuTYVzVMe6RBasOn41PrGUKpqpMygnVvF0Z3MHfq4O
         E37Esy1J1/KHi7yeSDYvAvMGm6FaYUvDr09yGgZTO166c1dGasPLIIQE2Vo3Vdaa9Jno
         hF5BbGpBAdCxmz84QmS5kUOBJ+x20EfnwZk6s1uPDLo9Stqw5PqdreowRU3ga85XPBEq
         a9pY+KbyIQzXHSJpBRf/lBg7k7c59j/u0KA+DSV050nd4Zy/TMvBEROwK7lINXlG6n8u
         6Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704772700; x=1705377500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+JGySNzF1TxXICx+IoE0CwzPZDyIzoBhgAgBf0mPnw=;
        b=qv+h+JjOFOnToCl2iP4dPC7LkSu+1d/meNNJxpmegyPa8VnySnXqmLOvartvr1Sxi+
         9N118B8bo2E5cPh3OTqK518DWcMYY6rkNgcgvMo9Xun8i0Zpl1DFaluh9HdhHIucotrP
         T7/c53zh7o6TLoQqxdDsfed/ZD+l1xqqIbJgRJ21vKnLoXZ75Yxno4uhjndVDJGMz0ij
         nX7GBq5IhmnpHRNqTcV0NFa1dg3tbivKmRMpF6Fi0idSL8SI1O8wPKPA8FbaYWS7fngh
         Dn+ozNwGm0wlogKAw4YB383YHla+nXaHx3/nx9M01rFAYaSyW0MyiMH0eRh3LNSREvmz
         hyTw==
X-Gm-Message-State: AOJu0YwPEWl67dPVrIRgGIRj3YD9BF4zghA2wYlBtxa9FCiowkPzsAtL
	2weFfV2v+Oayxa/3wI/xujU=
X-Google-Smtp-Source: AGHT+IG7oanF79UWlje51X1cFGF4No3FJX0a+t24EfCMq48WW1ffXcRhMq6cXjlehe94atY17VaM6w==
X-Received: by 2002:a17:903:278e:b0:1d4:cae:99f9 with SMTP id jw14-20020a170903278e00b001d40cae99f9mr134076plb.45.1704772699727;
        Mon, 08 Jan 2024 19:58:19 -0800 (PST)
Received: from localhost.localdomain ([115.156.141.114])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b001cf96a0e4e6sm645452plm.242.2024.01.08.19.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:58:19 -0800 (PST)
From: Wenjie <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	guoweichao@oppo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v2] f2fs: fix max open zone constraints
Date: Tue,  9 Jan 2024 11:58:04 +0800
Message-ID: <20240109035804.642-1-qwjhust@gmail.com>
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

3. The original code for determining zone end was
after "out":, which would have missed some fio's
where is_end_zone_blkaddr(sbi, fio->new_blkaddr)
was true. I've moved this code before "skip:" to
make sure it's done for each fio.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c  | 38 ++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/super.c |  9 +++++++++
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..6b11364e94b8 100644
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
@@ -1080,22 +1093,27 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	io->last_block_in_bio = fio->new_blkaddr;
 
 	trace_f2fs_submit_page_write(fio->page, fio);
-skip:
-	if (fio->in_list)
-		goto next;
-out:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
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
+skip:
+	if (fio->in_list)
+		goto next;
+out:
 	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
 				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..1b1833e1d10e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
+	atomic_t available_active_zones;		/* remaining zone resources */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..c79919425d63 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3932,6 +3932,15 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	sbi->max_active_zones = bdev_max_active_zones(bdev);
+	if (sbi->max_active_zones && (sbi->max_active_zones < F2FS_OPTION(sbi).active_logs)) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+	atomic_set(&sbi->available_active_zones, sbi->max_active_zones - F2FS_OPTION(sbi).active_logs);
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1


