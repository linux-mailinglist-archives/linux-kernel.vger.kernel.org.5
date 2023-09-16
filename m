Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C57A3041
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjIPMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbjIPMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6F0CED;
        Sat, 16 Sep 2023 05:39:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so3621636a12.2;
        Sat, 16 Sep 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867951; x=1695472751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYYjh9GMEQV4bQzg1yrZBAuN1ssy5a2YTx5yaZl725w=;
        b=WHJMFxtdghFQ5NPDrXWh22aq8vJd+i8bobyAkuV+HbgxXheTgCvO7fQ9xuuhKP9Y24
         F3GneP3csRqX8Qm4BtoFakTMHArrte336g3ikkI3VnyREvDzjGGIkLVR7VL2PMBNONtp
         os+v3FjIq1tM1pWh3xE2AVpVAtxFDcuLVGpa/RQfMAnGLTrhdLTPn0kUqAywEm86z0Ab
         4Xczy0U+xFlEzgGNWY0M6uq10jsohgJlMvIO67KOk09Wd0uiak2KWWOjg2zUAh3NwDyD
         KcstrXsOCpaqTcHCFbWou3uOIxJCZvGjNia8u60AOoQrxUkPtdkVyLnicjCoyHvONcVy
         dXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867951; x=1695472751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYYjh9GMEQV4bQzg1yrZBAuN1ssy5a2YTx5yaZl725w=;
        b=EKCZgPEPvNNvPyW/4t085WUY2y8mqSu0MZXqgwHgmU4ufwbau8Brn9V6+OZRzTflxi
         3LbO2yrQMPXUBhE4IscLHgWoNO62iZWouXxBGbzSc21t0lWHE3iPR7iA4kozlPxbzXgI
         WgeNE/rmWKqQ2bd4MPY+6Ne9mj9T8nqYZEcAW43fGqpWVbAjzrWqiUwLh2p/3pESnak9
         iqJZiA34n9Wwu078RRPifMD74Mgx3BRneD2p8u8/0uAqaeqiWE+oitEo/qBkqlx1Fpih
         ax+7Qdnorc6oLtAzkZSyQrApJ8Cmpbv7OWaTjEpuDDkGv4A042ZA+JwjoeokxpMvYvSo
         TGwQ==
X-Gm-Message-State: AOJu0YwMXnbK2AabyJKdZij97AH+6oMvEbwtVk2CKAu2whv4/yHSrXvi
        na1Ok3O8BMfGBKbG2tFZpn6Q9V462vbpnA==
X-Google-Smtp-Source: AGHT+IF3pdlrF9KDFCXXOMdGR7KeMs4q60AuU50UeaoWvlHbEvMsBvGAqR5u0DVzm2xSEk6SN989mA==
X-Received: by 2002:a50:fc0e:0:b0:527:3a95:5bea with SMTP id i14-20020a50fc0e000000b005273a955beamr3616471edr.32.1694867951371;
        Sat, 16 Sep 2023 05:39:11 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:10 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 5/7] iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
Date:   Sat, 16 Sep 2023 14:38:51 +0200
Message-Id: <7a31d0cdefba15d7c791252ec8bc5db553b3996b.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
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

