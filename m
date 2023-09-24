Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB37ACC1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIXVwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIXVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:52:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19010D;
        Sun, 24 Sep 2023 14:52:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32003aae100so4368939f8f.0;
        Sun, 24 Sep 2023 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695592347; x=1696197147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1mUiu1NbtoOEm28VDfVFWd43xm6wsUmZ3K7SF3CDig=;
        b=bCPr3Sjc3F09pWHMz9N3XG1qzpkji8AwgJAnviL0JomwH0YxczLw+jo7bTfbN9IId6
         a+vy3DmRvrUBirr7/LjyMwUIVHa6DZWK0BeVd56IsfndfQEOAg7nHIOh9Nk4Sr+uCuJg
         0gOhMb3t58yvmRpV879YwvbxgoM3sWNHaBUxo4y11/2LwYIIg8Qcpdd71xpwLWmyoW9Y
         ut/JgekQDhBm9du0q0Fm0EoMNWRb1B3kD4AgL8fz498aARpgjPLOzKymlWaOqFHlSjbq
         KTIbEvjXZtXXYoa+lzK2LJ/Fmor82aPo8hXOrlK2o7wALABl6hd8dy00hl0PhfMEY96Q
         cAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695592347; x=1696197147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1mUiu1NbtoOEm28VDfVFWd43xm6wsUmZ3K7SF3CDig=;
        b=vWkTAGGMu8sS/U3NavdIEe5TPNj7Yi3fsz3po/dacwldq6dl4kaNgG5CSl9AIEtjQI
         XryFFpJTZVIxZv3sPK0IvqwI043BCkaiYWxzuCe8R4mMa13CVjtHRrXIlN8VrKPW4l71
         y4+2PSV/lhnYCJB92pZMqswGi0nWZ4IoawTdiOs3FuGmW1Fz2mjaJPNtq0h3clpky1GN
         VZxZ713LX/0ujjsQg8RDLqjkjum0qHnwvYKv9KJgTX1jZ6gFD+8gWwTwX1mR9JGzhWUY
         2qiz+owmM17G/LYdeaWJNMpG31u2MtGSYmRhDi3U3yRI8coq0zpOeapX3iUmAjNsdk5S
         /Tqw==
X-Gm-Message-State: AOJu0YyX9dc0l0TnMvSEJ5yh3hhNEouX/GG7uPnYbp0df+aAwFNlvFNc
        FOgCk/t0q/jE3J8x/S2c+s0=
X-Google-Smtp-Source: AGHT+IHpEl+lvIf+Tqc9qxedHbLstx3mEYRJvB/o8BKaKtHY726EWq1uOjTKkU35/PYeZ03RFhJuuw==
X-Received: by 2002:a5d:5904:0:b0:317:6579:2b9f with SMTP id v4-20020a5d5904000000b0031765792b9fmr3835926wrd.30.1695592347329;
        Sun, 24 Sep 2023 14:52:27 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:1bc9:cab8:e784:6ddb])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm10144444wru.52.2023.09.24.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 14:52:27 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: adc: ad7192: Improve f_order computation
Date:   Mon, 25 Sep 2023 00:51:47 +0300
Message-Id: <20230924215148.102491-3-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230924215148.102491-1-alisadariana@gmail.com>
References: <20230924215148.102491-1-alisadariana@gmail.com>
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
index d693f2ce8a20..0f9d33002d35 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -179,7 +179,6 @@ struct ad7192_state {
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
-	u32				f_order;
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
@@ -419,7 +418,6 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
-	st->f_order = AD7192_NO_SYNC_FILTER;
 
 	buf_en = of_property_read_bool(np, "adi,buffer-enable");
 	if (buf_en)
@@ -530,22 +528,60 @@ static ssize_t ad7192_set(struct device *dev,
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
+				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+}
+
+static int ad7192_get_f_adc(struct ad7192_state *st)
+{
+	unsigned int f_order = ad7192_get_f_order(st);
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+}
+
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 						    int *freq)
 {
 	unsigned int fadc;
 
 	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_compute_f_adc(st, false, true);
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_compute_f_adc(st, true, true);
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk, FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_compute_f_adc(st, false, false);
 	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
+
+	fadc = ad7192_compute_f_adc(st, true, false);
 	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
 }
 
@@ -628,25 +664,21 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 
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
@@ -664,8 +696,7 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
 {
 	unsigned int fadc;
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 st->f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_get_f_adc(st);
 
 	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
 		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
@@ -713,8 +744,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->fclk /
-			(st->f_order * 1024 * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*val = ad7192_get_3db_filter_freq(st);
@@ -764,7 +794,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		div = st->fclk / (val * st->f_order * 1024);
+		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
 		if (div < 1 || div > 1023) {
 			ret = -EINVAL;
 			break;
-- 
2.34.1

