Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3B7EC327
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbjKONAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjKONA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:00:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417D130;
        Wed, 15 Nov 2023 05:00:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c431ca7826so5849230b3a.0;
        Wed, 15 Nov 2023 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053222; x=1700658022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMGWOyYs7PfLPnHHX3eEkJL05C/4w6oYrycDGEtP+O8=;
        b=QOOE6TUYLgGr6kfiybkGWALY/fl9rViuqOKLM29C2GV0XQ72h55aL+NdTGbrZiFkkJ
         DzOQngHE7k/O5y6Nvivd4/LANUXrvFeSSHHXEyW0Z65BGU3CofWu5ZHMgkXvcnBujoQ5
         n4oZs93XgRIpDZKKCuFgc5vjs3sIVuS7xVV0MwwBEtQ/DpGWTnHPKyM2WtCX+1akgiZr
         MYozOqCTuOclsxXhg074nqstDf/b4wP1e4Rd1VNwL0SyufVa8fKPRYXJ5lXKo+spfMP7
         cjyZbyQFIVkK45CG1TFm1Q5SLVJsz2JZApNbwwoKGvGPE+zsqcyi2+CSqaXm3QVJ70Qy
         MYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053222; x=1700658022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMGWOyYs7PfLPnHHX3eEkJL05C/4w6oYrycDGEtP+O8=;
        b=LY0bka8SpW4biZivPE3f1LwQ01ME4XD5kb91ayWs/sZYE24sFDb+ZnuIXQEjn4l/Hf
         d7HW616pglkQtuWI6GZ/ITlvCbPHjHjw0wQFTQDV3A1lbG4b25Jc/Uvdg76vHlKT/zU5
         TjkvSkZXyC3CpoAV44dLv+PBal8do9nRv6xdOsQzbHxzTdHjLqgnMp/uaXiwLW/ls6lR
         C2OsqHfXhv33eOyCnBcbWKWqR1i5fsFNgmrfa3XeQPxhN8zKt9+FovvodvAc32QbMPd0
         BLNOEFaysCJZ5PbqysPVU0SGBQI1QXMF71TTLb7lqOirQTN9Xag2PeDmw3I+7I8Vtehb
         nhyg==
X-Gm-Message-State: AOJu0YxCQMbwgTDUa5/XLRCnRkyyGANOJBsDLKi1uQ5TxgMiFJcMCUmx
        JqMlUtMXovd6t2yIw2kXorEd7mUNRFUULQ==
X-Google-Smtp-Source: AGHT+IG0DCAALxLt73Hxif+HsVVrnfq9qeiEd8MhZnzopAZbDKkX4ez1ojHiT+rNaTkOIS53L78BSg==
X-Received: by 2002:a05:6a20:160b:b0:187:858b:8c1a with SMTP id l11-20020a056a20160b00b00187858b8c1amr568604pzj.50.1700053221366;
        Wed, 15 Nov 2023 05:00:21 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id fh42-20020a056a00392a00b006c4d128b71esm2812867pfb.98.2023.11.15.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:00:20 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 3/3] iio: chemical: add support for Aosong AGS02MA
Date:   Wed, 15 Nov 2023 18:28:08 +0530
Message-ID: <20231115125810.1394854-3-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115125810.1394854-1-anshulusr@gmail.com>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple driver for the TVOC (Total Volatile Organic Compounds)
sensor from Aosong: AGS02MA

Steps in reading the VOC sensor value over i2c:
  1. Read 5 bytes from the register `AGS02MA_TVOC_READ_REG` [0x00]
  2. The first 4 bytes are taken as the big endian sensor data with final
     byte being the CRC
  3. The CRC is verified and the value is returned over an
     `IIO_CHAN_INFO_RAW` channel as percents

Tested on Raspberry Pi Zero 2W

Datasheet:
  https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Product-Page:
  http://www.aosong.com/m/en/products-33.html

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v2:
- Fixed Kconfig not selecting CRC8 (used to be `select crc8`)
- Changed instances of asair to aosong
- Report raw readings in percents instead of ppb
- Added myself as maintainer for the device binding
---
 MAINTAINERS                    |   7 ++
 drivers/iio/chemical/Kconfig   |  11 +++
 drivers/iio/chemical/Makefile  |   1 +
 drivers/iio/chemical/ags02ma.c | 161 +++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+)
 create mode 100644 drivers/iio/chemical/ags02ma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..07b82e766dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3028,6 +3028,13 @@ S:	Supported
 W:	http://www.akm.com/
 F:	drivers/iio/magnetometer/ak8974.c
 
+AOSONG AGS02MA TVOC SENSOR DRIVER
+M:	Anshul Dalal <anshulusr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
+F:	drivers/iio/chemical/ags02ma.c
+
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index c30657e10ee1..02649ab81b3c 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -5,6 +5,17 @@
 
 menu "Chemical Sensors"
 
