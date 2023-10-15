Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686777C9ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjJOSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjJOSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:45:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B498AB7;
        Sun, 15 Oct 2023 11:45:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9becde9ea7bso240174566b.0;
        Sun, 15 Oct 2023 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697395530; x=1698000330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ6GvkOmgKCdV4l0X9jVSOV9mK5bdKyZoEMslYH3KYo=;
        b=iE8nnkuG1c9rhnuii2QQ8f9fEMipcuFaxy1b9eo0eQk7Z1/Y01heDCuVE39GUTFmAu
         6Tx8iB31RU3eeuzwalRFez6YJWJgWStwvN5sgK7DYoIM4vauX1flmC4Mw0UEwlSn29fM
         FzkR6Ij8LDdffyTnkjTyn2wCZXrxp6ZkVsrZM7u7RLMKTKSCV16XH3Zwd8RIGSgf6jAV
         6/p0/DnTTtPmS0nH/7kGekp1c2TagkewkN1pmaAJ/sduRMxJHY5j+ZQZn1HM8Q8j89mr
         HIlQ2VQj02I8EcU5k2a2Kem+XOHIIkmhT3zRQtOvq/+zUR+uDzrK20DRSKPhlb1OzXgi
         e4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697395530; x=1698000330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ6GvkOmgKCdV4l0X9jVSOV9mK5bdKyZoEMslYH3KYo=;
        b=fatHTgy77sFyEVBY9D1oqVSpwpJMfrav3XRIMA3XO9QaAZxAe94QZNGS99KfHy1MMG
         o/HtAeMSUBuwNG6YQwuomjw+G2tAdWkaJpWNxRpTOLWDg5ILIa+CsR25zjpAWJImBnY1
         V2FDBirRKc4YcMz2lHJ2a8aEt5OspchoOS9Sgs5yepGaPUQzoh4mJityqq4841UZSZH3
         KDBHnZTPPcvKcP5VHEfTe2X4KBOn6yTOO8uwShj7dQjUYPqye0bVeaju02hirhP7A43H
         LzXwnB8UwkP6rcx82sZrxWOTh2UmvAOCx+tHqgkcEWpVx94AUsd/J4S78edFtrs15geV
         OO5A==
X-Gm-Message-State: AOJu0Yz+CsiO8HN1DS7qQLV/CQcFgD2kRpR3oTGPiMV7OqmzJUKyeRIS
        uXI40At/qS6zVvtlcpbWti8=
X-Google-Smtp-Source: AGHT+IFpcv9ahUxefeICrBf6DWkc7zF2LF/MZX1sId7VEotQCqG0OzTA9w7sHD23AN+XTjjYO7LljA==
X-Received: by 2002:a17:907:84e:b0:9b2:b37d:17ff with SMTP id ww14-20020a170907084e00b009b2b37d17ffmr4822087ejb.19.1697395529965;
        Sun, 15 Oct 2023 11:45:29 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id ga19-20020a170906b85300b0099b76c3041csm2608200ejb.7.2023.10.15.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 11:45:29 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3 2/2] iio: adc: ads7038: Add driver support for 12bit ADC
Date:   Sun, 15 Oct 2023 20:32:21 +0200
Message-ID: <20231015184517.3582-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015184517.3582-1-andre.werner@systec-electronic.com>
References: <20231015184517.3582-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Currently, the driver does support manual measure mode only.

One can trigger an offset calibration using sysfs option for the
provided IIO device. The programmable average filter can be configured
via devicetree option as well as appending status information.
The CRC option is not implemented but configurable.

The GPIO functionality is completely missing.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v3:
- Delete ads7038_info struct for regmap access
- Add new regulator for DVDD voltage
- Shift regulators form SPI device to IIO device
- Add attributes for last channel read, CRC, status and average samples (RO)
- Add option to trigger offset calibration (WO)
- Implement Average Sampling for manual measure mode. That effects the
  measure cycle and for that the time to get the return value.
- Additional code improvements that where recommendet by the reviewer
  such es renaming of defines or variables as well as deleting of
  explicit casts or const pointers.
- Uodate Kconfig so that the ADS7038 SPI device selects the common
  module functions that shall be provided to add the ADS7138 (I2C)
  version easily.

Sadly, the device has no interrupt to show the status of a running
measure cycle. But a full measure cycle with 128 samples takes
approximately 130us. The driver uses a simple delay between
transmissions of an SPI message. An alternative
needs to poll a single bit in the device's status register. In my
opinion that is a bad alternative if the device is not the only on at
the SPI bus.

