Return-Path: <linux-kernel+bounces-135523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551E89C725
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA7F2827FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931313E402;
	Mon,  8 Apr 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EqXcrpKb"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900CA13E047;
	Mon,  8 Apr 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586740; cv=none; b=TVGo59rhqPu1+obEJreUo2S65ds575jGZyA3RtPJEPd03E3FujEDQWwo+3BwCpo3GIAgCvNSFse5zo+/0mWiM6eqdHPHPoAytlSCP1a6OJ3oUDW4wesxOg/VYpsc5J9yCt7RAia98BmN4baYVV6gZuyaDkjI4DQrkRglq4w8QDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586740; c=relaxed/simple;
	bh=gANt+aDkOXYJZN6TyWWXhvJJdnuFKSYIrZujqW36bl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YC08bZxgYE3GwXYJESpqoJyLF5vLosw+pKcHd5EbsTf1zeTPBrrpRqHHCnCDRr7QU6w4WDOGEPZmYj4FRXllyDOPMStoY2YeBZp+DTEiobCv2SFh7AgM2x9IAxq/gUIBjSPYMoqH770uwLENPW/Jt2XwhMgafOz+jjCh93dpx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EqXcrpKb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438CNDbA009606;
	Mon, 8 Apr 2024 10:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=JgxS57RVMvrhl5zUzvtX68b04gMHMmKJ2jBpUOVEEEQ=; b=EqXcrpKbCdaY
	Rnla9x5xS/kmrPm7M2C4aDeYLup4vOeTEkgtnUS7tsc8avt3lrPnK/Kq5pTXVTR3
	hB45w6Rsl//Hy8DrIyPz6jGaJucz/Pq0T3qPgwgP194uKaer7E4y7a3uDSqJ647f
	PW/MSdcbwTrO6K/UPsh20/N/nqnV0w7XRlJZFkO89QWTOiihjTngj7MvCvM8OJoG
	Vd9Q2aHGVnz3shlVWycEJHFZDGL8lz7dG9wwQKGwUsr+NCuzO4bWtj1NyAeNhqac
	9zQsnnCYj6Q8zIjUI5CMhJ31rZ/1/96NGfmIIa0BPvlAjZpnTZwMgbpT7cvnaaf9
	Gnv0L0+9yA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xbk7mvxbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:32:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 438EW0iZ010509
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 10:32:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Apr 2024 10:31:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Apr 2024 10:31:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 Apr 2024 10:31:59 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 438EVjhB017949;
	Mon, 8 Apr 2024 10:31:47 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: Add support for AD4000
Date: Mon, 8 Apr 2024 11:31:42 -0300
Message-ID: <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1712585500.git.marcelo.schmitt@analog.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0bqogMS_yxJjr5YgUB2uc3TDdaSFtQj8
X-Proofpoint-ORIG-GUID: 0bqogMS_yxJjr5YgUB2uc3TDdaSFtQj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080111

Add support for AD4000 family of low noise, low power, high speed,
successive aproximation register (SAR) ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  12 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4000.c | 649 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 663 insertions(+)
 create mode 100644 drivers/iio/adc/ad4000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dfe118a5dd3..86aa96115f5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1165,6 +1165,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+F:	drivers/iio/adc/ad4000.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..9c9d13d4b74f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD4000
