Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6967767569
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjG1S1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjG1S1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:27:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6334EE6;
        Fri, 28 Jul 2023 11:26:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so5029763a12.0;
        Fri, 28 Jul 2023 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690568739; x=1691173539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMy4pVNg828OEBJfbAusmZ7BTQF3Gz3KVtSgqaAE0Ts=;
        b=iyOv+oRBh5zZnyyVwh7eeDuc4YCFUdus7ENRB9UsnHYk4Hpvb6oxuav5yJhHa+U5h7
         PlukG4B6yR6faDQfKUmoAQTLbmTbhpAd0sBwcbu+t0VAUU8FRofz2701h75s5ScdgSlD
         qnH4KZwrYvyyhhDVpmDm7/tSVEcQJMfAb/5mp+sCOG0fXPezXlOTuCoBHsv8mqQNs/NT
         7+ARrs5Egi8iw09BQA7LYwgRRpdAnOWXi54BjQ7/3Zd+PyipxU4/rRJ1HeOu96Abs/IQ
         xqcuKqYv0s5y+qgGhon08kZTIB0I5p2zQg0aB9853tx8i6AP96n7kEJgpa9ygconpomy
         oe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690568739; x=1691173539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMy4pVNg828OEBJfbAusmZ7BTQF3Gz3KVtSgqaAE0Ts=;
        b=PAJK3AERNIP87vB1zCDSdBBu3D4y5giNArnx+ly1BxxC/C1IcZ+DgwqDutJ4V49yKP
         KyoG08gv0y/4jo8/XJoHe87zTLLggjhtMWeq1K19Vk5TRJbZ4Bvz0qw4T2NcWGk29fNm
         6qaKTWzHB+q19VtU4XST5KU8FhSd3U1cSX1ECjKTg9/2c6NRTpXsw4I3Pq9HAu4ik9wQ
         svYdz3b2NJEDXAHIABXCtI+Lp3feTpDAOntancStRlnATArcXRDlaqcnLk0k/60j/Z+5
         zk0g4S/7sItJkfyYVsyPwhxxQhJm2uzZ72BROu6uD44D7XKkMlKwcNU6waxNp0HQNDEm
         nmJA==
X-Gm-Message-State: ABy/qLY937xdeXj17gS9jR3up3RTqhkPL3G9gh9S5vSxs9x953HUAsuN
        T78XA+gvlHx0rncYuMmQyZQ7zsiVqliBEQ==
X-Google-Smtp-Source: APBJJlHajWZEnSdXU36IKQli/dI6jjwynNCjbPYmgiCEr37AHkNOscU6SeGWs9anTgLmH6qkIQGaUQ==
X-Received: by 2002:a05:6402:5188:b0:522:28b9:e84c with SMTP id q8-20020a056402518800b0052228b9e84cmr5964390edd.21.1690568738884;
        Fri, 28 Jul 2023 11:25:38 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7dd58000000b0052236dcacf2sm2025699edw.67.2023.07.28.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:25:38 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        ludovic.desroches@microchip.com,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: sama5d2-piobu: remove unneeded call to platform_set_drvdata()
Date:   Fri, 28 Jul 2023 21:25:22 +0300
Message-Id: <20230728182522.18477-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-sama5d2-piobu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 767c33ae3213..d89da7300ddd 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -189,7 +189,6 @@ static int sama5d2_piobu_probe(struct platform_device *pdev)
 	if (!piobu)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, piobu);
 	piobu->chip.label = pdev->name;
 	piobu->chip.parent = &pdev->dev;
 	piobu->chip.owner = THIS_MODULE,
-- 
2.34.1

