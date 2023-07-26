Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF88762F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGZICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjGZIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB194C1C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703a0453fso95362631fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357992; x=1690962792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3InCljZqye4eFwsDTu+IODNCfq24t38Cj22eVGkKqxU=;
        b=SjCV/8xNSkyjqz5FS+Xw75QoV10ooDUJ1MU4dKZfKvJ8elu1NZ+8JLkUjZ1UE09dPW
         bhVr6aNQ4rUPXYC3R0S6qwidvA4On3ayyYu3ARZ61swT4EPMgxE7j+jshMJ7h21kU6sV
         XpsuvTsGptgeKeiCtZyvLTksp4dkMibMn1QyuRIH64if7+mfwvQ3Qpa2GYwk6ltN7oFK
         UXrOVBPgtLwC0ewYXDFv9BN3YI61WM3CdcFG12Tf+JmbODG5NUpsFQbCn3i2BHB/6p48
         w0HUb/uWeVgsLCWI14Q8aKNKM4flHeRj/S5eJt82vmoBhmjEN/NFmIvNsc2Rj2AvC19H
         So3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357992; x=1690962792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3InCljZqye4eFwsDTu+IODNCfq24t38Cj22eVGkKqxU=;
        b=Fm+MX85BIBD0WL/oTEjN03HlpXI9/yZ5QQVkESnyTWQ0O/JqDkxkf8wXoVudZWIzxQ
         y5OBnMZfvDkz7d3cS7AMMbne3WO8kvPZ+oOGbFpvuhlG5Az2J3PUfWn9aevWm19WqaYn
         AOrMEtjqZoxiOQ6++lafviz/P+CBNdyjIk7/xoTo3cVWuIqdpovRjeze8wAvXicjF/Cc
         8lEGtnMNvyiv8NVIpdLE/+m9ohaFDckxZ8OPIcjdgM3A5Vl1L0pcQIWMhRSGEIY7tJDV
         j3MyLvyvWfe0+faflv0VwoW7V0bgw2/TBikB+ZZ19iN6LX+BigXAHOkhicngIJhTNG/C
         yPZw==
X-Gm-Message-State: ABy/qLa2eOlTjo1dL685dl2gpYpjUg/mPGPTsCA8yx+hmcktQgL+XDBY
        d6orOd+XkJ56JTGnvBgjz7jWrg==
X-Google-Smtp-Source: APBJJlEBXqLQv3e010LqDbxJd0efexmnQKBKiXcJ4lUJnBWUHbvBTg9p6Tg94k/lVYJgGJeyc9Q9bA==
X-Received: by 2002:a2e:870d:0:b0:2b9:acad:b4b2 with SMTP id m13-20020a2e870d000000b002b9acadb4b2mr828072lji.6.1690357991856;
        Wed, 26 Jul 2023 00:53:11 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:11 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v4 06/11] mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
Date:   Wed, 26 Jul 2023 10:52:52 +0300
Message-Id: <20230726075257.12985-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=tudor.ambarus@linaro.org; h=from:subject; bh=doE8v18UAwCgNrGgR/vrxrYb2ko5JOoI6sQ8dWotQW4=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDY3mqSfchKqowpgyrLyI3ImYTReUH+R5oS1 Y/KJTj+vbGJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6QyfB/4uuxOaTt48p7ouhOQz71ZZ+86XFAaMCYdjr/yy1lCkCARo5ETZ9JZ0HbsUws1oCCZHr4Z GlQwhLqcDzWomLtFap317Njk3lJcTDVeREJsrGWfd0qajoSDhy67NX6PYbH+Bn43T+uOeWcRqku zrFsnnCnBVxYGQrQNOheDB/9SmWrrb6oGw8wuVKAW5dW9+ch9a1pdqADs7P/9Z58v417M+pDLRA +T5IB2oQjksf0J22I1sDE5L1YhcbDiuejBj426V/iljSonJd2pIv1qLK8pwaLsBgvTKxEGOF5pH eqDOSq3HYievyFVpU7XAejWrJhAovmJIfM8pEIt5ha3ifHJu
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

Infineon multi-chip package (MCP) devices require the Octal DTR
configuraion to be set on each die. We can access to configuration
registers in each die by using params->n_dice and params->vreg_offset[]
populated from SFDP. Add MCP support in set_octal_dtr().

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6d8dd800ba65..b3a710985f84 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -204,17 +204,19 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
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
@@ -249,14 +251,17 @@ static int cypress_nor_set_single_spi_bits(struct spi_nor *nor, u64 addr)
 
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

