Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E547AFE62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjI0I2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjI0I2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:28:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621AE5;
        Wed, 27 Sep 2023 01:28:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50433d8385cso16304049e87.0;
        Wed, 27 Sep 2023 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803299; x=1696408099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wW//0hg2ZBcL2pbV43SXPkrbW8KNU1L75iBZdBWNo5Y=;
        b=ET/XODNKNe42oxDIcsIBAZWfjFgbW+DDSLg7PBAW+SpdfJsyr2cGUZRnjPQ8OmuCbM
         dTjFkNWwcc2zDIgcgAkSbEyV+o9wQ511iV7iSxv6PAUInxRwanxstdgprAZS4r0jrDFz
         FriSUflsgh2c41t6tNqz2S6khu55L58p/aBQMP3FEW6oS6gMlU+1QsN+nzOlaaMrYIfe
         4qFRyQ+xgaezz4INkkz9togYVy+FWf8gsTnCJyaAa56BCzYQkJPYp3sQCg1zFauwBq54
         Z2kgdbWXRPu2nHPZVzVDyGiXzvaO1JtANqqyGOT+vOtKsDDsB2AXWzftbc/bfSyf5w2A
         8kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803299; x=1696408099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW//0hg2ZBcL2pbV43SXPkrbW8KNU1L75iBZdBWNo5Y=;
        b=v4Kk6bZxIBBrHgj+rbfi9eak5dFvTsEusAY81I/B/21BvEWjQr0pPOPt4PvpbFLJ/u
         IA4nxyCtUnFyElbIYEHn0/0FOthjI68X5Xo2FCAkc784g6f6pg+aS9OiF4THQImK77gy
         dMYPjg0bLMHleXLHyZpG0tJBjxxXTmtCpHG8uYlsZ3/FdZNZjL2o1xd+WxHyFhAjrgnB
         xMQ/Jj+XEtg5WbKnsSlMWNNNbSfPgRuanhrq2HpaQODHaSwOrMfj40RcTxJesL+syKG4
         ux4S4MW3EVTyQ+D/dHu2BcApYXeXkzb2/zh4FHow0rYMkqzzmt6ReQPn+UU/lr/EkuYF
         b/Jw==
X-Gm-Message-State: AOJu0Yz66XFbM/A/6mQ877oQgh+AwC/8oGoYBCOzeUS5s+RfvZ6MMO98
        +iyVv/DsNofP15rRipc9yOI=
X-Google-Smtp-Source: AGHT+IGGo2RlMeIAN9fp2uJxfjdS3+3rpsODqK+ld/TvgCA+g4Qe/7N6dZ6ALkSl+VdVVQHYSqwmJw==
X-Received: by 2002:a05:6512:10d1:b0:503:1722:bf3a with SMTP id k17-20020a05651210d100b005031722bf3amr1527797lfg.1.1695803299038;
        Wed, 27 Sep 2023 01:28:19 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b00503189d8b8csm2531687lft.198.2023.09.27.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:28:17 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:28:13 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] iio: pressure: Support ROHM BU1390
Message-ID: <4f23211e3cf248f9f48ddb2a752387bb00e9c2c4.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gEkNYV1/m57NRl57"
Content-Disposition: inline
In-Reply-To: <cover.1695727471.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gEkNYV1/m57NRl57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
pressures ranging from 300 hPa to 1300 hPa with configurable measurement
averaging and internal FIFO. The sensor does also provide temperature
measurements.

Sensor does also contain IIR filter implemented in HW. The data-sheet
says the IIR filter can be configured to be "weak", "middle" or
"strong". Some RMS noise figures are provided in data sheet but no
accurate maths for the filter configurations is provided. Hence, the IIR
filter configuration is not supported by this driver and the filter is
configured to the "middle" setting (at least not for now).

The FIFO measurement mode is only measuring the pressure and not the
temperature. The driver measures temperature when FIFO is flushed and
simply uses the same measured temperature value to all reported
temperatures. This should not be a problem when temperature is not
changing very rapidly (several degrees C / second) but allows users to
get the temperature measurements from sensor without any additional logic.

This driver allows the sensor to be used in two muitually exclusive ways,

1. With trigger (data-ready IRQ).
In this case the FIFO is not used as we get data ready for each collected
sample. Instead, for each data-ready IRQ we read the sample from sensor
and push it to the IIO buffer.

