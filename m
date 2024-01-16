Return-Path: <linux-kernel+bounces-27449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D64182F03F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798CAB233F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1C1BDEA;
	Tue, 16 Jan 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9wXl+Cc"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41421BDE1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5dfda4319so6190265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705413974; x=1706018774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=;
        b=m9wXl+Cc8ySodt0c3ab0sD+q36pTecZ2P9lZTl4N4aVaihssYtcGK9L7QJf6kwogCo
         amvex91IqDjo7Y4SO8LWlM0FCiw8aJQMn5bITON/42RoT/xLw9rKkOdIt0egWqdwyNNx
         GS8L/hBkmjIC34dSeMf/8TMWR6LE2hzt9JLyEKiIypbJOSepfov7rugprLClznWs6NGN
         uDTM/125y7osAsLfXnAMlBTukaktpIA0fCN+RFM6mznf4fHggarcPtfvUP5Q+2eibTQv
         mK5h7e0SnJEG6GxOxnHjXYh8x+wVEwPDEnaqDvT2O72F2R94T1J8PPPwLRz8EqdLcjT+
         Btdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705413974; x=1706018774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=;
        b=GlsIYxmb/Ey/1QC6yG5MZ9COHyxoHN84gL0ZQ7ZeJVe2vHArkNKyu+vSXG+XhcS2U6
         Nm6X9ckVwtkZ7nstNd6jINGPIvR+VGzN3NU1s4v2b8L4Y6e3ovgd9562AS+rJToPKPM9
         1btIMhB4Pe5atzUCOAGqnF8fBKb6liL8knhGnNOkQV5/XptfdN9/+ST1qaPk1QjzqRnE
         sRvPG/orEztVgLhHk47LX/7CSxiLT7X+W10R0XjNFD87KVAd61w1yYjKToaMNVc5hcMj
         JRhKDYUS4JG4dxfPV4ccPwAmyrJow23hlgIg0Yw6RlNwr8SVvCzH51zQb8MmuTTtIlab
         M2dA==
X-Gm-Message-State: AOJu0Yw6ee9m6LkFrLWETs4naWLxTKZu46d0lzt4gDFaVFv63xYY3Spp
	59bYzX80A2lRX4hgayTswrPaweSYFUMBGA==
X-Google-Smtp-Source: AGHT+IGAY1SVIEbtnn+B0y3YjKdZ2vC+ch+yaWFXuC1iIBEXpUnjN6SkMsXl8PCeSn882peT42GLug==
X-Received: by 2002:a17:902:eb8d:b0:1d0:8352:b71c with SMTP id q13-20020a170902eb8d00b001d08352b71cmr4607011plg.5.1705413973801;
        Tue, 16 Jan 2024 06:06:13 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:8dd2:f82d:e185:367f])
        by smtp.gmail.com with ESMTPSA id mi11-20020a170902fccb00b001d59f061a29sm8245474plb.11.2024.01.16.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:06:13 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v2] f2fs: fix zoned block device information initialization
Date: Tue, 16 Jan 2024 22:05:13 +0800
Message-ID: <20240116140513.1222-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the max active zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs are
being written at the same time. If this value is 0, there is no limit.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..669f84f6b0e5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..b65547f4c710 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2385,6 +2385,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3932,6 +3941,14 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	sbi->max_active_zones = bdev_max_active_zones(bdev);
+	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1


