Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0577AAC3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHMTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjHMTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:04:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE461703;
        Sun, 13 Aug 2023 12:04:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31965c94001so1472705f8f.3;
        Sun, 13 Aug 2023 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953493; x=1692558293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8YB+q6fVqTqNWWbQhr5Ldlkw+mPwEid201v9qRYkhA=;
        b=qYg4/Y3SWIucTefZvDwpfDoFKN7KRttDfZZX4g7Eu6qdFf3w2dFoAmqDm/lJb9jK32
         rwTdDjzOXfchXl3uznBvP8mc+4M3hhO++asllZGUWYDO4VqQ32CF7VAcLn5buBILDUKm
         gz71NFh7RVLtMHrQlZw97q3Q9akGzfr+qzCiMqCfuiAU3Jcam9IFGvNb2i0igS4pACys
         6u6lj8LQ5qsi0Re++mRqXkFyqCN06e18oUQ6Ny6v0aGyumXuPZN5adHlkUJ0PFVnP3cb
         XrEIKmIRY2UhKNtN1WyTWXNH+J8cRGDs2ROweUoLbj+g0ZTW+CezUwwM6EscdJDclqZK
         RS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953493; x=1692558293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8YB+q6fVqTqNWWbQhr5Ldlkw+mPwEid201v9qRYkhA=;
        b=WBpNmj41jIwV+bSgtSSTcuIgLmMtPAdLZi17FiU/Plab57ObnK5tCGaOTxj2HshsnI
         kGsAhDZeB/AipeB0T8t7G8/Ad8jFKBCtZDKAVy/j/1OCmw7sZL0Lk07eEv+6KieX0rOY
         a4Edxo7VKqP81pR5cHfw/4ro7FSSZvZwzfXb+KKIzuU2JcIFA/DxHuDNt5uGdXVEjO7C
         p+i+/wZyNFUcQynMc9o+zrPEICidarBCCZfKgCY38ZM7Jfdjd/dDRvEGEU8H5ar3NeP/
         AkRWdgKwUAwJf0WqGecfRHO6E7w9JBzH5G+9aomEmKIZArd6iXSFzXaTD6kh6fhzfS+F
         YI9w==
X-Gm-Message-State: AOJu0YwcVDKz1WRLejPPJ2mFlKHbd91ny+YCtAObo3OHQ+xC9mutP9fo
        DiqTf2V5jL+ga9xkM/nOuwpA6SClBdo=
X-Google-Smtp-Source: AGHT+IF9b4sOrElGwIPfET66tfJmLz7jCz6laN9soh8d2u+ljrobgEUwQadQguqb9/2mR1Qa6ca/cw==
X-Received: by 2002:adf:f490:0:b0:314:17cc:31d0 with SMTP id l16-20020adff490000000b0031417cc31d0mr5387952wro.34.1691953492932;
        Sun, 13 Aug 2023 12:04:52 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm12111678wru.107.2023.08.13.12.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:04:52 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Date:   Sun, 13 Aug 2023 21:03:55 +0200
Message-ID: <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
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

Replaces device_get_match_data() and fallback match_id logic by new
unified helper function i2c_get_match_data().

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 693eb1975fdc..34e3bc758493 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	const struct bmp280_chip_info *chip_info;
 	struct regmap *regmap;
 
-	chip_info = device_get_match_data(&client->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = i2c_get_match_data(client);
 
 	regmap = devm_regmap_init_i2c(client, chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.41.0

