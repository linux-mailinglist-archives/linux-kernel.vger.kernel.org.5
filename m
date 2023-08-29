Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1B78BCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjH2CnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjH2Cml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:42:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746ACC1;
        Mon, 28 Aug 2023 19:42:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-64a0176b1easo22914086d6.3;
        Mon, 28 Aug 2023 19:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276930; x=1693881730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD3dp6ywatUqJmmcU6/0kDuW7atzOmkLXwYmjb97oFw=;
        b=MJVIsIDEMKmLXmlCmA2Uh9y2OP+3vjlDvmFhX5zV0RvIJfp67llC/Bo53xWZ0oHhP8
         6OekiLcqF5pUDcWmzudWZSyHF16XETyGBnFAOgIyfQfT/R+5BqEk5UHOz9483D4xOo38
         SLX7B3Y9STyx7Fv1yEJxyNhNIEzDpeJF7YZ2yYLxJDFjnFZvmM5rz53mOiznWvDOa5CN
         XZma5p1PQ//UIQ9i8TAGh70SanRBdpiInEqmUBjxeiJx3TWI1Zq7JSwsylk2dmGoXS5w
         44ZMJctrjMiEpkaMMgNVA5NY0P1BiCJieyzSIaZP0hqPkXH0Gxm7tbdVrdPaphORI6Ak
         MRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276930; x=1693881730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD3dp6ywatUqJmmcU6/0kDuW7atzOmkLXwYmjb97oFw=;
        b=j3rnuzr9mWorbXAYcdezyvl9dWwOxAigalOi7D4gUDEPcf9+OXVsL7fQk9neJ9berm
         rPvyarzo+U8Sq1xofsEqxDZ3ljsVcf8qYdmaM6zYVWsirKmzQUapJ1AfJ+mNWjwaf5Lc
         4oY9FDNaGcS3XDKFfN7Re0rnQmBhsdb4r/V53KJ2cbI9/PKQ3uJiLK00O7A30nze7zen
         Nq7qyDzm1tGZ/+t8XoK0MZo8si+Yp9AIyNP1sKtcNnx88ichgss97g8JRZSou9h2aIod
         4BiT7XSJTFAIGhyrQKp6dAIWpsKoV0STQuHupc8hCTBxmBv9mJBFpWFL68eB8jE2vjmH
         sMbw==
X-Gm-Message-State: AOJu0Yw0pHmCIO2ZNGyYL2aqhgQGCwZrXPMrWwJY7yfxA4in5hIU0s5Y
        LE6jpdXUfuiAMiKZYliR3/I=
X-Google-Smtp-Source: AGHT+IGdWu/Uq7e4TXzalJgvnNguBk982+LlKpa71KSUvwHQZrUQpiDgG0rBl7oN66Yun//zW6Q2/g==
X-Received: by 2002:a0c:f1cc:0:b0:651:65f4:31fa with SMTP id u12-20020a0cf1cc000000b0065165f431famr4384482qvl.39.1693276929989;
        Mon, 28 Aug 2023 19:42:09 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce509000000b0063cf4d0d558sm3010037qvm.25.2023.08.28.19.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:42:09 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Mon, 28 Aug 2023 22:41:35 -0400
Subject: [PATCH v3 2/2] iio: adc: add ltc2309 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-ltc2309-v3-2-338b3a8fab8b@gmail.com>
References: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
In-Reply-To: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693276926; l=8491;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=sWghY5YoSselhOI/wP/CfB9MXdV+hoBdPExmSuyL6tc=;
 b=Jspv5wyG+7R0X8RZWC646wlm/gQpCgjfsWVWV1qQj1EUwvKks1ue/gLR1H2t/zrB9yFaoXbMq
 oC5+Oz+5bg/BECprnVeBKwSC1uH3xhJabHWkq329jJjg3ThGd80AI28
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
 drivers/iio/adc/ltc2309.c | 249 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)

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
index 000000000000..3f8e1d238639
--- /dev/null
+++ b/drivers/iio/adc/ltc2309.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
+ *
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
+ *
+ * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+
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
+/**
+ * struct ltc2309 - internal device data structure
+ * @dev:	Device reference
+ * @client:	I2C reference
+ * @vref:	External reference source
+ * @lock:	Lock to serialize data access
+ * @vref_mv	Internal voltage reference
+ */
+struct ltc2309 {
+	struct device		*dev;
+	struct i2c_client	*client;
+	struct regulator	*vref;
+	struct mutex		lock; /* serialize data access */
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
+static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
+				    unsigned long address, int *val)
+{
+	int ret;
+	u16 buf;
+	u8 din;
+
+	din = FIELD_PREP(LTC2309_DIN_CH_MASK, address & 0x0f) |
+		FIELD_PREP(LTC2309_DIN_UNI, 1) |
+		FIELD_PREP(LTC2309_DIN_SLEEP, 0);
+
+	ret = i2c_smbus_write_byte(ltc2309->client, din);
+	if (ret < 0) {
+		dev_err(ltc2309->dev, "i2c command failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
+	if (ret < 0) {
+		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	*val = be16_to_cpu(buf) >> 4;
+
+	return ret;
+}
+
+static int ltc2309_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&ltc2309->lock);
+		ret = ltc2309_read_raw_channel(ltc2309, chan->address, val);
+		mutex_unlock(&ltc2309->lock);
+		if (ret < 0)
+			return -EINVAL;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = ltc2309->vref_mv;
+		*val2 = LTC2309_ADC_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltc2309_info = {
+	.read_raw = ltc2309_read_raw,
+};
+
+void ltc2309_regulator_disable(void *regulator)
+{
+	struct regulator *r = (struct regulator *)regulator;
+
+	regulator_disable(r);
+}
+
+static int ltc2309_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2309 *ltc2309;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ltc2309 = iio_priv(indio_dev);
+	ltc2309->dev = &indio_dev->dev;
+	ltc2309->client = client;
+	ltc2309->vref_mv = 4096; /* Default to the internal ref */
+
+	indio_dev->name = "ltc2309";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc2309_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->info = &ltc2309_info;
+
+	ltc2309->vref = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(ltc2309->vref)) {
+		ret = PTR_ERR(ltc2309->vref);
+		if (ret == -ENODEV)
+			ltc2309->vref = NULL;
+		else
+			return ret;
+	}
+
+	if (ltc2309->vref) {
+		ret = regulator_enable(ltc2309->vref);
+		if (ret)
+			return dev_err_probe(ltc2309->dev, ret,
+					     "failed to enable vref\n");
+
+		ret = devm_add_action_or_reset(ltc2309->dev,
+					       ltc2309_regulator_disable,
+					       ltc2309->vref);
+		if (ret) {
+			return dev_err_probe(ltc2309->dev, ret,
+					     "failed to add regulator_disable action: %d\n",
+					     ret);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(ltc2309->vref);
+		if (ret < 0)
+			return ret;
+
+		ltc2309->vref_mv = ret / 1000;
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
+	{ "ltc2309" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltc2309_id);
+
+static struct i2c_driver ltc2309_driver = {
+	.driver = {
+		.name = "ltc2309",
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

