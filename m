Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55D761865
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGYMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjGYMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:31:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F06172E;
        Tue, 25 Jul 2023 05:31:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso35553075e9.0;
        Tue, 25 Jul 2023 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690288264; x=1690893064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcyVN5jjkcBHnJbRI3N7PWgbLb9r9f1m41jxH2AGzLA=;
        b=ZeSrLNXuDLsbT27CUFFw52MHcHBHFpDVlB92ncPMCkPHcmnXgyyJMtGfKRTqSuHzpJ
         15xkK04hkvzI9az6CB4BwQu+/i7w1Uud72UHIPmrpAhYHWAHtRHtXNNipwknwmAnb9hh
         whtJ7wasmRsPapogG63I/SRSv6u0GPI4+rN8W1OWJlqZ9rgtYfsy3B90vuesjg4W7rP2
         5bfG2MR6EtdxlMALJ3F9UjNgrr1sy2xS/aoi9slulnguMrKVWjYvpQyTwinP5cKvzzZa
         q722Qp+W0h0vLozV9djT+6/aKQroGOKHwd1KxKG8mbozTH/LioDtCrfCOcUpkeSXghqs
         pqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288264; x=1690893064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcyVN5jjkcBHnJbRI3N7PWgbLb9r9f1m41jxH2AGzLA=;
        b=KuoeETLiwfFfyMO4LGXTsv80dut8UTc1CsSCBZsXcbaEmvZwpsU7lafH44QEy+lgGE
         q28xee9iG5KJNSpITchlPu8MCtKeeiNbPvnAd/puSnk/dePNMJI/ngKUMJgnm3hPbmJG
         QDtHYIK0AvR05kZ6LmOAoEFPwptRvrAPymCc4+ETIVhcfkfBLybCxjzzPzJuVZCDVI3q
         X8bR4MGAvnzxLmurQb6KjSJBNlskS3MAg5PEa4Z0lRGiNtKoiRsaFjYGqdpMyVrM6xj7
         hB9OC0J7avrdpxJqqvijqJ1UZwPhwcu8K7umHfKSkRxZfE6TAQ3uEvaBIckzgsQeg7Ko
         oa6w==
X-Gm-Message-State: ABy/qLZvFOOIObb1zgGKV6+Pqp97M4endjqd3Yla8/XFA6CBEBWbpdzu
        i+fCEn1D5vIUumSOyJyIIFuwlxh+Vj1x8g==
X-Google-Smtp-Source: APBJJlECt/mC+pfnaNTqb5YCyiY2f6/0UB1ZNr0K4AYa36nGt4+AdALli2+v6j+KgCiqVFoW6ThVXg==
X-Received: by 2002:a05:600c:5012:b0:3fc:757:833 with SMTP id n18-20020a05600c501200b003fc07570833mr1826781wmr.7.1690288264314;
        Tue, 25 Jul 2023 05:31:04 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b0031432f1528csm16415321wru.45.2023.07.25.05.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:31:03 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2] gpio: mlxbf2: remove unneeded platform_set_drvdata() call
Date:   Tue, 25 Jul 2023 15:30:45 +0300
Message-Id: <20230725123045.6367-1-aboutphysycs@gmail.com>
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver.
Also, the private data is defined in this driver, so there is no risk of
it being accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---

Changelog V1->V2:
* https://lore.kernel.org/linux-gpio/20230720134845.23727-1-aboutphysycs@gmail.com
* fixed subject line: adjusted colons where needed

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

