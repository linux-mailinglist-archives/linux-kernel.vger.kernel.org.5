Return-Path: <linux-kernel+bounces-32011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D835540
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC176B2193B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8B537157;
	Sun, 21 Jan 2024 10:35:47 +0000 (UTC)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5B36B00;
	Sun, 21 Jan 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833346; cv=none; b=DRD3zeAHgPff7dQhWqcxEUCZaVo+FfxVcx/8+9yMBdubMHChzYHDm+hCo3znDzwrx84rXd26lABEDvxehC+wL1gV613t2TjuhbGKdnrmIIfE9vq2079y75J7Cd/uJUFK90JeYkxxcMKZ9pHZDC0t6bs04KmdTYfKXBnqU5EwTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833346; c=relaxed/simple;
	bh=Wb6M8XBxNNu/xmwdmMOGAKwII+CjP3Atro/4wU/nls8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVuMbp6/BAY5PqiMVc+ui/jhaEc1edZD3d4Yomy+rgQ/MKvCZMsSZ3vMfCFI/ke5mEL5osolhM/M0mNoEsMEmaABs34L4foj+txV0s+bpNMPl2vUNc2CTmsTdHIczCm1zQnADP0NmQbMj/S4mZJeF0Oyw8Z3hgtX+DkQFU2KCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40L4xkGv011754;
	Sun, 21 Jan 2024 05:35:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vr8w7bgwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jan 2024 05:35:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40LAZTtc059850
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 21 Jan 2024 05:35:29 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 21 Jan 2024 05:35:28 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40LAZAof021011;
	Sun, 21 Jan 2024 05:35:23 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kim
 Seer Paller" <kimseer.paller@analog.com>
Subject: [PATCH 2/2] gpio: gpio-adg1414: New driver
Date: Sun, 21 Jan 2024 18:35:05 +0800
Message-ID: <20240121103505.26475-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121103505.26475-1-kimseer.paller@analog.com>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: n7xPRH64Yqg_pLCV_UZII8v7YDAwOTKm
X-Proofpoint-ORIG-GUID: n7xPRH64Yqg_pLCV_UZII8v7YDAwOTKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_06,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401210082

The ADG1414 is a 9.5 Ω RON ±15 V/+12 V/±5 V iCMOS Serially-Controlled
Octal SPST Switches

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS                 |   1 +
 drivers/gpio/Kconfig        |  10 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-adg1414.c | 141 ++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 drivers/gpio/gpio-adg1414.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 526145e69..254ba7ea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -466,6 +466,7 @@ M:	Kim Seer Paller <kimseer.paller@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
+F:	drivers/gpio/gpio-adg1414.c
 
 ADM1025 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1301cec94..25d467d70 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1728,6 +1728,16 @@ config GPIO_74X164
 	  shift registers. This driver can be used to provide access
 	  to more GPIO outputs.
 
+config GPIO_ADG1414
+	tristate "ADG1414 SPST Switch Driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADG1414 SPST
+	  Switch Driver
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-adg1414.
+
 config GPIO_MAX3191X
 	tristate "Maxim MAX3191x industrial serializer"
 	select CRC8
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9e40af196..9ab45d128 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_GPIO_104_IDI_48)		+= gpio-104-idi-48.o
 obj-$(CONFIG_GPIO_104_IDIO_16)		+= gpio-104-idio-16.o
 obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
+obj-$(CONFIG_GPIO_ADG1414)		+= gpio-adg1414.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
 obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
diff --git a/drivers/gpio/gpio-adg1414.c b/drivers/gpio/gpio-adg1414.c
new file mode 100644
index 000000000..6c0830ee2
--- /dev/null
+++ b/drivers/gpio/gpio-adg1414.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADG1414 SPST Switch Driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+#define ADG1414_MAX_DEVICES		4
+
+struct adg1414_state {
+	struct spi_device		*spi;
+	struct gpio_chip		chip;
+	struct mutex			lock; /* protect sensor state */
+	u32				buf;
+
+	__be32				tx __aligned(ARCH_DMA_MINALIGN);
+};
+
+static void adg1414_set(struct gpio_chip *chip,
+			unsigned int offset,
+			int value)
+{
+	struct adg1414_state *st = gpiochip_get_data(chip);
+	int ret;
+
+	struct spi_transfer xfer = {
+		.tx_buf = &st->tx,
+		.len = st->chip.ngpio / 8,
+	};
+
+	mutex_lock(&st->lock);
+
+	if (value)
+		st->buf |= BIT(offset);
+	else
+		st->buf &= ~BIT(offset);
+
+	st->tx = cpu_to_be32(st->buf << (32 - st->chip.ngpio));
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		goto out;
+
+out:
+	mutex_unlock(&st->lock);
+}
+
+static int adg1414_get(struct gpio_chip *chip,
+		       unsigned int offset)
+{
+	struct adg1414_state *st = gpiochip_get_data(chip);
+	int value;
+
+	mutex_lock(&st->lock);
+
+	value = st->buf & BIT(offset);
+
+	mutex_unlock(&st->lock);
+
+	return value;
+}
+
+static int adg1414_get_direction(struct gpio_chip *chip,
+				 unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int adg1414_probe(struct spi_device *spi)
+{
+	struct adg1414_state *st;
+	struct gpio_desc *reset;
+	struct device *dev = &spi->dev;
+	u32 num_devices;
+	int ret;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->spi = spi;
+
+	/* Use reset pin to reset the device */
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "Failed to get reset gpio");
+
+	if (reset) {
+		fsleep(1);
+		gpiod_set_value_cansleep(reset, 0);
+	}
+
+	num_devices = 1;
+	ret = device_property_read_u32(dev, "#daisy-chained-devices",
+				       &num_devices);
+	if (!ret) {
+		if (!num_devices || num_devices > ADG1414_MAX_DEVICES)
+			return dev_err_probe(dev, ret,
+			       "Failed to get daisy-chained-devices property\n");
+	}
+
+	st->chip.label = "adg1414";
+	st->chip.parent = dev;
+	st->chip.get_direction = adg1414_get_direction;
+	st->chip.set = adg1414_set;
+	st->chip.get = adg1414_get;
+	st->chip.base = -1;
+	st->chip.ngpio =  num_devices * 8;
+	st->chip.can_sleep = true;
+
+	mutex_init(&st->lock);
+
+	return devm_gpiochip_add_data(dev, &st->chip, st);
+}
+
+static const struct of_device_id adg1414_of_match[] = {
+	{ .compatible = "adi,adg1414" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adg1414_of_match);
+
+static struct spi_driver adg1414_driver = {
+	.driver = {
+		.name = "adg1414",
+		.of_match_table = adg1414_of_match,
+	},
+	.probe = adg1414_probe,
+};
+module_spi_driver(adg1414_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("ADG1414 SPST Switch Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


