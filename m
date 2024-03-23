Return-Path: <linux-kernel+bounces-112343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D48878A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1781F2403F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C253E2D;
	Sat, 23 Mar 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK46ST+P"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6047F46;
	Sat, 23 Mar 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196451; cv=none; b=UrXutuQpFHOGWm8kVjyfdZClky5qK/MTnqMwIgS6aeFDOa5a1aBrRvcIBO0sUmo721CtpVpP9Hp7GXmRsBI4dWi7S+qmEcz5TIlPVvnaW0EoxzIsRqkY42MxHP66RmmeKpGlXkPOBCGtASm9EiXpfyFzXWUGbRqwcRPvVbCCHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196451; c=relaxed/simple;
	bh=+hksS7cYoCxKlnPaPD0csY/wWZfTxuNPy2blg52hfXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZdDSOobr7SIW/KCFv/JDA+GE3XLqTHfbY7xIWzMZ2qRREXtiJ9vmZLwzBRRHNy0dlaoyQ9BhgsYiAY+9RjyZIhkaKS8Sxl8b8VgL3CPjrnFwgVJifnRpHD7P8HWi1NyH2gvjc6QLtJQy6OFvIZi8jVjz8zqR30bi7UIvqTxtI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK46ST+P; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513dd2d2415so3107914e87.3;
        Sat, 23 Mar 2024 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196447; x=1711801247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRpIX2NoDjrlLfYxowFXuiPiSun/0ui+T5NHiqb1OJc=;
        b=jK46ST+PEfq2ANsEPZu3HSTXmX/5lyUxBmpRh4xb1kGEhv7bK9CiyY1HzkE362Fzck
         2CgAwOT2EkEC+eISE/c7qVqUBvxnbWqevD9d+wmMexksX5W/H3kH2DWv6WpWpPVtaPTr
         XWnvwZ706S++HesywxOfKrTGAewVrusiQV2tkpbVX0nRChD5OTaTqfDqmaJ1H5K0acoj
         7ROqGwHIPGX5c3nCPMltFi/qRZEoIcXxDtMUI2Ep3jrLIkKUrlrhf/sVrkRPDe1v1buM
         58BCicjkU7drYCxFS1dNT7zaFEtMUdjqM2i6QtJl0jAAOPbpzLiDauTRCQOCBJEl51yB
         7cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196447; x=1711801247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRpIX2NoDjrlLfYxowFXuiPiSun/0ui+T5NHiqb1OJc=;
        b=vytiJT3WYpWRxKKsenj7nVEDtFprcpn99lwS4Gcr2eg9eAJ43HQKPdK24Z1LedYZSC
         hQAEuGP4BgJ/QJ+beJyIFmFrVtgZp2QRz9aNZAUBTSIlTLPR+NnCLmKPpQKuEMGIk6VT
         MtKpfL6vxmhG+anGyoYz82AaE+1mOdPfL/O8bidP03hrjcq0ILIYnDo+uEFNQXzyNkLu
         Ox/k9HQxA8nkRX87Y8zWc61bLKGlzi3AE9InQPO2po04p6ph4kZsaqDGtcd7xgcjX3ac
         IX4ki9GnoiwTFYqDPN1R8OSea8SyRI5Ns7S4U+mmeUQM2cEsSSW4wlYzhHbH1+zR8g+Z
         ab9A==
X-Forwarded-Encrypted: i=1; AJvYcCUEcGITihfY+WsHXYZPlh368HW6Yu1zNNeWloJ1RuP3Ofibw6vM1/zW7CTLb2BTQl4JxKCy0i3tfq27DzMZOUbALM3qlsAf9CcHt6iF//PuiR1/+VMcaC/REZWXY198hTdQlKoPSLkPGA==
X-Gm-Message-State: AOJu0YyWNi2T9L1SGYaSYbrhVHooC7DUiSnfpX6iOUq+IT8VmniDhc6c
	0jkhHuffBLxPSgMoKA+Hp3lMNG2do9/81JNbxUZ5W4w060oGQbD+
X-Google-Smtp-Source: AGHT+IF0wwBYKx6UbRzIZR97lSbHApfDdyvelMsJ0GtqeayZj7rUfVL2duFLpeOlwyLJ2lOjfCUJRg==
X-Received: by 2002:ac2:58c5:0:b0:513:994e:ace0 with SMTP id u5-20020ac258c5000000b00513994eace0mr1332346lfo.15.1711196447265;
        Sat, 23 Mar 2024 05:20:47 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 5/6] iio: accel: adxl345: Group bus configuration
Date: Sat, 23 Mar 2024 12:20:29 +0000
Message-Id: <20240323122030.21800-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the probe function group bus configuration and the
indio_dev initialization to improve readability. Add a
comment to the probe function to explain function arguments.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index e3718d0dd..662628cdf 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -209,6 +209,16 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
+/**
+ * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
+ *                        also covers the adlx375 accelerometer
+ * @dev:	Driver model representation of the device
+ * @regmap:	Regmap instance for the device
+ * @setup:	Setup routine to be executed right before the standard device
+ *		setup, can also be set to NULL if not required
+ *
+ * Return: 0 on success, negative errno on error
+ */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	int (*setup)(struct device*, struct regmap*))
 {
@@ -238,22 +248,23 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
+
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
-				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
-
 	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set data range\n");
+
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1


