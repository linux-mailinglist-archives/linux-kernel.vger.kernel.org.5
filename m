Return-Path: <linux-kernel+bounces-5447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC30818AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53371C21733
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B71C2AE;
	Tue, 19 Dec 2023 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLvhnnOf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EE1C282;
	Tue, 19 Dec 2023 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4285501b3a.0;
        Tue, 19 Dec 2023 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702998332; x=1703603132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhOzTYOIgMtWCRkVE+vtJSFZFrHXDKqfCoMh0MHGygw=;
        b=iLvhnnOfD3H6ihUwpOtC5gNS4YNRarexuord5in0xYVVCpfn5v/26pttY9W7c+55Nq
         Sc++w2k2cu69f08AU1AVEZZRgyli+7NBuKCrchpi2OddSL7gssgc57VNgOAUAcXDxcs4
         E3YkrS88wG6540MCzr9/p2e8v2/d6+sOxUmIp4/iHd98Wzk/NB6yfFBkBi4EHuVUzOyx
         MkH6svmjO0OGZ+TTYpb1ZfLoP7Z/uimUVQ/9UI2SMUI2ky1oeWgID/yJKGCviCE6IAb3
         TxYwS4xQ234HZylp9gRyrBY1yLQMJsxHw6S4orzSdErtjXOvGHtQYFMGXKdp4NH3RBdd
         6azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998332; x=1703603132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhOzTYOIgMtWCRkVE+vtJSFZFrHXDKqfCoMh0MHGygw=;
        b=PtuWmHNQPCTtHn4O/wVrWjGR1sl+/hvBMxPfajmNlQ/hZE/nt8kSL1CsF+vHddDohk
         jNCIPbNRHuGE/8ZdB4GUeoDK92+d39BqoWnJlEHgmQNZcU2yBJOaXhp1taKbYIfhveES
         r9AwmdHSin1dAEPub3sE8XTmihMMAUBitGhkmW/h6Q2M31pi8q6ygoaGjey/tocy5LFs
         si3g9uQ+bP1mjteSASOEAGM/aClZqVG1yBwG3nmYY9uUyNKxO+30DUU65HwRIqaiBrlH
         c0MH4zuAQGSEIscD7gAOBnHwn0eYDTeKzUenwHC/opm9ST4EtR0DWffJzhhHOe84jJW7
         lJBg==
X-Gm-Message-State: AOJu0YxTE4jvjHstlysKFvUkmYmqymBlhh0FdoZi29b/E4JRQrTszufD
	t4ISw6W/+aWHJv+SMVr5ZYSvvdcpJoZh+FVK0aJYlYdT
X-Google-Smtp-Source: AGHT+IG6lRJmmzhfwev27aI9JjmtJNuidIigi0tjqcQfrD7ol+CNQw7E5QiGIcog26kPhqj/OM2iKQ==
X-Received: by 2002:a05:6a20:3ca6:b0:190:3991:e0f2 with SMTP id b38-20020a056a203ca600b001903991e0f2mr22910633pzj.65.1702998331882;
        Tue, 19 Dec 2023 07:05:31 -0800 (PST)
Received: from arch.localdomain (36-233-211-170.dynamic-ip.hinet.net. [36.233.211.170])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b006d3b7f40292sm6276251pfn.19.2023.12.19.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:05:31 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Jonathan.Cameron@huawei.com
Cc: lars@metafoo.de,
	Qing-wu.Li@leica-geosystems.com.cn,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] iio: accel: bmi088: add i2c support for bmi088 accel driver
Date: Tue, 19 Dec 2023 23:04:40 +0800
Message-ID: <20231219150440.264033-1-jerrysteve1101@gmail.com>
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

The I2C interface of the {BMI085,BMI088,BMI090L} is compatible with
the I2C Specification UM10204 Rev. 03 (19 June 2007), available at
http://www.nxp.com. The {BMI085,BMI088,BMI090L} supports I2C standard
mode and fast mode, only 7-bit address mode is supported.[1][2][3]

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
[2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
[3]: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/4807/BST-BMI090L-DS000-00.pdf

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312191325.jfiyeL5F-lkp@intel.com/

---

Changes in  v2:
- fix compile error
- Link to v1: https://lore.kernel.org/linux-iio/20231218154045.219317-1-jerrysteve1101@gmail.com/
- build-tested on linux-next

---
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
index 000000000000..642dc2607943
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
+#include <linux/i2c.h>
+
+#include "bmi088-accel.h"
+
+static int bmi088_accel_probe(struct i2c_client *i2c)
+{
+	struct regmap *regmap;
+	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
+
+	regmap = devm_regmap_init_i2c(i2c, &bmi088_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bmi088_accel_core_probe(&i2c->dev, regmap, i2c->irq,
+					id->driver_data);
+}
+
+static void bmi088_accel_remove(struct i2c_client *i2c)
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("BMI088 accelerometer driver (I2C)");
+MODULE_IMPORT_NS(IIO_BMI088);
-- 
2.43.0


