Return-Path: <linux-kernel+bounces-3519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA2816D49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AB2844E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FF1CAA0;
	Mon, 18 Dec 2023 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="lF0F6ZJM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184922330
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so2493781a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1702900730; x=1703505530; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orMvcLfAW1bWOmlNaHx4ffjlbLb3ietWU+HumE/aHms=;
        b=lF0F6ZJMu13IHFi4BvHZCeC2KUXr83ZGC/tBUt6tdLldjjm+PKJysh+OT0kmdw+/IX
         O8zpOetyKP2wPNu8AOLV5HSURDnvcbQgMAqFqmL0IzfT9jFgNS832kKi+GO/s8SnXX4a
         wtM6VxFSkuQ62x+wP4BhRbivXLtOltxBlIpTcx/5864x+U3xYi11umzvd3Gcihvp8Lbc
         HGtopm3qI6+I6THnXiMR7tQNJhcEkQmpMDZlZUYh3OWgn7dLLrPIsEz3+z8ulhwO5FmQ
         veGM/cJVuvwoYa7z9W+OI896q7l+lRlZfxqBUDL0W8zXed4mutc2p/oUPI8K8Yji+Mw4
         vXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900730; x=1703505530;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orMvcLfAW1bWOmlNaHx4ffjlbLb3ietWU+HumE/aHms=;
        b=F9C9cqZEgu/OlEN7fqxTeBsGFavE0UiN7IkX6k8a0OJCMyOx1FlnaD6jR1ryyvA0tA
         we+AgGai0wJVeb6SlkYSzF5Kh7ulZbg1X5gfW/ipWPu1Kq2eDAfn+WRNeY8Fivxy5RQX
         CIWDsrLyK/k6PBdCySNga7dhOdWoL8bdIH7gsVkrSQh7kYIa0hKnDMorXr74NukP3y14
         WYJOZKRK9a62XA2SS9hPukbybRe7FuLPLLMORIo+i5C4tGa3HZ7jrYUr7XRwCjgq5z1a
         tB6psl/RC+/S1sy2U0WhPRl/Z2d6nI9KnPg+gqk6/g0J7MoPDtWZy+SBhjyeYvxqxM4P
         g8Sg==
X-Gm-Message-State: AOJu0YzE81UWVyShEPN/K5SmFq8LwXuT+EXKbWVPA2XqLHZut/KFfmnj
	mPjUjOA4ycl/FcDMP/ZuxduKXA==
X-Google-Smtp-Source: AGHT+IGDmpYsBu9vjzBqD2RVr9vd3yuOeOgqIoJ2O9xi1AOkmHMN6+eAJ7arABF3v+gsBl8fGZSQuQ==
X-Received: by 2002:a17:90b:391:b0:28b:9117:d070 with SMTP id ga17-20020a17090b039100b0028b9117d070mr487023pjb.74.1702900729789;
        Mon, 18 Dec 2023 03:58:49 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001d38410aa13sm5868936plg.192.2023.12.18.03.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:58:49 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sam@ravnborg.org,
	allen.chen@ite.corp-partner.google.com,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/bridge: Fixed a DP link training bug
Date: Mon, 18 Dec 2023 19:58:36 +0800
Message-Id: <20231218115836.23686-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To have better compatibility for DP sink, there is a retry mechanism
for the link training process to switch between different training process.
The original driver code doesn't reset the retry counter when training
state is pass. If the system triggers link training over 3 times,
there will be a chance to causes the driver to use the wrong training
method and return a training fail result.

To Fix this, we reset the retry counter when training state is pass
each time.

Signed-off-by: Allen Chen <allen.chen@ite.corp-partner.google.com>
Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2f300f5ca051..b589136ca6da 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2240,11 +2240,13 @@ static void it6505_link_training_work(struct work_struct *work)
 	ret = it6505_link_start_auto_train(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
 			     ret ? "pass" : "failed", it6505->auto_train_retry);
-	it6505->auto_train_retry--;
 
 	if (ret) {
+		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		it6505_link_train_ok(it6505);
 		return;
+	} else {
+		it6505->auto_train_retry--;
 	}
 
 	it6505_dump(it6505);
-- 
2.17.1


