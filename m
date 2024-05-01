Return-Path: <linux-kernel+bounces-165406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A08B8C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0441F222E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8B131183;
	Wed,  1 May 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GpHwOJ+8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA912130A65
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575364; cv=none; b=GK6gbA8TA0OVKqZctyo4pAaSPdX7mEq+IAfW6z47V2gwmiicvt7EZRW7Hf+/pMiLlMW74+95qHD/lcl6D4/ymBA7OPcVaOlRKg1LAxlJvhjH4dqdrtn3x+ReLv8sdexl8LysEnb00p4uV1GA7tzh2CkNiS8ZXvEU7Y90AbTsVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575364; c=relaxed/simple;
	bh=fPiWODpLyIpk8mbW8S6s/JMkotwnMO8eXB66C821A4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmXXh4Yg+ccMNZXef8rcWDWglAZY6nxr51hKp9uc2hEZAKPs/8LsgEYb9p6RD+AWDAmTDUDofnD0q0UNRY4IUB3FsQ3ljdxmh52kjnfs99OpezXu1TVe2WQpOloFnkFWzZUMFtVHvKJ0l6ceVk9hzN0kSBGZvd74or3FP0ACCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GpHwOJ+8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so37516695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575360; x=1715180160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQvEn6eTVpgZ7ge0YdIc6SxCVLT/jwgprRg33qL4bbM=;
        b=GpHwOJ+8ic/QRgOaFULe4pEsyJRBTLRHzpL6+HJs/LuHH6LX6a39AupxOfj6HFlacS
         meenSSYKKw6LCQzhwcmdYvKbMGvZAjWwLsartU9ndvsHxjoVaaaCFQ5kprmiDnP2qyWv
         lXlJJFeiMSM4WsCZKL4/QqBbgKooTRat1Xximzm2VCSxEo/byGSxFDEJO3RKYtRxXylr
         d5IVpzQcDSdYLOrzWvMkP/P/7jrfcktOg/8UsdUm8Q0/7q478KOEPp3pz0L0njXlKLXt
         pkF9ksHPl3Q0DMspWaOzXMXhA2E30oy7AnhCnOkUj78y31PXKClW0TJLfMqjccYx+iRP
         bG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575360; x=1715180160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQvEn6eTVpgZ7ge0YdIc6SxCVLT/jwgprRg33qL4bbM=;
        b=aGY+iAukhAsLMl3ABQd3VYQKsFFsxYo5AXQdyL0SHSTpn2gk8c6SJCZZSa3kbiU2Pz
         kx77DJKPP9ioX+uhv4emc5PAtwiTJK08X29/OvNp2hWgikY0bww24gy/GEYmxSkhaUdR
         zfPxq0TcDQLCRI4ba8dlrKop0nojDNHJ0U2RNk+baQh2750AidCL7RkGRo1UpK5/Nsk3
         Ro35CmSRJfV+hhuOYlBpfoLUrIlDC3nS183Hilaj5+dj71s7S3I8mBhwbkK0hrTWM2C0
         bCyTJfYskTEIJbk2izrpUUvvgR1a3bbJahIMsEo5RF6BYzOTsseQcXGXQCOwQs3XojR6
         5Zww==
X-Forwarded-Encrypted: i=1; AJvYcCU6XIQG1TWlazMJL6vQXiHPeJ7XgRBUhu7W8+CBTVDbd4HJgtPI4I6OPJiE5sWCWdL5tbS+sMgaC5NKtHWmb3v+iVKsaVcvveRqn4Fz
X-Gm-Message-State: AOJu0YxQW4HCGO0uASOi3dia51GPFveQw9povZKqlWjTpPvoKDW+cHQC
	NPfL/mNH/Zpfa7m8OQj6/b768m8dePlEm1a0zV/cWgLeNKTH2x3ojloxGhk+oIo=
