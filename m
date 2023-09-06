Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4630793CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjIFMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIFMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:38:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84375171F;
        Wed,  6 Sep 2023 05:37:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so57156291fa.2;
        Wed, 06 Sep 2023 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694003874; x=1694608674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uMlZi0H5+FVdOiHvAHEZ9XDX/D3fVcsZQ3Qq6sKqUw=;
        b=DI7REB9wjT3Vka7MAc9xcnIowL9HKjdCkQYxImGsZIv9vgQH2ioyvthHYoGSIIwaBF
         QWUYK8HWaSn97yjMC6sLpMvDHRe7NzQQy7aXuNVOhNXxmBFnjpMp7krQ/Brc3XJJ6LK3
         GliEWfgNVhSm15Q11WiybBYgNmtdpS6MEhCKvUXYNPbJlc9MkL0d3hLs+VO88vN6f/SG
         m8BVXLgad90LGbLveeA/67l5YDD18/m9Tsy+II+DdRwnLWF4etu9oQASG7hb6k266Uc3
         ZWw7sVn0ART6Z6MOj4V7zE8xYkCvjCmkMg8KhE+dmRTcIngwer31XgKu5jX1SNTEWb4z
         ycMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003874; x=1694608674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uMlZi0H5+FVdOiHvAHEZ9XDX/D3fVcsZQ3Qq6sKqUw=;
        b=dslGsHtlUT6JyKhFoB0PCVkWH1DccTmVheO864vm0F6xE2D3B7Q7TZphegVxsgrYE6
         sRrp3WM/x1cUwEmhaSbMWoBbegC0o8QyJk9ndAX6JCu5HxpStH2jO0a4N1ICFwyqSo3F
         qnLEjHi9wLXgToyaVockqdGl+/bC9GmsaQa6SjiV6p6aFLh1zN/pBPQHZu3GQ23hIYPz
         QwSY6hE9fxqbTQrlbpNx73Zg+mE5rpNPSCHk38h9516Z9XgcpK29BcS0+ITjSHbhJvs6
         gIpYnCF3ti6cEtofTaj7mCrdhxoX1lzyi7XdLFXVXWLUlYra4ZXdjjyDhdtndwYlI0Rl
         BdAA==
X-Gm-Message-State: AOJu0YwlCYk6xRBHnKDwJq4pzb67B/JRTbl0xDI+/uWZjOjtfZjVMsA4
        iPgFC/oft2FMa/g+A64o7XQ=
X-Google-Smtp-Source: AGHT+IHPCKt++WNjrWv9tXNEPPUe1bZHFCU7oUJwxpNbeiDYgbuu7MJI1eqflOF8kRaxSB7OwnV33Q==
X-Received: by 2002:a2e:991a:0:b0:2b9:aa4d:3728 with SMTP id v26-20020a2e991a000000b002b9aa4d3728mr2208732lji.29.1694003873418;
        Wed, 06 Sep 2023 05:37:53 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id g24-20020a2eb0d8000000b002b6cd89a3fcsm3395958ljl.118.2023.09.06.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:37:52 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:37:48 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lFfLBnrnvyuXQCIO"