2. With hardware FIFO and watermark IRQ.
In this case the data-ready is not used but we enable watermark IRQ. At
each watermark IRQ we go and read all samples in FIFO and push them to the
IIO buffer.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v3 =3D> v4:
- fix some typos
- drop useless print
- use iio_push_to_buffers() instead of
  iio_push_to_buffers_with_timestamp()
- provide own iio_info struct for use without IRQ
- allow other triggers
- fix ordering of the FIFO disabling
- don't set INDIO_BUFFER_SOFTWARE when there's no SW buffer

v2 =3D> v3:
- Read temperature only after FIFO is read to overcome a HW quirck
- Drop unused defines
- Allow scanning the pressure only
- Some clarifying comments added, some made less verbose
- warn if measurement stp fails
- use IIO_VAL_FRACTIONAL for pressure scale
- don't disable IRQ but use timestamp from stack
- fix amount of samples to read
- minor styling
- better separate buffer and trigger parts
- allow buffer even when there is no IRQ
  with external trigger to be supported.
- add completely, utterly useless NULL check because we have the cycles
  to waste (grumbles)

v1 =3D> v2:
- prefer s64 over int64_t
- drop not needed handling of 2's complements
- plenty of styling changes
- drop dead code (write_raw)
- fix typos in comments
- explain trigger and FIFO usage in commit message
- do better job at cheking the return values
- ensure there's no race when checking if triggered buffer is used
  before enabling the FIFO
- print warning if register read fails at IRQ handler
- drop unnecessary warning if IRQ is not given
- explain why we prefer asynchronous probing
---
 drivers/iio/pressure/Kconfig       |   9 +
 drivers/iio/pressure/Makefile      |   1 +
 drivers/iio/pressure/rohm-bm1390.c | 934 +++++++++++++++++++++++++++++
 3 files changed, 944 insertions(+)
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 7b4c2af32852..95efa32e4289 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -16,6 +16,15 @@ config ABP060MG
 	  To compile this driver as a module, choose M here: the module
 	  will be called abp060mg.
=20
+config ROHM_BM1390
+	tristate "ROHM BM1390GLV-Z pressure sensor driver"
+	depends on I2C
+	help
+	  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
+	  can measure pressures ranging from 300 hPa to 1300 hPa with
+	  configurable measurement averaging and internal FIFO. The
+	  sensor does also provide temperature measurements.
+
 config BMP280
 	tristate "Bosch Sensortec BMP180/BMP280/BMP380/BMP580 pressure sensor dri=
