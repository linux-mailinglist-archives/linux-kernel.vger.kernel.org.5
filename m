Return-Path: <linux-kernel+bounces-165405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DC8B8C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AA3281ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4D130E20;
	Wed,  1 May 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="poCE+KvX"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6601304B1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575362; cv=none; b=CSFGhaEPK7/KIfuqAjvl3GuaO2wcSOZ7iGNefElzkV9g+u2Wr+xHssSCKhKewsZC2JxTN4qXxJn/nxoOOCKngHopsPFoeCewEtzOCrg/N4K2TPFh2dDOrEWVFNp18oXZHCqUwflKDJYBGIbT2BLMsF9LOxOEQeHsPY3Z2lnzCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575362; c=relaxed/simple;
	bh=du2kLMCRp5o4P3dsqZNBM0LPI3ROwsmwvCGStfPCr9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdsQ1fiUwj1cmbVXNUVeg0uBe+FJbKk+QBGRWvUA9c45M9yb/MZG+WqqUwj32k4rQb+/zcXtPcX0/1HUPpHs93DSK0srQHyT8Tnv3NhonfBJ+Bl7ssxLaPrhy//vp9NjO4pBSJdtY5DJZVnjWEIKoOVo7Kr2AbhZ8ECFmJE+kHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=poCE+KvX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso27494365e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575358; x=1715180158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7y0HuhKkWvqsIGNuF6QczDFqnvdiHcoO8fQ4/iNtzs=;
        b=poCE+KvXhN7uuuX0pL6L7JRYd9h9vqK1UHnrTDzk++aiDicsWFywc7ez/GkXK4ZUjL
         1AyVEDpt1a4+dBFv1ZjrX2BEqjFK307WOHsa/uwIramawIeevpY/qtvAt2X0CiHg3gaf
         XLV06rcITfHvxHe6XY0ayB2SlGXw0KgTixAbDmiH1Po+15FKlVTpmWlGPBc7sdN7EpzV
         bRntg2hag9F9ny6KmdI6ZM566SO7O2thZMHlWME5G/7bRj4HxonC3hT0HQQhZARw58OP
         RjTRynWtIbIYjWJVRSXAqoaXbuv8Inx4zgdIMimR/9KbayEgrJ+aHr9JkVmv5KWbu6os
         PWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575358; x=1715180158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7y0HuhKkWvqsIGNuF6QczDFqnvdiHcoO8fQ4/iNtzs=;
        b=vKSLOXNw0efepsYmB8nC1kgDgnRCw/xzuaEzaqhjTkSJhZQS3eP4BY/9RatAtp/Jyp
         l3wU8Wunm7I0LsJPuYGCMwEB1TgSSqeYGr/ob9Cg5vb7yNtAVY89nHQFF4SkikRLYF+K
         Pehlb9Nq7aEGtq8ttZwtwL81Tu8qaqwI0Mu0xlmmSb9yuRawQ5ZRQrKstigsRDuMwSeN
         uE8/l9TfUTdpOBlggBscHcw/YdpBmCDMY95fktxBD5ARhS6g2dQN8O4AEt4PFz/dRODf
         SzduXqq0jWm//QvDxspDKoldpZCK6Y1i3bYQHb8N7PfdX2p/EwUQKVUEhYLns8APOgoj
         xLeg==
X-Forwarded-Encrypted: i=1; AJvYcCVm8yJ+hXX2ekzAo60NdhqpRg8Zy7nDizVJvc3Vi16/8bf3j0BghLaMhD4igivjfZJvf2GeNFGmTOpflsQw+0LvSeOg5aokBBDVkWpy
X-Gm-Message-State: AOJu0Yz7+1GPFfvevCeaol8fy5FNkFeALcWS6sgXewFMHIZd+lfRlPmb
	vg+lU/bN2pK0ASm+NavB9osXfImrHia+TGbMJu4c9SttopGSecrYJxHC4+4Tt5c=
X-Google-Smtp-Source: AGHT+IFb+S1JZu/pjS1R0VAFDljvVUvKkc6fdJz5V7dgS2gKjVI2x4U7x6KqVf5Hme/wx0vVVUAkjg==
X-Received: by 2002:a05:600c:5250:b0:41c:b44:f917 with SMTP id fc16-20020a05600c525000b0041c0b44f917mr2595394wmb.22.1714575358698;
        Wed, 01 May 2024 07:55:58 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:58 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:42 +0200
Subject: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
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

Adds support for rolling average oversampling mode.

