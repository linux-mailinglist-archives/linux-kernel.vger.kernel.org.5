Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5814762F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjGZICH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjGZIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF853A90
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso63633045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357989; x=1690962789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cGdD2J+WB7rZO93rB0npNuDiQt+dhyl4APRgSC+jsQ=;
        b=V9vS3c9DTJ5zX8a//yweUAkpqwOBX606yqRDKs+llohTHJJn1s/pyk9BjHaPbcb1zo
         oSSxK5vwhUrCgsVtNAVCKUN+66uO1hTf4yn0dRnul9FtbD4sJakxoSFbPyNHT+G3H0/C
         QiGnYKWXl+HyepMhL9er2IlUMaRKGx7Q4C+SjDJWFDI6WjyGSjagAUbJZMPBzlLAvbBE
         8yZ3Vntspl0uxI9sSifrzAaeelIi9gZMkcccEUktc6izd4Gm9WS6I7JeDuiPSaJ0Tifc
         CLfBXpSPoN9ZWj1ZqnDu3qvZtsHJqRRxXSvBh8hgXdy9J1mWwUVcuCq6siAQlDXBi4Ww
         v5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357989; x=1690962789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cGdD2J+WB7rZO93rB0npNuDiQt+dhyl4APRgSC+jsQ=;
        b=H/EHhb8wtY03sclB/QES1IySymqAQve0c1d1wn0MCGsdDOY/ZrNnK852LCzefsCyiv
         1QiV+vGi+vPDzO4lbakmIJv1jgDjKPAUdd24mD1MZrdTPrtv8RNhBX2ZuUSHfezkNm7K
         W7DIDidNsgaaj6/UcQzwWwIuHF1PwT83Tlo47Wonu+CR6pYSs549dy3rVXz7dLl3kj8U
         i+zesJM0WohKyvPTJfBT4xjFdgkiacwCFBKZimgR4PgmmiQW3KAO7gKW5PV+bwpeI09s
         KcGWlFdsN+oXJqeVrapF/vKKviYSrJT269vwsE/8pAYFPXB5wD/Zj8JGF3LyKufNuaxR
         2zog==
X-Gm-Message-State: ABy/qLaL4TDMaddNWt7fFKVmzeMCU/UV2EOHTj3p54wyxKCgUm5o2OEl
        IhXmaDtjONhNNTJkJBOo85i+fA==
X-Google-Smtp-Source: APBJJlGTaOx/Va0WfosYrUackkgfEAuLx2m6K4nuU7C0geavNrJii9dWjNVsw2A0pDPqeQEWEH+Ezg==
X-Received: by 2002:a05:600c:2249:b0:3fd:242d:ee5b with SMTP id a9-20020a05600c224900b003fd242dee5bmr768072wmm.33.1690357988893;
        Wed, 26 Jul 2023 00:53:08 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:08 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v4 04/11] mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
Date:   Wed, 26 Jul 2023 10:52:50 +0300
Message-Id: <20230726075257.12985-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009; i=tudor.ambarus@linaro.org; h=from:subject; bh=mCXnzZObQc2zhfJufj3cA5z2xujPAjIEucaG9JmkqZU=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYDwwoqDn25kns6GQbu0V+TxM1w1CZcl4Rj xe+vM3yTYuJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6fVSB/0X+AC60NMt+0iVr9T0QiN63zOwAHa4aMnsmWYJfYuZXMlZjXotN+TvdgZV2x1/iRkEKz0 Z9OitjSmE1sl625kHEt9REkbAJSLlVPlGD9QYiOkcgzAhu6pECnXZmpQ3K7+tlvC8GUPMuKwGqj uNA/4iLiFJ8WxXy+BbTW9GU/ts8E5LM7ZuGYDRzRvMch669wzq/3lM0fKVvDWPK1EGPy3fYw4IU 5bUvLljF86BYpxhjmWFvPyvLFMxjXe4/oNjD4oizCummI26MAtv1ZxaKxj7KXP3rZZp0rXxgO2d gUNWRYOdwBBaymo8K2wg0pe7L7Dsj7nffpxf5g3wgDgepeVB
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

All the Infineon flashes that currently support octal DTR mode
define the optional SCCR SFDP table, thus all retrieve vreg_offset.
Switch all the available octal DTR Infineon flashes to use the
volatile register offset to set the configuration registers. The goal
is to have a single pair of methods for both single/multi-chip package
devices.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 51eabddf2b16..94d98b5b0ff1 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mtd/spi-nor.h>
 
 #include "core.h"
@@ -37,8 +38,6 @@
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR3)
 #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
 #define SPINOR_REG_CYPRESS_CFR5			0x6
-#define SPINOR_REG_CYPRESS_CFR5V					\
-	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR5)
 #define SPINOR_REG_CYPRESS_CFR5_BIT6		BIT(6)
 #define SPINOR_REG_CYPRESS_CFR5_DDR		BIT(1)
 #define SPINOR_REG_CYPRESS_CFR5_OPI		BIT(0)
@@ -202,14 +201,18 @@ static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
 
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
 
@@ -247,9 +250,11 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
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
 
@@ -714,7 +719,15 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
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

