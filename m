Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B678762F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbjHXQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbjHXQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:06 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9541989;
        Thu, 24 Aug 2023 09:56:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64c2e2572f7so339596d6.1;
        Thu, 24 Aug 2023 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692896163; x=1693500963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jEdJHvnvLc6oMed5fkf7S9T7cgwPwSLb2xDRIdTeIQ=;
        b=GdQP6/yEVRmwKIifF+7W38myv/kKkTJyaaKdG82wdfpVP0Gf/V7rzKCARAewFVbpI/
         1gQo1Q7eZ+1Vod5eviepCRSRt1hoT3arJzD0nDSvQYAUnGfMJznPD7c/UTkj4nQrZppp
         x/hvzXQmYHD/oDXkp9gwTgfDln9GjJmp3sxeHZCJP9Fd1qfY6KjY9iSlZjR+LP+OAF+y
         VFQ8419qn7o+RUVbGoNfUEb4dZzAt3WOEulmq6YgagHbW/7qVsp85FO9tKtdbVtoxdm6
         vXzxVighyk3dVyohocbzxqC17cz+OqbD+i/3l9EXOaJrg5Q3JEggNNf74YaX0frz2I1G
         4BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896163; x=1693500963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jEdJHvnvLc6oMed5fkf7S9T7cgwPwSLb2xDRIdTeIQ=;
        b=J/M+WReVlH/yGV9MkplI9BiKHsv9knDqXdMcJblmLgO/jW+N3iZNavkh8WDRWpKiM+
         iN13kNTYxzcdCip0nT+y1hgs78baZlslDTDtZ8MgBh09Wn1XGvp6BXFn+zQBe4Y4R9O8
         grhcbBqYbVBckaxtS62/psv+ma1KJdvhb02SQmCiqwkY76SDLSQ0tgNu+DEpq6gXSd/0
         QIuvtnf3xZja/l5MjOi/39OY/xc/JvcRrm+LfiI6KCiJFt1BikoUvvMPv5O6teCkJdiS
         3X+1ytkbJUzNk9TXuSyxPFkMq+G6ctBeTrirkE0VqpD95HcjYvak/7xXMGd9ZM/oNSQB
         uXsA==
X-Gm-Message-State: AOJu0YyBOYuTPtG7nZFhaO2ejN90bRMJ45jzjMje6lqrzQK7AtXfo2G5
        efkFISmvdvLtGs3cqUUvaY4=
X-Google-Smtp-Source: AGHT+IH/OtvyS8L91mQe0RrfFE/NMaG/NSE4dtJHi9asA81d/x/8ipZgHXOnd218jrdkgKDHfE+I4Q==
X-Received: by 2002:a0c:f985:0:b0:64a:138e:dc1 with SMTP id t5-20020a0cf985000000b0064a138e0dc1mr16320779qvn.53.1692896163507;
        Thu, 24 Aug 2023 09:56:03 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b0064f4f14aecesm2225654qvl.24.2023.08.24.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:56:03 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Thu, 24 Aug 2023 12:55:30 -0400
Subject: [PATCH 1/3] iio: adc: add ltc2309 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-ltc2309-v1-1-b87b4eb8030c@gmail.com>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
In-Reply-To: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692896161; l=8059;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=mgVUhWjX4SFW7juBRvKt5JFMzezW55rjVCk3CupSfsw=;
 b=lVDmtb8JFTJ4UxK1xbw8H5GQHlEcvVO4xriAmZk/t9WI8iYiMXSh92rowbABkW66GB6czmC8d
 EzukC6hAmPgBay5F6HfXt4dMnH0rGDK8krscXdYAqFy1z0QC31Tcl3j
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.

This implements support for all single-ended and differential channels,
in unipolar mode only.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/adc/Kconfig   |  10 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2309.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dc14bde31ac1..6ec18e02faf9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -607,6 +607,16 @@ config LPC32XX_ADC
 	  activate only one via device tree selection.  Provides direct access
 	  via sysfs.
 
+config LTC2309
+	tristate "Linear Technology LTC2309 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Linear Technology LTC2309, a low
+	  noise, low power, 8-channel, 12-bit SAR ADC
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2309.
+
 config LTC2471
 	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index eb6e891790fb..fbd86184ec94 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
