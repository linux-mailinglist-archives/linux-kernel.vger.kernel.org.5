Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5694975ED2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGXIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGXIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:14:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1D10E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98df3dea907so641009766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186402; x=1690791202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1B2NCe5HAwiQi6+47CtZiZu+Vu5z0uOnlROiU8PNpA=;
        b=QY7rh/pAquoo378N4CyA6AZKj1v++zcN/3Ww5oKLwMS3+S8dU4IF0lj7RjaS2CAEGY
         Isr3wXYFsc2lc8QS2yD1D2FJqI7UWjW1EGh2Uz37QduASB1I2QFVv6nvGDEPHZDpgWEJ
         caiwYhTdWpH8yTEsQgO33RIiWs8ZZECP+CSrEhw5ml0u8wqwCmgxN5dYzbScDuQ6vFuI
         qE4OlLll9IbgR9gIMy/vEiJaDjST4+OBEn+2LyWHetaIgG0cWPg2ZGKZ4/pXN05UroPC
         Vu+QMggpzaQegiisHi/LhJUGDM4gu/zQ2SV73D6bgaIYcPi23lRNAbpIl4vJStFs6izi
         7gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186402; x=1690791202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1B2NCe5HAwiQi6+47CtZiZu+Vu5z0uOnlROiU8PNpA=;
        b=Cw/nXzxE8LUhy7MTip8PrCTnfJJM1tymqFo3W5pVWYygu/ewY5T37MTF9QJuwW8xFt
         CoNyKc86r2B1Wjq69NxQLSO4O7JoKNvqahN8QlPpPhaSaUywVcjKRvm+e+s2eltHNuak
         gEXT8Lzti4kjt+zsbJYIgHJXnQSi8qATT0EjWcuZSL+VAb+gGnfZI/59kbnKwcySuPF9
         SzwwFCnuGbpi+8acy/8ClDjSP11bQn3JQfg2ijpn8GQa7mr4l3daSU+qFTqwFZ302fQn
         HO9T8hec/oVkrT5AHkEezgTkgt0P0dsMqUna8kM4SBcQ1Gh3H9EHxtUfZuZgUKzKkt3s
         QD7g==
X-Gm-Message-State: ABy/qLYammdRcyzixtlYJSKgE6Uup9bFOrWKP1RqbDXNpT9anAjIV/8F
        C25WZ2wbJHNznkUWDi06jS1yXA==
X-Google-Smtp-Source: APBJJlEaKG5Dt3U+fEqgqoE/BxTER41uI27lLaRY7hkr8e7uknLgy0tvjNvR5pFAKRwACqZEycM3Xg==
X-Received: by 2002:a17:906:5393:b0:99b:4956:e4df with SMTP id g19-20020a170906539300b0099b4956e4dfmr8859714ejo.11.1690186401974;
        Mon, 24 Jul 2023 01:13:21 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:19 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v3 10/11] mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for quad_enable()
Date:   Mon, 24 Jul 2023 11:12:46 +0300
Message-Id: <20230724081247.4779-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=tudor.ambarus@linaro.org; h=from:subject; bh=m09E4D2SbSB/QXfTnPlKEg92z13fHEFqiJ3l0puhOlE=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ/rJZTBzC/giI8SYKUWTg+y0y5OCBsOq+TO AFXiVivf7SJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfwAKCRBLVU9HpY0U 6Y8XCACdkKLonzkXNLmbOIc30Xy4RMFAPgZZN2E71+WJcm6QkDzPko/G6Itava2mbzFlxNn2mCS jaOK4RXgSkuGI7jLfPHBzGyfYf0GJEtpvIjobh+3jbFtKK2+YzzhDb8c4lfOW3nWl6kAQh9i8Ng OU+9x/jecpEDS4wOZH+4vYrgEfb0bVSFqr5OBf2crbsYi+CC4mJZijeym7Pxc0cUkiho3fCJzjh oZVjQU3rlbe7bczuwe6LJg7dOwjoq2/O6AGCT4y2jje/TM4zAB5gvlDXK5phT14S3iyuNANp1dX sSYnWD/CE8b6UJNyfnashTsrOal7yU/Xd9jkRcgwh54rnV75
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

All s25hx_t flashes have single or multi chip flavors and already use
n_dice and vreg_offset in cypress_nor_sr_ready_and_clear. Switch s25hx_t
to always use vreg_offset for the quad_enable() method, so that we use
the same code base for both single and multi chip package flashes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 413573cdb4fc..4027f0038ce5 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -350,10 +350,6 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	u8 i;
 	int ret;
 
-	if (!params->n_dice)
-		return cypress_nor_quad_enable_volatile_reg(nor,
-						SPINOR_REG_CYPRESS_CFR1V);
-
 	for (i = 0; i < params->n_dice; i++) {
 		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR1;
 		ret = cypress_nor_quad_enable_volatile_reg(nor, addr);
@@ -659,15 +655,17 @@ static int s25hx_t_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
+	if (!params->n_dice || !params->vreg_offset) {
+		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
 	/* Fast Read 4B requires mode cycles */
 	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
-
+	params->ready = cypress_nor_sr_ready_and_clear;
 	cypress_nor_ecc_init(nor);
 
-	/* Replace ready() with multi die version */
-	if (params->n_dice)
-		params->ready = cypress_nor_sr_ready_and_clear;
-
 	return 0;
 }
 
-- 
2.34.1