The functionality is tested with Kernel 5.10 and ported to Linux master.
---
 MAINTAINERS                         |  10 +
 drivers/iio/adc/Kconfig             |  15 +
 drivers/iio/adc/Makefile            |   3 +
 drivers/iio/adc/ti-ads7038-core.c   | 415 ++++++++++++++++++++++++++
 drivers/iio/adc/ti-ads7038-regmap.c |  89 ++++++
 drivers/iio/adc/ti-ads7038-spi.c    | 269 +++++++++++++++++
 drivers/iio/adc/ti-ads7038.h        | 433 ++++++++++++++++++++++++++++
 7 files changed, 1234 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads7038-core.c
 create mode 100644 drivers/iio/adc/ti-ads7038-regmap.c
 create mode 100644 drivers/iio/adc/ti-ads7038-spi.c
 create mode 100644 drivers/iio/adc/ti-ads7038.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..dd0cae0405d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21247,6 +21247,16 @@ T:	git https://github.com/jcmvbkbc/linux-xtensa.git
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
index 517b3db114b8..d5725a87a54c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1239,6 +1239,21 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS7038_COMMON
+	tristate
+	depends on TI_ADS7038_SPI
+
+config TI_ADS7038_SPI
+	tristate "Texas Instruments ADS7038 ADC driver"
+	depends on SPI_MASTER
+	select REGMAP
+	select TI_ADS7038_COMMON
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
index 2facf979327d..3583ceb4c8c8 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -111,6 +111,9 @@ obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
+obj-$(CONFIG_TI_ADS7038_COMMON) += ti-ads7038.o
+ti-ads7038-objs := ti-ads7038-core.o ti-ads7038-regmap.o
+obj-$(CONFIG_TI_ADS7038_SPI) += ti-ads7038-spi.o
 obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
