Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBD7B7D08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbjJDKXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjJDKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:23:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92BD95;
        Wed,  4 Oct 2023 03:23:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1959850f8f.0;
        Wed, 04 Oct 2023 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696415015; x=1697019815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7nQ0uIziiyZOrBvz20AVk6ovJ+kidjNVmlOM815bs4=;
        b=VjJvARiNTd12vZnBa8wFihhmmnpmFKNp//Q0yQH8ptrMcKfpXdp1Z+gu07GyleCLSk
         DCVmYikdiMvYg/nHHZvsES2vda+Z+DJYkuZ+HmqSK7LKvaNakS/iyly/lpsk5av2ztrF
         HiX/RsMWXASvpJvaEQ3hJpx2xfOobI0DyA4MJpQJ4UW1zxk0vJ92tGEo3qDaHopo9vmg
         sAGpalfeXC7Wj9hMs+ZIlSWSF60acLrMWNWBmu39m8XkaObSRwQc7XOxu+tmoO7ywJpq
         WD76YaWBimUDkcL2K7/Sl8TAjyd1cimYrUrlIggkYeO/NhhmNQb9JvcXVT7kz88nG9Ch
         is5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696415015; x=1697019815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7nQ0uIziiyZOrBvz20AVk6ovJ+kidjNVmlOM815bs4=;
        b=gmLvJGT+SaFbicEOk5sBEKNiKao4AlPzqiqgMm8yPXJR13LayeCUh264jVBtq24JI5
         TIaibtLQW4frqHW/QDpWsIq9usAQ5lSwe2AYeoye4BKUmXlklRPXaMnmiz6fMwfVT0WH
         +taWYK4suz4mXjIFcxpdkJBMjUjpLuUrlN7L8iHbP2gNZXbKghmc+6xVb+Vdp/nP6/t+
         RkuU1UPnzhj5P+vPhzaBFgze8zn5wRojqvgCWlw7ViN7DkEzRHgBZXHNCV236zeIBMMm
         B8Fhs3LrjG1UsoQ5cfDYj2qH1aIV65BEyTpZJmBhwD2tJVKQ6IUvlPI6kRUPwzE3WZQf
         hAXg==
X-Gm-Message-State: AOJu0YyEDwBP5hyh5fjM9wQwIMt0U/RgXT4TARINdq/v0Iha5nIebcqx
        OM4yMST8sSH10IvuMBCam68=
X-Google-Smtp-Source: AGHT+IHTcraEcRDTuQAJMcmPvZKGuaQH6cW7zALtHGz9Pcbw8qIjCZRnBFSJLoWLCpL3ZtuaeWyWIA==
X-Received: by 2002:adf:fd46:0:b0:31c:7001:3873 with SMTP id h6-20020adffd46000000b0031c70013873mr1660203wrs.60.1696415014959;
        Wed, 04 Oct 2023 03:23:34 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d63cf000000b003143c9beeaesm3631043wrw.44.2023.10.04.03.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:23:34 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH 2/2] iio: adc: ads7038: Add driver support for 12bit ADC
Date:   Wed,  4 Oct 2023 12:23:30 +0200
Message-ID: <20231004102330.3713-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004102330.3713-1-andre.werner@systec-electronic.com>
References: <20231004102330.3713-1-andre.werner@systec-electronic.com>
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

From: Andre Werner <andre.werner@systec-electronic.com>

The driver is designed to support both, ADS7038 and ADS7138, but the
implementation of the device access is limited to ADS7038 (SPI). The
ADS7138 is accessed via I2C.

The driver has a regmap and a core file that abstracts device access.
Currently, the driver does support manual mode only.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 MAINTAINERS                         |  10 +
 drivers/iio/adc/Kconfig             |  22 ++
 drivers/iio/adc/Makefile            |   3 +
 drivers/iio/adc/ti-ads7038-core.c   | 137 +++++++
 drivers/iio/adc/ti-ads7038-regmap.c |  91 +++++
 drivers/iio/adc/ti-ads7038-spi.c    | 375 +++++++++++++++++++
 drivers/iio/adc/ti-ads7038.h        | 551 ++++++++++++++++++++++++++++
 7 files changed, 1189 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads7038-core.c
 create mode 100644 drivers/iio/adc/ti-ads7038-regmap.c
 create mode 100644 drivers/iio/adc/ti-ads7038-spi.c
 create mode 100644 drivers/iio/adc/ti-ads7038.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..dace0a03987e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21252,6 +21252,16 @@ T:	git https://github.com/jcmvbkbc/linux-xtensa.git
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
+TEXAS INSTRUMENT'S ADS7038 ADC DRIVER
+M:	Andre Werner <andre.werner@systec-electronic.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
+F:	drivers/iio/adc/ti-ads7038.h
+F:	drivers/iio/adc/ti-ads7038-core.c
+F:	drivers/iio/adc/ti-ads7038-regmap.c
+F:	drivers/iio/adc/ti-ads7038-spi.c
+
 TEXAS INSTRUMENTS ASoC DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 517b3db114b8..b3a2f27ecd69 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1239,6 +1239,28 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS7038
+	tristate "Texas Instruments ADS7038 ADC driver"
+	depends on (I2C || SPI_MASTER)
+	select REGMAP
+	select TI_ADS7038_SPI if (SPI_MASTER)
+	help
+	  Say yes here to build support for TI ADS7038 12BIT ADC.
+
+	  To compile this driver as a module, choose M here: the core module
+	  will be called ti-ads7038 and you will also get ti-ads7038-spi for SPI support.
+
+config TI_ADS7038_SPI
+	tristate
+	depends on TI_ADS7038
+	depends on SPI_MASTER
+	select REGMAP
+	help
+	  Say yes here to build support for TI ADS7038 12BIT ADC (SPI connected).
+
+	  To compile this driver as a module, choose M here: the core module
+	  will be called ti-ads7038 and you will also get ti-ads7038-spi for SPI support.
+
 config TI_ADS7924
 	tristate "Texas Instruments ADS7924 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 2facf979327d..6aa355ab24de 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -111,6 +111,9 @@ obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
+obj-$(CONFIG_TI_ADS7038) += ti-ads7038.o
+ti-ads7038-objs := ti-ads7038-core.o ti-ads7038-regmap.o
+obj-$(CONFIG_TI_ADS7038_SPI) += ti-ads7038-spi.o
 obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
