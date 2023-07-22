Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9C75D9E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGVE7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGVE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:59:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070711BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 21:59:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so3624537a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 21:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690001986; x=1690606786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPPZJ6eh59MfiIUBA8Mfsk7fKsGGjDRF4wsTV+SRVQc=;
        b=uSB1iES7m/scCF5hmNjX2Rs5Sr1hJnPulXIDgDliHq1OqlQxlnpKdr7fntCHbEZSyu
         0zxmYjJgtaI6KpFiZ0I2ZXwRtV3ewfk8p3/yOlA7C0QKzXV5U8SdY5RQ6xVgU5vegJbD
         yT8c14H+sTqg6m6rLkmsoTeBddMynSMxPW3r7XFcx8liuu5yJxVzLh6DdIbWpj/sggeW
         zWMUx11abf7XWeya3bndXosewik2StrFP846RhI3h2hXNOAA0Oq+nVlKCOWCX9OUzJQ9
         jZE+M9A8zhMfNwsWtTYWTfvoKnQCheFOXhdgq5w6NGHAA2/l1zxfbeEO04YYpe8RaDUK
         XMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690001986; x=1690606786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPPZJ6eh59MfiIUBA8Mfsk7fKsGGjDRF4wsTV+SRVQc=;
        b=R0CL3gufLrjoIpu8yZNqIo1vBkQfd5pwNdz9WbX53fGmXsxFyh5QrtAlQxWyA3O6Dd
         kPbLoXXJ9WuAxoBY1WdaQ4cGk6sfN6OGBK+k98H6tNq2NENDavJfE3105xnLWyATVK3U
         nc2iMgMt1h3CiCe5E08q5SHWGflyaEviytr6N4R/2pfgouxG9fJZPu8IAROxplJx+CtW
         MsLLYBOw2xWQIur6ATLICjMHeEPGapCG3VH8fkHVJm1O6HkJ5nVh9uSDeWrIC804/nb7
         Cj8ddxDwa4mK5V0nMmngcdouVTtJgTMbKVVnVXnzeiiLAuX1ChrQI2AjnMcjeu7F3N9x
         1vxg==
X-Gm-Message-State: ABy/qLZcUaWKktN5iugFXZjmfwGCdbdzV5w8IANJorP1ITlCfrsVuBsd
        aU+JdynM5aUFNt3Gajb5d9WjMQ==
X-Google-Smtp-Source: APBJJlGSmwWCv19wKWY7+rUTWGLB8hqxBZd+bl/5PamQUQPbNzTouOAc0RH8zpEzJopVRkSoNGvbVg==
X-Received: by 2002:a17:906:5a4f:b0:994:569b:61b4 with SMTP id my15-20020a1709065a4f00b00994569b61b4mr3367092ejc.28.1690001986336;
        Fri, 21 Jul 2023 21:59:46 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906c41400b00993928e4d1bsm2969834ejz.24.2023.07.21.21.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 21:59:10 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc, pratyush@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: let SFDP determine the flash and sector size
Date:   Sat, 22 Jul 2023 07:59:01 +0300
Message-Id: <20230722045901.9872-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=tudor.ambarus@linaro.org; h=from:subject; bh=s09x/ZFTcPaBJaM7nguyytIOWp4AAa76VraRBrhiDGU=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku2IVn1Wn3GArG5rp0WYzGxoMlZxyXiPN6QukI 1vsF3uHXqiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLtiFQAKCRBLVU9HpY0U 6QvRB/4vUD3tnpebh3iQ86MCnarZJscI1rQWWi3o1PeCBrvqIb11mEeHDJ8JokjQG0DweEGY1ZO sZsDc9oY4LDw9v9ho2WR8AN2wwUmitLSUPmIQeugP/e7yLhNaVvHvATaVkSmM3NjrgF86ftaflX tgLLNUGJ9RVf72gHwEkfiKens1alkXjJxlBoTLHHba/7GgengbvINl+C7UuZDlnwSCTHLWDo/01 uNwiVhoUc6ak6uwIMvGxB6YmLdZKDyRhrQfjcjV+o1xCuNDtGI8R/NdYGVyH7yjjAYcpKgLioNK guDgx7DpibvsW3+K0nJ55HCm8H9s9gGD+K+YDPbdY4MZjalU
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

sector_size is used to determine the flash size and the erase size in
case of uniform erase. n_sectors is used to determine the flash_size.
But the flash size and the erase sizes are determined when parsing SFDP,
let SFDP determine them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6b199112a533..5f2a76969c76 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -878,11 +878,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25fs256t_fixups },
-	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 256 * 1024, 256)
+	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 256 * 1024, 512)
+	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
@@ -891,11 +891,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 256 * 1024, 256)
+	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 256 * 1024, 512)
+	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
@@ -906,22 +906,22 @@ static const struct flash_info spansion_nor_parts[] = {
 		.fixups = &s25hx_t_fixups },
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
-	{ "s28hl512t",   INFO(0x345a1a,      0, 256 * 1024, 256)
+	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hl01gt",   INFO(0x345a1b,      0, 256 * 1024, 512)
+	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
+	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hs01gt",   INFO(0x345b1b,      0, 256 * 1024, 512)
+	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
-- 
2.34.1