ver"
 	depends on (I2C || SPI_MASTER)
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index c90f77210e94..436aec7e65f3 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -5,6 +5,7 @@
=20
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) +=3D abp060mg.o
+obj-$(CONFIG_ROHM_BM1390) +=3D rohm-bm1390.o
 obj-$(CONFIG_BMP280) +=3D bmp280.o
 bmp280-objs :=3D bmp280-core.o bmp280-regmap.o
 obj-$(CONFIG_BMP280_I2C) +=3D bmp280-i2c.o
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm=
-bm1390.c
new file mode 100644
index 000000000000..ccaa07a569c9
--- /dev/null
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -0,0 +1,934 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BM1390 ROHM pressure sensor
+ *
+ * Copyright (c) 2023, ROHM Semiconductor.
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/pressur=
e/bm1390glv-z-e.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define BM1390_REG_MANUFACT_ID		0x0f
+#define BM1390_REG_PART_ID		0x10
+#define BM1390_REG_POWER		0x12
+#define BM1390_MASK_POWER		BIT(0)
+#define BM1390_POWER_ON			BM1390_MASK_POWER
+#define BM1390_POWER_OFF		0x00
+#define BM1390_REG_RESET		0x13
+#define BM1390_MASK_RESET		BIT(0)
+#define BM1390_RESET_RELEASE		BM1390_MASK_RESET
+#define BM1390_RESET			0x00
+#define BM1390_REG_MODE_CTRL		0x14
+#define BM1390_MASK_MEAS_MODE		GENMASK(1, 0)
+#define BM1390_MASK_DRDY_EN		BIT(4)
+#define BM1390_MASK_WMI_EN		BIT(2)
+#define BM1390_MASK_AVE_NUM		GENMASK(7, 5)
+
+/*
+ * Data-sheet states that when the IIR is used, the AVE_NUM must be set to
+ * value 110b
+ */
+#define BM1390_IIR_AVE_NUM		0x06
+#define BM1390_REG_FIFO_CTRL		0x15
+#define BM1390_MASK_IIR_MODE		GENMASK(1, 0)
+#define BM1390_IIR_MODE_OFF		0x0
+#define BM1390_IIR_MODE_WEAK		0x1
+#define BM1390_IIR_MODE_MID		0x2
+#define BM1390_IIR_MODE_STRONG		0x3
+
+#define BM1390_MASK_FIFO_LEN		BIT(6)
+#define BM1390_MASK_FIFO_EN		BIT(7)
+#define BM1390_WMI_MIN			2
+#define BM1390_WMI_MAX			3
+
+#define BM1390_REG_FIFO_LVL		0x18
+#define BM1390_MASK_FIFO_LVL		GENMASK(2, 0)
+#define BM1390_REG_STATUS		0x19
+#define BM1390_REG_PRESSURE_BASE	0x1a
+#define BM1390_REG_TEMP_HI		0x1d
+#define BM1390_REG_TEMP_LO		0x1e
+#define BM1390_MAX_REGISTER		BM1390_REG_TEMP_LO
+
+#define BM1390_ID			0x34
+
+/* Regmap configs */
+static const struct regmap_range bm1390_volatile_ranges[] =3D {
+	{
+		.range_min =3D BM1390_REG_STATUS,
+		.range_max =3D BM1390_REG_STATUS,
+	},
+	{
+		.range_min =3D BM1390_REG_FIFO_LVL,
+		.range_max =3D BM1390_REG_TEMP_LO,
+	},
+};
+
+static const struct regmap_access_table bm1390_volatile_regs =3D {
+	.yes_ranges =3D &bm1390_volatile_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bm1390_volatile_ranges),
+};
+
+static const struct regmap_range bm1390_precious_ranges[] =3D {
+	{
+		.range_min =3D BM1390_REG_STATUS,
+		.range_max =3D BM1390_REG_STATUS,
+	},
+};
+
+static const struct regmap_access_table bm1390_precious_regs =3D {
+	.yes_ranges =3D &bm1390_precious_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bm1390_precious_ranges),
+};
+
+static const struct regmap_range bm1390_read_only_ranges[] =3D {
+	{
+		.range_min =3D BM1390_REG_MANUFACT_ID,
+		.range_max =3D BM1390_REG_PART_ID,
+	}, {
+		.range_min =3D BM1390_REG_FIFO_LVL,
+		.range_max =3D BM1390_REG_TEMP_LO,
+	},
+};
+
+static const struct regmap_access_table bm1390_ro_regs =3D {
+	.no_ranges =3D &bm1390_read_only_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(bm1390_read_only_ranges),
+};
+
+static const struct regmap_range bm1390_noinc_read_ranges[] =3D {
+	{
+		.range_min =3D BM1390_REG_PRESSURE_BASE,
+		.range_max =3D BM1390_REG_TEMP_LO,
+	},
+};
+
+static const struct regmap_access_table bm1390_nir_regs =3D {
+	.yes_ranges =3D &bm1390_noinc_read_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bm1390_noinc_read_ranges),
+};
+
+static const struct regmap_config bm1390_regmap =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.volatile_table =3D &bm1390_volatile_regs,
+	.wr_table =3D &bm1390_ro_regs,
+	.rd_noinc_table =3D &bm1390_nir_regs,
+	.precious_table =3D &bm1390_precious_regs,
+	.max_register =3D BM1390_MAX_REGISTER,
+	.cache_type =3D REGCACHE_RBTREE,
+	.disable_locking =3D true,
+};
+
+enum {
+	BM1390_STATE_SAMPLE,
+	BM1390_STATE_FIFO,
+};
+
+struct bm1390_data_buf {
+	u32 pressure;
+	__be16 temp;
+	s64 ts __aligned(8);
+};
+
+/* BM1390 has FIFO for 4 pressure samples */
+#define BM1390_FIFO_LENGTH	4
+
+struct bm1390_data {
+	s64 timestamp, old_timestamp;
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+	struct device *dev;
+	struct bm1390_data_buf buf;
+	int irq;
+	unsigned int state;
+	bool trigger_enabled;
+	u8 watermark;
+
+	/* Prevent accessing sensor during FIFO read sequence */
+	struct mutex mutex;
+};
+
+enum {
+	BM1390_CHAN_PRESSURE,
+	BM1390_CHAN_TEMP,
+};
+
+static const struct iio_chan_spec bm1390_channels[] =3D {
+	{
+		.type =3D IIO_PRESSURE,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+		/*
+		 * When IIR is used, we must fix amount of averaged samples.
+		 * Thus we don't allow setting oversampling ratio.
+		 */
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index =3D BM1390_CHAN_PRESSURE,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D 22,
+			.storagebits =3D 32,
+			.endianness =3D IIO_LE,
+		},
+	},
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index =3D BM1390_CHAN_TEMP,
+		.scan_type =3D {
+			.sign =3D 's',
+			.realbits =3D 16,
+			.storagebits =3D 16,
+			.endianness =3D IIO_BE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+/*
+ * We can't skip reading the pressure because the watermark IRQ is acked
+ * only when the pressure data is read from the FIFO.
+ */
+static const unsigned long bm1390_scan_masks[] =3D {
+	BIT(BM1390_CHAN_PRESSURE),
+	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
+	0
+};
+
+static int bm1390_read_temp(struct bm1390_data *data, int *temp)
+{
+	__be16 temp_raw;
+	int ret;
+
+	ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_raw,
+			       sizeof(temp_raw));
+	if (ret)
+		return ret;
+
+	*temp =3D be16_to_cpu(temp_raw);
+
+	return 0;
+}
+
+static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
+{
+	/* Pressure data is in 3 8-bit registers */
+	u8 raw[3];
+	int ret;
+
+	ret =3D regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
+			       raw, sizeof(raw));
+	if (ret < 0)
+		return ret;
+
+	*pressure =3D (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
+
+	return 0;
+}
+
+ /* The enum values map directly to register bits */
+enum bm1390_meas_mode {
+	BM1390_MEAS_MODE_STOP =3D 0x0,
+	BM1390_MEAS_MODE_1SHOT =3D 0x1,
+	BM1390_MEAS_MODE_CONTINUOUS =3D 0x2,
+};
+
+static int bm1390_meas_set(struct bm1390_data *data, enum bm1390_meas_mode=
 mode)
