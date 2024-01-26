Return-Path: <linux-kernel+bounces-40276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9683DD70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F801F261EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28521EB39;
	Fri, 26 Jan 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb9/bTBx"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE931EA71
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282766; cv=none; b=scMpos41myJxWOT6+w5us4U1E69Uou8QfBBDUKSs/A+A8pClCZ4G2jKGjUCXJy07IVOn99cl9YQuffQ4M/WcFrOX8eLvYetUdjCbm1BmKlLMP4HUtpm1i0mE7htOcqxjmcUkIab7FruYdeZT8x84FRAfq54IrCKjCfME0sHZ2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282766; c=relaxed/simple;
	bh=BRhWTo+/NPWNxQJuyEqZDTWB1pcTfonuimTvflg1itU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jam5j29kEzpvu1W2+9/wmN2ifGrNRBZX2xJg6rbITP1GUak5Mn0MrRq2FdK4QOzxJ0SqvW6t/ICSfHk0WU6jzHpNOqAYLnvDVwtsF+JY8ktpGWB4L9Z2yYBfJuvTVa0lBtzonKrJqp9ZZGSleITJUrDzZpWgx2zMInT0tGQzwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb9/bTBx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394dc2ae23so734621f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706282762; x=1706887562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7qX8odXPP3RV5R94dRW7ALCQ1ih+UkRr3f07aHV/1A=;
        b=kb9/bTBxLYZgcsMhxkW+GNNxUyo5T1By7UH9gd2VW6GmWz8J0poEW2sSeXJo2mK9LU
         gJecFM2fNJQ32BeJGZta976IFCACusHJkEfRJfHLz4UjTOU893ZAC+z3uHD3Du6fAMcx
         s9bqJHs7Lqy/967ZU7g0oA43DzJN7vhjZNkh/I/zZwXEIh0rz6KlIuPjcExxqua/U5z0
         wJHpFw6+RAiAL67yBXi7oDrHR2gElOY1mn0udMsbxUBw3y2v15B5TvCL1JAxPeabR85n
         MzHP052UUCUM5kU0BjvV7wSYb4JB11Pu6LxVsw2qykBUYmBiQg2OiI/GuyNnkbwjiP0n
         sH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282762; x=1706887562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7qX8odXPP3RV5R94dRW7ALCQ1ih+UkRr3f07aHV/1A=;
        b=Chqz4UAVWlA+uWl8Pu3LomnM/3ddjq7xYBXjoycU10a4rJwDhJO1PdZufuMRn4rwRE
         zOzJd0k4lVm41mEyyHK68SH/aWl+16Kb1wOsR9vUpN4VbjARIlvs5S9/3Z1fJcaV5Tki
         yRh/oz/8JsUoYWZ+rx1yB/wG22vKZPvt1JAty/raov7afh+C1MxWFFGpq6fDqrBjdkOU
         2dJ8rxz1TKHodLTOYRuD3MvUnTdnbZaZbDvqKQivmTyZT5B+Al7hOT0tetmUnkz8nrR+
         eTHQ3eo48FqJYm6J+ScNo+JjB2a+i2XBr3U3D9feWskVKzeNwW6ikWAkPmbRyQl2eS3Q
         xUSA==
X-Gm-Message-State: AOJu0YwVy4NPWw61lkvMPFO+Z0KkfT5htz42QTEF1WDVJqnjssVpvOGN
	XeHqcwo6wX+jxHhfQedSxDB74rL1BpYol7dhc9z9xx13OKZGhyx+
X-Google-Smtp-Source: AGHT+IGUd1ntIzSSZOM958nbaw+cl7tvaX1PK3J+Jvy4OZyxW2iZYeDSUSu/KLNxUg1/+Gayc9eBGQ==
X-Received: by 2002:adf:ce09:0:b0:337:cf68:c06 with SMTP id p9-20020adfce09000000b00337cf680c06mr791836wrn.77.1706282762096;
        Fri, 26 Jan 2024 07:26:02 -0800 (PST)
Received: from localhost.localdomain ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d498e000000b003392bbeeed3sm1477098wrq.47.2024.01.26.07.26.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jan 2024 07:26:01 -0800 (PST)
From: Levi Yun <ppbuk5246@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] kswapd: Replace try_to_freeze to kthread_freezable_should_stop.
Date: Fri, 26 Jan 2024 15:25:54 +0000
Message-ID: <20240126152556.58791-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using try_to_freeze, use kthread_freezable_should_stop in
kswapd.
By this, we can avoid unnecessary freezing when kswapd should stop.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/vmscan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..1f139830b26f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6796,6 +6796,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		bool raise_priority = true;
 		bool balanced;
 		bool ret;
+		bool was_frozen;

 		sc.reclaim_idx = highest_zoneidx;

@@ -6894,9 +6895,9 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)

 		/* Check if kswapd should be suspending */
 		__fs_reclaim_release(_THIS_IP_);
-		ret = try_to_freeze();
+		ret = kthread_freezable_should_stop(&was_frozen);
 		__fs_reclaim_acquire(_THIS_IP_);
-		if (ret || kthread_should_stop())
+		if (was_frozen || ret)
 			break;

 		/*
@@ -7102,7 +7103,7 @@ static int kswapd(void *p)
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 	atomic_set(&pgdat->nr_writeback_throttled, 0);
 	for ( ; ; ) {
-		bool ret;
+		bool was_frozen;

 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
@@ -7119,15 +7120,14 @@ static int kswapd(void *p)
 		WRITE_ONCE(pgdat->kswapd_order, 0);
 		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);

-		ret = try_to_freeze();
-		if (kthread_should_stop())
+		if (kthread_freezable_should_stop(&was_frozen))
 			break;

 		/*
 		 * We can speed up thawing tasks if we don't call balance_pgdat
 		 * after returning from the refrigerator
 		 */
-		if (ret)
+		if (was_frozen)
 			continue;

 		/*
--
2.39.2

