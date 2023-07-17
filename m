Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862D75694E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGQQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGQQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:36:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA4E7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso43479335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689611768; x=1692203768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BHlMzcHYoIQ/5F2lC99n1rk5D4NCewvebB3dqx2z9A=;
        b=A/W5XRDhCLcF15wQAwDxezJ+NNw+om7iiYhAd64k/dGNhSkEKU2NRPeiPeIpWH1+C4
         RgFCIZf0ICfWgH+H22jw0zzAU5r7OV3MCQWh+hSQzV4foAfybe6Vx5g2BO2iWQgHZ+w1
         QbWCVX9qXxfbCMecyyij6V36Ym+3HIqZ6Z9QULePNMc4ka2o9aoXukLMjaXXlvVgCvxD
         M/ztYFdQV+pZMCydcuLHuYmT0IyYantJEd6Wmn0YReQpfG8ZzGGKrPIRDn1lhom4mpxU
         xwHtKEBYDkea2rnTjAZ644g4vAAqGaW0ICM4kOJLQUqSgeAvqmtEOQMwwfsRc0JEjjWY
         /xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611768; x=1692203768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BHlMzcHYoIQ/5F2lC99n1rk5D4NCewvebB3dqx2z9A=;
        b=JqdeLewKkM8RRNq0M1T7+Irel5opesyJ0Ng5GBsXJaXcikyELSYutF0lN1B/7O9B0X
         dyawV6yGDYRBjnEiCZodMX4QAhEyiCr705r15QNCwXcV01/PN4Ip5mK5X0lj2m/snZi9
         oKBtOXn/FYD9U/ACTjYjB4V4Z8ezw2dOXHifOXNiv7fpRTF3zvIVqcx4PbPog7WMgufc
         IeeHm4wJYFuWwM7KYbE8s1onP8d6q/g3AVKXf6dgKuFUcZGkSTa/zOO021swPKdfE33u
         ffK+XY000tgLNFPWwat0BHOorDlTN5hTYc+ZLKyfvsBhdmAvKihLCDN5sINkhXKn17z8
         58NQ==
X-Gm-Message-State: ABy/qLYgSMVImi55nLVKb4naGg5ROmBUUXX7KsVvGezG4h3okOYejRrQ
        yukRvih2onkTh7PyWAVjd/YZyg==
X-Google-Smtp-Source: APBJJlE8De/7VCFQjN/m+Z6kzJXg7MDef5Bg0VJQgMK60QU9AMr+lhTdH3I9BQOr+2oO/tTFBfa/lA==
X-Received: by 2002:a05:600c:247:b0:3fb:b6fa:9871 with SMTP id 7-20020a05600c024700b003fbb6fa9871mr9299500wmj.14.1689611767777;
        Mon, 17 Jul 2023 09:36:07 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fb40f5f553sm8401774wmi.31.2023.07.17.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:36:07 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, ichard@nod.at,
        Takahiro.Kuwano@infineon.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 4/4] mtd: spi-nor: spansion: make sure op does not contain garbage (2)
Date:   Mon, 17 Jul 2023 19:36:00 +0300
Message-Id: <20230717163600.29087-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717163600.29087-1-tudor.ambarus@linaro.org>
References: <20230717163600.29087-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=tudor.ambarus@linaro.org; h=from:subject; bh=MA05hwZg2zr6d+O9X5q1HLg6NFLm0xJVJqTNBEWaguo=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBktW3wRTw4YeCaxFZJEwY09jToFFH2GI3KkwVoZ un8raZaMTyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLVt8AAKCRBLVU9HpY0U 6V5ACADCTsIJ6xwp2xykxCJ4F4a1wBs4RbXl5Dw4ChKIOmWeFsuQxGp+9TopB8e5pBLk5swhaTU KY+obbOAy8ujF5CypB0k9CxxTyGBxaMiSwySSEQZacAWcQviBXILqdJr2GJfNNqwXz7rF/0Q6op szH8UmQZ2UwDRiaVNNdQ81aIqhwT/8Ps/+bO4iRA9f12lXZDA2cikUrG9Yy89EjaoYJwIjplRYd grSzjoxXLO997T/t1fEa7+VA5YbR1pWqeCdd/OTu8mr8La8m35LY500cJ/94MyLNKdIC3OHtFcJ tQK+5AqFBsYOlyrnKWJHo8Dqy3TxY7XixYy8ASrstS7nmxJf
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

Initialise local struct spi_mem_op with all zeros at declaration,
or by memset before the second use, in order to avoid using garbage
data for fields that are not explicitly set afterwards.

Fixes: b6b23833fc42 ("mtd: spi-nor: spansion: Add s25hl-t/s25hs-t IDs and fixups")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index c03445e46d56..7485b708158f 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -220,7 +220,7 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 
 static int cypress_nor_quad_enable_volatile_reg(struct spi_nor *nor, u64 addr)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 	u8 cfr1v_written;
 	int ret;
@@ -237,6 +237,7 @@ static int cypress_nor_quad_enable_volatile_reg(struct spi_nor *nor, u64 addr)
 		return 0;
 
 	/* Update the Quad Enable bit. */
+	memset(&op, 0, sizeof(op));
 	nor->bouncebuf[0] |= SPINOR_REG_CYPRESS_CFR1_QUAD_EN;
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes, addr, 1,
@@ -248,6 +249,7 @@ static int cypress_nor_quad_enable_volatile_reg(struct spi_nor *nor, u64 addr)
 	cfr1v_written = nor->bouncebuf[0];
 
 	/* Read back and check it. */
+	memset(&op, 0, sizeof(op));
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes, addr, 0,
 					  nor->bouncebuf);
-- 
2.34.1

