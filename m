Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6213A7BFBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjJJMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjJJMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:49:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5BDB;
        Tue, 10 Oct 2023 05:49:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso835012a12.1;
        Tue, 10 Oct 2023 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942185; x=1697546985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msy7jv8g0SLNU2c8sB4y8hw1WS5I1nkPJ94zB1gQH70=;
        b=SrkxS6evptDFFJzSFWZFpxT1YPVBfPPyyzA/3mlwrP9esJAz8n5OLYo08JpYMsK4/o
         kYPMHTTz1tvbq7YIrJ0+IYAwtpUKz5eh8csWbkitaJLOokto/Y62qLRZRkxZQVdo62/K
         90aElQOP08jgt8+gI+quJJAo8+lSuP6ynOCWgv0y29nnxq1sgwEFSpnVwxwQv/4SCtRj
         N4rEWN0ts/t00Ut6fV8ldo8E29GT/2iQ7yMDIUear1vJjXt5s0CmbHdtcEhHHEAZLBRa
         ywB4xZljnFDf7wuAOlgFPYWZfIQAcI1MiT1+ugeVqSU5C8Cel/x90CYd3iDWbd4qAHBc
         X3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942185; x=1697546985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msy7jv8g0SLNU2c8sB4y8hw1WS5I1nkPJ94zB1gQH70=;
        b=tNR5g+OYXV+Yr30SWEXnCCqXIDdEXpAlyrLt/HLoAR6/UZ9TyDB1GJcGEto77aQFTG
         nWnVlaZOwRRt7KEaRsVX9kNocWQ0DCSRhJgs2F9jHa+yTnLwKyMeD9Y2vsfnI7AAPsPM
         BqP7BfW66W0f5FWHihtAJ9tS/Dl9WiWKQfKZd0GqifrGahMfSF0DTpvSuFOxs1FMs6Zs
         N/E4Wt+2J6ujpoeNQqm+crVfpX0w1lB/E62YJHCdIyVh3LeoHIpLkzVWhIiMJLRSSINh
         OAFfaooWEwG+qEmr1WxHZvuIXd6ZB9+TmUJxo2m4kMtzcfq3z8V1wXdVJeQyJmNh9ETc
         JUdw==
X-Gm-Message-State: AOJu0Yw56w/1qzg2J8f2WPHSYl4mwMHjMlQcguTh5pCuQt8+w/Nk5Nl3
        SsUhW/j/5Gt2JcLquVwRNNY=
X-Google-Smtp-Source: AGHT+IFJunh/iFx66Xg6oiovR2A+r8a9IIdNmv4a9lXSvnlMDsMw2UNT8MvI3qU6pnHx28ec0wvLaw==
X-Received: by 2002:aa7:cfda:0:b0:522:ae79:3ee8 with SMTP id r26-20020aa7cfda000000b00522ae793ee8mr15865968edy.5.1696942185420;
        Tue, 10 Oct 2023 05:49:45 -0700 (PDT)
Received: from spiri.. ([5.14.139.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402005a00b00530bc7cf377sm7629476edu.12.2023.10.10.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:49:45 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] iio: adc: ad7192: Add fast settling support
Date:   Tue, 10 Oct 2023 15:49:26 +0300
Message-Id: <20231010124927.143343-4-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010124927.143343-1-alisadariana@gmail.com>
References: <20231010124927.143343-1-alisadariana@gmail.com>
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

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Add fast settling mode support for AD7193.

Add two new device specific attributes: oversampling_ratio and
oversampling_ratio_available.

For AD7193 the user can set the average factor by writing to
oversampling_ratio. The possible values are exposed when reading
oversampling_ratio_available.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 107 +++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index fe47ef43b3d7..954093ee0fbd 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -60,6 +60,8 @@
 #define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
+#define AD7192_MODE_AVG_MASK	GENMASK(17, 16)
+		  /* Fast Settling Filter Average Select Mask (AD7193 only) */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
@@ -185,6 +187,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u32				oversampling_ratio_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
@@ -462,6 +465,11 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 		st->scale_avail[i][0] = scale_uv;
 	}
 
+	st->oversampling_ratio_avail[0] = 1;
+	st->oversampling_ratio_avail[1] = 2;
+	st->oversampling_ratio_avail[2] = 8;
+	st->oversampling_ratio_avail[3] = 16;
+
 	return 0;
 }
 
@@ -531,15 +539,21 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int ad7192_compute_f_order(bool sinc3_en, bool chop_en)
+static int ad7192_compute_f_order(struct ad7192_state *st, bool sinc3_en, bool chop_en)
 {
-	if (!chop_en)
+	u8 avg_factor_selected, oversampling_ratio;
+
+	avg_factor_selected = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
+
+	if (!avg_factor_selected && !chop_en)
 		return 1;
 
+	oversampling_ratio = st->oversampling_ratio_avail[avg_factor_selected];
+
 	if (sinc3_en)
-		return AD7192_SYNC3_FILTER;
+		return AD7192_SYNC3_FILTER + oversampling_ratio - 1;
 
-	return AD7192_SYNC4_FILTER;
+	return AD7192_SYNC4_FILTER + oversampling_ratio - 1;
 }
 
 static int ad7192_get_f_order(struct ad7192_state *st)
