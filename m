Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05612767464
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjG1SUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjG1SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:20:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004F422A;
        Fri, 28 Jul 2023 11:20:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso3075688a12.2;
        Fri, 28 Jul 2023 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690568437; x=1691173237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0MBJeozieN7RIE8kNLl/uGWmYsWBsu6wJK96hz5N2E=;
        b=QOTP0xhn/BMAWeGZ6vOZTV1gy2SgiLvIh3/Y7RaFDdaYicZERfXjIqDn5fILMAnPTo
         0SjpIcwfmrLsNLE+LtPMm/AqSAjEVnRWHlWpu6SNKTF8h2uNohQsJm5eY5eS1UscNHYn
         KCXg4WRDh0W85sctR1OfidE90FMBHOJHrElDM3hu3YbHCsxvtzAksSF4Z19EgxYNPRu8
         t0my61FtHclVkdvwj26MoHcFK7vegpcWdss9scIpV3T4UcpWuCdd+dgUWVK1ghDM2KED
         RcLk02w9Ap0rbC8j1ttVnEcVAAzYBmLpW4Gq5m0LC6yavIgDeQIXAJTTSwCr/FXLnaKd
         M15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690568437; x=1691173237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0MBJeozieN7RIE8kNLl/uGWmYsWBsu6wJK96hz5N2E=;
        b=TU6bs5v9QsdPYp5E/0TSlR1ME99mTHQDZaWv5nCrR6uX7TCi9O9gcpO4NxQVIJMWen
         pGN2QKF4akW2EdMs6F3lcOhmomT4XjCyxo7cgFJksKMDlSU0h6BtyusY19w5D/bt0B/l
         YZa54dcknxPjhYz3VkV6OAcfV3Zpkt/p0H2vQfRJawSkmvCJ0MVXoPltWkfBek0jQ71g
         i2YblGWfGf6/rKeyotRHKbhB/1idCj4609wgkAYkpSvAiK9w1xvcCdUeuNxMVUY28NGO
         7KpHsJ07mW4xwaZ4tkZ7fNBdLwh0RFIeaIWK8u+avPJcePguNctAU4D01jUwfs5GiyNb
         zJ9g==
X-Gm-Message-State: ABy/qLadazxRAtwtxkYY9VcBmTuVhASPDQB6QrapHf+Wz4pU2EwR22VV
        PEMcubRNvkcHPfAPi3Jnux+q98I5KgnNHA==
X-Google-Smtp-Source: APBJJlHyailxSXANyPgkHXVCri0eBf8tqZkiVYo5PDXjQJRxuHB0C8RPIra3UKKYVigTMch+45YyRw==
X-Received: by 2002:a17:906:1d1:b0:997:e7ce:1e88 with SMTP id 17-20020a17090601d100b00997e7ce1e88mr104383ejj.52.1690568437496;
        Fri, 28 Jul 2023 11:20:37 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id ga15-20020a170906b84f00b00997c1d125fasm2317766ejb.170.2023.07.28.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:20:37 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: rc5t583: remove unneeded call to platform_set_drvdata()
Date:   Fri, 28 Jul 2023 21:20:09 +0300
Message-Id: <20230728182009.18445-1-aboutphysycs@gmail.com>
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
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-rc5t583.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-rc5t583.c b/drivers/gpio/gpio-rc5t583.c
index 4fae3ebea790..c34dcadaee36 100644
--- a/drivers/gpio/gpio-rc5t583.c
+++ b/drivers/gpio/gpio-rc5t583.c
@@ -121,8 +121,6 @@ static int rc5t583_gpio_probe(struct platform_device *pdev)
 	if (pdata && pdata->gpio_base)
 		rc5t583_gpio->gpio_chip.base = pdata->gpio_base;
 
-	platform_set_drvdata(pdev, rc5t583_gpio);
-
 	return devm_gpiochip_add_data(&pdev->dev, &rc5t583_gpio->gpio_chip,
 				      rc5t583_gpio);
 }
-- 
2.34.1