+	tristate "Analog Devices AD4000 ADC Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD4000 high speed
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4000.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index edb32ce2af02..aa52068d864b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
new file mode 100644
index 000000000000..7997d9d98743
--- /dev/null
+++ b/drivers/iio/adc/ad4000.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD4000 SPI ADC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+#include <asm/unaligned.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+#include <linux/util_macros.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define AD400X_READ_COMMAND	0x54
+#define AD400X_WRITE_COMMAND	0x14
+
+/* AD4000 Configuration Register programmable bits */
+#define AD4000_STATUS		BIT(4) /* Status bits output */
+#define AD4000_SPAN_COMP	BIT(3) /* Input span compression  */
+#define AD4000_HIGHZ		BIT(2) /* High impedance mode  */
+#define AD4000_TURBO		BIT(1) /* Turbo mode */
+
+#define AD4000_TQUIET2_NS		60
+
+#define AD4000_18BIT_MSK	GENMASK(31, 14)
+#define AD4000_20BIT_MSK	GENMASK(31, 12)
+
+#define AD4000_DIFF_CHANNEL(_sign, _real_bits)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.differential = 1,					\
+		.channel = 0,						\
+		.channel2 = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),\
+		.scan_type = {						\
+			.sign = _sign,					\
+			.realbits = _real_bits,				\
+			.storagebits = _real_bits > 16 ? 32 : 16,	\
+			.shift = _real_bits > 16 ? 32 - _real_bits : 0,	\
+			.endianness = IIO_BE,				\
+		},							\
+	}								\
+
+#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits)			\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = 0,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_SCALE) |	\
+				      BIT(IIO_CHAN_INFO_OFFSET),	\
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),\
+		.scan_type = {						\
+			.sign = _sign,					\
+			.realbits = _real_bits,				\
+			.storagebits = _real_bits > 16 ? 32 : 16,	\
+			.shift = _real_bits > 16 ? 32 - _real_bits : 0,	\
+			.endianness = IIO_BE,				\
+		},							\
+	}								\
+
+enum ad4000_ids {
+	ID_AD4000,
+	ID_AD4001,
+	ID_AD4002,
+	ID_AD4003,
+	ID_AD4004,
+	ID_AD4005,
+	ID_AD4006,
+	ID_AD4007,
+	ID_AD4008,
+	ID_AD4010,
+	ID_AD4011,
+	ID_AD4020,
+	ID_AD4021,
+	ID_AD4022,
+	ID_ADAQ4001,
+	ID_ADAQ4003,
+};
+
+struct ad4000_chip_info {
+	const char *dev_name;
+	struct iio_chan_spec chan_spec;
+};
+
+static const struct ad4000_chip_info ad4000_chips[] = {
+	[ID_AD4000] = {
+		.dev_name = "ad4000",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
+	},
+	[ID_AD4001] = {
+		.dev_name = "ad4001",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 16),
+	},
+	[ID_AD4002] = {
+		.dev_name = "ad4002",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
+	},
+	[ID_AD4003] = {
+		.dev_name = "ad4003",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 18),
+	},
+	[ID_AD4004] = {
+		.dev_name = "ad4004",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
+	},
+	[ID_AD4005] = {
+		.dev_name = "ad4005",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 16),
+	},
+	[ID_AD4006] = {
+		.dev_name = "ad4006",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
+	},
+	[ID_AD4007] = {
+		.dev_name = "ad4007",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 18),
+	},
+	[ID_AD4008] = {
+		.dev_name = "ad4008",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
+	},
+	[ID_AD4010] = {
+		.dev_name = "ad4010",
+		.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
+	},
+	[ID_AD4011] = {
+		.dev_name = "ad4011",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 18),
+	},
+	[ID_AD4020] = {
+		.dev_name = "ad4020",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 20),
+	},
+	[ID_AD4021] = {
+		.dev_name = "ad4021",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 20),
+	},
+	[ID_AD4022] = {
+		.dev_name = "ad4022",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 20),
+	},
+	[ID_ADAQ4001] = {
+		.dev_name = "adaq4001",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 16),
+	},
+	[ID_ADAQ4003] = {
+		.dev_name = "adaq4003",
+		.chan_spec = AD4000_DIFF_CHANNEL('s', 18),
+	},
+};
+
+enum ad4000_gains {
+	AD4000_0454_GAIN = 0,
+	AD4000_0909_GAIN = 1,
+	AD4000_1_GAIN = 2,
+	AD4000_1900_GAIN = 3,
+	AD4000_GAIN_LEN
+};
+
+/*
+ * Gains stored and computed as fractions to avoid introducing rounding errors.
+ */
+static const int ad4000_gains_frac[AD4000_GAIN_LEN][2] = {
+	[AD4000_0454_GAIN] = { 227, 500 },
+	[AD4000_0909_GAIN] = { 909, 1000 },
+	[AD4000_1_GAIN] = { 1, 1 },
+	[AD4000_1900_GAIN] = { 19, 10 },
+};
+
+struct ad4000_state {
+	struct spi_device *spi;
+	struct gpio_desc *cnv_gpio;
+	int vref;
+	bool status_bits;
+	bool span_comp;
+	bool turbo_mode;
+	bool high_z_mode;
+
+	enum ad4000_gains pin_gain;
+	int scale_tbl[AD4000_GAIN_LEN][2][2];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	struct {
+		union {
+			u16 sample_buf16;
+			u32 sample_buf32;
+		} data;
+		s64 timestamp __aligned(8);
+	} scan;
+	__be16 tx_buf __aligned(IIO_DMA_MINALIGN);
+	__be16 rx_buf;
+};
+
+static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bits,
+				  const struct ad4000_chip_info *chip)
+{
+	int diff = chip->chan_spec.differential;
+	int val, val2, tmp0, tmp1, i;
+	u64 tmp2;
+
+	val2 = scale_bits;
+	for (i = 0; i < AD4000_GAIN_LEN; i++) {
+		val = st->vref / 1000;
+		/* Multiply by MILLI here to avoid losing precision */
+		val = mult_frac(val, ad4000_gains_frac[i][1] * MILLI,
+				ad4000_gains_frac[i][0]);
+		/* Would multiply by NANO here but we already multiplied by MILLI */
+		tmp2 = shift_right((u64)val * MICRO, val2);
+		tmp0 = (int)div_s64_rem(tmp2, NANO, &tmp1);
+		/* Store scale for when span compression is disabled */
+		st->scale_tbl[i][0][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][0][1] = abs(tmp1); /* Fractional part */
+		/* Store scale for when span compression is enabled */
+		st->scale_tbl[i][1][0] = tmp0;
+		if (diff)
+			st->scale_tbl[i][1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
+		else
+			st->scale_tbl[i][1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
+	}
+}
+
+static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
+{
+	put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val,
+			   &st->tx_buf);
+	return spi_write(st->spi, &st->tx_buf, 2);
+}
+
+static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.rx_buf = &st->rx_buf,
+			.len = 2,
+		},
+	};
+	int ret;
+
+	put_unaligned_be16(AD400X_READ_COMMAND << BITS_PER_BYTE, &st->tx_buf);
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	*val = get_unaligned_be16(&st->rx_buf);
+
+	return ret;
+}
+
+static int ad4000_read_sample(struct ad4000_state *st,
+			      const struct iio_chan_spec *chan)
+{
+	struct spi_transfer t[] = {
+		{
+			.rx_buf = &st->scan.data,
+			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
+			.delay = {
+				.value = AD4000_TQUIET2_NS,
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		},
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ad4000_single_conversion(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	u32 sample;
+	int ret;
+
+	if (st->cnv_gpio)
+		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);
+
+	ret = ad4000_read_sample(st, chan);
+	if (ret)
+		return ret;
+
+	if (st->cnv_gpio)
+		gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
+
+	if (chan->scan_type.storagebits > 16)
+		sample = get_unaligned_be32(&st->scan.data);
+	else
+		sample = get_unaligned_be16(&st->scan.data);
+
+	switch (chan->scan_type.realbits) {
+	case 16:
+		break;
+	case 18:
+		sample = FIELD_GET(AD4000_18BIT_MSK, sample);
+		break;
+	case 20:
+		sample = FIELD_GET(AD4000_20BIT_MSK, sample);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad4000_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ad4000_single_conversion(indio_dev, chan, val);
+		unreachable();
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->scale_tbl[st->pin_gain][st->span_comp][0];
+		*val2 = st->scale_tbl[st->pin_gain][st->span_comp][1];
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		if (st->span_comp)
+			*val = mult_frac(st->vref / 1000, 1, 10);
+
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int ad4000_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_tbl[st->pin_gain];
+		*length = 2 * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
+}
+
+static int ad4000_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	bool span_comp_en;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ad4000_read_reg(st, &reg_val);
+			if (ret < 0)
+				return ret;
+
+			span_comp_en = (val2 == st->scale_tbl[st->pin_gain][1][1]);
+			reg_val &= ~AD4000_SPAN_COMP;
+			reg_val |= FIELD_PREP(AD4000_SPAN_COMP, span_comp_en);
+
+			ret = ad4000_write_reg(st, reg_val);
+			if (ret < 0)
+				return ret;
+
+			st->span_comp = span_comp_en;
+			return 0;
+		}
+		unreachable();
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static irqreturn_t ad4000_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4000_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->cnv_gpio)
+		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
+
+	ret = ad4000_read_sample(st, &indio_dev->channels[0]);
+	if (ret < 0)
+		goto err_out;
+
+	if (st->cnv_gpio)
+		gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
+					   iio_get_time_ns(indio_dev));
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ad4000_info = {
+	.read_raw = &ad4000_read_raw,
+	.read_avail = &ad4000_read_avail,
+	.write_raw = &ad4000_write_raw,
+	.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
+};
+
+static void ad4000_config(struct ad4000_state *st)
+{
+	unsigned int reg_val;
+	int ret;
+
+	reg_val = FIELD_PREP(AD4000_TURBO, 1);
+
+	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
+		reg_val |= FIELD_PREP(AD4000_HIGHZ, 1);
+
+	/*
+	 * The ADC SDI pin might be connected to controller CS line in which
+	 * case the write might fail. This, however, does not prevent the device
+	 * from functioning even though in a configuration other than the
+	 * requested one.
+	 */
+	ret = ad4000_write_reg(st, reg_val);
+	if (ret < 0)
+		dev_dbg(&st->spi->dev, "Failed to config device\n");
+}
+
+static void ad4000_regulator_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static int ad4000_probe(struct spi_device *spi)
+{
+	const struct ad4000_chip_info *chip;
+	struct regulator *vref_reg;
+	struct iio_dev *indio_dev;
+	struct ad4000_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = spi_get_device_match_data(spi);
+	if (!chip)
+		return -EINVAL;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to enable VDD supply\n");
+
+	ret = devm_regulator_get_enable(&spi->dev, "vio");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to enable VIO supply\n");
+
+	vref_reg = devm_regulator_get(&spi->dev, "ref");
+	if (IS_ERR(vref_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
+				     "Failed to get vref regulator\n");
+
+	ret = regulator_enable(vref_reg);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to enable voltage regulator\n");
+
+	ret = devm_add_action_or_reset(&spi->dev, ad4000_regulator_disable, vref_reg);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to add regulator disable action\n");
+
+	st->vref = regulator_get_voltage(vref_reg);
+	if (st->vref < 0)
+		return dev_err_probe(&spi->dev, st->vref, "Failed to get vref\n");
+
+	st->cnv_gpio = devm_gpiod_get_optional(&spi->dev, "cnv", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->cnv_gpio)) {
+		if (PTR_ERR(st->cnv_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
+				     "Failed to get CNV GPIO");
+	}
+
+	ad4000_config(st);
+
+	indio_dev->name = chip->dev_name;
+	indio_dev->info = &ad4000_info;
+	indio_dev->channels = &chip->chan_spec;
+	indio_dev->num_channels = 1;
+
+	st->pin_gain = AD4000_1_GAIN;
+	if (device_property_present(&spi->dev, "adi,gain-milli")) {
+		u32 val;
+
+		ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
+		if (ret)
+			return ret;
+
+		switch (val) {
+		case 454:
+			st->pin_gain = AD4000_0454_GAIN;
+			break;
+		case 909:
+			st->pin_gain = AD4000_0909_GAIN;
+			break;
+		case 1000:
+			st->pin_gain = AD4000_1_GAIN;
+			break;
+		case 1900:
+			st->pin_gain = AD4000_1900_GAIN;
+			break;
+		default:
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid firmware provided gain\n");
+		}
+	}
+
+	/*
+	 * ADCs that output twos complement code have one less bit to express
+	 * voltage magnitude.
+	 */
+	if (chip->chan_spec.scan_type.sign == 's')
+		ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits - 1,
+				      chip);
+	else
+		ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realbits,
+				      chip);
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad4000_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad4000_id[] = {
+	{ "ad4000", (kernel_ulong_t)&ad4000_chips[ID_AD4000] },
+	{ "ad4001", (kernel_ulong_t)&ad4000_chips[ID_AD4001] },
+	{ "ad4002", (kernel_ulong_t)&ad4000_chips[ID_AD4002] },
+	{ "ad4003", (kernel_ulong_t)&ad4000_chips[ID_AD4003] },
+	{ "ad4004", (kernel_ulong_t)&ad4000_chips[ID_AD4004] },
+	{ "ad4005", (kernel_ulong_t)&ad4000_chips[ID_AD4005] },
+	{ "ad4006", (kernel_ulong_t)&ad4000_chips[ID_AD4006] },
+	{ "ad4007", (kernel_ulong_t)&ad4000_chips[ID_AD4007] },
+	{ "ad4008", (kernel_ulong_t)&ad4000_chips[ID_AD4008] },
+	{ "ad4010", (kernel_ulong_t)&ad4000_chips[ID_AD4010] },
+	{ "ad4011", (kernel_ulong_t)&ad4000_chips[ID_AD4011] },
+	{ "ad4020", (kernel_ulong_t)&ad4000_chips[ID_AD4020] },
+	{ "ad4021", (kernel_ulong_t)&ad4000_chips[ID_AD4021] },
+	{ "ad4022", (kernel_ulong_t)&ad4000_chips[ID_AD4022] },
+	{ "adaq4001", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4001] },
+	{ "adaq4003", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4003] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4000_id);
+
+static const struct of_device_id ad4000_of_match[] = {
+	{ .compatible = "adi,ad4000", .data = &ad4000_chips[ID_AD4000] },
+	{ .compatible = "adi,ad4001", .data = &ad4000_chips[ID_AD4001] },
+	{ .compatible = "adi,ad4002", .data = &ad4000_chips[ID_AD4002] },
+	{ .compatible = "adi,ad4003", .data = &ad4000_chips[ID_AD4003] },
+	{ .compatible = "adi,ad4004", .data = &ad4000_chips[ID_AD4004] },
+	{ .compatible = "adi,ad4005", .data = &ad4000_chips[ID_AD4005] },
+	{ .compatible = "adi,ad4006", .data = &ad4000_chips[ID_AD4006] },
+	{ .compatible = "adi,ad4007", .data = &ad4000_chips[ID_AD4007] },
+	{ .compatible = "adi,ad4008", .data = &ad4000_chips[ID_AD4008] },
+	{ .compatible = "adi,ad4010", .data = &ad4000_chips[ID_AD4010] },
+	{ .compatible = "adi,ad4011", .data = &ad4000_chips[ID_AD4011] },
+	{ .compatible = "adi,ad4020", .data = &ad4000_chips[ID_AD4020] },
+	{ .compatible = "adi,ad4021", .data = &ad4000_chips[ID_AD4021] },
+	{ .compatible = "adi,ad4022", .data = &ad4000_chips[ID_AD4022] },
+	{ .compatible = "adi,adaq4001", .data = &ad4000_chips[ID_ADAQ4001] },
+	{ .compatible = "adi,adaq4003", .data = &ad4000_chips[ID_ADAQ4003] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4000_of_match);
+
+static struct spi_driver ad4000_driver = {
+	.driver = {
+		.name   = "ad4000",
+		.of_match_table = ad4000_of_match,
+	},
+	.probe          = ad4000_probe,
+	.id_table       = ad4000_id,
+};
+module_spi_driver(ad4000_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