@@ -549,13 +563,13 @@ static int ad7192_get_f_order(struct ad7192_state *st)
 	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
 	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
 
-	return ad7192_compute_f_order(sinc3_en, chop_en);
+	return ad7192_compute_f_order(st, sinc3_en, chop_en);
 }
 
 static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
 				bool chop_en)
 {
-	unsigned int f_order = ad7192_compute_f_order(sinc3_en, chop_en);
+	unsigned int f_order = ad7192_compute_f_order(st, sinc3_en, chop_en);
 
 	return DIV_ROUND_CLOSEST(st->fclk,
 				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
@@ -753,6 +767,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		*val = ad7192_get_3db_filter_freq(st);
 		*val2 = 1000;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio_avail[FIELD_GET(AD7192_MODE_AVG_MASK, st->mode)];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -810,6 +827,23 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = -EINVAL;
+		mutex_lock(&st->lock);
+		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++)
+			if (val == st->oversampling_ratio_avail[i]) {
+				ret = 0;
+				tmp = st->mode;
+				st->mode &= ~AD7192_MODE_AVG_MASK;
+				st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
+				if (tmp == st->mode)
+					break;
+				ad_sd_write_reg(&st->sd, AD7192_REG_MODE,
+						3, st->mode);
+				break;
+			}
+		mutex_unlock(&st->lock);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -830,6 +864,8 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -849,6 +885,12 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 		/* Values are stored in a 2D matrix  */
 		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = (int *)st->oversampling_ratio_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(st->oversampling_ratio_avail);
+
 		return IIO_AVAIL_LIST;
 	}
 
@@ -896,7 +938,7 @@ static const struct iio_info ad7195_info = {
 };
 
 #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _type, \
-	_mask_type_av, _ext_info) \
+	_mask_all, _mask_type_av, _mask_all_av, _ext_info) \
 	{ \
 		.type = (_type), \
 		.differential = ((_channel2) == -1 ? 0 : 1), \
@@ -908,8 +950,10 @@ static const struct iio_info ad7195_info = {
 			BIT(IIO_CHAN_INFO_OFFSET), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
-			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+			(_mask_all), \
 		.info_mask_shared_by_type_available = (_mask_type_av), \
+		.info_mask_shared_by_all_available = (_mask_all_av), \
 		.ext_info = (_ext_info), \
 		.scan_index = (_si), \
 		.scan_type = { \
@@ -921,15 +965,26 @@ static const struct iio_info ad7195_info = {
 	}
 
 #define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
-	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
+	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, 0, \
+		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_calibsys_ext_info)
 
 #define AD719x_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
+	__AD719x_CHANNEL(_si, _channel1, -1, _address, IIO_VOLTAGE, 0, \
+		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_calibsys_ext_info)
 
 #define AD719x_TEMP_CHANNEL(_si, _address) \
-	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, NULL)
+	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, 0, 0, NULL)
+
+#define AD7193_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
+	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, \
+		IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		BIT(IIO_CHAN_INFO_SCALE), \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		ad7192_calibsys_ext_info)
+
+#define AD7193_CHANNEL(_si, _channel1, _address) \
+	AD7193_DIFF_CHANNEL(_si, _channel1, -1, _address)
 
 static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
@@ -944,20 +999,20 @@ static const struct iio_chan_spec ad7192_channels[] = {
 };
 
 static const struct iio_chan_spec ad7193_channels[] = {
-	AD719x_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
-	AD719x_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
-	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
-	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
+	AD7193_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
+	AD7193_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
+	AD7193_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
+	AD7193_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
-	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
-	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
-	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
-	AD719x_CHANNEL(9, 4, AD7193_CH_AIN4),
-	AD719x_CHANNEL(10, 5, AD7193_CH_AIN5),
-	AD719x_CHANNEL(11, 6, AD7193_CH_AIN6),
-	AD719x_CHANNEL(12, 7, AD7193_CH_AIN7),
-	AD719x_CHANNEL(13, 8, AD7193_CH_AIN8),
+	AD7193_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
+	AD7193_CHANNEL(6, 1, AD7193_CH_AIN1),
+	AD7193_CHANNEL(7, 2, AD7193_CH_AIN2),
+	AD7193_CHANNEL(8, 3, AD7193_CH_AIN3),
+	AD7193_CHANNEL(9, 4, AD7193_CH_AIN4),
+	AD7193_CHANNEL(10, 5, AD7193_CH_AIN5),
+	AD7193_CHANNEL(11, 6, AD7193_CH_AIN6),
+	AD7193_CHANNEL(12, 7, AD7193_CH_AIN7),
+	AD7193_CHANNEL(13, 8, AD7193_CH_AIN8),
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
-- 
2.34.1

