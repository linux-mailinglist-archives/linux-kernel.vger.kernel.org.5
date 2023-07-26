Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F3762F12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjGZICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjGZIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231274C28
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b700e85950so93844231fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357999; x=1690962799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5jcS1qvmfeGuaQwUWQlurqi39Eg/E+0di+mOyaXrvI=;
        b=nsZniQwd928rjHv8N0YUoY18C0hZZ4OKCNz9qYqK1GMZ9f+0tu21Ib9aoaLzgQItdA
         WuVhEVpUkIJfrrdDrNDta1NsL4DCX4vb6dxQb44q04v+tM4m6p+ffqpE9+wJCQz6HVha
         z+xVBRqQuX5VBPpfh+cXuvL7We+3K8xDkJyMDd2iAyjVYawjcx5Tj/ymx91MrHW9JKeP
         P6akq/vC52ae4Z7W4ZgryfYJFjGYNwRl8wR4HOwapGJ3objZtPYTNJtIIDVmSA6mBInK
         Jmo6Iv9s4O5Qw9QtgKSFOuHCOupIsMzHV4kz3tDbOa7hV5K3eSQ9I3F15iL8FV138C0V
         TMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357999; x=1690962799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5jcS1qvmfeGuaQwUWQlurqi39Eg/E+0di+mOyaXrvI=;
        b=dkJnWUSqaBCPLLzeTzcYqoXfzbqy5l8At+5jXS9DTpDFqNTOBrpQ02i+084d4AZxQ+
         9bD++GdKk7WEC1TY8NpzQMZchJoceZvc18CXgJ5VUvonxlYdcCArPqy25TKuc3K+Krm3
         SHSHGmDyOEyEi6wH+v59VHc8HHczG/Hr30ExVtFdrh1JllEsUF4Pbw0F6QyjYRHKUqMj
         ohtCXYGaLcWkNhc8qf71tjOdZXDubw0k5oXf4I2/Ppf3AnDZSI4WmjfjyANybKZ2pyqx
         eEY0H3IXnaRgoITzFGgj349DGaawM7XC/k2aYuE+fELoYYMT+i03gOxBzguHuQl+luV3
         Lf1Q==
X-Gm-Message-State: ABy/qLZC9TjwWBozbantpIf7vFIlRXJUdRTnmqazXSglVR5zNIQmfWF+
        I69YTvt0gbrn9ruz+YGXhNss5w==
X-Google-Smtp-Source: APBJJlEvBR+0YDOzl0+01yUiRq0NFNaRHew75JOQ5wEpYR/E8ZKz0lcpzHaesMh+oGmFdQ/BMa957A==
X-Received: by 2002:a2e:b163:0:b0:2b5:68ad:291f with SMTP id a3-20020a2eb163000000b002b568ad291fmr832496ljm.19.1690357999459;
        Wed, 26 Jul 2023 00:53:19 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:18 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 11/11] mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use vreg_offset
Date:   Wed, 26 Jul 2023 10:52:57 +0300
Message-Id: <20230726075257.12985-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7480; i=tudor.ambarus@linaro.org; h=from:subject; bh=6eTHq2NR9v4yz00ZyFtEXFO52VWKVfLrd5UtS7Vf+L8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYP/pogcFjD8Enf1q4+mfRGt0OIeM7D54FU xi6nM+wHBKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6dIDB/9RNq1W9pOH9zI6GApqMHrqYjmLmSCU9aG63oJphZ+xNXqbsBIpLuSnCx3FFQHYcY1oxx1 L9RMlwM08eOG5Xm675XrM6GxSgLIDRXaVFzNRq821I/bBYCeo6n6D/0B5nFNdXRlPT0yLN0hUr2 X0m4OjbCr9cBTVxJeeUhLwH72CqufBXT7vBh2kka5lg8n1YKwubTb9Tc0dSzguj5Ivgeo+E4cD7 IQRMzYexPhllTngHL8omuQ13CFHGlNeHtVoK3NWfm/1QXfN7hW92nRD3Iu7si7m9hSmsuxGyNva +BMY5dRVuiz1og0ydGYJSDoVd7FUaUqLMWiGywOdMPj+OavH
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

All users of cypress_nor_get_page_size() but S25FS256T retrieve n_dice
and vreg_offset from SFDP. S25FS256T does not define the SCCR map to
retrive the vreg_offset, but it does support it: SPINOR_REG_CYPRESS_VREG.
Switch cypress_nor_get_page_size() to always use vreg_offset so that we
use the same code base for both single and multi chip package flashes.
cypress_nor_get_page_size() is now called in the post_sfdp() hook instead
of post_bfpt(), as vreg_offset and n_dice are parsed after BFPT.
Consequently the null checks on n_dice and vreg_offset are moved to
the post_sfdp() hook.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 113 ++++++++++++++-------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6abef5b515a1..a23eb2ae9488 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -32,8 +32,6 @@
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
-#define SPINOR_REG_CYPRESS_CFR3V					\
-	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR3)
 #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
 #define SPINOR_REG_CYPRESS_CFR5			0x6
 #define SPINOR_REG_CYPRESS_CFR5_BIT6		BIT(6)
