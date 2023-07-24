Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6075ED22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGXIND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGXIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:12:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC17115
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:12:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9926623e367so722774566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186377; x=1690791177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=IF+0ss6NBRFxVEvrbdhWI4conkRSs7twLSGYcxdmi6/cC/bynEt5PSWxf9WbyO4akj
         SSkOYO0ltYkykh1A+aRmVxXyb9WYfbifp+QfcC91Wo964JFWwMOTKJLrsNLI9/7h6S2g
         xvwkf659OHSWtNurKOW9lRV0jo4EX5g0fdTh1UC1yy5pdlVmDdQni9MYQfCeVC9dT51p
         aRFtftRXnU/gu0NxhOira9W4ABhJ7GUrLyoFXml9y+65QF8tI6oAQFCs0iRuDmXrh0cd
         59hEBINQ20GXqeeeo8CyAIJxRwnf0mSVKllCSQlovJvg6nNRrXMsuG5JRCGYSZ0jPnUB
         5NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186377; x=1690791177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=SuE+9gdsVfrPuAL7WTU9XKdKDkmPGwbDTclnnqhfqTPGMrj/FimIUaD4J3IbtJmfHy
         GNnE0XdIZPibHRP9KXlSn2mGYM4zwS2pGlPXz8sYJ05Tc2hWUXPSAbAgYGcQA3GPSrmm
         ErVBcLNEwGQRdxIZJSpr76hh+hTj4BjJ22HWFtwyMvKiJh29wR/np/muMF9Q0ia+D8Dq
         Efie+rTHIZbgEOevCrRZaupr3oFa10iPULaHuzL+ePSeKx/c7ApNmmZvAqMrArkdptA1
         DEvT4IJx8dSRUaHCJcrhDcBi7EoGlKe1dJO1M04qYIihf0a7/yXCFvlH0naHKK1oNw8d
         2u1Q==
X-Gm-Message-State: ABy/qLbCAP2hX+Rovhp1eRaMrVXiNkteHZlXBnJS20kBSN5c1UOEFuCt
        e8WOIbI3G4b/OSCTuXF34K/Lng==
X-Google-Smtp-Source: APBJJlFrbF1dyLHSDZqf2T8yfi603+3h845Soxk6FH+ij/grlAEud6qiyv29/Xz1egJwH4A8fSBWHw==
X-Received: by 2002:a17:907:7895:b0:99b:4bab:2838 with SMTP id ku21-20020a170907789500b0099b4bab2838mr9950011ejc.0.1690186377054;
        Mon, 24 Jul 2023 01:12:57 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:12:56 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
Subject: [RESEND PATCH v3 02/11] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
Date:   Mon, 24 Jul 2023 11:12:38 +0300
Message-Id: <20230724081247.4779-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=tudor.ambarus@linaro.org; h=from:subject; bh=kVZ7aQId7ERSbIGrhSxOKuGFZinAOtskWkM0179Q9K8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+SIacWrtM6rqggQL3xW9NW3MgQizA9VFwu e+IRxfckVyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6fIXB/4sxp2lHpr0bsLJOluiR+54Ai3rZFme+Z0Pca5oGlc2cJN4GcjbS3uuNnLbr7tfVFoByji wShomDl6y/CbrxwQzxMake0uet1egUDKMWMu2yTRNbwRE4ljVUgMEF9xh1WpId9T4CkC+CJ5pc0 FXWgZLt/0PjOw5XX+xjohQBXJ21y+U+C+2XPZJwkY+5Vh9uPkmc2qz6KrFOrpemfQRKYB/bWxsO I1IF9O5SU2xNxx1wJIL4/1HQISx1JFwpwJlzQnL51sa1tgg785Vx3zE4n7KJiy9VI+xADeSsD+u WUTXjxqujyuVPa5dvmLNFofEraQia4pr0HXRWfdH/DGgiR20
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

CFR2V[7] is assigned to Flash's address mode (3- or 4-ybte) and must not
be changed when writing MEMLAT (CFR2V[3:0]). CFR2V shall be used in a read,
update, write back fashion.

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
---
 drivers/mtd/spi-nor/spansion.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6b2532ed053c..6460d2247bdf 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/mtd/spi-nor.h>
 
@@ -28,6 +29,7 @@
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
@@ -161,8 +163,18 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
+
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
 	/* Use 24 dummy cycles for memory array reads. */
-	*buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
+	*buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
+	*buf |= FIELD_PREP(SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK,
+			   SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24);
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
-- 
2.34.1

