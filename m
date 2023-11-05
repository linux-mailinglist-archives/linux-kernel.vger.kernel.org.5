Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14D47E1612
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKETc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjKETcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:32:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65BE1;
        Sun,  5 Nov 2023 11:32:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso565391966b.0;
        Sun, 05 Nov 2023 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699212740; x=1699817540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx4rbRfjJn26t0QwsBmlr0DRSHJPbATrjWqayUKhDAA=;
        b=WinK7U/4MP8E4x7FuXKrMgCw/K8t59guALdWCOTGj9Bqtae+VGseKWvQBjT1GC7ufS
         m/b8VGxc4D7QWiUqSe+uBgTD4GmEekA7MEFe9fX0DtYcJVxGZ/VqipbXJAUjGt3Cd9RX
         QajUdmRNXX8lz/Hjz9Jtkexf0j5KDn5tfdGiORipW8PFffbRsKMskI9JbJ0ioDvN0rqG
         EPP00ALXVdflz9VoZBzQG2KP5n+7Dz3r6rXWJkbIIMINQBDs8ee+jDfLwp7wtTVvIsjH
         YY72Ze5W4WoOh2hEkJ2sKkWzWGtI/aYGMxfLxozJCb+kNp+F7HAMB3E+qFhMe3Kipbad
         jXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699212740; x=1699817540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx4rbRfjJn26t0QwsBmlr0DRSHJPbATrjWqayUKhDAA=;
        b=StpXDEyYqAEBr4Ds+FUdgb/+6RlC6XytxAHQsefal6PQn2F+I/4rtP6RGb0j5QRRBx
         zLPxJWwaKSJ5u87BtnyqloBlTwKjiuAAks+y7Fz4IRoagSJ/jjjIa7K1iJmzSgjc8UZd
         C9tQRjS4nOhGz2I3lCWGkg1f9lZpQXkVMO59XvNFqj+oy2/m7O1g1SzXaIxUdcf1fVPu
         of/NCvY7Tf0Jezep8DuF6jguIw0J5lRkT+4B6nRJsmLqlRI8j8X4NooPFPNkKaWnKkCP
         nDxj9QUmfhggGSR7yEMHiVmFKKlObX1ELVvxqyDVeRzZ1dr4m94PpQBEaC3qFer+XvJ1
         IGvA==
X-Gm-Message-State: AOJu0YwbN9hoWzTgyHY8WZ9X2F9/r98TiHPLW6Vswj993bZln9RParMi
        ZRDGRQkXrEt1ZF8TvJr0XEc=
X-Google-Smtp-Source: AGHT+IFijrL+t53UkXWRLz2sD+Q+okMjn5WAfzowdw8Vmg5NfMG2VbCFynga46eSlFHF+CzYfBNo6Q==
X-Received: by 2002:a17:907:c24:b0:9bf:20e0:bfe9 with SMTP id ga36-20020a1709070c2400b009bf20e0bfe9mr14275382ejc.15.1699212739794;
        Sun, 05 Nov 2023 11:32:19 -0800 (PST)
Received: from spiri.. ([5.14.137.80])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009b947aacb4bsm3300259ejw.191.2023.11.05.11.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 11:32:19 -0800 (PST)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: ad7192: Use device api
Date:   Sun,  5 Nov 2023 21:31:29 +0200
Message-Id: <20231105193132.47009-2-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105193132.47009-1-alisadariana@gmail.com>
References: <20231105193132.47009-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Replace of.h and corresponding functions with preferred device specific
functions.

Also replace of_device_get_match_data function with
spi_get_device_match_data.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
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

