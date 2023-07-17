Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D625475694B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGQQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjGQQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:36:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965110C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso43486285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689611765; x=1692203765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX7yNzoekDNDbN0fPtnQMsaJD27BOR7rmE5NRifPB7Q=;
        b=IND8N0L+fr1Uc16sxI3Z74rnAsa6vA+B5Liol8qBgMc1+TRJwZTOnr+ccwlTc8bh1y
         KLwPZin+wq79ZUg03rlNnfT7kwDvm2gaJBOqTC6BMy84w4SyGBMcTNW2a06hGWi+8Pkv
         gr82EUnXj8PBuORxS6Wd8ROv+5qO2tblAUzGmKJg6Lq9IcbUiens009MPFncOP7j/dSq
         pWANDBAcrJADOIfvYOedxt66E2ZXBqEdD8A7iYrzinzZuSfW+EQdewRZPTOJ5sJWX6RZ
         gl0wYGHmuepN+ijRX52fa1eM7fnFUzsNtfgv9qwONzpUvbSVji0KDBbuFuaS7zffaBGY
         fZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611765; x=1692203765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX7yNzoekDNDbN0fPtnQMsaJD27BOR7rmE5NRifPB7Q=;
        b=NH1Q8YZvKbXvDdO7NcYBp+SutFoh6XUQheOg2WpDOvbgKULuHzvshFdVGkcmTnn/Ek
         p6xppiSzbbyKS3qogcJ5WSJSF3O29jsQCqXfZ8faKSyIsNwMsbeAJHyik6NLU0Qe6Z9Y
         OY3xGWGF+YZvCmQrTE4d58tU3tfRwmNBNbW/6+hQCX7gXRFlG3etz6AAZbY4FOzvxYfj
         G4IGdqqm7iaHLPJCnJgpEV1OgMUa14MvbnlV/HqYdTv3NrexVJ4KzcPoqnAvhv1UgVwY
         ILWR/dTJeMk7NmPDGSTg+Pwssi3zKG6LhQfGUC4BSqO/nPkDphkzkApDS/JV2DU01z6z
         A58g==
X-Gm-Message-State: ABy/qLZ1/LQpmbc2nLksZiQRIEsPaxt4LY2w2epPpBKUUnIjv/dFhmoB
        361vl24WT+U8flLooBj3m8I0pA==
X-Google-Smtp-Source: APBJJlFe3nHBHHz3eZdTxjP3C3AMs95Vkm8fdGGbxfxNNWXpZnEQmXfqK9SvAkayxV63JlDfgmw1lQ==
X-Received: by 2002:a05:600c:2814:b0:3fc:1fb:79d3 with SMTP id m20-20020a05600c281400b003fc01fb79d3mr9572731wmb.15.1689611765395;
        Mon, 17 Jul 2023 09:36:05 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fb40f5f553sm8401774wmi.31.2023.07.17.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:36:05 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, ichard@nod.at,
        Takahiro.Kuwano@infineon.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] mtd: spi-nor: micron-st: make op does not contain garbage
Date:   Mon, 17 Jul 2023 19:35:58 +0300
Message-Id: <20230717163600.29087-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717163600.29087-1-tudor.ambarus@linaro.org>
References: <20230717163600.29087-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=tudor.ambarus@linaro.org; h=from:subject; bh=cc3WX61OcneA4MU73qFbNg5cW6QHECtpXG9atTmOcLU=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBktW3wEEw9DE81vexn1H1EkBZM0tvslE7PtjiOU hbBgcsMyliJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLVt8AAKCRBLVU9HpY0U 6XjeB/sG/azfGxCjojb1+N7IjYFym26tF4HdiNtjYzRNM8h/648p41pxigBzob1sA5DpU9adYoA b0E9n4iEpWuCeWd4eQCRXXvex09n1DrVCYEDRZQOwnbNb7Prkpi8Pj8WU8aPfABN4LGWQQHzM8s 0XUQgbdgiwalrS+Xius/U2fijDUJ7AVuicR/5PSAW3zF6k8yKX1czXJN7LRVZh9KJ0vSXETGEZ+ WfLfd0vrzLf67cpBfXAAPK0oAGjI61ArtqTilZc0hLV8pt7m68wIRauLIcJkuvGkW3DHSEWmIqt HkhOn99/TPVJ3jE8QzaQJrSzK4099zQGnmPpi8vz74POXD4O
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise local struct spi_mem_op with all zeros at declaration,
or by memset before the second use, in order to avoid using garbage
data for fields that are not explicitly set afterwards.

Fixes: ad624dfd7bb6 ("mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/micron-st.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f79e71d99124..8390ed6a47b6 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -49,7 +49,7 @@
 
 static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 *buf = nor->bouncebuf;
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
@@ -64,6 +64,7 @@ static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 		return ret;
 
 	buf[0] = SPINOR_MT_OCT_DTR;
+	memset(&op, 0, sizeof(op));
 	op = (struct spi_mem_op)
 		MICRON_ST_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					    SPINOR_REG_MT_CFR0V, 1, buf);
@@ -86,7 +87,7 @@ static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
 
 static int micron_st_nor_octal_dtr_dis(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 *buf = nor->bouncebuf;
 	int ret;
 
-- 
2.34.1

