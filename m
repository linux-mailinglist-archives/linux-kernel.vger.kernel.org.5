Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C975ED23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGXINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjGXINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E712E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-993d1f899d7so717963966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186379; x=1690791179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOW1ZpE6/v2ajQK+LnlqMKJQMOzTE7yoF7vscLDu6Gs=;
        b=JDj+wnF8yQouCVrrQKETHEvvp6b3VpVDNs5K5tqUgWfGuih0tmOk83JGe9at5g06wr
         XkgzGrDO83Gaw4+TRv84K2Dw1a7drN/HMLi8Xsb+2/p9xWcBKKcqMIy8PFdgK1nPmKDx
         EEPKdf9xhYBO6pR5AFAUJIjbVKUQAYdYP3kfT2LqjwVRduK44LCHCsbOQhrQ/cYvktMq
         58hIG5EFzx+XpJpaWVuT6hqPYu0cyy/1SLjyp+SFxoJWDaNWqGoEfjahm48hO9k+icjx
         6q6ncxxmhF3DZs6InQ8wGWSv4WvV9Mr348wWJ4N3UT3ADWO9wo0uDX5kiVGoj04ekxgb
         DhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186379; x=1690791179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOW1ZpE6/v2ajQK+LnlqMKJQMOzTE7yoF7vscLDu6Gs=;
        b=RacgcEjlo4X+NhOhrfr9kng32uMwgakM6ydQoVDGfPS49r/oqB/uQdmP0oAkjaLCEE
         TEpyiOyhpvBgL+7PQmgB7BXn1NqWuZC1/6FlTR2MCngtDAFJW8ArEgwxCVVkhzdcaD0x
         GtKrWsbmuJB775nakB0PdctAGKiTxtOuM3m/q7y0C0iIqRNdj3GLvgdmD2Vu3C4V1Mbm
         JdL/5ry21ifsOGtK+ICTbNYxmMJhtXsIoKSkCsDNTD2ooC9CSJ9Sxtnr/ZF1+8EsQDNC
         JwdSxk2eAQV/0UxGUXBN0Hc7LpTJAjJcmAvC0wp+OqYLSeAcBWTkb0Vz9CdBPbw+f22R
         Hwfg==
X-Gm-Message-State: ABy/qLaA24l/U+3ezC1xh2RBNg0EWvO2J988ZoZyyz2pkYfDvf2HRCuj
        6lBWpdIX3+iIRM0OAfKzNbX25Q==
X-Google-Smtp-Source: APBJJlF5DN5lXH8fTejLZtW8eJla8OQDmeW6ZRpLHgk8ob9ppkwAXRuwapkwP5Cr6qktk0vTBm5dJw==
X-Received: by 2002:a17:906:20c6:b0:96f:1f79:c0a6 with SMTP id c6-20020a17090620c600b0096f1f79c0a6mr8864498ejc.70.1690186379120;
        Mon, 24 Jul 2023 01:12:59 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:12:58 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v3 03/11] mtd: spi-nor: spansion: prepare octal dtr methods for multi chip support
Date:   Mon, 24 Jul 2023 11:12:39 +0300
Message-Id: <20230724081247.4779-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820; i=tudor.ambarus@linaro.org; h=from:subject; bh=xpyv1UNUOm+7WUBWb0Vl59R+HvbIVKf4klrF0ttDcrA=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+cL1Tyl84sNIYkyBfq2rFtCaH7yjWfYS7u dc1OqqEJMiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6bwwCACZMu+rPl8e8uNTwrWcuFUGYQBaS9XZuG8XIKvziwOQI07kaK1F2tHjzDhOExyHcrKTmDS kKUJNHHnxz2RbevGYR1sjJJyGVtdEN7yvFBxZrBQ9maIOFg0SJowEtnANesQRaBLMs8Qjxyv7ho KRNkkU/G6mF1R6QnFVMIezeiFEqZCIT7o+GQGWQATpz/pUOMZuiw91p8h915Kw/kXxBv99m8VXo aXUZwXMqiBf/EEYLr0Fg2s7mNI9/yoSiNVUIgDekgIwwriQbp/2mP6H6NeTCI/ztKGH+Ddqkd9w 7rSJ3kAHilhWRbiNySha+9gSBrvmWbhxq2/YTGvsT5V77GZx
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

Infineon's multi-chip package (MCP) devices require the octal DTR
configuration to be set for each die. Split common code in
dedicated methods to ease the octal DDR MCP support addition.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 50 +++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6460d2247bdf..51eabddf2b16 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -156,7 +156,7 @@ static int cypress_nor_sr_ready_and_clear(struct spi_nor *nor)
 	return 1;
 }
 
-static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
+static int cypress_nor_set_memlat(struct spi_nor *nor, u64 addr)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
@@ -164,8 +164,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes, addr, 0, buf);
 
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
 	if (ret)
@@ -176,8 +175,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	*buf |= FIELD_PREP(SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK,
 			   SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24);
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
+		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes, addr, 1, buf);
 
 	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
 	if (ret)
@@ -185,13 +183,33 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 
 	nor->read_dummy = 24;
 
+	return 0;
+}
+
+static int cypress_nor_set_octal_dtr_bits(struct spi_nor *nor, u64 addr)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+
 	/* Set the octal and DTR enable bits. */
 	buf[0] = SPINOR_REG_CYPRESS_CFR5_OCT_DTR_EN;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
-					  SPINOR_REG_CYPRESS_CFR5V, 1, buf);
+		CYPRESS_NOR_WR_ANY_REG_OP(nor->params->addr_mode_nbytes,
+					  addr, 1, buf);
 
-	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+	return spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
+}
+
+static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	ret = cypress_nor_set_memlat(nor, SPINOR_REG_CYPRESS_CFR2V);
+	if (ret)
+		return ret;
+
+	ret = cypress_nor_set_octal_dtr_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
 	if (ret)
 		return ret;
 
@@ -209,11 +227,10 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	return 0;
 }
 
-static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
+static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
-	int ret;
 
 	/*
 	 * The register is 1-byte wide, but 1-byte transactions are not allowed
@@ -223,9 +240,16 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 	buf[0] = SPINOR_REG_CYPRESS_CFR5_OCT_DTR_DS;
 	buf[1] = 0;
 	op = (struct spi_mem_op)
-		CYPRESS_NOR_WR_ANY_REG_OP(nor->addr_nbytes,
-					  SPINOR_REG_CYPRESS_CFR5V, 2, buf);
-	ret = spi_nor_write_any_volatile_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
+		CYPRESS_NOR_WR_ANY_REG_OP(nor->addr_nbytes, addr, 2, buf);
+	return spi_nor_write_any_volatile_reg(nor, &op, SNOR_PROTO_8_8_8_DTR);
+}
+
+static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	ret = cypress_nor_set_single_spi_bits(nor, SPINOR_REG_CYPRESS_CFR5V);
 	if (ret)
 		return ret;
 
-- 
2.34.1

