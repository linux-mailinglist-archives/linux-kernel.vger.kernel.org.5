Return-Path: <linux-kernel+bounces-2204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7526815952
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C91C2189B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C62E410;
	Sat, 16 Dec 2023 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC4kJolX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E928DB8;
	Sat, 16 Dec 2023 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3364a5ccbb1so1437442f8f.1;
        Sat, 16 Dec 2023 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702733669; x=1703338469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYkcCRj2aDyNKfpsjAbeqa50uCwjkKY1rnjchlV8BI4=;
        b=IC4kJolX9lb7dVy88nZR1JMFEtwzaXEMPuoYRDMiZeygzk/GtlCknW/uQTPZgmqbIZ
         21IN8ciNUr+VLYcEV6aIAw04mi9UOrPKaTrRfDCcEo4vqPKswKCp0trc7XyAFUQ3XICM
         j6O01MbwyvLfON+MR138/GvTXDCZw7FDnwYQlBt3NevtDfOK2lnxFcuGuV4VfTHqCDEj
         J3BnfpK5NIuJzcB5O92EAg7799Asv9Hzcu9CwTjgqfqGqio6du3BJ2h3P1rXzy25FfgG
         tpRx1P44w9nEdGTRcO29TbiPt03J9FMPiYSFuRcQKx/qxJgJWwD94yGswumaKdeKt84B
         Iq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702733669; x=1703338469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYkcCRj2aDyNKfpsjAbeqa50uCwjkKY1rnjchlV8BI4=;
        b=m5YpQEbHZrmjd17Eyvhgq7SMC8bizmVZ0mMMIQ451ndTMdayO2vW9uyIRNv/lE9Owh
         osvwVVjlNUx+CZFTZPllZz6FF6D8e1ceDNFjXB82P7q9EHPObwvQCV1mI/G/56AH8kFN
         fKqHPx+wVnr6U81kSJgKpUla1dEzm9tMAEGIBYHeB567YFC9irhYf4hYKsk0Rs0LPvMO
         U3zrxoj85rLghicEeKT+l6maNyy6VxH3bYVIMJ/UgSgl4DWXUKS834XIO2kwuDaHK4uJ
         hbfhNai3CwouHqZAXXjcOEnxRBsEBq2vEuH/oNC004HiCE4h+ZGA89mQQ1S/pbyxI7sy
         gUrQ==
X-Gm-Message-State: AOJu0Yzv/7QbeuDyS4a9zUZwWTdH+m7BoTATvXija0WFJN1f/kXLbx/3
	aq1etjypc4jMIKNqiFWJVb4=
X-Google-Smtp-Source: AGHT+IG911xAhwr40S4ErD5qmHRV0PNM/nWBQsYJcAqJSi58EQSzDvjWDUWnf87Wfg5I7RBAyT+tHw==
X-Received: by 2002:a05:600c:3ca2:b0:40c:5112:a0b with SMTP id bg34-20020a05600c3ca200b0040c51120a0bmr4922033wmb.45.1702733668688;
        Sat, 16 Dec 2023 05:34:28 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l16-20020a170906415000b00a232bf6045csm423629ejk.63.2023.12.16.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 05:34:28 -0800 (PST)
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
Subject: [PATCH 1/3] media: sun8i-di: Fix coefficient writes
Date: Sat, 16 Dec 2023 14:34:20 +0100
Message-ID: <20231216133422.2534674-2-jernej.skrabec@gmail.com>
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

Currently coefficients are applied only once, since they don't change.
However, this is done before enable bit is set and thus it doesn't get
applied properly.

Fix that by applying coefficients after enable bit is set. While this
means that it will be done evey time, it doesn't bring much time
penalty.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 90ab1d77b6a5..34e099939284 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -66,6 +66,7 @@ static void deinterlace_device_run(void *priv)
 	struct vb2_v4l2_buffer *src, *dst;
 	unsigned int hstep, vstep;
 	dma_addr_t addr;
+	int i;
 
 	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -160,6 +161,26 @@ static void deinterlace_device_run(void *priv)
 	deinterlace_write(dev, DEINTERLACE_CH1_HORZ_FACT, hstep);
 	deinterlace_write(dev, DEINTERLACE_CH1_VERT_FACT, vstep);
 
+	/* neutral filter coefficients */
+	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
+			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
+	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
+			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
+
+	for (i = 0; i < 32; i++) {
+		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
+				  DEINTERLACE_IDENTITY_COEF);
+	}
+
+	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
+				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
+
 	deinterlace_clr_set_bits(dev, DEINTERLACE_FIELD_CTRL,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT_MSK,
 				 DEINTERLACE_FIELD_CTRL_FIELD_CNT(ctx->field));
@@ -248,7 +269,6 @@ static irqreturn_t deinterlace_irq(int irq, void *data)
 static void deinterlace_init(struct deinterlace_dev *dev)
 {
 	u32 val;
-	int i;
 
 	deinterlace_write(dev, DEINTERLACE_BYPASS,
 			  DEINTERLACE_BYPASS_CSC);
@@ -285,26 +305,6 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
 				 DEINTERLACE_CHROMA_DIFF_TH(5));
-
-	/* neutral filter coefficients */
-	deinterlace_set_bits(dev, DEINTERLACE_FRM_CTRL,
-			     DEINTERLACE_FRM_CTRL_COEF_ACCESS);
-	readl_poll_timeout(dev->base + DEINTERLACE_STATUS, val,
-			   val & DEINTERLACE_STATUS_COEF_STATUS, 2, 40);
-
-	for (i = 0; i < 32; i++) {
-		deinterlace_write(dev, DEINTERLACE_CH0_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH0_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_HORZ_COEF0 + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-		deinterlace_write(dev, DEINTERLACE_CH1_VERT_COEF + i * 4,
-				  DEINTERLACE_IDENTITY_COEF);
-	}
-
-	deinterlace_clr_set_bits(dev, DEINTERLACE_FRM_CTRL,
-				 DEINTERLACE_FRM_CTRL_COEF_ACCESS, 0);
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


