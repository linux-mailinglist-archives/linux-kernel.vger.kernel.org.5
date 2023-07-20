Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63375B05F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGTNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGTNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:49:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF41FD5;
        Thu, 20 Jul 2023 06:49:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-521650a7603so1010342a12.3;
        Thu, 20 Jul 2023 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689860991; x=1690465791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxvRSshYBjetI3TaoXkBrxJO7jUYDGeMHAnhQ8Z7mI8=;
        b=BiiSH9olC1Qt3zhlKwZr9odcOTW3JXbqsPhzy9xh2na/MBQLx35nMm+kToVS8D4np7
         76vI/02W7BnFCBFCZcPjTdvokWC5XF94qmypXD0Tm+zKG40cn9MQemo6xvXyRfGhSmmg
         sklT9XVpu3J2MYSKe/hkAmpyNxvRjEfN/9dqoYoiXw8Gl1GNGhGJictL2k60fdAiubbS
         nUgEUgBSaY3ygPDvlUyi7/FdEUBGHy8X12BFxUPq27XEm++6i/zi/3+5T/sdLubaR5vt
         0DjcOsm0qCdR9iH4RBCzELjfGi04hdjgGh275Z/p2GOQguN0ZGSl/PCNCD2ElJt743zx
         +Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860991; x=1690465791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxvRSshYBjetI3TaoXkBrxJO7jUYDGeMHAnhQ8Z7mI8=;
        b=KCq3EihBFNqFj/NIpvhRnqN59SZA+N8DwOt5DL0EVAQb1vNeilHaO7YVSSwp8bjDqO
         JvyxIkErDwOBPi8Zdf1ZX1wjF+0EgFy0xbqckvEp1gepGLcbw2Zkmlo5M0g/rwfPmGfe
         8gbHtMRFfwODkyOAewGsbFzqQwokCLZHf7WasfeVLWFTt+5Wdh6h3GjXlOdF/iueDGBA
         MsO90OO2UFwYhmv5+tQNrxTmbNyySv4OTW/LA+CEW5OIkvENKvkFM0LwwI3e9iXrmmy4
         ZWREblu8CCY3nlLXHsPj8ozma3Vimn4f3LMVBiFEfqaRFE7uWSH01+dSy/s0TsBOJGaf
         D2Tw==
X-Gm-Message-State: ABy/qLag9y/bRr0jKc9Vs6JkIwP1kALZm2VxyuDwIPldfedK0aQ8HwTM
        zumYUpCtAKOEgZenkZY3g3auPteTdgb4tw==
X-Google-Smtp-Source: APBJJlGK0CUz5nj9uYVheB7WVKn0XHJWwqd09SLQbm4FspmSWRtwz+UwXCZUKLl0PrKguPsMyYGg0A==
X-Received: by 2002:a17:906:5357:b0:992:ab3a:f0d4 with SMTP id j23-20020a170906535700b00992ab3af0d4mr2331420ejo.17.1689860990530;
        Thu, 20 Jul 2023 06:49:50 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906855900b00993017b64a9sm717663ejy.223.2023.07.20.06.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:49:49 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio :mlxbf2: remove unneeded platform_set_drvdata() call
Date:   Thu, 20 Jul 2023 16:48:45 +0300
Message-Id: <20230720134845.23727-1-aboutphysycs@gmail.com>
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
platform_get_drvdata() call to access the private data of the driver.
Also, the private data is defined in this driver, so there is no risk of
it being accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-mlxbf2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 6abe01bc39c3..cf91b6e74d88 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -420,8 +420,6 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, gs);
-
 	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
 	if (ret) {
 		dev_err(dev, "Failed adding memory mapped gpiochip\n");
-- 
2.34.1

