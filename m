Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0577C99BF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJOPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjJOPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:18:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F19F5;
        Sun, 15 Oct 2023 08:18:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so40329875e9.3;
        Sun, 15 Oct 2023 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383094; x=1697987894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2no0yowA3lGSRYKd2XnR+vjmcZErrr5k9KrUOlR237s=;
        b=YEz+0dVCd98HgxT5Fm++IXCiCGydtCQjxYQR9jAi/OmjcXfEa/VNmnV7RQaEbLIYz5
         VZzYddcLgDa98hNLHimYSOyBwrfVonWzxJoQXgMocJplkKzrUJuQcwnzQiREQr7rp/Xk
         ELBcDb0iKk7y7OPxtTL4lCg2HbncQetLeNGrFTlcIHinuo8RAdJN2oRdVE6WFVZv8Pfn
         kLtXz5/H0g4wqBTpjSoqoomW9zPYDcg9WLekYAluBmXhj2o9f8uPygNCigwZuuwAGPcq
         J4GFK7+Ys3I4bpjHtHgFqGLdojrlSAXnCpFsBGcwuBPfGimRRg09r+2kUf/Y/B8BM5f7
         u6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383094; x=1697987894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2no0yowA3lGSRYKd2XnR+vjmcZErrr5k9KrUOlR237s=;
        b=UT8XptV5YltIAjPwo5VSwrRdD5/ag7EGSZz9d2Kn3fNUUKyCQiDDfgL3y/YFaCH6+e
         jzTZZ+XWvzJPzupc5fQVNL14fJ5IjezizMV1NzfOD304ngYVIR/c0mvpdvT9ZqT728LJ
         bWI6vNs+4yFvu+GSJFtE0DoQEFGRu5b31bvNn6f2aMJUDR56tGxCSw9Gsa2AZ8fARMw+
         HzxaD/YtWuGP6gtj4rftr2VWMU5F/HwNDKTq3awIeuVcvdxOkbZki7RwmT1ZJfeNtAY/
         QC9RHu3FtrrzFNUwWMySmSy2c50QJyRt8mwL9JaTFSrP02f+pvnxfzhK6Vc1wK/L/NOE
         d0eA==
X-Gm-Message-State: AOJu0YynmWRLMWY+fiK+6DD8bwzxC7DWgWKWH6V6gHVn9XiYSnwCS9iG
        6vI6PFZLkXmoX2BMrax9JSKoBGYw6OA=
X-Google-Smtp-Source: AGHT+IH51KFZBCDp8L+Fmb1DEJVofovwBikpQNVLxXIdZSEJ/sC9YckYnbwPbbQ4k0eJkqfLG3lFyA==
X-Received: by 2002:a05:600c:259:b0:403:b64:ad0a with SMTP id 25-20020a05600c025900b004030b64ad0amr25954953wmj.26.1697383093909;
        Sun, 15 Oct 2023 08:18:13 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:18:13 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 5/5] iio: pressure: bmp280: Add support for BMP390
Date:   Sun, 15 Oct 2023 17:16:27 +0200
Message-ID: <defa66c54aeecb7dddfc8a3865b075e84cc32725.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BMP390 device ID to the supported IDs on bmp380 sensor family

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e3bb4d7906a9..d2345956ebc8 100644
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
-static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID };
+static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a230fcfc4a85..2971bf58f802 100644
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

