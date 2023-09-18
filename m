Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E347A5540
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjIRVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjIRVvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:51:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AB10F;
        Mon, 18 Sep 2023 14:51:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso51149335e9.2;
        Mon, 18 Sep 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695073861; x=1695678661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77vkDA7o99pkxj/eIirfTUK9vAc5BeQ+d3yACNP0k4Y=;
        b=UphArjMkjEl4+3vFZcPCj8jCM6Sb7Yf340GOA0cSQGnufMC5KnCs1/vQ813kthbt6x
         waMd0fRDtn2Nox9Edf+2tkD7OdxUQmfUvP8dCTSnWW3ZqSHdLsIr1X/VZEffUhIAm1Hk
         zX+HixHXMXhqh4qrNPezLmHon2qlTd2xna9R8Epk62m6R0ARdaCmfBTbYeIstnP1/TJ3
         0tVKaJOc4zrjQdwaStYVsugRpVRD2WiooWjx6VEP16CETpXw3lib5+TPIyejjTn1GsfT
         aQayjiZZrE7Tr23cazVo277bKJPRAONKSuebZSfCcVS8Qyrjz1K6aj6ZMJumDYhR4VQj
         5jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073861; x=1695678661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77vkDA7o99pkxj/eIirfTUK9vAc5BeQ+d3yACNP0k4Y=;
        b=TWvNNCVsCuuEVuwYp+IsdYQCNwqzLmTQfuIXtU9wFm9qOnDYfLI3lXbskEa94yvmIv
         n2HBOlxpheLtm4VntOccvIw6/MPX5LHW1naCh83XLH9ZvcFsNcqGzK4+qLjIvz+ddbCo
         bJHnSnXwsZ7SHWYSo1NsoYIiS3GWfBtSKSmg5uZeHia6/Dv4ATkWJxCOtFiuZFZ39CAu
         wrnCno8TM+9pHf6RaaT81BtfOkHjy5rC5t5Loh9uShCl+BS887UYf8E1y6ezstFsKdhN
         ZhEt3fm4shLs1uj9FBvAxZUihNRtp9YB24/eQi0X8CB2Z5x52QwmFz43x3SZbRZoAWcN
         21mQ==
X-Gm-Message-State: AOJu0Yw+8PBsBgkz6n+NsLCeN4J2bflpbMdIE2TRXfjIRR8ExvO6L8Ia
        VPGFf351Pt8jgjtXZXfFJM7qu8Go7sk0kg==
X-Google-Smtp-Source: AGHT+IGzC+aPiS3zYN1QtbIZPb229mo4q7gS8ZhorQwZOvtCUUxh8i5Y/GBL3cNDxkWH9ruk4+155A==
X-Received: by 2002:a1c:6a0e:0:b0:402:f536:41c5 with SMTP id f14-20020a1c6a0e000000b00402f53641c5mr10457875wmc.3.1695073861249;
        Mon, 18 Sep 2023 14:51:01 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:13e1:e47b:904a:6f81])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003fe23b10fdfsm16323715wmj.36.2023.09.18.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 14:51:00 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: ad7192: Use bitfield access macros
Date:   Tue, 19 Sep 2023 00:48:52 +0300
Message-Id: <20230918214854.252781-2-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918214854.252781-1-alisadariana@gmail.com>
References: <20230918214854.252781-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Include bitfield.h and update driver to use bitfield access macros
GENMASK, FIELD_PREP and FIELD_GET.

Also simplify AD7192_CONF_GAIN(-1) to AD7192_CONF_GAIN_MASK and
AD7192_MODE_RATE(-1) to AD7192_MODE_RATE_MASK.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 69d1103b9508..e83fecb63c1d 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -43,7 +44,9 @@
 #define AD7192_COMM_WEN		BIT(7) /* Write Enable */
 #define AD7192_COMM_WRITE	0 /* Write Operation */
 #define AD7192_COMM_READ	BIT(6) /* Read Operation */
-#define AD7192_COMM_ADDR(x)	(((x) & 0x7) << 3) /* Register Address */
+#define AD7192_COMM_ADDR_MASK	GENMASK(5, 3) /* Register Address Mask */
+#define AD7192_COMM_ADDR(x)	FIELD_PREP(AD7192_COMM_ADDR_MASK, x)
+				  /* Register Address */
 #define AD7192_COMM_CREAD	BIT(2) /* Continuous Read of Data Register */
 
 /* Status Register Bit Designations (AD7192_REG_STAT) */
@@ -56,17 +59,24 @@
 #define AD7192_STAT_CH1		BIT(0) /* Channel 1 */
 
 /* Mode Register Bit Designations (AD7192_REG_MODE) */
