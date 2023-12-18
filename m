Return-Path: <linux-kernel+bounces-4199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED72981790C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D17B1F25E67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0A7BEF3;
	Mon, 18 Dec 2023 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDib+SPD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BC740BC;
	Mon, 18 Dec 2023 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc4e15605aso39825581fa.0;
        Mon, 18 Dec 2023 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921276; x=1703526076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dk2TKVbYraAu74v7NaSM1t18f6z4SZSFZ1EWmH7B+A=;
        b=CDib+SPD87rYhO6EsoDjcOkOa9D5nY3ajlJLmrSUA0wyDAIf6YousNX5lf1isnD/d2
         ZmmGogeQoyj+JEcE2c9U/K/4j/WYgJfNWsCkgq74f8QMaO9Vbco6QeYyCvC0b8IIll9M
         1ooU2RrDH3ci9apPmbbno5VzK1241YK4MM7UFzN0RfcsG92av9ddt+8iJYPsUUeqhiKM
         1AOFGqGOICeHEuB5WOy/2V503t2nlGcPLYXn9CIAuAuO/L71cG8jwFma829vE/gSJvY0
         31Gw/yKPGPpe8A4yrpKZ3jfKFM/cgzwWN4LFpZ7pB38hqEFhFfVvAjZes1V/kz2IEjE9
         haeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921276; x=1703526076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dk2TKVbYraAu74v7NaSM1t18f6z4SZSFZ1EWmH7B+A=;
        b=pDYOZAdKJj052vjHI8ZNN43oUdtnSzPG4yc95OH/TkUei9QiBvj1evXE+P0yP0TTws
         Y2oQrGPxc536h2FOQEZKiYgNwkfuiD9KUODwEgIy+MGjVry49CewiTuCip3fuLOBGtNQ
         GJ2usShDtuF5omwl5lUv3tM1KVIsaRwZ5jixuVNtNPAw3OeBnXrRXYBofObS+OObUHS6
         qEArH3VEM5xQDe5hNa2kShXxFElPkJuljzjTa03TY1R6Gh2rd3Sq8PV499gl96vC5YLu
         5XP2EtV+yd+QNmIWl8MEcJaO43ywS9FiwZQkvNi1tVOwCQxNiozWW7A/Ffxr2LMYMR8n
         SXtw==
X-Gm-Message-State: AOJu0YzfwLhjDCGQuSeNSFRX1QcVaWNdkFoZla+9ZVs+nRUgKLDtUI15
	QF9SbwAguXOzPACnRwimQu7sSgWA6dbfJg==
X-Google-Smtp-Source: AGHT+IGKWDiozrtpr6qFpU+ktcXW+LOrfaN4oJ191M+u5ciwj+4UpK4tleOWT5p4t+1Nr+FPWXmtRA==
X-Received: by 2002:a2e:998f:0:b0:2cc:4547:1892 with SMTP id w15-20020a2e998f000000b002cc45471892mr3267791lji.34.1702921275695;
        Mon, 18 Dec 2023 09:41:15 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id d8-20020a05651c01c800b002ca34ad9e8bsm3563871ljn.138.2023.12.18.09.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:15 -0800 (PST)
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
Subject: [PATCH v2 14/20] media: i2c: ov4689: Implement manual color balance controls
Date: Mon, 18 Dec 2023 20:40:35 +0300
Message-ID: <20231218174042.794012-15-mike.rudenko@gmail.com>
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

The OV4689 sensor has separate red and blue gain settings (up to 4x).
Implement appropriate controls in the driver. Default gain values
are not modified.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 579362570ba4..b43fb1d7b15f 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -56,6 +56,13 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
+#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
+#define OV4689_WB_GAIN_MIN		1
+#define OV4689_WB_GAIN_MAX		0xfff
+#define OV4689_WB_GAIN_STEP		1
+#define OV4689_WB_GAIN_DEFAULT		0x400
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -632,6 +639,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_DIGITAL_GAIN:
 		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
 		break;
+	case V4L2_CID_RED_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_RED, ctrl->val, &ret);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -662,7 +675,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 13);
+	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
 
@@ -709,6 +722,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
 			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0


