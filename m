Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CF75DB0F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGVIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGVIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:40:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3319235A7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992b66e5affso425979766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015230; x=1690620030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1X6ZNWe7KmsdOhe9OS7Rrilt+XPjdCv43wNon4Ix9Y=;
        b=EIMQYIObKwY0GBNZAalolqy41q+2eqtubpHGnsRInr7E5qF+18NSCWtorN+hqFXN5x
         2VKu2WPirAWGee/S3FeplKBXZP7q3WyyKzBtslSVVQU4C61iGhJhi5GOejo3k7d6gZmX
         rOaQ5yuCs9bpi3n9xDeg0mxZoUxsPNtpmVsbqi/8IM+e5Gs0O+yv7mIiY21T6DthKxhY
         OF3AlmBPkhxPzliABOYdcq71LTFSrszeVFaHR8u7gMbXBj9CsQkAZhAWH637iUoZIvNQ
         nUGiJW76yxlZO1RbW/fdnGH18U0t1IFgWxrUgrOQlGJ13MrFjdHGZ+d43sAQoIVMCGx7
         WCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015230; x=1690620030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1X6ZNWe7KmsdOhe9OS7Rrilt+XPjdCv43wNon4Ix9Y=;
        b=iNq4P0+thh8FnOx6T7GorLY1p/FaBRptttj4T+73PnhOX30fjxo9j2hXivsrNI8q7t
         0Q/NOwpyNlGlquDV2iCCnxYhVN04waJWXZlaKN9gtqjEThmUfLCsHezuu2ozGPBjEiPq
         eKq2DsmWSZbmEeJ/Brt3XwIx9TT/2VyKkTNG0nl1sQZt7zZXHRt4uW3evMM7at4U+5ux
         oo9JtsSygQY5qgEoYHjWk/349NI2aeDTgKmcK49kpAAFwz7/HAxS3KHmsO+Yv7cH4sfL
         uC3/HNfJ4Yf41YD2s8C6zXwlWuimXx5dj3ZttWX9szfEjhq0VEUv0GWzLv4f+XTo06+L
         Plmg==
X-Gm-Message-State: ABy/qLY5NalEi4M+5QBtzwVQbwPRmLjsijHz5O+dUHvbj3JNfefUsWaO
        Bi8kXvzYIxvjeATkK5Cl+Sbfjg==
X-Google-Smtp-Source: APBJJlHCiopkNxKqMwMDiRqhP8c9uSaFW7KOAtBbGUrP2sKS88kXyUABO2nCk3jNnInzG1rKDlUUuQ==
X-Received: by 2002:a17:907:7810:b0:993:f2b4:13c9 with SMTP id la16-20020a170907781000b00993f2b413c9mr4241609ejc.21.1690015230164;
        Sat, 22 Jul 2023 01:40:30 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:27 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 04/11] mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
Date:   Sat, 22 Jul 2023 11:39:59 +0300
Message-Id: <20230722084004.21857-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=tudor.ambarus@linaro.org; h=from:subject; bh=kgTcomoQU7JsYNjD2ojxcF6vrGgWFcnW4j+zTTO9fWg=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XjF1McRGWHDR/dosXymqrH8LFtXFXqWHGWg YCEuhu05uqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6UOcCACA2ZOT2/g+dowXl3TLgT0pmmXmkYCVEJhtKOyH2rCDeA75Grg2Pa/3mQZWGN7T4BzwdyV Q+s9npTWqnT2GySbRnpCz1piLVKUGrZyxT7tE04vmxms7xT2YBuEvX8jqDWHPQ1OFE3O6KowXKD rfQCyBRGV1QnKowFzUI3w3/qWX09vGpaVimY5PYnrHyoXbv/RxSVinWYr5oldv1c67/ScMYxeHm vxb2t1IEW+kITttD+37+8qTYKtWVjV0bLLP1m54p4IIWC5CPANIYEpZuIUOFCvwRkg9lDzYOQ7V AN6yuKyC8CM95FFgqq/gTG+fzT7a/LWOHRx0ivS9/+yrHFDT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

All the Infineon flashes that currently support octal DTR mode
define the optional SCCR SFDP table, thus all retrieve vreg_offset.
Switch all the available octal DTR Infineon flashes to use the
volatile register offset to set the configuration registers. The goal
is to have a single pair of methods for both single/multi-chip package
devices.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 51eabddf2b16..dc4841891b74 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mtd/spi-nor.h>
 
 #include "core.h"
@@ -202,14 +203,18 @@ static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 {
+	const struct spi_nor_flash_parameter *params = nor->params;
 	u8 *buf = nor->bouncebuf;
+	u64 addr;
 	int ret;
 
-	ret = cypress_nor_set_memlat(nor, SPINOR_REG_CYPRESS_CFR2V);
+	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR2;
+	ret = cypress_nor_set_memlat(nor, addr);
 	if (ret)
 		return ret;
 
-	ret = cypress_nor_set_octal_dtr_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
+	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
+	ret = cypress_nor_set_octal_dtr_bits(nor, addr);
 	if (ret)
 		return ret;
 
@@ -247,9 +252,11 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 {
 	u8 *buf = nor->bouncebuf;
+	u64 addr;
 	int ret;
 
-	ret = cypress_nor_set_single_spi_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
+	addr = nor->params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
+	ret = cypress_nor_set_single_spi_bits(nor, addr);
 	if (ret)
 		return ret;
 
@@ -714,7 +721,15 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
 static int s28hx_t_late_init(struct spi_nor *nor)
 {
-	nor->params->set_octal_dtr = cypress_nor_set_octal_dtr;
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
+	params->set_octal_dtr = cypress_nor_set_octal_dtr;
 	cypress_nor_ecc_init(nor);
 
 	return 0;
-- 
2.34.1