@@ -467,28 +465,17 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 	return 0;
 }
 
-static int cypress_nor_get_page_size_single_chip(struct spi_nor *nor)
-{
-	struct spi_mem_op op =
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR3V, 0,
-					  nor->bouncebuf);
-	int ret;
-
-	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
-	if (ret)
-		return ret;
-
-	if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR3_PGSZ)
-		nor->params->page_size = 512;
-	else
-		nor->params->page_size = 256;
-
-	return 0;
-}
-
-
-static int cypress_nor_get_page_size_mcp(struct spi_nor *nor)
+/**
+ * cypress_nor_get_page_size() - Get flash page size configuration.
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * The BFPT table advertises a 512B or 256B page size depending on part but the
+ * page size is actually configurable (with the default being 256B). Read from
+ * CFR3V[4] and set the correct size.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int cypress_nor_get_page_size(struct spi_nor *nor)
 {
 	struct spi_mem_op op =
 		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
@@ -518,23 +505,6 @@ static int cypress_nor_get_page_size_mcp(struct spi_nor *nor)
 	return 0;
 }
 
-/**
- * cypress_nor_get_page_size() - Get flash page size configuration.
- * @nor:	pointer to a 'struct spi_nor'
- *
- * The BFPT table advertises a 512B or 256B page size depending on part but the
- * page size is actually configurable (with the default being 256B). Read from
- * CFR3V[4] and set the correct size.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int cypress_nor_get_page_size(struct spi_nor *nor)
-{
-	if (nor->params->n_dice)
-		return cypress_nor_get_page_size_mcp(nor);
-	return cypress_nor_get_page_size_single_chip(nor);
-}
-
 static void cypress_nor_ecc_init(struct spi_nor *nor)
 {
 	/*
@@ -571,20 +541,32 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	if (nor->bouncebuf[0])
 		return -ENODEV;
 
-	return cypress_nor_get_page_size(nor);
+	return 0;
 }
 
 static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
+	/*
+	 * S25FS256T does not define the SCCR map, but we would like to use the
+	 * same code base for both single and multi chip package devices, thus
+	 * set the vreg_offset and n_dice to be able to do so.
+	 */
+	params->vreg_offset = devm_kmalloc(nor->dev, sizeof(u32), GFP_KERNEL);
+	if (!params->vreg_offset)
+		return -ENOMEM;
+
+	params->vreg_offset[0] = SPINOR_REG_CYPRESS_VREG;
+	params->n_dice = 1;
+
 	/* PP_1_1_4_4B is supported but missing in 4BAIT. */
 	params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
 				SPINOR_OP_PP_1_1_4_4B,
 				SNOR_PROTO_1_1_4);
 
-	return 0;
+	return cypress_nor_get_page_size(nor);
 }
 
 static int s25fs256t_late_init(struct spi_nor *nor)
@@ -619,10 +601,20 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
 static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
-	struct spi_nor_erase_type *erase_type =
-					nor->params->erase_map.erase_type;
+	struct spi_nor_flash_parameter *params = nor->params;
+	struct spi_nor_erase_type *erase_type = params->erase_map.erase_type;
 	unsigned int i;
 
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
+	if (params->size == SZ_256M)
+		params->n_dice = 2;
+
 	/*
 	 * In some parts, 3byte erase opcodes are advertised by 4BAIT.
 	 * Convert them to 4byte erase opcodes.
@@ -640,10 +632,6 @@ static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 		}
 	}
 
-	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
-	if (nor->params->size == SZ_256M)
-		nor->params->n_dice = 2;
-
 	return cypress_nor_get_page_size(nor);
 }
 
@@ -651,12 +639,6 @@ static int s25hx_t_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
-	if (!params->n_dice || !params->vreg_offset) {
-		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
-			__func__);
-		return -EOPNOTSUPP;
-	}
-
 	/* Fast Read 4B requires mode cycles */
 	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
 	params->ready = cypress_nor_sr_ready_and_clear;
@@ -690,6 +672,17 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
+
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
+	if (params->size == SZ_256M)
+		params->n_dice = 2;
+
 	/*
 	 * On older versions of the flash the xSPI Profile 1.0 table has the
 	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
@@ -715,10 +708,6 @@ static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	 */
 	params->rdsr_addr_nbytes = 4;
 
-	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
-	if (params->size == SZ_256M)
-		params->n_dice = 2;
-
 	return cypress_nor_get_page_size(nor);
 }
 
@@ -733,12 +722,6 @@ static int s28hx_t_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
-	if (!params->n_dice || !params->vreg_offset) {
-		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
-			__func__);
-		return -EOPNOTSUPP;
-	}
-
 	params->set_octal_dtr = cypress_nor_set_octal_dtr;
 	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
-- 
2.34.1

