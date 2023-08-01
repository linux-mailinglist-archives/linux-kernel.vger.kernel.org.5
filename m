Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC39376BEAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjHAUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHAUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:45:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E051982;
        Tue,  1 Aug 2023 13:45:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so883697466b.0;
        Tue, 01 Aug 2023 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922700; x=1691527500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VT8bquHjYuDXY5tDxC/4mqV+mQIYR6f3TfN+Z0jNypY=;
        b=nqjZ+Hma7hxI93/rDxjqsCl2pNEuzYdiu/7o6a+wMLx65eJ31PrHFpdi3hB9n0AjGU
         6+0CJ/R6JVL/wrDJL/5GHzq/YF8PramJDvoi421kNj6n8HZiHFK/OuIuTpLfhkriGVA7
         heFdEFs0ZXszUizeIGw7v9ce851iWUo5rn3GX48YMCHQTCZOgiQcyyaKc2ijp2CUiMiD
         wBZ2fAiXHwzuU2ODMW9PS4kDeaH7XSzeaiPKRDs3OhZNoxN/W+fWICGzh2XoR4BQePbC
         N1ilfuW3rnkQi+ZfrgOCWFRSNgQKL7/U6/Xfec+UkhNzelBFhSQckCy5Zmo8yT1uM5Rt
         Q71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922700; x=1691527500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT8bquHjYuDXY5tDxC/4mqV+mQIYR6f3TfN+Z0jNypY=;
        b=QEioLemDYagNIka2s937JV7F7PTNGfHxheOXGqCQKhnIzvLyzXDw2Xe1/sOj4qvvw6
         GtlvVCtkG5KdnOKtrALKgDNI7XsYFW3ZaNomIFGOnZ2e5FW+03GOYntNsXSGWTtUuorC
         kizjn7hdHafeDZi46TvMfWudJRXgdIZFvvfi5KEhXvUxtvnULWpCb5/VaqJLx9r56bPW
         QvGm2ZcGJlZUDJ1OboUjBhKTPjrg0mc9QLkfE11oS6htKwjCafVIKQOEP691oJ1Km76C
         63+OP0XQjjfRyUpGnhl6bAZIoKDCKNcDvXP1Pa5Wl5pljCYqlAEiwGgNCmVwmpKE0fPy
         Afbg==
X-Gm-Message-State: ABy/qLZT5zXyo5RZLI5ZVzorKpN5ET2rXOztMg+3AUAMyblmSEmcN+IK
        X09vMMeSBdNWqm7JmE5mT/91MPlbPl8gvQ==
X-Google-Smtp-Source: APBJJlF7Op452kcsJOz08wJDaOsgjnl1rDc3tzOSp+xpIbK5B3N35ILOF9wOJyJZQNmpjafXzx73zg==
X-Received: by 2002:a17:906:cc58:b0:991:d05c:f065 with SMTP id mm24-20020a170906cc5800b00991d05cf065mr3335091ejb.52.1690922700396;
        Tue, 01 Aug 2023 13:45:00 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906495700b0098748422178sm8103466ejt.56.2023.08.01.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:45:00 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: vx855: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 23:44:45 +0300
Message-Id: <20230801204445.9677-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-vx855.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
index 69713fd5485b..8fd6c3913d69 100644
--- a/drivers/gpio/gpio-vx855.c
+++ b/drivers/gpio/gpio-vx855.c
@@ -240,8 +240,6 @@ static int vx855gpio_probe(struct platform_device *pdev)
 	if (!vg)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, vg);
-
 	dev_info(&pdev->dev, "found VX855 GPIO controller\n");
 	vg->io_gpi = res_gpi->start;
 	vg->io_gpo = res_gpo->start;
-- 
2.34.1