Add the chip_info structure to the driver's private data to hold all
the device specific infos.
Refactor the kx022a driver implementation to make it more generic and
extensible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c |  13 ++-
 drivers/iio/accel/kionix-kx022a-spi.c |  13 ++-
 drivers/iio/accel/kionix-kx022a.c     | 117 +++++++++++++++++---------
 drivers/iio/accel/kionix-kx022a.h     |  52 +++++++++++-
 4 files changed, 143 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index c0d0b69680f9..2fdc4c1ab93f 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -15,6 +15,7 @@
 static int kx022a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!i2c->irq) {
@@ -22,22 +23,26 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
+	chip_info = i2c_get_match_data(i2c);
+	if (!chip_info)
+		return -EINVAL;
+
+	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
 static const struct i2c_device_id kx022a_i2c_id[] = {
-	{ .name = "kx022a" },
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index f45a46899a5f..c21494ade157 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -15,6 +15,7 @@
 static int kx022a_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!spi->irq) {
@@ -22,22 +23,26 @@ static int kx022a_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -EINVAL;
+
+	regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
 static const struct spi_device_id kx022a_id[] = {
-	{ "kx022a" },
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 5a144f86c634..ab3e5c8a19df 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -48,7 +48,7 @@ enum {
 	KX022A_STATE_FIFO,
 };
 
-/* Regmap configs */
+/* kx022a Regmap configs */
 static const struct regmap_range kx022a_volatile_ranges[] = {
 	{
 		.range_min = KX022A_REG_XHP_L,
@@ -138,7 +138,7 @@ static const struct regmap_access_table kx022a_nir_regs = {
 	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
 };
 
-const struct regmap_config kx022a_regmap = {
+static const struct regmap_config kx022a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &kx022a_volatile_regs,
@@ -149,10 +149,10 @@ const struct regmap_config kx022a_regmap = {
 	.max_register = KX022A_MAX_REGISTER,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
 
 struct kx022a_data {
 	struct regmap *regmap;
+	const struct kx022a_chip_info *chip_info;
 	struct iio_trigger *trig;
 	struct device *dev;
 	struct iio_mount_matrix orientation;
@@ -175,6 +175,8 @@ struct kx022a_data {
 	struct mutex mutex;
 	u8 watermark;
 
+	__le16 *fifo_buffer;
+
 	/* 3 x 16bit accel data + timestamp */
 	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
 	struct {
@@ -208,7 +210,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 	{ }
 };
 
-#define KX022A_ACCEL_CHAN(axis, index)				\
+#define KX022A_ACCEL_CHAN(axis, reg, index)			\
 {								\
 	.type = IIO_ACCEL,					\
 	.modified = 1,						\
@@ -220,7 +222,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.ext_info = kx022a_ext_info,				\
-	.address = KX022A_REG_##axis##OUT_L,			\
+	.address = reg,						\
 	.scan_index = index,					\
 	.scan_type = {                                          \
 		.sign = 's',					\
@@ -231,9 +233,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 }
 
 static const struct iio_chan_spec kx022a_channels[] = {
-	KX022A_ACCEL_CHAN(X, 0),
-	KX022A_ACCEL_CHAN(Y, 1),
-	KX022A_ACCEL_CHAN(Z, 2),
+	KX022A_ACCEL_CHAN(X, KX022A_REG_XOUT_L, 0),
+	KX022A_ACCEL_CHAN(Y, KX022A_REG_YOUT_L, 1),
+	KX022A_ACCEL_CHAN(Z, KX022A_REG_ZOUT_L, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -332,10 +334,10 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
 				      KX022A_MASK_PC1);
 	else
-		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_clear_bits(data->regmap, data->chip_info->cntl,
 					KX022A_MASK_PC1);
 	if (ret)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
@@ -402,7 +404,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			break;
 
 		ret = regmap_update_bits(data->regmap,
-					 KX022A_REG_ODCNTL,
+					 data->chip_info->odcntl,
 					 KX022A_MASK_ODR, n);
 		data->odr_ns = kx022a_odrs[n];
 		kx022a_turn_on_unlock(data);
@@ -423,7 +425,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 		if (ret)
 			break;
 
-		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
 					 KX022A_MASK_GSEL,
 					 n << KX022A_GSEL_SHIFT);
 		kx022a_turn_on_unlock(data);
@@ -445,7 +447,7 @@ static int kx022a_fifo_set_wmi(struct kx022a_data *data)
 
 	threshold = data->watermark;
 
-	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
+	return regmap_update_bits(data->regmap, data->chip_info->buf_cntl1,
 				  KX022A_MASK_WM_TH, threshold);
 }
 
@@ -488,7 +490,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->odcntl, &regval);
 		if (ret)
 			return ret;
 
@@ -503,7 +505,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->cntl, &regval);
 		if (ret < 0)
 			return ret;
 
@@ -519,8 +521,7 @@ static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data = iio_priv(idev);
 
-	if (val > KX022A_FIFO_LENGTH)
-		val = KX022A_FIFO_LENGTH;
+	val = min(data->chip_info->fifo_length, val);
 
 	mutex_lock(&data->mutex);
 	data->watermark = val;
@@ -581,7 +582,7 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	 */
 	data->timestamp = 0;
 
-	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
+	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
@@ -589,7 +590,6 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 {
 	struct kx022a_data *data = iio_priv(idev);
 	struct device *dev = regmap_get_device(data->regmap);
-	__le16 buffer[KX022A_FIFO_LENGTH * 3];
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
@@ -668,13 +668,13 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	}
 
 	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
-	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
-				&buffer[0], fifo_bytes);
+	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
+				data->fifo_buffer, fifo_bytes);
 	if (ret)
 		goto renable_out;
 
 	for (i = 0; i < count; i++) {
-		__le16 *sam = &buffer[i * 3];
+		__le16 *sam = &data->fifo_buffer[i * 3];
 		__le16 *chs;
 		int bit;
 
@@ -721,10 +721,10 @@ static const struct iio_info kx022a_info = {
 static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
 {
 	if (en)
-		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		return regmap_set_bits(data->regmap, data->chip_info->cntl,
 				       KX022A_MASK_DRDY);
 
-	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+	return regmap_clear_bits(data->regmap, data->chip_info->cntl,
 				 KX022A_MASK_DRDY);
 }
 
@@ -759,7 +759,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 	if (ret)
 		goto unlock_out;
 
-	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
 				KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -768,6 +768,8 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 
 	kx022a_drop_fifo_contents(data);
 
+	kfree(data->fifo_buffer);
+
 	return kx022a_turn_on_unlock(data);
 
 unlock_out:
@@ -790,6 +792,12 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 {
 	int ret;
 
+	data->fifo_buffer = kmalloc_array(data->chip_info->fifo_length,
+					  KX022A_FIFO_SAMPLES_SIZE_BYTES,
+					  GFP_KERNEL);
+	if (!data->fifo_buffer)
+		return -ENOMEM;
+
 	ret = kx022a_turn_off_lock(data);
 	if (ret)
 		return ret;
@@ -800,7 +808,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 		goto unlock_out;
 
 	/* Enable buffer */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -846,7 +854,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
 			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
@@ -894,7 +902,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
 	if (data->state & KX022A_STATE_FIFO) {
 		int ok;
 
-		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		ok = __kx022a_fifo_flush(idev, data->chip_info->fifo_length, true);
 		if (ok > 0)
 			ret = IRQ_HANDLED;
 	}
@@ -947,7 +955,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	int ret, val;
 
 	/* Reset the senor */
-	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
+	ret = regmap_write(data->regmap, data->chip_info->cntl2, KX022A_MASK_SRST);
 	if (ret)
 		return ret;
 
@@ -957,7 +965,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	 */
 	msleep(1);
 
-	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
+	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
 				       !(val & KX022A_MASK_SRST),
 				       KX022A_SOFT_RESET_WAIT_TIME_US,
 				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
@@ -967,14 +975,14 @@ static int kx022a_chip_init(struct kx022a_data *data)
 		return ret;
 	}
 
-	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
+	ret = regmap_reinit_cache(data->regmap, data->chip_info->regmap_config);
 	if (ret) {
 		dev_err(data->dev, "Failed to reinit reg cache\n");
 		return ret;
 	}
 
 	/* set data res 16bit */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BRES16);
 	if (ret) {
 		dev_err(data->dev, "Failed to set data resolution\n");
@@ -984,7 +992,31 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	return kx022a_prepare_irq_pin(data);
 }
 
-int kx022a_probe_internal(struct device *dev)
+const struct kx022a_chip_info kx022a_chip_info = {
+	.name		  = "kx022-accel",
+	.regmap_config	  = &kx022a_regmap_config,
+	.channels	  = kx022a_channels,
+	.num_channels	  = ARRAY_SIZE(kx022a_channels),
+	.fifo_length	  = KX022A_FIFO_LENGTH,
+	.who		  = KX022A_REG_WHO,
+	.id		  = KX022A_ID,
+	.cntl		  = KX022A_REG_CNTL,
+	.cntl2		  = KX022A_REG_CNTL2,
+	.odcntl		  = KX022A_REG_ODCNTL,
+	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
+	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
+	.buf_clear	  = KX022A_REG_BUF_CLEAR,
+	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
+	.buf_read	  = KX022A_REG_BUF_READ,
+	.inc1		  = KX022A_REG_INC1,
+	.inc4		  = KX022A_REG_INC4,
+	.inc5		  = KX022A_REG_INC5,
+	.inc6		  = KX022A_REG_INC6,
+	.xout_l		  = KX022A_REG_XOUT_L,
+};
+EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
 	struct iio_trigger *indio_trig;
@@ -1011,6 +1043,7 @@ int kx022a_probe_internal(struct device *dev)
 		return -ENOMEM;
 
 	data = iio_priv(idev);
+	data->chip_info = chip_info;
 
 	/*
 	 * VDD is the analog and digital domain voltage supply and
@@ -1021,24 +1054,24 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to enable regulator\n");
 
-	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
+	ret = regmap_read(regmap, chip_info->who, &chip_id);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID)
+	if (chip_id != chip_info->id)
 		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-		data->inc_reg = KX022A_REG_INC1;
-		data->ien_reg = KX022A_REG_INC4;
+		data->inc_reg = chip_info->inc1;
+		data->ien_reg = chip_info->inc4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
 		if (irq < 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
-		data->inc_reg = KX022A_REG_INC5;
-		data->ien_reg = KX022A_REG_INC6;
+		data->inc_reg = chip_info->inc5;
+		data->ien_reg = chip_info->inc6;
 	}
 
 	data->regmap = regmap;
@@ -1047,9 +1080,9 @@ int kx022a_probe_internal(struct device *dev)
 	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
 	mutex_init(&data->mutex);
 
-	idev->channels = kx022a_channels;
-	idev->num_channels = ARRAY_SIZE(kx022a_channels);
-	idev->name = "kx022-accel";
+	idev->channels = chip_info->channels;
+	idev->num_channels = chip_info->num_channels;
+	idev->name = chip_info->name;
 	idev->info = &kx022a_info;
 	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	idev->available_scan_masks = kx022a_scan_masks;
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 12424649d438..0e5026019213 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,7 +76,55 @@
 
 struct device;
 
-int kx022a_probe_internal(struct device *dev);
-extern const struct regmap_config kx022a_regmap;
+/**
+ * struct kx022a_chip_info - Kionix accelerometer chip specific information
+ *
+ * @name:		name of the device
+ * @regmap_config:	pointer to register map configuration
+ * @channels:		pointer to iio_chan_spec array
+ * @num_channels:	number of iio_chan_spec channels
+ * @fifo_length:	number of 16-bit samples in a full buffer
+ * @who:		WHO_AM_I register
+ * @id:			WHO_AM_I register value
+ * @cntl:		control register 1
+ * @cntl2:		control register 2
+ * @odcntl:		output data control register
+ * @buf_cntl1:		buffer control register 1
+ * @buf_cntl2:		buffer control register 2
+ * @buf_clear:		buffer clear register
+ * @buf_status1:	buffer status register 1
+ * @buf_read:		buffer read register
+ * @inc1:		interrupt control register 1
+ * @inc4:		interrupt control register 4
+ * @inc5:		interrupt control register 5
+ * @inc6:		interrupt control register 6
+ * @xout_l:		x-axis output least significant byte
+ */
+struct kx022a_chip_info {
+	const char *name;
+	const struct regmap_config *regmap_config;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int fifo_length;
+	u8 who;
+	u8 id;
+	u8 cntl;
+	u8 cntl2;
+	u8 odcntl;
+	u8 buf_cntl1;
+	u8 buf_cntl2;
+	u8 buf_clear;
+	u8 buf_status1;
+	u8 buf_read;
+	u8 inc1;
+	u8 inc4;
+	u8 inc5;
+	u8 inc6;
+	u8 xout_l;
+};
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
+
+extern const struct kx022a_chip_info kx022a_chip_info;
 
 #endif
-- 
2.30.2