-#define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
-#define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
-#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
+#define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
+#define AD7192_MODE_SEL(x)	FIELD_PREP(AD7192_MODE_SEL_MASK, x)
+				  /* Operation Mode Select */
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
-#define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
+#define AD7192_MODE_STA(x)	FIELD_PREP(AD7192_MODE_STA_MASK, x)
+				  /* Status Register transmission */
+#define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
+#define AD7192_MODE_CLKSRC(x)	FIELD_PREP(AD7192_MODE_CLKSRC_MASK, x)
+				  /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
 #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
 #define AD7192_MODE_REJ60	BIT(10) /* 50/60Hz notch filter */
-#define AD7192_MODE_RATE(x)	((x) & 0x3FF) /* Filter Update Rate Select */
+#define AD7192_MODE_RATE_MASK	GENMASK(9, 0)
+				  /* Filter Update Rate Select Mask */
+#define AD7192_MODE_RATE(x)	FIELD_PREP(AD7192_MODE_RATE_MASK, x)
+				  /* Filter Update Rate Select */
 
 /* Mode Register: AD7192_MODE_SEL options */
 #define AD7192_MODE_CONT		0 /* Continuous Conversion Mode */
@@ -92,13 +102,16 @@
 #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
 #define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
 #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
-#define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
-#define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
+#define AD7192_CONF_CHAN_MASK	GENMASK(18, 8) /* Channel select mask */
+#define AD7192_CONF_CHAN(x)	FIELD_PREP(AD7192_CONF_CHAN_MASK, x)
+				  /* Channel select */
 #define AD7192_CONF_BURN	BIT(7) /* Burnout current enable */
 #define AD7192_CONF_REFDET	BIT(6) /* Reference detect enable */
 #define AD7192_CONF_BUF		BIT(4) /* Buffered Mode Enable */
 #define AD7192_CONF_UNIPOLAR	BIT(3) /* Unipolar/Bipolar Enable */
-#define AD7192_CONF_GAIN(x)	((x) & 0x7) /* Gain Select */
+#define AD7192_CONF_GAIN_MASK	GENMASK(2, 0) /* Gain Select */
+#define AD7192_CONF_GAIN(x)	FIELD_PREP(AD7192_CONF_GAIN_MASK, x)
+				  /* Gain Select */
 
 #define AD7192_CH_AIN1P_AIN2M	BIT(0) /* AIN1(+) - AIN2(-) */
 #define AD7192_CH_AIN3P_AIN4M	BIT(1) /* AIN3(+) - AIN4(-) */
@@ -130,7 +143,7 @@
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
 #define CHIPID_AD7195		0x6
-#define AD7192_ID_MASK		0x0F
+#define AD7192_ID_MASK		GENMASK(3, 0)
 
 /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
 #define AD7192_GPOCON_BPDSW	BIT(6) /* Bridge power-down switch enable */
@@ -399,7 +412,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 	if (ret)
 		return ret;
 
-	id &= AD7192_ID_MASK;
+	id = FIELD_GET(AD7192_ID_MASK, id);
 
 	if (id != st->chip_info->chip_id)
 		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
@@ -472,7 +485,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
+	return sysfs_emit(buf, "%d\n", !!FIELD_GET(AD7192_CONF_ACX, st->conf));
 }
 
 static ssize_t ad7192_show_bridge_switch(struct device *dev,
@@ -482,7 +495,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
+	return sysfs_emit(buf, "%d\n",
+			  !!FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
 }
 
 static ssize_t ad7192_set(struct device *dev,
@@ -667,9 +681,9 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
 	fadc = DIV_ROUND_CLOSEST(st->fclk,
 				 st->f_order * AD7192_MODE_RATE(st->mode));
 
-	if (st->conf & AD7192_CONF_CHOP)
+	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
 		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
-	if (st->mode & AD7192_MODE_SINC3)
+	if (FIELD_GET(AD7192_MODE_SINC3, st->mode))
 		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
 	else
 		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
@@ -682,7 +696,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	bool unipolar = !!(st->conf & AD7192_CONF_UNIPOLAR);
+	bool unipolar = !!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf);
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -746,7 +760,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			if (val2 == st->scale_avail[i][1]) {
 				ret = 0;
 				tmp = st->conf;
-				st->conf &= ~AD7192_CONF_GAIN(-1);
+				st->conf &= ~AD7192_CONF_GAIN_MASK;
 				st->conf |= AD7192_CONF_GAIN(i);
 				if (tmp == st->conf)
 					break;
@@ -769,7 +783,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		st->mode &= ~AD7192_MODE_RATE(-1);
+		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= AD7192_MODE_RATE(div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 		break;
-- 
2.34.1