Content-Disposition: inline
In-Reply-To: <cover.1694001462.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lFfLBnrnvyuXQCIO
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

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/pressure/Kconfig       |   9 +
 drivers/iio/pressure/Makefile      |   1 +
 drivers/iio/pressure/rohm-bm1390.c | 944 +++++++++++++++++++++++++++++
 3 files changed, 954 insertions(+)
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
index 000000000000..2d51a99a58fc
--- /dev/null
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -0,0 +1,944 @@
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
+/* Pressure data is in 3 8-bit registers */
+#define BM1390_PRESSURE_SIZE	3
+
+/* BM1390 has FIFO for 4 pressure samples */
+#define BM1390_FIFO_LENGTH	4
+
+/* Temperature data is in 2 8-bit registers */
+#define BM1390_TEMP_SIZE	2
+
+struct bm1390_data {
+	int64_t timestamp, old_timestamp;
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
+static const unsigned long bm1390_scan_masks[] =3D {
+	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
+};
+
+static int bm1390_read_temp(struct bm1390_data *data, int *temp)
+{
+	u8 temp_reg[2] __aligned(2);
+	__be16 *temp_raw;
+	int ret;
+	s16 val;
+	bool negative;
+
+	ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
+			       sizeof(temp_reg));
+	if (ret)
+		return ret;
+
+	if (temp_reg[0] & 0x80)
+		negative =3D true;
+	else
+		negative =3D false;
+
+	temp_raw =3D (__be16 *)&temp_reg[0];
+	val =3D be16_to_cpu(*temp_raw);
+
+	if (negative) {
+		/*
+		 * Two's complement. I am not sure if all supported
+		 * architectures actually use 2's complement represantation of
+		 * signed ints. If yes, then we could just do the endianes
+		 * conversion and say this is the s16 value. However, as I
+		 * don't know, and as the conversion is pretty simple. let's
+		 * just convert the signed 2's complement to absolute value and
+		 * multiply by -1.
+		 */
+		val =3D ~val + 1;
+		val *=3D -1;
+	}
+
+	*temp =3D val;
+
+	return 0;
+}
+
+static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
+{
+	int ret;
+	u8 raw[3];
+
+	ret =3D regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
+			       &raw[0], sizeof(raw));
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
+	BM1390_MEAS_MODE_1SHOT,
+	BM1390_MEAS_MODE_CONTINUOUS,
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
+	int ret;
+
+	*val2 =3D 0;
+
+	mutex_lock(&data->mutex);
+	/*
+	 * We use 'continuous mode' even for raw read because according to the
+	 * data-sheet an one-shot mode can't be used with IIR filter
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
+	bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
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
+			*val =3D 0;
+			/*
+			 * pressure in hPa is register value divided by 2048.
+			 * This means kPa is 1/20480 times the register value,
+			 * which equals to 48828.125 * 10 ^ -9
+			 * This is 48828.125 nano kPa.
+			 *
+			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
+			 * get 48828 - which means we lose some accuracy. Well,
+			 * let's try to live with that.
+			 */
+			*val2 =3D 48828;
+
+			return IIO_VAL_INT_PLUS_NANO;
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
+		if (!ret)
+			return IIO_VAL_INT;
+
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
+			       bool irq)
+{
+	/* The fifo holds maximum of 4 samples */
+	struct bm1390_data *data =3D iio_priv(idev);
+	struct bm1390_data_buf buffer;
+	int smp_lvl, ret, i;
+	u64 sample_period;
+	__be16 temp =3D 0;
+
+	/*
+	 * If the IC is accessed during FIFO read samples can be dropped.
+	 * Prevent access until FIFO_LVL is read
+	 */
+	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
+		ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
+				       sizeof(temp));
+		if (ret)
+			return ret;
+	}
+
+	ret =3D regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
+	if (ret)
+		return ret;
+
+	smp_lvl =3D FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
+
+	if (smp_lvl > 4) {
+		/*
+		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
+		 * bit errors in I2C line. Don't overflow if this happens.
+		 */
+		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
+		smp_lvl =3D 4;
+	}
+
+	if (!smp_lvl)
+		return ret;
+
+	sample_period =3D data->timestamp - data->old_timestamp;
+	do_div(sample_period, smp_lvl);
+
+	if (samples && smp_lvl > samples)
+		smp_lvl =3D samples;
+
+	for (i =3D 0; i < smp_lvl; i++) {
+		ret =3D bm1390_pressure_read(data, &buffer.pressure);
+		if (ret)
+			break;
+
+		buffer.temp =3D temp;
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
+
+		iio_push_to_buffers_with_timestamp(idev, &buffer,
+						   data->old_timestamp);
+	}
+	/* Reading the FIFO_LVL closes the FIFO access sequence */
+	regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
+
+	if (!ret)
+		return ret;
+
+	return smp_lvl;
+}
+
+static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
+{
+	struct bm1390_data *data =3D iio_priv(idev);
+	int ret;
+
+	/*
+	 * If fifo_flush is being called from IRQ handler we know the stored time=
stamp
+	 * is fairly accurate for the last stored sample. If we are
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
+	disable_irq(data->irq);
+	data->timestamp =3D iio_get_time_ns(idev);
+
+	mutex_lock(&data->mutex);
+	ret =3D __bm1390_fifo_flush(idev, samples, false);
+	mutex_unlock(&data->mutex);
+
+	enable_irq(data->irq);
+
+	return ret;
+}
+
+static int bm1390_write_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	ret =3D iio_device_claim_direct_mode(idev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	default:
+		ret =3D -EINVAL;
+	}
+	iio_device_release_direct_mode(idev);
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
+static const struct iio_info bm1390_info =3D {
+	.read_raw =3D &bm1390_read_raw,
+	.write_raw =3D &bm1390_write_raw,
+	.validate_trigger =3D iio_validate_own_trigger,
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
+	 * be fixed when IIR is in use
+	 */
+	ret =3D regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
+				 BM1390_MASK_IIR_MODE, BM1390_IIR_MODE_MID);
+
+	return ret;
+}
+
+static int bm1390_fifo_set_wmi(struct bm1390_data *data)
+{
+	u8 regval;
+
+	regval =3D data->watermark - BM1390_WMI_MIN;
+	regval =3D FIELD_PREP(BM1390_MASK_FIFO_LEN, regval);
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
+	mutex_lock(&data->mutex);
+
+	/* Update watermark to HW */
+	ret =3D bm1390_fifo_set_wmi(data);
+	if (ret)
+		goto unlock_out;
+
+	/* Enable WMI_IRQ */
+	ret =3D regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
+				 BM1390_MASK_WMI_EN);
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
+	if (ret)
+		goto unlock_out;
+
+	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
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
+	 * results to the IIO fifo when data-ready triggers.
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
+	int ret, dummy;
+
+	/* DRDY is acked by reading status reg */
+	ret =3D regmap_read(data->regmap, BM1390_REG_STATUS,
+			  &dummy);
+	if (ret || !dummy)
+		return IRQ_NONE;
+
+	dev_dbg(data->dev, "DRDY trig status 0x%x\n", dummy);
+
+	ret =3D bm1390_pressure_read(data, &data->buf.pressure);
+	if (ret) {
+		dev_warn(data->dev, "sample read failed %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	ret =3D regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
+			       &data->buf.temp, BM1390_TEMP_SIZE);
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
+	}
+
+	if (data->state =3D=3D BM1390_STATE_FIFO) {
+		int ok;
+
+		ok =3D __bm1390_fifo_flush(idev, BM1390_TEMP_SIZE, true);
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
+	} else {
+		int dummy;
+
+		ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
+
+		/*
+		 * We need to read the status register in order to ACK the
+		 * data-ready which may have been generated just before we
+		 * disabled the measurement.
+		 */
+		if (!ret)
+			ret =3D regmap_read(data->regmap, BM1390_REG_STATUS,
+					  &dummy);
+	}
+
+	ret =3D bm1390_set_drdy_irq(data, state);
+	if (ret)
+		goto unlock_out;
+
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
+
+}
+
+static const struct iio_trigger_ops bm1390_trigger_ops =3D {
+	.set_trigger_state =3D bm1390_trigger_set_state,
+};
+
+static int bm1390_setup_trigger(struct bm1390_data *data, struct iio_dev *=
idev,
+				int irq)
+{
+	struct iio_trigger *itrig;
+	char *name;
+	int ret;
+
+	if (irq < 0) {
+		dev_warn(data->dev, "No IRQ - skipping buffering\n");
+		return 0;
+	}
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
+	itrig =3D devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", idev->nam=
e,
+					    iio_device_id(idev));
+	if (!itrig)
+		return -ENOMEM;
+
+	data->trig =3D itrig;
+	idev->available_scan_masks =3D bm1390_scan_masks;
+
+	itrig->ops =3D &bm1390_trigger_ops;
+	iio_trigger_set_drvdata(itrig, data);
+
+	/*
+	 * No need to check for NULL. request_threaded_irq() defaults to
+	 * dev_name() should the alloc fail.
+	 */
+	name =3D devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
+			      dev_name(data->dev));
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
+
+	return ret;
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
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	ret =3D devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	data =3D iio_priv(idev);
+
+	ret =3D regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to access sensor\n");
+
+	if (part_id !=3D BM1390_ID)
+		dev_warn(dev, "unknown device 0x%x\n", part_id);
+
+	data->regmap =3D regmap;
+	data->dev =3D dev;
+	data->irq =3D i2c->irq;
+	/*
+	 * Default watermark to WMI_MAX. We could also allow setting WMI to 0,
+	 * and interpret that as "WMI is disabled, use FIFO_FULL" but I've
+	 * no idea what is assumed if watermark is 0. Does it mean each sample
+	 * should trigger IRQ, or no samples should do that?
+	 *
+	 * Well, for now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
+	 * discard every other configuration when triggered mode is not used.
+	 */
+	data->watermark =3D BM1390_WMI_MAX;
+	mutex_init(&data->mutex);
+
+	idev->channels =3D bm1390_channels;
+	idev->num_channels =3D ARRAY_SIZE(bm1390_channels);
+	idev->name =3D "bm1390";
+	idev->info =3D &bm1390_info;
+	idev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+
+	ret =3D bm1390_chip_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "sensor init failed\n");
+
+	ret =3D bm1390_setup_trigger(data, idev, i2c->irq);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_device_register(dev, idev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Unable to register iio device\n");
+
+	return ret;
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

--lFfLBnrnvyuXQCIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmT4cpwACgkQeFA3/03a
ocVg7wgAmO3C0V6jKF+U19ynFyOkrQ+l4uoRxzlSGWtZw3GQdijop0v9nsnSKzKU
G5auzRLKyT8mV1P6oWbtDK/5V3dGv8HcDEaXfoKssxfK9ZQpNUh8HGm8VTTPdoP2
pSV3vu9t5YdyoT/irIe+FA5t8TcHG9D7wYRKVkhSVtsux0gGs+Z8A4tJAxPiDV2n
lzXlfsmU1ZPqDW+pCc2jzovxMthkSNdh7wiiWGvHQL5EuK2GTwmt5zmQMGEBtj1w
D8XI1DNZzYTd7tX3O3uSreTr/rHjOgu9GnslqDhUXigMxtxGM4ogJ4hOQA75apRL
nWDSdqjIsqtjJm7fWzAPu/eMyhA0Iw==
=1el8
-----END PGP SIGNATURE-----

--lFfLBnrnvyuXQCIO--
