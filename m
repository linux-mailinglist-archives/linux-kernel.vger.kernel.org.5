Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60A7610BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjGYK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjGYK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:26:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447F10E2;
        Tue, 25 Jul 2023 03:25:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so1880712f8f.3;
        Tue, 25 Jul 2023 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690280755; x=1690885555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iH1UXdiadzHAsDlblA/iuxbT5kUQexi3rKYsnWXQffw=;
        b=cgUx320ShkCBFHIWtgTbx21okfgYZXQ6eQlVsOlqhp6AsxPOXQl9HrVqbfAhFNrh/i
         0MAAmdml+Ai6OkyMtb7WvhKLFa58H7CVQBU7B3870nd078bV11W/Q80QEfbDtHzzgusc
         VbCV3ScfyX7JzRstXarSNVXGqEBKed2a4RWY9S+BKyUPkGRgCUSVz96B24q5gWEA14gk
         /ND7aojWfF4Q2KWRr5cjxwC5HXni3L6bkzAZ8MxTSZhhDHdoodCH+IcPJVLFbRrVeNF4
         NdDo+l3RQjyrpLoEFFv61uPbbTvQRdjozvsfzs5/swXTNp/0fsZQ+piYEn2RUc25FyPm
         pv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280755; x=1690885555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH1UXdiadzHAsDlblA/iuxbT5kUQexi3rKYsnWXQffw=;
        b=aMi64iDH0EnhcXuxavOafwMSMQRE2AflOqqZwosAiFeVZbN2R+OZ3UtJFoxXlJVbpB
         r+ep82/IAhfZ2B/SB1HaxXaZh+rZtg7TGf+m4whiAAN6YhWXTu0iD/rWcFu30Dr1harL
         3GKMiVEJC3EVHLkD+L4AOC/hN1AQIpmI9qoliOr0xqIvWQwoi4RKHhee8hVgt32dFZBZ
         c0dFlevuP1tS0NNhXubewlPTZeNzW84YNfvefkEo7yRDsCAfEPSPkF53OD4M6OsCI6Vw
         QxmgLEufZ3J8T3knK2XfFb16aEx82MwnQz0A+SEBuiw/cJdiLQ4kJgP6rJhjfsvsHZkh
         BlyQ==
X-Gm-Message-State: ABy/qLah0rbcG+xgay1mPQ+R7CXiIRq2hQI2IsypfTnlnOMR/ndHWEZ3
        0a/vCEy1Qy3i7+ajUlYEo6mwIKU4fwFRPg==
X-Google-Smtp-Source: APBJJlF74eFxls2fhODHglkV01oVMPl9UaZTQcyhxl9IXS7A6JYlz5+crwjXjVXXFCbYIN6fp7L8hQ==
X-Received: by 2002:a5d:440a:0:b0:317:5e91:5588 with SMTP id z10-20020a5d440a000000b003175e915588mr3919606wrq.3.1690280754818;
        Tue, 25 Jul 2023 03:25:54 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d410d000000b0031766e99429sm3299939wrp.115.2023.07.25.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:25:54 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2] gpio: lp3943: remove unneeded platform_set_drvdata() call
Date:   Tue, 25 Jul 2023 13:25:32 +0300
Message-Id: <20230725102532.3989-1-aboutphysycs@gmail.com>
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
platform_get_drvdata() call, to access the private data of the driver.
Also, the private data is defined in this driver, so there is no risk of
it being accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---

Changelog V1->V2: 
* https://lore.kernel.org/linux-gpio/CAHp75VdU1c1vUoRpbekPXoLg2DDcbSThwUmkdHRT2FaZ9kagRA@mail.gmail.com/T/#t
* https://lore.kernel.org/linux-gpio/ZLpdOYxo2U+uO%2FH3@smile.fi.intel.com/T/#t
* fixed subject line: adjusted colons where needed

 drivers/gpio/gpio-lp3943.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 79edd5db49d2..8e58242f5123 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -199,8 +199,6 @@ static int lp3943_gpio_probe(struct platform_device *pdev)
 	lp3943_gpio->chip = lp3943_gpio_chip;
 	lp3943_gpio->chip.parent = &pdev->dev;
 
-	platform_set_drvdata(pdev, lp3943_gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &lp3943_gpio->chip,
 				      lp3943_gpio);
 }
-- 
2.34.1

