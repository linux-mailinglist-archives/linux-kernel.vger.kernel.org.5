Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBF7EB743
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjKNUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjKNUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2A181;
        Tue, 14 Nov 2023 12:06:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c3aec5f326so26806466b.1;
        Tue, 14 Nov 2023 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992387; x=1700597187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyyZDkc0Wj7minjSP1UoKOglPc5es2p26jbnUyN/6fU=;
        b=N1uydid1O9ZGquiYGOSzGnU9i2KC1dQjKXguS8q03gURiI6mBC13Ep87rk9hjDu9mu
         5OcosoaAlS6xijwtzEDUFKyhx4KVpgiQpIEVC30AIJ58NUdkXw7y1PQhHTsHlfXhF/+4
         zBufxtfp49aH5yQlxXNpD+qzMYVE/UxsgoOum0cvHQ9utA11bCgtSNwnzSym3JGDAWus
         kqn6fsieTtEzDjPIlNRmn5+a++SOkrK6EkaWW7zhqLC8TdMLJB+40gNeXyAG+vu8xpSq
         bBoKjAme4qBqbIiE+DaLQRVEQ3hV9VWMqif3SoXBEMwzlHRi3obBii0K8M3h6WOoB1EQ
         LQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992387; x=1700597187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyyZDkc0Wj7minjSP1UoKOglPc5es2p26jbnUyN/6fU=;
        b=jP/UvA6enjuGMDTmNhCJNhlhXkeVXKL9iDm2S0qQ/H7XHNzbQL7JnQVgaaDSpvLI/1
         GPMdVLuy5HogSuyalwsPs7ocXPXmo/Q847Ojqe+9SiUsLU5sfNhsJICaT8S6mYkgBEY+
         Q/hJbc6maFSQr7jC1YOuFHuuokTvkEQAH7VVLSqxclYHz6t1rTaMSUnlLZBazBaIbHPt
         Y+6RPrCbQQOlBulhN91Mlbm/LVjayiU+qeIr0yDMacGvUff0fRBIE4Q8jPSo+ovWSOV0
         RsE99+UfTPUqyHAmwh5WvNKsh0CX5U9WQBRtTGh97N6mIAddVDQI9RZRMoq/XWZ5aMpK
         cLww==
X-Gm-Message-State: AOJu0YwOkCpa2pp/Nx8piqUvOpGIUZVft72D6/hqBcwTPKvw2wwaAU/7
        QfqhZRL/cp2FAhmh9Ttpsz4=
X-Google-Smtp-Source: AGHT+IH3MC4UIYYnqtCHmnf+EsCekcir3VXx1nA1PstT0HzLHjiliGG0jsH4HhgqXHacFGHXGESfhw==
X-Received: by 2002:a17:907:9813:b0:9b2:be5e:3674 with SMTP id ji19-20020a170907981300b009b2be5e3674mr3614330ejc.36.1699992386810;
        Tue, 14 Nov 2023 12:06:26 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:06:26 -0800 (PST)
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/4] iio: adc: ad7192: Use device api
Date:   Tue, 14 Nov 2023 22:05:31 +0200
Message-Id: <20231114200533.137995-3-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114200533.137995-1-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of.h and corresponding functions with preferred device specific
functions.

Also replace of_device_get_match_data() with
spi_get_device_match_data().

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad7192.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index adc3cbe92d6e..48e0357564af 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -364,19 +363,19 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_of_clock_select(struct ad7192_state *st)
+static int ad7192_device_clock_select(struct ad7192_state *st)
 {
-	struct device_node *np = st->sd.spi->dev.of_node;
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int clock_sel;
 
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
 	if (!st->mclk) {
-		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
+		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
-		if (of_property_read_bool(np, "adi,clock-xtal"))
+		if (device_property_read_bool(dev, "adi,clock-xtal"))
 			clock_sel = AD7192_CLK_EXT_MCLK1_2;
 		else
 			clock_sel = AD7192_CLK_EXT_MCLK2;
@@ -385,9 +384,10 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -416,26 +416,26 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 
 	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
 
-	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	rej60_en = device_property_read_bool(dev, "adi,rejection-60-Hz-enable");
 	if (rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	refin2_en = device_property_read_bool(dev, "adi,refin2-pins-enable");
 	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
 
-	buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	buf_en = device_property_read_bool(dev, "adi,buffer-enable");
 	if (buf_en)
 		st->conf |= AD7192_CONF_BUF;
 
-	bipolar = of_property_read_bool(np, "bipolar");
+	bipolar = device_property_read_bool(dev, "bipolar");
 	if (!bipolar)
 		st->conf |= AD7192_CONF_UNIPOLAR;
 
-	burnout_curr_en = of_property_read_bool(np,
-						"adi,burnout-currents-enable");
+	burnout_curr_en =
+		device_property_read_bool(dev, "adi,burnout-currents-enable");
 	if (burnout_curr_en && buf_en) {
 		st->conf |= AD7192_CONF_BURN;
 	} else if (burnout_curr_en) {
@@ -1117,9 +1117,7 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 	st->int_vref_mv = ret / 1000;
 
-	st->chip_info = of_device_get_match_data(&spi->dev);
-	if (!st->chip_info)
-		st->chip_info = (void *)spi_get_device_id(spi)->driver_data;
+	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
@@ -1140,7 +1138,7 @@ static int ad7192_probe(struct spi_device *spi)
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	st->clock_sel = ad7192_of_clock_select(st);
+	st->clock_sel = ad7192_device_clock_select(st);
 
 	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
@@ -1152,7 +1150,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(indio_dev, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1

