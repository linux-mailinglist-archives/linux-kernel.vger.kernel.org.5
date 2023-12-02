Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A90801A8F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjLBESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:18:13 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EABD40;
        Fri,  1 Dec 2023 20:18:17 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423ed5fb48eso18920601cf.3;
        Fri, 01 Dec 2023 20:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701490697; x=1702095497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWXKsDYQZOtA/TQTkbglj67WmoBOmNR4pIUbPqNZzKc=;
        b=Pt+pOp9y68+LSs74v6xGdFmtDZy280uBLzqX0MAlRCtdtpFfwpDcggeJHOI+5S27Hj
         WPBJYU2cKJsdzHvZwQuD4GKTTKzgGw2Gy1WGw8XjrkT7/oQXvdo7+DutHC2bV9rY4rkx
         aMSahBdilKPWCmhesjOVO0xIjSC/Lh4Wtyqfd+o2Q8rJ9vqg4Qiq+3wh4+IjAPgJ1fWG
         TvOKqaQBsdOQv5SAI+VNvSJEt6QQ4joWpQWLfARNd5JIdrX7wB3fQxyVIucjIT99rrei
         2YmX5kDQVXdn3dPjB99wZqorHklfzl2RtxMONKOo9LMj+NL5r+FcZqay4RAJRsTKPArt
         5urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701490697; x=1702095497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWXKsDYQZOtA/TQTkbglj67WmoBOmNR4pIUbPqNZzKc=;
        b=oNDvTMGFgYLbUQxwETulRINTAqiP5HqanFcqlr5hYuD0jUGse6fC5d/pHcfHh4oeyM
         eW3LCPCzTSo3FbeR9iSBKXJYZwkcUYdXST31f1jnggCr/xwQJE8vp70cUyldZQ7C6KQp
         ydbKvAB43Cpq6QRcRIBHjhbDNk779yJmeM0RMqNlmcFvIwTzhSV5s5kS19HXHvXwidne
         4UElaxZSGe7thkJ8eY1G2ZS6QePuQ/7HFXQaP0n8vne8pCu1iH9Qn1Zt3TLTMGILDurq
         HkudeP52j21RD/p+rVEn09YXnietbZnmwfKjXL61xiRMnCXvPSG15edQtY/zarDGiyAo
         cm7A==
X-Gm-Message-State: AOJu0Yy4xtUdJuQos99OgvHSjaMZal4tKIVaXzg9WP1NxLaEgR+yy8Zq
        SUpE8DNlLJy1+91Q4CmYKfA=
X-Google-Smtp-Source: AGHT+IFZHwIKuxNyEgPbWKapfh5ArWd+vBt1nw6mMgfqVnCpbnXi0xt+0XhJuEf2+/Hm9xDNgIhUHg==
X-Received: by 2002:ac8:57ce:0:b0:425:4043:7653 with SMTP id w14-20020ac857ce000000b0042540437653mr955731qta.123.1701490696536;
        Fri, 01 Dec 2023 20:18:16 -0800 (PST)
Received: from localhost.localdomain (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id g11-20020ac84dcb000000b0041818df8a0dsm2101485qtw.36.2023.12.01.20.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:18:15 -0800 (PST)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v2 2/2] iio: temperature: Add support for AMS AS6200
Date:   Fri,  1 Dec 2023 23:16:51 -0500
Message-Id: <20231202041651.719963-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202041651.719963-1-alkuor@gmail.com>
References: <20231202041651.719963-1-alkuor@gmail.com>
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

as6200 is a high accuracy temperature sensor of 0.0625C with a range
between -40 to 125 Celsius degrees.

The driver implements the alert trigger event in comparator mode where
consecutive faults are converted into periods, high/low temperature
thresholds require to be above/below the set limit for n seconds for
the alert to be triggered/cleared. The alert is only cleared when the
current temperature is below the low temperature threshold for n seconds.

The driver supports the following:
- show available sampling frequencey
- read/write sampling frequency
- read raw temperature
- read scaling factor
- read/write temperature period that needs to be met for low/high
  temperature thresholds to trigger an alert
