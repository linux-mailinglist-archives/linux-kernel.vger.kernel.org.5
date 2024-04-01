Return-Path: <linux-kernel+bounces-127012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80E8945BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761A8282556
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2857873;
	Mon,  1 Apr 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbk4o9N9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC8537EE;
	Mon,  1 Apr 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000966; cv=none; b=BuXx0Pmh3V4r+S1ZvchgAkWUByg61fr892abm7z/WOhZGBhtBVhiBKTPN0GDIkPzyDC+lQBXreFO/xLIacrHcIUacQ0X/VkNB9n9dB0t+riJDoK62YzVo9gutavefaaah7Vwo5PFP0fplEFZFR34TqQGqQq2Q+GUKRvARh/U4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000966; c=relaxed/simple;
	bh=xzt8SWl3KHViH+zyg/KZwkq5Er+lLdNQ8lhXyZZqUSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1zBJyLNU7ZNe4NFREO4pimY/nU7zy4/53DPCtIeqOeV2iK4xTMy7c2cRxReZvXZ8BwZhgFD8uiI04xtYNLSerAf7/Swvvq7o5crODuaPpgAjk2L6prPwhLSyYKRLSUUyNH2sobUIuOCl85AkNgwbXKLV5qqeaBTagsH5Bo+8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbk4o9N9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5308974e87.2;
        Mon, 01 Apr 2024 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000962; x=1712605762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fubKQbTeDO83qP8OCWWXIez2ufZ9jRBr/4WIn+ZDMy4=;
        b=Fbk4o9N980oTc4ftqrtiHRMUjy0yanrvbE/Q9raMrRyLgYh0vxbQXcQFGcKAEJAzku
         iX6TTmOo8kD+oUUo1thQdJEirSmu68bCGQTsueUIh9GNVi/B5xN2SS/skpXzfAPS00GE
         yb8RTPsoPvlRj2dd1ISXLKb07jIIcE+1/Dqy4VDjAY1wthV2be84t3g1S456oiFyLj9b
         I9F9NM08I4QuG35da2OJVMmHCYNjUxVZJyCWMVh9JVlSeXZg/tAC9tyTVt+S4i16LfqA
         Hzu8K4dPBiG94XGw5+5THOuG5tZT0OnVq0K0jgsaH6aH+TDiddjWBt/mJMnMh0Ydy8Kz
         kwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000962; x=1712605762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fubKQbTeDO83qP8OCWWXIez2ufZ9jRBr/4WIn+ZDMy4=;
        b=lJzK0a4ByDVZwd39S/UerkCOyYW+TeFCOIsv47sUnBP1Fj2BaVOJDtJ1rCktzqYJ1X
         B8NS5ztorqv7ddaiqJePB40qCQabYSwnzjBarmPPoHfooiYyHlWWRa94cR7QrN3hvobU
         TyjjVFc303jBev/0viT+a3gOA+MDPmsWlbewt2w2Oy9LSKMz005ZbR10JximWyYRkIYy
         n4r4h6vy6xtbOHEWgjEJSV8mJf7ihdl/KIPV5SVaEGAPG4wzsTmvgAN0IzEy8Yae5Tgr
         FEsW7EyM0gZWkZi39FMFr+fi9LZ4Oi4GeAyiPKTq8WhEuKScTHg3qCrIDvy3kfvvHklK
         AFBw==
X-Forwarded-Encrypted: i=1; AJvYcCWjVaKHmRY0SOrKCnf4BpPgGt1yvS1f2AEgcu+a/81ZIM2TU6r7Xw93Hy/vpXUGBIBCm33vGW/WNwO/Le29Ln/eMzLkK1Nz/92T24bIl9O7xJ3WTPU4JbrMjGv6S/enjjtR0ziTTdXyLA==
X-Gm-Message-State: AOJu0Yycm7/XWZW1j0CX4zCDffWQttcdc+pONaOxkiho+kg8q44rKy5u
	UqaQQp0DRk3SQIRPWx5If4j5nIYY9dIaXNsPYFXbEFmPeAxKcsdx
X-Google-Smtp-Source: AGHT+IFs2YgcgCmIwTNWSK5hbDttoCc2wfGPCuEqFhF/STwWFgmVgNJfLymJYUoof8bjQWs0sIMjLw==
X-Received: by 2002:a05:6512:619:b0:515:9abe:6c46 with SMTP id b25-20020a056512061900b005159abe6c46mr6287650lfe.34.1712000962427;
        Mon, 01 Apr 2024 12:49:22 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:22 -0700 (PDT)
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
Subject: [PATCH v7 6/8] iio: accel: adxl345: Reorder probe initialization
Date: Mon,  1 Apr 2024 19:49:04 +0000
Message-Id: <20240401194906.56810-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring indio_dev, setup() and data initialization to begin of the probe()
function to increase readability. Access members through data
pointer to assure implicitely the driver's data instance is correctly
initialized and functional.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8d4a66d8c..5d0f3243e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -180,14 +180,30 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
 
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -ENODEV;
+
+	indio_dev->name = data->info->name;
+	indio_dev->info = &adxl345_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxl345_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
-		ret = setup(dev, regmap);
+		ret = setup(dev, data->regmap);
 		if (ret)
 			return ret;
 
 		/* Enable full-resolution mode */
-		ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+		ret = regmap_update_bits(data->regmap, ADXL345_REG_DATA_FORMAT,
 					 data_format_mask,
 					 ADXL345_DATA_FORMAT_FULL_RES);
 		if (ret)
@@ -196,14 +212,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	} else {
 		/* Enable full-resolution mode (init all data_format bits) */
-		ret = regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
+		ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
 				   ADXL345_DATA_FORMAT_FULL_RES);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to set data range\n");
 	}
 
-	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
+	ret = regmap_read(data->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
@@ -211,22 +227,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	data = iio_priv(indio_dev);
-	data->regmap = regmap;
-	data->info = device_get_match_data(dev);
-	if (!data->info)
-		return -ENODEV;
-
-	indio_dev->name = data->info->name;
-	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adxl345_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
-
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1


