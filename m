Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED07B3AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjI2UI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjI2UIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:08:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4ACDE;
        Fri, 29 Sep 2023 13:08:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50307acd445so22428912e87.0;
        Fri, 29 Sep 2023 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696018130; x=1696622930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC51NPRQArVOguHDhk9mg73V7ayqVja4w0iQeM4AXP8=;
        b=MYIVJmmXRVsZZYYKyHGv1YRu3jpCmetPpaaX9VwNEXYg1Lo70V6kD7knCID/YUeTqH
         DU77xXc9+sII2/V9HvR0+FVa8rOghFqLATlzwJpxNfEZNZByu8UvgiiC2T/s0FCsfJsY
         Zrc0rZjW5Pgcu2ySP3OX/ioA82vA357gxW9T34qr3SdS6tRhf4mrtqwounTd2EcgMxj1
         YhbjCjnGKWAsfQv7T8kgl3OBxfyjKzTlxtQmN7LxNxEHGhoAye7Q9Ub+H+VyoRcbT95h
         uCfjMnHsETHSBqTEt/aYcoCm4i0dEFniNzCxkO+gEpenrLfT8VPgpL7MzF0TRgPcgngL
         +ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696018130; x=1696622930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC51NPRQArVOguHDhk9mg73V7ayqVja4w0iQeM4AXP8=;
        b=CTOAxi4/KHriLYZcCahR1AS84LDFF2ix2qCbn+0xk448ko1Rdfzx5Cdhc1gGZRfR3x
         CLT+OIROQpJnAR7E7j9RtYtNkAHwtnBRZjDA9mOFrO1AwMEQVxdlt6fXWS49LYEKYKZf
         5QHwEWaA+KPgVkkul3b0HyyZlQKytaeAwUsQ9XOcYsd7Ybx1olI1bHQbbF/fFw1f205E
         AC4xGj2PIIQhN3p9fEiLaN2rBdyIXJlskziNuQQsGWgcHLHMsF2Vk0s1nRhhha3fpbvX
         OHfFAEPK0ROiemZXsDwt4mMoa7LbS/j9c8aUV/mODiDp21p/NIKl5/8c1wjEwSkuaTZi
         ZL6w==
X-Gm-Message-State: AOJu0YxLEmcTotjQh8pieQPAa3J/vXL1YD6Xqr+X97Zs2IS+/eF3Elv1
        9xQvb3fhjgbhnecyMizD060=
X-Google-Smtp-Source: AGHT+IG443+hefjLULzrdFkEPSyGQ0Nk1q1BDyJwXSutahsATYEZeByVLtA0m5nsKeKcUcsa7wCDKA==
X-Received: by 2002:ac2:4f0b:0:b0:500:9dd4:2969 with SMTP id k11-20020ac24f0b000000b005009dd42969mr5411060lfr.59.1696018129510;
        Fri, 29 Sep 2023 13:08:49 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id v12-20020a19740c000000b005056e9b734esm422439lfe.151.2023.09.29.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:08:49 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: Add driver support for MAX34408/9
Date:   Fri, 29 Sep 2023 23:08:44 +0300
Message-ID: <20230929200844.23316-3-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929200844.23316-1-fr0st61te@gmail.com>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX34408/MAX34409 are two- and four-channel current monitors that are
configured and monitored with a standard I2C/SMBus serial interface. Each
unidirectional current sensor offers precision high-side operation with a
low full-scale sense voltage. The devices automatically sequence through
two or four channels and collect the current-sense samples and average them
to reduce the effect of impulse noise. The raw ADC samples are compared to
user-programmable digital thresholds to indicate overcurrent conditions.
Overcurrent conditions trigger a hardware output to provide an immediate
indication to shut down any necessary external circuitry.

