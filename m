Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99480A0A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573520AbjLHKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573509AbjLHKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:24:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F85D121;
        Fri,  8 Dec 2023 02:24:31 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d048d38881so14394075ad.2;
        Fri, 08 Dec 2023 02:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702031070; x=1702635870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4QxlHi4/ZvraCu8KWHK0ZLMjQ5vfM8a7X0PIfYoVNY=;
        b=kjIsWiuU1/aFQ6SlaTsZx7ZOX51smL+3MHSW2udFxY16C0BQT7KRRCd73K/kMCshAI
         4wbio/TY4ojUzVITTDuQI3RTEX2kRWORcsVdoKrk2G2NKO5vb0+d0/GZxpjTP6/ls4tg
         BYrwx7EwKOntfz39tw+DWm6pRQ0OSpzoTAMLYM0hwCsfrWEWcD/M4qYiJeMbtxCrVSUa
         KoHL0iK8Vw63P6MEIdoCdUfRpXaRDM8ctcJkF+ohsFi0ST9WHmIedWPKeKrZSUllNhb9
         DrAZ7zTjBpIXmZu/QkXi9tzECFbcM6NrZ05FlhJZI01rPf7atQtx+0LeAlrc2ac4rwX5
         pWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031070; x=1702635870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4QxlHi4/ZvraCu8KWHK0ZLMjQ5vfM8a7X0PIfYoVNY=;
        b=aZ0PranIW9LeSkgA9RvGhWw3zTahbHwJFPHHkMx7pYBKoUAKfKk39+GEA3fRWjL+px
         uIaRM1PIpMO97S28qmnnpxMI7MrtoWGZxrEzx3g1p3Ng6UW8A80BL9tCnT9ub1snnP4F
         GjipSzKN7JJUBuUomzRWRAURIBulROvYJIfrjYm+0yQ0ehnNkoAhWlUJUYh7zcOvnqDT
         WhC0487lLs6BGBjidEzwWObMRXivj9bEjI4YGaiLwFBwK9LdCAXeOE1ynIPoae7dBe08
         i/VNX3a10n0Zpg8FYZ/admQz2H1Je8DMiQI85pN2Tn99sG7pjGTQRSh8vYZScokosJFS
         Ndlw==
X-Gm-Message-State: AOJu0Yz1X7bGXJ4B9dhotokTGNfb2H+V7ESyQXVdpZj2AaDt2baeVpzt
        EVKQHNL3EgcXrXaCGgHWasCsl9ATrJmWvFbQ
X-Google-Smtp-Source: AGHT+IH0iM2YxIoeMUyD4D/y5O89usEV9cth/XNbYaLpNCun+MjC9T3oxVYyXPl0IYTEJTos9QLtXg==
X-Received: by 2002:a17:902:e5cc:b0:1d0:7249:a900 with SMTP id u12-20020a170902e5cc00b001d07249a900mr3842595plf.103.1702031070103;
        Fri, 08 Dec 2023 02:24:30 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6277:8af4:45bc:8bc9:c94a:54d2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d1d6f6b67dsm1337033plh.147.2023.12.08.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:24:29 -0800 (PST)
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
Subject: [PATCH v3 2/2] iio: light: driver for Lite-On ltr390
Date:   Fri,  8 Dec 2023 15:52:10 +0530
Message-ID: <20231208102211.413019-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208102211.413019-1-anshulusr@gmail.com>
References: <20231208102211.413019-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements driver for the Ambient/UV Light sensor LTR390.
The driver exposes two ways of getting sensor readings:
  1. Raw UV Counts directly from the sensor
  2. The computed UV Index value with a percision of 2 decimal places

[NOTE] Ambient light sensing has not been implemented yet.

Driver tested on RPi Zero 2W

Datasheet: https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v3:
- Formatted header includes
- Replaced instances of LTR390_DEVICE_NAME with "ltr390"
- Use shorthand macro 'guard' for mutex
- Replace instances of `dev_err` followed by a return with `dev_err_probe`
- Separate channel for UV Index into a IIO_CHAN_INFO_RAW and _SCALE
- Remove unused IIO_INTENSITY channel
- Warn on invalid product id instead of exiting
- Changed `ltr390_id_table` to `ltr390_of_table` [TYPO]
  > MODULE_DEVICE_TABLE(of, ltr390_of_table)
- Removed of_match_ptr

Changes for v2:
- Fixed typo in `LTR390_FRACTIONAL_PRECISION`
- Added of_device_id

Previous versions:
v2: https://lore.kernel.org/lkml/20231117074554.700970-2-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231109090456.814230-2-anshulusr@gmail.com/
---
 MAINTAINERS                |   7 ++
 drivers/iio/light/Kconfig  |  11 +++
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/ltr390.c | 195 +++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/iio/light/ltr390.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..c9f2238673f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12484,6 +12484,13 @@ S:	Maintained
 W:	http://linux-test-project.github.io/
 T:	git https://github.com/linux-test-project/ltp.git
 