Rolling oversampling mode uses a first in, first out (FIFO) buffer of
the most recent samples in the averaging calculation, allowing the ADC
throughput rate and output data rate to stay the same, since we only need
to take only one sample for each new conversion.

The FIFO length is 8, thus the available oversampling ratios are 1, 2, 4, 8
in this mode (vs 1,  2, 4, 8, 16, 32 for the normal average)

In order to be able to change the averaging mode, this commit also adds
the new "oversampling_mode" and "oversampling_mode_available" custom
attributes along with the according documentation file in
Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no standard
attributes correspond to this use case.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 |  38 ++++++
 MAINTAINERS                                        |   1 +
 drivers/iio/adc/ad7380.c                           | 143 +++++++++++++++++++--
 3 files changed, 174 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
new file mode 100644
index 000000000000..0a560ef3e32a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
@@ -0,0 +1,38 @@
+What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode
+KernelVersion: 6.9
+Contact: Michael Hennerich <michael.hennerich@analog.com>
+Description:
+    Writing this attribute sets the oversampling average mode.
+    Reading it, shows the configured mode.
+    Available modes can be displayed using the oversampling_mode_available
+    attribute.
+    When writing this attribute to change the oversampling mode, this will
+    have the following side effects:
+
+      - soft reset the ADC to flush the oversampling block and FIFO
+
+      - the available oversampling ratios depend on the oversampling mode
+        configured so to avoid misconfiguration, changing the mode will disable
+        the oversampling by setting the ratio to 1.
+
+      - the list of available ratios (displayed by reading the
+        oversampling_ratio_available attribute) will be updated when changing
+        the oversampling mode.
+
+What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode_available
+KernelVersion: 6.9
+Contact: Michael Hennerich <michael.hennerich@analog.com>
+Description:
+    Display the available oversampling average modes. The two available modes
+    are "normal" and "rolling" where "normal" average mode is the default one.
+
+      - normal averaging involves taking a number of samples, adding them
+        together, and dividing the result by the number of samples taken.
+        This result is then output from the device. The sample data is cleared
+        when the process completes. Because we need more samples to output a
+        value, the data output rate decrease with the oversampling ratio.
+
+      - rolling oversampling mode uses a first in, first out (FIFO) buffer of
+        the most recent samples in the averaging calculation, allowing the ADC
+        throughput rate and output data rate to stay the same, since we only need
+        to take only one sample for each new conversion.
diff --git a/MAINTAINERS b/MAINTAINERS
index 87724a9e9f9f..ca1e115f2aff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -434,6 +434,7 @@ R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
 F:	drivers/iio/adc/ad7380.c
 
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 1e3869f5e48c..7b021bb9cf87 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -51,6 +51,8 @@
 #define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
 
 #define AD7380_CONFIG1_OS_MODE		BIT(9)
+#define OS_MODE_NORMAL_AVERAGE		0
+#define OS_MODE_ROLLING_AVERAGE		1
 #define AD7380_CONFIG1_OSR		GENMASK(8, 6)
 #define AD7380_CONFIG1_CRC_W		BIT(5)
 #define AD7380_CONFIG1_CRC_R		BIT(4)
@@ -159,16 +161,27 @@ static const struct ad7380_timing_specs ad7380_4_timing = {
 	.t_csh_ns = 20,
 };
 
+/*
+ * Available oversampling modes.
+ */
+static const char * const ad7380_oversampling_average_modes[] = {
+	[OS_MODE_NORMAL_AVERAGE]	= "normal",
+	[OS_MODE_ROLLING_AVERAGE]	= "rolling",
+};
+
 /*
  * Available oversampling ratios. The indices correspond
  * with the bit value expected by the chip.
- * The available ratios depend on the averaging mode,
- * only normal averaging is supported for now
+ * The available ratios depend on the averaging mode.
  */
 static const int ad7380_normal_average_oversampling_ratios[] = {
 	1, 2, 4, 8, 16, 32,
 };
 
