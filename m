Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2B762F11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGZICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjGZIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8D4C26
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so64347255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357998; x=1690962798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OR4WatIj1vDPYbZVDclfDkYALtpmV2GorGc4TguZ9g=;
        b=Jz3uDiHidmkOdHqQ4A15ozND+FenOh0akWPvH168WQkS1ulMaER6nfRl9L/yUu/yT8
         tm+X3r56QMEYUzaioEswopvrQaqqBZNVgeUtcZH99wMcv/YKJMp39Co3F97ewaUjxYQs
         FW6uAgjTV8NUw1k8wmQBJkE2XwtRIqmgtykRdgDMZtp1Wrj410nKRm0SslzYC29aabKg
         5XRMz02kdUXh7MMWRZ9ngTjTnfkxU4Nr8+9kPzITZmHXORgKG6P0wT65gOphuHcU4NjJ
         XcNL98mIpfocURNFsJEzpplNEmKGzzqvQOyyFUP3XO6Yuncft9yPKVJMvbm775ob8FjX
         ZYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357998; x=1690962798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OR4WatIj1vDPYbZVDclfDkYALtpmV2GorGc4TguZ9g=;
        b=jJplsBln+q6K2xYNAVI9h2IrUl3O5bPAFhBsLoYfo9H0gYz7+vZl97weul1s51/oYk
         0GF8bGatF/sqosP/+q8epCvmhgcYr3yTGHlcvvmj/ypOAw3OKaQzLP47WEr8J14iNA1g
         Rfbe49MBCtb+YVDIl/w4ktSZXxZI1bDs140uvGXboIucDhln8l5G/GM8yBkeSKX0kG1h
         YJCxBlJpa02OkhjJaTaMlo2R2LDeXgu8XNpfyA4k3oBVXd6qYhYXF1jGvSgckvB2kexH
         keLvg5O3VxpqQek39Yv4YfumeT0yazYAwZf+NvMvCokN6DGYa9BouXur/riZRCOsajMY
         mX5A==
X-Gm-Message-State: ABy/qLZKD7JG+NAWvLZ3r3wQ70U/ikpLoyaR+x1jWPRnJrUQAyXokEy/
        Kgs3HMeIKStFTbpo1AL90Mw+7w==
X-Google-Smtp-Source: APBJJlHbavuz0p8nucrQuOaoL5YFpD5cb/Psc+qFF06gSLSvyRwttFangsg+w898wdRx7yDfaLeK7Q==
X-Received: by 2002:a7b:c407:0:b0:3fb:ef86:e2e with SMTP id k7-20020a7bc407000000b003fbef860e2emr785798wmi.19.1690357997872;
        Wed, 26 Jul 2023 00:53:17 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:17 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 10/11] mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for quad_enable()
Date:   Wed, 26 Jul 2023 10:52:56 +0300
Message-Id: <20230726075257.12985-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=tudor.ambarus@linaro.org; h=from:subject; bh=QdB1CqYeo+E0vRmCT5AKj+737qFOif1g4DSnqlL1Z6o=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYWzzJw8YDhGmjAHNiDSE8hUDVOK83EN137 yf6F7ibY/aJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6TaBB/9OD4NAVj0Ze+yCwu+WLSTy9opP6fNQcZ6JV8WDN5h11aIzOo2vW3Lt1VPTKpL8Fxpr/7U 7syEMtg2iTm3aBOjM/4B73+vwAxFd4xon9PDcZ2f8YOOgiuOhKeyhA+r4JK/qFmEE1usbf6ssof wtXJast8GMQqjx8rD6jO0KDx6CZeG5vnw4XvpO+SWb361znYdbRxFtmWFJ5jCMaawhh12k4z9au Bw6QnJz1PO5u05Jzwi0sD4gBX5dGBFm9/cWWspuSFT8hpiq3B+2gkZ+wt34v7dcUpPnsH8LHzmG ixoMeoAoLpMMtAlETLwlXqiO1JV6JhWpwv6PqPdqFzlLkjXV
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All s25hx_t flashes have single or multi chip flavors and already use
n_dice and vreg_offset in cypress_nor_sr_ready_and_clear. Switch s25hx_t
to always use vreg_offset for the quad_enable() method, so that we use
the same code base for both single and multi chip package flashes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 30a3ffbfa381..6abef5b515a1 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -24,8 +24,6 @@
 #define SPINOR_REG_CYPRESS_STR1V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_STR1)
 #define SPINOR_REG_CYPRESS_CFR1			0x2
-#define SPINOR_REG_CYPRESS_CFR1V					\
-	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR1)
 #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
@@ -348,10 +346,6 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	u8 i;
 	int ret;
 
-	if (!params->n_dice)
-		return cypress_nor_quad_enable_volatile_reg(nor,
-						SPINOR_REG_CYPRESS_CFR1V);
-
 	for (i = 0; i < params->n_dice; i++) {
 		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR1;
 		ret = cypress_nor_quad_enable_volatile_reg(nor, addr);
@@ -657,15 +651,17 @@ static int s25hx_t_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
 	/* Fast Read 4B requires mode cycles */
 	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
-
+	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
 
-	/* Replace ready() with multi die version */
-	if (params->n_dice)
-		params->ready = cypress_nor_sr_ready_and_clear;
-
 	return 0;
 }
 
-- 
2.34.1

