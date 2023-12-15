Return-Path: <linux-kernel+bounces-1291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DC814CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B81C2375A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830C3C49B;
	Fri, 15 Dec 2023 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6U8BoVo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D663DBBB;
	Fri, 15 Dec 2023 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d05199f34dso3951965ad.3;
        Fri, 15 Dec 2023 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657536; x=1703262336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Ib9M9xg38B/QbmBOXK61x/WxHHrbWgabum0nBmkMI=;
        b=g6U8BoVosgfg/zWkq+TlyvMfBTes+irlvSMtE3CQmOADsxE2pPrY4RQ4qjS1i0kghG
         mJ5r4604zuZajL1TvlQXwWRptzZc25RDWE/VrLf89hNeAPFk0+ZTuHCfkWDaO8jyGI3+
         fb/qUDAXPaP+F+FgEB28bdtg/qj6rLLha9HY7FOuZO5G/u3HGv7XW11TrCdwqauqG07H
         9EyYmugqVKw9X0pxqkFyTZo8x/pfMfr5tAroexdfemnZ+3jv1+qWKoMkkNPcYaFRRO7s
         Nj02Jjv3qmHXx+0oGquuIVmNl2A2Z55ZWnDGV2mBknWRIBfR2EvET7SOKjPF/fsoUfon
         mqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657536; x=1703262336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Ib9M9xg38B/QbmBOXK61x/WxHHrbWgabum0nBmkMI=;
        b=dGYqFwLh30oQd222gvi7TCSbkQeT4COrD/Wf/Vz8czWuXDbtEbkL0hIKz0eJhp7WOU
         JuuwC5N6X/idZIwizXpgEM/2khF5a00SFswCSjq9ih9Yjd5kkcy3Ny1Hb/ypS5pSO+IP
         inZL/5CIT5/7iKeigyRBHiB/dDy7GXkkB+PS44e+P9jApeh/YVeA3afgLSPG7NideFRO
         cDB+te7yE9ymkDl2lXQE3SCnQ6cBF/pVgDs9BPWf+LOr1B/P9ou4i31NAIJNQ3/eqnd7
         UNlHIwx8LqHxY/qgX5gBE3/DZz89/RJTsJ58T5RKHxokmMD8MBktxX2mTvvL7pYntuEL
         Hvbw==
X-Gm-Message-State: AOJu0YyjihgLK/z/iBAvy/VQqGLEX1rq81vgqk56DaigAFUQ9eWdlUEq
	Bv0arVK+/FnrxT9G81jow+czK1N1hKNrag==
X-Google-Smtp-Source: AGHT+IHAzlqLfSUjVD+t87pazfdcFu3bvkezL0AmisAGvfMeWZ/R/akVDuZqnZyyhmt5R+6mI2CA/Q==
X-Received: by 2002:a17:902:9893:b0:1d3:7c16:91d6 with SMTP id s19-20020a170902989300b001d37c1691d6mr1267651plp.115.1702657536101;
        Fri, 15 Dec 2023 08:25:36 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001bb750189desm14468665plp.255.2023.12.15.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:25:35 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 3/3] iio: chemical: add support for Aosong AGS02MA
Date: Fri, 15 Dec 2023 21:53:11 +0530
Message-ID: <20231215162312.143568-3-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215162312.143568-1-anshulusr@gmail.com>
References: <20231215162312.143568-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple driver for the TVOC (Total Volatile Organic Compounds)
sensor from Aosong: AGS02MA

Steps in reading the VOC sensor value over i2c:
  1. Read 5 bytes from the register `AGS02MA_TVOC_READ_REG` [0x00]
  2. The first 4 bytes are taken as the big endian sensor data with final
     byte being the CRC
  3. The CRC is verified and the value is returned over an
     `IIO_CHAN_INFO_RAW` channel as percents

Tested on Raspberry Pi Zero 2W

Datasheet: https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v5:
- Removed AGS02MA_DEVICE_NAME define
- Saperated return value from data in
  `ags02ma_register_read`
