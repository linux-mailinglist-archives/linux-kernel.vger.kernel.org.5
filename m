Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B507A303E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbjIPMjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbjIPMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA1CF1;
        Sat, 16 Sep 2023 05:39:15 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703a0453fso50225871fa.3;
        Sat, 16 Sep 2023 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867954; x=1695472754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj0S4IUhwKpm57k81UJh3FEAAmf45N8dx0cUdOy0h84=;
        b=SwQymvz72+L7um8VS20JF407Sg+WMxmAVOf97V9rkOzNVmu7a+gY382gVoCtYyy71H
         LnMm8xZ45zoc43fwDrWgiIc/egMzVTtO5oOzrnEXz9hDGyX6GJgiIQ4fl6V/cs6DW3Mc
         2ay/QTJe+JAEW2C3IIGX8w7gJoqwK9RCu7gE/tZxqQVj6n3gQQ+MksUICK8YRIADdYgi
         hM1DeX9ICb/ymtDhby2mKQNcqzvsAcCJSdO610dP2MgNBkYEAEWk+OHr/1ubB25pn/NF
         seSO2OmkP1bZXQkJiAOZ4LP3TOJc4FLws1JtzqbdfJi8/16FteQJX9siLlEAjls4Gzld
         PoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867954; x=1695472754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj0S4IUhwKpm57k81UJh3FEAAmf45N8dx0cUdOy0h84=;
        b=LalrCoosV/xEMiDU74XujkgVNKTSwLBDleisnfZEonGinMrsfQspWv4ovnD8/gRVEn
         5bXcIY8WfyFHU4+/s3uCsyNII3CQRgGfmrJs3Pm8km5LP5u+9VUDvJ/J3rhj0S38v98A
         n8SP8h90NrCvvEX5YV+KgaPoJu95uG6mxBW4RKpExyMSU+4MWHkFNws3X8AoXYsjKyJO
         RtIxKrqrZKfiyjtADHTTEOkr670iIPrwceBWP736ecPpSuEIwmHGzfiMCNouGtPTu474
         5aY9pRuwEnX1VlWNNxe4LGSzaYH1iJrZsx92rSQnNngNNRStfXxUDjabaXkCa0bUJKqQ
         EQyw==
X-Gm-Message-State: AOJu0YwRO6W98RDC/xnIBDGN9C2z43XOLywdhgUBFoPd/ee/9n77thw6
        7/Yi+Rs+JDFJ00Mw/sLzI0ZO9xoWxskC8Q==
X-Google-Smtp-Source: AGHT+IGj462tn+kYa6mnbmyhKe/vs8cE9HX/9bQ8DzXGvyzB7fNvA3hHUFOWswr9WHzVW3MwU/9tMg==
X-Received: by 2002:ac2:58e2:0:b0:4fe:8c07:98eb with SMTP id v2-20020ac258e2000000b004fe8c0798ebmr3479948lfo.51.1694867953910;
        Sat, 16 Sep 2023 05:39:13 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:13 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 6/7] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Sat, 16 Sep 2023 14:38:52 +0200
Message-Id: <9c550fb28e34915d473e379f812c7753f7643bae.1694867379.git.mehdi.djait.k@gmail.com>
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

Since Kionix accelerometers use various numbers of bits to report data, a
device-specific function is required.
Implement the function as a callback in the device-specific chip_info structure

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 68 +++++++++++++++++--------------
 drivers/iio/accel/kionix-kx022a.h | 46 ++++++++++++---------
 2 files changed, 64 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ab3e5c8a19df..cc7134b1183b 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -585,26 +585,33 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes_available(struct kx022a_data *data)
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
+	fifo_bytes = data->chip_info->get_fifo_bytes_available(data);
 
 	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
 		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
