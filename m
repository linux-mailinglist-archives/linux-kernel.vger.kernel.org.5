Return-Path: <linux-kernel+bounces-147716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BBE8A7815
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDFD2849B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9A13DBAD;
	Tue, 16 Apr 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amCj3tS8"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1713D60A;
	Tue, 16 Apr 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307552; cv=none; b=nESaffBT2PgOIBeRO5stXA3HbQPGG8Ppyjd4GYo5GmduXxlxZEbnwku/pi6LJ7L2aiJTRkyVbrWT7Ecib9e4s2+4Fa6T4ut99cbbAVJT3bfq69zqRgUdEmLcwZuGdo9MQe2GGE3Tx5/PMxJqMlODx+LXy3x3L0Jvdg+6hPcemZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307552; c=relaxed/simple;
	bh=sLICh8uWL/pFkYZmub7k1MwFmB7JItN36Hx/5frbUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taX8UXIvXspKUShBOBivWNprbiZbN5xCN35VrUk8lRehqijdCMKqb/12hzB6FxdzueSrISoLRPtCCGvaAhA1YsxAktPqpGHupPJlOis3eaiRp+moSwaHXy0yvi1mCPYVJCX6WHmKq113mJtsy83sJkzQ6oacawVCI37WZNX0hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amCj3tS8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6c1e238so5889630e87.2;
        Tue, 16 Apr 2024 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307549; x=1713912349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNrZ+v7tBZ68Mo8D5/6+veCro3vnKNVEByeT1M+GGEA=;
        b=amCj3tS87BvLGuDZC0e/eJQBGYFUraUT39hgbXAgRvNXCBLUrqcVIlhdeJHINXX/Gf
         kPk0NS6hBZ0NoDPT0sMyfPK3cMJp8TnhoWVXGhutiEFLsI6OjvhHskxQOXlhilYT96A1
         GAPExUzKLW0p/7qN9ElAgATrQM93ocb/qlTNydbq/xm+4ZAFAFYVX9azShbZEWS6gWLT
         kHGBAW2WNR2eQA6UpcEjCtnVkVieOjpG95boRk0IPL4wt0B1fr3dlRovlZRl/fOT2P5e
         TOY4H3qCeFpeeibpmp8V79mxMX503KM3OSHMSWUXkevyPiQfUxDoMRwGZ8rqIOZsCR0M
         3MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307549; x=1713912349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNrZ+v7tBZ68Mo8D5/6+veCro3vnKNVEByeT1M+GGEA=;
        b=PNZDG/VQLEHTG0edjuaeSyfSjV/N535DD/9LJwnqtTwlxcWBmdkK2X9RSOGwQEcaxO
         uKRwlIQQ7TDPSS128xeqs4b3WjjyYHIqjvLVTWBfqkaM0K35gOnfiwqBztovQjP80k1E
         ettw+vFcRDyCX5ON7t5BCZucQKmvWzWHpHYpjSzP0EKOg1MjTF6J+sTlXjP3ap82N7at
         rvsZdhpDH9e1KJ0znqEAR2Dpjh8GIzb3BttuubPpX2U/z/Nhom4AO0mlBQ8mdpB0L6vU
         YiUXjsOKYFj0TrBIbB0MbRTbPmcUYl/xXI3LqbL39OgS+AuZc6zTycyQuUxdaTeL70bw
         ggOg==
X-Forwarded-Encrypted: i=1; AJvYcCUwj8m06auq5OvfKQsQKZg38422+O/vJt+cSEZV8QhkvNjpi8OHsQmGrYk3TKE2w74BrmfjY4rr+mvr/vH67yipNhEJw4I7RFwERqQW
X-Gm-Message-State: AOJu0Ywbw8uR6FX7vVEAOIPZOCa/ypofGMITcbXzEKiTFMY3/fxkc6SE
	2ViTPwIOAnzyUuABG/FeZ6xEQ9+A7F/WeEzp3xXMPpUP6zGaMKFnXCcZe0YWxr8=
X-Google-Smtp-Source: AGHT+IGymgJktXLd90G06oaSwmUX2LOPBgoVgIwP8g2xxsJea7dBlERLI7/P3Qk/sa0qrtFKfqjozw==
X-Received: by 2002:ac2:410a:0:b0:515:bacd:adbf with SMTP id b10-20020ac2410a000000b00515bacdadbfmr8584259lfi.34.1713307548463;
        Tue, 16 Apr 2024 15:45:48 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b00518e3a194e9sm800817lfe.304.2024.04.16.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:47 -0700 (PDT)
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
Subject: [PATCH v5 15/16] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
Date: Wed, 17 Apr 2024 01:45:23 +0300
Message-ID: <20240416224524.1511357-16-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
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
index 81153b1a49a5..9da4f84e63b1 100644
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


