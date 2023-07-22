Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68175DB0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGVIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGVIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:40:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCFE2106
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso416280066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015220; x=1690620020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=n4seZDY0bMuh9xp7Iuhq3UR77wpwNEpdbqlB0BPZwZI8sMBJ7tv7TzP8yy1rqhAe3J
         ZrRDdwZm1S+TLt7bVhibZWUffxysVi6BrgZRB+zkLUX5rO9t8DdMj1yfnWCilZyt6909
         1eg86o2EY0sxMgwzCFY/YMYlPmLARJT6UXdfKn3eNU7pdkQB1E7QVIarwst9Nlws2MBO
         QhupPqkXQdHZpM23yiyXDVwfOMuSzJ++tLcDXlxmaIQwRmeR9ZAg0X7TBLv/VsOL5XAa
         yNFKB6K6yxorxL4i1PUNiEy6YzYEBc64stVXvvz2yHasPWkiM7BouprLqk7h/EItfP7d
         I3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015220; x=1690620020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=bR1KyaVc1MRLlu4BvoXTS6O0HGSwK7xDBK5aqb55fxmJ/VgEKOHlGVPV1Me1j6f+96
         TwM/7yW/el+Fu12C+grRtNruHcckgOurUcr3rNfJYItB1gN1xWeU3e5j/yNaBPU9A7zc
         L2udb2qxsGn0t1IOC/ZSIePKDbiKFkPviRx3Wlki1iQTmEsxol8gFWBFhEg+Tu3MGDI9
         Z3gfHS4RaFmWBbmJwOuWQfVNxScCAz1Hw9M+g3ypmzjIX+Rjhw4x83ceqWti7koQdluK
         cd1NWnWXekq3pDlEd7mV9G9iyirA7twF/CZ+EA9sz96B8LUJFMFPEcA2xBn9NlwrNtBu
         2o6A==
X-Gm-Message-State: ABy/qLb9py7swSmT+TIYTEyXRjLhntut9XGZSrT7yG3l1quBQBOGxHeu
        64EY4ia7EiGyJjwbGWI1vZ6CZg==
X-Google-Smtp-Source: APBJJlF4lMl5iWQYQ/4JO4kw+zAmtEy7Y8ZV+haXiFSDaQ5Vdtk6DJHqYZ/wuPRGiL+IpYJYL/0U4g==
X-Received: by 2002:a17:906:3059:b0:994:673:8afa with SMTP id d25-20020a170906305900b0099406738afamr3849246ejd.28.1690015220231;
        Sat, 22 Jul 2023 01:40:20 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:17 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 02/11] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
Date:   Sat, 22 Jul 2023 11:39:57 +0300
Message-Id: <20230722084004.21857-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=tudor.ambarus@linaro.org; h=from:subject; bh=kVZ7aQId7ERSbIGrhSxOKuGFZinAOtskWkM0179Q9K8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XjSIacWrtM6rqggQL3xW9NW3MgQizA9VFwu e+IRxfckVyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6YbLB/45qZNj8nqPWcNS3Itsu5FdKDrhjLuejWXdzdmPSETVdxeQz58b4LPfXz+sOF1aqcEOUSL LOg0Lb3Od7CYJMV99JDgS8ABw5FOUFIi5KGBoniJ+fnuS9F8VSHsU+QT59CQ/RE7J4t4DZO2Lv0 WGAjIEzRmnPNJTeN5eOJEmgb62EJ8spSGmwuFgZmB2EBAb7fOlEVhqQ9HMGs/o438ixCJKD6Fwa xJmD1c6Gjy/uMn15C5yq72c8GHsHHmQ6YcN6u+MnJ+CDtQl5806ib/dfeoAprNBYazjB82cP8Xn FnfEVTsgxAH/DnIBtVBhEYNoROepT57/DyxonpJISVr4mWnq
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

