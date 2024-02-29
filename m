Return-Path: <linux-kernel+bounces-87121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12286CFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FA51F22A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFD13F45E;
	Thu, 29 Feb 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adl+gWQu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8313C9F8;
	Thu, 29 Feb 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225650; cv=none; b=sdgnFZzGzRmqQ7CbuJCs2w+1I4XrK12X5yiAolDll5vcDDk+xWYJ/zP7H+cxaJUEyCNZaPVEPhTiQ9VcEFxUGDLxgWtc7rBmK3XHg7qiTA1jKZPVu77bSBX079kkAtAReIKCMgRI0cj3Ex6mLs4ZJIZm6WxxObY4KQNaVAK/F/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225650; c=relaxed/simple;
	bh=2qah5IkORwbyRN5g2N/9fCCwXEmTYgvXO/Gtw9Jlpe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg8CYIEBeL+kxHXNa1RndS4QgW99nvvCaXgn+0can1WJSPE7kjsv3ab8oTZyj4BE4gab8NzMNKsr8TF368Wg38+I6zRROZ2KqrVcMhAj+7eOR/YyltT5K3CFZ9gSiS1fhnkhlnwIKEM1pBADy8Dk/0NkX922iSnwtHdIYiTVnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adl+gWQu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1241449e87.1;
        Thu, 29 Feb 2024 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225646; x=1709830446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJQkprQQfQSNaHlwTiO4ZnGarK6Ad6c4fE/9ick1hRU=;
        b=adl+gWQu/8gAEzvm1GjIrxeWp80wpuK/hu5mPAmTCIb2DfsCr0flt6q7Ikk3miKx6O
         mCM/HDGhj0A7lz7hH6hmNLJ3JeqZNF5Tb5FzGp6vSvVbw43FcpKhXKMzHeKrH2IquIIm
         jBCFYW5/mY5OQl5dz+uEmiEMNXmdFdOFZw2w8aF9Y/WwKtpcBTIsNu3F3P8wnx+oaH07
         77oacxqq66r1vE72nUZEtccdf3cQ4IbFymg9NkJolnptxfptMB00MjfoXLPn3PuMh4cN
         8JZujsky+NMqTDS3TTGbI8p4KOVb+Fdwqxt8FhI7+g1HN+6o8Hw1M2sEpsidmnqfYWWj
         DSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225646; x=1709830446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJQkprQQfQSNaHlwTiO4ZnGarK6Ad6c4fE/9ick1hRU=;
        b=hMZztm6aD4Msem8h6Im657fdfTAkV/YiC6ITEvdC3b0J+psF19yiGc1UjsCEYM+A1x
         /670iP2s4si5rvhNawwvO39mTEqogcdblbTIgAVmaRKhB6cAldD04nZdwkMui1ztE/vB
         KrB9n/56G8p60GAowoWQIPTqcri15V8Q4X+UllYMyJh3e9WjPNIIeR3P0P0pM9BOMd7/
         1PbVwB00fKjHNP8jMUmAEEdwL3FgiE2AeVyIbcoQmnc1T0+m8SrFX7QgUHOUBW5KdkGZ
         BIhoJMaH+d47HS0pdNdvuhZuWRcfuJtgKKkFd7Iu6eEaSrXhEFDzjV/bxwYQsmuELhn7
         kzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2O1xEWTND4w4Jr8zERghPh61M/yVoA/uTJqA8uhY2BWD1lv1CBZw9/hAopJ4uLoXkFqYZdT5Xeubf8jzM3GxTJx5nlfLQjMTfYgcA
X-Gm-Message-State: AOJu0Yx9++CHW0MyT6MH4LNgXmdFHCbAVo2Aj2/px5I1W4Do7TxSKbsI
	Nk/Mn4GafWKGLA2tjmZWsTbenFLuzeW8CcCB5iuNb8BU1bzrFk1J8GTftzR3rC8=
X-Google-Smtp-Source: AGHT+IGgV4XtE3FxovmT8emaKq3AzzO+2FM+TQqplSxR4HKjK1CewUfqoSVcJ2DNA2awPGfgaCnbCw==
X-Received: by 2002:ac2:5599:0:b0:513:25c6:e98d with SMTP id v25-20020ac25599000000b0051325c6e98dmr1590452lfg.57.1709225646535;
        Thu, 29 Feb 2024 08:54:06 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id dx13-20020a0565122c0d00b0051255cbaf06sm310317lfb.14.2024.02.29.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:06 -0800 (PST)
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
Subject: [PATCH v3 15/20] media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
Date: Thu, 29 Feb 2024 19:53:28 +0300
Message-ID: <20240229165333.227484-16-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
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
index 6c36fe5f3b44..cc8d9fa369e7 100644
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
2.43.0