+static const int ad7380_rolling_average_oversampling_ratios[] = {
+	1, 2, 4, 8,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
@@ -244,6 +257,7 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
+	unsigned int oversampling_mode;
 	unsigned int oversampling_ratio;
 	struct regmap *regmap;
 	unsigned int vref_mv;
@@ -403,7 +417,7 @@ static int ad7380_read_direct(struct ad7380_state *st,
 	/*
 	 * In normal average oversampling we need to wait for multiple conversions to be done
 	 */
-	if (st->oversampling_ratio > 1)
+	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
 		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
@@ -462,10 +476,22 @@ static int ad7380_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	struct ad7380_state *st = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*vals = ad7380_normal_average_oversampling_ratios;
-		*length = ARRAY_SIZE(ad7380_normal_average_oversampling_ratios);
+		switch (st->oversampling_mode) {
+		case OS_MODE_NORMAL_AVERAGE:
+			*vals = ad7380_normal_average_oversampling_ratios;
+			*length = ARRAY_SIZE(ad7380_normal_average_oversampling_ratios);
+			break;
+		case OS_MODE_ROLLING_AVERAGE:
+			*vals = ad7380_rolling_average_oversampling_ratios;
+			*length = ARRAY_SIZE(ad7380_rolling_average_oversampling_ratios);
+			break;
+		default:
+			return -EINVAL;
+		}
 		*type = IIO_VAL_INT;
 
 		return IIO_AVAIL_LIST;
@@ -505,9 +531,20 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		osr = check_osr(ad7380_normal_average_oversampling_ratios,
-				ARRAY_SIZE(ad7380_normal_average_oversampling_ratios),
-				val);
+		switch (st->oversampling_mode) {
+		case OS_MODE_NORMAL_AVERAGE:
+			osr = check_osr(ad7380_normal_average_oversampling_ratios,
+					ARRAY_SIZE(ad7380_normal_average_oversampling_ratios),
+					val);
+			break;
+		case OS_MODE_ROLLING_AVERAGE:
+			osr = check_osr(ad7380_rolling_average_oversampling_ratios,
+					ARRAY_SIZE(ad7380_rolling_average_oversampling_ratios),
+					val);
+			break;
+		default:
+			return -EINVAL;
+		}
 
 		if (osr < 0)
 			return osr;
@@ -538,7 +575,96 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t oversampling_mode_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct ad7380_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int os_mode;
+
+	os_mode = st->oversampling_mode;
+
+	return sysfs_emit(buf, "%s\n", ad7380_oversampling_average_modes[os_mode]);
+}
+
+static ssize_t oversampling_mode_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int os_mode, ret;
+
+	ret = sysfs_match_string(ad7380_oversampling_average_modes, buf);
+	if (ret < 0)
+		return ret;
+
+	os_mode = ret;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_OS_MODE,
+					 FIELD_PREP(AD7380_CONFIG1_OS_MODE, os_mode));
+
+		if (ret)
+			return  ret;
+
+		st->oversampling_mode = os_mode;
+
+		/*
+		 * Oversampling ratio depends on oversampling mode, to avoid
+		 * misconfiguration when changing oversampling mode,
+		 * disable oversampling by setting OSR to 0.
+		 */
+		ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_OSR, FIELD_PREP(AD7380_CONFIG1_OSR, 0));
+
+		if (ret)
+			return ret;
+
+		st->oversampling_ratio = 1;
+
+		/*
+		 * Perform a soft reset.
+		 * This will flush the oversampling block and FIFO but will
+		 * maintain the content of the configurable registers.
+		 */
+		ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+					 AD7380_CONFIG2_RESET,
+					 FIELD_PREP(AD7380_CONFIG2_RESET,
+						    AD7380_CONFIG2_RESET_SOFT));
+	}
+	return ret ?: len;
+}
+
+static ssize_t oversampling_mode_available_show(struct device *dev,
+						struct device_attribute *attr, char *buf)
+{
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ad7380_oversampling_average_modes); i++)
+		len += sysfs_emit_at(buf, len, "%s ", ad7380_oversampling_average_modes[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(oversampling_mode, 0);
+static IIO_DEVICE_ATTR_RO(oversampling_mode_available, 0);
+
+static struct attribute *ad7380_attributes[] = {
+	&iio_dev_attr_oversampling_mode.dev_attr.attr,
+	&iio_dev_attr_oversampling_mode_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7380_attribute_group = {
+	.attrs = ad7380_attributes,
+};
+
 static const struct iio_info ad7380_info = {
+	.attrs = &ad7380_attribute_group,
 	.read_raw = &ad7380_read_raw,
 	.read_avail = &ad7380_read_avail,
 	.write_raw = &ad7380_write_raw,
@@ -569,6 +695,7 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	 * This is the default value after reset,
 	 * so just initialize internal data
 	 */
+	st->oversampling_mode = OS_MODE_NORMAL_AVERAGE;
 	st->oversampling_ratio = 1;
 
 	/* SPI 1-wire mode */

-- 
2.44.0


