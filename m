Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3260575694C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGQQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGQQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:36:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B11E60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5048428f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689611766; x=1692203766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxRhR0r73fCyJSfEpEtXqPaclv2CSQ/el9ad+l8akUs=;
        b=l9WcVXC6HdDMB4tx7zgtYXUMLlfQ0AQz3HHM6OjZE+NsImHmb0d3d3VezU1cEsm4A1
         ekmg6zBOuebenN+D5v7eZY76SanuwfIgCo/ckGXwRa1DkwODMC9hbNZnMM8E4KY7VsE3
         qtI8uhCjsWu9LiVgGYGqiXn2bG7EFBL73AA8R9bNt7Vcb9pOw+yTFnTb8LRyUObYEwqG
         h64elD2L0/C4tMWsopAENzzADUvT8JD8PjS5elXL0OjHAOGGdNiBsw3BrCj/YXKMGpEP
         XKZg3qzVGwyuGWhXMFIuTjLMSyxuOPQyJXhlFDXcBp515tENzQ3DCOCH7oImFBhYpoJm
         jNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611766; x=1692203766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxRhR0r73fCyJSfEpEtXqPaclv2CSQ/el9ad+l8akUs=;
        b=VBIx+iEa6rlSTzVfgaOkSTZyPnxrKhc1Z3yb/ckPL0Y2/g+gTZp2FziAPPKPZLDS5J
         wiU/2I2khmIB5uSPvRxaMSRl1PzdA7AQrarBEc9aCLvUdG46s3FhA6s48uWhaOwsEEhf
         VZLm6vgQAmYoalRYiuyAygSHhVVzroSM364gT1xzk0dOhhwktojcuq4xro8IdTywRmsP
         shFk2UABVfaMFg1/lNXLDRTCQAVA3uOJYvbZySedBAF2Cit7LX9hGVda3S6ORPs7zy63
         TNgwDGwUWQAKftDaRlLZ13bBwfHEfi/LpusGieTniTghTU24MOZr8Rdu6kecvbOmwgc0
         lvzA==
X-Gm-Message-State: ABy/qLYcQUzJhO0Iy5JQUZzmUcl2EC+/P6q7HI6wb61nnBbb/UffOpXX
        de0XTP0qCDp2c01Ik5FduhQ2aANp2PR1BKWjais=
X-Google-Smtp-Source: APBJJlFDDluHEyFjvvRLMvIDD+mFo545IE15sH1uF1huHfdDMOWSDiwOqi1dlJi7WOh0HamPx8XPXw==
X-Received: by 2002:adf:ce09:0:b0:313:eadf:b82d with SMTP id p9-20020adfce09000000b00313eadfb82dmr10414459wrn.69.1689611766638;
        Mon, 17 Jul 2023 09:36:06 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fb40f5f553sm8401774wmi.31.2023.07.17.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:36:06 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, ichard@nod.at,
        Takahiro.Kuwano@infineon.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/4] mtd: spi-nor: spansion: make sure op does not contain garbage
Date:   Mon, 17 Jul 2023 19:35:59 +0300
Message-Id: <20230717163600.29087-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717163600.29087-1-tudor.ambarus@linaro.org>
References: <20230717163600.29087-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=tudor.ambarus@linaro.org; h=from:subject; bh=jK7G8/dGKpNjblyZNdcgsS29H7EUdtJKmDLXkFoMUK8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBktW3wRZnBIKX7MJLwCSTRLiWTIyz0hXlIKgZMI bMr/T+s2NCJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLVt8AAKCRBLVU9HpY0U 6bOqCACEhwiC1WelN0j1rCBwwmj6+cDXlWqgkMVMJAREFfkkAbllBqLEGEp495t/1wQnZNIffkb fv/fPXIjmSA+ekXchngSY0acafr4PMLytM0I+BSw0R7ynDT8r1OHiHQT66PptTl7iWoL7NyRQjf RxOdEExkfVuW2rC9TfULIiArJ0p8Y70fJ3yzLCuOkwRKYrcA9ItIuphooo3ia2ez1HAzRC1jJJi 0FpywB95NapP8ccOaium4t/2FPzaaVCth5hFrGtC4Ur1JFR9Vc9tv4JtPhI+X2HtFphpJUGb4/D m3u8O/ukd+EbTfKj5BmMaT2NUPggzGLer6xAiu12syD8qX2U
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

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6d6466a3436e..c03445e46d56 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -143,7 +143,7 @@ static int cypress_nor_sr_ready_and_clear(struct spi_nor *nor)
 
 static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 *buf = nor->bouncebuf;
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
@@ -161,6 +161,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	nor->read_dummy = 24;
 
 	/* Set the octal and DTR enable bits. */
+	memset(&op, 0, sizeof(op));
 	buf[0] = SPINOR_REG_CYPRESS_CFR5_OCT_DTR_EN;
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
@@ -186,7 +187,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 
 static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 {
-	struct spi_mem_op op;
+	struct spi_mem_op op = {};
 	u8 *buf = nor->bouncebuf;
 	int ret;
 
-- 
2.34.1

