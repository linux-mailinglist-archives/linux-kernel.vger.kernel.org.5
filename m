Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8267756949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGQQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGQQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:36:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A15191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso49873545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689611764; x=1692203764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8bP/ypkDEicRqegK1ckEg3dKW2SZEz72dtAjxisDjE=;
        b=Uhz2RKXFF888YxPlPlECu1mLqH98lSlnqziMcnEPgZjWbxMYgREH+eu9F7OU0PTzqB
         XEFisE5XjxVXToJrXeD806zWfZxDdTq6/777B4WBT2KYhobutH0CbrJsoFM6iJupF4/5
         gVOv1uX6J1gO4u+Cl3AYc+RAJf2gMJp7kaZHWDIEVRnWpyy4lmoh1KDK6cKwWH4VcGxw
         LCw4Z/sSzew+0GhbwYNtdPfPJeOwIzn7L02hyLmNc8VWfGgg+klrO1pPdyAuuV5Lr9wy
         VURBq8n/G+ONJ/j1750Fe7HDHt03Kj1wtH4wKX4cZsMAYxHkGfP0vugrG4HmgqUj5z3h
         KVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611764; x=1692203764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8bP/ypkDEicRqegK1ckEg3dKW2SZEz72dtAjxisDjE=;
        b=MZW8s0YGdtqmQG6OJXXTzYrx5wnFMf8sEYDVpGdse9zDI51HIL0xytlkLuWH1dsuLn
         aJHFoo99d1DTCgcqoYsiptKhmTmyojbWfVdO173P9DJFcZES1W7fuJ5U5upTeZBi+KYR
         GEnwOvQC+cAppNxseVABH1AvGYiFIRFrS18LeyvUNjgkuE3guYYa2lEk6KBqF+xZ53jl
         4qdfrW0pGv4bnui3YnIqQTPAWbMgBiBKd2kFxbDMrV/38FMZwNR5Qh3qCSX2L/IW6WTq
         joobmHFBuMnx04xtxTDYOGspluCBRPWqi74sYfbTFlRC6myWiMD66OhkwkYuWp6bHJfB
         7iBQ==
X-Gm-Message-State: ABy/qLadvmcOdsc48/9w/CJ/4BeMf9cd1pa7P1vWVgJPeIR2Or7MfvGF
        KaQvOD3GrUiSNAVohcLm94sMys3DQEoguIMawN4=
X-Google-Smtp-Source: APBJJlHQJOUxudXuvlRKed/GyjyonoToL8pJYFeXFNoiFadNnfM6DgMYmIUqpPPm//OTyTMqQT/46A==
X-Received: by 2002:a7b:cbc6:0:b0:3fc:70:2f76 with SMTP id n6-20020a7bcbc6000000b003fc00702f76mr10796513wmi.20.1689611764148;
        Mon, 17 Jul 2023 09:36:04 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fb40f5f553sm8401774wmi.31.2023.07.17.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:36:03 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, ichard@nod.at,
        Takahiro.Kuwano@infineon.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] mtd: spi-nor: make sure op does not contain garbage
Date:   Mon, 17 Jul 2023 19:35:57 +0300
Message-Id: <20230717163600.29087-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=tudor.ambarus@linaro.org; h=from:subject; bh=Mux36ybHfWkJ7tOaNPO0Gnmji/GnoNj7exBtCMurQb8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBktW3vahCdxQWTncoi0ZBa7DE+e/QRLIPsH/eow P4JtOpNHV6JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLVt7wAKCRBLVU9HpY0U 6a7aB/9a81EmIo3z7HyaYE9kWA0DWCRW/eEmldo1PKGx3CcEZbhoesaemawa5NAIBE4zVzaeuPX bMVMYXEvaZnbD2XNqFDsXaUuVATmn533/BZGYO6XS2TGGFfSRFT24EXlJB3JKVOdbj8f4Cxnh+h h49p20eTTCiIERtz4erDXS0zppR4tz7stR7dP61Q2z0tutUk2VU6x9eb0nT0/nAAU4ImvoQ22sa 7hZwf/hbdnFpt/M2nfYdb1g2M8rYY/Brh5WwQUG2MXXz1A0uUvYYJXRIsZUatxlKNgvCkOkhWW0 q+RStb5mr8oj7aQDnAdktcMp13AaVp5qDb07ou26ALgkuIEz
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

Initialize local struct spi_mem_op at declaration to avoid having
garbage data from stack for members that were not explicitly
initialized afterwards. Zeroise the local struct after the first
use, so that we have it clean for the second use.

Fixes: d73ee7534cc5 ("mtd: spi-nor: core: perform a Soft Reset on shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 273258f7e77f..603791497523 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3235,11 +3235,9 @@ static int spi_nor_init(struct spi_nor *nor)
  */
 static void spi_nor_soft_reset(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = SPINOR_SRSTEN_OP;
 	int ret;
 
-	op = (struct spi_mem_op)SPINOR_SRSTEN_OP;
-
 	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
@@ -3248,6 +3246,7 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 		return;
 	}
 
+	memset(&op, 0, sizeof(op));
 	op = (struct spi_mem_op)SPINOR_SRST_OP;
 
 	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-- 
2.34.1

