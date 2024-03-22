Return-Path: <linux-kernel+bounces-110829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31B88646E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839E9282097
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDF79E1;
	Fri, 22 Mar 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmKCrF41"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86D4A3C;
	Fri, 22 Mar 2024 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067852; cv=none; b=lka8gPKeyFG7wODjBukJ3Xh+LAj0yPZdHtxN0nitbfSC0oEyLi3fcaA5oFkvz451lcXPW4or+djuhsiVi9iaOsNenxtWbd39vcQ9qERSDeIlKxG+OYllu/S9lgKQHsa4TWWYBUuGD4OGhKFEPcH4ZPTQDMk59dN9QWaeV4DFUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067852; c=relaxed/simple;
	bh=3CycA3mmXO4xQ85UTYU5bmuD2J3SC+juB4BZoKQmN5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiirfY7CncjPO8N+nIV8pLmi0LoXVxjD9gJwv9Hy868L9v8JsEnXM7E/INY71mKHceyn02HUs8tUGzcnRFs5kCfJNUMYjznfmcXAQQtmIYWXiWNqZjUZQcb6OyOuyLADKc9wivRT7VhITTKPn/szopAArbJY3yxPBPx/gQgiojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmKCrF41; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso164212266b.1;
        Thu, 21 Mar 2024 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067848; x=1711672648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr96grEbp0QCEdvGrKBsplKcmOfKqmllryZhp+VXvf0=;
        b=AmKCrF41FAzThquREZPM/RCuwxPc8fDpwzveaqAo0Svv3T2lSjaO3ztn3FjKjzV6Ww
         3I3j9DqP/YuPgcCkKngRnoeWqoH7JUDGQl7nq59/SQyq1gwuf9fHMZf5AgH8FbGkSz3s
         VDOM0Tb7J0HvCgBv2SOZn27h/H4Q0TqqmCt2CpFiPy92qNHhM5ZvSfkLX8sqDHuYryss
         EZCPJZw4DrEhUPYVK1vlNII8QwfJlf2u1heszEccOdICs3ZfvPwQLgrlWSPNwonhT/gw
         8YEQcpqJRwerP2Yt9G03Jd+ptKF8iAiLUpZ3JV2SLl1I3V3wk7r3twz+HUBQktTGEA1O
         kLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067848; x=1711672648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr96grEbp0QCEdvGrKBsplKcmOfKqmllryZhp+VXvf0=;
        b=J0SikCPp7NSWTypt8avo1BGqFg9+Gx4miiUnHU2bOPk9fwdYFwy4seLzt0fbcyDcVW
         ziVtgiC851Y+JQriLzBjOSZigAsVI1sWx4zmBWNT2iJrbgn4vrB4Mv3vDOk0CDjFcyFL
         574TXQsUuLJ8J0JwtIhyoxf51wdqC1U5bZ+vB6qWRNK8ouZ2a1Rmy1GQega+LKuPZLIi
         lKbkHtCCyGiT4wshlFNRqbh2gnpVH3+soT0ce9/mhpdZIJQcHSPt9kp1MiAaTRbkdIf+
         7o8+m7Vua7Koh7RkmyWYTPuxkqzYKywN1ryBg+9S7IAyD2H23cXwvpgh2PWlfX6ncqsJ
         b6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXCAkpe8XrCisLgIgF4C9VOY3XRI16fEci1vQH4GxskrsR3aFIDVd/Z9XjB6rQmyAy3fjRx9JJ8GOaEzibj1BErvu3tS90yHqPl2VSgXrRXq0PNAg7PWDCtEz4SRu/nz2A5a6EKTSNjHg==
X-Gm-Message-State: AOJu0YzkvnqgFX4gww542TUkrV/NdZ6JHF/k4dXpxToLz3X76PxT2+qR
	7gMOt+u2RomnC7t2RVxryh6y0KrAsv7xUAgrBkTR2UAo7Vdl1lOx
X-Google-Smtp-Source: AGHT+IEaLcfAxxqjD4uHMWhBq+rNgl0e6DVTtKGbdA/EjfvLJhV9EdUfMJYy8c/mPw1owGyG6UIs2A==
X-Received: by 2002:a17:906:4e98:b0:a46:8ca9:eb2e with SMTP id v24-20020a1709064e9800b00a468ca9eb2emr568770eju.38.1711067846425;
        Thu, 21 Mar 2024 17:37:26 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906774b00b00a46af0fbf5dsm439950ejn.103.2024.03.21.17.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 17:37:26 -0700 (PDT)
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
Subject: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
Date: Fri, 22 Mar 2024 00:37:11 +0000
Message-Id: <20240322003713.6918-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322003713.6918-1-l.rubusch@gmail.com>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move driver wide constants and fields into the header.
Let probe call a separate setup function. Provide
possibility for an SPI/I2C specific setup to be passed
as function pointer to core.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  44 +++++++++++-
 drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++--------------
 drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
 drivers/iio/accel/adxl345_spi.c  |  28 ++++----
 4 files changed, 134 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..01493c999 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,39 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#include <linux/iio/iio.h>
