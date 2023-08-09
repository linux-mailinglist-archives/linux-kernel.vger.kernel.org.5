Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47A77662C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjHIRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:12:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766832103;
        Wed,  9 Aug 2023 10:12:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-687087d8ddaso6678974b3a.1;
        Wed, 09 Aug 2023 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601172; x=1692205972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeYbOsS7m7Ci+oO9qmLW4YJFfrwZPXuK5PLkDCaWNro=;
        b=m9SLyR5CWKCKowrtvk50dLqs8iMis6jpBIAhdByP4ZJW79BOm4DB7iaJsDvYTXOxI/
         SA8AShuYF5AvXOGeFSyjDF7JIZPKqzr+Li4+3bhmGUMb08ErRhuXVaKlcedACDM/ieCJ
         HslHe6BSV6hvQsRaq1IaAsut3pr3NvZySYTDC/WvyyZutDjCa+zyX/333iUa03CLwGRf
         3HxqJeTH7C/xGOjTVHSZe8iQ2oc983fpxrOe3Gqvz9nRrISd+XBdMEnCHxP/CKCh7ych
         00OXgh3Qq5D9KgOmpYGP3D39DNacc+F5/moXj2LSdh9wBCvZT9f2OjERsxHRua0SMdlZ
         49xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601172; x=1692205972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeYbOsS7m7Ci+oO9qmLW4YJFfrwZPXuK5PLkDCaWNro=;
        b=UcQLyvv++HBYbGsth5wB7CAjXgyK+K7zpB/RubYTWnCNI3l2J1fx4iXaMjRN040Ses
         kiGLubKQ9nSQhAypeTZGla/+rueROHR2I0x+YKj19myqNEFHFrmhg1bKYGUs0xxl+97B
         hc8dv5XSW2dSaeLEhc/lf/QuwyWCOZOf931J2259p5Y5vWg079sUhR5ohLDlBmJv5lbu
         7nL6kVJ/apK6Kz8BAS6XvT5XmFE5n4AFCu76cLoa9AbvjS1O8BLv61ZBdoF3KDgz3CH0
         f+7AUvhkntuzQ1yj5CyjUB0cJeFu/w42xYYT6sSiaa6aCa0TGSLAPMFOnEIbLMCmWdT0
         ph5A==
X-Gm-Message-State: AOJu0YyPYJx0f1JwG5x8c0X4sENeCp/gZngFdh3ZwnLJghGYOuK53V7Q
        0mqy93RGtZrUvUpRlCH3WMU=
X-Google-Smtp-Source: AGHT+IEQM2P86vJ5xnSvgcE3nb86ErwM/e9/QOs1IeoTEXzT8GSnjWcd8eyauGfAKy+KgXYuB7mtCA==
X-Received: by 2002:a05:6a20:4422:b0:138:1c5b:24c3 with SMTP id ce34-20020a056a20442200b001381c5b24c3mr3958967pzb.49.1691601171849;
        Wed, 09 Aug 2023 10:12:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1009:f4c5:4c0f:f2b7:4636:86b])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001bbd1562e75sm11390069plg.55.2023.08.09.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:12:50 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
Date:   Wed,  9 Aug 2023 22:42:45 +0530
Message-Id: <20230809171245.92081-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.
This fixes warnings reported by Coccinelle:
drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/gpio/gpio-imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
index e190bde5397d..fb05a53c9712 100644
--- a/drivers/gpio/gpio-imx-scu.c
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -103,7 +103,7 @@ static int imx_scu_gpio_probe(struct platform_device *pdev)
 	gc = &priv->chip;
 	gc->base = -1;
 	gc->parent = dev;
-	gc->ngpio = sizeof(scu_rsrc_arr)/sizeof(unsigned int);
+	gc->ngpio = ARRAY_SIZE(scu_rsrc_arr)/sizeof(unsigned int);
 	gc->label = dev_name(dev);
 	gc->get = imx_scu_gpio_get;
 	gc->set = imx_scu_gpio_set;
-- 
2.25.1