X-Google-Smtp-Source: AGHT+IFPiOA5OgO2LcEiOeQ9z95Elxo3H/VFN/MqqHOCNEN/VLCkZAllpFjJjc9lb1KKraoJW4trZQ==
X-Received: by 2002:a05:600c:3148:b0:416:536b:683a with SMTP id h8-20020a05600c314800b00416536b683amr1823734wmo.32.1714575360127;
        Wed, 01 May 2024 07:56:00 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:43 +0200
Subject: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for resolution
 boost
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

ad738x chips are able to use an additional 2 bits of resolution when
using oversampling. The 14-bits chips can have up to 16 bits of
resolution and the 16-bits chips can have up to 18 bits of resolution.

In order to dynamically allow to enable/disable the resolution boost
feature, we have to set iio realbits/storagebits to the maximum per chips.
This means that for iio, data will always be on the higher resolution
available, and to cope with that we adjust the iio scale and iio offset
depending on the resolution boost status.

The available scales can be displayed using the regular _scale_available
attributes and can be set by writing the regular _scale attribute.
The available scales depend on the oversampling status.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>

---

In order to support the resolution boost (additional 2 bits of resolution)
we need to set realbits/storagebits to the maximum value i.e :
  - realbits = 16 + 2 = 18, and storagebits = 32 for 16-bits chips
  - realbits = 14 + 2 = 16, and storagebits = 16 for 14-bits chips

For 14-bits chips this does not have a major impact, but this
has the drawback of forcing 16-bits chip users to always use 32-bits
words in buffers even if they are not using oversampling and resolution
boost. Is there a better way of implementing this? For example
implementing dynamic scan_type?

Another issue is the location of the timestamps. I understood the need
for ts to be consistent between chips, but right now I do not have a
better solution.. I was thinking of maybe adding the timestamps at the
beginning? That would imply to change the iio_chan_spec struct and maybe
add a iio_push_to_buffers_with_timestamp_first() wrapper function? Is
that an option?

Any suggestion would be very much appreciated.
---
 drivers/iio/adc/ad7380.c | 226 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 194 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 7b021bb9cf87..e240098708e9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/units.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -58,6 +59,8 @@
 #define AD7380_CONFIG1_CRC_R		BIT(4)
 #define AD7380_CONFIG1_ALERTEN		BIT(3)
 #define AD7380_CONFIG1_RES		BIT(2)
+#define RESOLUTION_BOOST_DISABLE	0
+#define RESOLUTION_BOOST_ENABLE		1
 #define AD7380_CONFIG1_REFSEL		BIT(1)
 #define AD7380_CONFIG1_PMODE		BIT(0)
 
@@ -86,6 +89,14 @@ struct ad7380_chip_info {
 	const struct ad7380_timing_specs *timing_specs;
 };
 
+/*
+ * realbits/storagebits cannot be dynamically changed, so in order to
+ * support the resolution boost (additional 2  bits of resolution)
+ * we need to set realbits/storagebits to the maximum value i.e :
+ *   - realbits = 16 + 2 = 18, and storagebits = 32 for 16-bits chips
+ *   - realbits = 14 + 2 = 16, and storagebits = 16 for 14-bits chips
+ * We need to adjust the scale depending on resolution boost status
+ */
 #define AD7380_CHANNEL(index, bits, diff) {			\
 	.type = IIO_VOLTAGE,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
