Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0975AFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGTN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjGTN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:26:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BAB1BFC;
        Thu, 20 Jul 2023 06:26:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so1250308e87.3;
        Thu, 20 Jul 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859594; x=1690464394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQjJSdjGFyH05KUOiJ895s0EmBFeOD2VpWV79nK2wRs=;
        b=mWkpt2DTKfUgTc4WPZCOOd54l/zrdumAL85ULv383Icr6DbPQM10Tf8dQN4PhLNAbW
         Rd5WFG3mTuVIPo/67H8aWC1Nzj+X9hyimt7ig5DcalbzimBAlGQE1D4G+Xmz3JGP/lI8
         XLb10MFTUYmhKvpcqzonh5S8rqJBr3pDLwT9v/xTxftgJV8grxtPxYrtRDUsKD96UMvz
         Kq4yTTokTD8gOfpPifBP1Mg3YZijw0EN/gdgKO0iC2Cqbyh9MyJ7/JZbS5GZsGzKpF8L
         D5c+pwwuka6GBz8SGR371kZy5x+LNeQPu5MsTGtCc5ggOdiN7cU1ZkesqRb4fa/UzpnR
         A2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859594; x=1690464394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQjJSdjGFyH05KUOiJ895s0EmBFeOD2VpWV79nK2wRs=;
        b=OQObmKjqm3V2a7MJah0wzoX5XLUWSwCezZkObYEjAeiLAy7CNfjrJPfZUqmriZjg+I
         cE7tHxxcrLff4vxmg/oE0PAYctG5xNvkMTlH+YzFkCaCAWOX6fR0UYJFOyvE2HPypImu
         Tzsp8ySlFka/lNtHn+VItLkn78iVrKxEDU2xOFt0gwkP8JSWEq1KqJx0c7pWQW0U8QaF
         wMo3AlOPDMPcptsVaVxTpX0S/Hhf1/3arVZfTLZfgXnPUxnl94UxPjeSGsaboljiz2ey
         59gpmqzxfV2aXofDxnTYFhQU4rA2iej4+u30alATmhbO644Ebyo/kYGCkvPUWQZQNXiG
         vDoA==
X-Gm-Message-State: ABy/qLbUaexR59twQgyj9gm/ApuurOIrvOUeFs+ocptT48nAnQ3wCKBw
        unRrBVOMGYto3rwvdzr5y0GqDpLF+Kg3Yw==
X-Google-Smtp-Source: APBJJlH8kOxkAXearW8UDPPr/lNtU09v2e9Bye/a0V/wQ0qRm9PSrZG9grgXR7WP7fhlgo+k4OSz7g==
X-Received: by 2002:a05:6512:2356:b0:4f8:714e:27a8 with SMTP id p22-20020a056512235600b004f8714e27a8mr2443843lfu.0.1689859594136;
        Thu, 20 Jul 2023 06:26:34 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906254f00b00992d122af63sm706728ejb.89.2023.07.20.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:26:33 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio : max77620: remove unneeded platform_set_drvdata() call
Date:   Thu, 20 Jul 2023 16:25:35 +0300
Message-Id: <20230720132535.23413-1-aboutphysycs@gmail.com>
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

