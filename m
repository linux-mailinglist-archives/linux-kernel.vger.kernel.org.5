Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24D7E9A40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjKMK0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKMK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:26:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B7D75;
        Mon, 13 Nov 2023 02:26:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso6454106a12.1;
        Mon, 13 Nov 2023 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871177; x=1700475977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=676mWdBEBZG3vlmSr/WlK77gM7Ih8+1VUmGPee+ETx8=;
        b=YTwNxixhrtHlFCXPMfPOUn2b9JNQlry7q8YuKQru2xTYi1ELtEGFQs+P3Uvh52sZLN
         MCYSJFM//zvcQ6nKjvJFMhB2yaYv7TbTpch7e9JdLEmRb3yeKLuoTXkYEMlA7m5SYKKW
         7J6AtiO27HRy+4ru9CHLtNULx4qwn8no1Z34SdrQN9rOZMbcTvF5RlOWltubOMuoba3w
         OErOyRP9CLnzHARfUGYyF6u3V1Qw8j9rTzgeoDJNYe91YZJQASXEaqivJ1s5iEDJ6IOQ
         SGJuTqBLUOYrRMQ66byb4Z0/UQKNnL6BNMC0e9q0x59C1IgvQdg1f8i+IBeVaiV04aNo
         sRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871177; x=1700475977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=676mWdBEBZG3vlmSr/WlK77gM7Ih8+1VUmGPee+ETx8=;
        b=chOya3VfCYASi47aTEyS6UbF3TQLx1pc0oza07fV8SZGgfxaCBHF31h/jhKrAtPhI8
         5YEATKL+MQnKa4Olg+SbgW2f7+LhrhqhGZ3mZoYu7L6Xi9DEOj4wAjlVRevwv5AD7FUG
         M7d5KAAtI2y0x0IQJDDLFBST2nPLO93RdI0o5MCd6oUB/982wlA75PBw1Wad5b+l2ClN
         Kk7UXR8ADhge5fjW/UyS8GxlUjn0m6Xp+jFOFQ8pekAYfRFGGBKOLm4IB+pCZeRBgJWF
         qpJZUHPljv/zZIgEJpZJksHoMrD2c8o7k68t8W7mgtzHfg/1ab+rF4f3jzZPvoODZWiy
         mdkQ==
X-Gm-Message-State: AOJu0YxdpjF2kRAd8PCoxkOe9aDGPAqa0fWjNa0gPjArsaNth0Q7IBmo
        HicITS+bbDTHSEEcndgUGMo=
X-Google-Smtp-Source: AGHT+IFiZGKPzSFocHuDLjkWopzGMcOQPUsdzIQhbStIxp43/mukSS2Iq5M1Yct5ueZmbbTPEhh3SA==
X-Received: by 2002:a05:6402:4c6:b0:540:54ef:43fd with SMTP id n6-20020a05640204c600b0054054ef43fdmr4329941edw.34.1699871176923;
        Mon, 13 Nov 2023 02:26:16 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7cfd4000000b005435c317fedsm3464940edy.80.2023.11.13.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:26:16 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: amplifiers: hmc425a: add support for ADRF5740 Attenuator
Date:   Mon, 13 Nov 2023 12:25:34 +0200
Message-Id: <20231113102535.51074-2-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
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

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

This adds support for the Analog Devices ADRF5740 2 dB LSB, 4-Bit,
Silicon Digital Attenuator, 10 MHz to 60 GHz.
The default (maximum) gain is also set at probe time, with GPIO lines
driven high to achieve maximum gain, in contrast to other devices
where GPIOs need to be driven low.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 drivers/iio/amplifiers/hmc425a.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index e87d35d50a95..ed4d72922696 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -5,6 +5,7 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -22,6 +23,7 @@
 enum hmc425a_type {
 	ID_HMC425A,
 	ID_HMC540S,
+	ID_ADRF5740
 };
 
 struct hmc425a_chip_info {
@@ -74,6 +76,10 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
 		case ID_HMC540S:
 			gain = ~code * -1000;
 			break;
+		case ID_ADRF5740:
+			code = code & BIT(3) ? code & ~BIT(2) : code;
+			gain = code * -2000;
+			break;
 		}
 
 		*val = gain / 1000;
@@ -113,6 +119,10 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 	case ID_HMC540S:
 		code = ~((abs(gain) / 1000) & 0xF);
 		break;
+	case ID_ADRF5740:
+		code = (abs(gain) / 2000) & 0xF;
+		code = code & BIT(3) ? code | BIT(2) : code;
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -165,6 +175,7 @@ static const struct iio_chan_spec hmc425a_channels[] = {
 static const struct of_device_id hmc425a_of_match[] = {
 	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
 	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
+	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
@@ -188,6 +199,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_max = 0,
 		.default_gain = -0x10, /* set default gain -15.0db*/
 	},
+	[ID_ADRF5740] = {
+		.name = "adrf5740",
+		.channels = hmc425a_channels,
+		.num_channels = ARRAY_SIZE(hmc425a_channels),
+		.num_gpios = 4,
+		.gain_min = -22000,
+		.gain_max = 0,
+		.default_gain = 0xF, /* set default gain -22.0db*/
+	},
 };
 
 static int hmc425a_probe(struct platform_device *pdev)
@@ -229,6 +249,9 @@ static int hmc425a_probe(struct platform_device *pdev)
 	indio_dev->info = &hmc425a_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Set default gain */
+	hmc425a_write(indio_dev, st->gain);
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.34.1