@@ -93,6 +104,7 @@ struct ad7380_chip_info {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.indexed = 1,						\
 	.differential = (diff),					\
@@ -101,8 +113,8 @@ struct ad7380_chip_info {
 	.scan_index = (index),					\
 	.scan_type = {						\
 		.sign = 's',					\
-		.realbits = (bits),				\
-		.storagebits = 16,				\
+		.realbits = (bits) + 2,				\
+		.storagebits = ((bits) + 2 > 16) ? 32 : 16,	\
 		.endianness = IIO_CPU,				\
 	},							\
 }
@@ -259,6 +271,8 @@ struct ad7380_state {
 	struct spi_device *spi;
 	unsigned int oversampling_mode;
 	unsigned int oversampling_ratio;
+	unsigned int scales[2][2];
+	bool resolution_boost_enable;
 	struct regmap *regmap;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
@@ -270,7 +284,10 @@ struct ad7380_state {
 	 * As MAX_NUM_CHANNELS is 4 the layout of the structure is the same for all parts
 	 */
 	struct {
-		u16 raw[MAX_NUM_CHANNELS];
+		union {
+			u16 u16[MAX_NUM_CHANNELS];
+			u32 u32[MAX_NUM_CHANNELS];
+		} raw;
 
 		s64 ts __aligned(8);
 	} scan_data __aligned(IIO_DMA_MINALIGN);
@@ -359,23 +376,67 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	unreachable();
 }
 
+static int ad7380_prepare_spi_xfer(struct ad7380_state *st, struct spi_transfer *xfer)
+{
+	int bits_per_word;
+
+	memset(xfer, 0, sizeof(*xfer));
+
+	xfer->rx_buf = &st->scan_data.raw;
+
+	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
+		bits_per_word = st->chip_info->channels[0].scan_type.realbits;
+	else
+		bits_per_word = st->chip_info->channels[0].scan_type.realbits - 2;
+
+	xfer->bits_per_word = bits_per_word;
+
+	xfer->len = (st->chip_info->num_channels - 1) * BITS_TO_BYTES(bits_per_word);
+
+	return bits_per_word;
+}
+
 static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7380_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
-		.len = (st->chip_info->num_channels - 1) *
-		       BITS_TO_BYTES(st->chip_info->channels->scan_type.storagebits),
-		.rx_buf = st->scan_data.raw,
-	};
-	int ret;
+	struct spi_transfer xfer;
+	int bits_per_word, realbits, i, ret;
+
+	realbits = st->chip_info->channels[0].scan_type.realbits;
+	bits_per_word = ad7380_prepare_spi_xfer(st, &xfer);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	if (ret)
 		goto out;
 
+	/*
+	 * If bits_per_word == realbits (resolution boost enabled), we don't
+	 * need to manipulate the raw data, otherwise we may need to fix things
+	 * up a bit to fit the scan_type specs
+	 */
+	if (bits_per_word < realbits) {
+		if (realbits > 16 && bits_per_word <= 16) {
+			/*
+			 * Here realbits > 16 so storagebits is 32 and bits_per_word is <= 16
+			 * so we need to sign extend u16 to u32 using reverse order to
+			 * avoid writing over union data
+			 */
+			for (i = st->chip_info->num_channels - 2; i >= 0; i--)
+				st->scan_data.raw.u32[i] = sign_extend32(st->scan_data.raw.u16[i],
+									 bits_per_word - 1);
+		} else if (bits_per_word < 16) {
+			/*
+			 * Here realbits <= 16 so storagebits is 16.
+			 * We only need to sign extend only if bits_per_word is < 16
+			 */
+			for (i = 0; i < st->chip_info->num_channels - 1; i++)
+				st->scan_data.raw.u16[i] = sign_extend32(st->scan_data.raw.u16[i],
+									 bits_per_word - 1);
+		}
+	}
+
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
 					   pf->timestamp);
 