@@ -993,26 +1000,27 @@ static int kx022a_chip_init(struct kx022a_data *data)
 }
 
 const struct kx022a_chip_info kx022a_chip_info = {
-	.name		  = "kx022-accel",
-	.regmap_config	  = &kx022a_regmap_config,
-	.channels	  = kx022a_channels,
-	.num_channels	  = ARRAY_SIZE(kx022a_channels),
-	.fifo_length	  = KX022A_FIFO_LENGTH,
-	.who		  = KX022A_REG_WHO,
-	.id		  = KX022A_ID,
-	.cntl		  = KX022A_REG_CNTL,
-	.cntl2		  = KX022A_REG_CNTL2,
-	.odcntl		  = KX022A_REG_ODCNTL,
-	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
-	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
-	.buf_clear	  = KX022A_REG_BUF_CLEAR,
-	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
-	.buf_read	  = KX022A_REG_BUF_READ,
-	.inc1		  = KX022A_REG_INC1,
-	.inc4		  = KX022A_REG_INC4,
-	.inc5		  = KX022A_REG_INC5,
-	.inc6		  = KX022A_REG_INC6,
-	.xout_l		  = KX022A_REG_XOUT_L,
+	.name				= "kx022-accel",
+	.regmap_config			= &kx022a_regmap_config,
+	.channels			= kx022a_channels,
+	.num_channels			= ARRAY_SIZE(kx022a_channels),
+	.fifo_length			= KX022A_FIFO_LENGTH,
+	.who				= KX022A_REG_WHO,
+	.id				= KX022A_ID,
+	.cntl				= KX022A_REG_CNTL,
+	.cntl2				= KX022A_REG_CNTL2,
+	.odcntl				= KX022A_REG_ODCNTL,
+	.buf_cntl1			= KX022A_REG_BUF_CNTL1,
+	.buf_cntl2			= KX022A_REG_BUF_CNTL2,
+	.buf_clear			= KX022A_REG_BUF_CLEAR,
+	.buf_status1			= KX022A_REG_BUF_STATUS_1,
+	.buf_read			= KX022A_REG_BUF_READ,
+	.inc1				= KX022A_REG_INC1,
+	.inc4				= KX022A_REG_INC4,
+	.inc5				= KX022A_REG_INC5,
+	.inc6				= KX022A_REG_INC6,
+	.xout_l				= KX022A_REG_XOUT_L,
+	.get_fifo_bytes_available	= kx022a_get_fifo_bytes_available,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 0e5026019213..7ca48e6f2c49 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,29 +76,34 @@
 
 struct device;
 
+struct kx022a_data;
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
- * @name:		name of the device
- * @regmap_config:	pointer to register map configuration
- * @channels:		pointer to iio_chan_spec array
- * @num_channels:	number of iio_chan_spec channels
- * @fifo_length:	number of 16-bit samples in a full buffer
- * @who:		WHO_AM_I register
- * @id:			WHO_AM_I register value
- * @cntl:		control register 1
- * @cntl2:		control register 2
- * @odcntl:		output data control register
- * @buf_cntl1:		buffer control register 1
- * @buf_cntl2:		buffer control register 2
- * @buf_clear:		buffer clear register
- * @buf_status1:	buffer status register 1
- * @buf_read:		buffer read register
- * @inc1:		interrupt control register 1
- * @inc4:		interrupt control register 4
- * @inc5:		interrupt control register 5
- * @inc6:		interrupt control register 6
- * @xout_l:		x-axis output least significant byte
+ * @name:			name of the device
+ * @regmap_config:		pointer to register map configuration
+ * @channels:			pointer to iio_chan_spec array
+ * @num_channels:		number of iio_chan_spec channels
+ * @fifo_length:		number of 16-bit samples in a full buffer
+ * @who:			WHO_AM_I register
+ * @id:				WHO_AM_I register value
+ * @cntl:			control register 1
+ * @cntl2:			control register 2
+ * @odcntl:			output data control register
+ * @buf_cntl1:			buffer control register 1
+ * @buf_cntl2:			buffer control register 2
+ * @buf_clear:			buffer clear register
+ * @buf_status1:		buffer status register 1
+ * @buf_read:			buffer read register
+ * @inc1:			interrupt control register 1
+ * @inc4:			interrupt control register 4
+ * @inc5:			interrupt control register 5
+ * @inc6:			interrupt control register 6
+ * @xout_l:			x-axis output least significant byte
+ * @get_fifo_bytes_available:	function pointer to get amount of acceleration
+ *				data bytes currently stored in the sensor's FIFO
+ *				buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -121,6 +126,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes_available)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2

