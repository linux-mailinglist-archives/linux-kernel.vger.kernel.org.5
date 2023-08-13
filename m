Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2877AAC6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjHMTFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjHMTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:05:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CEC1708;
        Sun, 13 Aug 2023 12:04:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso34064215e9.0;
        Sun, 13 Aug 2023 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953497; x=1692558297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0YioFxfrQNoWhYJLctdcMwWLrNlPOgKU0KVIAKARic=;
        b=eouFrZkWNTsq3yIsbTMErask3onhLhMEfCyXEiTRIbW2jz13bNQTMjJjDE/Qq/24/9
         y0KxbpzhkNvlndVRGLKoHpiDcaNDwb2OopCYJGEPL30kn98l8rIoA7hcxcjTygjW7Mic
         1FjyPQrZ4tq2FSD8gB9piYDYjEKqYTxGmIvgFQOJRtr/SdudtR9vewb5/+RUGAZIUyrz
         aZMhxK1uXt+fDJkAvDs8c/YZwsW++zaVSorcE7WxTnvsEOOYSpNUuaruTD6T04Mdmq89
         jDrysFkvPgi2ghCQuJRQ8bJ8NnqfOocaOrNBVpDBJug6YOVI1D65ZXrcYndQcA5jq6TW
         p+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953497; x=1692558297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0YioFxfrQNoWhYJLctdcMwWLrNlPOgKU0KVIAKARic=;
        b=GZrkxjzRfAvg/4bH5Q6i2mJWD7KvTbLv9h0W7FqF2BgJQM4DAO1EC8AhvqHH6OpE8p
         W3GfORU3lkm1jvde+cFt+Sz/CZdEvBW4GLrnt07G4P/ZuvuGRcqOcsxJ7MzEeYsVF9q5
         miDWQOlhNw7Z7ZiR/kh4YvBuwBXFUAgzuwU+Dp6mJqoATbHiSpdjR0j9jTfc9dwYVeZA
         3p9m27KkBU6/rrPB9B+eRvYGdMmP7AOVQXhNmaR3a/lVwYC2e3iAOARsm0nv/cSgBEXm
         Rt+9aqlVszsTXNgNx4Eu/Al6CCXdLeO1kVhllK06yrxSzhFEX/oxuC0VCHqR5TXeM2il
         WqCw==
X-Gm-Message-State: AOJu0YxGMSS4Zul5F8KVSx8EOWwPFsxeQFgwyP75P7xGpnXzeM7LB5IN
        BDKMbZHFMDRYKR1P+JG3msFfXibSQYM=
X-Google-Smtp-Source: AGHT+IE2/XaPFk4bP5bobaVECHC+Mr3zC29w9R5lm78CDO2BMKjRcex8In/3+daNQJpFslDncKLWOg==
X-Received: by 2002:adf:e6c7:0:b0:314:10d8:b482 with SMTP id y7-20020adfe6c7000000b0031410d8b482mr5491655wrm.65.1691953497345;
        Sun, 13 Aug 2023 12:04:57 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm12111678wru.107.2023.08.13.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:04:57 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 3/3] iio: pressure: bmp280: Use spi_get_device_match_data()
Date:   Sun, 13 Aug 2023 21:03:56 +0200
Message-ID: <655dde2866d7d28c233eeca507b3d59e90584b74.1691952005.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691952005.git.ang.iglesiasg@gmail.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
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

Use the spi_get_device_match_data() helper instead of
device_get_match_data() and the fallback match_id logic.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 1c9c01f1b1c7..433d6fac83c4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -56,9 +56,7 @@ static int bmp280_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	chip_info = device_get_match_data(&spi->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = spi_get_device_match_data(spi);
 
 	regmap = devm_regmap_init(&spi->dev,
 				  &bmp280_regmap_bus,
-- 
2.41.0

