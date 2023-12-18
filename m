Return-Path: <linux-kernel+bounces-4189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76358178F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4811F23EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1C72074;
	Mon, 18 Dec 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNeuCI9/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACB73462;
	Mon, 18 Dec 2023 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso4627494e87.3;
        Mon, 18 Dec 2023 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921265; x=1703526065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRAVS4vC9ni6nFv/TOVO0tDXxMYBMHf0gL/d3MqoeLg=;
        b=eNeuCI9/n8IPTWNx30Fk1ROiHUtsmOZcgYTGHFJaoRZeqYcl9rCewx58shHDR1REXr
         yO2PHSUgJMVEkLVD5yeFNdZgyUlTPCUp5/V30l8q9zTcdIC/355B+50lDCScOsTNLCPz
         oWWvRLkUklIJe9BfjU3Y24Ulhp+xwlss7+uofV/rSGtw3rMXqXqOEmMbzKjBWXbc3Ktg
         ZInWIk0iumOtGAtN5zKXNwNDDZ5ZN55cnhhtdpEgDRLoTCbZL4gtSJdRLFLFrrGOqXmW
         0aa3EGUW8VUyXoOXmy3wnCDShI1zn4sbIwVzjHJYeoZGK9P3OB06f8dFRoNLbL/ZT7N0
         f0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921265; x=1703526065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRAVS4vC9ni6nFv/TOVO0tDXxMYBMHf0gL/d3MqoeLg=;
        b=iYt7o04uzR1mKjf9VeuLd8yDcHfwdlukYQ03SjK4V4GUZFx+Yviln3+gbFkaeMDzVr
         m6J7f8+3NgY+GLb9N48IQa56GitkaY6JNotUzkO+nzGD1Rguk3Ymh9n3+EonL9dnDyfR
         AOpS8+qXLnyqO5oxO1NoVpJWvHUt4b9EJ/q/PUixFDLGQRWzadcH7BzhoFm3NHLFy/EW
         0hNQyAgukry9m8y4jjG9fsu2ypaZfkIU26asApRtRQGEuZQ9Ay/aEqFb3Og+h2cxeBgC
         gSLEtyBcLhuvEfnsarhMLC187wTArb8AvZUwVSLBbdT1SOOXl+9VXZmllXkpJ//GyWG9
         pDlQ==
X-Gm-Message-State: AOJu0YwYuuFCw0ifx3GmIBZpEZrrd7Zn/5T8iwUR1qjkBN7xlbApsFgQ
	yq+s1oL1M+2TvH8Q/pM7Jou4+f1LHC9xMw==
X-Google-Smtp-Source: AGHT+IFuVh3NnbRkHJJQpPto8uz+sG7n1PpAvbfvBBjPePQSJZd4LNqyRfmPpOoi4pv+MbeYIiK9ZA==
X-Received: by 2002:a19:6d0b:0:b0:50e:2e79:eb2 with SMTP id i11-20020a196d0b000000b0050e2e790eb2mr1602734lfc.14.1702921265055;
        Mon, 18 Dec 2023 09:41:05 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id bi6-20020a0565120e8600b0050bf44d0d23sm2947923lfb.20.2023.12.18.09.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:04 -0800 (PST)
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
Subject: [PATCH v2 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Mon, 18 Dec 2023 20:40:27 +0300
Message-ID: <20231218174042.794012-7-mike.rudenko@gmail.com>
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

Introduce local variable for regmap within the ov4689_set_ctrl
function. This adjustment eliminates repetition within the function.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 3b20eba59c9c..d42f5d1a1ba8 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -580,6 +580,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct regmap *regmap = ov4689->regmap;
 	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
@@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
 		/* 4 least significant bits of exposure are fractional part */
-		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
-				ctrl->val << 4, NULL);
+		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
-		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
+		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
-				ctrl->val + ov4689->cur_mode->height, NULL);
+		cci_write(regmap, OV4689_REG_VTS,
+			  ctrl->val + ov4689->cur_mode->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
@@ -625,7 +625,6 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	}
 
 	pm_runtime_put(dev);
-
 	return ret;
 }
 
-- 
2.43.0