+
+/* ADXL345 register definitions */
+#define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1E
+#define ADXL345_REG_OFSY		0x1F
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+#define ADXL345_REG_BW_RATE		0x2C
+#define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_DATA_FORMAT		0x31
+#define ADXL345_REG_DATAX0		0x32
+#define ADXL345_REG_DATAY0		0x34
+#define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_STANDBY	0x00
+
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
+
+#define ADXL345_DEVID			0xE5
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
@@ -23,11 +56,20 @@
  */
 #define ADXL375_USCALE	480000
 
+enum adxl345_device_type {
+	ADXL345,
+	ADXL375,
+};
+
 struct adxl345_chip_info {
 	const char *name;
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+extern const struct adxl345_chip_info adxl3x5_chip_info[];
+
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const struct adxl345_chip_info *chip_info,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..040c3f05a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,38 +17,9 @@
 
 #include "adxl345.h"
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_OFSX		0x1e
-#define ADXL345_REG_OFSY		0x1f
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
-
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_STANDBY	0x00
-
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -62,6 +33,18 @@ struct adxl345_data {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
+const struct adxl345_chip_info adxl3x5_chip_info[] = {
+	[ADXL345] = {
+		.name = "adxl345",
+		.uscale = ADXL345_USCALE,
+	},
+	[ADXL375] = {
+		.name = "adxl375",
+		.uscale = ADXL375_USCALE,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, X),
 	ADXL345_CHANNEL(1, Y),
@@ -197,14 +180,21 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+static int adxl345_setup(struct device *dev, struct adxl345_data *data,
+			 int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *data;
-	struct iio_dev *indio_dev;
 	u32 regval;
 	int ret;
 
-	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
+	/* Perform bus specific settings if available */
+	if (setup) {
+		ret = setup(dev, data->regmap);
+		if (ret)
+			return ret;
+	}
+
+	/* Read out DEVID */
+	ret = regmap_read(data->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
@@ -212,37 +202,62 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
 
+	/* Update data_format to full-resolution mode */
+	ret = regmap_update_bits(data->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to update data_format register\n");
+
+	/* Enable measurement mode */
+	ret = adxl345_powerup(data->regmap);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
+
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
+ *                        also covers the adlx375 accelerometer
+ * @dev:	Driver model representation of the device
+ * @regmap:	Regmap instance for the device
+ * @chip_info:  Structure containing device specific data
+ * @setup:	Setup routine to be executed right before the standard device
+ *		setup, can also be set to NULL if not required
+ *
+ * Return: 0 on success, negative errno on error
+ */
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const struct adxl345_chip_info *chip_info,
+		       int (*setup)(struct device*, struct regmap*))
+{
+	struct adxl345_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
-	data->info = device_get_match_data(dev);
-	if (!data->info)
-		return -ENODEV;
-
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
+	data->info = chip_info;
 
-	indio_dev->name = data->info->name;
+	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
-	/* Enable measurement mode */
-	ret = adxl345_powerup(data->regmap);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
-
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
-	if (ret < 0)
+	ret = adxl345_setup(dev, data, setup);
+	if (ret) {
+		dev_err(dev, "ADXL345 setup failed\n");
 		return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a3084b0a8..3f882e2e0 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -21,41 +22,36 @@ static const struct regmap_config adxl345_i2c_regmap_config = {
 
 static int adxl345_i2c_probe(struct i2c_client *client)
 {
+	const struct adxl345_chip_info *chip_data;
 	struct regmap *regmap;
 
+	/* Retrieve device data, i.e. the name, to pass it to the core */
+	chip_data = i2c_get_match_data(client);
+
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap);
+	return adxl345_core_probe(&client->dev, regmap, chip_data, NULL);
 }
 
-static const struct adxl345_chip_info adxl345_i2c_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_i2c_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 93ca349f1..c26bac462 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -22,8 +22,14 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 
 static int adxl345_spi_probe(struct spi_device *spi)
 {
+	const struct adxl345_chip_info *chip_data;
 	struct regmap *regmap;
 
+	/* Retrieve device name to pass it as driver specific data */
+	chip_data = device_get_match_data(&spi->dev);
+	if (!chip_data)
+		chip_data = spi_get_device_match_data(spi);
+
 	/* Bail out if max_speed_hz exceeds 5 MHz */
 	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
 		return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
@@ -33,35 +39,25 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap);
+	return adxl345_core_probe(&spi->dev, regmap, chip_data, NULL);
 }
 
-static const struct adxl345_chip_info adxl345_spi_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_spi_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct spi_device_id adxl345_spi_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
-- 
2.25.1


