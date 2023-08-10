Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626387771D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjHJHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHJHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:46:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8EC1702;
        Thu, 10 Aug 2023 00:46:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc65360648so5969705ad.1;
        Thu, 10 Aug 2023 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691653599; x=1692258399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gTz6hcoAzVZcSGAehaR348Fo/uyOm0OL4hmIYIrZZA=;
        b=h+7tOucTOdOz8TQvOUT0sabcTzCnlSOWbL7VcjubyhRJs+QRtvKFAzzRM9L9nIdS1P
         nNqSVk11YEy+loiPRdPtrDsxc70BDIN/FdnI/Gv++3cDOqT+dy2jNySYJHJSn74O76VA
         8O++XVsIB+8Am+HaqWRxb46ZiM3DX4Xdt92RorosZGzSSzsjbQqETzrV/kziY0D9qqGY
         Kyi9t12RhX+pLWrsHLReJJRmDedo44LaAn/d07J61w5mgYvc9qqfkOPirZXn1pDuGzJa
         tcqt0dAzZofras8bhHuFKI6PVblJz64hhuhZUeBblGaP4bd8MYWSPLmkBaLMlnLp96NR
         yVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653599; x=1692258399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gTz6hcoAzVZcSGAehaR348Fo/uyOm0OL4hmIYIrZZA=;
        b=N6DQaY3NnLOpWuW35W/Jgi+jpGGfAHQoiw1Nsu0GPFZVh0xME/Hkwotu1mdthHPvLa
         SlIf2yn+ZoLakIHMBEG52wZ3CJlzLUyR52AkXxk8R+miiZDKG9r7+v6g9uWR1pFoEta4
         1ntRCjsS4kTSt5aUyso/lLnzc+NR44Wa5YFQFTEOP7XhN7ccJ7UDv2P+XlM0qfY8qIlM
         ZJW7wEryjrx0kOjGM2sjoucN+hhwEA/+YlccIeEnflzcgCu3UGJsGgR8IO0VbeNIxkn6
         ysdMXsFw2oDFhi8fXkM4pOkxg3Gr/dGBBgc8EqP2Kf035TDcI5kY4EptDTnMOrNsRFv0
         UIwg==
X-Gm-Message-State: AOJu0Yz5TXMkxWgdC6ZspCt00zFCcoXnn+gVcFOSAz8Y8FpWo3zkm4Sb
        6NtEZ7BFKRQvevctoiUMdDI=
X-Google-Smtp-Source: AGHT+IEdVgZI7BPbqizq8DoWCJq/ZmRAIgZoKv81fEAzLLFHRJbKGVmqf2OVRsvfxWzC9SRZcQGVeQ==
X-Received: by 2002:a17:902:ba86:b0:1b9:ebe9:5f01 with SMTP id k6-20020a170902ba8600b001b9ebe95f01mr1637726pls.19.1691653598860;
        Thu, 10 Aug 2023 00:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:103c:968b:4dc8:d063:71b0:bea])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b001bd99fd1114sm948570pll.288.2023.08.10.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:46:38 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
Date:   Thu, 10 Aug 2023 13:16:33 +0530
Message-Id: <20230810074633.13111-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
v1->v2
ARRAY_SIZE calculates array length, so changed 
gc->ngpio = ARRAY_SIZE(scu_rsrc_arr)/sizeof(unsigned int) to
gc->ngpio = ARRAY_SIZE(scu_rsrc_arr)

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
+	gc->ngpio = ARRAY_SIZE(scu_rsrc_arr);
 	gc->label = dev_name(dev);
 	gc->get = imx_scu_gpio_get;
 	gc->set = imx_scu_gpio_set;
-- 
2.25.1