- show available temperature period thresholds
- buffer trigger
- temperature alert event trigger

Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v2:
  - Add AS6200 in Kconfig in alphabetical order
  - Add as6200.o in Makefile in alphabetical order
  - Fix spelling Auther -> Author
  - Group iio/*.h
  - Arrange *.h into alpabetical order
  - Prefix defines with AS6200
  - Add mask bits for temperature
  - Remove dev, iio_dev, data from as6200 struct
  - Add a comment for the lock usage
  - Convert as6200_samp_freq into 2d array
  - Fix spaces around curly brackets
  - Remove unneccessry "," after NULL terminated arrays
  - Add an array for consecutive faults conversion from samples to periods
  - Remove custom consecutive faults attribute and use IIO_EV_INFO_PERIOD instead
  - Rename as6200_temp_channels to as6200_channels
  - Remove unneccessry zerod indices from as6200_channels
  - Add available sampling frequency attribute
  - Use regmap_update_bits instead of as6200_modify_config_reg
  - Remove as6200_read_config_reg
  - Retrieve driver priv data using iio_priv
  - Retrieve all temperature readings using the new temp mask
  - Use the scaling factor directly instead of using macro
  - Use mutex guard in the event handler
  - Return IRQ_NONE instead of returning an error in as6200_event_handler
  - Remove lock from the trigger handler and put the data on the stack
  - Add custom attribute to show the avaiable temp periods
  - Add in_tempY_threshold_either_period and in_temp_period_available to iio sysfs
    documentation
  - Use as6200 as the name of iio device
  - Drop as6200_remove and use devm_iio_device_register
  - Populate i2c_set_clientdata with indio_dev
  - grab and enable a regulator in probe
  - Update commit message

 Documentation/ABI/testing/sysfs-bus-iio |   4 +-
 drivers/iio/temperature/Kconfig         |  12 +-
 drivers/iio/temperature/Makefile        |   1 +
 drivers/iio/temperature/as6200.c        | 493 ++++++++++++++++++++++++
 4 files changed, 508 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/temperature/as6200.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 19cde14f3869..cc96e6592377 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1174,6 +1174,7 @@ What:		/sys/.../events/in_voltageY_roc_rising_period
 What:		/sys/.../events/in_voltageY_roc_falling_period
 What:		/sys/.../events/in_tempY_thresh_rising_period
 What:		/sys/.../events/in_tempY_thresh_falling_period
+What:		/sys/.../events/in_tempY_thresh_either_period
 What:		/sys/.../events/in_tempY_roc_rising_period
 What:		/sys/.../events/in_tempY_roc_falling_period
 What:		/sys/.../events/in_accel_x&y&z_mag_falling_period
@@ -2016,11 +2017,12 @@ Description:
 		equal to X micrometers.
 
 What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_temp_period_available
 Date:		November 2019
 KernelVersion:	5.4
 Contact:	linux-iio@vger.kernel.org
 Description:
-		List of valid periods (in seconds) for which the light intensity
+		List of valid periods (in seconds) for which the condition
 		must be above the threshold level before interrupt is asserted.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index ed384f33e0c7..a0ffbc77e623 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -4,6 +4,17 @@
 #
 menu "Temperature sensors"
 
+config AS6200
+       tristate "AS6200 temperature sensor"
+       depends on I2C
+       select REGMAP_I2C
+       help
+         If you say yes here you get support for AS6200
+         temperature sensor chip connected via I2C.
+
+         This driver can also be built as a module.  If so, the module
+         will be called as6200.
+
 config IQS620AT_TEMP
 	tristate "Azoteq IQS620AT temperature sensor"
 	depends on MFD_IQS62X || COMPILE_TEST
@@ -157,5 +168,4 @@ config MAX31865
 
 	  This driver can also be build as a module. If so, the module
 	  will be called max31865.
-
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index dfec8c6d3019..e3d4be6770d2 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #
 
+obj-$(CONFIG_AS6200) += as6200.o
 obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
new file mode 100644
index 000000000000..7fcc785871d8
--- /dev/null
+++ b/drivers/iio/temperature/as6200.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for AMS AS6200 Temperature sensor
+ *
+ * Author: Abdel Alkuor <alkuor@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define AS6200_TVAL_REG		0x0
+#define AS6200_CONFIG_REG	0x1
+#define AS6200_TLOW_REG		0x2
+#define AS6200_THIGH_REG	0x3
+
+#define AS6200_CONFIG_AL	BIT(5)
+#define AS6200_CONFIG_CR	GENMASK(7, 6)
+#define AS6200_CONFIG_SM	BIT(8)
+#define AS6200_CONFIG_IM	BIT(9)
+#define AS6200_CONFIG_POL	BIT(10)
+#define AS6200_CONFIG_CF	GENMASK(12, 11)
+
+#define AS6200_TEMP_MASK	GENMASK(15, 4)
+
+struct as6200 {
+	struct regmap *regmap;
+	struct mutex lock; /* Prevent concurrent temp fault processing */
+};
+
+static const int as6200_samp_freq[4][2] = {
+	{ 0, 250000 },
+	{ 1, 0 },
+	{ 4, 0 },
+	{ 8, 0 }
+};
+
+/* Consective faults converted to period */
+static const int as6200_temp_thresh_periods[4][4][2] = {
+	{ { 4, 0 }, { 8, 0 }, { 16, 0 }, { 24, 0 } },
+	{ { 1, 0 }, { 2, 0 }, { 4, 0 }, { 6, 0 } },
+	{ { 0, 250000 }, { 0, 500000 }, { 1, 0 }, { 2, 0} },
+	{ { 0, 125000 }, { 0, 250000 }, { 0, 500000 }, { 0, 750000 } }
+};
+
+static const struct iio_event_spec as6200_temp_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+	}
+};
+
+static const struct iio_chan_spec as6200_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 4,
+		},
+		.event_spec = as6200_temp_event,
+		.num_event_specs = ARRAY_SIZE(as6200_temp_event),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct regmap_config as6200_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0x7F,
+};
+
+static int as6200_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	struct as6200 *as = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(as->regmap, AS6200_TVAL_REG, &reg);
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, reg), 11);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 62500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(as->regmap, AS6200_CONFIG_REG, &reg);
+		if (ret)
+			return ret;
+
+		reg = FIELD_GET(AS6200_CONFIG_CR, reg);
+		*val = as6200_samp_freq[reg][0];
+		*val2 = as6200_samp_freq[reg][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int as6200_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(as6200_samp_freq) * 2;
+		*vals = (int *)as6200_samp_freq;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int as6200_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct as6200 *as = iio_priv(indio_dev);
+	int cr;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (cr = 0; cr < ARRAY_SIZE(as6200_samp_freq); cr++) {
+			if (val == as6200_samp_freq[cr][0] &&
+			    val2 == as6200_samp_freq[cr][1])
+				break;
+		}
+
+		if (cr == ARRAY_SIZE(as6200_samp_freq))
+			return -EINVAL;
+
+		return regmap_update_bits(as->regmap, AS6200_CONFIG_REG,
+					  AS6200_CONFIG_CR,
+					  FIELD_PREP(AS6200_CONFIG_CR, cr));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int as6200_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct as6200 *as = iio_priv(indio_dev);
+	unsigned int reg;
+	unsigned int tmp;
+	int ret;
+	u8 cf;
+	u8 cr;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		reg = AS6200_TLOW_REG;
+		break;
+	case IIO_EV_DIR_RISING:
+		reg = AS6200_THIGH_REG;
+		break;
+	case IIO_EV_DIR_EITHER:
+		reg = AS6200_CONFIG_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(as->regmap, reg, &tmp);
+	if (ret)
+		return ret;
+
+	if (info == IIO_EV_INFO_VALUE) {
+		*val = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, tmp), 11);
+		ret = IIO_VAL_INT;
+	} else {
+		cf = FIELD_GET(AS6200_CONFIG_CF, tmp);
+		cr = FIELD_GET(AS6200_CONFIG_CR, tmp);
+		*val = as6200_temp_thresh_periods[cr][cf][0];
+		*val2 = as6200_temp_thresh_periods[cr][cf][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return ret;
+}
+
+static int as6200_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct as6200 *as = iio_priv(indio_dev);
+	unsigned int tmp;
+	unsigned int reg;
+	int ret;
+	u8 cr;
+	u8 cf;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		reg = AS6200_TLOW_REG;
+		break;
+	case IIO_EV_DIR_RISING:
+		reg = AS6200_THIGH_REG;
+		break;
+	case IIO_EV_TYPE_THRESH:
+		reg = AS6200_CONFIG_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (info == IIO_EV_INFO_VALUE) {
+		/*
+		 * range without applying the scaling
+		 * factor of 0.06250
+		 */
+		if (val > 2000 || val < -640)
+			return -EINVAL;
+
+		tmp = FIELD_PREP(AS6200_TEMP_MASK, val);
+	} else {
+		ret = regmap_read(as->regmap, reg, &tmp);
+		if (ret)
+			return ret;
+
+		cr = FIELD_GET(AS6200_CONFIG_CR, tmp);
+
+		for (cf = 0; cf < ARRAY_SIZE(as6200_temp_thresh_periods); cf++) {
+			if (val == as6200_temp_thresh_periods[cr][cf][0] &&
+			    val2 == as6200_temp_thresh_periods[cr][cf][1])
+				break;
+		}
+
+		if (cf == ARRAY_SIZE(as6200_temp_thresh_periods))
+			return -EINVAL;
+
+		tmp &= ~AS6200_CONFIG_CF;
+		tmp |= FIELD_PREP(AS6200_CONFIG_CF, cf);
+	}
+
+	return regmap_write(as->regmap, reg, tmp);
+}
+
+static irqreturn_t as6200_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct as6200 *as = iio_priv(indio_dev);
+	unsigned int alert;
+	enum iio_event_direction dir;
+	int ret;
+
+	guard(mutex)(&as->lock);
+
+	ret = regmap_read(as->regmap, AS6200_CONFIG_REG, &alert);
+	if (ret)
+		return IRQ_NONE;
+
+	alert = FIELD_GET(AS6200_CONFIG_AL, alert);
+
+	dir = alert ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+
+	iio_push_event(indio_dev,
+		       IIO_EVENT_CODE(IIO_TEMP, 0, 0,
+				      dir,
+				      IIO_EV_TYPE_THRESH,
+				      0, 0, 0),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t as6200_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct as6200 *as = iio_priv(indio_dev);
+	int ret;
+	u8 data[16];
+
+	ret = regmap_read(as->regmap, AS6200_TVAL_REG, (unsigned int *)data);
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, data,
+						   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t
+in_temp_period_available_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct as6200 *as = iio_priv(indio_dev);
+	int len = 0;
+	unsigned int cr;
+	u8 cf;
+	int ret;
+
+	ret = regmap_read(as->regmap, AS6200_CONFIG_REG, &cr);
+	if (ret)
+		return ret;
+
+	cr = FIELD_GET(AS6200_CONFIG_CR, cr);
+
+	for (cf = 0; cf < ARRAY_SIZE(as6200_temp_thresh_periods); cf++)
+		len += sprintf(buf + len, "%d.%06d ",
+			       as6200_temp_thresh_periods[cr][cf][0],
+			       as6200_temp_thresh_periods[cr][cf][1]);
+
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RO(in_temp_period_available, 0);
+
+static struct attribute *as6200_event_attributes[] = {
+	&iio_dev_attr_in_temp_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group as6200_event_attribute_group = {
+	.attrs = as6200_event_attributes,
+};
+
+static const struct iio_info as6200_temp_info = {
+	.event_attrs = &as6200_event_attribute_group,
+	.read_raw = &as6200_read_raw,
+	.read_avail = &as6200_read_avail,
+	.write_raw = &as6200_write_raw,
+	.read_event_value = &as6200_read_event_value,
+	.write_event_value = &as6200_write_event_value,
+};
+
+static int as6200_probe(struct i2c_client *client)
+{
+	struct as6200 *as;
+	struct iio_dev *indio_dev;
+	int ret;
+	struct device *dev = &client->dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*as));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	as = iio_priv(indio_dev);
+
+	as->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
+	if (IS_ERR(as->regmap))
+		return PTR_ERR(as->regmap);
+
+	mutex_init(&as->lock);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = as6200_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as6200_channels);
+	indio_dev->name = "as6200";
+	indio_dev->info = &as6200_temp_info;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      NULL,
+					      as6200_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev,
+						client->irq,
+						NULL,
+						&as6200_event_handler,
+						IRQF_ONESHOT,
+						client->name,
+						indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not get and enable regulator %d\n",
+				     ret);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int __maybe_unused as6200_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct as6200 *as = iio_priv(i2c_get_clientdata(client));
+
+	if (client->irq)
+		disable_irq(client->irq);
+
+	return regmap_update_bits(as->regmap, AS6200_CONFIG_REG,
+				  AS6200_CONFIG_SM, AS6200_CONFIG_SM);
+}
+
+static int __maybe_unused as6200_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct as6200 *as = iio_priv(i2c_get_clientdata(client));
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return regmap_update_bits(as->regmap, AS6200_CONFIG_REG,
+				  AS6200_CONFIG_SM, 0);
+}
+
+static const struct dev_pm_ops as6200_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(as6200_suspend, as6200_resume)
+};
+
+static const struct i2c_device_id as6200_id_table[] = {
+	{ "as6200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as6200_id_table);
+
+static const struct of_device_id as6200_of_match[] = {
+	{ .compatible = "ams,as6200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, as6200_of_match);
+
+static struct i2c_driver as6200_driver = {
+	.driver = {
+		.name = "as6200",
+		.pm = pm_sleep_ptr(&as6200_pm_ops),
+		.of_match_table = as6200_of_match,
+	},
+	.probe = as6200_probe,
+	.id_table = as6200_id_table,
+};
+module_i2c_driver(as6200_driver);
+
+MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com");
+MODULE_DESCRIPTION("AMS AS6200 Temperature Sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1

