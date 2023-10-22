Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F447D24DF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjJVRXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjJVRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425C13E;
        Sun, 22 Oct 2023 10:23:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso1818860f8f.0;
        Sun, 22 Oct 2023 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995388; x=1698600188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR1rbIRAVPmg6FZUklnnnduo61uGU5Ugg06WBamDHUw=;
        b=RKs4pyD48fYg8PLKWvvb+7iky1q34Gg+JrikWsyCdEtuj2kuKq0R/RTJtenwFp7HI8
         szI7nQ00OhnzjyYUPnTiGeHlq+aQHvoAzk1HqS84UEYWL7LaiolsJkBbT028O641Sldx
         lTAo5D9PAq3ACORRa4JnD1rrXZFRe8LLciOGOFOARG08K+1IBKoCtG1YY8qu493WQuXR
         dvZhUBTS9R02XOy6YRF2yo06wWaB54RZJgRC9Ylg9PI7oo3/kTYGsC7C8c47jEKQqlUu
         48ZVppKik86X+VUrnBdjm0tOIslqALl7WodOXq2e/OxuNDOBIC2vH1YYfCSO1+qEVh0Z
         MSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995388; x=1698600188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR1rbIRAVPmg6FZUklnnnduo61uGU5Ugg06WBamDHUw=;
        b=ojj5gUuwlwBhCFNIJMxCJEznsJgfao7zSSNxcE8B+ZIog10uxZE7dqEqOhq7+Z06NW
         AfZLu4SU4mtzu/mlp2ml3Ssqy5lDopYXh23TBRu6VjeqH1HKIaKm/KxwefEMMp30uETa
         d0ZPvYx+tyhMT3KXPC7nHahBv2xi/IBRHzdRBbJ8qkMFxcvUJKBoEF1lpNd6ZIzzkKXM
         BH4RojBy0L4S3e0dzb7D2NTmHdO/egVGu6c4Zi/fYVa9VyvO9nfDRH8uVkZ9PQ3S4akQ
         JB6WDquAh4loYq19p/ScNV1LmZ/tU/jkWXW8MFon/U+3gv7gZdbp6y5j1aoawQezSlP9
         tNpA==
X-Gm-Message-State: AOJu0Yzyo7HUEIWlO7f5DPYWNw0qn8OiwD5Qb0UbKMCJ5p3akaWR5hNN
        DT7RCKkpoARTEweb6YzGX7cOu6Q3mNs=
X-Google-Smtp-Source: AGHT+IHKXkwcFSqiGLw9BE2OaR2A81h471j3cwpibbjiSufBeLaZEit2tS4ICIKb52ku2A0mBjhg5Q==
X-Received: by 2002:a5d:43c2:0:b0:32d:804c:15d1 with SMTP id v2-20020a5d43c2000000b0032d804c15d1mr5051743wrr.47.1697995387780;
        Sun, 22 Oct 2023 10:23:07 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:07 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 1/5] iio: pressure: bmp280: Use i2c_get_match_data()
Date:   Sun, 22 Oct 2023 19:22:17 +0200
Message-ID: <0554ddae62ba04ccacf58c2de04ec598c876665e.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace device_get_match_data() and id lookup for retrieving match data
by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index dbe630ad05b5..b3e069730f97 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
-	chip_info = device_get_match_data(&client->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = i2c_get_match_data(client);
 
 	regmap = devm_regmap_init_i2c(client, chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.42.0