- Added IIO_CHAN_INFO_SCALE for ppb to percent conversion
- Changed `ags02ma_channels` (iio_chan_spec[1]) to
  `ags02ma_channel` (iio_chan_spec) since only driver only
  uses a single channel
- Use `dev_err_probe` instead of `dev_err`
- removed unnecessary `i2c_set_clientdata(..)`
- Removed `of_match_ptr(..)`

Changes for v4:
- Fixed warning: unused variable 'ags02ma_of_table'
- Fixed warning: unsigned 'ret' is never less than zero in
  `ags02ma_register_read`

Changes for v3:
- Added of_device_id

Changes for v2:
- Fixed Kconfig not selecting CRC8 (used to be `select crc8`)
- Changed instances of asair to aosong
- Report raw readings in percents instead of ppb
- Added myself as maintainer for the device binding

Previous versions:
v4: https://lore.kernel.org/lkml/20231125100139.193584-3-anshulusr@gmail.com/
v3: https://lore.kernel.org/lkml/20231121095800.2180870-3-anshulusr@gmail.com/
v2: https://lore.kernel.org/lkml/20231115125810.1394854-3-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231107173100.62715-3-anshulusr@gmail.com/
---
 MAINTAINERS                    |   7 ++
 drivers/iio/chemical/Kconfig   |  11 +++
 drivers/iio/chemical/Makefile  |   1 +
 drivers/iio/chemical/ags02ma.c | 164 +++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 drivers/iio/chemical/ags02ma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..ba3c950aca1b 100644
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
index 000000000000..b2fe056083b3
--- /dev/null
+++ b/drivers/iio/chemical/ags02ma.c
@@ -0,0 +1,164 @@
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
+ */
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+#define AGS02MA_TVOC_READ_REG		   0x00
+#define AGS02MA_VERSION_REG		   0x11
+
+#define AGS02MA_VERSION_PROCESSING_DELAY   30
+#define AGS02MA_TVOC_READ_PROCESSING_DELAY 1500
+
+#define AGS02MA_CRC8_INIT		   0xff
+#define AGS02MA_CRC8_POLYNOMIAL		   0x31
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
+static int ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay,
+				 u32 *val)
+{
+	int ret;
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
+
+	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
+		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
+	if (crc != read_buffer.crc) {
+		dev_err(&client->dev, "CRC error\n");
+		return -EIO;
+	}
+
+	*val = be32_to_cpu(read_buffer.data);
+	return 0;
+}
+
+static int ags02ma_read_raw(struct iio_dev *iio_device,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ags02ma_data *data = iio_priv(iio_device);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ags02ma_register_read(data->client, AGS02MA_TVOC_READ_REG,
+					    AGS02MA_TVOC_READ_PROCESSING_DELAY,
+					    val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* The sensor reads data as ppb */
+		*val = 0;
+		*val2 = 100;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ags02ma_info = {
+	.read_raw = ags02ma_read_raw,
+};
+
+static const struct iio_chan_spec ags02ma_channel = {
+	.type = IIO_CONCENTRATION,
+	.channel2 = IIO_MOD_VOC,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
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
+				    AGS02MA_VERSION_PROCESSING_DELAY, &version);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+			      "Failed to read device version\n");
+	dev_dbg(&client->dev, "Aosong AGS02MA, Version: 0x%x", version);
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	indio_dev->info = &ags02ma_info;
+	indio_dev->channels = &ags02ma_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->name = "ags02ma";
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id ags02ma_id_table[] = {
+	{ "ags02ma" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, ags02ma_id_table);
+
+static const struct of_device_id ags02ma_of_table[] = {
+	{ .compatible = "aosong,ags02ma" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ags02ma_of_table);
+
+static struct i2c_driver ags02ma_driver = {
+	.driver = {
+		.name = "ags02ma",
+		.of_match_table = ags02ma_of_table,
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
2.43.0


