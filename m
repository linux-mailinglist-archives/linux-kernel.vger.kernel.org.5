Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92535761873
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjGYMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGYMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:36:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C011A;
        Tue, 25 Jul 2023 05:36:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3176a439606so714019f8f.3;
        Tue, 25 Jul 2023 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690288600; x=1690893400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4fmEupfiQyKnSK5Kyg9rCV7EW8/GVgeB9eIhTVv0HQ=;
        b=Zyl3W4KbS5elwBKsCvfymuiSu+4vJA2EIqv8BmJxSAdTMhJWP+V0ylwgcdTJhsigjh
         jSO1NLqCViWsT7NqUSJqkRcdFdLu1T8HNsCbOGwaC3mFlY+H7YEk6k5+JuEZk2aIRlEa
         epxuKDVKs3WskJt4wws5yppM3N+tA0lf62UsAagqHmz4nUzfqrQmNFgom88EcSgRu5lD
         jU7QlQ6dZ5XKcN8qBcGZxxAXvSuAkjTnNsUiyun6mE3dc3b50FKA6G3h35KVgd5+GMRK
         OM+8lxhUh/a20BNycrsFYLpXcCGjRCdk6JU/q1bmtTJBkP7pTXjbX+R8+2uUqddPBgu9
         Bf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288600; x=1690893400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4fmEupfiQyKnSK5Kyg9rCV7EW8/GVgeB9eIhTVv0HQ=;
        b=YKd0Y7ofXgTRPfSDowy4dZmBbM1YUdYHM7KKUAgxZ1yuVNng3SDL0rODBfYr6XU6Fy
         gd79+SBsoRnPOi1q4ClM6TNJfijwc0AKUFad1FCv7hY9NNq9xD8wtry+ZaTAYdoPkVj2
         ml/Jb8amPSnA+vMZQTocvOUp5USfDHfsapFcddBwTvEKs/VZmZyxc9KwN8izOVxjIvPI
         lNZB1+5gb1vTNM5L5LH4ZnKjwuFe3UGftJNULqlb/vj1bOJdqxoK8Ta0fbg2IP7X3vqO
         Vk8cUmpVZdAToVfbRyvwNya1bJ8SmSi7HQppeJm2Tzx7wH6p4eOfswQMjQoIrqhxyBiN
         Fj/Q==
X-Gm-Message-State: ABy/qLZho6aSh+hmS+4dyl8TtG35iYWoUqqxeAKZaJarzjgLWLIvPhoH
        n8fQ7DsvFeoc2lkFmcelElCAwUA2KnyJpg==
X-Google-Smtp-Source: APBJJlGyBl1KXZX7BOzGgdeRbpCxKZyk5QBRHwoHIuCd2DOv0oxzhLRB8dXhKQpAx8GJgz1Sh4+qMA==
X-Received: by 2002:a5d:4526:0:b0:317:630f:de0c with SMTP id j6-20020a5d4526000000b00317630fde0cmr3072582wra.44.1690288599448;
        Tue, 25 Jul 2023 05:36:39 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b0031424f4ef1dsm16411345wrn.19.2023.07.25.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:36:39 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2] gpio: max77620: remove unneeded platform_set_drvdata() call
Date:   Tue, 25 Jul 2023 15:36:23 +0300
Message-Id: <20230725123623.6411-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call is not required because no counterpart
platform_get_drvdata() call is present to leverage the private data of
the driver.
Since the private data is confined to this driver file, external access
is not feasible.
The use of this function appears redundant in the current context of the
driver's implementation.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---

Changelog V1->V2:

* https://lore.kernel.org/linux-gpio/20230720132535.23413-1-aboutphysycs@gmail.com/ 
* fixed subject line: adjusted colons where needed

 drivers/gpio/gpio-max77620.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index c18b60e39a94..8c2a5609161f 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -331,8 +331,6 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	girq->init_hw = max77620_gpio_irq_init_hw;
 	girq->threaded = true;
 
-	platform_set_drvdata(pdev, mgpio);
-
 	ret = devm_gpiochip_add_data(&pdev->dev, &mgpio->gpio_chip, mgpio);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "gpio_init: Failed to add max77620_gpio\n");
-- 
2.34.1

