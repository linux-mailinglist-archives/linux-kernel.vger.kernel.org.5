Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE775ED2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGXIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGXINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C5171E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so717044366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186395; x=1690791195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVktBm6sJYLsfwDSxkCEMzdAYO9ly2+TwdXhkfjytSk=;
        b=sGq3JK8o46jSpuHPepL1m9b3U5faB2dCmQuUcMqsm9ZY4m0Kx5d+MkS9CbuncxZBBn
         rGfVVPh8hI0m4aVPpAmW2Wbn8m23gJpTLuhy15OY3vjJ6KbQCQcvhrtJ6S1B3O8/Q+P5
         U7YGLc97db1/5/vcvlEnZwP+D1wE/w2p6OB6WzjZDzW9n7WrXUCOm0uta40++euYzURw
         t63Io3sgEOMT3SvyYwcQyrs/x7r15XHfvTWJU9F0OIoNSAg+yY6DzfBacrXnNdmJ4zwq
         harQtGHM/ptRmIA2c2eAuWwqOUKoRP7Ss1+hrYIS5dPsTwCVif7mOqKsiUb62+cGsBMr
         TyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186395; x=1690791195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVktBm6sJYLsfwDSxkCEMzdAYO9ly2+TwdXhkfjytSk=;
        b=NpqcoxJ3Rc/Y//yqZI1QodDf6in7KuyExhALSCYdnO4sniVcpjg1HwNXy6rMTjsL/w
         n4SyK9Z4uHU2zk8U4yPPiGTVz9PaUotgtvhUWEDuGWPQFhGu6Xfao5CevZyOq2Qt4k/P
         mMZCBDOKhIF02zPFTM2mx5gERjlHGayGrLm/+Fktn2qMS8iMy+KWkYwvRDyc+WEOXWII
         xKBm4l0wqIAiEXmDp5ki2eSWMTDUFYziCzabBE/PlGSDNLko0mBoGaeRZPc6QmsZV4Oz
         JSu4Jl6dZoT38fIlaz6H7yPi+0DiLvOeTlA9OYdovsDRWB/MdlO5SmP8/Et90aQY4UaB
         Y4CQ==
X-Gm-Message-State: ABy/qLZCwgq5yWeC3MPt3z3dFW2EFPHPLr9mXc0ybj2itHaQ1bkvLfQy
        UaOBdWrmAjJhqRR92mDV3rw5hA==
X-Google-Smtp-Source: APBJJlExAx+HV8ZAaCKyf2Qp7rDblH1XsgOcs5UU9eKDTe7YZDFVoX9leKmqYV0UXmOvE0Zl0WliSA==
X-Received: by 2002:a17:907:2e0d:b0:969:93f2:259a with SMTP id ig13-20020a1709072e0d00b0096993f2259amr9076158ejc.73.1690186395027;
        Mon, 24 Jul 2023 01:13:15 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:12 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v3 08/11] mtd: spi-nor: spansion: add support for S28HS02GT
Date:   Mon, 24 Jul 2023 11:12:44 +0300
Message-Id: <20230724081247.4779-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=tudor.ambarus@linaro.org; h=from:subject; bh=42jO3KEj6TPMriTkqWSNGWStki92z6JnENZKEl1DzBQ=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+3DJLbcgDJ/Bnw8XTtxSY3c8EYXmtEi73A UxghPLI3sKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6W47CACKy1GhVpCclmoAAJYiRpqVPkMcBm58dTZrbpSQ5BzjyW3k/+/u9kNK8cbHzDLP2GFtUIe B+U/vNTce/C7jYROWAfo+DveIyQBzf/T26CrY097wYMKT6LihvmSvt/3PRYwsjfiIPGTXZupjgF bNF32zD1zZc8NVPhzqu1gxy6Lqi589iq/QWaE/CqJn3B8Wo9BeZR2FzusgZWsr+EwOLfNRH/00j riPSj2Cq2coFjjLjbaQhG7ncvxO+4cF9pClsBfFx6p1zgF8h5/Yl2wAT9RemB0IletkvaYy/tLu peI+CFd1c+a5LB2PrVL9YVNtmOcL7az/G8a3N0bikC85dz9j
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

