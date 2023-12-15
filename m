Return-Path: <linux-kernel+bounces-760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698678145A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20059285381
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937FF24B47;
	Fri, 15 Dec 2023 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fXfm67lP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DE249EF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so392199f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702636332; x=1703241132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNUIgGKeBLNxRtZa/e62xwwjn2LbYij3IIZziGi/+Cs=;
        b=fXfm67lPjf1836o+7z3zuPoa6EUu3NdrzwC6Ty8UuPjrN8A54jd43E9peGszT9zLjv
         2KF/xfCXUUrnTiOnr73VhgE0vdv8PsooT5wvVqZ8ZECHHu6R/NbCX2QzWfVjpU8pJSGW
         L8CgORvrgM63JM/u6LxgJ+2s2GUv0cT+VPG7nTi0ajFxnIFdxkSsCMGfz/8liC3Abeg5
         I4VINI5UbKfoy8sfi4KFYi3AgCsk6Z6nFD/JDjZhvxMIaFgY6kVrundSeKqeM9y9Tvcv
         /Thx6kC2Pk5ovPLH2NdEg2lpnG/7E45NCM2Lw+0qaWAU2WRQVNTxyi6OMkOjRvU9NO2L
         bCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636332; x=1703241132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNUIgGKeBLNxRtZa/e62xwwjn2LbYij3IIZziGi/+Cs=;
        b=Q7yT4w6ld45QP12MiPubemDGhUM3BHe9A7JCdRuWGQ9+lFKK93DsIAI2TxPF4suXFD
         Lz7V04cZoosmN5mSF7jVCGqQ9Hs1GaLPSeCxPv/yf0zq8dFMOk/gsaRIerMna81zZV/a
         F1yMiO49JOVtaaVBfWF1R5DRV2IW8r5N1SEJz7Bnh1dHGQtpnJbX1+GS54kDXCIOrc6I
         dm9NzlG4EaM7eGwwqIIV84drwUiSG08sKe87djkVqCXzEr7vO1pr3FDGQyMgYhIebv3+
         fU0a1vKYlFLdh64mLXJeWt/AZC5INKq0Z7e5jLmzvTAsSQ5EFxkL877OFpzKGhuAe+HF
         h0XQ==
X-Gm-Message-State: AOJu0YwS0vd873R6ng7RivHA3jR+NHEFGC/jTfoS5vF62n4ICMfR2ss1
	Q3/j8Koci7oGvRoiDnERMi9VDA==
X-Google-Smtp-Source: AGHT+IFeLk1CnSx2XUPLfPx2pcI54txed0kAOP+Eqa42CkBqPcmuy7REMQGvvG1qqQUTnteXdhO+OA==
X-Received: by 2002:adf:e28e:0:b0:334:b3d0:c300 with SMTP id v14-20020adfe28e000000b00334b3d0c300mr6228671wri.32.1702636332422;
        Fri, 15 Dec 2023 02:32:12 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id q11-20020adffecb000000b003332db7d91dsm18421015wrs.39.2023.12.15.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:32:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v3 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
Date: Fri, 15 Dec 2023 04:32:04 -0600
Message-Id: <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new driver for the AD7380 family ADCs.

The driver currently implements basic support for the AD7380, AD7381,
AD7383, and AD7384 2-channel differential ADCs. Support for additional
single-ended and 4-channel chips that use the same register map as well
as additional features of the chip will be added in future patches.

Co-developed-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  16 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7380.c | 462 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 480 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a998be5879..5a54620a31b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -438,6 +438,7 @@ S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+F:	drivers/iio/adc/ad7380.c
 
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 35f9867da12c..cbfd626712e3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -122,6 +122,22 @@ config AD7298
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7298.
 
+config AD7380
+	tristate "Analog Devices AD7380 ADC driver"
+	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  AD7380 is a family of simultaneous sampling ADCs that share the same
+	  SPI register map and have similar pinouts.
+
+	  Say yes here to build support for Analog Devices AD7380 ADC and
+	  similar chips.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7380.
+
 config AD7476
 	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index bee11d442af4..9c921c497655 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
