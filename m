Return-Path: <linux-kernel+bounces-8137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5F81B282
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904BE284DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8734B5B8;
	Thu, 21 Dec 2023 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="xwp9zPWb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FF4B5A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd54e5fbb2so225101a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1703151071; x=1703755871; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orMvcLfAW1bWOmlNaHx4ffjlbLb3ietWU+HumE/aHms=;
        b=xwp9zPWbswMvU6mmtCc+ShDnGNDW9FS4jF0X7UlqqWp8gl1+Ey32cGF5toh365Xbsm
         XiOjHvsurA5dyYbEJjcTNgulx3eIEysfwZkjsyZFM3i9N2tQmqpNA5lcgSZxX6WwXNbt
         2t535cbixJybkKxPLQp8FF1uQD3VDfPioSIOa0ECv1qtj9A4iqF5E0u/+GlmWhRnFAn3
         uMxejkeUs83MI/xVNEHoMNonL9IZihP0yOwL9XoGkBzSZtC1rfLjvf5HU2THR3tjNgQE
         YmYpNlmTMBJFmS96b9tgcgoVLQnuYsOPK6KC2QMNlTjCBe7Y3Sb39Dcs0ded7rUkmxRH
         zwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703151071; x=1703755871;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orMvcLfAW1bWOmlNaHx4ffjlbLb3ietWU+HumE/aHms=;
        b=Z5zpo5kqwUpuT7ZmBG16c9BcXD4r6+PgVios5CZd1qVeSngczt7p/7rGc06MhfRVEp
         jZP59PfMLahggACOkW2ZK3B+2JIkt1RiA5cPbhR5GHnr5OhsD3Yrdb8vnmIlOltoD44i
         PefvMDwShoFpLTZCeA1VmMEp/Ko5S7zBxwZl7IEmMqaUcSzS7MMlo77Umz6Mqnlr0wOT
         iykvdlQZ6angRxjXEAj/xKaRHvwDypCbyLCQSx6SrRCs/ioW+WCt+CBY+oFQ/KZow1v7
         uDeJFqLszpRLw/5VZerpCtd+xlPLWjhNj2uQ3EfTEsTmYLHjzEVDxIjPXj8Y8q/1N3ON
         2R4w==
X-Gm-Message-State: AOJu0YzHjUsitNwFnFbc1GKv/ffq7GC6Jdd9np5lKBr3xsXCmRjVuUor
	+uS99GUM2VQ2nwG0ZF4CP7cZyQ==
X-Google-Smtp-Source: AGHT+IHI26Y47w+/46gRPCqXGKzZtZ12NB9UdTqzWVjrYsMkiyMkqOBvwN9hGUq3sAiJixjUQbiqYA==
X-Received: by 2002:a05:6a20:dca8:b0:18c:23b0:39bd with SMTP id ky40-20020a056a20dca800b0018c23b039bdmr756282pzb.16.1703151070745;
        Thu, 21 Dec 2023 01:31:10 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001d09c539c95sm1170875plc.90.2023.12.21.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:31:09 -0800 (PST)
From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: neil.armstrong@linaro.org,
	rfoss@kernel.org,
	jonas@kwiboo.se,
	sam@ravnborg.org,
	jernej.skrabec@gmail.com,
	allen.chen@ite.corp-partner.google.com,
	Laurent.pinchart@ideasonboard.com,
	andrzej.hajda@intel.com,
	dianders@google.com,
	hsinyi@google.com,
	xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH RESEND] drm/bridge: Fixed a DP link training bug
Date: Thu, 21 Dec 2023 17:30:57 +0800
Message-Id: <20231221093057.7073-1-xiazhengqiao@huaqin.corp-partner.google.com>
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


