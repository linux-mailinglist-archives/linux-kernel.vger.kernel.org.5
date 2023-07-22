Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEC75DB11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGVIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGVIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:41:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91773AB5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992ace062f3so433614666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015235; x=1690620035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zR/M8U1wHDKNH5FK18SqWQfcxUTegtHbVe9hHuhxRk=;
        b=Q8CDUX1g919ChNF1aXrbToRMtSAuo4l2fClsOX5A9ydH5K3MX+x0uEDUreGg61XcfB
         0OexDaywZdd8lWC6tOn03l8mAm/is66saBlUY7CHBgwVWaRBmAPF41E4SYUelMxeCS4h
         qzPpU4Z0NUecnH8BfjQ9sdHYImROoh1B2XpTgopDL+7gKjGa+9LMJD7/GJ40g1fQC2lX
         mRlTfWInp0HqYNBHScwezmMWfzH9UJxktF70q4yL+0QGB8GhEw/fBuC1eBQvEAhuEtNb
         b2MxBGKhTdk1dyy+XiihQ6C7Krl7+usdDOAyRECIh8/jz3tyKYrqQtOjx3hQBlYd078S
         DwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015235; x=1690620035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zR/M8U1wHDKNH5FK18SqWQfcxUTegtHbVe9hHuhxRk=;
        b=Q10QzUTFuGN2Bm7CQVg3i6OUTYmx8BzKznps+CNhyGuyRQ5gE6dM1lioZRFBVmRanV
         Dwd4jGqxffpcvuElNBoyE5MMMFGmhxv0QIwu6vhFDq/yWNp8AHrnCLk8nRLIoGOJ76U7
         90UObZU4lvhHqBj2g1199auyjfhLRly7fpiqTtdQtYM9I0jdKHstayfuTLn2nHazJ91E
         R1wPksGJJVE+bHOLTU8P3BwmZEKvUm7XSEt/gB+LgAn+/tBEZaNSwVaYY88uaVNjnWv0
         Pfpvzak7CZKpfaGaEYrV95Q5IcR1Si8qzhXgV2QzXJt/T8Vh4UOei1kz/7qj6lSSdmas
         bbdg==
X-Gm-Message-State: ABy/qLZeJUL5Q+i2lWSGsky69SgMH4kOd+fmH5cSQgF35knC0h2gWbRX
        C2n9G9ai0hO05pl+LirpWU3LcAYnVD/MsG24yLw=
X-Google-Smtp-Source: APBJJlFLqt4xcTFAt2SORNGL+XlPD4TKMSXUYNLhF5LHkHtv5TWjMVJb4msGeL3AmaHBWHpP/Kp8Lg==
X-Received: by 2002:a17:907:a056:b0:994:5396:e322 with SMTP id gz22-20020a170907a05600b009945396e322mr3888825ejc.1.1690015235212;
        Sat, 22 Jul 2023 01:40:35 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:34 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 06/11] mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
Date:   Sat, 22 Jul 2023 11:40:01 +0300
Message-Id: <20230722084004.21857-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=tudor.ambarus@linaro.org; h=from:subject; bh=Wrd7TgCxXlMqnk/UDwQEgLVdRWdaYJRKC05Rf/3Xxx0=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5Xj6rh7ujEX5KOJrzAwohHe3MP6fhRRPEZAn HCFY1KuZRqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6eWOB/9+2h8aDbm4YrPkRSrcKUFhB5510QgyQbrAdkMp2QkSds+NKEyUPi3vT3ssN8FoWehS71q ritgg5fmEKWDSvD+vfkpvucWch3obftYa7XOBRbyyhCeQqzavdNktNYaW4TZ+CGHl2XR2hEbBro AfPzVsTdcrJirY+aWhPBEV4PeDg2Kg3hYXX4r7IuXEVYDcitDuhYV+NoQPLMZMvc4qA5sr8Od5N wohkPhYJW1GhiNdPFTvPKgqs+3dU7hZpyPbYGKT5qDQ/9Uqd+Vdfx342In8AI4akCJi1gN2/Tan Rf3vwiL5+MrIYOjkgahLZA71m4NPyRJgJFzk3r/j9JzHDn97
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