+{
+	return regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				  BM1390_MASK_MEAS_MODE, mode);
+}
+
+/*
+ * If the trigger is not used we just wait until the measurement has
+ * completed. The data-sheet says maximum measurement cycle (regardless
+ * the AVE_NUM) is 200 mS so let's just sleep at least that long. If speed
+ * is needed the trigger should be used.
+ */
+#define BM1390_MAX_MEAS_TIME_MS 205
+
+static int bm1390_read_data(struct bm1390_data *data,
+			struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	int ret, warn;
+
+	mutex_lock(&data->mutex);
+	/*
+	 * We use 'continuous mode' even for raw read because according to the
+	 * data-sheet an one-shot mode can't be used with IIR filter.
+	 */
+	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
+	if (ret)
+		goto unlock_out;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		msleep(BM1390_MAX_MEAS_TIME_MS);
+		ret =3D bm1390_pressure_read(data, val);
+		break;
+	case IIO_TEMP:
+		msleep(BM1390_MAX_MEAS_TIME_MS);
+		ret =3D bm1390_read_temp(data, val);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+	warn =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
+	if (warn)
+		dev_warn(data->dev, "Failed to stop measurement (%d)\n", warn);
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bm1390_read_raw(struct iio_dev *idev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type =3D=3D IIO_TEMP) {
+			*val =3D 31;
+			*val2 =3D 250000;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		} else if (chan->type =3D=3D IIO_PRESSURE) {
+			/*
+			 * pressure in hPa is register value divided by 2048.
+			 * This means kPa is 1/20480 times the register value,
+			 */
+			*val =3D 1;
+			*val2 =3D 2048;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iio_device_claim_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		ret =3D bm1390_read_data(data, chan, val, val2);
+		iio_device_release_direct_mode(idev);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
+			       s64 timestamp)
+{
+	/* BM1390_FIFO_LENGTH is small so we shouldn't run out of stack */
+	struct bm1390_data_buf buffer[BM1390_FIFO_LENGTH];
+	struct bm1390_data *data =3D iio_priv(idev);
+	int smp_lvl, ret, i, warn, dummy;
+	u64 sample_period;
+	__be16 temp =3D 0;
+
+	ret =3D regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
+	if (ret)
+		return ret;
+
+	smp_lvl =3D FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
+	if (!smp_lvl)
+		return 0;
+
+	if (smp_lvl > BM1390_FIFO_LENGTH) {
+		/*
+		 * The fifo holds maximum of 4 samples so valid values
+		 * should be 0, 1, 2, 3, 4 - rest are probably bit errors
+		 * in I2C line. Don't overflow if this happens.
+		 */
+		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
+		smp_lvl =3D BM1390_FIFO_LENGTH;
+	}
+
+	sample_period =3D timestamp - data->old_timestamp;
+	do_div(sample_period, smp_lvl);
+
+	if (samples && smp_lvl > samples)
+		smp_lvl =3D samples;
+
+
+	/*
+	 * After some testing it appears that the temperature is not readable
+	 * until the FIFO access has been done after the WMI. Thus, we need
+	 * to read the all pressure values to memory and read the temperature
+	 * only after that.
+	 */
+	for (i =3D 0; i < smp_lvl; i++) {
+		/*
+		 * When we start reading data from the FIFO the sensor goes to
+		 * special FIFO reading mode. If any other register is accessed
+		 * during the FIFO read, samples can be dropped. Prevent access
+		 * until FIFO_LVL is read. We have mutex locked and we do also
+		 * go performing reading of FIFO_LVL even if this read fails.
+		 */
+		if (test_bit(BM1390_CHAN_PRESSURE, idev->active_scan_mask)) {
+			ret =3D bm1390_pressure_read(data, &buffer[i].pressure);
+			if (ret)
+				break;
+		}
+
+		/*
+		 * Old timestamp is either the previous sample IRQ time,
+		 * previous flush-time or, if this was first sample, the enable
+		 * time. When we add a sample period to that we should get the
+		 * best approximation of the time-stamp we are handling.
+		 *
+		 * Idea is to always keep the "old_timestamp" matching the
+		 * timestamp which we are currently handling.
+		 */
+		data->old_timestamp +=3D sample_period;
+		buffer[i].ts =3D data->old_timestamp;
+	}
+	/* Reading the FIFO_LVL closes the FIFO access sequence */
+	warn =3D regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &dummy);
+	if (warn)
+		dev_warn(data->dev, "Closing FIFO sequence failed\n");
+
+	if (ret)
+		return ret;
+
+	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
+		ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
+				       sizeof(temp));
+		if (ret)
+			return ret;
+	}
+
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < smp_lvl; i++) {
+		buffer[i].temp =3D temp;
+		iio_push_to_buffers(idev, &buffer[i]);
+	}
+
+	return smp_lvl;
+}
+
+static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+	s64 timestamp;
+	int ret;
+
+	/*
+	 * If fifo_flush is being called from IRQ handler we know the stored
+	 * timestamp is fairly accurate for the last stored sample. If we are
+	 * called as a result of a read operation from userspace and hence
+	 * before the watermark interrupt was triggered, take a timestamp
+	 * now. We can fall anywhere in between two samples so the error in this
+	 * case is at most one sample period.
+	 * We need to have the IRQ disabled or we risk of messing-up
+	 * the timestamps. If we are ran from IRQ, then the
+	 * IRQF_ONESHOT has us covered - but if we are ran by the
+	 * user-space read we need to disable the IRQ to be on a safe
+	 * side. We do this usng synchronous disable so that if the
+	 * IRQ thread is being ran on other CPU we wait for it to be
+	 * finished.
+	 */
+
+	timestamp =3D iio_get_time_ns(idev);
+	mutex_lock(&data->mutex);
+	ret =3D __bm1390_fifo_flush(idev, samples, timestamp);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bm1390_set_watermark(struct iio_dev *idev, unsigned int val)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+
+	if (val < BM1390_WMI_MIN || val > BM1390_WMI_MAX)
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	data->watermark =3D val;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static const struct iio_info bm1390_noirq_info =3D {
+	.read_raw =3D &bm1390_read_raw,
+};
+
+static const struct iio_info bm1390_info =3D {
+	.read_raw =3D &bm1390_read_raw,
+	.hwfifo_set_watermark =3D bm1390_set_watermark,
+	.hwfifo_flush_to_buffer =3D bm1390_fifo_flush,
+};
+
+static int bm1390_chip_init(struct bm1390_data *data)
+{
+	int ret;
+
+	ret =3D regmap_write_bits(data->regmap, BM1390_REG_POWER,
+				BM1390_MASK_POWER, BM1390_POWER_ON);
+	if (ret)
+		return ret;
+
+	msleep(1);
+
+	ret =3D regmap_write_bits(data->regmap, BM1390_REG_RESET,
+				BM1390_MASK_RESET, BM1390_RESET);
+	if (ret)
+		return ret;
+
+	msleep(1);
+
+	ret =3D regmap_write_bits(data->regmap, BM1390_REG_RESET,
+				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
+	if (ret)
+		return ret;
+
+	msleep(1);
+
+	ret =3D regmap_reinit_cache(data->regmap, &bm1390_regmap);
+	if (ret) {
+		dev_err(data->dev, "Failed to reinit reg cache\n");
+		return ret;
+	}
+
+	/*
+	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
+	 * be fixed when IIR is in use.
+	 */
+	ret =3D regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
+				  BM1390_MASK_IIR_MODE, BM1390_IIR_MODE_MID);
+}
+
+static int bm1390_fifo_set_wmi(struct bm1390_data *data)
+{
+	u8 regval;
+
+	regval =3D FIELD_PREP(BM1390_MASK_FIFO_LEN,
+			    data->watermark - BM1390_WMI_MIN);
+
+	return regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
+				  BM1390_MASK_FIFO_LEN, regval);
+}
+
+static int bm1390_fifo_enable(struct iio_dev *idev)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret;
+
+	/* We can't do buffered stuff without IRQ as we never get WMI */
+	if (data->irq <=3D 0)
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	if (data->trigger_enabled) {
+		ret =3D -EBUSY;
+		goto unlock_out;
+	}
+
+	/* Update watermark to HW */
+	ret =3D bm1390_fifo_set_wmi(data);
+	if (ret)
+		goto unlock_out;
+
+	/* Enable WMI_IRQ */
+	ret =3D regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
+			      BM1390_MASK_WMI_EN);
+	if (ret)
+		goto unlock_out;
+
+	/* Enable FIFO */
+	ret =3D regmap_set_bits(data->regmap, BM1390_REG_FIFO_CTRL,
+			      BM1390_MASK_FIFO_EN);
+	if (ret)
+		goto unlock_out;
+
+	data->state =3D BM1390_STATE_FIFO;
+
+	data->old_timestamp =3D iio_get_time_ns(idev);
+	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bm1390_fifo_disable(struct iio_dev *idev)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret;
+
+	msleep(1);
+
+	mutex_lock(&data->mutex);
+	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
+	if (ret)
+		goto unlock_out;
+
+	/* Disable FIFO */
+	ret =3D regmap_clear_bits(data->regmap, BM1390_REG_FIFO_CTRL,
+				BM1390_MASK_FIFO_EN);
+	if (ret)
+		goto unlock_out;
+
+	data->state =3D BM1390_STATE_SAMPLE;
+
+	/* Disable WMI_IRQ */
+	ret =3D regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				 BM1390_MASK_WMI_EN);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bm1390_buffer_postenable(struct iio_dev *idev)
+{
+	/*
+	 * If we use data-ready trigger, then the IRQ masks should be handled by
+	 * trigger enable and the hardware buffer is not used but we just update
+	 * results to the IIO FIFO when data-ready triggers.
+	 */
+	if (iio_device_get_current_mode(idev) =3D=3D INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return bm1390_fifo_enable(idev);
+}
+
+static int bm1390_buffer_predisable(struct iio_dev *idev)
+{
+	if (iio_device_get_current_mode(idev) =3D=3D INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return bm1390_fifo_disable(idev);
+}
+
+static const struct iio_buffer_setup_ops bm1390_buffer_ops =3D {
+	.postenable =3D bm1390_buffer_postenable,
+	.predisable =3D bm1390_buffer_predisable,
+};
+
+static irqreturn_t bm1390_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *idev =3D pf->indio_dev;
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret, status;
+
+	/* DRDY is acked by reading status reg */
+	ret =3D regmap_read(data->regmap, BM1390_REG_STATUS, &status);
+	if (ret || !status)
+		return IRQ_NONE;
+
+	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
+
+	if (test_bit(BM1390_CHAN_PRESSURE, idev->active_scan_mask)) {
+		ret =3D bm1390_pressure_read(data, &data->buf.pressure);
+		if (ret) {
+			dev_warn(data->dev, "sample read failed %d\n", ret);
+			return IRQ_NONE;
+		}
+	}
+
+	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
+		ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
+				       &data->buf.temp, sizeof(data->buf.temp));
+		if (ret) {
+			dev_warn(data->dev, "temp read failed %d\n", ret);
+			return IRQ_HANDLED;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
+	iio_trigger_notify_done(idev->trig);
+
+	return IRQ_HANDLED;
+}
+
+/* Get timestamps and wake the thread if we need to read data */
+static irqreturn_t bm1390_irq_handler(int irq, void *private)
+{
+	struct iio_dev *idev =3D private;
+	struct bm1390_data *data =3D iio_priv(idev);
+
+	data->timestamp =3D iio_get_time_ns(idev);
+
+	if (data->state =3D=3D BM1390_STATE_FIFO || data->trigger_enabled)
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t bm1390_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *idev =3D private;
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret =3D IRQ_NONE;
+
+	mutex_lock(&data->mutex);
+
+	if (data->trigger_enabled) {
+		iio_trigger_poll_nested(data->trig);
+		ret =3D IRQ_HANDLED;
+	} else if (data->state =3D=3D BM1390_STATE_FIFO) {
+		int ok;
+
+		ok =3D __bm1390_fifo_flush(idev, BM1390_FIFO_LENGTH,
+					 data->timestamp);
+		if (ok > 0)
+			ret =3D IRQ_HANDLED;
+	}
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bm1390_set_drdy_irq(struct bm1390_data *data, bool en)
+{
+	if (en)
+		return regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				       BM1390_MASK_DRDY_EN);
+	return regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				 BM1390_MASK_DRDY_EN);
+}
+
+static int bm1390_trigger_set_state(struct iio_trigger *trig,
+				    bool state)
+{
+	struct bm1390_data *data =3D iio_trigger_get_drvdata(trig);
+	int ret =3D 0;
+
+	mutex_lock(&data->mutex);
+
+	if (data->trigger_enabled =3D=3D state)
+		goto unlock_out;
+
+	if (data->state =3D=3D BM1390_STATE_FIFO) {
+		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
+		ret =3D -EBUSY;
+		goto unlock_out;
+	}
+
+	data->trigger_enabled =3D state;
+
+	if (state) {
+		ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
+		if (ret)
+			goto unlock_out;
+	} else {
+		int dummy;
+
+		ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
+		if (ret)
+			goto unlock_out;
+
+		/*
+		 * We need to read the status register in order to ACK the
+		 * data-ready which may have been generated just before we
+		 * disabled the measurement.
+		 */
+		ret =3D regmap_read(data->regmap, BM1390_REG_STATUS, &dummy);
+		if (ret)
+			dev_warn(data->dev, "status read failed\n");
+	}
+
+	ret =3D bm1390_set_drdy_irq(data, state);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct iio_trigger_ops bm1390_trigger_ops =3D {
+	.set_trigger_state =3D bm1390_trigger_set_state,
+};
+
+static int bm1390_setup_buffer(struct bm1390_data *data, struct iio_dev *i=
dev)
+{
+	int ret;
+
+	ret =3D devm_iio_triggered_buffer_setup(data->dev, idev,
+					      &iio_pollfunc_store_time,
+					      &bm1390_trigger_handler,
+					      &bm1390_buffer_ops);
+
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio_triggered_buffer_setup FAIL\n");
+
+	idev->available_scan_masks =3D bm1390_scan_masks;
+
+	return 0;
+}
+
+static int bm1390_setup_trigger(struct bm1390_data *data, struct iio_dev *=
idev,
+				int irq)
+{
+	struct iio_trigger *itrig;
+	char *name;
+	int ret;
+
+	itrig =3D devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", idev->nam=
e,
+					    iio_device_id(idev));
+	if (!itrig)
+		return -ENOMEM;
+
+	data->trig =3D itrig;
+
+	itrig->ops =3D &bm1390_trigger_ops;
+	iio_trigger_set_drvdata(itrig, data);
+
+	name =3D devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
+			      dev_name(data->dev));
+	if (name =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D devm_request_threaded_irq(data->dev, irq, bm1390_irq_handler,
+					&bm1390_irq_thread_handler,
+					IRQF_ONESHOT, name, idev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
+
+
+	ret =3D devm_iio_trigger_register(data->dev, itrig);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Trigger registration failed\n");
+
+	return 0;
+}
+
+static int bm1390_probe(struct i2c_client *i2c)
+{
+	struct bm1390_data *data;
+	struct regmap *regmap;
+	struct iio_dev *idev;
+	struct device *dev;
+	unsigned int part_id;
+	int ret;
+
+	dev =3D &i2c->dev;
+
+	regmap =3D devm_regmap_init_i2c(i2c, &bm1390_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
+
+	ret =3D devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	ret =3D regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to access sensor\n");
+
+	if (part_id !=3D BM1390_ID)
+		dev_warn(dev, "unknown device 0x%x\n", part_id);
+
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	data =3D iio_priv(idev);
+	data->regmap =3D regmap;
+	data->dev =3D dev;
+	data->irq =3D i2c->irq;
+	/*
+	 * For now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
+	 * discard every other configuration when triggered mode is not used.
+	 */
+	data->watermark =3D BM1390_WMI_MAX;
+	mutex_init(&data->mutex);
+
+	idev->channels =3D bm1390_channels;
+	idev->num_channels =3D ARRAY_SIZE(bm1390_channels);
+	idev->name =3D "bm1390";
+	idev->modes =3D INDIO_DIRECT_MODE;
+
+	ret =3D bm1390_chip_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "sensor init failed\n");
+
+	ret =3D bm1390_setup_buffer(data, idev);
+	if (ret)
+		return ret;
+
+	/* No trigger if we don't have IRQ for data-ready and WMI */
+	if (i2c->irq > 0) {
+		idev->info =3D &bm1390_info;
+		idev->modes |=3D INDIO_BUFFER_SOFTWARE;
+		ret =3D bm1390_setup_trigger(data, idev, i2c->irq);
+		if (ret)
+			return ret;
+	} else {
+		idev->info =3D &bm1390_noirq_info;
+	}
+
+	ret =3D devm_iio_device_register(dev, idev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Unable to register iio device\n");
+
+	return 0;
+}
+
+static const struct of_device_id bm1390_of_match[] =3D {
+	{ .compatible =3D "rohm,bm1390glv-z" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bm1390_of_match);
+
+static const struct i2c_device_id bm1390_id[] =3D {
+	{ "bm1390glv-z", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bm1390_id);
+
+static struct i2c_driver bm1390_driver =3D {
+	.driver =3D {
+		.name =3D "bm1390",
+		.of_match_table =3D bm1390_of_match,
+		/*
+		 * Probing explicitly requires a few millisecond of sleep.
+		 * Enabling the VDD regulator may include ramp up rates.
+		 */
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe =3D bm1390_probe,
+	.id_table =3D bm1390_id,
+};
+module_i2c_driver(bm1390_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Driver for ROHM BM1390 pressure sensor");
+MODULE_LICENSE("GPL");
--=20
2.41.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--gEkNYV1/m57NRl57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT550ACgkQeFA3/03a
ocXN5gf/cVjxZZyNOlVMtxplIC1W6V3SjYD8FJZXpryMcdZFZ6HfJbseyODZffhv
aSlapL+4mUGjMaUUY4N6byrlkXa8vVXx4CNa7o/vzTv6xWFf04yRw/RqX9yGLrP3
g5uKgAqJ8VqxOjkLowwCgOr12G/9ncUV2eFB8B1ISqfY750FsPK350znAn+Udx9s
0dTGCXv5GXfVWiqc0p/3oKM+MqryxyqSZjsvADmbrNkA1wMYMSOzuZA0NPH+CStB
4Gn+KCvbepdXF8gs1RY31a6rDJXvsKcY4Bhv8oi9IruBIlU7T6EdJnmKJDOpcbE1
5BQh+O4eHAxBCzgpOU/EyPYwM0r2zg==
=/qc4
-----END PGP SIGNATURE-----

--gEkNYV1/m57NRl57--
