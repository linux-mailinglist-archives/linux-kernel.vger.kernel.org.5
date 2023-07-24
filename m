Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1366C75ED2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGXIO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjGXIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:14:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9FD1AE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso1574442a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186407; x=1690791207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjpE0CTKohDZ2ehuACLTkZqrmJb/Yntt3sN7R44vEtA=;
        b=xnK7gh0F2XnAfmAj7Ba1o3LJ6gE86oxlduR7gzGsnqUaQDPW0DjO6k+wKCrWJolfMV
         YFQAJTae5IuAHo31uL/QrUyJPzR6OaqHN3jLrkBGcTvak4Kycx7E4h3lonGmDuElS1Bx
         z6guQ4efnsjzSPgTIosyC8T9zqXD7npWb/xRPq7zTvO+NLrfKmq2Z1GJi7guVeckwhPi
         mVO+Baljx36aLdOu0AyqDDSwWJfJFwzueLK6sDRsoZ5Y7Fj9SodKIvqhlWWCxSq9ZE8i
         hqGc2wDUkDYkYYzc3og0mFBAI8QE+mL7HDMA/b0GulSzLa7k0Xivj+Yq0YhigcwxgUhl
         PP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186407; x=1690791207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjpE0CTKohDZ2ehuACLTkZqrmJb/Yntt3sN7R44vEtA=;
        b=H3uaMUS5VM6gnuP0P9SWJPaD+wK9ZhjQvL4wErSaKyLQO4LLgmSV1JTpVfXMDCp1iZ
         CYBzhrUekysp4U1nVFrPw5Cn+1AwUYX39ndTRWZwtdD0j4bzjmMfohK5g881L+iOOFEz
         QkyAeXMqukDHN+WQUXfHeB/VnGqvY1IdWrYEM2qJrRoVWOS4+k7jwUnLSPlNqy+IMWhY
         whI3s/bFpt/zLE0cIQzgjinAtBw6wOHZRgUxQrsDyF1ZROMNqvd5vxpUedx4FryyIIcC
         yqI+bVLyyaDgbQuQ1mXiLXkuHApyY8GbByF6lXWO9Vk7d45bNKbpwUCS8kvUa2dVDAkL
         wFmw==
X-Gm-Message-State: ABy/qLZFK84+cdvCHOqEs/gluXwDCG0f321dcVMqG9AlMVwb7hvLMd8Y
        HeU9nFJKCbIZgkXcYjlEfN8snQ==
X-Google-Smtp-Source: APBJJlGUL2q0PX1PyO+HWJGPTCESCX+Zx0heqGiwB2fUoec14FFM4neH/1+XpitqtN1NgIf8XO++Ng==
X-Received: by 2002:a17:907:1de6:b0:982:79fa:4532 with SMTP id og38-20020a1709071de600b0098279fa4532mr9124481ejc.53.1690186407034;
        Mon, 24 Jul 2023 01:13:27 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:24 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v3 11/11] mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use vreg_offset
Date:   Mon, 24 Jul 2023 11:12:47 +0300
Message-Id: <20230724081247.4779-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6780; i=tudor.ambarus@linaro.org; h=from:subject; bh=MUJq2mMJ7nIureH4NTnSp4c0il3VTp5/1NGTZmdRv8E=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ/AjClsiJy+r+/oUJQL9lKwKRmy/640tCVi cFl1S4x6XeJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfwAKCRBLVU9HpY0U 6UyACACihYeFek6vZM2wuP6gooTVtrkuQT5Myp3MWn40rPLrLh3/dTfZyuhJl8GEDwfykX24Ecc aEj0LnTn1IGBg9q0diCEtiGkoOmcIcqdXNWpMlsC0VlifsOZ+JXS9Lc8bHVGEyTnfX8w58DaZTN yM1+opq/Tz/u3Fmn1FAM2f1UNX+9r7AgDqIRKitESVkmD/OYeoO92RbAoXJZ6WX0X5GnhzJfgFP vSk/GNok44dcUaj5RRrGXVKdvaLSiodma8LRekoOUC3gyhOyQzEq3o2QVE5Vo9NpeoLeY3bm8lb 8Kp9DGsZI+5fzj9+dleV+rAnqFJAJcN7GgpRuO/nrbCogAgr
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of cypress_nor_get_page_size() retrieve n_dice and vreg_offset
from SFDP. Switch cypress_nor_get_page_size() to always use vreg_offset
so that we use the same code base for both single and multi chip package
flashes. cypress_nor_get_page_size() is now called in the post_sfdp()
hook instead of post_bfpt(), as vreg_offset and n_dice are parsed after
BFPT and we now use them to get the page size in the post_sfdp hook.
Consequently the null checks on n_dice and vreg_offset are moved to
the post_sfdp() hook.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 105 +++++++++++++--------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 4027f0038ce5..0b01af33aa57 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -471,28 +471,17 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
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
@@ -522,23 +511,6 @@ static int cypress_nor_get_page_size_mcp(struct spi_nor *nor)
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
@@ -575,20 +547,26 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	if (nor->bouncebuf[0])
 		return -ENODEV;
 
-	return cypress_nor_get_page_size(nor);
+	return 0;
 }
 
 static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
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
@@ -623,10 +601,20 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 
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
@@ -644,10 +632,6 @@ static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 		}
 	}
 
-	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
-	if (nor->params->size == SZ_256M)
-		nor->params->n_dice = 2;
-
 	return cypress_nor_get_page_size(nor);
 }
 
@@ -655,12 +639,6 @@ static int s25hx_t_late_init(struct spi_nor *nor)
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
@@ -694,6 +672,17 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
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
@@ -719,10 +708,6 @@ static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	 */
 	params->rdsr_addr_nbytes = 4;
 
-	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
-	if (params->size == SZ_256M)
-		params->n_dice = 2;
-
 	return cypress_nor_get_page_size(nor);
 }
 
@@ -737,12 +722,6 @@ static int s28hx_t_late_init(struct spi_nor *nor)
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

