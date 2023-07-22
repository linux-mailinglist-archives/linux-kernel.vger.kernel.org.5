Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0570D75DB0D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGVIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGVIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:40:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5F3A9B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-993a37b79e2so419267366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015225; x=1690620025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOW1ZpE6/v2ajQK+LnlqMKJQMOzTE7yoF7vscLDu6Gs=;
        b=qNT80/Zlbe9BshSZXck/Xh0cYZdvv5Txu9QfiqaRM0OaV0TyN1eWCa8DR4FNXw0Bzk
         fJxCkbz+H1Gkid78ipk/QXuZUvpUCpCaa9dL3muHd1I3wALxpV3PvGoDvM1Ig0RzwASD
         Szsr0WmCXw5IESDLkn7i+MG/zyMi4v74yEHZcHletcLGDKBgYSIHpX34KgZ/8C84xYMg
         uFz+clWz0GPwb1s8zzrwB/80inRUELrnHBlq3njTJzrItyGK4VWE+GXd7h6LtZV2JWoQ
         Krinqie3FbNbm/t72tN0qnrO4MjkLCz8HjOnr7foGSNb/89qeZVkjWR9okX977+WPjiE
         2lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015225; x=1690620025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOW1ZpE6/v2ajQK+LnlqMKJQMOzTE7yoF7vscLDu6Gs=;
        b=c0PxjX94vVsx5QGqFDDdGaceqv4ghI8UGtlcbL52KFeagOPM6vUcV0S0ny9txPBXVP
         E8n41NjaRUcq3t6nefiUJ/PcDdhTRO7vpKjNCKoo8UC/pTj9nVHzhCokh26ayyc6CXpZ
         VRKBYujvYkC8e4qaIetJ5MD6nSqH8HZAzYRDFMl2L3IFPtnVWD1KoQno6qIgppz/GvLx
         QQeQLaH/7zpzbBGOMCdV+7o0ByCgLTlDTHD7OUxYuIsl+k1F2BPyl+8TZiais7k7f1fJ
         oGheIOxOe1E7GSWvsoef5O21owkBp+6gOoLMn8SJ9d0i5E1B78rboUcGdHG5O+YKGsyV
         apZQ==
X-Gm-Message-State: ABy/qLbfTlrJeJKyEkN7Ho6iRSJF3iKfy7km7LKOMf0UnYhdZcrjGa3t
        rJsaeCXMwgPv41I6wnfZI53s0A==
X-Google-Smtp-Source: APBJJlGWcymer2aN2fSpqQil9d9NKXD4YAk09ouGIhBw/NgkLPikpYhlNPp09K9CCXkQzEDUGzUW0Q==
X-Received: by 2002:a17:906:5306:b0:99b:49ce:b4cc with SMTP id h6-20020a170906530600b0099b49ceb4ccmr3493371ejo.64.1690015225489;
        Sat, 22 Jul 2023 01:40:25 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:21 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 03/11] mtd: spi-nor: spansion: prepare octal dtr methods for multi chip support
Date:   Sat, 22 Jul 2023 11:39:58 +0300
Message-Id: <20230722084004.21857-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820; i=tudor.ambarus@linaro.org; h=from:subject; bh=xpyv1UNUOm+7WUBWb0Vl59R+HvbIVKf4klrF0ttDcrA=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XjcL1Tyl84sNIYkyBfq2rFtCaH7yjWfYS7u dc1OqqEJMiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6VEjB/9xLq3zCHc9dae1xMRtJ+ek/y0oBhA/OlFzbU3DSDM8M3BSj15Z5jy+OuKX79eSHhPkg7b +DAQj8eEAKtkL8X5aAObt93vrdcTTTrSOhJ7yrEVqzKdwvAEMmyzOOq7cQppJ4MQYi00ahEIWmr ou2XkFoaQ2yGZe35GFtndpo56HJj5BqJeKMKPijzlbksszGCa5O2jB2wYkVqJyBfGJtUc4rFow5 5HiuB6j3Sy69QsLaVsoddtyO3W0pd7B/wQEWdWAbGRw6AMM6Gn9XRVWvsKJ1T6j/gTn5AnwsuIj NnFWYLJV1UYVvUZsbmw6PKAKBRBOWEGdRGWIHQFtVz0GEwtB
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

