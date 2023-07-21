Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738675C75A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGUNIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:08:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F630C4;
        Fri, 21 Jul 2023 06:08:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so3104437e87.3;
        Fri, 21 Jul 2023 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689944933; x=1690549733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtlyWn2I3ogc2VsptqSvO9P1T5RQycoIkTmKOHueTBg=;
        b=S8PTRVUMNu8G4Msql+QdzSAXokDbUKFUuzdDgIlBAjtRnFSD1ZQSop+HhaiOkZ33VJ
         9cmr14AoKtGPPl7TIRE4XATfTXThA8ZmVQyPrBvZmKRd8P3vihO0ZVKQFNRfBdz/p6+p
         FmbHdZo2zhe0WVn7XA4PyyUITo7Pu129O3HmSGMAgpdW1bupOTSkFYCSFj+FytORoElR
         QxvIfTAw1ZNQoiscEAs0udy/ZZIAd93tGtHWlAVBWmIm7UewZjaUQ3rMK6f0HLZecFgJ
         ugIrycFAnq0MRIMihz6GFJ8Z3J4Cye2/Sru3s6hgOg3j25nIgfaQMX+lgjPK2oTaEAw1
         9IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689944933; x=1690549733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtlyWn2I3ogc2VsptqSvO9P1T5RQycoIkTmKOHueTBg=;
        b=Qj1CZIXCjtL8f8aXPEaGJxpyfiGm3F5O9WW7C+kJmB2nom7MZZAlgI7NZUnti9Icy8
         Qm26pvD86Im+87l3RNmWswL9n6mctDT13+MlU+BaNVNII48Ui8rTIYpW29SNs86fFapi
         xcXUFv3neDUx/o5mdZh5H5fDUULwULdlBVEnSIn0UUKI9wihOXiI4P7AHQ2s2ZXw4sgR
         A0IUCOVVK7GpkEH7P1btVjw94+b92D+tPikyE71J7WyqbTVCWWQGthBgTew7Yd/gIebu
         NfoL5A+oBp7qGIEB4PTnzGzT8N6WUV5k8tyMP3JP3icIKNQCcSA5JDnJf4fcDjc8B/pD
         3QuA==
X-Gm-Message-State: ABy/qLaM1Y4ebIqrEvImB8TKJHm3CJZUoZgr96fld3vNow8EHhsCq54v
        MVT8nthPW+MI/qiKQPUsHOFyKZPxOlpf6A==
X-Google-Smtp-Source: APBJJlGWg54hXrgHwtVxHtuUFDOm84BpYP/EqgGmtO39iCY1GtfP9Z2VtWTVC8s94tfgVprnEgBW3w==
X-Received: by 2002:a05:6512:3243:b0:4fb:7666:3bc0 with SMTP id c3-20020a056512324300b004fb76663bc0mr1141674lfr.47.1689944932468;
        Fri, 21 Jul 2023 06:08:52 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7ce11000000b00521d42fb41asm2087154edv.67.2023.07.21.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:08:51 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: mt7621: remove unnecessary call to platfrom_set_drvdata()
Date:   Fri, 21 Jul 2023 16:08:38 +0300
Message-Id: <20230721130838.26616-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 93facbebb80e..c0c715167d9c 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -315,7 +315,6 @@ mediatek_gpio_probe(struct platform_device *pdev)
 		return mtk->gpio_irq;
 
 	mtk->dev = dev;
-	platform_set_drvdata(pdev, mtk);
 
 	for (i = 0; i < MTK_BANK_CNT; i++) {
 		ret = mediatek_gpio_bank_probe(dev, i);
-- 
2.34.1

