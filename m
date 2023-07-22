Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7775DB12
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGVIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGVIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:41:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D094202
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so7924570a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015237; x=1690620037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkHM3RFGQ0WIr5v2TWHAHkTdJrhHVucyrUvsad9WfOo=;
        b=vRimpBOHp1L4wof8poOTIEpL8OUE8DOYT7U0dk3OIiI+euEJnyezDBX21g1cbp2Bg2
         VMIuHqxT7nFfa9vqrACBS55vEGN7wsvLeRVWQQeiayOJZcOyk2SMvSBa3HqDMB4C+LV1
         3kZZfkUrIkeDXV91UHlw60ILSW/Qcxawi5xT8yYZRdFQPx/Lc8UQG+UMeXhgGPxqawDw
         ZMw7ppBwctyGSUBIgEWS0EYTfFtkIo5uGqwZX079YubDF2vjiI2T6qd+8L4p7SbHWsk/
         E5IY4rL7WWn9Z2KwfvgxkJhpWdWBh6kZaPAElZsMI45emieBT74VyHilB9OVAQSHb8Ci
         hCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015237; x=1690620037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkHM3RFGQ0WIr5v2TWHAHkTdJrhHVucyrUvsad9WfOo=;
        b=BXnek4kdpfNjSD5mAecXK/nCaV0qWGSVGpWo66jLK5lHjNqHouMs5m8viTNx47XcB6
         oi3DHoAAAHzM3WCV/sx2D1jRaBD2pYDHVDW2vI1S4L+G+2uGGDe5Ej7xXZPokT5oFeur
         DnnIEfG57BnN+vflvn2RtqtNcsIksTWnbujgYiah4HcmgufgdhjeekhPx++fFjpO/dwu
         /3I/bMvsyrFBjx7bWJQe9AS0fkjMixEofbLhwDKk9zmvg7tP1QJOy4Gt6VsyfyrI1SE0
         AJuY/UnSQDmD/rMh7RPcTMbEaBzegAt3SS81uOVkNO6iSYsoNpFs4R5jWyl7msuSJjKa
         nOjg==
X-Gm-Message-State: ABy/qLbqqqDsSa5NHj3BPBJgiKZKoRgZcCb0zLObKV3OpjtTJF1sVnBM
        7rWIVmaaJZF2ZGmBoYcA1Z2t2g==
X-Google-Smtp-Source: APBJJlEk3C6yfEANJoJEFcZ7mnWGruo5N082AVMMno65jwWmpMMczKQ1IyWK6+BDMwK6pijWPlCiGA==
X-Received: by 2002:a17:907:270e:b0:993:e695:b585 with SMTP id w14-20020a170907270e00b00993e695b585mr4666497ejk.9.1690015237350;
        Sat, 22 Jul 2023 01:40:37 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:36 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 07/11] mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
Date:   Sat, 22 Jul 2023 11:40:02 +0300
Message-Id: <20230722084004.21857-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=tudor.ambarus@linaro.org; h=from:subject; bh=ARtE+Fv/l4a+BkMfBrTfq2ov79VZLg+i8bYbcphxQmM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XjbqmEDqHMfs1PJlBNahV34jcDlLvGaPX+Z cKEiovvOcyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV4wAKCRBLVU9HpY0U 6buHCACtlNOMz7joEkDiwxVMGe9W9J1dOVkmWSjupR0a0KXu3VB2a88w1PHj7FhDFiy9h5mhn88 RftVhay8xwYW0Ar9iZ+0Ztx9GBYpKwiHOOhyc/c7DfuNQHL8ZmjJl+rMg3+bbfQRiM2z+nNew5g czhkgamz7pjWWws3qP0gh4luGXZeFe8FITa7AA0Z/NmGHdu/zPo39PcKIaZKJPO8nTy/PHWrYv9 5VEKb1iVfesv9eoRZCNUcnnt1WdgQ8FTcczZNdEPLhHvWJYIGIQMc6bdB6UYLw9+jLnEJQiWKA+ GtNGC+WILZs1DITtddgu3it7f/jWbPL/sKWabczIDxm8DAZW
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