+obj-$(CONFIG_LTC2309) += ltc2309.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
new file mode 100644
index 000000000000..ee1fd9b82e2a
--- /dev/null
+++ b/drivers/iio/adc/ltc2309.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
+ *
+ * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+
+#define DRIVER_NAME		"ltc2309"
+#define LTC2309_ADC_RESOLUTION	12
+
+#define LTC2309_DIN_CH_MASK	GENMASK(7, 4)
+#define LTC2309_DIN_SDN		BIT(7)
+#define LTC2309_DIN_OSN		BIT(6)
+#define LTC2309_DIN_S1		BIT(5)
+#define LTC2309_DIN_S0		BIT(4)
+#define LTC2309_DIN_UNI		BIT(3)
+#define LTC2309_DIN_SLEEP	BIT(2)
+
+/* struct ltc2309 - internal device data structure
+ *
+ * @dev:	Device reference
+ * @client:	I2C reference
+ * @refcomp:	External reference source
+ * @lock:	Lock to protect against multiple access to the device
+ * @vref_mv	Internal voltage reference
+ */
+struct ltc2309 {
+	struct device		*dev;
+	struct i2c_client	*client;
+	struct regulator	*refcomp;
+	struct mutex		lock;
+	int			vref_mv;
+};
+
+/* Order matches expected channel address, See datasheet Table 1. */
+enum ltc2309_channels {
+	LTC2309_CH0_CH1 = 0,
+	LTC2309_CH2_CH3,
+	LTC2309_CH4_CH5,
+	LTC2309_CH6_CH7,
+	LTC2309_CH1_CH0,
+	LTC2309_CH3_CH2,
+	LTC2309_CH5_CH4,
+	LTC2309_CH7_CH6,
+	LTC2309_CH0,
+	LTC2309_CH2,
+	LTC2309_CH4,
+	LTC2309_CH6,
+	LTC2309_CH1,
+	LTC2309_CH3,
+	LTC2309_CH5,
+	LTC2309_CH7,
+};
+
+#define LTC2309_CHAN(_chan, _addr) {				\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = "CH"#_chan,				\
+}
+
+#define LTC2309_DIFF_CHAN(_chan, _chan2, _addr) {		\
+	.type = IIO_VOLTAGE,					\
+	.differential = 1,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.channel2 = _chan2,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = "CH"#_chan"-CH"#_chan2,		\
+}
+
+static const struct iio_chan_spec ltc2309_channels[] = {
+	LTC2309_CHAN(0, LTC2309_CH0),
+	LTC2309_CHAN(1, LTC2309_CH1),
+	LTC2309_CHAN(2, LTC2309_CH2),
+	LTC2309_CHAN(3, LTC2309_CH3),
+	LTC2309_CHAN(4, LTC2309_CH4),
+	LTC2309_CHAN(5, LTC2309_CH5),
+	LTC2309_CHAN(6, LTC2309_CH6),
+	LTC2309_CHAN(7, LTC2309_CH7),
+	LTC2309_DIFF_CHAN(0, 1, LTC2309_CH0_CH1),
+	LTC2309_DIFF_CHAN(2, 3, LTC2309_CH2_CH3),
+	LTC2309_DIFF_CHAN(4, 5, LTC2309_CH4_CH5),
+	LTC2309_DIFF_CHAN(6, 7, LTC2309_CH6_CH7),
+	LTC2309_DIFF_CHAN(1, 0, LTC2309_CH1_CH0),
+	LTC2309_DIFF_CHAN(3, 2, LTC2309_CH3_CH2),
+	LTC2309_DIFF_CHAN(5, 4, LTC2309_CH5_CH4),
+	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
+};
+
+static int ltc2309_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
+	u16 buf;
+	int ret;
+	u8 din;
+
+	mutex_lock(&ltc2309->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		din = FIELD_PREP(LTC2309_DIN_CH_MASK, chan->address & 0x0f) |
+			FIELD_PREP(LTC2309_DIN_UNI, 1) |
+			FIELD_PREP(LTC2309_DIN_SLEEP, 0);
+
+		ret = i2c_smbus_write_byte(ltc2309->client, din);
+		if (ret < 0) {
+			dev_err(ltc2309->dev, "i2c command failed: %pe\n",
+				ERR_PTR(ret));
+			goto out;
+		}
+
+		ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
+		if (ret < 0) {
+			dev_err(ltc2309->dev, "i2c read failed: %pe\n",
+				ERR_PTR(ret));
+			goto out;
+		}
+
+		*val = be16_to_cpu(buf) >> 4;
+
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = ltc2309->vref_mv;
+		*val2 = LTC2309_ADC_RESOLUTION;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out:
+	mutex_unlock(&ltc2309->lock);
+	return ret;
+}
+
+static const struct iio_info ltc2309_info = {
+	.read_raw = ltc2309_read_raw,
+};
+
+static int ltc2309_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2309 *ltc2309;
+	int ret = 0;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ltc2309 = iio_priv(indio_dev);
+	ltc2309->dev = &indio_dev->dev;
+	ltc2309->client = client;
+	ltc2309->vref_mv = 4096; /* Default to the internal ref */
+
+	indio_dev->name = DRIVER_NAME;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc2309_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->info = &ltc2309_info;
+
+	ltc2309->refcomp = devm_regulator_get_optional(&client->dev, "refcomp");
+	if (!IS_ERR_OR_NULL(ltc2309->refcomp)) {
+		ret = regulator_enable(ltc2309->refcomp);
+		if (ret) {
+			dev_err(ltc2309->dev, "failed to enable REFCOMP\n");
+			return ret;
+		}
+
+		ret = regulator_get_voltage(ltc2309->refcomp);
+		if (ret < 0)
+			return ret;
+
+		ltc2309->vref_mv = ret / 1000;
+		if (ret)
+			return ret;
+	}
+
+	mutex_init(&ltc2309->lock);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id ltc2309_of_match[] = {
+	{ .compatible = "lltc,ltc2309" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2309_of_match);
+
+static const struct i2c_device_id ltc2309_id[] = {
+	{"ltc2309", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ltc2309_id);
+
+static struct i2c_driver ltc2309_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ltc2309_of_match,
+	},
+	.probe		= ltc2309_probe,
+	.id_table	= ltc2309_id,
+};
+module_i2c_driver(ltc2309_driver);
+
+MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
+MODULE_DESCRIPTION("Linear Technology LTC2309 ADC");
+MODULE_LICENSE("GPL v2");

-- 
2.39.0

