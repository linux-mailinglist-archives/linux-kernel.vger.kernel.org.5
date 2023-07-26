Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1C762F08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGZIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjGZIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F933A84
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so63652785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357986; x=1690962786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=pq4Brhj55ONYmo8UszaBri7HNV1FDePeR8ylO84tUQWnC1hEsyv2pej6cyTBETJXQD
         wGM/HNoMSqqxKkeNBKInkKlPysEn/Pv1FhMUeRcOIhu3UD8diovitZKQph8yEgOHVC9E
         PdOMG4qNqQHm5mTSx/uYKcomYZ9J4xkdBt3O5NA3ue9qhh2pyTtYsjYvB/pgE94oszlP
         aTEyES+NgWstAmIgOqT95rVsP6NvGYQ9qLroWIbjzjTiI3pnfErDZjeQrps3d2ZNdM2l
         D63AC0v2pVy2nU3zxtvkZ27WRwP2sD304/B6woWo1k4NfF67Gq6sdsJC1gBORzwqHJyu
         rmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357986; x=1690962786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9TJeEMNRCv2DgCOuJM1bBGc8b3D58xXpaHuqfHRQK8=;
        b=CejHRqG+l9nn8OJGynAXepb38//i/DdQi0BuSINmUar+4v1Zn+p0enfqTCBVVpM4FV
         WEjT/BMjqQYUf+/QBS0cWbyWNa27GWjmQIk5nkSjy6FEGQubt7GvBRzAKP/VHT6Ku8Pu
         3Q29q6pKPq6agT8Sfme48+15gTldOGDQWaw4ddEEN9WjrrM2ZqSIljihIlQShSZJLuky
         8T0Wr3n0Y+DAn5E4UAizxrHQQpi+1V2szkxHF3ShNx7R+iwtnomF4+mavzTWdOtEtwg6
         ySowby5uPN29MsOf86jDTPPTXYxgBv/+yhIV5ipS4sMO5WO4VkQGZUj6V5EBtczchMg9
         5EAg==
X-Gm-Message-State: ABy/qLZ3+FCEjpgZ4zGjxqLOyvFHv8N2mqcqBNmxuu7c/XCx3cZmrb0w
        V7GESHw5H6P1QePzpm5zBw1oUw==
X-Google-Smtp-Source: APBJJlE3xLWWa4x2NUcgPXxOGOScoCjYHAfSUUOory2sLtH0JMctp8AXJ4TIsUaWGm4w9kkkgzOeBw==
X-Received: by 2002:a05:600c:2212:b0:3f9:b8df:26ae with SMTP id z18-20020a05600c221200b003f9b8df26aemr766600wml.34.1690357986164;
        Wed, 26 Jul 2023 00:53:06 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:05 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 02/11] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
Date:   Wed, 26 Jul 2023 10:52:48 +0300
Message-Id: <20230726075257.12985-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=tudor.ambarus@linaro.org; h=from:subject; bh=kVZ7aQId7ERSbIGrhSxOKuGFZinAOtskWkM0179Q9K8=; b=owGbwMvMwMXoHervvrRX5CXjabUkhpQDF657tM2J2u3zateCRqbvR/N9o4sVnHQOfA0s2Pm+w 138zsSYTkZjFgZGLgZZMUUWWSetU+f5TuTGyf67DzOIlQlkCgMXpwBMpPAA+/+ckoQ31xSlePsW SdUvdJtreiBl1928qPwPBxxn73n6JmVvsiZ3SsHGvSGWSS3XRNbw/C5V3bR338nN0x2mL/DLbEo RfcUm72IhOTfsM7+2B4Omq9j5P97d/X1OW8+WhJbJvdO69W+Z3ArWl+3Jbzb9XBzsV+EbrO2qYe Lxs1PkDYfB1BX+s+fGHZoSXNO3R6OrhV3sRtDvM7dvTjnuPtlBzTW58pF3y5r8NIu/rW1n57JKf eKq4p69vMAo8Fjrgcu6a46JcptVCooefnJYUF7w05Il5d0CniVBOS4fWjK7rY3Ewg/Wslkr5S91 7tzOwvNznbDed55S2+LfvzgvbFtluXPyvyqeD5tj/DgdAA==
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

