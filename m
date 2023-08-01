Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BD76BEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHAUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjHAUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:43:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8566198A;
        Tue,  1 Aug 2023 13:43:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so9687309e87.3;
        Tue, 01 Aug 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922627; x=1691527427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNd5c57AON0zLDGVNskCRqDS5DSWPtgyT6et2Ew3gqI=;
        b=fCOyxqEvbG/08yslzsnSvRyomiGz1K9WbSGh0gzRJsERe7sB7OcKGZQpkV5Izqkqrp
         TQMhzOTAm5K/S1xbiBTBZsehyc5V0Tz7aNWGdTpRDGo+WJBqrHkYFng5WumI8S/wE5qZ
         MEaxFMO26WeKXcWAvuEX73EIes7lZER8w45gkp1lTmGStzoUVAxfSkr8UwRONSa1EXf7
         NqC7O0lIarjR7fiiMPUMSAlzo/QpZ6AoKvCh9JHcgMY/H2smXZh72X5DxmNmYCDmOPno
         9XDRjPkcVqQGHBpmJQusct6D6xQjvQqkSxd18tiovW/JG9mEe3XfR9gxWYiQI7klW7Ia
         7iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922627; x=1691527427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNd5c57AON0zLDGVNskCRqDS5DSWPtgyT6et2Ew3gqI=;
        b=NDrQ9WA/tKiSyjS7gS1bETsrXrGYJkuxeG4dOScvNZsml/v/sgfzxt1CDZtuhc9gHW
         ZQwQXpj6EoLjTt18nM7Uji7KyXk8/TiUuQ78aOUGowLxau/OzaQS3GaP77FT01uM2xYM
         RcjX1278dhpo5XG93fwrW7NkinSWnhnCCs27wm8UmFPTre5freSN6p5/hgmCZGW4HiZR
         +3BGkt4rD6Xuo8b3Enejd8WTDPdVV/UGs+H02n6uiKlxOAPXj3KlzXMaeGNST5vKEdEH
         7ls3ya66fsgDdXxVV7Kv95rfDNM3Zs9RHFWpGUYnsOQu6mKgWIS7zdKhVGCv4dD0Glbz
         hK7Q==
X-Gm-Message-State: ABy/qLYshVfDSZrw3ycYUQg2Pl9Btto1e5Mbd0iC+jgtEu/XzFgwPeeW
        Qttw2ELKWAEl2KIb81IR8QKP0QiPbmyk8g==
X-Google-Smtp-Source: APBJJlHustI3PQFW3+M7Yt2l37ptbAyu9DAzasRdrkrueAzbaQHVMajGhiEJTTc4UzA3BOj8q4Y/uQ==
X-Received: by 2002:ac2:4e06:0:b0:4fe:993:2218 with SMTP id e6-20020ac24e06000000b004fe09932218mr3587417lfr.31.1690922626431;
        Tue, 01 Aug 2023 13:43:46 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7d6c4000000b0051e2cde9e3esm7384740edr.75.2023.08.01.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:43:46 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: tqmx86: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 23:38:39 +0300
Message-Id: <20230801203839.9502-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-tqmx86.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 6f8bd1155db7..3a28c1f273c3 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -277,8 +277,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 
 	tqmx86_gpio_write(gpio, (u8)~TQMX86_DIR_INPUT_MASK, TQMX86_GPIODD);
 
-	platform_set_drvdata(pdev, gpio);
-
 	chip = &gpio->chip;
 	chip->label = "gpio-tqmx86";
 	chip->owner = THIS_MODULE;
-- 
2.34.1

