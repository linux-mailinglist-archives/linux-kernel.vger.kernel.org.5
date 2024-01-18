Return-Path: <linux-kernel+bounces-29926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684B831549
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452931C21577
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37193200BC;
	Thu, 18 Jan 2024 08:59:46 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D301F60B;
	Thu, 18 Jan 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568385; cv=none; b=GLx57FTSl0zOMg8uhqMeeu9A/Rptqo9yRVzBR5sAFxK7v0TZsD83yk0BgYUK91vhjDFZbj4w5QnDr99Rpf8qPwnKA21I+fJviIMGkSbOiX00TEkOi3u++3FBmsPlrrGlWJpKecb/oXWwWjqSeX3a5O7846oxfl36o+6aDwPNLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568385; c=relaxed/simple;
	bh=Wnc2vLVgvh+f6D4g01DZsrNrW50DfkPwAg8oVF51w2k=;
	h=Received:Received:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=WwBUpfJAoEbHAeOkAqvfWtVd3E/L3CV4DeyPWu7feEb3u6TraXP/X6/NZuNmYmBx3heKz6+zxwDDAu6zOkfi3yqalovSy8VVaOJs7HY/Lzr3DU8yOkueC1hqJsb4YNzqMVERPykYI1mIm7Ie+WGQVX9wj+m5dcrq608HdRs8AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6lTCD003257;
	Thu, 18 Jan 2024 03:59:28 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vpy1fgfkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 03:59:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40I8xQG3001139
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:59:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 18 Jan
 2024 03:59:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jan 2024 03:59:25 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40I8x0RD005188;
	Thu, 18 Jan 2024 03:59:18 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Crt
 Mori <cmo@melexis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz
 Golaszewski <brgl@bgdev.pl>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v6 2/2] iio: frequency: admfm2000: New driver
Date: Thu, 18 Jan 2024 16:58:56 +0800
Message-ID: <20240118085856.70758-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118085856.70758-1-kimseer.paller@analog.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZOuICzXcb8C1VPOnkuE7NSECsfBi3eaz
X-Proofpoint-GUID: ZOuICzXcb8C1VPOnkuE7NSECsfBi3eaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180063

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V5 -> V6: Used devm_fwnode_gpiod_get_index for getting array of gpios.
V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
	  declarations in probe function.
V1 -> V4: No changes.

 MAINTAINERS                       |   1 +
 drivers/iio/frequency/Kconfig     |  10 +
 drivers/iio/frequency/Makefile    |   1 +
 drivers/iio/frequency/admfm2000.c | 307 ++++++++++++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 drivers/iio/frequency/admfm2000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a86f9d6cb98..49d320535105 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1266,6 +1266,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
+F:	drivers/iio/frequency/admfm2000.c
 
 ANALOG DEVICES INC ADMV1013 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 9e85dfa58508..c455be7d4a1c 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -60,6 +60,16 @@ config ADF4377
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4377.
 
+config ADMFM2000
+	tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices ADMFM2000 Dual
+	  Microwave Down Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admfm2000.
+
 config ADMV1013
 	tristate "Analog Devices ADMV1013 Microwave Upconverter"
 	depends on SPI && COMMON_CLK
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index b616c29b4a08..70d0e0b70e80 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
 obj-$(CONFIG_ADF4377) += adf4377.o
+obj-$(CONFIG_ADMFM2000) += admfm2000.o
 obj-$(CONFIG_ADMV1013) += admv1013.o
 obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADMV4420) += admv4420.o
diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
new file mode 100644
index 000000000000..a09ec38fad22
--- /dev/null
+++ b/drivers/iio/frequency/admfm2000.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADMFM2000 Dual Microwave Down Converter
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define ADMFM2000_MIXER_MODE		0
+#define ADMFM2000_DIRECT_IF_MODE	1
+#define ADMFM2000_DSA_GPIOS		5
+#define ADMFM2000_MODE_GPIOS		2
+#define ADMFM2000_MAX_GAIN		0
+#define ADMFM2000_MIN_GAIN		-31000
+#define ADMFM2000_DEFAULT_GAIN		-0x20
+
+struct admfm2000_state {
+	struct mutex			lock; /* protect sensor state */
+	struct gpio_desc		*sw1_ch[2];
+	struct gpio_desc		*sw2_ch[2];
+	struct gpio_desc		*dsa1_gpios[5];
+	struct gpio_desc		*dsa2_gpios[5];
+	u32				gain[2];
+};
+
+static int admfm2000_mode(struct iio_dev *indio_dev, u32 chan, u32 mode)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (mode) {
+	case ADMFM2000_MIXER_MODE:
+		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+			gpiod_set_value_cansleep(st->sw1_ch[i], (chan == 0) ? 1 : 0);
+			gpiod_set_value_cansleep(st->sw2_ch[i], (chan == 0) ? 0 : 1);
+		}
+		return 0;
+	case ADMFM2000_DIRECT_IF_MODE:
+		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+			gpiod_set_value_cansleep(st->sw1_ch[i], (chan == 0) ? 0 : 1);
+			gpiod_set_value_cansleep(st->sw2_ch[i], (chan == 0) ? 1 : 0);
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_attenuation(struct iio_dev *indio_dev, u32 chan, u32 value)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (chan) {
+	case 0:
+		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++)
+			gpiod_set_value_cansleep(st->dsa1_gpios[i], value & (1 << i));
+		return 0;
+	case 1:
+		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++)
+			gpiod_set_value_cansleep(st->dsa2_gpios[i], value & (1 << i));
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		gain = ~(st->gain[chan->channel]) * -1000;
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
+		mutex_unlock(&st->lock);
+
+		return  IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain, ret;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > ADMFM2000_MAX_GAIN || gain < ADMFM2000_MIN_GAIN)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
+
+		ret = admfm2000_attenuation(indio_dev, chan->channel,
+					     st->gain[chan->channel]);
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int admfm2000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info admfm2000_info = {
+	.read_raw = &admfm2000_read_raw,
+	.write_raw = &admfm2000_write_raw,
+	.write_raw_get_fmt = &admfm2000_write_raw_get_fmt,
+};
+
+#define ADMFM2000_CHAN(_channel) {					\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+}
+
+static const struct iio_chan_spec admfm2000_channels[] = {
+	ADMFM2000_CHAN(0),
+	ADMFM2000_CHAN(1),
+};
+
+static int admfm2000_channel_config(struct admfm2000_state *st,
+				    struct iio_dev *indio_dev)
+{
+	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child;
+	u32 reg, mode;
+	int ret, i;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Failed to get reg property\n");
+		}
+
+		if (reg >= indio_dev->num_channels) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
+					     indio_dev->num_channels);
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,mode", &mode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Failed to get mode property\n");
+		}
+
+		if (mode >= 2) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
+		}
+
+		switch (reg) {
+		case 0:
+			for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+				st->sw1_ch[i] = devm_fwnode_gpiod_get_index(dev, child,
+									    "switch", i,
+									    GPIOD_OUT_LOW,
+									    NULL);
+				if (IS_ERR(st->sw1_ch[i])) {
+					fwnode_handle_put(child);
+					return dev_err_probe(dev, PTR_ERR(st->sw1_ch[i]),
+							     "Failed to get gpios\n");
+				}
+			}
+
+			for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
+				st->dsa1_gpios[i] = devm_fwnode_gpiod_get_index(dev, child,
+										"attenuation", i,
+										GPIOD_OUT_LOW,
+										NULL);
+				if (IS_ERR(st->dsa1_gpios[i])) {
+					fwnode_handle_put(child);
+					return dev_err_probe(dev, PTR_ERR(st->dsa1_gpios[i]),
+							     "Failed to get gpios\n");
+				}
+			}
+			break;
+		case 1:
+			for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+				st->sw2_ch[i] = devm_fwnode_gpiod_get_index(dev, child,
+									    "switch", i,
+									    GPIOD_OUT_LOW,
+									    NULL);
+				if (IS_ERR(st->sw2_ch[i])) {
+					fwnode_handle_put(child);
+					return dev_err_probe(dev, PTR_ERR(st->sw2_ch[i]),
+							     "Failed to get gpios\n");
+				}
+			}
+
+			for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
+				st->dsa2_gpios[i] = devm_fwnode_gpiod_get_index(dev, child,
+										"attenuation", i,
+										GPIOD_OUT_LOW,
+										NULL);
+				if (IS_ERR(st->dsa2_gpios[i])) {
+					fwnode_handle_put(child);
+					return dev_err_probe(dev, PTR_ERR(st->dsa2_gpios[i]),
+							     "Failed to get gpios\n");
+				}
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = admfm2000_mode(indio_dev, reg, mode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int admfm2000_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct admfm2000_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	indio_dev->name = "admfm2000";
+	indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
+	indio_dev->channels = admfm2000_channels;
+	indio_dev->info = &admfm2000_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->gain[0] = ADMFM2000_DEFAULT_GAIN;
+	st->gain[1] = ADMFM2000_DEFAULT_GAIN;
+
+	mutex_init(&st->lock);
+
+	ret = admfm2000_channel_config(st, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id admfm2000_of_match[] = {
+	{ .compatible = "adi,admfm2000" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, admfm2000_of_match);
+
+static struct platform_driver admfm2000_driver = {
+	.driver = {
+		.name = "admfm2000",
+		.of_match_table = admfm2000_of_match,
+	},
+	.probe = admfm2000_probe,
+};
+module_platform_driver(admfm2000_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("ADMFM2000 Dual Microwave Down Converter");
+MODULE_LICENSE("GPL");
-- 
2.34.1


