Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB587DC0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJ3ThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjJ3ThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:37:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C4EE;
        Mon, 30 Oct 2023 12:36:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50930f126b1so107614e87.3;
        Mon, 30 Oct 2023 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694617; x=1699299417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVGWdNdmpu8vSibrYJC/RZxDG0iblOVJzHPyX+FabSU=;
        b=hu3ccR1jimNXh2B0ACJGbtYF090Tqi23OaoKu1WQpJ+cPw40xM4N84iUPpurvzGFs2
         voNaItV/YTJ4dZQK9KtMcQFOb0uVwMAeRxzUHC2JKZlx0mVki9et+2tEPfo1WUypNNMm
         1M0uQtG67JRlG3j+EI8PQJhiTfXsx2/GURav6o9IP4MG2VOrWca3dmhuecbENu1Zk8+h
         bb5k2ZKuRWV2qa2HkjKMPCbfRaTQ8ZclRsLvNAhNWl0YSnlkZn97zUeTOhbvqV46TwrC
         E+GkU/lv5cDKcDZS+ZZ5mi8Ftlg2D7tpJJrxpkDHm2YCDUZ7twxmlHXB6KduyFSGRYd5
         Vlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694617; x=1699299417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVGWdNdmpu8vSibrYJC/RZxDG0iblOVJzHPyX+FabSU=;
        b=W/eGgHA1vLzrGEGyZ1TiHaBJkLzkRxEih9T3l9i4h200tLHClVX94JI59F2iVrYq+Z
         LhGJCw0iiynoXiqjC88P7KQEjAqHN9wTMa20nbknUka0s3yLAGTOvEr3G1BWZXHSet+w
         18U5KzbiG76+YilrjwVHCXZ8Dh+KO4bEDchBSPdniKMwXNBq7GWeb+YH9Qj69zY0zPal
         ZQ7wgDGeiq6gZ1V4LZdu4N1Z8xFxOcsxw8cia/T1N1NRumUreD5LXjkb3Jgj3QwmZK+P
         Xv/cpwZ8OcbjEQnIrE+LFGQSy4ZSPtPvYxWJGMjSk2zOCAMPqvJDL+yrxc2Tlvvu/3Tu
         c+jA==
X-Gm-Message-State: AOJu0Yy0prFPlI2ffhHilHWDLJWPjWpmbWGptcnG/aSWEIMrSgspxJgU
        U0m3sYJ/UgV2BhDMHZdlb3E=
X-Google-Smtp-Source: AGHT+IEFYLc0LWk2+gubsWmVoJUJJhCLxugkEYB/uIxSQB6LHNJIH24jVFny2uBAM3G+f/x8iu3Jjw==
X-Received: by 2002:ac2:424f:0:b0:502:9a2c:f766 with SMTP id m15-20020ac2424f000000b005029a2cf766mr7192644lfl.30.1698694616903;
        Mon, 30 Oct 2023 12:36:56 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b0050482b29ac8sm1510781lfl.31.2023.10.30.12.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:36:56 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:36:41 +0100
Subject: [PATCH 4/6] mfd: bcm590xx: Add compatible for BCM59054
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v1-4-3517f980c1e3@gmail.com>
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
In-Reply-To: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694608; l=1936;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=GaZAs1pHOm9g/5MXQbdGtce8n4JeiRhmO5EZ2BKjVhk=;
 b=iXnXR/iUSsOy5Qa5LWnXMndbYTWYQ0arqnxQ5RAfnU1nadKV2ZmXXoLfF5IdKOLigzM8FZ/6i
 NxuD1yo/ADECA98t5VkRwFb8psKKdYFIGg5911KUgycrohoLdBS8NHv
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM59056 supported by the bcm590xx driver is similar to the
BCM59054 MFD. Add a compatible for it in the driver, in preparation
for adding support for this chip in the bcm590xx regulator driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/mfd/bcm590xx.c       | 5 ++++-
 include/linux/mfd/bcm590xx.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 92eede9a5e61..f5c5fa97ca9a 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -50,6 +50,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 	bcm590xx->dev = &i2c_pri->dev;
 	bcm590xx->i2c_pri = i2c_pri;
 
+	bcm590xx->device_type = (unsigned int)of_device_get_match_data(bcm590xx->dev);
+
 	bcm590xx->regmap_pri = devm_regmap_init_i2c(i2c_pri,
 						 &bcm590xx_regmap_config_pri);
 	if (IS_ERR(bcm590xx->regmap_pri)) {
@@ -91,7 +93,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 }
 
 static const struct of_device_id bcm590xx_of_match[] = {
-	{ .compatible = "brcm,bcm59056" },
+	{ .compatible = "brcm,bcm59054", .data = (void *)BCM59054_TYPE },
+	{ .compatible = "brcm,bcm59056", .data = (void *)BCM59056_TYPE },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm590xx_of_match);
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index 6b8791da6119..ed0d8be6387c 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -13,12 +13,19 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+/* device types */
+enum {
+	BCM59054_TYPE,
+	BCM59056_TYPE,
+};
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0
 
 struct bcm590xx {
 	struct device *dev;
+	unsigned int device_type;
 	struct i2c_client *i2c_pri;
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;

-- 
2.42.0

