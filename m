Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7117A5542
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjIRVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjIRVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:51:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075A12A;
        Mon, 18 Sep 2023 14:51:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso32633265e9.2;
        Mon, 18 Sep 2023 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695073867; x=1695678667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXypIG8thQVVoSCVF6ddVbBsO4QXLTxrxZ50blaKQVM=;
        b=e7Cq+HSALqBCZY9U5RYYBe7dOTSyGV+rANECWMmpc5F1E5WGMb0k2Hs8pcmqqb5SJP
         IhCpPv12qjCv4kt8DU//q/ly51HBpbFDcvhLA23bXorTCt82gdyTuGcTbzF97asMDMf2
         jxVOXo/aywN/UqztwyIS0Dbaz/UjOKAww5KOGXSLIONqCT4yFVptokYEtFc1e8MDHCSb
         oD9DGmu+npiULByws2Bbr0JQJLgmhzbl/tjcqU3191XB4v/ymqEuBstB9JTFxQTm6qZF
         hVgdI/IyZfw1IRB4f8pLL2ylYog/Q87wvdOwsNEx2Gb6dku3xKL+nymkGv7X2zgk+X6r
         4yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073867; x=1695678667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXypIG8thQVVoSCVF6ddVbBsO4QXLTxrxZ50blaKQVM=;
        b=DRlC3cAErVeXQUjeIgjmJMip1675GSk2PNYa8+wble74jWotklbeoI4s6I6WYuit7b
         +YMxPa6ejgCMjEm77lghkH8lifpyAZffsfLVt5ZfqpZcljj/LpoX6BXf9ooKfzyttPHK
         5J6+WbjIpbqhkkSgKEsqLppuW2L/3abkuPP8eXIuo81uuBkfvQQ6pD1rGlUMxyHffZ/9
         f/sDEtqOql9hTKPwnJUrtN+jHcAVWkDXlSeIY4Iro3FrBpHA0GROucStyjGpHzel/O41
         9jjwzKFCCBY6FYAoblEScIX8yKD5+Qn9YfPDPqB0ZDzNJ/svRom0msYaGKKgdGvLssv4
         CZLg==
X-Gm-Message-State: AOJu0YwFiM+KDwTV3f8iRR5ERMci/S1kSRbfr6VvHbb87urNK2vS4JrD
        8HjV1fv0W7Pk6JkFBMq0+Tg=
X-Google-Smtp-Source: AGHT+IGLmqJGJG5kE9VGvMip3DUHKvmxC9lU0YcOFTp0az1ULaEOlaxgZseVVZ9P8H+8osfGmd33UA==
X-Received: by 2002:a05:600c:2053:b0:3fb:b5c0:a079 with SMTP id p19-20020a05600c205300b003fbb5c0a079mr9306980wmg.21.1695073866651;
        Mon, 18 Sep 2023 14:51:06 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:13e1:e47b:904a:6f81])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003fe23b10fdfsm16323715wmj.36.2023.09.18.14.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 14:51:06 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: ad7192: Improve f_order computation
Date:   Tue, 19 Sep 2023 00:48:53 +0300
Message-Id: <20230918214854.252781-3-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918214854.252781-1-alisadariana@gmail.com>
References: <20230918214854.252781-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Instead of using the f_order member of ad7192_state, a function that
computes the f_order coefficient makes more sense. This coefficient is a
function of the sinc filter and chop filter states.

Remove f_order member of ad7192_state structure. Instead use
ad7192_compute_f_order function to compute the f_order coefficient
according to the sinc filter and chop filter states passed as
parameters.

Add ad7192_get_f_order function that returns the current f_order
coefficient of the device.

Add ad7192_compute_f_adc function that computes the f_adc value
according to the sinc filter and chop filter states passed as
parameters.

Add ad7192_get_f_adc function that returns the current f_adc value of
the device.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 62 +++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index e83fecb63c1d..323e25c3ea30 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -193,7 +193,6 @@ struct ad7192_state {
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
-	u32				f_order;
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
@@ -433,7 +432,6 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
-	st->f_order = AD7192_NO_SYNC_FILTER;
 
 	buf_en = of_property_read_bool(np, "adi,buffer-enable");
 	if (buf_en)
@@ -544,22 +542,60 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
+static int ad7192_compute_f_order(bool sinc3_en, bool chop_en)
+{
+	if (!chop_en)
+		return 1;
+
+	if (sinc3_en)
+		return AD7192_SYNC3_FILTER;
+
+	return AD7192_SYNC4_FILTER;
+}
+
+static int ad7192_get_f_order(struct ad7192_state *st)
+{
+	bool sinc3_en, chop_en;
+
+	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
+	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
+
+	return ad7192_compute_f_order(sinc3_en, chop_en);
+}
+
+static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
+				bool chop_en)
+{
+	unsigned int f_order = ad7192_compute_f_order(sinc3_en, chop_en);
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * AD7192_MODE_RATE(st->mode));
+}
+
+static int ad7192_get_f_adc(struct ad7192_state *st)
+{
+	unsigned int f_order = ad7192_get_f_order(st);
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * AD7192_MODE_RATE(st->mode));
+}
+
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 						    int *freq)
 {
 	unsigned int fadc;
 
 	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
+	fadc = ad7192_compute_f_adc(st, false, true);
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
+	fadc = ad7192_compute_f_adc(st, true, true);
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
+	fadc = ad7192_compute_f_adc(st, false, false);
 	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
+
+	fadc = ad7192_compute_f_adc(st, true, false);
 	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
 }
 
@@ -642,25 +678,21 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 
 	switch (idx) {
 	case 0:
-		st->f_order = AD7192_SYNC4_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 1:
-		st->f_order = AD7192_SYNC3_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf |= AD7192_CONF_CHOP;
 		break;
 	case 2:
-		st->f_order = AD7192_NO_SYNC_FILTER;
 		st->mode &= ~AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
 		break;
 	case 3:
-		st->f_order = AD7192_NO_SYNC_FILTER;
 		st->mode |= AD7192_MODE_SINC3;
 
 		st->conf &= ~AD7192_CONF_CHOP;
@@ -678,8 +710,7 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
 {
 	unsigned int fadc;
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 st->f_order * AD7192_MODE_RATE(st->mode));
+	fadc = ad7192_get_f_adc(st);
 
 	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
 		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
@@ -726,8 +757,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->fclk /
-			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
+		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*val = ad7192_get_3db_filter_freq(st);
@@ -777,7 +807,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		div = st->fclk / (val * st->f_order * 1024);
+		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
 		if (div < 1 || div > 1023) {
 			ret = -EINVAL;
 			break;
-- 
2.34.1

