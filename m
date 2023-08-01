Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9076AA0B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHAHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHAHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:32:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FA10C7;
        Tue,  1 Aug 2023 00:32:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso8808795e87.2;
        Tue, 01 Aug 2023 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690875142; x=1691479942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgshofvWYyF/DhpPi22apL12vwawsYEjRGZkBlpio2o=;
        b=ounrYPusqaK/Y/cRZwCbRP5ZabY27J2S5VdDx2TywsEIGxEindywms3vI0WjpE0krt
         DeXI/P7EgCLLADwHkMRnNuUllXg1PZKWFXOP+Mx8CGWCmuXCBsXw/vyDZ94fQpWPMaFN
         9nlcF9yWDogOqWQ52xtcIJn1s8EZV/hBMX6ZhxDap3+UWF5Ln6Nhj7jzXP67S1GjcYxD
         QQLiQq/RJk5u8JQYri+IAGtz5Vph+b6xcceMLru6w8gudNGTDge1tdkRhwwyNbi5QwM2
         LEu0+usahM751QKCCirqPbran8goL1vOcj2RIjHyvTk+GBWqOquFKczIBUCEbAz0Xj8n
         P0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875142; x=1691479942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgshofvWYyF/DhpPi22apL12vwawsYEjRGZkBlpio2o=;
        b=lhN+Gg1cwAWJwvP/Cae5hIPExn7jsFyEvaH3IKwnoSA04QdEZtlopWEyYbSWjtWir5
         n1/G3ZQ0lmI+RIlYqlMMYthmmgDpbuWmCXBRgHP2YTFIgszczk+iB84L5H0encevnzZw
         YVMcPXb4oFEc9nCftat3YwR3HWbM58Fb+2Zk0dQcJGTmunPFFffJDRbXB9wB3mgXs+9L
         286zvepCnUvZiGhMAR8baTqiyXamj3mzCyk1vVOdf2bL1JhcW9IxGilzCHd/zxGBhs3n
         xF2E2FfpqwpfnZKmOEWj0oK8Q0Vd9ePIIVGkYwTrJ83uTZyXjgJPcnow+UK6XokRmCH2
         K9ww==
X-Gm-Message-State: ABy/qLbjbdcBBi73lwnZTtx+Q3m9bWK+0kGQHUdEHSlCVGsEYrLNvBUL
        Hn0niMW13QJvTmqC83G5H4C0fAsZZwOG+w==
X-Google-Smtp-Source: APBJJlGDi01mRhcoTi0A1Gj6heCpwb5DOIRYb3jhpuOmn8W9RKD6wWUrse393Xnx4Yg6S395s9okdw==
X-Received: by 2002:a05:6512:3d10:b0:4fe:1d88:2c61 with SMTP id d16-20020a0565123d1000b004fe1d882c61mr1914184lfv.32.1690875141921;
        Tue, 01 Aug 2023 00:32:21 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c44a000000b0052238bc70ccsm6503428edr.89.2023.08.01.00.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:32:21 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: timberdale: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 10:32:11 +0300
Message-Id: <20230801073211.4274-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-timberdale.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index de14949a3fe5..bbd9e9191199 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -256,8 +256,6 @@ static int timbgpio_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, tgpio);
-
 	/* make sure to disable interrupts */
 	iowrite32(0x0, tgpio->membase + TGPIO_IER);
 
-- 
2.34.1

