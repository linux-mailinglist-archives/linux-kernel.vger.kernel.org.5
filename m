Return-Path: <linux-kernel+bounces-145507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C28A571E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DACA1C2250B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793D81ACA;
	Mon, 15 Apr 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpP8HRy6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3538174C;
	Mon, 15 Apr 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197319; cv=none; b=lPlzrcNEWYX1QDFgzRHznvBADbEA6QtMe33KsqFuLLoIa4IaGIEJ/R2wg28TMB0D8VW6BQnYuXMjUoAPaXp+3YqfSjAurUVdZ3L23jvVcvCt7+EtGmmfI1y3+WKjpfixgOj5qt9ZE0z2a2EnjA5LhkKDUQZVKX34yCzXOxpE2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197319; c=relaxed/simple;
	bh=3GVeSBq3i3WVVAKL5C7iNHeCdZfIQrOT9LZi5TxkvWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MeqFIGEck0MYaD68G8YuRt4bOJQ7kcOus9zyBIKR71+iaAWyQlbmm14EPbrNK49A4/S+1HeQ0rl5UdVunx2dTwqYZVUvLsps4jwtxCQjqP7UnR0OddLDoMvLQjBEIC9hM/1jZT648JwSNK3ACt4NBsRrYyZsZ7rOyVZEQFjEIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpP8HRy6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e65a1370b7so12380525ad.3;
        Mon, 15 Apr 2024 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197318; x=1713802118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3s3KWGVV93WKwKK9I5nZWoIVkkIpPiCOk0POxZeGeA=;
        b=NpP8HRy6RklsBdO7gVx+q/nitNa4Z8kvbIdvIdTcoNMWXBoJtgB9hEeF6A33GARGVk
         iVpQyr2CAUuvaBWC44y+BcPJGuImsbR8ddLKhGlFt7yp7wyuunOPIfwnznkpFnMBWYnT
         ENCrlrzarmox/PhVkJNKdvFo5AXXM3sdt12I2GQAwa9rVuDinFVYfhBydNLveO5BveEb
         knLY/1YPeVptT6qe0y1Zn/IY0GgwTW9vpytOq8IPNBF9NGQmTElMDfR1SBG+vB9vMdDI
         QVNppUmUlBj0NqFkgOrBZiSu7M69+WkfWVIscCBY2gIRczmxRZCsVcejq79cNPWewx3I
         lVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197318; x=1713802118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3s3KWGVV93WKwKK9I5nZWoIVkkIpPiCOk0POxZeGeA=;
        b=KDHDcq5OMgx7V4hAY3ccSxPhWKZr7RqDKl+uEAa57lJM4vQmupmFzLmICJGEgnnOQY
         FfKalKIvOAmmD2FxMeSPDwlFlgG7EU7CwqBQt9ukrh0vnXlMpMw9eBiS2yTX18w7jrtT
         tkBJPrZzwjBS5qYXnWvaK7nEIZGkk4E23KPDmaVleJSKH0g+Wt2U9nfiV8hLHngyGN7Y
         wzqUR4Cx8GOL9To9XbTh7Oe1kW/TE+rm2n/DEdAAqb6DJvjhgF6YxnHOwxAboxqfI4go
         +6jVn366RPTxprPG6tKDEk6PHD1WwD0gFQOm/5gy6r01aODI3yXiiDUAuf8Ja/75zfOJ
         2UKA==
X-Forwarded-Encrypted: i=1; AJvYcCUi68PgvB+Ib3xP1532RPbxxF8TeVzKySdH4CzkcTeU/uu/xGDXihlp8m1CmkCT/LE1ONTWU0NHKSiGwRRinBVSwCT/DjPvXWZMDxvP7xcLSR63zj9kTnqHPF1qoYGLViTH4RrXmoo5ig==
X-Gm-Message-State: AOJu0YyHNKAXPwpSZ0RsUjNuAot9yCRwHY+fJXVlAHspIF2Mjk/q21q7
	eNfwWImA9hvaY7oM8vJ4hs17v9Sls2/vouOMsSfV/QOuQVTqIqSFaCEaYO3p
X-Google-Smtp-Source: AGHT+IHu3Nuj6UAHVKUuC1+lQBGvYWGfBaC30CgRkK4LRiq7nj6kxmX2o/DutSHvuG+5i7Vc3yGuNQ==
X-Received: by 2002:a17:902:ed4c:b0:1dd:e114:121c with SMTP id y12-20020a170902ed4c00b001dde114121cmr11596550plb.56.1713197317835;
        Mon, 15 Apr 2024 09:08:37 -0700 (PDT)
Received: from dev0.. ([49.43.161.106])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b001e668c1060bsm2510562plh.122.2024.04.15.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:08:37 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: song@kernel.org,
	yukuai3@huawei.com,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] md: Added journal count to md_u.h
Date: Mon, 15 Apr 2024 16:08:18 +0000
Message-Id: <20240415160818.8276-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses TODO in "./drivers/md/md.c:6752".
Add journal struct member to mdu_array_info_t in "md_u.h".
Add the journal field in get_array_info function in "md.c".
Need feedback on if the update_array_info function needs to be updated.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/md/md.c                | 8 ++++----
 include/uapi/linux/raid/md_u.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e575e74aabf5..4958d6e21923 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6735,10 +6735,10 @@ static int get_version(void __user *arg)
 static int get_array_info(struct mddev *mddev, void __user *arg)
 {
 	mdu_array_info_t info;
-	int nr,working,insync,failed,spare;
+	int nr, working, insync, failed, spare, journal;
 	struct md_rdev *rdev;
 
-	nr = working = insync = failed = spare = 0;
+	nr = working = insync = failed = spare = journal = 0;
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		nr++;
@@ -6749,8 +6749,7 @@ static int get_array_info(struct mddev *mddev, void __user *arg)
 			if (test_bit(In_sync, &rdev->flags))
 				insync++;
 			else if (test_bit(Journal, &rdev->flags))
-				/* TODO: add journal count to md_u.h */
-				;
+				journal++;
 			else
 				spare++;
 		}
@@ -6769,6 +6768,7 @@ static int get_array_info(struct mddev *mddev, void __user *arg)
 	info.raid_disks    = mddev->raid_disks;
 	info.md_minor      = mddev->md_minor;
 	info.not_persistent= !mddev->persistent;
+	info.journal       = journal;
 
 	info.utime         = clamp_t(time64_t, mddev->utime, 0, U32_MAX);
 	info.state         = 0;
diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
index 7be89a4906e7..485befa2205d 100644
--- a/include/uapi/linux/raid/md_u.h
+++ b/include/uapi/linux/raid/md_u.h
@@ -84,6 +84,7 @@ typedef struct mdu_array_info_s {
 	int raid_disks;
 	int md_minor;
 	int not_persistent;
+	int journal;
 
 	/*
 	 * Generic state information
-- 
2.34.1


