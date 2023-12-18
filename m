Return-Path: <linux-kernel+bounces-4198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6087981790A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E0028335D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2A7BEE5;
	Mon, 18 Dec 2023 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZypryEv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A574086;
	Mon, 18 Dec 2023 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso42616961fa.3;
        Mon, 18 Dec 2023 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921274; x=1703526074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIwzcax46A46ItNbQ7ZCrC54+Ug7OcXYl/iMtTi3jXI=;
        b=kZypryEvoFfLSzH0Ni241v+8l/vZnN7WareyrSaFiVe22FZ3W3y+05eNBJyOW5rP7+
         INtWG37unttZEfblN7UriXKa44CSke4rtNFSSxmYypLMOo7tHXkOY9WhBcTFsQuEI8bs
         46vkDkwFq5hAG4NhEk5m2urE+NvFkahiY7c1joWDIhWw21D5ve6VVt6LjQMpD0VjOURM
         qrKy0BnDb8fHZJrhCTRHvFFW+9gM8pXGD1ABInH5fngdRm6LmDuqedPeViohkna+bfkP
         HazZe5TRU804aZGlsVJCD9VLj/Z/zYZQrG4Pw+KIL218vpEQ859N3Q2TAkLS3XMtXQc0
         Y16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921274; x=1703526074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIwzcax46A46ItNbQ7ZCrC54+Ug7OcXYl/iMtTi3jXI=;
        b=GpXzkzSMwBillItMc27IRlLC8uZB1+FT7Yf5H55R3cUsma+oYl6exkFy/GinyosAeX
         qQGefQRzYz7mkEzltW1vG1Hmy8hFrL822C2qzNvr8tj1oNDEDygkUwr5XG1BwKg/pOW7
         AXfyzKRyen/SZSOdGpvMR1MVwY2wd+t2mPuVcQdLCkj15Tg/A/5GG0IWL2FTxAfWfCa0
         IP6HnuZYIQV9FzWtxgW7gi9/c2AGERfzCeuLLoxGHvX+30u7NJd7Pp32FNnp3R7wW2Q6
         T29gWrB3hyBr8/etHSAj3pk4yrs8kMtrFgVCM0iz6QbYEhDXD9yLGS1TAtu4JM4qg5H+
         NBjw==
X-Gm-Message-State: AOJu0YzIRpBZYed0S/IIs9FYylWL7jowAuAfS1S9T9MeA+VUFmAab+QS
	rBCjgPLk1JQn2rqvSLeJsdC8Vq+3bDG9Mg==
X-Google-Smtp-Source: AGHT+IEBNWfcbcWCGaGFrxIgQ1i2BeJaXMZ+icuzr+MbhXAPm4xz81Q4UnfrAQqpzBb8Q/PWRET/9Q==
X-Received: by 2002:a05:651c:149:b0:2cc:671c:a449 with SMTP id c9-20020a05651c014900b002cc671ca449mr1515868ljd.2.1702921274379;
        Mon, 18 Dec 2023 09:41:14 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id d18-20020a05651c089200b002cc782cf190sm210269ljq.72.2023.12.18.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:14 -0800 (PST)
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
Subject: [PATCH v2 13/20] media: i2c: ov4689: Implement digital gain control
Date: Mon, 18 Dec 2023 20:40:34 +0300
Message-ID: <20231218174042.794012-14-mike.rudenko@gmail.com>
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

The OV4689 sensor supports digital gain up to 16x. Implement
corresponding control in the driver. Default digital gain value is not
modified by this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 6cf986bf305d..579362570ba4 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -35,6 +35,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352a)
+#define OV4689_DIG_GAIN_MIN		1
+#define OV4689_DIG_GAIN_MAX		0x7fff
+#define OV4689_DIG_GAIN_STEP		1
+#define OV4689_DIG_GAIN_DEFAULT		0x800
+
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
 #define OV4689_HTS_DIVIDER		4
 #define OV4689_HTS_MAX			0x7fff
@@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 
 	/* AEC PK */
 	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
-	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
 
 	/* ADC and analog control*/
 	{CCI_REG8(0x3603), 0x40},
@@ -624,6 +629,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 				OV4689_TIMING_FLIP_MASK,
 				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
 		break;
+	case V4L2_CID_DIGITAL_GAIN:
+		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -654,7 +662,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 12);
+	ret = v4l2_ctrl_handler_init(handler, 13);
 	if (ret)
 		return ret;
 
@@ -697,6 +705,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
+			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
+			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0


