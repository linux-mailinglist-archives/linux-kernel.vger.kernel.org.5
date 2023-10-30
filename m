Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AE7DC0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJ3TmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJ3TmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:42:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACCE6;
        Mon, 30 Oct 2023 12:41:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so71059591fa.0;
        Mon, 30 Oct 2023 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694913; x=1699299713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVGWdNdmpu8vSibrYJC/RZxDG0iblOVJzHPyX+FabSU=;
        b=mrc6uIBmP1emLi+0hZsTg8ztrBSFZfqYs20yNqcrwcktkEVtqB79UfdhzARyXq2Ciy
         mnRuaPB3aNhgvxEQTmEtkvNRyJOnZlF4PTQiB6dYCB1hKWWYM6rywkI8WJcgzZ6Yt8ed
         01Q1o65XJd7FxkWQh8gMpmRsyBfP48ZEVrfIzhfRHoxYR+oUMsyKIDMCK7HO/OlkxlQd
         /vs0LjJjnzh+qyQPUwEu1AuOlrZN7vX1G5YKPnbaDPh/sGljipVgpiNis7cDXoj5woJ6
         JBkFvwtbOu4ilR1KDtYCOGvsUAntCd53VY9pbyUlbZmhVzUHpzU9z6CCgUHwSuAQOQxa
         zeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694913; x=1699299713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVGWdNdmpu8vSibrYJC/RZxDG0iblOVJzHPyX+FabSU=;
        b=Or/Q21sMuyWqgNe8oU36urrePCiTmvXnLTSDqm3WJ59cyAnALW/ToLJLqLrYcPBJ5y
         epLiYAvjv0vfyIO4DEsPjr7cnTOZjXrTUtisnyh9jr4ef4K9eeJ7j1ixEyb0jl0c9HI3
         al/9By8UFE5ebZe3VWwlmXYBvWtyL1fhHpsqih0dozXJgJ04CA4X4IFvoLq7f/qZ5o8G
         upP8XjuCLxAC888fzAzUdC5M5yzwYUTKkw2FrZV/Wf2ehp/gpcOWE0EY7w/qWEkYskfc
         Sov7U1D0KZQPiyyfOQDtJJM3Nj8s7GN6eZIODx9//PJrZOiTBI088H/gMiu/sZCDf20T
         nMng==
X-Gm-Message-State: AOJu0YxrDTobcAuu9j4Do1Bpz9O9OE+Cwf6nFRducgbT4ZbSCupRiXCC
        4jWPosig15aTio5myGHOnrM=
X-Google-Smtp-Source: AGHT+IG2fWFrzQ7B0lInjhmgmbToxPfdp7+yDm6KzfqHnJxQ2uEdEnXUVAgy07VZr7nveCyziVdYyA==
X-Received: by 2002:ac2:55aa:0:b0:505:98a8:fa39 with SMTP id y10-20020ac255aa000000b0050598a8fa39mr7131537lfg.18.1698694913087;
        Mon, 30 Oct 2023 12:41:53 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:52 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:46 +0100
Subject: [PATCH v2 4/6] mfd: bcm590xx: Add compatible for BCM59054
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-4-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
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
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=1936;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=GaZAs1pHOm9g/5MXQbdGtce8n4JeiRhmO5EZ2BKjVhk=;
 b=AD/A0qChov9/UuR+aIEJvoDFuKb6QmCISZGXUmJiKCiDvIrqzPckzH/r1BjXFz0+orh2oldKb
 oaNuSd6xQuBALsUkb2Zqe1I8ORVi7y7c2fmGpP6RT8VIQpNkC9hgNzX
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

