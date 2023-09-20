Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B67A6FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjITAeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjITAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:34:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3382BD;
        Tue, 19 Sep 2023 17:34:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-403012f27e1so67336595e9.1;
        Tue, 19 Sep 2023 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695170064; x=1695774864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTKsldiiCRsv+wVrj01zIAiYaQFNo54L3IgaNR8DqAw=;
        b=JbkPgxoQY6P7ZcX7/skVfqmWRggUOMUha/n9n3oBlqoMtHm2pNIBx2Qi8E84B0HeGt
         6wZH4YbPxxXBgHi36f0UwWUpmYoo/a4MYJ8n7hVjrnw4PlWjMByqRDK7jgkdUCAzAaNU
         ukFx+s5YO9K+/N4fypw9D5hMDNxmXLkQUXpYpH74AYd3upBoM6KBugtimOEbhd9FZRs9
         tUCZkOAZylZxgAwO6T6uqo08GCKqGq+iKtbJy+CXeLGH0ndoeQDQHWAoN/lL/ou9YsS5
         dbAGL73ZotgeJ/IOsrgH3kicZuA81PnyyT/VRzV9qSWX7nP5m3YQJzBUpMOuzwRH3XCt
         3b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170064; x=1695774864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTKsldiiCRsv+wVrj01zIAiYaQFNo54L3IgaNR8DqAw=;
        b=acBG8f4hDXiZQgL/tTH9rkYQPb/PTofEJCBj7M374Peldbm++xYLIOr1O4u+LeHtmS
         ydUlFPBK9OwM9OTC43pyDgTpRZYkwTFQQ3p6KSl1wKn0pwgJflhZHPX3dEBeAsT0FfSw
         NqIP64KNvspRV4h5OvRh81EdYnUUx9N0eScKmaP3aJQc9XWQUzHmrjQjB+g99uS+OaG0
         ogRqOtpGDoGY8T9q8VkIINxUR7Nmm7L6L4b4v6xx6HLAIb848xRfb9EwwQDazhXmJjIw
         wLEFzqGSLzyc90rvdjgXpMlYDW0bhgLmtzQ25JjApxsmg0fzdtjRI+yddzw8mu6qAanu
         Smkw==
X-Gm-Message-State: AOJu0YylucdZyuW6Xoze+tI0sT+LLJSlHSD3utnzVP+Z2Fm1wqAy5o5p
        XFgLjg1+5W6NUQfD3gQZ4KZN0O3keyVBY8r7
X-Google-Smtp-Source: AGHT+IE/TpaZdH8KvTm84ZAfthXFa5cJINZ4NH43rRc/Eg3Pac3MV++yRIM/5Bh5kwzoRtq7tf/2Yw==
X-Received: by 2002:a7b:cd12:0:b0:401:bdd7:499d with SMTP id f18-20020a7bcd12000000b00401bdd7499dmr1054566wmj.25.1695170064240;
        Tue, 19 Sep 2023 17:34:24 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:7838:74ca:1f92:5a36])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b003fe15ac0934sm506343wmo.1.2023.09.19.17.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:34:23 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: adc: ad7192: Improve f_order computation
Date:   Wed, 20 Sep 2023 03:33:41 +0300
Message-Id: <20230920003342.118813-3-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920003342.118813-1-alisadariana@gmail.com>
References: <20230920003342.118813-1-alisadariana@gmail.com>
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
index 64bc09ce3cb1..eed3de02c26d 100644
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
+				 f_order * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
+}
+
+static int ad7192_get_f_adc(struct ad7192_state *st)
+{
+	unsigned int f_order = ad7192_get_f_order(st);
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
+}
+
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
 						    int *freq)
 {
 	unsigned int fadc;
 
 	/* Formulas for filter at page 25 of the datasheet */
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC4_FILTER * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_compute_f_adc(st, false, true);
 	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk,
-				 AD7192_SYNC3_FILTER * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_compute_f_adc(st, true, true);
 	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
-	fadc = DIV_ROUND_CLOSEST(st->fclk, FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
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
-				 st->f_order * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
+	fadc = ad7192_get_f_adc(st);
 
 	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
 		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
@@ -713,8 +744,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->fclk /
-			(st->f_order * 1024 * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
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

