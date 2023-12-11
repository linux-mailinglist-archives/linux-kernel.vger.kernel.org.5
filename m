Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260A80D495
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbjLKRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345094AbjLKRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D6D10A;
        Mon, 11 Dec 2023 09:51:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bce78f145so5436684e87.0;
        Mon, 11 Dec 2023 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317061; x=1702921861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk40BFqdM79fk23xCLVJrMhVtoRWFhktaIF9x7isDYY=;
        b=HdHtrTjceu0y62/Z5hRTF96op5Gr+rIXq7tgU3EVHD9/bjxf1x0/bD1uqBnRoO2EAU
         41QjMpShVtJmwYc5gNqaOrQKhfh/SuPD7D7W2lrblmtscLrCpNexm0cseAumXY5Je0aq
         gfp3aopdeaW3TWsTqOWz0doDK1bmed0miGinr68608kic30+cOEA78sUv8jCGr/TVvCI
         uaz/GkgZlWJC8uj0OdeNeLc8rno+Mokn5lCQq1NOw4h6CkUJjVOtt/eScozWTYjoaoqa
         ShJBgibm7jF5RlG2GcYzO71gKFuNmN93UG8LpSgbOvVHZ8IkekVW7/3qrUk/Mmso1Mx/
         GyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317061; x=1702921861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk40BFqdM79fk23xCLVJrMhVtoRWFhktaIF9x7isDYY=;
        b=HNq7DaroZrIJOfhLOoMhyX2dMIsXcFU/UttMwnZ2GXMiEqGtW+v2x1DBf4XqOQ2xQn
         PQS+mPa2IEbG+AGVE8HtNqk2nBap1cpMX+XMJsFuQAlrKdazJ3CtrlYXy6eVU7iq5A8B
         cm7LpkM04oYvkLK0dH/RKqX49II59+9B7Ys/AxyVpB2tWLWPghFFCwJ8UEOFD/ZQvOB/
         5RdmIzJVejBAt2OjEEbIzcANbMJFdFf1Pz9Guh2F1N1kulLT85QjBSNzwGirTG/ZtjMx
         inPd6LJmn/IMmrw/Mgm40sw144G+ufAqhRz4bd6xFahslflvizw8gKFqB7QvfDTWlR77
         Bosw==
X-Gm-Message-State: AOJu0YwZKtNcnxNK8/Yw8BoJE6ee9Y886ZHRDcymWCZQwlK8g+MBkRMx
        rlPOHsQA7DAetBnEAcsOThjm+4pJAAwZ5uqv
X-Google-Smtp-Source: AGHT+IFe8gf7KEsqd7IjxuDCvtob/zVeC6BjjnFSLHAEjkwulgdFY5EI2VYQvLpkrXnYRAS9o7dqAg==
X-Received: by 2002:a05:6512:3a88:b0:50b:d944:bfe1 with SMTP id q8-20020a0565123a8800b0050bd944bfe1mr1234818lfu.163.1702317061343;
        Mon, 11 Dec 2023 09:51:01 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id cf16-20020a056512281000b0050df1c4149asm605479lfb.273.2023.12.11.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:01 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 14/19] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
Date:   Mon, 11 Dec 2023 20:50:17 +0300
Message-ID: <20231211175023.1680247-15-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel array dimensions and default crop size do not belong to the
ov4689_mode structure, since they are mode independent. Make them
defines instead.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 18e1fd564ec0..5acdf9e1b670 100644
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