diff --git a/drivers/iio/adc/ti-ads7038-core.c b/drivers/iio/adc/ti-ads7038-core.c
new file mode 100644
index 000000000000..04095e836076
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-core.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/fwnode.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+
+#include "ti-ads7038.h"
+
+#define ADS7038_AVERAGE_OUTPUT_BITS	16
+
+#define ADS7038_V_CHAN(_chan, _addr)				\
+	{							\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
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
+static ssize_t ads7038_crc_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads7038_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%s\n", data->crc_enabled ? "enabled (not implement)" : "disabled");
+}
+
+static ssize_t ads7038_status_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads7038_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "0x%01X\n", data->status_appended ? data->current_status : 0xFF);
+}
+
+static ssize_t ads7038_chanid_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads7038_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", data->latest_chanid);
+}
+
+static ssize_t ads7038_cycletime_show(struct device *dev, struct device_attribute *attr,
+				      char *buf)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads7038_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d us\n", data->measure_cycle_time_us);
+}
+
+static ssize_t ads7038_calibrate_store(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads7038_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int regval, loop_cnt = 10;
+
+	mutex_lock(&data->lock);
+	ret = regmap_read(data->regmap, ADS7038_GENERAL_CFG_REG, &regval);
+	if (ret < 0)
+		goto error;
+
+	regval |= ADS7038_GENERAL_CFG_CAL;
+
+	ret = regmap_write(data->regmap, ADS7038_GENERAL_CFG_REG, regval);
+	if (ret < 0)
+		goto error;
+
+	do {
+		ret = regmap_read(data->regmap, ADS7038_GENERAL_CFG_REG, &regval);
+		if (ret < 0)
+			goto error;
+		--loop_cnt;
+	} while ((regval & ADS7038_GENERAL_CFG_CAL) && (loop_cnt < 0));
+
+	if (loop_cnt)
+		ret = count;
+	else
+		ret = -EIO;
+error:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static DEVICE_ATTR_RO(ads7038_crc);
+static DEVICE_ATTR_RO(ads7038_status);
+static DEVICE_ATTR_RO(ads7038_chanid);
+static DEVICE_ATTR_RO(ads7038_cycletime);
+static DEVICE_ATTR_WO(ads7038_calibrate);
+
+static struct attribute *ads7038_dev_attrs[] = {
+	&dev_attr_ads7038_crc.attr,
+	&dev_attr_ads7038_status.attr,
+	&dev_attr_ads7038_chanid.attr,
+	&dev_attr_ads7038_cycletime.attr,
+	&dev_attr_ads7038_calibrate.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ads7038_dev);
+
+static int ads7038_regulator_config(struct iio_dev *const indio_dev,
+				    struct ads7038_data *const data)
+{
+	struct regulator *reg;
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regulator_register_supply_alias(&indio_dev->dev, "avdd", data->dev, "avdd");
+	if (ret < 0)
+		goto error;
+
+	reg = devm_regulator_get(&indio_dev->dev, "avdd");
+	if (IS_ERR(reg)) {
+		dev_dbg(&indio_dev->dev, "Failed to get regulator \"AVDD\"\n");
+		ret = PTR_ERR(reg);
+		goto error;
+	}
+
+	ret = regulator_enable(reg);
+	if (ret < 0) {
+		dev_dbg(&indio_dev->dev, "Failed to enable regulator \"AVDD\"\n");
+		goto error;
+	}
+
+	data->avdd_reg = reg;
+
+	ret = regulator_register_supply_alias(&indio_dev->dev, "dvdd", data->dev, "dvdd");
+	if (ret < 0)
+		goto error;
+
+	reg = devm_regulator_get(&indio_dev->dev, "dvdd");
+	if (IS_ERR(reg)) {
+		dev_dbg(&indio_dev->dev, "Failed to get regulator \"DVDD\"\n");
+		ret = PTR_ERR(reg);
+		goto error;
+	}
+
+	ret = regulator_enable(reg);
+	if (ret < 0) {
+		dev_dbg(&indio_dev->dev, "Failed to enable regulator \"DVDD\"\n");
+		goto error;
+	}
+
+	data->dvdd_reg = reg;
+
+error:
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static int ads7038_enable_status(struct ads7038_data *const data, const bool enable)
+{
+	int ret;
+	struct regmap *map = data->regmap;
+	unsigned int regval, stat_enable;
+
+	if (enable)
+		stat_enable = ADS7038_DATA_CFG_APPEND_STATUS_STATUS;
+	else
+		stat_enable =  ADS7038_DATA_CFG_APPEND_STATUS_NO;
+
+	mutex_lock(&data->lock);
+	ret = regmap_read(map, ADS7038_DATA_CFG_REG, &regval);
+	if (ret < 0)
+		goto error;
+
+	regval = (ret & ~ADS7038_DATA_CFG_APPEND_STATUS) | stat_enable;
+
+	ret = regmap_write(map, ADS7038_DATA_CFG_REG, regval);
+	if (ret < 0)
+		goto error;
+
+	data->status_appended = enable;
+
+error:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int ads7038_config_average(struct ads7038_data *const data, const u32 ov_ratio)
+{
+	int ret;
+	struct regmap *map = data->regmap;
+	unsigned int regval;
+
+	if (ov_ratio > ADS7038_OSR_CFG_OSR_128)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	ret = regmap_read(map, ADS7038_OSR_CFG_REG, &regval);
+	if (ret < 0)
+		goto error;
+
+	regval = (ret & ~ADS7038_OSR_CFG_OSR) | ov_ratio;
+
+	ret = regmap_write(map, ADS7038_OSR_CFG_REG, regval);
+	if (ret < 0)
+		goto error;
+
+	data->measure_cycle_time_us = (1 << ov_ratio) * ADS7038_CYCLE_TIME_US;
+	if (ov_ratio == ADS7038_OSR_CFG_OSR_NO)
+		data->avaraging_enabled = false;
+	else
+		data->avaraging_enabled = true;
+
+error:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int ads7038_set_mode_manual(struct device const *dev, struct regmap *const map)
+{
+	int ret;
+	const unsigned int regs[] = { ADS7038_OPMODE_CFG_REG,
+		ADS7038_SEQUENCE_CFG_REG
+	};
+	unsigned int reg_values[2] = { 0 };
+	unsigned int idx;
+
+	/* Registers need to be read first to adapt configuration bits. */
+	for (idx = 0; idx < ARRAY_SIZE(regs); ++idx) {
+		ret = regmap_read(map, regs[idx], &reg_values[idx]);
+		if (ret < 0) {
+			dev_dbg(dev,
+				"Cannot read value from register %02X.\n",
+				regs[idx]);
+			break;
+		}
+	}
+
+	if (ret < 0)
+		goto out;
+
+	reg_values[0] &= ~ADS7038_OPMODE_CFG_CONV_MODE;
+	reg_values[0] |= ADS7038_OPMODE_CFG_CONV_MODE_MANUAL;
+	reg_values[0] &= ~ADS7038_SEQUENCE_CFG_SEQ_MODE;
+	reg_values[0] |= ADS7038_SEQUENCE_CFG_SEQ_MODE_MANUAL;
+
+	for (idx = 0; idx < ARRAY_SIZE(regs); ++idx) {
+		ret = regmap_write(map, regs[idx], reg_values[idx]);
+		if (ret < 0) {
+			dev_dbg(dev,
+				"Cannot write value to register %02X.\n",
+				regs[idx]);
+			break;
+		}
+	}
+out:
+	return ret;
+}
+
+static int ads7038_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+		     int *val, int *val2,
+		     long mask)
+{
+	unsigned int ret;
+	struct ads7038_ch_meas_result tmp_val;
+	struct ads7038_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = data->read_channel_raw(indio_dev, chan->channel, &tmp_val);
+
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "Read channel returned with error %d", ret);
+			return ret;
+		}
+
+		*val = tmp_val.raw;
+
+		mutex_lock(&data->lock);
+		if (data->status_appended) {
+			if (tmp_val.status_valid)
+				data->current_status = tmp_val.status;
+			else
+				dev_warn(&indio_dev->dev, "No valid status reported by device.\n");
+		}
+		data->latest_chanid = chan->channel;
+		mutex_unlock(&data->lock);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&data->lock);
+		ret = regulator_get_voltage(data->avdd_reg);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;	/* uV -> mV */
+		if (data->avaraging_enabled)
+			*val2 = 1 << ADS7038_AVERAGE_OUTPUT_BITS;
+		else
+			*val2 = 1 << chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ads7038_iio_info = {
+	.read_raw = ads7038_read_raw,
+};
+
+int ads7038_common_probe(struct device *parent, read_channel_raw_cb read_ch_raw_cb,
+			 struct regmap *const regmap,
+			 const char *name, int irq)
+{
+	struct ads7038_data *data;
+	struct iio_dev *indio_dev;
+	u32 prop_value;
+	int ret;
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
+	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
+	data->dev = parent;
+	data->read_channel_raw = read_ch_raw_cb;
+	data->regmap = regmap;
+
+	ret = ads7038_regulator_config(indio_dev, data);
+	if (ret < 0)
+		return ret;
+
+	ret = ads7038_enable_status(data, device_property_present(parent, "status-enabled"));
+	if (ret < 0) {
+		dev_dbg(&indio_dev->dev,
+			"Error while configuring appending of chip status (ret = %d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(parent, "average-samples", &prop_value);
+	if (ret == 0) {
+		ret = ads7038_config_average(data, prop_value);
+		if (ret < 0) {
+			dev_dbg(&indio_dev->dev,
+				"Error while configuring appending of chip status (ret = %d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	data->crc_enabled = device_property_present(parent, "crc-enabled");
+
+	/* Configure read manual mode for single read of channel value */
+	ret = ads7038_set_mode_manual(&indio_dev->dev, data->regmap);
+	if (ret < 0)
+		return ret;
+
+	data->func_mode = MAN;
+
+	/* Link general device driver with IIO device driver data */
+	dev_set_drvdata(parent, indio_dev);
+
+	devm_iio_device_register(data->dev, indio_dev);
+
+	ret = devm_device_add_groups(&indio_dev->dev, ads7038_dev_groups);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ads7038_common_probe, IIO_ADS7038);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7038 and ADS7138 core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038-regmap.c b/drivers/iio/adc/ti-ads7038-regmap.c
new file mode 100644
index 000000000000..fcc2f0b9d3a9
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-regmap.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* This driver supports TI 12Bit ADC devices
+ *
+ * Register mapping for both ADS7x38 devices (I2C and SPI interface)
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
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
+/* It is okay to include noaccess registers in range, because they have been proven at first. */
+static const struct regmap_range ads7038_readable_ranges[] = {
+	regmap_reg_range(0x00, ADS7038_REG_ADDRESS_MAX),
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
+	regmap_reg_range(ADS7038_SYSTEM_STATUS_REG, ADS7038_GENERAL_CFG_REG),
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
+	.reg_bits = ADS7038_REGISTER_NUM_BITS,
+	.val_bits = ADS7038_REGISTER_NUM_BITS,
+
+	.wr_table = &ads7038_writable_table,
+	.rd_table = &ads7038_readable_table,
+	.volatile_table = &ads7038_volatile_table,
+
+	.max_register = ADS7038_REG_ADDRESS_MAX,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_NS_GPL(ads7038_regmap_config, IIO_ADS7038);
+
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7x38 register mapping");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038-spi.c b/drivers/iio/adc/ti-ads7038-spi.c
new file mode 100644
index 000000000000..163a76001138
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038-spi.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This driver supports TI 12Bit ADC devices
+ *
+ *	 - ADS7038 with SPI interface
+ *
+ * Copyright (C) 2023 SYS TEC electronic AG
+ * Author: Andre Werner <andre.werner@systec-electronic.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
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
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
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
+			.tx_buf = tx_buf,
+			.rx_buf = NULL,
+			.len = ADS7038_SPI_FRAME_SIZE_REG,
+			.bits_per_word = ADS7038_REGISTER_NUM_BITS,
+			.cs_change = 1,
+		},
+		{
+			.tx_buf = NULL,
+			.rx_buf = rx_buf,
+			.len = ADS7038_SPI_FRAME_SIZE_REG,
+			.bits_per_word = ADS7038_REGISTER_NUM_BITS,
+		},
+	};
+
+	if (!val)
+		return -EINVAL;
+
+	ret = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+
+	if (ret < 0)
+		return ret;
+
+	*val = rx_buf[0];
+
+	return 0;
+}
+
+static int ads7038_regmap_spi_write(void *context, unsigned int reg,
+				    unsigned int val)
+{
+	unsigned int ret;
+	struct device *dev = (struct device *)context;
+	struct spi_device *spi = to_spi_device(dev);
+	const u8 buf[ADS7038_SPI_FRAME_SIZE_REG] = {
+		[0] = ADS7038_OPCODE_REGWRITE,
+		[1] = (u8)(reg & GENMASK(7, 0)),
+		[2] = (u8)(val & GENMASK(7, 0)),
+	};
+
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = buf,
+			.rx_buf = NULL,
+			.len = ARRAY_SIZE(buf),
+		},
+	};
+
+	ret = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ads7038_read_channel(struct iio_dev *const indio_dev,
+				const enum MANUAL_CHID chan,
+				struct ads7038_ch_meas_result *const res)
+{
+	int ret;
+	struct ads7038_data *data = iio_priv(indio_dev);
+	struct spi_device *spi_dev = to_spi_device(data->dev);
+	__be16 rx_buf[ADS7038_SPI_FRAME_SIZE_CHAN_MAX] = { 0 };
+
+	const u8 tx_buf[] = {
+		[0] = ADS7038_OPCODE_REGWRITE,
+		[1] = ADS7038_CHANNEL_SEL_REG,
+		[2] = chan
+	};
+
+	/*
+	 * If the channel changes it needs two additional cycles before the result
+	 * is ready to tranmit.
+	 */
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = tx_buf,
+			.rx_buf = NULL,
+			.len = sizeof(tx_buf),
+			.tx_nbits = SPI_NBITS_SINGLE,
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = data->measure_cycle_time_us,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
+		},
+		{
+			.dummy_data = 1,
+			.len = sizeof(tx_buf),
+			.tx_nbits = SPI_NBITS_SINGLE,
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = data->measure_cycle_time_us,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
+		},
+		{
+			.tx_buf = NULL,
+			.rx_buf = rx_buf,
+			.len = sizeof(rx_buf),
+			.tx_nbits = SPI_NBITS_SINGLE,
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = data->measure_cycle_time_us,
+				.unit = SPI_DELAY_UNIT_USECS
+			},
+		},
+		{
+			.dummy_data = 1,
+			.len = sizeof(rx_buf),
+			.tx_nbits = SPI_NBITS_SINGLE,
+		},
+	};
+
+	if (chan > AIN_MAX)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+
+	/* If the channel does not switch we do not need to send that transfers again */
+	if (data->latest_chanid != chan)
+		ret = spi_sync_transfer(spi_dev, xfer, ARRAY_SIZE(xfer));
+	else
+		ret = spi_sync_transfer(spi_dev, &xfer[1], (ARRAY_SIZE(xfer) - 1));
+
+	if (ret < 0)
+		goto out;
+
+	if (data->avaraging_enabled) {
+		res->raw = be16_to_cpu(rx_buf[0]);
+		res->raw_is_an_average = true;
+		if (data->status_appended) {
+			res->status = FIELD_GET(GENMASK(15, 12), (be16_to_cpup(&rx_buf[1])));
+			res->status_valid = true;
+		}
+	} else {
+		res->raw = be16_to_cpu(rx_buf[0]);
+		res->raw >>= 4;
+		if (data->status_appended) {
+			res->status = FIELD_GET(GENMASK(3, 0), (be16_to_cpup(&rx_buf[0])));
+			res->status_valid = true;
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
+static int ads7038_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+	int ret;
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_dbg(&spi->dev, "spi_setup failed!\n");
+		goto error_spi;
+	}
+
+	regmap = devm_regmap_init(&spi->dev, &ads7038_regmap_bus, &spi->dev,
+				  &ads7038_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_dbg(&spi->dev, "Failed to allocate register map\n");
+		ret = PTR_ERR(regmap);
+		goto error_spi;
+	}
+
+	return ads7038_common_probe(&spi->dev, ads7038_read_channel, regmap,
+				    id->name, spi->irq);
+
+error_spi:
+	dev_err(&spi->dev, "Probe failed\n");
+	return ret;
+}
+
+static const struct of_device_id ads7038_of_spi_match[] = {
+	{.compatible = "ti,ads7038" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ads7038_of_spi_match);
+
+const struct spi_device_id ads7038_spi_id[] = {
+	{.name = "ads7038" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, ads7038_spi_id);
+
+static struct spi_driver ads7038_spi_driver = {
+	.driver = {
+		   .name = "ads7038-spi",
+		   .of_match_table = ads7038_of_spi_match,
+	},
+	.id_table = ads7038_spi_id,
+	.probe = ads7038_spi_probe,
+};
+
+module_spi_driver(ads7038_spi_driver);
+
+MODULE_IMPORT_NS(IIO_ADS7038);
+MODULE_AUTHOR("Andre Werner <andre.werner@systec-electronic.com>");
+MODULE_DESCRIPTION("ADS7038 SPI bus driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ti-ads7038.h b/drivers/iio/adc/ti-ads7038.h
new file mode 100644
index 000000000000..898b3cfd4694
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7038.h
@@ -0,0 +1,433 @@
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
+#define ADS7038_REGISTER_NUM_BITS	8
+#define ADS7038_CYCLE_TIME_US		1
+
+/* Opcodes for commands */
+#define ADS7038_OP_NOOP		0x00
+#define ADS7038_OP_REG_READ	0x10
+#define ADS7038_OP_REG_WRITE	0x08
+#define ADS7038_OP_SET_BIT	0x18
+#define ADS7038_OP_CLEAR_BIT	0x20
+
+#define ADS7038_SYSTEM_STATUS_REG		0x00
+#define ADS7038_SYSTEM_STATUS_BOR		BIT(0)
+#define ADS7038_SYSTEM_STATUS_CRC_ERROR_IN	BIT(1)
+#define ADS7038_SYSTEM_STATUS_CRC_ERROR_FUSE	BIT(2)
+#define ADS7038_SYSTEM_STATUS_OSR_DONE		BIT(3)
+#define ADS7038_SYSTEM_STATUS_OSR_SEQ_STATUS	BIT(6)
+
+#define ADS7038_GENERAL_CFG_REG		0x01
+#define ADS7038_GENERAL_CFG_RST		BIT(0)
+#define ADS7038_GENERAL_CFG_CAL		BIT(1)
+#define ADS7038_GENERAL_CFG_CH_RST	BIT(2)
+#define ADS7038_GENERAL_CFG_DWC_EN	BIT(4)
+#define ADS7038_GENERAL_CFG_STATS_EN	BIT(5)
+#define ADS7038_GENERAL_CFG_CRC_EN	BIT(6)
+
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
+#define ADS7038_PIN_CFG_REG		0x05
+#define ADS7038_PIN_CFG_ALL_AIN		0x00
+#define ADS7038_PIN_CFG_ALL_GPIO	GENMASK(7, 0)
+
+#define ADS7038_GPIO_CFG_REG		0x07
+#define ADS7038_GPIO_CFG_ALL_IN		0x00
+#define ADS7038_GPIO_CFG_ALL_OUT	GENMASK(7, 0)
+
+#define ADS7038_GPO_DRIVE_CFG_REG		0x09
+#define ADS7038_GPO_DRIVE_CFG_ALL_OPEN_DRAIN	0x00
+#define ADS7038_GPO_DRIVE_CFG_ALL_PP		GENMASK(7, 0)
+
+#define ADS7038_GPO_VALUE_REG		0x0B
+#define ADS7038_GPO_VALUE_ALL_LOW	0x00
+#define ADS7038_GPO_VALUE_ALL_HIGH	GENMASK(7, 0)
+
+#define ADS7038_GPI_VALUE_REG		0x0D
+
+#define ADS7038_SEQUENCE_CFG_REG			0x10
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE			GENMASK(1, 0)
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_MANUAL		0x00
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_AUTO_SEQ		0x01
+#define ADS7038_SEQUENCE_CFG_SEQ_MODE_ON_THE_FLY	0x02	/* solely ADS7038 */
+#define ADS7038_SEQUENCE_CFG_SEQ_START BIT(4)
+
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
+#define ADS7038_AUTO_SEQ_CH_SEL_REG	0x12
+#define ADS7038_AUTO_SEQ_CH_SEL_ALL	GENMASK(7, 0)
+
+#define ADS7038_ALERT_CH_SEL_REG	0x14
+#define ADS7038_ALERT_CH_SEL_ALL	GENMASK(7, 0)
+
+#define ADS7038_ALERT_MAP_REG		0x16
+#define ADS7038_ALERT_MAP_ALERT_CRCIN	BIT(0)
+
+#define ADS7038_ALERT_PIN_CFG_REG			0x17
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC		GENMASK(1, 0)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_ACTIVE_LOW	0x00
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_ACTIVE_HIGH	BIT(0)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_PULSED_LOW	BIT(1)
+#define ADS7038_ALERT_PIN_CFG_ALERT_LOGIC_PULSED_HIGH	GENMASK(1, 0)
+#define ADS7138_ALERT_PIN_CFG_ALERT_DRIVE		BIT(2)	/* solely ADS7138 */
+#define ADS7038_ALERT_PIN_CFG_ALERT_PIN			0xF0	/* solely ADS7038 */
+
+#define ADS7038_EVENT_FLAG_REG	0x18
+
+#define ADS7038_EVENT_HIGH_FLAG_REG	0x1A
+
+#define ADS7038_EVENT_LOW_FLAG_REG	0x1C
+
+#define ADS7038_EVENT_RGN_REG	0x1E
+
+#define ADS7038_HYSTERESIS_CH0_REG			0x20
+#define ADS7038_HYSTERESIS_CH0_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH0_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH0_REG		0x21
+
+#define ADS7038_EVENT_CNT_CH0_REG			0x22
+#define ADS7038_EVENT_CNT_CH0_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH0_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH0_REG	0x23
+
+#define ADS7038_HYSTERESIS_CH1_REG			0x24
+#define ADS7038_HYSTERESIS_CH1_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH1_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH1_REG	0x25
+
+#define ADS7038_EVENT_CNT_CH1_REG			0x26
+#define ADS7038_EVENT_CNT_CH1_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH1_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH1_REG	0x27
+
+#define ADS7038_HYSTERESIS_CH2_REG			0x28
+#define ADS7038_HYSTERESIS_CH2_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH2_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH2_REG				0x29
+
+#define ADS7038_EVENT_CNT_CH2_REG			0x2A
+#define ADS7038_EVENT_CNT_CH2_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH2_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH2_REG	0x2B
+
+#define ADS7038_HYSTERESIS_CH3_REG			0x2C
+#define ADS7038_HYSTERESIS_CH3_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH3_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH3_REG				0x2D
+
+#define ADS7038_EVENT_CNT_CH3_REG			0x2E
+#define ADS7038_EVENT_CNT_CH3_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH3_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH3_REG 0x2F
+
+#define ADS7038_HYSTERESIS_CH4_REG			0x30
+#define ADS7038_HYSTERESIS_CH4_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH4_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH4_REG				0x31
+
+#define ADS7038_EVENT_CNT_CH4_REG			0x32
+#define ADS7038_EVENT_CNT_CH4_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH4_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH4_REG				0x33
+
+#define ADS7038_HYSTERESIS_CH5_REG			0x34
+#define ADS7038_HYSTERESIS_CH5_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH5_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH5_REG				0x35
+
+#define ADS7038_EVENT_CNT_CH5_REG			0x36
+#define ADS7038_EVENT_CNT_CH5_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH5_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH5_REG				0x37
+
+#define ADS7038_HYSTERESIS_CH6_REG			0x38
+#define ADS7038_HYSTERESIS_CH6_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH6_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH6_REG 0x39
+
+#define ADS7038_EVENT_CNT_CH6_REG			0x3A
+#define ADS7038_EVENT_CNT_CH6_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH6_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH6_REG				0x3B
+
+#define ADS7038_HYSTERESIS_CH7_REG			0x3C
+#define ADS7038_HYSTERESIS_CH7_HYSTERESIS_CH0		GENMASK(3, 0)
+#define ADS7038_HYSTERESIS_CH7_HIGH_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_HIGH_TH_CH7_REG				0x3D
+
+#define ADS7038_EVENT_CNT_CH7_REG			0x3E
+#define ADS7038_EVENT_CNT_CH7_EVENT_CNT_CH0		GENMASK(3, 0)
+#define ADS7038_EVENT_CNT_CH7_LOW_THRESHOLD_CH0_LSB	GENMASK(7, 4)
+
+#define ADS7038_LOW_TH_CH7_REG		0x3F
+
+#define ADS7038_MAX_CH0_LSB_REG		0x60
+
+#define ADS7038_MAX_CH0_MSB_REG		0x61
+
+#define ADS7038_MAX_CH1_LSB_REG		0x62
+
+#define ADS7038_MAX_CH1_MSB_REG		0x63
+
+#define ADS7038_MAX_CH2_LSB_REG		0x64
+
+#define ADS7038_MAX_CH2_MSB_REG		0x65
+
+#define ADS7038_MAX_CH3_LSB_REG		0x66
+
+#define ADS7038_MAX_CH3_MSB_REG		0x67
+
+#define ADS7038_MAX_CH4_LSB_REG		0x68
+
+#define ADS7038_MAX_CH4_MSB_REG		0x69
+
+#define ADS7038_MAX_CH5_LSB_REG		0x6A
+
+#define ADS7038_MAX_CH5_MSB_REG		0x6B
+
+#define ADS7038_MAX_CH6_LSB_REG		0x6C
+
+#define ADS7038_MAX_CH6_MSB_REG		0x6D
+
+#define ADS7038_MAX_CH7_LSB_REG		0x6E
+
+#define ADS7038_MAX_CH7_MSB_REG		0x6F
+
+#define ADS7038_MIN_CH0_LSB_REG		0x80
+
+#define ADS7038_MIN_CH0_MSB_REG		0x81
+
+#define ADS7038_MIN_CH1_LSB_REG		0x82
+
+#define ADS7038_MIN_CH1_MSB_REG		0x83
+
+#define ADS7038_MIN_CH2_LSB_REG		0x84
+
+#define ADS7038_MIN_CH2_MSB_REG		0x85
+
+#define ADS7038_MIN_CH3_LSB_REG		0x86
+
+#define ADS7038_MIN_CH3_MSB_REG		0x87
+
+#define ADS7038_MIN_CH4_LSB_REG		0x88
+
+#define ADS7038_MIN_CH4_MSB_REG		0x89
+
+#define ADS7038_MIN_CH5_LSB_REG		0x8A
+
+#define ADS7038_MIN_CH5_MSB_REG		0x8B
+
+#define ADS7038_MIN_CH6_LSB_REG		0x8C
+
+#define ADS7038_MIN_CH6_MSB_REG		0x8D
+
+#define ADS7038_MIN_CH7_LSB_REG		0x8E
+
+#define ADS7038_MIN_CH7_MSB_REG		0x8F
+
+#define ADS7038_RECENT_CH0_LSB_REG	0xA0
+
+#define ADS7038_RECENT_CH0_MSB_REG	0xA1
+
+#define ADS7038_RECENT_CH1_LSB_REG	0xA2
+
+#define ADS7038_RECENT_CH1_MSB_REG	0xA3
+
+#define ADS7038_RECENT_CH2_LSB_REG	0xA4
+
+#define ADS7038_RECENT_CH2_MSB_REG	0xA5
+
+#define ADS7038_RECENT_CH3_LSB_REG	0xA6
+
+#define ADS7038_RECENT_CH3_MSB_REG	0xA7
+
+#define ADS7038_RECENT_CH4_LSB_REG	0xA8
+
+#define ADS7038_RECENT_CH4_MSB_REG	0xA9
+
+#define ADS7038_RECENT_CH5_LSB_REG	0xAA
+
+#define ADS7038_RECENT_CH5_MSB_REG	0xAB
+
+#define ADS7038_RECENT_CH6_LSB_REG	0xAC
+
+#define ADS7038_RECENT_CH6_MSB_REG	0xAD
+
+#define ADS7038_RECENT_CH7_LSB_REG	0xAE
+
+#define ADS7038_RECENT_CH7_MSB_REG	0xAF
+
+#define ADS7038_GPO0_TRIG_EVENT_SEL_REG		0xC3
+
+#define ADS7038_GPO1_TRIG_EVENT_SEL_REG		0xC5
+
+#define ADS7038_GPO2_TRIG_EVENT_SEL_REG		0xC7
+
+#define ADS7038_GPO3_TRIG_EVENT_SEL_REG		0xC9
+
+#define ADS7038_GPO4_TRIG_EVENT_SEL_REG		0xCB
+
+#define ADS7038_GPO5_TRIG_EVENT_SEL_REG		0xCD
+
+#define ADS7038_GPO6_TRIG_EVENT_SEL_REG		0xCF
+
+#define ADS7038_GPO7_TRIG_EVENT_SEL_REG		0xD1
+
+#define ADS7038_GPO_TRIG_CFG_REG		0xE9
+
+#define ADS7038_GPO_VALUE_TRIG_REG	0xEB
+
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
+	AIN_MAX
+};
+
+/* Functional Measure Modes */
+enum FUNC_MODE {
+	UNKNOWN = 0,
+	MAN,
+	ON_THE_FLY,
+	AUTO_SEQ,
+	AUTO,
+};
+
+struct ads7038_ch_meas_result {
+	unsigned int raw;
+	unsigned int status;
+	bool raw_is_an_average;
+	bool status_valid;
+};
+
+struct device;
+struct iio_dev;
+struct regmap;
+struct regulator;
+
+/* Perform a single read of a channel */
+typedef int (*read_channel_raw_cb)(struct iio_dev *const indio_dev,
+			    const enum MANUAL_CHID chan,
+			    struct ads7038_ch_meas_result *const res);
+
+struct ads7038_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;		/* Mutex for single communication resource */
+	struct regulator *avdd_reg;	/* Regulator that controls ADC reference voltage */
+	struct regulator *dvdd_reg;	/* Regulator digital I/O voltage */
+
+	enum FUNC_MODE func_mode;	/* actual measure mode */
+	bool crc_enabled;
+	bool avaraging_enabled;
+	bool status_appended;
+	u8 current_status;		/* Chip status if enabled */
+	u8 latest_chanid;		/* Latest channel id requested */
+	u16 measure_cycle_time_us;
+
+	read_channel_raw_cb read_channel_raw;
+};
+
+extern const struct regmap_config ads7038_regmap_config;
+
+int ads7038_common_probe(struct device *parent, read_channel_raw_cb read_ch_raw_cb,
+			 struct regmap *const regmap,
+			 const char *name, const int irq);
+
+#endif
-- 
2.42.0

