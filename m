Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5075DB13
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGVIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGVIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:41:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4B420F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9939fbb7191so570946266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015241; x=1690620041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVktBm6sJYLsfwDSxkCEMzdAYO9ly2+TwdXhkfjytSk=;
        b=SzThPkjg9NB1hgiSL/XY0aeozTViHtDiMzgk6m8y62uFtX/p8iTCQR2WiRGHgwdNZ3
         E5uPAYH8vgEPDYXktpPM3Eh52K9/7Of30DA2uDeSFQuAkzeaDktdPJF5wiUMbiw/2VoS
         wDRt5123bsdXN22c+stKVzYXlV9vOrmqnTKIteZwRqsHLN4Oh/pHbzohuBqtAN9CFmpj
         cRLU3He8/UgNLOrBlNDT+b4ymtEkkVNQQolRDeYDF5eR+4WvnWbl35R5KaQoi4gBh7r+
         rJywtQgMYAvunDcQHCuWC1389rE2y7ageQitVzUs2NMNabY9YVmi1wr+W0j9jUOHDOfm
         8vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015241; x=1690620041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVktBm6sJYLsfwDSxkCEMzdAYO9ly2+TwdXhkfjytSk=;
        b=PMlP96WLAVBHxKa6/vM0x5Op95yUust01NmJshzuUm+0YeQsibfwfAAdcAab46SVDa
         n0IuQGioDZUUgOGg7BE26MJeA3cG/oaEhXRZcLIq8IxuIpjx5Qp/jbNlXqj5XQ/yXO2w
         6dpWl/OW76QO4/1SudYTRAVXMicObw7pT8RP/LZI7oFk5FtvHzW5+jyfK+vaBMtiXT44
         0Y0zE3Er4uRqGf54B32BLtKxReh+8ZZ3Sbq0k9K543NcSWrX/wulIHdi3kD6aHRTIoE5
         NscogWJqOGN8Qov8s1DuVRT3blrPMxpQm0wmzeEVZd+DDy9D8tVUJzfbtjlEfM69Ymb5
         YNGA==
X-Gm-Message-State: ABy/qLbE144nj5rvLrv0agPPMhxma0aLov9qXwCUtMguIAis9ZVirdRA
        kS75GyHLhiYwUS/1I1UgBGJdGg==
X-Google-Smtp-Source: APBJJlHU0CfoCkcOmzfRkFAyT2mQNIckuAtLZFMmLl36+XJaWeiOCFD8H29VITnRkpx8wyrwK/2pBQ==
X-Received: by 2002:a17:907:b10:b0:99b:50ea:2f96 with SMTP id h16-20020a1709070b1000b0099b50ea2f96mr4785505ejl.12.1690015241120;
        Sat, 22 Jul 2023 01:40:41 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:39 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 08/11] mtd: spi-nor: spansion: add support for S28HS02GT
Date:   Sat, 22 Jul 2023 11:40:03 +0300
Message-Id: <20230722084004.21857-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=tudor.ambarus@linaro.org; h=from:subject; bh=42jO3KEj6TPMriTkqWSNGWStki92z6JnENZKEl1DzBQ=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5Xj3DJLbcgDJ/Bnw8XTtxSY3c8EYXmtEi73A UxghPLI3sKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6ZTCCACwegMt4CAnc55Yg1eWhGLbJFiFLIVUd4tS6jNoWZgzrfKuFPaWQsPEDa1HgniljW/UQCP G5x/yw/RVzMTjNiQiSs+ZVF9zvUZodyN/+k5LLIbifTnQGTDuDkCl0QuGPEnj1VBrf34vMIiVd9 lX4UR7CjmURnuqpRGn7mDYbqp19oi72/46pz7xmhTLAQxqeW+k2Q9rz8pdlJ2d8G28Cw6cVzDPu dhaKYLnr+6S8nRZ1se1J5QE4cxVAHBQ8XTM5j2n3Yhim4jZ4f0+EFCjswGaM1HJNzcNVSGCCinI hl5OK7ThJWT8A33V8tvQlNR8WH9SoGDoBzdqtIQBAP7Xs9YH
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

Add support for S28HS02GT. Infineon S28HS02GT is a 2Gb,
multi-chip package, Octal SPI Flash.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 2fc3e65686b3..1f2b4a469719 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -695,22 +695,23 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 
 static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	/*
 	 * On older versions of the flash the xSPI Profile 1.0 table has the
 	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
 	 */
-	if (nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
-		nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
+	if (params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
+		params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
 			SPINOR_OP_CYPRESS_RD_FAST;
 
 	/* This flash is also missing the 4-byte Page Program opcode bit. */
-	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP],
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
 	/*
 	 * Since xSPI Page Program opcode is backward compatible with
 	 * Legacy SPI, use Legacy SPI opcode there as well.
 	 */
-	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
 				SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
 
 	/*
@@ -718,7 +719,11 @@ static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
 	 * address bytes needed for Read Status Register command as 0 but the
 	 * actual value for that is 4.
 	 */
-	nor->params->rdsr_addr_nbytes = 4;
+	params->rdsr_addr_nbytes = 4;
+
+	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
+	if (params->size == SZ_256M)
+		params->n_dice = 2;
 
 	return cypress_nor_get_page_size(nor);
 }
@@ -918,6 +923,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
+	{ "s28hs02gt",   INFO(0x345b1c,      0, 0, 0)
+		PARSE_SFDP
+		MFR_FLAGS(USE_CLPEF)
+		.fixups = &s28hx_t_fixups,
+	},
 };
 
 /**
-- 
2.34.1