+config AOSONG_AGS02MA
+	tristate "Aosong AGS02MA TVOC sensor driver"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build support for Aosong AGS02MA TVOC (Total Volatile
+	  Organic Compounds) sensor.
+
+	  To compile this driver as module, choose M here: the module will be
+	  called ags02ma.
+
 config ATLAS_PH_SENSOR
 	tristate "Atlas Scientific OEM SM sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index a11e777a7a00..2f3dee8bb779 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AOSONG_AGS02MA)	+= ags02ma.o
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
 obj-$(CONFIG_ATLAS_EZO_SENSOR)	+= atlas-ezo-sensor.o
 obj-$(CONFIG_BME680) += bme680_core.o
diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
new file mode 100644
index 000000000000..e23655ffce69
--- /dev/null
+++ b/drivers/iio/chemical/ags02ma.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
+ *
+ * Driver for Aosong AGS02MA
+ *
+ * Datasheet:
+ *   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
+ * Product Page:
+ *   http://www.aosong.com/m/en/products-33.html
+ *
+ * TODO:
+ *   - Add support for ug/m^3 units of measurement
+ *   - Add support for modifying i2c address
+ */
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+
+#define AGS02MA_DEVICE_NAME		   "ags02ma"
+
+#define AGS02MA_TVOC_READ_REG		   0x00
+#define AGS02MA_VERSION_REG		   0x11
+
+#define AGS02MA_VERSION_PROCESSING_DELAY   30
+#define AGS02MA_TVOC_READ_PROCESSING_DELAY 1500
+
+#define AGS02MA_CRC8_INIT		   0xff
+#define AGS02MA_CRC8_POLYNOMIAL		   0x31
+#define AGS02MA_PPB_PERCENT_CONVERSION     10000000
+
+DECLARE_CRC8_TABLE(ags02ma_crc8_table);
+
+struct ags02ma_data {
+	struct i2c_client *client;
+};
+
+struct ags02ma_reading {
+	__be32 data;
+	u8 crc;
+} __packed;
+
+static u32 ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay)
+{
+	u32 ret;
+	u8 crc;
+	struct ags02ma_reading read_buffer;
+
+	ret = i2c_master_send(client, &reg, sizeof(reg));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to send data to register 0x%x: %d", reg, ret);
+		return ret;
+	}
+
+	/* Processing Delay, Check Table 7.7 in the datasheet */
+	msleep_interruptible(delay);
+
+	ret = i2c_master_recv(client, (u8 *)&read_buffer, sizeof(read_buffer));
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to receive from register 0x%x: %d", reg, ret);
+		return ret;
+	}
+	ret = be32_to_cpu(read_buffer.data);
+
+	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
+		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
+	if (crc != read_buffer.crc) {
+		dev_err(&client->dev, "CRC error\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static int ags02ma_read_raw(struct iio_dev *iio_device,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ags02ma_data *data = iio_priv(iio_device);
+
+	if (mask == IIO_CHAN_INFO_RAW) {
+		/* The sensor reads data as ppb */
+		ret = ags02ma_register_read(data->client, AGS02MA_TVOC_READ_REG,
+					    AGS02MA_TVOC_READ_PROCESSING_DELAY);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		*val2 = AGS02MA_PPB_PERCENT_CONVERSION;
+		return IIO_VAL_FRACTIONAL;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ags02ma_info = {
+	.read_raw = ags02ma_read_raw,
+};
+
+static const struct iio_chan_spec ags02ma_channels[] = {
+	{ .type = IIO_CONCENTRATION,
+	  .channel2 = IIO_MOD_VOC,
+	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) }
+};
+
+static int ags02ma_probe(struct i2c_client *client)
+{
+	int ret;
+	struct ags02ma_data *data;
+	struct iio_dev *indio_dev;
+	u32 version;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	crc8_populate_msb(ags02ma_crc8_table, AGS02MA_CRC8_POLYNOMIAL);
+
+	ret = ags02ma_register_read(client, AGS02MA_VERSION_REG,
+				    AGS02MA_VERSION_PROCESSING_DELAY);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device version: %d", ret);
+		return ret;
+	}
+	version = ret;
+	dev_dbg(&client->dev, "Aosong AGS02MA, Version: 0x%x", version);
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	indio_dev->info = &ags02ma_info;
+	indio_dev->channels = ags02ma_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ags02ma_channels);
+	indio_dev->name = AGS02MA_DEVICE_NAME;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ags02ma_id_table[] = {
+	{ AGS02MA_DEVICE_NAME, 0 },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, ags02ma_id_table);
+
+static struct i2c_driver ags02ma_driver = {
+	.driver = {
+		.name = AGS02MA_DEVICE_NAME,
+	},
+	.id_table = ags02ma_id_table,
+	.probe = ags02ma_probe,
+};
+module_i2c_driver(ags02ma_driver);
+
+MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
+MODULE_DESCRIPTION("Aosong AGS02MA TVOC Driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

