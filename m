Return-Path: <linux-kernel+bounces-4200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2F81790D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111762850BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626B7BF0D;
	Mon, 18 Dec 2023 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzD3u9KZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826B79955;
	Mon, 18 Dec 2023 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso4627940e87.3;
        Mon, 18 Dec 2023 09:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921277; x=1703526077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SjlvAuV+ITVZU87l8JftGavoBHWbV2WagI03hZeup4=;
        b=NzD3u9KZ6UbCKI8H7DB1Z3O7fH8g3PkrclL6XA/Wn8Gp4jCt4ozpGz1fQRdG7ykA9c
         /s4gAaTORzIqOiduM403whLdWgr0dXbK8YHoyVm7oSPjoNU3k5WBkpWkB9/gH7v7OloP
         mGtM2kc6SEWZSDslkfncHQhnx8vHtZr2ks+nYAc/pbK2h9wLWWuW77bNiRc5HT3TRPRM
         g2UdkNFe4XP0o6cfaDHakr38O783eQhJQeAtpXn4vU7rcoHR3H5A/f2ufevoO0Nq5SUx
         nPZPOQ2ct03xuK5BzRd4Bi04xljL4hITeVSwTvGKr/SZlj5oCZ+gvYf/WLrFTL7wAq9t
         ksdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921277; x=1703526077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SjlvAuV+ITVZU87l8JftGavoBHWbV2WagI03hZeup4=;
        b=Ca3YdSxwHNcqjksxti0zSct4SFbCJAS3unlCIKXOr6YrRCt0kDCfTJCqoVbXqTQb2x
         mDBdPf+N6iz8nQuWSx6hSHiFo9PF5TuaR7/unq5Kzg/d/GmCcMhJpKBtW1SJ2HYPHJw7
         ZwnS9h8m2F4q4b/CgQYg83TlQwLeR32qifHIq6W6DBP9n2X6FSUDOceF00w5jCwJoY/X
         XDK+Bymk+F619qDkT+62okgs22iHtVoXh9eBberecydnPz0MhlezZWWx7tXRNiK+xax6
         tlWt5TtX8uFfm2txN7zF7cX5vSeegreLpq8eY5YUcgu9HQIUfJF3MU/nZneIBivoUcwr
         uwjg==
X-Gm-Message-State: AOJu0YxkLZnLCF4I/s8Web6HdWrwWoGxKkOAVjGiOi8T71lYGZCzsqur
	25GHnU0XxIqFkrTTDKojTTMGh05MvGd5xg==
X-Google-Smtp-Source: AGHT+IEpHBMcQFNgHrRtF7STxyBad7yeoLMk3qAFvX+/l/O6so3UTpn9p3QJpE9w7exXQyhfLJ9k9w==
X-Received: by 2002:ac2:419a:0:b0:50c:222b:2489 with SMTP id z26-20020ac2419a000000b0050c222b2489mr6965947lfh.135.1702921276912;
        Mon, 18 Dec 2023 09:41:16 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id f9-20020a0565123b0900b0050e3b2646a0sm265645lfv.152.2023.12.18.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:16 -0800 (PST)
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
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v2 15/20] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
Date: Mon, 18 Dec 2023 20:40:36 +0300
Message-ID: <20231218174042.794012-16-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218174042.794012-1-mike.rudenko@gmail.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
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
---
 drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index b43fb1d7b15f..475508559e3e 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -70,6 +70,11 @@
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
 
+#define OV4689_PIXEL_ARRAY_WIDTH	2720
+#define OV4689_PIXEL_ARRAY_HEIGHT	1536
+#define OV4689_DUMMY_ROWS		8
+#define OV4689_DUMMY_COLUMNS		16
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
+			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_ROWS;
 		return 0;
 	}
 
-- 
2.43.0


