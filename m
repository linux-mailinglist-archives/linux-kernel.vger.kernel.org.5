Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4B7CCE21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJQUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:34:40 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F8BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:34:39 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3af957bd7e9so3924899b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574878; x=1698179678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjMxNklY9G/+xqQ/lM5xPuWR9yO1uXO1qqREMwyoCLU=;
        b=hn2ce0fMUJOm4wbstqtggLq7iHP9bi6gSPQasH60fWYND8228Gw+JMDMFC82l/mUCY
         bvIuOjUCF4JyhLbEPBYAvCAtF6L0iXdQb+pqWeWokIFCXNT9wyTKjD4WETkefQUbe3Jk
         th4u+RZdrUJjGGGgyIL0Gj70J9eopFAtk6vEd6FeXBsLQBGo3QT99DX+spEQhOiYAIXs
         V/oCfWqQTcr53OwDw7AXuO2JMSl1R5k8OxqoIC6W4AXaCr7Zlhz5l1iIUZMg9eygw42n
         K038pH4F058G3l1j/PNK3yesdgVin5pNfkA5RerS2MFieusRmK+/MQ8SrplOEGmFm2JM
         bC/g==
X-Gm-Message-State: AOJu0Yyhj75iJLoO0s0SYDqQuUNMUktXFIfKLpTP8bmRCnALw4vo1vDN
        U1BurprCiuoAJ60JAgjZ6A==
X-Google-Smtp-Source: AGHT+IEY/Q80f+aO2Wk9Wu/rVQyhEfg8vbYxNWal8XEX+SBftdXW74LwcitRBEMycxZ+fdBFCbDE0A==
X-Received: by 2002:a54:4706:0:b0:3ad:29a4:f560 with SMTP id k6-20020a544706000000b003ad29a4f560mr3760803oik.34.1697574878227;
        Tue, 17 Oct 2023 13:34:38 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a54459a000000b003af60f06629sm379032oib.6.2023.10.17.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:34:37 -0700 (PDT)
Received: (nullmailer pid 2699232 invoked by uid 1000);
        Tue, 17 Oct 2023 20:34:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] regulator: da9121: Use i2c_get_match_data()
Date:   Tue, 17 Oct 2023 15:34:28 -0500
Message-ID: <20231017203429.2699039-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred i2c_get_match_data() instead of of_match_device() to get
the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/da9121-regulator.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 80098035bb13..b551a400bdd1 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -13,7 +13,7 @@
 //
 // Copyright (C) 2020 Dialog Semiconductor
 
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
@@ -1117,17 +1117,6 @@ static const struct of_device_id da9121_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9121_dt_ids);
 
-static inline int da9121_of_get_id(struct device *dev)
-{
-	const struct of_device_id *id = of_match_device(da9121_dt_ids, dev);
-
-	if (!id) {
-		dev_err(dev, "%s: Failed\n", __func__);
-		return -EINVAL;
-	}
-	return (uintptr_t)id->data;
-}
-
 static int da9121_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9121 *chip;
@@ -1141,7 +1130,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c)
 	}
 
 	chip->pdata = i2c->dev.platform_data;
-	chip->subvariant_id = da9121_of_get_id(&i2c->dev);
+	chip->subvariant_id = (enum da9121_subvariant)i2c_get_match_data(i2c);
 
 	ret = da9121_assign_chip_model(i2c, chip);
 	if (ret < 0)
-- 
2.42.0

