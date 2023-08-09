Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB92D77681C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjHITMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHITME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E47212B;
        Wed,  9 Aug 2023 12:12:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso709525e9.2;
        Wed, 09 Aug 2023 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608320; x=1692213120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GXHD9z3QbTzRtcNSHsxh75zMlKi3WfnQYnJg7fdwt4=;
        b=PwDY2MIX6ELKje2/CPgWrHbbFN9FLx5GpWgJizSfvDItlBiAERDDT4eaoVVTyOGtYR
         3P8Espud1LSbEAxJOg0pOJvXBcVq8wnEBFSjwjtg9J4XrnrY0QpHQ53SVPPHlcbHjk4X
         HMBrALmaZrHKNFxFvKUG0IQPnZp2dDL0QTNNS5VwpbCDe17oKkueMDjFt8xzKKAJZa+W
         u2SHAgBDBwP3paaBG2aaVc0mHUr1w0JCFlZHolrDiwrlsZxqQt5leFlL/8LQuKq87MPy
         y5gmxkdzmE0+LRTHRRF53/SJmcKMW6zBw0vqrXLvZIDbpQRpYYuS810umGyQazhWubDL
         OWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608320; x=1692213120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GXHD9z3QbTzRtcNSHsxh75zMlKi3WfnQYnJg7fdwt4=;
        b=UP+TOVfuCLtNqGPAXPAupR+zscRlaFgqzLZV9tOvq8Dcxrz4tBxqcmkOFiavO71wPj
         JfSycqC7Z0nAzP0VwOq583XD7iPMqN2boEdEtdADAEpP7yda4cvFTlhG1tOslwY5X2Vn
         5uidDCZOp6cm68WdoaJXrW6u8phZN6QD1brAtQv1jsmWa8v8DiabCq9NGUHoOWnGqzsj
         16pua8lOvAuxMrp1h1ne702w64oHleSWjo4ZmW/BUNJP4TRNKWXb5S36R3edlvDnIM/s
         0PchyYNf4Ypyt8oU4+yrrKvJy6BrgQ3ISf+NsbDYLfvmAJpopI/qECV3yxp7eLvIpAQf
         JNdA==
X-Gm-Message-State: AOJu0Yxjqjb8RbBPuodMwfStan+ywQJeaC1Fl4aoD9Rpny1MiYDHx1TZ
        IS/1jIhf8QDoLI4rI/mglS4kMLkpXVF1kg==
X-Google-Smtp-Source: AGHT+IEnQWbEtjM9Fa7ITAilwjuOCwOGxVinwAZ9QP3noHU6f1nOxehOS3Yos00q0O4EcXkHs53J4A==
X-Received: by 2002:a5d:4241:0:b0:317:e7e0:8528 with SMTP id s1-20020a5d4241000000b00317e7e08528mr226123wrr.50.1691608320286;
        Wed, 09 Aug 2023 12:12:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:59 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Wed,  9 Aug 2023 21:11:37 +0200
Message-Id: <11d8bcef77a563804c125ed4de1127253e98f3be.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
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

Since Kionix accelerometers use various numbers of bits to report data, a
device-specific function is required.
Implement the function as a callback in the device-specific chip_info structure

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
- no changes

v6:
- directly return KX022A_FIFO_MAX_BYTES as suggested by Andy

v5:
- no changes

v4:
- removed the comment about "bogus value from i2c"
- removed regmap_get_device(data->regmap); dev is present in the
  driver's private data

v3:
- no changes

v2:
- separated this change from the chip_info introduction and made it a patch in v2 
- changed the function from generic implementation for to device-specific one
- removed blank lines pointed out by checkpatch
- changed the allocation of the "buffer" array in __kx022a_fifo_flush

 drivers/iio/accel/kionix-kx022a.c | 28 ++++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h |  4 ++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 0bab3f109e4e..0b0f14dca17f 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -596,26 +596,33 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	int ret, fifo_bytes;
+
+	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret) {
+		dev_err(data->dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
+		return KX022A_FIFO_MAX_BYTES;
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
 	struct kx022a_data *data = iio_priv(idev);
-	struct device *dev = regmap_get_device(data->regmap);
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
 	int64_t tstamp;
 	int ret, i;
 
-	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
-	if (ret) {
-		dev_err(dev, "Error reading buffer status\n");
-		return ret;
-	}
-
-	/* Let's not overflow if we for some reason get bogus value from i2c */
-	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
-		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+	fifo_bytes = data->chip_info->get_fifo_bytes(data);
 
 	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
 		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
@@ -1023,6 +1030,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 0e5026019213..c9f9aee7e597 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,6 +76,8 @@
 
 struct device;
 
+struct kx022a_data;
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
@@ -99,6 +101,7 @@ struct device;
  * @inc5:		interrupt control register 5
  * @inc6:		interrupt control register 6
  * @xout_l:		x-axis output least significant byte
+ * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -121,6 +124,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

