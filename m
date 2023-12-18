Return-Path: <linux-kernel+bounces-3969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32D817610
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8882280E06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043727409A;
	Mon, 18 Dec 2023 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3mqX1MK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1ED74092;
	Mon, 18 Dec 2023 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d84b68a866so440332b3a.0;
        Mon, 18 Dec 2023 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914084; x=1703518884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfAmnqaK+W/dhF70JOgLBVhhTwo8kK7NvyUkbJBYbfc=;
        b=H3mqX1MKFl7vWpY8ZPTxZLUGw88FH4nKJcIfZTOQrPZQbK+bAhiMuDFqH87nfE0AtK
         6nLXB/l3Ldx9WOOeNsz0Em7xQs/LD+jJwPMikA8e2Ze6y8qBWftUpoWWbCwyuNtHu7Tl
         iQInReSsJ+SVi6g34G4XyBKrHr7+K6ZhJKp4TBbRsLTmx/1NA0pt+5pcFaJPGr7+iAHT
         q1aGufltBlSFWst6vlcIHA4WaCaJNRogXFfIBKVf7aTaKBQEc3+kgVbmRjnCHFlSGe05
         +OQGmlBEGxF3UAmTKr4yv/C48mS+2KBKJrEAzuWlEXepKITr5ul89lEz2yl78zLPim0x
         kCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914084; x=1703518884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfAmnqaK+W/dhF70JOgLBVhhTwo8kK7NvyUkbJBYbfc=;
        b=iRSE+pAqh7ZHi4WxkeLNF/k9HbzczNIk730CuxsYj/FjESxtkWGdSg3ix0TqFbR7d0
         DShuAFYEtF+a/MZtR+8OtuaOZa5ehUcw5HWy38x+owf5NVPmGepLQCWzSnsfyLyQfmGb
         7jXN1zpr0eFUQHIJvHRwcUrousAtfbMOYY2Y2VcytmoJ489UfZ2FkAoCXlObpWAEGDSi
         FeIk+3gVHe+HPSW94ShLXeIZyDQcppQjqFKEWGHuf7h+jiT/iUXgsqt+TrRRI9LcQFVP
         KqValUnxOHXPHUPGUiTjAzEVu7F5ou5eo0lh1lQvA1cFvVCQu1XJH4a7Mwdo5zUzSbBn
         k6vw==
X-Gm-Message-State: AOJu0Yw3Xlt+RUWbA62Ags5pWe7sckRMsmsbvHwWqeB+aBP69Km54/fW
	dnT91Qk1acCDDwYarFUbo04=
X-Google-Smtp-Source: AGHT+IEiZJl8YCqQLmp7AiYlERLHpMmZWeiPMOQe88HWKtWq23SpuNXK78B298bkLHJrQM2ymNRDGw==
X-Received: by 2002:a05:6a20:144a:b0:194:8a59:8255 with SMTP id a10-20020a056a20144a00b001948a598255mr393436pzi.72.1702914083771;
        Mon, 18 Dec 2023 07:41:23 -0800 (PST)
Received: from arch.localdomain ([134.209.105.58])
        by smtp.gmail.com with ESMTPSA id q23-20020a62e117000000b006d0951e74cbsm4539666pfh.178.2023.12.18.07.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:23 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Jonathan.Cameron@huawei.com
Cc: lars@metafoo.de,
	Qing-wu.Li@leica-geosystems.com.cn,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH] iio: accel: bmi088: add i2c support for bmi088 accel driver
Date: Mon, 18 Dec 2023 23:40:45 +0800
Message-ID: <20231218154045.219317-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BMI088, BMI085 and BMI090L accelerometer also support
I2C protocol, so let's add the missing I2C support.

The I2C interface of the {BMI085,BMI088,BMI090L} is compatible with the I2C Specification UM10204 Rev. 03 (19 June
2007), available at http://www.nxp.com. The {BMI085,BMI088,BMI090L} supports I2C standard mode and fast mode, only
7-bit address mode is supported.[1][2][3]

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
[2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
[3]: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/4807/BST-BMI090L-DS000-00.pdf

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/accel/Kconfig            |  8 +++-
 drivers/iio/accel/Makefile           |  1 +
 drivers/iio/accel/bmi088-accel-i2c.c | 69 ++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/accel/bmi088-accel-i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 91adcac875a4..dc92cf599acb 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -254,11 +254,11 @@ config BMC150_ACCEL_SPI
 
 config BMI088_ACCEL
 	tristate "Bosch BMI088 Accelerometer Driver"
-	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP
-	select BMI088_ACCEL_SPI
+	select BMI088_ACCEL_SPI if SPI
+	select BMI088_ACCEL_I2C if I2C
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
 	  BMI088, BMI085, BMI090L. Note that all of these are combo module that
@@ -267,6 +267,10 @@ config BMI088_ACCEL
 	  This driver only implements the accelerometer part, which has its own
 	  address and register map. BMG160 provides the gyroscope driver.
 
+config BMI088_ACCEL_I2C
+	tristate
+	select REGMAP_I2C
+
 config BMI088_ACCEL_SPI
 	tristate
 	select REGMAP_SPI
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 311ead9c3ef1..db90532ba24a 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
 obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
+obj-$(CONFIG_BMI088_ACCEL_I2C) += bmi088-accel-i2c.o
 obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
 obj-$(CONFIG_DA280)	+= da280.o
 obj-$(CONFIG_DA311)	+= da311.o
diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi088-accel-i2c.c
new file mode 100644
index 000000000000..1dcca0e88c1a
--- /dev/null
+++ b/drivers/iio/accel/bmi088-accel-i2c.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
+ *  - BMI088
+ *  - BMI085
+ *  - BMI090L
+ *
+ * Copyright 2023 Jun Yan <jerrysteve1101@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/i2c/i2c.h>
+
+#include "bmi088-accel.h"
+
+static int bmi088_accel_probe(struct i2c_device *i2c)
+{
+	struct regmap *regmap;
+	const struct i2c_device_id *id = i2c_get_device_id(i2c);
+
+	regmap = devm_regmap_init_i2c(&i2c->dev, &bmi088_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bmi088_accel_core_probe(&i2c->dev, regmap, i2c->irq,
+					id->driver_data);
+}
+
+static void bmi088_accel_remove(struct i2c_device *i2c)
+{
+	bmi088_accel_core_remove(&i2c->dev);
+}
+
+static const struct of_device_id bmi088_of_match[] = {
+	{ .compatible = "bosch,bmi085-accel" },
+	{ .compatible = "bosch,bmi088-accel" },
+	{ .compatible = "bosch,bmi090l-accel" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bmi088_of_match);
+
+static const struct i2c_device_id bmi088_accel_id[] = {
+	{"bmi085-accel",  BOSCH_BMI085},
+	{"bmi088-accel",  BOSCH_BMI088},
+	{"bmi090l-accel", BOSCH_BMI090L},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
+
+static struct i2c_driver bmi088_accel_driver = {
+	.driver = {
+		.name	= "bmi088_accel_i2c",
+		.pm	= pm_ptr(&bmi088_accel_pm_ops),
+		.of_match_table = bmi088_of_match,
+	},
+	.probe		= bmi088_accel_probe,
+	.remove		= bmi088_accel_remove,
+	.id_table	= bmi088_accel_id,
+};
+module_i2c_driver(bmi088_accel_driver);
+
+MODULE_AUTHOR("Jun Yan <jerrysteve1101@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMI088 accelerometer driver (I2C)");
+MODULE_IMPORT_NS(IIO_BMI088);
-- 
2.43.0


