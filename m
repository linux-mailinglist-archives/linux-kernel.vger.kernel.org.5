Return-Path: <linux-kernel+bounces-2205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD38815954
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BC31F23B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A130349;
	Sat, 16 Dec 2023 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEgpuw6o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DC2C69D;
	Sat, 16 Dec 2023 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so11158025e9.3;
        Sat, 16 Dec 2023 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702733670; x=1703338470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ54a7sGebhpJsxp9YTsGDagOVgcaEiKJBAxSRg25CE=;
        b=cEgpuw6oaWHcuhr0HkLT2pDN2n/PzthzVLQ+e/C2Z/eGjDkLS6O3hJggpySYzUDjCY
         m/meJ/d5ZEMs7NQEkFeC/sbL2Zkdrrmo70P+wClY+h8cjLT0sJHWUV/WUHJHtAsLEcXy
         nexR8Bfthl7TapCJvqghF7V1cdznKLpJ6JqPFuhs9yQFHyd8S/IC9mxN8VZ2CAPHYWZn
         95KDXcw2sjo/XkPNp7WIOkX066KJoPQ14Ow13zq1Y8p2WPSFyhaO3M5GMgDFvIVKADda
         5yR4XmR1iUQiE4KD0AXylso7/d+Rp/dDXj1KDpZS7Y4QxR/DTR9rFnFbyHOKNSnij08m
         CO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702733670; x=1703338470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ54a7sGebhpJsxp9YTsGDagOVgcaEiKJBAxSRg25CE=;
        b=O+Vv3rsOMoBgHDHNQoEbJowH1h1dtDxAYdDvBAvFqeS3LPxrgl8jVJf3Lv/qv+eeJs
         4THFp2+D9e9NgcDOV/PJEshcXr8+1dznh2JlTY+eUZFKBv0sc3bgOQoEFCt6lLsohNRz
         SBlcKDkOj8jAz9Wma6d4YCHBN5ipq0shsnnMiZzgP3oSKNVx8uCu0vJ5svkUnVc3UrgR
         6iy8Z3kgEwnRUC73qIrXS9zGe+W6hBWnaZ9uu/QL5vKjDZC7gaLeu1RMkF2+7nlhPNMZ
         kXLWC1qaCy+EpqPHrkvs03sCaDsLAI6DWEQDBrKYNo9AjMemKUP6QJ0I5UsWkXy3SmPS
         xoOw==
X-Gm-Message-State: AOJu0Yw8LIpYeBc4pl2ZpPCrMG9MNkPkAoNfBgsJ3XoDAt7+1GGRlzkf
	lTDNJfHmkwm8hvBEmuHKGgY=
X-Google-Smtp-Source: AGHT+IGu8efrSlq+GuBq/ObkC9OhhHEBe/IbQv7ZHkDgjyi9R8rIZVgzPJfTHhK03kt9IfWoxR5u+Q==
X-Received: by 2002:a05:600c:244:b0:40c:2b4c:623f with SMTP id 4-20020a05600c024400b0040c2b4c623fmr4435388wmj.82.1702733669609;
        Sat, 16 Dec 2023 05:34:29 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l16-20020a170906415000b00a232bf6045csm423629ejk.63.2023.12.16.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 05:34:29 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org,
	samuel@sholland.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/3] media: sun8i-di: Fix power on/off sequences
Date: Sat, 16 Dec 2023 14:34:21 +0100
Message-ID: <20231216133422.2534674-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216133422.2534674-1-jernej.skrabec@gmail.com>
References: <20231216133422.2534674-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to user manual, reset line should be deasserted before clocks
are enabled. Also fix power down sequence to be reverse of that.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 34e099939284..f253a40cc04f 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -929,11 +929,18 @@ static int deinterlace_runtime_resume(struct device *device)
 		return ret;
 	}
 
+	ret = reset_control_deassert(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		goto err_exclusive_rate;
+	}
+
 	ret = clk_prepare_enable(dev->bus_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable bus clock\n");
 
-		goto err_exclusive_rate;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -950,23 +957,16 @@ static int deinterlace_runtime_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_deassert(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	deinterlace_init(dev);
 
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_bus_clk:
 	clk_disable_unprepare(dev->bus_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 err_exclusive_rate:
 	clk_rate_exclusive_put(dev->mod_clk);
 
@@ -977,11 +977,12 @@ static int deinterlace_runtime_suspend(struct device *device)
 {
 	struct deinterlace_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->bus_clk);
+
+	reset_control_assert(dev->rstc);
+
 	clk_rate_exclusive_put(dev->mod_clk);
 
 	return 0;
-- 
2.43.0