@@ -388,7 +449,7 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 static int ad7380_read_direct(struct ad7380_state *st,
 			      struct iio_chan_spec const *chan, int *val)
 {
-	struct spi_transfer xfers[] = {
+	struct spi_transfer xfers[2] = {
 		/* toggle CS (no data xfer) to trigger a conversion */
 		{
 			.speed_hz = AD7380_REG_WR_SPEED_HZ,
@@ -403,16 +464,11 @@ static int ad7380_read_direct(struct ad7380_state *st,
 				.unit = SPI_DELAY_UNIT_NSECS,
 			},
 		},
-		/* then read all channels */
+		/* then read all channels, it will be filled by ad7380_prepare_spi_xfer */
 		{
-			.speed_hz = AD7380_REG_WR_SPEED_HZ,
-			.bits_per_word = chan->scan_type.realbits,
-			.rx_buf = st->scan_data.raw,
-			.len = (st->chip_info->num_channels - 1) *
-			       ((chan->scan_type.storagebits > 16) ? 4 : 2),
 		},
 	};
-	int ret;
+	int bits_per_word, ret;
 
 	/*
 	 * In normal average oversampling we need to wait for multiple conversions to be done
@@ -420,12 +476,18 @@ static int ad7380_read_direct(struct ad7380_state *st,
 	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
 		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
 
+	bits_per_word = ad7380_prepare_spi_xfer(st, &xfers[1]);
+
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret < 0)
 		return ret;
 
-	*val = sign_extend32(st->scan_data.raw[chan->scan_index],
-			     chan->scan_type.realbits - 1);
+	if (bits_per_word > 16)
+		*val = sign_extend32(st->scan_data.raw.u32[chan->scan_index],
+				     bits_per_word - 1);
+	else
+		*val = sign_extend32(st->scan_data.raw.u16[chan->scan_index],
+				     bits_per_word - 1);
 
 	return IIO_VAL_INT;
 }
@@ -435,6 +497,12 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
+	int realbits;
+
+	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
+		realbits = chan->scan_type.realbits;
+	else
+		realbits = chan->scan_type.realbits - 2;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
@@ -443,22 +511,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		}
 		unreachable();
 	case IIO_CHAN_INFO_SCALE:
-		/*
-		 * According to the datasheet, the LSB size is:
-		 *    * (2 × VREF) / 2^N, for differential chips
-		 *    * VREF / 2^N, for pseudo-differential chips
-		 * where N is the ADC resolution (i.e realbits)
-		 */
-		*val = st->vref_mv;
-		*val2 = chan->scan_type.realbits - chan->differential;
+		*val = st->scales[st->resolution_boost_enable][0];
+		*val2 = st->scales[st->resolution_boost_enable][1];
 
-		return IIO_VAL_FRACTIONAL_LOG2;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
 		/*
 		 * According to IIO ABI, offset is applied before scale,
 		 * so offset is: vcm_mv / scale
 		 */
-		*val = st->vcm_mv[chan->channel] * (1 << chan->scan_type.realbits)
+		*val = st->vcm_mv[chan->channel] * (1 << realbits)
 			/ st->vref_mv;
 
 		return IIO_VAL_INT;
@@ -494,6 +556,24 @@ static int ad7380_read_avail(struct iio_dev *indio_dev,
 		}
 		*type = IIO_VAL_INT;
 
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scales[0];
+		/*
+		 * Values are stored into a 2D matrix.
+		 * We have 2 available scales depending on the resolution boost status
+		 * (enabled/disabled). Resolution boost can be enabled only when oversampling
+		 * is enabled (i.e OSR > 1).
+		 * So depending on the oversampling ratio we display only the currently
+		 * available scales. First scale is for normal mode, second scale is for resolution
+		 * boost enabled.
+		 */
+		if (st->oversampling_ratio > 1)
+			*length = 4;
+		else
+			*length = 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -522,6 +602,25 @@ static inline int check_osr(const int *available_ratio, int size, int ratio)
 	return -EINVAL;
 }
 
+static int ad7380_set_resolution_boost(struct iio_dev *indio_dev, bool enable)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->resolution_boost_enable == enable)
+		return 0;
+
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_RES,
+				 FIELD_PREP(AD7380_CONFIG1_RES, enable));
+
+	if (ret)
+		return ret;
+
+	st->resolution_boost_enable = enable;
+	return 0;
+}
+
 static int ad7380_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
@@ -559,6 +658,13 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 
 			st->oversampling_ratio = val;
 
