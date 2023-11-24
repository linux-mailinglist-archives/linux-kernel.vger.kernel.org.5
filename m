Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCC7F86A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKXXZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:25:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A110DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:25:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso3597557e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700868348; x=1701473148; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JG09yndkEu639f4KTRkyZKsAldPT0yw1/lGIrHycfbc=;
        b=w7IgrSt823VjG7s3oVAFRbVPz3Tl4EH0Ph8ZLgnYklpviAMiB9sdhYuAt7Prn/q7LH
         zIOZEtzvqEky3+pDjCXWTJjulkQK18c/YTKDkoS1XWuMndBAZoEkilH01E5gTfLCd9fE
         zQKZ2WtKpqmKMDu8s+p95NWZulG+evca+BSSwHcIBm4spACmu7VS2ubo6u296Akkd+br
         ZJZ13MQjbIDz0wSaQDqXV8wo7hqycljr+QokySB4RfQJLYRj5ClxLZ7aHLZhP7wtp8HF
         +ccxWo0tdmOUIBJeA4WqbSk34fM1t7DnI6z5iBQ6nNUCHCuCv8RoUt8dqL/qBtB5YDrW
         GK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700868348; x=1701473148;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG09yndkEu639f4KTRkyZKsAldPT0yw1/lGIrHycfbc=;
        b=dg4V3ipX03RbzVQLCTlvazjpltjyJD9+GR101Lldw3z+AbMCIYJDacJs9UGnpFsOUk
         7yW+/LFki5R0Lzs/a2kCw3TgPet4krz7vM/aVCH6r3wiFEuX1LvQ3C8AIpSmQcYyiLAZ
         20S57K94IJ2uc19d4JJSoZ7kAkRzR8SXID/7jZC8bV1l7gWbi53z5fEwEREuBIYaOJzV
         h3WH0poxK0I8lD7XcSh/cfWdLmuiuDPKmrS9OSj0cH1iC1di3Gu5qYY4g6LHLG+TjnYv
         01AQpftY2s/49uS0Gubh8d6tQAUINxW38R8A6+L4x/jvBjFKQz/8J4YPaPhYerSt6MvI
         nZrQ==
X-Gm-Message-State: AOJu0Yzu/0pE7w1VEfGMrd2KS10+7bVmKcO6UOJWHQUCFxjXhKlGvPr6
        jfpJcz//WxAHpZwWCSvcK5b2fhZW3bttHtORmhc=
X-Google-Smtp-Source: AGHT+IHL4UO5xgya8QptvShrVia42MIQfcwsotShbKqPYeoh6HTSXN4MOL6Tq2601Y12IebD1WZlig==
X-Received: by 2002:a05:6512:1314:b0:507:ae8b:a573 with SMTP id x20-20020a056512131400b00507ae8ba573mr4116472lfu.51.1700868348344;
        Fri, 24 Nov 2023 15:25:48 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b0050949e41d36sm635489lfs.253.2023.11.24.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:25:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Nov 2023 00:25:47 +0100
Subject: [PATCH] gpiolib: Drop cargo-culted comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-dropcomment-v1-1-15800415aae0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPowYWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNT3ZSi/ILk/Nzc1LwSXQvLVNMk8yST5GTjNCWgjoKi1LTMCrBp0bG
 1tQDNwiCXXQAAAA==
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment about the gpio_lock is just completely confusing and
misleading. This refers to a gpio_desc that would in 2008 be used
to hold the list of gpio_chips, but nowadays gpio_desc refers to
descriptors of individual GPIO lines and this comment is completely
unparseable. Delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 95d2a7b2ea3e..1c47af866bf6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -86,10 +86,6 @@ static struct bus_type gpio_bus_type = {
  */
 #define FASTPATH_NGPIO CONFIG_GPIOLIB_FASTPATH_LIMIT
 
-/* gpio_lock prevents conflicts during gpio_desc[] table updates.
- * While any GPIO is requested, its gpio_chip is not removable;
- * each GPIO's "requested" flag serves as a lock and refcount.
- */
 DEFINE_SPINLOCK(gpio_lock);
 
 static DEFINE_MUTEX(gpio_lookup_lock);

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231125-dropcomment-89e5b7b4cc3f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

