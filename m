Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B476AA04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjHAHbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjHAHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:31:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDE170D;
        Tue,  1 Aug 2023 00:31:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so7774466a12.3;
        Tue, 01 Aug 2023 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690875059; x=1691479859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYBxzvO4ml9Oz6WlADCY+2SQm+lkIbnjBV8DwQhDoPU=;
        b=I+aZkPEDlaHVAudnf+LM9ehS3/VonxI/ZfvYr8zhW2bDDsKcH6rziWd3cQHb4NExCx
         M+yuOE8v99NUYDuh4KYoRLrfNdZSCdiete+YqdY/1LlQtm6K+8/xQ3jmjny3et3Xchxx
         z09LH42/Yu0TsMXBkhv1hJHWrGitgsPKBkzFlRI1HfBP5+y8PUbeBzffEKTVA+8NZS6n
         OV3lziFGqBxZoehBG/bf2TI+Rz24ubqBhONrjcOAPqyvSqAklGeKB2wPQIT7Sok5tneQ
         IqPxbBnXBHXk/XN0bBkUylFYWtSJTwkJTnB+Dw/Mc31zWshYy7kbukHbGSKLiPfZR4tZ
         CA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875059; x=1691479859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYBxzvO4ml9Oz6WlADCY+2SQm+lkIbnjBV8DwQhDoPU=;
        b=STaYNkWzgQyTQrxN0fc8zudsMQwxyOS+FI8vkoXOMVpldy/chZzWsP214gMSf5zfll
         lXB0o3BcpYl24wEVxPHVURjTMfHaUs+kiv5ZNZfow1LNv0sVTVcvhGaX2C0ym2ZDIxZO
         NXLNNWfojVHFNN7s4pH8JG1xW6VjdEyKjDYPaVdpSAsv1QoTIdipSGebz6GrSeDnkRkU
         13IYFJCUobmBDuDjXBL+hDpQM2bF//CTMPbUPIZC2ey8vH2sG3Lq0pI9/CK+f+ZyxCOe
         d3t2PlHTCyybmZreGj5/oDymz8DR5e26udZf4j1F07+yloA/XIeN6Sng67mArmRDCRCl
         2u+w==
X-Gm-Message-State: ABy/qLa1B7SsChJkawoli/J/8bv4ENCiAox5GNRGtWhugODJivTw+LHi
        eDMIRO0M/vReB50S72iAF94GOatjr7OsrQ==
X-Google-Smtp-Source: APBJJlEPks53voxGryK9BseKIZXmg03seqrmZA4CzUerIxT68sbId8YPWduX+mrCB9NkJpmUWPQWuA==
X-Received: by 2002:a05:6402:2c7:b0:51d:e3d2:f5eb with SMTP id b7-20020a05640202c700b0051de3d2f5ebmr1874837edx.5.1690875058735;
        Tue, 01 Aug 2023 00:30:58 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402516f00b00521f4ee396fsm6451262ede.12.2023.08.01.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:30:58 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: syscon: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 10:30:44 +0300
Message-Id: <20230801073044.4249-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-syscon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 6076937b18e7..afceb7e17ad8 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -249,8 +249,6 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 		priv->chip.direction_output = syscon_gpio_dir_out;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->chip, priv);
 }
 
-- 
2.34.1

