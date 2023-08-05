Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27F7712FB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjHEXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHEXPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:15:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31A2120;
        Sat,  5 Aug 2023 16:15:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso5584247e87.2;
        Sat, 05 Aug 2023 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691277319; x=1691882119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhe3k7N6Zudq4d/t7ExDf16kdAR6Hv2A6e2F4vngjQY=;
        b=YWBvoYpa/M2LeZSO0wmxlBmS4HVBByAUStNuCHphyZgobdUE8mIdiB2SjYUclSBeYW
         zpEVmYu2xrsOZI+MzHz1SFzDUspr+FNjG/L/Ynp/wLFp7QjrDYbGVWe0CW9ypTwSBjqA
         p9gQaWikLDm16XjigKEupiUHe8pSjpHNhmNHtdQCuPDPTUjB5bExtOw/pWjdQd0K1KbF
         vljnC0zj5ix1EyOkrNc0FaGLo8RD8oo6/XLf49vhpnUsAX3np0XDJIAl4yb1QBtWPPxL
         jnNyArei3Tmtu4pRz933V8wEjrtDbE0yVwKlx4RqI4HNR8blxBEqPhLURAXCFu3GMsYQ
         5U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691277319; x=1691882119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhe3k7N6Zudq4d/t7ExDf16kdAR6Hv2A6e2F4vngjQY=;
        b=ILfUyI9nWr5M5g5OUi9vCpVLd/7EFFCy8qSv6J9kUMsuMvzcQ/ez7pQ3Y1hmbnimr3
         gYDB5wJP8jZZmnAdFlPUK0vLsa06D+qoXYcPJUARogxMQ5bpwieA2F9qV7UwuL30euLj
         IwDNsikcdBaFxPy7Jf7QpRLGtOuDZ0p9Uo4AsRGa7rRH/OCTW1aXhqYgE+VXUOsvLyhF
         QsSm1kN5MKyvpmJlAuWkdzvd37lzNBoKswGDMzWnwlmeUw0Bruy+bMQfDfqow/NhOJ+j
         QW4oRLx7SUOdzl8veNNi+i6Mf2ympiQfezlyZUXg07BqmqDUggmu6ROxVxbmB6a9lWMF
         ryzQ==
X-Gm-Message-State: AOJu0Yyja23oTPRhPyiriFTp9aT9ROoUXdifOuCWWRzP+mWfEO1ysrP+
        BIxHs1bA5qLJcoraHLG6itFWO5g7rEw=
X-Google-Smtp-Source: AGHT+IHNiVBO9XT0BL7AOhaa5lD/J6dWqynwTVGcBFwKCtq0BZ/r8DcmsQ4GQNJCmW6DL/fxXdemxw==
X-Received: by 2002:a19:8c5a:0:b0:4fb:889c:c53d with SMTP id i26-20020a198c5a000000b004fb889cc53dmr3497341lfj.10.1691277318747;
        Sat, 05 Aug 2023 16:15:18 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (89.red-83-35-60.dynamicip.rima-tde.net. [83.35.60.89])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm6212531wro.3.2023.08.05.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 16:15:18 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: pressure: bmp280: i2c: Rearrange vars in reverse xmas tree order
Date:   Sun,  6 Aug 2023 01:15:02 +0200
Message-ID: <80c7bf32dee57a4a21e5c623b9adbc5e1175f2de.1691276610.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691276610.git.ang.iglesiasg@gmail.com>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
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

Minor cleanup reordering local variable declarations following reverse
christmas tree convention.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index dbe630ad05b5..693eb1975fdc 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -7,9 +7,9 @@
 
 static int bmp280_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
-	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct bmp280_chip_info *chip_info;
+	struct regmap *regmap;
 
 	chip_info = device_get_match_data(&client->dev);
 	if (!chip_info)
-- 
2.41.0

