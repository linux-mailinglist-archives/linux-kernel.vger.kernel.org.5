Return-Path: <linux-kernel+bounces-128381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFC895A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B8AB27611
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193215D5B2;
	Tue,  2 Apr 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG1qv1qj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5115CD6D;
	Tue,  2 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076403; cv=none; b=RLn07N1jzffxT1uDQtolUCkIVjOVnIJhUS9Gp6UOZB+OXKbvqOpDWqCvoFGD6sVDYsE2MyZEn9PQ9RsdS8mlX9b9jGmTdmenEZD5YIXlqG7GJo/nBntDd9tcxN+mjjw7RYqw0ikbMiqXtK7o4SEmVH4//CJ64Qpe295KANd3SvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076403; c=relaxed/simple;
	bh=fm+9Qj0ImSfRv/WT2NnXJ+bGEL7DkTvn3MhzyZEvlkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBkDYC1qGj0rkq6FHTvi65KLmHnA6/gfFwF1AmQ/rQ2JjQk+HffTLRIBxH/sa86NZgmOcfhUYoFazcz4uax3hSiJcERQbZAqPqX6Y6F3HpN5S8YxkGYfVcQaO6KUvetDXbGdNo+SROnknKW4j9/T9VAvWB2NRe4wx7GahOcOwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG1qv1qj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d247e3c4so50341e87.0;
        Tue, 02 Apr 2024 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076399; x=1712681199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBDqn2uq/EwX2ij63DYOieS6gOnWId3qHXbEJvkO63Q=;
        b=FG1qv1qj/Bwkdpw9YJrCA/Uh4RxQIgKNXcTyAr5GwvKKqRH5d4xpXUkwxmEIXaaPt3
         XTXAulKvhAkJtFbfzej8RtfZ7Nk8jfNveqolM8HJ0Zcjp2DZH5xSIqvtX9uXuc67HEjI
         gV6PKbiz2mb6PP6NZeewgoGuBJ9wh+p51MsyNnsINKVCQ4hNGcvKLOCPef6FE69FSGVy
         0BpLpI11Npog+bsdZfHjUVKrx6Ahx3Sx/9nm+raXas4FExFQdziOEPqUIWPz0pOsMK1H
         O3Hdoy23u4omapoxrctuCUJuW1M0dLSqOkmY7ii5XsayitcGToSO+7VpS0BHjs4bS8Gh
         G6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076399; x=1712681199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBDqn2uq/EwX2ij63DYOieS6gOnWId3qHXbEJvkO63Q=;
        b=KVrwPwsC/JMaAjNsZ/8UAiyKJ0R1+8tP7D/YWQ/KLJpqxK5qQE48uPliacjB4YeriT
         nPk3pZCcFutC+K6ti2s5jLixDj4q//ml/DY6+wX5nZA7Nyl3ZEfCxWepCgFNL82ZpXgV
         g3jMm2WsMV7HXo/1MTGpEs42Il6lPPjZLmHzd/cjrlZOQPdZxcPTv37CXtaAbv/UIXuJ
         W+Mv7twWtGEJXDGSHyVyuBCKoWfwdGy4/V7yksIzKo4zEBQmTvlGLozlFlnwBoZ0p26W
         qxxU3Zk7du57oSSWeHADqh2pXYxTquTewwGkpNznvLE5exRA0ucRDPnV/Xz65aJmNMcn
         3AVA==
X-Forwarded-Encrypted: i=1; AJvYcCUfYMMBFoGR8rCqtcftiuEdU3PWgBvjM0nUww8469TQ8SHaXBfJ90mR/Y5MD9n3Hkxwi6LyAQoE4qjc6osFE9qFqO0U9FnXLRpX7EHf
X-Gm-Message-State: AOJu0Yxng3WhD3mo50nnt/fZBgVHqEAyc7O8IsF+H1jHmgAal6I1y8Z1
	TecEdDEdVtGemRVB3G2Hh363R2ORCtwcGjEUpPJoATg12DHtB9GRRq5a9f8c9eRm9A==
X-Google-Smtp-Source: AGHT+IEUKDNimLZDeJfNJ6r2N4wIjWADJNPM/1cc+QUzFcKIAWiS6QLWGvuPsKpKug+0UhIj9POTJg==
X-Received: by 2002:ac2:53ae:0:b0:513:cc74:992b with SMTP id j14-20020ac253ae000000b00513cc74992bmr18692lfh.19.1712076399034;
        Tue, 02 Apr 2024 09:46:39 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id k17-20020a05651210d100b00515c8ff6f52sm1741308lfg.229.2024.04.02.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:38 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v4 15/20] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
Date: Tue,  2 Apr 2024 19:45:46 +0300
Message-ID: <20240402164552.19171-16-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pixel array dimensions and default crop size do not belong to the
ov4689_mode structure, since they are mode independent. Make them
defines instead.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 28470627ec45..fe7d095dc51c 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -70,6 +70,11 @@
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
 
+#define OV4689_PIXEL_ARRAY_WIDTH	2720
+#define OV4689_PIXEL_ARRAY_HEIGHT	1536
+#define OV4689_DUMMY_ROWS		8	/* 8 dummy rows on each side */
+#define OV4689_DUMMY_COLUMNS		16	/* 16 dummy columns on each side */
+
 static const char *const ov4689_supply_names[] = {
 	"avdd", /* Analog power */
 	"dovdd", /* Digital I/O power */
@@ -90,10 +95,6 @@ struct ov4689_mode {
 	u32 vts_def;
 	u32 exp_def;
 	u32 pixel_rate;
-	u32 sensor_width;
-	u32 sensor_height;
-	u32 crop_top;
-	u32 crop_left;
 	const struct cci_reg_sequence *reg_list;
 	unsigned int num_regs;
 };
@@ -254,10 +255,6 @@ static const struct ov4689_mode supported_modes[] = {
 		.id = OV4689_MODE_2688_1520,
 		.width = 2688,
 		.height = 1520,
-		.sensor_width = 2720,
-		.sensor_height = 1536,
-		.crop_top = 8,
-		.crop_left = 16,
 		.exp_def = 1536,
 		.hts_def = 10296,
 		.hts_min = 3432,
@@ -385,8 +382,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state,
 				struct v4l2_subdev_selection *sel)
 {
-	const struct ov4689_mode *mode = to_ov4689(sd)->cur_mode;
-
 	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
 		return -EINVAL;
 
@@ -394,15 +389,17 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		sel->r.top = 0;
 		sel->r.left = 0;
-		sel->r.width = mode->sensor_width;
-		sel->r.height = mode->sensor_height;
+		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
+		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
 		return 0;
 	case V4L2_SEL_TGT_CROP:
 	case V4L2_SEL_TGT_CROP_DEFAULT:
-		sel->r.top = mode->crop_top;
-		sel->r.left = mode->crop_left;
-		sel->r.width = mode->width;
-		sel->r.height = mode->height;
+		sel->r.top = OV4689_DUMMY_ROWS;
+		sel->r.left = OV4689_DUMMY_COLUMNS;
+		sel->r.width =
+			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
+		sel->r.height =
+			OV4689_PIXEL_ARRAY_HEIGHT - 2 * OV4689_DUMMY_ROWS;
 		return 0;
 	}
 
-- 
2.44.0