diff --git a/drivers/iio/adc/ti-ads7038-core.c b/drivers/iio/adc/ti-ads7038-core.c
new file mode 100644
index 000000000000..21a84589d99b
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-core.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *	 - ADS7138 with I2C interface (future)
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "linux/regulator/consumer.h"
+
+#include "ti-ads7038.h"
+
+#define ADS7038_V_CHAN(_chan, _addr)				\
+	{							\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = _addr,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.datasheet_name = "AIN"#_chan,				\
+	}
+
+static const struct iio_chan_spec ads7038_channels[] = {
+	ADS7038_V_CHAN(0, AIN0), ADS7038_V_CHAN(1, AIN1),
+	ADS7038_V_CHAN(2, AIN2), ADS7038_V_CHAN(3, AIN3),
+	ADS7038_V_CHAN(4, AIN4), ADS7038_V_CHAN(5, AIN5),
+	ADS7038_V_CHAN(6, AIN6), ADS7038_V_CHAN(7, AIN7),
+};
+
+int ads7038_read_raw(struct iio_dev *indio_dev,
+		     struct iio_chan_spec const *chan,
+		     int *val, int *val2,
+		     long mask)
+{
+	unsigned int ret;
+	struct ads7038_ch_meas_result tmp_val;
+	struct ads7038_data *const data = (struct ads7038_data *)iio_priv(indio_dev);
+	struct ads7038_info *const info = (struct ads7038_info *)data->info;
+
+	ret = info->read_channel(indio_dev, chan->channel, &tmp_val);
+
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Read channel returned with error %d", ret);
+		return ret;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = tmp_val.raw;
+
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(data->reg);
+		if (ret < 0)
+			break;
+
+		*val = ret / 1000;	/* uV -> mV */
+		*val2 = (1 << chan->scan_type.realbits) - 1;
+
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info ads7038_iio_info = {
+	.read_raw = ads7038_read_raw,
+};
+
+int ads7038_common_probe(struct device *parent, const struct ads7038_info *info,
+			 struct regmap *const regmap,
+			 struct regulator *const ref_voltage_reg,
+			 const char *name, int irq)
+{
+	struct ads7038_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(parent, sizeof(struct ads7038_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->name = name;
+	indio_dev->channels = ads7038_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads7038_channels);
+	indio_dev->info = &ads7038_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data = (struct ads7038_data *)iio_priv(indio_dev);
+	mutex_init(&data->lock);
+	data->dev = parent;
+	data->info = info;
+	data->regmap = regmap;
+	data->reg = ref_voltage_reg;
+
+	/* Link general device driver with IIO device driver data */
+	dev_set_drvdata(parent, indio_dev);
+
+	iio_device_register(indio_dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(ads7038_common_probe);
+
+int ads7038_common_remove(struct device *parent)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)dev_get_drvdata(parent);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(ads7038_common_remove);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7038 and ADS7138 core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038-regmap.c b/drivers/iio/adc/ti-ads7038-regmap.c
new file mode 100644
index 000000000000..d10ca3122681
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-regmap.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *	 - ADS7138 with I2C interface (future)
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "ti-ads7038.h"
+
+static const struct regmap_range ads7038_noaccess_ranges[] = {
+	regmap_reg_range(0x06, 0x06), regmap_reg_range(0x08, 0x08),
+	regmap_reg_range(0x0A, 0x0A), regmap_reg_range(0x0C, 0x0C),
+	regmap_reg_range(0x0E, 0x0F), regmap_reg_range(0x15, 0x15),
+	regmap_reg_range(0x19, 0x19), regmap_reg_range(0x1B, 0x1B),
+	regmap_reg_range(0x1D, 0x1D), regmap_reg_range(0x1F, 0x1F),
+	regmap_reg_range(0x40, 0x5F), regmap_reg_range(0x70, 0x7F),
+	regmap_reg_range(0xB0, 0xC2), regmap_reg_range(0xC4, 0xC4),
+	regmap_reg_range(0xC6, 0xC6), regmap_reg_range(0xC8, 0xC8),
+	regmap_reg_range(0xCA, 0xCA), regmap_reg_range(0xCC, 0xCC),
+	regmap_reg_range(0xCE, 0xCE), regmap_reg_range(0xD0, 0xD0),
+	regmap_reg_range(0xD2, 0xE8), regmap_reg_range(0xEA, 0xEA),
+};
+
+static const struct regmap_range ads7038_readable_ranges[] = {
+	regmap_reg_range(0x00, 0x00),	/*This is a dummy entry to provide a valid access pointer */
+};
+
+static const struct regmap_access_table ads7038_readable_table = {
+	.yes_ranges = ads7038_readable_ranges,
+	.n_yes_ranges = 0,	/* regmap.c: In case zero "yes ranges" are supplied, any reg is OK */
+	.no_ranges = ads7038_noaccess_ranges,
+	.n_no_ranges = ARRAY_SIZE(ads7038_noaccess_ranges),
+};
+
+static const struct regmap_range ads7038_volatile_ranges[] = {
+	regmap_reg_range(ADS7038_SYSTEM_STATUS_REG, ADS7038_SYSTEM_STATUS_REG),
+	regmap_reg_range(ADS7038_GPI_VALUE_REG, ADS7038_GPI_VALUE_REG),
+	regmap_reg_range(ADS7038_EVENT_FLAG_REG, ADS7038_EVENT_FLAG_REG),
+	regmap_reg_range(ADS7038_MAX_CH0_LSB_REG, ADS7038_MAX_CH7_MSB_REG),
+	regmap_reg_range(ADS7038_MIN_CH0_LSB_REG, ADS7038_MIN_CH7_MSB_REG),
+	regmap_reg_range(ADS7038_RECENT_CH0_LSB_REG,
+			 ADS7038_RECENT_CH7_MSB_REG),
+};
+
+static const struct regmap_access_table ads7038_volatile_table = {
+	.yes_ranges = ads7038_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ads7038_volatile_ranges),
+	.no_ranges = ads7038_noaccess_ranges,
+	.n_no_ranges = ARRAY_SIZE(ads7038_noaccess_ranges),
+};
+
+/* It is okay to include noaccess registers in range, because they have been proven at first. */
+static const struct regmap_range ads7038_writable_range[] = {
+	regmap_reg_range(ADS7038_SYSTEM_STATUS_REG, ADS7038_GPO_VALUE_REG),
+	regmap_reg_range(ADS7038_SEQUENCE_CFG_REG, ADS7038_ALERT_PIN_CFG_REG),
+	regmap_reg_range(ADS7038_EVENT_HIGH_FLAG_REG, ADS7038_LOW_TH_CH7_REG),
+	regmap_reg_range(ADS7038_GPO0_TRIG_EVENT_SEL_REG,
+			 ADS7038_GPO_VALUE_TRIG_REG),
+};
+
+static const struct regmap_access_table ads7038_writable_table = {
+	.yes_ranges = ads7038_writable_range,
+	.n_yes_ranges = ARRAY_SIZE(ads7038_writable_range),
+	.no_ranges = ads7038_noaccess_ranges,
+	.n_no_ranges = ARRAY_SIZE(ads7038_noaccess_ranges),
+};
+
+const struct regmap_config ads7038_regmap_config = {
+	.name = "ads7038",
+	.reg_bits = ADS7038_REGISTER_SIZE,
+	.val_bits = ADS7038_REGISTER_SIZE,
+
+	.wr_table = &ads7038_writable_table,
+	.rd_table = &ads7038_readable_table,
+	.volatile_table = &ads7038_volatile_table,
+
+	.max_register = ADS7038_REG_ADDRESS_MAX,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL(ads7038_regmap_config);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7038 SPI bus driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038-spi.c b/drivers/iio/adc/ti-ads7038-spi.c
new file mode 100644
index 000000000000..e26884afb9c6
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-spi.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "ti-ads7038.h"
+
+#define ADS7038_OPCODE_NOOP		0x00
+#define ADS7038_OPCODE_REGREAD		0x10
+#define ADS7038_OPCODE_REGWRITE		0x08
+#define ADS7038_OPCODE_SETBIT		0x18
+#define ADS7038_OPCODE_CLEATBIT		0x20
+
+/*
+ * The bitwidth for ADC channel results differ
+ * by setting average and status
+ * in the dedicated configuration registers.
+ */
+#define ADS7038_NO_AVG_NO_STAT		12	/* bits */
+#define ADS7038_NO_AVG_STAT		16	/* bits */
+#define ADS7038_AVG_NO_STAT		16	/* bits */
+#define ADS7038_AVG_STAT		20	/* bits */
+
+#define ADS7038_SPI_FRAME_SIZE_REG		3	/* bytes */
+#define ADS7038_SPI_FRAME_SIZE_CHAN_MAX		2	/* elements */
+
+static int ads7038_regmap_spi_read(void *context, unsigned int reg,
+				   unsigned int *val)
+{
+	struct device *const dev = (struct device *)context;
+	struct spi_device *const spi = to_spi_device(dev);
+	int ret;
+	const u8 tx_buf[ADS7038_SPI_FRAME_SIZE_REG] = {
+		[0] = ADS7038_OPCODE_REGREAD,
+		[1] = (u8)(reg & GENMASK(7, 0)),
+		[2] = 0,	/* dummy data */
+	};
+	u8 rx_buf[ADS7038_SPI_FRAME_SIZE_REG] = { 0 };
+
+	/* Data contains 8bit address and 8bit register data */
+	struct spi_transfer xfer[] = {
+		{
+		 .tx_buf = tx_buf,
+		 .rx_buf = NULL,
+		 .len = ADS7038_SPI_FRAME_SIZE_REG,
+		 .bits_per_word = ADS7038_REGISTER_SIZE,
+		 .cs_change = 1,
+		  },
+		{
+		 .tx_buf = NULL,
+		 .rx_buf = rx_buf,
+		 .len = ADS7038_SPI_FRAME_SIZE_REG,
+		 .bits_per_word = ADS7038_REGISTER_SIZE,
+		  },
+	};
+
+	if (!val)
+		return -EINVAL;
+
+	ret = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+
+	if (ret != 0)
+		return ret;
+
+	*val = (unsigned int)rx_buf[0];
+
+	return ret;
+}
+
+static int ads7038_regmap_spi_write(void *context, unsigned int reg,
+				    unsigned int val)
+{
+	unsigned int ret;
+	unsigned int regval;
+	struct device *const dev = (struct device *)context;
+	struct spi_device *const spi = to_spi_device(dev);
+	struct iio_dev *const indio_dev =
+	    (struct iio_dev *)dev_get_drvdata(dev);
+	struct ads7038_data *const data =
+	    (struct ads7038_data *)iio_priv(indio_dev);
+	const u8 buf[ADS7038_SPI_FRAME_SIZE_REG] = {
+		[0] = ADS7038_OPCODE_REGWRITE,
+		[1] = (u8)(reg & GENMASK(7, 0)),
+		[2] = (u8)(val & GENMASK(7, 0)),
+	};
+
+	struct spi_transfer xfer[] = {
+		{.tx_buf = buf,
+		 .rx_buf = NULL,
+		 .len = ARRAY_SIZE(buf) },
+	};
+
+	ret = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+
+	if (ret != 0)
+		goto error;
+
+	/* If status or avaraging is used, the length for the spi output frame changes. */
+	if (reg == ADS7038_DATA_CFG_REG || reg == ADS7038_OSR_CFG_REG) {
+		ret = ads7038_regmap_spi_read(context, ADS7038_DATA_CFG_REG, &regval);
+		if (ret != 0)
+			goto error;
+
+		data->faverage = (regval & ADS7038_DATA_CFG_APPEND_STATUS) ? 1 : 0;
+
+		ret = ads7038_regmap_spi_read(context, ADS7038_OSR_CFG_REG, &regval);
+		if (ret != 0)
+			goto error;
+
+		data->fstatus = (regval & ADS7038_OSR_CFG_OSR) ? 1 : 0;
+	}
+
+error:
+	return ret;
+}
+
+static int ads7038_read_reg(struct device *dev, const unsigned int reg,
+			    unsigned int *val)
+{
+	int ret;
+	struct iio_dev *const indio_dev = (struct iio_dev *)dev_get_drvdata(dev);
+	struct ads7038_data *const data = (struct ads7038_data *)iio_priv(indio_dev);
+	struct regmap *const map = data->regmap;
+
+	ret = regmap_read(map, reg, val);
+
+	return ret;
+}
+
+static int ads7038_write_reg(struct device *dev, const unsigned int reg,
+			     unsigned int val)
+{
+	struct iio_dev *const indio_dev = (struct iio_dev *)dev_get_drvdata(dev);
+	struct ads7038_data *const data = (struct ads7038_data *)iio_priv(indio_dev);
+	struct regmap *const map = data->regmap;
+	int ret;
+
+	ret = regmap_write(map, reg, val);
+
+	return ret;
+}
+
+static int ads7038_set_mode_manual(struct spi_device *dev,
+				   struct ads7038_data *const data)
+{
+	int ret;
+	struct regmap *const map = data->regmap;
+	const unsigned int regs[] = { ADS7038_OPMODE_CFG_REG,
+		ADS7038_SEQUENCE_CFG_REG
+	};
+	unsigned int reg_values[2] = { 0 };
+	unsigned int idx;
+
+	/* Registers need to be read first to adapt configuration bits. */
+	for (idx = 0; idx < ARRAY_SIZE(regs); ++idx) {
+		ret = regmap_read(map, regs[idx], &reg_values[idx]);
+		if (ret != 0) {
+			dev_dbg(&dev->dev,
+				"Cannot read value from register %02X.\n",
+				regs[idx]);
+			break;
+		}
+	}
+
+	if (ret != 0)
+		goto out;
+
+	reg_values[0] &= ~ADS7038_OPMODE_CFG_CONV_MODE;
+	reg_values[0] |= ADS7038_OPMODE_CFG_CONV_MODE_MANUAL;
+	reg_values[0] &= ~ADS7038_SEQUENCE_CFG_SEQ_MODE;
+	reg_values[0] |= ADS7038_SEQUENCE_CFG_SEQ_MODE_MANUAL;
+
+	for (idx = 0; idx < ARRAY_SIZE(regs); ++idx) {
+		ret = regmap_write(map, regs[idx], reg_values[idx]);
+		if (ret != 0) {
+			dev_dbg(&dev->dev,
+				"Cannot write value to register %02X.\n",
+				regs[idx]);
+			break;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static int ads7038_read_channel(struct iio_dev *indio_dev,
+				const enum MANUAL_CHID chan,
+				struct ads7038_ch_meas_result *const res)
+{
+	int ret;
+	struct ads7038_data *const data = (struct ads7038_data *)iio_priv(indio_dev);
+	struct spi_device *const spi_dev = to_spi_device(data->dev);
+	enum FUNC_MODE *const current_mode = &data->func_mode;
+	const u8 chan_buf[ADS7038_SPI_FRAME_SIZE_REG] = {
+		[0] = ADS7038_OPCODE_REGWRITE,
+		[1] = ADS7038_CHANNEL_SEL_REG,
+		[2] = chan,
+	};
+	u16 rx_buf[ADS7038_SPI_FRAME_SIZE_CHAN_MAX] = { 0 };
+
+	/*
+	 * Fixup: If the channel not changes between sequential reads, the first
+	 * SPI frame is not necessary. This can be handled separately.
+	 */
+	struct spi_transfer xfer[] = {
+		{
+		 .tx_buf = chan_buf,
+		 .rx_buf = NULL,
+		 .len = ARRAY_SIZE(chan_buf),
+		 .bits_per_word = ADS7038_REGISTER_SIZE,
+		 .tx_nbits = SPI_NBITS_SINGLE,
+		 .cs_change = 1,
+		  },
+		{
+		 .tx_buf = NULL,
+		 .rx_buf = rx_buf,
+		 .len = sizeof(rx_buf),
+		 .tx_nbits = SPI_NBITS_SINGLE,
+		 .cs_change = 1,
+		  },
+		{.tx_buf = NULL,
+		 .rx_buf = rx_buf,
+		 .len = sizeof(rx_buf),
+		 .tx_nbits = SPI_NBITS_SINGLE },
+	};
+
+	if (chan > AIN_MAX)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+
+	/* Configure read manual mode for single read of channel value */
+	if (*current_mode != MAN) {
+		dev_dbg(&spi_dev->dev, "Set manual mode for reading data.\n");
+		ret = ads7038_set_mode_manual(spi_dev, data);
+		if (ret != 0)
+			goto out;
+
+		*current_mode = MAN;
+	}
+
+	ret = spi_sync_transfer(spi_dev, xfer, ARRAY_SIZE(xfer));
+
+	if (ret != 0)
+		goto out;
+
+	if (!!data->faverage) {
+		res->raw = be16_to_cpup((__be16 *)&rx_buf[0]);
+		res->faverage = 1;
+		if (!!data->fstatus) {
+			res->status = (be16_to_cpup((__be16 *)&rx_buf[1]) & GENMASK(15, 11)) >> 11;
+			res->fstatus = 1;
+		}
+	} else {
+		res->raw = be16_to_cpup((__be16 *)&rx_buf[0]);
+		res->raw >>= 4;
+		if (!!data->fstatus) {
+			res->status = (be16_to_cpup((__be16 *)&rx_buf[0]) & GENMASK(3, 0));
+			res->fstatus = 1;
+		}
+	}
+
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static struct regmap_bus ads7038_regmap_bus = {
+	.reg_write = ads7038_regmap_spi_write,
+	.reg_read = ads7038_regmap_spi_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static const struct ads7038_info ads7038_info = {
+	.read_reg = ads7038_read_reg,
+	.write_reg = ads7038_write_reg,
+	.read_channel = ads7038_read_channel,
+};
+
+static int ads7038_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+	const struct regmap_config *regmap_config = &ads7038_regmap_config;
+	int ret;
+	struct regulator *reg;
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_dbg(&spi->dev, "Spi_setup failed!\n");
+		goto error_spi;
+	}
+
+	regmap = devm_regmap_init(&spi->dev, &ads7038_regmap_bus, &spi->dev,
+				  regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_dbg(&spi->dev, "Failed to allocate register map\n");
+		ret = PTR_ERR(regmap);
+		goto error_spi;
+	}
+
+	reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(reg)) {
+		dev_dbg(&spi->dev, "Failed to get regulator \"vref\"\n");
+		ret = PTR_ERR(reg);
+		goto error_spi;
+	}
+
+	ret = regulator_enable(reg);
+	if (ret) {
+		dev_dbg(&spi->dev, "Failed to enable regulator \"vref\"\n");
+		goto error_spi;
+	}
+
+	return ads7038_common_probe(&spi->dev, &ads7038_info, regmap,
+				    reg, id->name, spi->irq);
+
+error_spi:
+	dev_err(&spi->dev, "Probe failed\n");
+	return ret;
+}
+
+static void ads7038_spi_remove(struct spi_device *spi)
+{
+	int ret;
+
+	ret = ads7038_common_remove(&spi->dev);
+	if (ret != 0)
+		dev_err(&spi->dev, "Error while removing general driver\n.");
+}
+
+static const struct of_device_id ads7038_of_spi_match[] = {
+	{.compatible = "ti,ads7038" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ads7038_of_spi_match);
+
+const struct spi_device_id ads7038_spi_id[] = {
+	{.name = "ads7038" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(spi, ads7038_spi_id);
+
+static struct spi_driver ads7038_spi_driver = {
+	.driver = {
+		   .name = "ads7038-spi",
+		   .of_match_table = ads7038_of_spi_match,
+		    },
+	.id_table = ads7038_spi_id,
+	.probe = ads7038_spi_probe,
+	.remove = ads7038_spi_remove,
+};
+
+module_spi_driver(ads7038_spi_driver);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7038 SPI bus driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038.h b/drivers/iio/adc/ti-ads7038.h
new file mode 100644
index 000000000000..7df41425d7d3
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038.h
@@ -0,0 +1,551 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *	 - ADS7138 with I2C interface (future)
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#ifndef IIO_TI_ADS7038_H_
+#define IIO_TI_ADS7038_H_
+
+#define ADS7038_REGISTER_SIZE	8	/* bits */
+
+/* Opcodes for commands */
+#define ADS7038_OP_NOOP		0x00
+#define ADS7038_OP_REG_READ	0x10
+#define ADS7038_OP_REG_WRITE	0x08
+#define ADS7038_OP_SET_BIT	0x18
+#define ADS7038_OP_CLEAR_BIT	0x20
+
+/* ADS7038 System Status Register */
+#define ADS7038_SYSTEM_STATUS_REG		0x00
+#define ADS7038_SYSTEM_STATUS_BOR		BIT(0)
+#define ADS7038_SYSTEM_STATUS_CRC_ERROR_IN	BIT(1)
+#define ADS7038_SYSTEM_STATUS_CRC_ERROR_FUSE	BIT(2)
+#define ADS7038_SYSTEM_STATUS_OSR_DONE		BIT(3)
+#define ADS7038_SYSTEM_STATUS_OSR_SEQ_STATUS	BIT(6)
+
+/* ADS7038 General Configuration Register */
+#define ADS7038_GENERAL_CFG_REG		0x01
+#define ADS7038_GENERAL_CFG_RST		BIT(0)
+#define ADS7038_GENERAL_CFG_CAL		BIT(1)
+#define ADS7038_GENERAL_CFG_CH_RST	BIT(2)
+#define ADS7038_GENERAL_CFG_DWC_EN	BIT(4)
+#define ADS7038_GENERAL_CFG_STATS_EN	BIT(5)
+#define ADS7038_GENERAL_CFG_CRC_EN	BIT(6)
+
+/* ADS7038 Data Configuration Register */
+#define ADS7038_DATA_CFG_REG			0x02
+#define ADS7038_DATA_CFG_CPOL_CPHA		GENMASK(1, 0)
+#define ADS7038_DATA_CFG_CPOL_CPHA_SPI00	0x00	/* solely ADS7038 */
+#define ADS7038_DATA_CFG_CPOL_CPHA_SPI01	0x01	/* solely ADS7038 */
+#define ADS7038_DATA_CFG_CPOL_CPHA_SPI10	0x02	/* solely ADS7038 */
+#define ADS7038_DATA_CFG_CPOL_CPHA_SPI11	0x03	/* solely ADS7038 */
+#define ADS7038_DATA_CFG_APPEND_STATUS		GENMASK(5, 4)
+#define ADS7038_DATA_CFG_APPEND_STATUS_NO	0x00
+#define ADS7038_DATA_CFG_APPEND_STATUS_CHID	BIT(4)
+#define ADS7038_DATA_CFG_APPEND_STATUS_STATUS	BIT(5)
+#define ADS7038_DATA_CFG_FIX_PAT		BIT(7)
+
+/* ADS7038 Oversampling Configuration Register */
+#define ADS7038_OSR_CFG_REG	0x03
+#define ADS7038_OSR_CFG_OSR	GENMASK(2, 0)
+#define ADS7038_OSR_CFG_OSR_NO	0x00
+#define ADS7038_OSR_CFG_OSR_2	0x01
+#define ADS7038_OSR_CFG_OSR_4	0x02
+#define ADS7038_OSR_CFG_OSR_8	0x03
+#define ADS7038_OSR_CFG_OSR_16	0x04
+#define ADS7038_OSR_CFG_OSR_32	0x05
+#define ADS7038_OSR_CFG_OSR_64	0x06
+#define ADS7038_OSR_CFG_OSR_128	0x07
+
+/* ADS7038 Operation Mode Configuration Register */
+#define ADS7038_OPMODE_CFG_REG			0x04
+#define ADS7038_OPMODE_CFG_CLK_DIV		GENMASK(3, 0)
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_1US0	0x00
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_1US5	0x01
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_2US0	0x02
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_3US0	0x03
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_4US0	0x04
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_6US0	0x05
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_8US0	0x06
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_12US0	0x07
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_16US0	0x08
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_24US0	0x09
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_32US0	0x0A
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_48US0	0x0B
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_64US0	0x0C
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_96US0	0x0D
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_128US0	0x0E
+#define ADS7038_OPMODE_CFG_CLK_DIV_FTIME_192US0	0x0F
+#define ADS7038_OPMODE_CFG_OSC_SEL		BIT(4)
+#define ADS7038_OPMODE_CFG_OSC_SEL_HIGHSPEED	0x00
+#define ADS7038_OPMODE_CFG_OSC_SEL_LOWSPEED	0x01
+#define ADS7038_OPMODE_CFG_CONV_MODE		GENMASK(6, 5)
+#define ADS7038_OPMODE_CFG_CONV_MODE_MANUAL	0x00
+#define ADS7038_OPMODE_CFG_CONV_MODE_AUTONOMOUS	BIT(5)
+#define ADS7038_OPMODE_CFG_CONV_ON_ERR		BIT(7)
+#define ADS7038_OPMODE_CFG_CONV_ON_ERR_CONTINUE	0x00
+#define ADS7038_OPMODE_CFG_CONV_ON_ERR_PAUSE	BIT(7)
+
+/* ADS7038 Pin Mode Configuration Register */
+#define ADS7038_PIN_CFG_REG		0x05
+#define ADS7038_PIN_CFG_ALL_AIN		0x00
+#define ADS7038_PIN_CFG_ALL_GPIO	GENMASK(7, 0)
+
+/* ADS7038 GPIO Mode Configuration Register */
+#define ADS7038_GPIO_CFG_REG		0x07
+#define ADS7038_GPIO_CFG_ALL_IN		0x00
+#define ADS7038_GPIO_CFG_ALL_OUT	GENMASK(7, 0)
+
+/* ADS7038 GPO Drive Strengh Configuration Register */
+#define ADS7038_GPO_DRIVE_CFG_REG		0x09
+#define ADS7038_GPO_DRIVE_CFG_ALL_OPEN_DRAIN	0x00
+#define ADS7038_GPO_DRIVE_CFG_ALL_PP		GENMASK(7, 0)
+
+/* ADS7038 GPO Value Register */
+#define ADS7038_GPO_VALUE_REG		0x0B
+#define ADS7038_GPO_VALUE_ALL_LOW	0x00
+#define ADS7038_GPO_VALUE_ALL_HIGH	GENMASK(7, 0)
+
+/* ADS7038 GPI Value Register */
+#define ADS7038_GPI_VALUE_REG		0x0D
+
+/* ADS7038 Sequence Configuration Register */
+#define ADS7038_SEQUENCE_CFG_REG			0x10
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE			GENMASK(1, 0)
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_MANUAL		0x00
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_AUTO_SEQ		0x01
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_ON_THE_FLY	0x02	/* solely ADS7038 */
+#define ADS7038_SEQUENCE_CFG_SEQ_START BIT(4)
+
+/* ADS7038 Channel Selection Register */
+#define ADS7038_CHANNEL_SEL_REG			0x11
+#define ADS7038_CHANNEL_SEL_MCHILDID		GENMASK(3, 0)
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN0	0x00
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN1	0x01
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN2	0x02
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN3	0x03
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN4	0x04
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN5	0x05
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN6	0x06
+#define ADS7038_CHANNEL_SEL_MCHILDID_AIN7	0x07
+
+/* ADS7038 Auto Sequence Channel Selection Register */
+#define ADS7038_AUTO_SEQ_CH_SEL_REG	0x12
+#define ADS7038_AUTO_SEQ_CH_SEL_ALL	GENMASK(7, 0)
+
+/* ADS7038 Alert Channel Selection Register */
+#define ADS7038_ALERT_CH_SEL_REG	0x14
+#define ADS7038_ALERT_CH_SEL_ALL	GENMASK(7, 0)
+
+/* ADS7038 Alert Map Register */
+#define ADS7038_ALERT_MAP_REG		0x16
+#define ADS7038_ALERT_MAP_ALERT_CRCIN	BIT(0)
+
+/* ADS7038 Alert Pin Configuration Register */
+#define ADS7038_ALERT_PIN_CFG_REG			0x17
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC		GENMASK(1, 0)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_ACTIVE_LOW	0x00
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_ACTIVE_HIGH	BIT(0)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_PULSED_LOW	BIT(1)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_PULSED_HIGH	GENMASK(1, 0)
+#define ADS7138_ALERT_PIN_CFG_ALERT_DRIVE		BIT(2)	/* solely ADS7138 */
+#define ADS7038_ALERT_PIN_CFG_ALERT_PIN			0xF0	/* solely ADS7038 */
+
+/* ADS7038 Event Flag Register */
+#define ADS7038_EVENT_FLAG_REG	0x18
+
+/* ADS7038 Event High Flag Register */
+#define ADS7038_EVENT_HIGH_FLAG_REG	0x1A
+
+/* ADS7038 Event Low Flag Register */
+#define ADS7038_EVENT_LOW_FLAG_REG	0x1C
+
+/* ADS7038 Event Region Register */
+#define ADS7038_EVENT_RGN_REG	0x1E
+
+/* ADS7038 HYSTERESIS CH0 Register */
+#define ADS7038_HYSTERESIS_CH0_REG			0x20
+#define ADS7038_HYSTERESIS_CH0_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH0_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH0 Register */
+#define ADS7038_HIGH_TH_CH0_REG		0x21
+
+/* ADS7038 Event Count CH0 Register */
+#define ADS7038_EVENT_CNT_CH0_REG			0x22
+#define ADS7038_EVENT_CNT_CH0_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH0_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH0 Register */
+#define ADS7038_LOW_TH_CH0_REG	0x23
+
+/* ADS7038 HYSTERESIS CH1 Register */
+#define ADS7038_HYSTERESIS_CH1_REG			0x24
+#define ADS7038_HYSTERESIS_CH1_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH1_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH1 Register */
+#define ADS7038_HIGH_TH_CH1_REG	0x25
+
+/* ADS7038 Event Count CH1 Register */
+#define ADS7038_EVENT_CNT_CH1_REG			0x26
+#define ADS7038_EVENT_CNT_CH1_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH1_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH1 Register */
+#define ADS7038_LOW_TH_CH1_REG	0x27
+
+/* ADS7038 HYSTERESIS CH2 Register */
+#define ADS7038_HYSTERESIS_CH2_REG			0x28
+#define ADS7038_HYSTERESIS_CH2_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH2_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH2 Register */
+#define ADS7038_HIGH_TH_CH2_REG				0x29
+
+/* ADS7038 Event Count CH2 Register */
+#define ADS7038_EVENT_CNT_CH2_REG			0x2A
+#define ADS7038_EVENT_CNT_CH2_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH2_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH2 Register */
+#define ADS7038_LOW_TH_CH2_REG	0x2B
+
+/* ADS7038 HYSTERESIS CH3 Register */
+#define ADS7038_HYSTERESIS_CH3_REG			0x2C
+#define ADS7038_HYSTERESIS_CH3_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH3_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH3 Register */
+#define ADS7038_HIGH_TH_CH3_REG				0x2D
+
+/* ADS7038 Event Count CH3 Register */
+#define ADS7038_EVENT_CNT_CH3_REG			0x2E
+#define ADS7038_EVENT_CNT_CH3_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH3_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH3 Register */
+#define ADS7038_LOW_TH_CH3_REG 0x2F
+
+/* ADS7038 HYSTERESIS CH4 Register */
+#define ADS7038_HYSTERESIS_CH4_REG			0x30
+#define ADS7038_HYSTERESIS_CH4_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH4_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH4 Register */
+#define ADS7038_HIGH_TH_CH4_REG				0x31
+
+/* ADS7038 Event Count CH4 Register */
+#define ADS7038_EVENT_CNT_CH4_REG			0x32
+#define ADS7038_EVENT_CNT_CH4_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH4_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH4 Register */
+#define ADS7038_LOW_TH_CH4_REG				0x33
+
+/* ADS7038 HYSTERESIS CH5 Register */
+#define ADS7038_HYSTERESIS_CH5_REG			0x34
+#define ADS7038_HYSTERESIS_CH5_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH5_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH5 Register */
+#define ADS7038_HIGH_TH_CH5_REG				0x35
+
+/* ADS7038 Event Count CH5 Register */
+#define ADS7038_EVENT_CNT_CH5_REG			0x36
+#define ADS7038_EVENT_CNT_CH5_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH5_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH5 Register */
+#define ADS7038_LOW_TH_CH5_REG				0x37
+
+/* ADS7038 HYSTERESIS CH6 Register */
+#define ADS7038_HYSTERESIS_CH6_REG			0x38
+#define ADS7038_HYSTERESIS_CH6_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH6_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH6 Register */
+#define ADS7038_HIGH_TH_CH6_REG 0x39
+
+/* ADS7038 Event Count CH6 Register */
+#define ADS7038_EVENT_CNT_CH6_REG			0x3A
+#define ADS7038_EVENT_CNT_CH6_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH6_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH6 Register */
+#define ADS7038_LOW_TH_CH6_REG				0x3B
+
+/* ADS7038 HYSTERESIS CH7 Register */
+#define ADS7038_HYSTERESIS_CH7_REG			0x3C
+#define ADS7038_HYSTERESIS_CH7_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH7_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH7 Register */
+#define ADS7038_HIGH_TH_CH7_REG				0x3D
+
+/* ADS7038 Event Count CH7 Register */
+#define ADS7038_EVENT_CNT_CH7_REG			0x3E
+#define ADS7038_EVENT_CNT_CH7_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH7_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+/* ADS7038 High Threshold CH7 Register */
+#define ADS7038_LOW_TH_CH7_REG		0x3F
+
+/* ADS7038 MAX CH0 LSB Register */
+#define ADS7038_MAX_CH0_LSB_REG		0x60
+
+/* ADS7038 MAX CH0 MSB Register */
+#define ADS7038_MAX_CH0_MSB_REG		0x61
+
+/* ADS7038 MAX CH1 LSB Register */
+#define ADS7038_MAX_CH1_LSB_REG		0x62
+
+/* ADS7038 MAX CH1 MSB Register */
+#define ADS7038_MAX_CH1_MSB_REG		0x63
+
+/* ADS7038 MAX CH2 LSB Register */
+#define ADS7038_MAX_CH2_LSB_REG		0x64
+
+/* ADS7038 MAX CH2 MSB Register */
+#define ADS7038_MAX_CH2_MSB_REG		0x65
+
+/* ADS7038 MAX CH3 LSB Register */
+#define ADS7038_MAX_CH3_LSB_REG		0x66
+
+/* ADS7038 MAX CH3 MSB Register */
+#define ADS7038_MAX_CH3_MSB_REG		0x67
+
+/* ADS7038 MAX CH4 LSB Register */
+#define ADS7038_MAX_CH4_LSB_REG		0x68
+
+/* ADS7038 MAX CH4 MSB Register */
+#define ADS7038_MAX_CH4_MSB_REG		0x69
+
+/* ADS7038 MAX CH5 LSB Register */
+#define ADS7038_MAX_CH5_LSB_REG		0x6A
+
+/* ADS7038 MAX CH5 MSB Register */
+#define ADS7038_MAX_CH5_MSB_REG		0x6B
+
+/* ADS7038 MAX CH6 LSB Register */
+#define ADS7038_MAX_CH6_LSB_REG		0x6C
+
+/* ADS7038 MAX CH6 MSB Register */
+#define ADS7038_MAX_CH6_MSB_REG		0x6D
+
+/* ADS7038 MAX CH7 LSB Register */
+#define ADS7038_MAX_CH7_LSB_REG		0x6E
+
+/* ADS7038 MAX CH7 MSB Register */
+#define ADS7038_MAX_CH7_MSB_REG		0x6F
+
+/* ADS7038 MIN CH0 LSB Register */
+#define ADS7038_MIN_CH0_LSB_REG		0x80
+
+/* ADS7038 MIN CH0 MSB Register */
+#define ADS7038_MIN_CH0_MSB_REG		0x81
+
+/* ADS7038 MIN CH1 LSB Register */
+#define ADS7038_MIN_CH1_LSB_REG		0x82
+
+/* ADS7038 MIN CH1 MSB Register */
+#define ADS7038_MIN_CH1_MSB_REG		0x83
+
+/* ADS7038 MIN CH2 LSB Register */
+#define ADS7038_MIN_CH2_LSB_REG		0x84
+
+/* ADS7038 MIN CH2 MSB Register */
+#define ADS7038_MIN_CH2_MSB_REG		0x85
+
+/* ADS7038 MIN CH3 LSB Register */
+#define ADS7038_MIN_CH3_LSB_REG		0x86
+
+/* ADS7038 MIN CH3 MSB Register */
+#define ADS7038_MIN_CH3_MSB_REG		0x87
+
+/* ADS7038 MIN CH4 LSB Register */
+#define ADS7038_MIN_CH4_LSB_REG		0x88
+
+/* ADS7038 MIN CH4 MSB Register */
+#define ADS7038_MIN_CH4_MSB_REG		0x89
+
+/* ADS7038 MIN CH5 LSB Register */
+#define ADS7038_MIN_CH5_LSB_REG		0x8A
+
+/* ADS7038 MIN CH5 MSB Register */
+#define ADS7038_MIN_CH5_MSB_REG		0x8B
+
+/* ADS7038 MIN CH6 LSB Register */
+#define ADS7038_MIN_CH6_LSB_REG		0x8C
+
+/* ADS7038 MIN CH6 MSB Register */
+#define ADS7038_MIN_CH6_MSB_REG		0x8D
+
+/* ADS7038 MIN CH7 LSB Register */
+#define ADS7038_MIN_CH7_LSB_REG		0x8E
+
+/* ADS7038 MIN CH7 MSB Register */
+#define ADS7038_MIN_CH7_MSB_REG		0x8F
+
+/* ADS7038 RECENT CH0 LSB Register */
+#define ADS7038_RECENT_CH0_LSB_REG	0xA0
+
+/* ADS7038 RECENT CH0 MSB Register */
+#define ADS7038_RECENT_CH0_MSB_REG	0xA1
+
+/* ADS7038 RECENT CH1 LSB Register */
+#define ADS7038_RECENT_CH1_LSB_REG	0xA2
+
+/* ADS7038 RECENT CH1 MSB Register */
+#define ADS7038_RECENT_CH1_MSB_REG	0xA3
+
+/* ADS7038 RECENT CH2 LSB Register */
+#define ADS7038_RECENT_CH2_LSB_REG	0xA4
+
+/* ADS7038 RECENT CH2 MSB Register */
+#define ADS7038_RECENT_CH2_MSB_REG	0xA5
+
+/* ADS7038 RECENT CH3 LSB Register */
+#define ADS7038_RECENT_CH3_LSB_REG	0xA6
+
+/* ADS7038 RECENT CH3 MSB Register */
+#define ADS7038_RECENT_CH3_MSB_REG	0xA7
+
+/* ADS7038 RECENT CH4 LSB Register */
+#define ADS7038_RECENT_CH4_LSB_REG	0xA8
+
+/* ADS7038 RECENT CH4 MSB Register */
+#define ADS7038_RECENT_CH4_MSB_REG	0xA9
+
+/* ADS7038 RECENT CH5 LSB Register */
+#define ADS7038_RECENT_CH5_LSB_REG	0xAA
+
+/* ADS7038 RECENT CH5 MSB Register */
+#define ADS7038_RECENT_CH5_MSB_REG	0xAB
+
+/* ADS7038 RECENT CH6 LSB Register */
+#define ADS7038_RECENT_CH6_LSB_REG	0xAC
+
+/* ADS7038 RECENT CH6 MSB Register */
+#define ADS7038_RECENT_CH6_MSB_REG	0xAD
+
+/* ADS7038 RECENT CH7 LSB Register */
+#define ADS7038_RECENT_CH7_LSB_REG	0xAE
+
+/* ADS7038 RECENT CH7 MSB Register */
+#define ADS7038_RECENT_CH7_MSB_REG	0xAF
+
+/* ADS7038 GPO0 Trigger Event Selection Register */
+#define ADS7038_GPO0_TRIG_EVENT_SEL_REG		0xC3
+
+/* ADS7038 GPO1 Trigger Event Selection Register */
+#define ADS7038_GPO1_TRIG_EVENT_SEL_REG		0xC5
+
+/* ADS7038 GPO2 Trigger Event Selection Register */
+#define ADS7038_GPO2_TRIG_EVENT_SEL_REG		0xC7
+
+/* ADS7038 GPO3 Trigger Event Selection Register */
+#define ADS7038_GPO3_TRIG_EVENT_SEL_REG		0xC9
+
+/* ADS7038 GPO4 Trigger Event Selection Register */
+#define ADS7038_GPO4_TRIG_EVENT_SEL_REG		0xCB
+
+/* ADS7038 GPO5 Trigger Event Selection Register */
+#define ADS7038_GPO5_TRIG_EVENT_SEL_REG		0xCD
+
+/* ADS7038 GPO6 Trigger Event Selection Register */
+#define ADS7038_GPO6_TRIG_EVENT_SEL_REG		0xCF
+
+/* ADS7038 GPO7 Trigger Event Selection Register */
+#define ADS7038_GPO7_TRIG_EVENT_SEL_REG		0xD1
+
+/* ADS7038 GPO Trigger Configuration Register */
+#define ADS7038_GPO_TRIG_CFG_REG		0xE9
+
+/* ADS7038 GPO Value Trigger Register */
+#define ADS7038_GPO_VALUE_TRIG_REG	0xEB
+
+/* ADS7038 Register Address Max */
+#define ADS7038_REG_ADDRESS_MAX		0xEB
+
+/* Channel IDs to use for manual mode */
+enum MANUAL_CHID {
+	AIN0 = ADS7038_CHANNEL_SEL_MCHILDID_AIN0,
+	AIN1 = ADS7038_CHANNEL_SEL_MCHILDID_AIN1,
+	AIN2 = ADS7038_CHANNEL_SEL_MCHILDID_AIN2,
+	AIN3 = ADS7038_CHANNEL_SEL_MCHILDID_AIN3,
+	AIN4 = ADS7038_CHANNEL_SEL_MCHILDID_AIN4,
+	AIN5 = ADS7038_CHANNEL_SEL_MCHILDID_AIN5,
+	AIN6 = ADS7038_CHANNEL_SEL_MCHILDID_AIN6,
+	AIN7 = ADS7038_CHANNEL_SEL_MCHILDID_AIN7,
+	AIN_MAX,
+};
+
+/* Functional Modes */
+enum FUNC_MODE {
+	MAN = 0,
+	ON_THE_FLY,
+	AUTO_SEQ,
+	AUTO,
+};
+
+struct ads7038_ch_meas_result {
+	unsigned int raw;
+	unsigned int status;
+	u8 faverage;		/* Flag indicates average result */
+	u8 fstatus;		/* Flag indicated if status is appended */
+};
+
+struct device;
+struct iio_dev;
+struct regmap;
+struct regulator;
+
+/* Functions to address registers and */
+struct ads7038_info {
+	/* Address configuration registers of IC */
+	int (*read_reg)(struct device *dev, const unsigned int reg,
+			unsigned int *val);
+	int (*write_reg)(struct device *dev, const unsigned int reg,
+			 unsigned int val);
+	/* Perform a single read of a channel */
+	int (*read_channel)(struct iio_dev *indio_dev,
+			    const enum MANUAL_CHID chan,
+			    struct ads7038_ch_meas_result *const res);
+};
+
+struct ads7038_data {
+	struct device *dev;
+	const struct ads7038_info *info;
+	struct regmap *regmap;
+
+	enum FUNC_MODE func_mode;	/* actual measure mode */
+	u8 faverage;		/* flag indicates averaging enabled */
+	u8 fstatus;		/* flag indicates status appended */
+
+	struct mutex lock;	/* Mutex for single communication resource */
+
+	struct regulator *reg;	/* Regulator that controls ADC reference voltage */
+};
+
+/* Regmap configurations */
+extern const struct regmap_config ads7038_regmap_config;
+
+/* Probe called from different transports */
+int ads7038_common_probe(struct device *parent, const struct ads7038_info *info,
+			 struct regmap *const regmap,
+			 struct regulator *const ref_voltage_reg,
+			 const char *name, const int irq);
+
+int ads7038_common_remove(struct device *parent);
+
+#endif
-- 
2.42.0