+obj-$(CONFIG_AD7380) += ad7380.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
new file mode 100644
index 000000000000..80712aaa9548
--- /dev/null
+++ b/drivers/iio/adc/ad7380.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD738x Simultaneous Sampling SAR ADCs
+ *
+ * Copyright 2017 Analog Devices Inc.
+ * Copyright 2023 BayLibre, SAS
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* 2.5V internal reference voltage */
+#define AD7380_INTERNAL_REF_MV		2500
+
+/* reading and writing registers is more reliable at lower than max speed */
+#define AD7380_REG_WR_SPEED_HZ		10000000
+
+#define AD7380_REG_WR			BIT(15)
+#define AD7380_REG_REGADDR		GENMASK(14, 12)
+#define AD7380_REG_DATA			GENMASK(11, 0)
+
+#define AD7380_REG_ADDR_NOP		0x0
+#define AD7380_REG_ADDR_CONFIG1		0x1
+#define AD7380_REG_ADDR_CONFIG2		0x2
+#define AD7380_REG_ADDR_ALERT		0x3
+#define AD7380_REG_ADDR_ALERT_LOW_TH	0x4
+#define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
+
+#define AD7380_CONFIG1_OS_MODE		BIT(9)
+#define AD7380_CONFIG1_OSR		GENMASK(8, 6)
+#define AD7380_CONFIG1_CRC_W		BIT(5)
+#define AD7380_CONFIG1_CRC_R		BIT(4)
+#define AD7380_CONFIG1_ALERTEN		BIT(3)
+#define AD7380_CONFIG1_RES		BIT(2)
+#define AD7380_CONFIG1_REFSEL		BIT(1)
+#define AD7380_CONFIG1_PMODE		BIT(0)
+
+#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
+#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_RESET		GENMASK(7, 0)
+
+#define AD7380_CONFIG2_RESET_SOFT	0x3C
+#define AD7380_CONFIG2_RESET_HARD	0xFF
+
+#define AD7380_ALERT_LOW_TH		GENMASK(11, 0)
+#define AD7380_ALERT_HIGH_TH		GENMASK(11, 0)
+
+struct ad7380_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+#define AD7380_DIFFERENTIAL_CHANNEL(index, bits) {		\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.indexed = 1,						\
+	.differential = 1,					\
+	.channel = 2 * (index),					\
+	.channel2 = 2 * (index) + 1,				\
+	.scan_index = (index),					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+#define DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(name, bits)	\
+static const struct iio_chan_spec name[] = {			\
+	AD7380_DIFFERENTIAL_CHANNEL(0, bits),			\
+	AD7380_DIFFERENTIAL_CHANNEL(1, bits),			\
+	IIO_CHAN_SOFT_TIMESTAMP(2),				\
+}
+
+/* fully differential */
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
+/* pseudo differential */
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
+DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
+
+/* Since this is simultaneous sampling, we don't allow individual channels. */
+static const unsigned long ad7380_2_channel_scan_masks[] = {
+	GENMASK(1, 0),
+	0
+};
+
+static const struct ad7380_chip_info ad7380_chip_info = {
+	.name = "ad7380",
+	.channels = ad7380_channels,
+	.num_channels = ARRAY_SIZE(ad7380_channels),
+};
+
+static const struct ad7380_chip_info ad7381_chip_info = {
+	.name = "ad7381",
+	.channels = ad7381_channels,
+	.num_channels = ARRAY_SIZE(ad7381_channels),
+};
+
+static const struct ad7380_chip_info ad7383_chip_info = {
+	.name = "ad7383",
+	.channels = ad7383_channels,
+	.num_channels = ARRAY_SIZE(ad7383_channels),
+};
+
+static const struct ad7380_chip_info ad7384_chip_info = {
+	.name = "ad7384",
+	.channels = ad7384_channels,
+	.num_channels = ARRAY_SIZE(ad7384_channels),
+};
+
+struct ad7380_state {
+	const struct ad7380_chip_info *chip_info;
+	struct spi_device *spi;
+	struct regulator *vref;
+	struct regmap *regmap;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
+	 * aligned 64 bit timestamp.
+	 */
+	struct {
+		u16 raw[2];
+		s64 ts __aligned(8);
+	} scan_data __aligned(IIO_DMA_MINALIGN);
+	u16 tx[2];
+	u16 rx[2];
+};
+
+static int ad7380_regmap_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfer = {
+		.speed_hz = AD7380_REG_WR_SPEED_HZ,
+		.bits_per_word = 16,
+		.len = 2,
+		.tx_buf = &st->tx[0],
+	};
+
+	st->tx[0] = FIELD_PREP(AD7380_REG_WR, 1) |
+		    FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		    FIELD_PREP(AD7380_REG_DATA, val);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad7380_regmap_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.tx_buf = &st->tx[0],
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		}, {
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.rx_buf = &st->rx[0],
+		},
+	};
+	int ret;
+
+	st->tx[0] = FIELD_PREP(AD7380_REG_WR, 0) |
+		    FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		    FIELD_PREP(AD7380_REG_DATA, 0);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_GET(AD7380_REG_DATA, st->rx[0]);
+
+	return 0;
+}
+
+const struct regmap_config ad7380_regmap_config = {
+	.reg_bits = 3,
+	.val_bits = 12,
+	.reg_read = ad7380_regmap_reg_read,
+	.reg_write = ad7380_regmap_reg_write,
+	.max_register = AD7380_REG_ADDR_ALERT_HIGH_TH,
+	.can_sleep = true,
+};
+
+static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
+				     u32 writeval, u32 *readval)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static irqreturn_t ad7380_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
+		.len = 4,
+		.rx_buf = st->scan_data.raw,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
+					   pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ad7380_read_direct(struct ad7380_state *st,
+			      struct iio_chan_spec const *chan, int *val)
+{
+	struct spi_transfer xfers[] = {
+		/* toggle CS (no data xfer) to trigger a conversion */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.delay = {
+				.value = 190, /* t[CONVERT] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		},
+		/* then read both channels */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.rx_buf = &st->rx[0],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(st->rx[chan->scan_index],
+			     chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad7380_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_read_direct(st, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		if (st->vref) {
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				return ret;
+
+			*val = ret / 1000;
+		} else {
+			*val = AD7380_INTERNAL_REF_MV;
+		}
+
+		*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info ad7380_info = {
+	.read_raw = &ad7380_read_raw,
+	.debugfs_reg_access = &ad7380_debugfs_reg_access,
+};
+
+static int ad7380_init(struct ad7380_state *st)
+{
+	int ret;
+
+	/* perform hard reset */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				 AD7380_CONFIG2_RESET,
+				 FIELD_PREP(AD7380_CONFIG2_RESET,
+					    AD7380_CONFIG2_RESET_HARD));
+	if (ret < 0)
+		return ret;
+
+	/* select internal or external reference voltage */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_REFSEL,
+				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
+	if (ret < 0)
+		return ret;
+
+	/* SPI 1-wire mode */
+	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				  AD7380_CONFIG2_SDO,
+				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
+}
+
+static void ad7380_regulator_disable(void *p)
+{
+	regulator_disable(p);
+}
+
+static int ad7380_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad7380_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
+
+	st->vref = devm_regulator_get_optional(&spi->dev, "refio");
+	if (IS_ERR(st->vref)) {
+		/*
+		 * If there is no REFIO supply, then it means that we are using
+		 * the internal 2.5V reference.
+		 */
+		if (PTR_ERR(st->vref) == -ENODEV)
+			st->vref = NULL;
+		else
+			return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
+					     "Failed to get refio regulator\n");
+	}
+
+	if (st->vref) {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7380_regulator_disable,
+					       st->vref);
+		if (ret)
+			return ret;
+	}
+
+	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "failed to allocate register map\n");
+
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7380_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad7380_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = ad7380_init(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad7380_of_match_table[] = {
+	{ .compatible = "adi,ad7380", .data = &ad7380_chip_info },
+	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
+	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
+	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
+	{ }
+};
+
+static const struct spi_device_id ad7380_id_table[] = {
+	{ "ad7380", (kernel_ulong_t)&ad7380_chip_info },
+	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
+	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
+	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7380_id_table);
+
+static struct spi_driver ad7380_driver = {
+	.driver = {
+		.name = "ad7380",
+		.of_match_table = ad7380_of_match_table,
+	},
+	.probe = ad7380_probe,
+	.id_table = ad7380_id_table,
+};
+module_spi_driver(ad7380_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD738x ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


