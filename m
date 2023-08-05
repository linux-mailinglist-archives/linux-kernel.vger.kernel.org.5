Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE91B7712FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHEXP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHEXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:15:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D426BE;
        Sat,  5 Aug 2023 16:15:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so13360155e9.1;
        Sat, 05 Aug 2023 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691277343; x=1691882143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLYg/J+UJ6fbY/mN9HM7bVyp2sfI4lnm/dmzqkwlIjY=;
        b=H3ug8b0CDCTepLMQsXNP2LkonvE8Y1AJvRJ8q5Sa1DgdXuaKoUGfdeZxRfGyW4zXAD
         4d/Cr2HToB5v6VnWHhQiM3pOhOPlR4JGOlJRmRGLXNavcEzA5WsTJygBDiIDlG2675zs
         prWx7iI2ILpz2ZG28ImDaEE3lnFZyMQxl5INF3azCejE1zsywvc/RePKC2+gc2vRl1NZ
         kTs0kQ5PMmnk5nci4Ao3h8F/QZwxdhZ9J6C5r2cBjeyg02Z0kG3FFkH1t3kjfKC1D8Cq
         hdYBKPf9RQHVf0egXPLpHvEWhkK39GhCOaJvg5/hORoluEiwgsSTkXVJBMNRZ+jQ97UB
         lTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691277343; x=1691882143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLYg/J+UJ6fbY/mN9HM7bVyp2sfI4lnm/dmzqkwlIjY=;
        b=OeAbJE/xK6nEr5mI2wJ9n9yokon1zYnjRVoTg0y3/xuPQYSNGz9dLT6NuFf6V3jl37
         Vr9q675BmRzB2bZdd2aUioNpIIk5BCFgp1IzkSJAGk3YB7KTxMHKRmB5+EAlC3fcM03Y
         Cyv2dvDkiLf9GMXdS7eZwDpO5gCW0En1nKROIge2uFSls/Gf+lR5o5YrLojzan0z7ywq
         DOVaHF9nwoa0JaRSqfybET1FBdqtbsk+qcDeuktOTuIS75F+hmEA1XjgzWp7pUw4OTKe
         prkh5au8znO092Yf/uQ1Jq2eRjNaP902Cnic853raT3sP5UvRyVO7X0Ftrk+mc5pf19K
         hk4g==
X-Gm-Message-State: AOJu0YypoCFidl12pbKVDBTHjEa4Spmu6ASgMf9RAmUWXUuSembL54BK
        AT7Pd18zo6K7wfdnDi7vK5eGEcaS0gw=
X-Google-Smtp-Source: AGHT+IFlxP+wGNHdHStcPnqROvQbpKscKDaAOAhTsJ+MrJL5NYJLHY+zLvPS2+4edL+v4KL9A3Va/A==
X-Received: by 2002:a5d:408b:0:b0:317:6653:60b8 with SMTP id o11-20020a5d408b000000b00317665360b8mr3450975wrp.50.1691277342682;
        Sat, 05 Aug 2023 16:15:42 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (89.red-83-35-60.dynamicip.rima-tde.net. [83.35.60.89])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm6212531wro.3.2023.08.05.16.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 16:15:42 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: pressure: bmp280: Use i2c_get_match_data
Date:   Sun,  6 Aug 2023 01:15:03 +0200
Message-ID: <b3483bd87093d4cd0862904b70a167ebbb538644.1691276610.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691276610.git.ang.iglesiasg@gmail.com>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
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

Replaces device_get_match_data() and fallback match_id logic by new
unified helper function i2c_get_match_data().

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 693eb1975fdc..4ebaa4edc4fc 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -11,9 +11,9 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	const struct bmp280_chip_info *chip_info;
 	struct regmap *regmap;
 
-	chip_info = device_get_match_data(&client->dev);
+	chip_info = i2c_get_match_data(client);
 	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client, chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.41.0