Add as ADC driver which only supports current monitoring for now.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 drivers/iio/adc/Kconfig    |  11 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max34408.c | 334 +++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/iio/adc/max34408.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 517b3db114b8..c215a2861350 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -735,6 +735,17 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX34408
+	tristate "Maxim max34408/max344089 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Maxim max34408/max34409 current sense
+	  monitor with 8-bits ADC interface with overcurrent delay/threshold and
+	  shutdown delay.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max34408.
+
 config MAX77541_ADC
 	tristate "Analog Devices MAX77541 ADC driver"
 	depends on MFD_MAX77541
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 2facf979327d..46dceab85e9a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX34408) += max34408.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
new file mode 100644
index 000000000000..f576c65e3900
--- /dev/null
+++ b/drivers/iio/adc/max34408.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Maxim MAX34409/34408 ADC, 4-Channels/2-Channels, 8bits, I2C
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+ *
+ * TODO: ALERT interrupt, Overcurrent delay, Shutdown delay
+ */
+
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define MAX34408_STATUS_REG		0x0
+#define MAX34408_CONTROL_REG		0x1
+#define MAX34408_OCDELAY_REG		0x2
+#define MAX34408_SDDELAY_REG		0x3
+
+#define MAX34408_ADC1_REG		0x4
+#define MAX34408_ADC2_REG		0x5
+/* ADC3 & ADC4 always returns 0x0 on 34408 */
+#define MAX34409_ADC3_REG		0x6
+#define MAX34409_ADC4_REG		0x7
+
+#define MAX34408_OCT1_REG		0x8
+#define MAX34408_OCT2_REG		0x9
+#define MAX34408_OCT3_REG		0xA
+#define MAX34408_OCT4_REG		0xB
+
+#define MAX34408_DID_REG		0xC
+#define MAX34408_DCYY_REG		0xD
+#define MAX34408_DCWW_REG		0xE
+
+/* Bit masks for status register */
+#define MAX34408_STATUS_OC_MSK		GENMASK(1, 0)
+#define MAX34409_STATUS_OC_MSK		GENMASK(3, 0)
+#define MAX34408_STATUS_SHTDN		BIT(4)
+#define MAX34408_STATUS_ENA		BIT(5)
+
+/* Bit masks for control register */
+#define MAX34408_CONTROL_AVG0		BIT(0)
+#define MAX34408_CONTROL_AVG1		BIT(1)
+#define MAX34408_CONTROL_AVG2		BIT(2)
+#define MAX34408_CONTROL_ALERT		BIT(3)
+
+/* Bit masks for over current delay */
+#define MAX34408_OCDELAY_OCD_MSK	GENMASK(6, 0)
+#define MAX34408_OCDELAY_RESET		BIT(7)
+
+/* Bit masks for shutdown delay */
+#define MAX34408_SDDELAY_SHD_MSK	GENMASK(6, 0)
+#define MAX34408_SDDELAY_RESET		BIT(7)
+
+#define MAX34408_DEFAULT_RSENSE		1000
+
+/**
+ * struct max34408_data - max34408/max34409 specific data.
+ * @regmap:	device register map.
+ * @dev:	max34408 device.
+ * @lock:	lock for protecting access to device hardware registers, mostly
+ *		for read modify write cycles for control registers.
+ * @rsense:	Rsense value in uOhm.
+ */
+struct max34408_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	u32 input1_rsense;
+	u32 input2_rsense;
+	u32 input3_rsense;
+	u32 input4_rsense;
+};
+
+static const struct regmap_config max34408_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34408_DCWW_REG,
+};
+
+struct max34408_adc_model_data {
+	const char *model_name;
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+};
+
+#define MAX34008_CHANNEL(_index)					\
+	{								\
+		.type = IIO_CURRENT,					\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |	\
+					  BIT(IIO_CHAN_INFO_SCALE) |	\
+					  BIT(IIO_CHAN_INFO_OFFSET),	\
+		.channel = (_index),					\
+		.indexed = 1,						\
+	}
+
+static const struct iio_chan_spec max34408_channels[] = {
+	MAX34008_CHANNEL(0),
+	MAX34008_CHANNEL(1),
+};
+
+static const struct iio_chan_spec max34409_channels[] = {
+	MAX34008_CHANNEL(0),
+	MAX34008_CHANNEL(1),
+	MAX34008_CHANNEL(2),
+	MAX34008_CHANNEL(3),
+};
+
+static int max34408_read_adc(struct max34408_data *max34408, int channel,
+			     int *val)
+{
+	u32 adc_reg;
+
+	switch (channel) {
+	case 0:
+		adc_reg = MAX34408_ADC1_REG;
+		break;
+	case 1:
+		adc_reg = MAX34408_ADC2_REG;
+		break;
+	case 2:
+		adc_reg = MAX34409_ADC3_REG;
+		break;
+	case 3:
+		adc_reg = MAX34409_ADC4_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_read(max34408->regmap, adc_reg, val);
+}
+
+static int max34408_read_adc_avg(struct max34408_data *max34408, int channel, int *val)
+{
+	unsigned int ctrl;
+	int rc;
+	u8 tmp;
+
+	guard(mutex)(&max34408->lock);
+	rc = regmap_read(max34408->regmap, MAX34408_CONTROL_REG, (u32 *)&ctrl);
+	if (rc)
+		return rc;
+
+	/* set averaging (0b100) default values*/
+	tmp = ctrl;
+	ctrl |= MAX34408_CONTROL_AVG2;
+	ctrl &= ~MAX34408_CONTROL_AVG1;
+	ctrl &= ~MAX34408_CONTROL_AVG0;
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, ctrl);
+	if (rc) {
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+		return rc;
+	}
+
+	rc = max34408_read_adc(max34408, channel, val);
+	if (rc)
+		return rc;
+
+	/* back to old values */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, tmp);
+	if (rc)
+		dev_err(max34408->dev,
+			"Error (%d) writing control register\n", rc);
+
+	return rc;
+}
+
+static int max34408_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max34408_data *max34408 = iio_priv(indio_dev);
+	int input_rsense;
+	int rc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		rc = max34408_read_adc_avg(max34408, chan->channel,
+					   val);
+		if (rc)
+			return rc;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * calcluate current for 8bit ADC with Rsense
+		 * value.
+		 * 10 mV * 1000 / Rsense uOhm = max current
+		 * (max current * adc val * 1000) / (2^8 - 1) mA
+		 */
+		switch (chan->channel) {
+		case 0:
+			input_rsense = max34408->input1_rsense;
+			break;
+		case 1:
+			input_rsense = max34408->input2_rsense;
+			break;
+		case 2:
+			input_rsense = max34408->input3_rsense;
+			break;
+		case 3:
+			input_rsense = max34408->input4_rsense;
+			break;
+		default:
+			return -EINVAL;
+		}
+		*val = 10000 / input_rsense;
+		*val2 = 8;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max34408_info = {
+	.read_raw	= max34408_read_raw,
+};
+
+static const struct max34408_adc_model_data max34408_model_data = {
+	.model_name = "max34408",
+	.channels = max34408_channels,
+	.num_channels = 2,
+};
+
+static const struct max34408_adc_model_data max34409_model_data = {
+	.model_name = "max34409",
+	.channels = max34409_channels,
+	.num_channels = 4,
+};
+
+static const struct of_device_id max34408_of_match[] = {
+	{
+		.compatible = "maxim,max34408",
+		.data = &max34408_model_data,
+	},
+	{
+		.compatible = "maxim,max34409",
+		.data = &max34409_model_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, max34408_of_match);
+
+static int max34408_probe(struct i2c_client *client)
+{
+	const struct max34408_adc_model_data *model_data;
+	const struct of_device_id *match;
+	struct max34408_data *max34408;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc;
+
+	match = of_match_device(max34408_of_match, &client->dev);
+	if (!match)
+		return -EINVAL;
+	model_data = match->data;
+
+	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err_probe(&client->dev, PTR_ERR(regmap),
+			      "regmap_init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max34408));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	max34408 = iio_priv(indio_dev);
+	max34408->regmap = regmap;
+	max34408->dev = &client->dev;
+	mutex_init(&max34408->lock);
+
+	rc = device_property_read_u32(&client->dev,
+				      "maxim,input1-rsense-val-micro-ohms",
+				      &max34408->input1_rsense);
+	if (rc)
+		max34408->input1_rsense = MAX34408_DEFAULT_RSENSE;
+
+	rc = device_property_read_u32(&client->dev,
+				      "maxim,input2-rsense-val-micro-ohms",
+				      &max34408->input2_rsense);
+	if (rc)
+		max34408->input2_rsense = MAX34408_DEFAULT_RSENSE;
+
+	rc = device_property_read_u32(&client->dev,
+				      "maxim,input3-rsense-val-micro-ohms",
+				      &max34408->input3_rsense);
+	if (rc)
+		max34408->input3_rsense = MAX34408_DEFAULT_RSENSE;
+
+	rc = device_property_read_u32(&client->dev,
+				      "maxim,input4-rsense-val-micro-ohms",
+				      &max34408->input4_rsense);
+	if (rc)
+		max34408->input4_rsense = MAX34408_DEFAULT_RSENSE;
+
+	/* disable ALERT and averaging */
+	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, 0x0);
+	if (rc)
+		return rc;
+
+	indio_dev->channels = model_data->channels;
+	indio_dev->num_channels = model_data->num_channels;
+	indio_dev->name = model_data->model_name;
+
+	indio_dev->info = &max34408_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static struct i2c_driver max34408_driver = {
+	.driver = {
+		.name   = "max34408",
+		.of_match_table = max34408_of_match,
+	},
+	.probe = max34408_probe,
+};
+module_i2c_driver(max34408_driver);
+
+MODULE_AUTHOR("Ivan Mikhaylov <fr0st61te@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX34408/34409 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

