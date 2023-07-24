Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6740C75ED29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGXINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjGXIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E110DC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9891c73e0fbso849854966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186387; x=1690791187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zR/M8U1wHDKNH5FK18SqWQfcxUTegtHbVe9hHuhxRk=;
        b=gSFQ/HpK5N6H/8kytfRh2+IX2a3eYAbeGHw5wmyZ/Q4cegnjB7xhpYXGDLuZRjRA5X
         fsH3lktwBPTPkQQhnj508dZGvPlzSF3WqdRXM1IwjnuW/azppW2sJiLQeaGywEl7rX0C
         HpobsrPlf/jbuwR7c43IgxGuiT5ExiQRMevZxhnrdRTBxuKbE6FM8LueSHyNsATzxahX
         3x0IlzZfeMPVJQ9CdVH6gOxGmFs6+URZGyAitNvAMrgMUuMVL31Nkl75IYeB+8EjizNM
         vdHk2Ra4FRfqZH4rUbSOD7h/NeA/1Z4FGhD6XniVXhWCZSwlMPaCvdArYZrQo2m+i2bZ
         9CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186387; x=1690791187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zR/M8U1wHDKNH5FK18SqWQfcxUTegtHbVe9hHuhxRk=;
        b=eutg8aObJPfQXcJ2ndBW02+FRQBcBy/lrbasrKxSg9/yn0zWyBekOmMoSxMul76aNT
         WEHMksbR8Ia2+XcZVL9ExF5dInOh4fYsb8RVUtkIEY0PSgP5I7coFy479vq96ViSfqMe
         ECrN06VQCSW5aQxTaY8iAy7r+YV+lXcX5eNSefbr8gXSV7zibOgkxJITorAkZoiz3HWP
         J6muf6hTV5DMrFG4fYimNJYKQm2oDkuUNYBiKY/8Ct4UrlmUb3vQtGfN+GbnjEMtwxaZ
         tPA3uNxAyuMsPMgU64884NxMEsSTvL6SKiDJmGSnuZ7Omp++MCdQb90nENn8qdpKDAr9
         wz6w==
X-Gm-Message-State: ABy/qLbdeuWsTWB4QQg9jPhcAWcIzUaIkr76kjViJIO8Q9pdl+HIBGMQ
        SZVN8zHZWP6DayUnreXftGNOrw==
X-Google-Smtp-Source: APBJJlF2heJfl8MQDDlm7U5LJn0RmLJ7fM7Slrql6tkji5QwnlxEqIZI61hThIeekB1eqyZykKJMrw==
X-Received: by 2002:a17:907:75e2:b0:99b:4bab:2841 with SMTP id jz2-20020a17090775e200b0099b4bab2841mr9525489ejc.26.1690186387421;
        Mon, 24 Jul 2023 01:13:07 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:06 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v3 06/11] mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
Date:   Mon, 24 Jul 2023 11:12:42 +0300
Message-Id: <20230724081247.4779-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=tudor.ambarus@linaro.org; h=from:subject; bh=Wrd7TgCxXlMqnk/UDwQEgLVdRWdaYJRKC05Rf/3Xxx0=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+6rh7ujEX5KOJrzAwohHe3MP6fhRRPEZAn HCFY1KuZRqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6bOzB/9ghK8NGTdi3IxM8Df5fdqtBbV5rzTB4CsDwL1WCLfQ09LY+dMOZpq3FoZpgwYwi3O/9Co nC4s1mzWjdxGCrY5XXgEUwu06zIvJqn4uhHm1frKCOByHs2LuvDh4BHsjnEXeaPzaJCf8o4xOcV 3VKswMoEvYd51FNnzQognRKtxlTr+2hAf7tqRciVUWQjk/MqfXM4011rfGRKXc1WLdgrNN+N9FQ QY++8UKrFkpJ1UifZoresZHuZUStoqYfGdZKY1Ar+s+0wgCg9Ib3yu/A/c2mRfQYW6b6l++2PrT PMYrBuwSBbfSoUceEHPA0ubhdk3drrFXomwplP/ggMXQDwf+
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

Infineon multi-chip package (MCP) devices require the Octal DTR
configuraion to be set on each die. We can access to configuration
registers in each die by using params->n_dice and params->vreg_offset[]
populated from SFDP. Add MCP support in set_octal_dtr().

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 5b6f36b56e9f..28d0a995f3b9 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -206,17 +206,19 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	const struct spi_nor_flash_parameter *params = nor->params;
 	u8 *buf = nor->bouncebuf;
 	u64 addr;
-	int ret;
+	int i, ret;
 
-	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR2;
-	ret = cypress_nor_set_memlat(nor, addr);
-	if (ret)
-		return ret;
+	for (i = 0; i < params->n_dice; i++) {
+		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR2;
+		ret = cypress_nor_set_memlat(nor, addr);
+		if (ret)
+			return ret;
 
-	addr = params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
-	ret = cypress_nor_set_octal_dtr_bits(nor, addr);
-	if (ret)
-		return ret;
+		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR5;
+		ret = cypress_nor_set_octal_dtr_bits(nor, addr);
+		if (ret)
+			return ret;
+	}
 
 	/* Read flash ID to make sure the switch was successful. */
 	ret = spi_nor_read_id(nor, nor->addr_nbytes, 3, buf,
@@ -251,14 +253,17 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 
 static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 {
+	const struct spi_nor_flash_parameter *params = nor->params;
 	u8 *buf = nor->bouncebuf;
 	u64 addr;
-	int ret;
+	int i, ret;
 
-	addr = nor->params->vreg_offset[0] + SPINOR_REG_CYPRESS_CFR5;
-	ret = cypress_nor_set_single_spi_bits(nor, addr);
-	if (ret)
-		return ret;
+	for (i = 0; i < params->n_dice; i++) {
+		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR5;
+		ret = cypress_nor_set_single_spi_bits(nor, addr);
+		if (ret)
+			return ret;
+	}
 
 	/* Read flash ID to make sure the switch was successful. */
 	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
-- 
2.34.1

