Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5275ED2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGXIN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGXINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEF1705
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992e22c09edso596709766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186391; x=1690791191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkHM3RFGQ0WIr5v2TWHAHkTdJrhHVucyrUvsad9WfOo=;
        b=deuRTZstRG4cjvLu+clvj8bi6F+b/ABQ00rFEdb/nZpASZp4DaGZWenjE4cGdrRm4M
         9htdKtMmA21QkObKsHHKINz2Oi0+UZDHkq02z0kM8zRu/LXF64qf6r/ISUdS0H5W9Zom
         QV0nxQycoAYQIcYpFqow0Szavf7JSW2OYa9OnlOjWcaAeeKv6deuP29rLjFcNs0acE8Q
         Zyhriv5zVWhdoaBXowGFJZSdRbmfvR5rtT2u3fNdq+g8PsopZCOxY/6I5c7SPZLEAgkt
         U09FFJzvp2lnk73nmBPpG4uD5VU3bvLaPjLdG7M8ghECJKRpGNsYy++jqaBtoDJQCpOu
         VnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186391; x=1690791191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkHM3RFGQ0WIr5v2TWHAHkTdJrhHVucyrUvsad9WfOo=;
        b=DephssKUAabpGaTe1D9fu866wHYos+t7izLhIM6Sn9OS3IyrAxzYtArwbmIJIL/33u
         ACjVcT+l3GzJBC167MpMaHFRQLAQNdjdW4lYUAMO1Haa1FBfxFLjVFmlSPmsCZYGJMNu
         XLpoD6r1IhWwfRh6j8zMIwDna7sROTIbKjF914R6HGGNf+j3kC6qgL1b5123/RSziNHa
         ExqrS4kbcvRBsr44CHPqs3i3QAfkpyfiffCiia/bDr6jF4XJVdurqUJLKIdinYE9agkC
         elPeckz2XAPPuT4GPCTwjCGLOnDKVObjifZccjoMLMDRTxP5BEwUtbE/LUwymbDEnbqO
         LHTw==
X-Gm-Message-State: ABy/qLZwpe/D+OOR01uM91u5F3dbTUVhMznlW24C1r2J2acPbbOnUDbb
        GYQsWJZ+4hxH48vSVcrG57VwVg==
X-Google-Smtp-Source: APBJJlHSxOp0xPKToV9ONheJ//o5w9GLr/jPtmw5rrpfHCOWAJ13ocXV1lLD8LOrgl9iQBS3bEGs4w==
X-Received: by 2002:a17:906:31d3:b0:993:f90b:e549 with SMTP id f19-20020a17090631d300b00993f90be549mr8877382ejf.37.1690186391119;
        Mon, 24 Jul 2023 01:13:11 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:08 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v3 07/11] mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
Date:   Mon, 24 Jul 2023 11:12:43 +0300
Message-Id: <20230724081247.4779-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=tudor.ambarus@linaro.org; h=from:subject; bh=ARtE+Fv/l4a+BkMfBrTfq2ov79VZLg+i8bYbcphxQmM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+bqmEDqHMfs1PJlBNahV34jcDlLvGaPX+Z cKEiovvOcyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6ed+CACMM3slBgYr2/UDm63/4pQWiMj1acdFTz6d2k3eD13QyQClOeGJIqfqwPCSfGWO94K8CAh h7DmAjYFrttVS6/Lb5HLhPkhtEY0holI46g6IRpyvipqRcdTK8hf7nQPejfO49PuwfnCosiEUzu zLJ2tBN5s3OUsZauWrCmBeC3Wpp4P6DIGfDQ4N5vxuwwAa4EFLvrRGHB7XzmK52llClTWmxDSmB 0IILcuxRBw9mqRytpVm+RGKB+cJg7WrDFkroIA43qvK7PVLJ20c5iLUJp7T1UVqy48Sz+zftLtI nh6dFLVBmFWwrHZVEQWZhiUbgkscQIdx8i9dARJ1bfXnrXdo
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

S28HS02GT uses RD_ANY_REG_OP to read status of each die. In Octal DTR
mode, RD_ANY_REG_OP needs dummy cycles (same as params->rdsr_dummy) and
data length should be 2.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 28d0a995f3b9..2fc3e65686b3 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -104,11 +104,17 @@ static void spansion_nor_clear_sr(struct spi_nor *nor)
 
 static int cypress_nor_sr_ready_and_clear_reg(struct spi_nor *nor, u64 addr)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_mem_op op =
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes, addr,
+		CYPRESS_NOR_RD_ANY_REG_OP(params->addr_mode_nbytes, addr,
 					  0, nor->bouncebuf);
 	int ret;
 
+	if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+		op.dummy.nbytes = params->rdsr_dummy;
+		op.data.nbytes = 2;
+	}
+
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
 	if (ret)
 		return ret;
-- 
2.34.1