+LTR390 AMBIENT/UV LIGHT SENSOR DRIVER
+M:	Anshul Dalal <anshulusr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
+F:	drivers/iio/light/ltr390.c
+
 LYNX 28G SERDES PHY DRIVER
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c..61993ae79afe 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -347,6 +347,17 @@ config SENSORS_LM3533
 	  changes. The ALS-control output values can be set per zone for the
 	  three current output channels.
 
+config LTR390
+	tristate "LTR-390UV-01 ambient light and UV sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Lite-On LTR-390UV-01
+	  ambient light and UV sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ltr390.
+
 config LTR501
 	tristate "LTR-501ALS-01 light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0db4c4c36ec..550f8b408bc2 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
+obj-$(CONFIG_LTR390)		+= ltr390.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
new file mode 100644
index 000000000000..49dfd2bdd1ee
--- /dev/null
+++ b/drivers/iio/light/ltr390.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * IIO driver for Lite-On LTR390 ALS and UV sensor
+ * (7-bit I2C slave address 0x53)
+ *
+ * Based on the work of:
+ *   Shreeya Patel and Shi Zhigang (LTRF216 Driver)
+ *
+ * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
+ *
+ * Datasheet:
+ *   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
+ *
+ * TODO:
+ *   - Support for configurable gain and resolution
+ *   - Sensor suspend/resume support
+ *   - Add support for reading the ALS
+ *   - Interrupt support
+ */
+
+#include <linux/i2c.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+
+#include <asm/unaligned.h>
+
+#define LTR390_MAIN_CTRL      0x00
+#define LTR390_PART_ID	      0x06
+#define LTR390_UVS_DATA	      0x10
+
+#define LTR390_SW_RESET	      BIT(4)
+#define LTR390_UVS_MODE	      BIT(3)
+#define LTR390_SENSOR_ENABLE  BIT(1)
+
+#define LTR390_PART_NUMBER_ID 0xb
+
+/*
+ * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
+ * the sensor are equal to 1 UV Index [Datasheet Page#8].
+ *
+ * For the default resolution of 18-bit (integration time: 100ms) and default
+ * gain of 3x, the counts/uvi are calculated as follows:
+ * 2300 / ((3/18) * (100/400)) = 95.83
+ */
+#define LTR390_COUNTS_PER_UVI 96
+
+/*
+ * Window Factor is needed when the device is under Window glass with coated
+ * tinted ink. This is to compensate for the light loss due to the lower
+ * transmission rate of the window glass and helps * in calculating lux.
+ */
+#define LTR390_WINDOW_FACTOR 1
+
+struct ltr390_data {
+	struct regmap *regmap;
+	struct i2c_client *client;
+	/* Protects device from simulataneous reads */
+	struct mutex lock;
+};
+
+static const struct regmap_config ltr390_regmap_config = {
+	.name = "ltr390",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+};
+
+static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+	u8 recieve_buffer[3];
+
+	guard(mutex)(&data->lock);
+
+	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
+			       sizeof(recieve_buffer));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read measurement data");
+
+	return get_unaligned_le24(recieve_buffer);
+}
+
+static int ltr390_read_raw(struct iio_dev *iio_device,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	int ret;
+	struct ltr390_data *data = iio_priv(iio_device);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ltr390_register_read(data, LTR390_UVS_DATA);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = LTR390_WINDOW_FACTOR;
+		*val2 = LTR390_COUNTS_PER_UVI;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltr390_info = {
+	.read_raw = ltr390_read_raw,
+};
+
+static const struct iio_chan_spec ltr390_channel = {
+	.type = IIO_UVINDEX,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
+};
+
+static int ltr390_probe(struct i2c_client *client)
+{
+	struct ltr390_data *data;
+	struct iio_dev *indio_dev;
+	struct device *dev;
+	int ret, part_number;
+
+	dev = &client->dev;
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->info = &ltr390_info;
+	indio_dev->channels = &ltr390_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->name = "ltr390";
+
+	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get sensor's part id\n");
+	/* Lower 4 bits of `part_number` change with hardware revisions */
+	if (part_number >> 4 != LTR390_PART_NUMBER_ID)
+		dev_info(dev, "received invalid product id: 0x%x", part_number);
+	dev_dbg(dev, "LTR390, product id: 0x%x\n", part_number);
+
+	/* reset sensor, chip fails to respond to this, so ignore any errors */
+	regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SW_RESET);
+
+	/* Wait for the registers to reset before proceeding */
+	usleep_range(1000, 2000);
+
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
+			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id ltr390_id[] = {
+	{ "ltr390" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, ltr390_id);
+
+static const struct of_device_id ltr390_of_table[] = {
+	{ .compatible = "liteon,ltr390" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ltr390_of_table);
+
+static struct i2c_driver ltr390_driver = {
+	.driver = {
+		.name = "ltr390",
+		.of_match_table = ltr390_of_table,
+	},
+	.probe = ltr390_probe,
+	.id_table = ltr390_id,
+};
+module_i2c_driver(ltr390_driver);
+
+MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
+MODULE_DESCRIPTION("Lite-On LTR390 ALS and UV sensor Driver");
+MODULE_LICENSE("GPL");
-- 
2.42.1

