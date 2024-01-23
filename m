Return-Path: <linux-kernel+bounces-34874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720F8388A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CD51F27142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953D5647B;
	Tue, 23 Jan 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRsXZRir"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9755E76
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997596; cv=none; b=UkbM0F8e+Oo6ZmzLBYRLTkWvvdekpO2DZ/EVGjPgrODuTB0g0512kF72eg/1PFsu41M54ZIOxYmncwE+vXQ7jXEEUyh6dpTwvpAmcxgzqpJnXAKtzJ3uRGmrARYHskcFQwc5/+GqGVhKxbVOEgBf7uMxj1bpSR1whhcVR4Cryh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997596; c=relaxed/simple;
	bh=/sM8VvHIXE+nip92qpOPQD1wgYBeZzA3gwJx9pdbtjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcH7A3AQL66mThhaDS/44RWtcREdISjCw3SNVA4LuFrbybRVtCMCEtpJmK28u4EoqbMvPPg1Z3x/1aUurbaIDrht6l80bj6WNBp05UVjf/NfLFP5g0SXjISCzPCpXhsiUXirTYlVBJb3xJS3v93xp6kEMZKYhPcY8LE0ypfvpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRsXZRir; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d76671e5a4so7989525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705997594; x=1706602394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcINxNqK9poEeYbYdpTS1L5ZKLd+2H3epIO3RsMgjVY=;
        b=CRsXZRir2JdbVood6H4uIFIExAjaPdjqMbYXWfUqU4eJL8moMI26wpcW/ppRY6zEEt
         AYQw06hThspBQrA4/ujNNf6fPEs0jIMEpBCoWImINTvlfKVbTzZ1JSFIGZBRKGBjW9xD
         TBdTePhkSSbfZwxulAJFCEEjbE8uNnd78d1KtmYOr+451xPlY4+Cr2hO9N1eU3S1p+oK
         4wl8Ai0yz4vp1+EN8ea/csiwTP+2owXw3D2xN3MPPjLEEzizw8oodFi7/922xPOGtSfz
         qRZ8DNbYf6qIh2YtlK5l/I0nTxEaHBnSn+hA86DmplFhqpyLGRM3e2b5+3GpNluWY8rN
         RnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997594; x=1706602394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcINxNqK9poEeYbYdpTS1L5ZKLd+2H3epIO3RsMgjVY=;
        b=U4Nioe1XhocWnEf7wHkB9hk9slsRlvUirz6Ydj42OslcZ/MJMESQs6qruEUOOVFAnb
         QUu9HCxPjK/RNK75Nv4pnNC2NvZaVSlHf8D84RkV5v+nri25De4jatvgIf9o1RdLhYyM
         emO7soHhsLHQl7WQp+tBHbDg4PaIQ59uvaTG2kAnMe19xngNR/mEZqquEKf/RAqZ+hs6
         0oPvc17jvkeiRU1/wUcIbGhO0G6ryUKkIa0U0qmtRBtTxe+VaW506Z0fhRpGfwq5bK81
         WjQvY14HPHllnQMn/muYv/d+jfki6fg4UshiKbmWe8eeQKEkv6C+eXN/fAw0zA5a+fsY
         KLMA==
X-Gm-Message-State: AOJu0Yzhkz+a7K8yPgwOC/7p3zjUL9aHcryK5W1LwGgcRGMWe8rx0nkJ
	FKZlBES/3+VTsDGt2NAq9T4FeF9Tfc+x8wZLysSPn2OhG5HrKyC2
X-Google-Smtp-Source: AGHT+IErVu63V4k0+Aq4pa/jHhmVEQBrs+2RsnmDS9vb3LEMXIfyc+CDCcw5kcox8aQnrm0Z/3H8aA==
X-Received: by 2002:a17:903:25d5:b0:1d7:808:dcfb with SMTP id jc21-20020a17090325d500b001d70808dcfbmr5123860plb.91.1705997594253;
        Tue, 23 Jan 2024 00:13:14 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:d59a:da76:65b9:ef0])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d70c6d40f3sm7798578ple.237.2024.01.23.00.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:13:13 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v3] f2fs: fix zoned block device information initialization
Date: Tue, 23 Jan 2024 16:12:58 +0800
Message-ID: <20240123081258.700-1-qwjhust@gmail.com>
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
 fs/f2fs/super.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 206d03c82d96..aef41b54098c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2385,6 +2385,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		err = -EINVAL;
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3932,6 +3942,14 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
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