+			/*
+			 * If oversampling is disabled (OSR == 1),
+			 * we need to disable resolution boost
+			 */
+			if (st->oversampling_ratio == 1)
+				ad7380_set_resolution_boost(indio_dev, RESOLUTION_BOOST_DISABLE);
+
 			/*
 			 * Perform a soft reset.
 			 * This will flush the oversampling block and FIFO but will
@@ -570,6 +676,25 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 							    AD7380_CONFIG2_RESET_SOFT));
 		}
 		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		if (val == st->scales[RESOLUTION_BOOST_DISABLE][0] &&
+		    val2 == st->scales[RESOLUTION_BOOST_DISABLE][1]) {
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				return ad7380_set_resolution_boost(indio_dev,
+								   RESOLUTION_BOOST_DISABLE);
+			}
+			unreachable();
+		}
+		if (st->oversampling_ratio > 1 &&
+		    val == st->scales[RESOLUTION_BOOST_ENABLE][0] &&
+		    val2 == st->scales[RESOLUTION_BOOST_ENABLE][1]) {
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				return ad7380_set_resolution_boost(indio_dev,
+								   RESOLUTION_BOOST_ENABLE);
+			}
+			unreachable();
+		}
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
@@ -614,6 +739,8 @@ static ssize_t oversampling_mode_store(struct device *dev,
 		 * Oversampling ratio depends on oversampling mode, to avoid
 		 * misconfiguration when changing oversampling mode,
 		 * disable oversampling by setting OSR to 0.
+		 * Since we disable the oversampling, we also need to
+		 * disable the resolution boost
 		 */
 		ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
 					 AD7380_CONFIG1_OSR, FIELD_PREP(AD7380_CONFIG1_OSR, 0));
@@ -622,6 +749,7 @@ static ssize_t oversampling_mode_store(struct device *dev,
 			return ret;
 
 		st->oversampling_ratio = 1;
+		ad7380_set_resolution_boost(indio_dev, RESOLUTION_BOOST_DISABLE);
 
 		/*
 		 * Perform a soft reset.
@@ -671,6 +799,36 @@ static const struct iio_info ad7380_info = {
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
+static void ad7380_init_available_scales(struct ad7380_state *st)
+{
+	s64 tmp;
+	int value_micro, value_int, realbits, differential;
+
+	/*
+	 * Resolution boost allow to enable 2 higher bits resolution
+	 * when oversampling is enabled, so we can have only two
+	 * scales depending on the resolution boost status.
+	 */
+	realbits = st->chip_info->channels[0].scan_type.realbits;
+	differential = st->chip_info->channels[0].differential;
+
+	/*
+	 * According to the datasheet, the LSB size is:
+	 *    * (2 × VREF) / 2^N, for differential chips
+	 *    * VREF / 2^N, for pseudo-differential chips
+	 * where N is the ADC resolution (i.e realbits)
+	 */
+	tmp = (s64)st->vref_mv * MEGA >> (realbits - 2 - differential);
+	value_int = div_s64_rem(tmp, MEGA, &value_micro);
+	st->scales[RESOLUTION_BOOST_DISABLE][0] = value_int;
+	st->scales[RESOLUTION_BOOST_DISABLE][1] = value_micro;
+
+	tmp = (s64)st->vref_mv * MEGA >> (realbits - differential);
+	value_int = div_s64_rem(tmp, MEGA, &value_micro);
+	st->scales[RESOLUTION_BOOST_ENABLE][0] = value_int;
+	st->scales[RESOLUTION_BOOST_ENABLE][1] = value_micro;
+}
+
 static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 {
 	int ret;
@@ -691,12 +849,16 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	if (ret < 0)
 		return ret;
 
-	/* Disable oversampling by default.
-	 * This is the default value after reset,
+	/* Disable oversampling and resolution boost by default.
+	 * This are the default values after reset,
 	 * so just initialize internal data
 	 */
 	st->oversampling_mode = OS_MODE_NORMAL_AVERAGE;
 	st->oversampling_ratio = 1;
+	st->resolution_boost_enable = RESOLUTION_BOOST_DISABLE;
+
+	/* initialize available scales */
+	ad7380_init_available_scales(st);
 
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,

-- 
2.44.0


