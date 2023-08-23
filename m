Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28715785CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjHWP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjHWP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:59:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5710C1;
        Wed, 23 Aug 2023 08:59:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso3684505e9.2;
        Wed, 23 Aug 2023 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806339; x=1693411139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDcQFVm5HdglSU0dZiKU1iAD22HC6I1kyuCmnz9csnQ=;
        b=h0SUl/VCmypPZaNRwY1nv4rcSwMvtdlO5R+R+9IfLNkiID/ItjgFZri7FcEbeSMmig
         D3oAYgbTQ7Yq47jhR7hm1EuRONTmRVow9u44b5iUnsLsu/+LkPKFBTh7D0b6u9zYtYv9
         EnMWKHaQQ/HVa+wkUEVzXYqvY1XVrLnyssfG3ZhHrxmiBm3PJUbBHfCl8OGVfAc2Z6M3
         hYM7qXu9DfQlgu0NUgB3Qh6Axf7a8ZoPm4OE3H9Xeha+FLT5BNpM4HwOtDZvi+lAX9MW
         FItpPCCahbZNFcQFFAa8F26HRT8Meq53cIcjtNgo1sZWvuzmdJ7pmV0SIUjsN8HUTUT/
         cdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806339; x=1693411139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDcQFVm5HdglSU0dZiKU1iAD22HC6I1kyuCmnz9csnQ=;
        b=mFxi8jl+IXLUsfxwA0i/+i+xot704BSJgWjdKCKb3/HZf/rAqw54CSui8mfhK+RhOC
         S1U5CDWEOD2tTvHWDOqlMfZ+tF/rI8SeW50C7pqQhhDfyuKRY8hGnPUFyee+3kz3MuMw
         +YatLZhN1ExJGqrIDzNYB+IxdJRBhPYlxR3XlhioJXoVIkIDrXdULrwR9vasXBt56VzL
         XPY14rGRfBMm9dflImUjud/xuAJbQetU6dapkqYCe6ZbNiMFlvq0KQyVNdJND0Rnji1q
         Wo8faoLQSJJouMKctX29ZyfsIWViIpKkXGhOJhKi9M3agf4fdDHQ7DB+cEefpqPNunV1
         vQLA==
X-Gm-Message-State: AOJu0YzshcpsjYUQgeETOY/Rhcy0lCWuuLhVc+ralrMdcJ3uO18q8Q/m
        jyxLdIQh8KU9/V324D5Aj0X2h5ZlNco=
X-Google-Smtp-Source: AGHT+IH08pv5jEnSd9N0g0myKkPsS+O7VIKhyG1EAZOsEbSxNy2qjpsRjLezPQ8ipXwBTiKDprDkQA==
X-Received: by 2002:a05:600c:28b:b0:3fe:2108:eb8e with SMTP id 11-20020a05600c028b00b003fe2108eb8emr10108210wmk.34.1692806338837;
        Wed, 23 Aug 2023 08:58:58 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fe195cecb3sm17044613wmj.38.2023.08.23.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:58:58 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] iio: pressure: bmp280: Add support for BMP390
Date:   Wed, 23 Aug 2023 17:58:07 +0200
Message-ID: <52adecef119e65e145669925e4a355a84e7f84d9.1692805377.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692805377.git.ang.iglesiasg@gmail.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds BMP390 device id to the supported ids on bmp380 sensor family

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4a544a20d6cb..d679a5644d16 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -13,6 +13,7 @@
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp390-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp581-ds004.pdf
  *
  * Notice:
@@ -1226,7 +1227,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
-static const uint8_t bmp380_chip_ids[] = { BMP380_CHIP_ID };
+static const uint8_t bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index c2acc9315223..d536e123ef14 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -292,6 +292,7 @@
 #define BMP580_CHIP_ID_ALT		0x51
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
+#define BMP390_CHIP_ID			0x60
 #define BME280_CHIP_ID			0x60
 #define BMP280_SOFT_RESET_VAL		0xB6
 
-- 
2.42.0

