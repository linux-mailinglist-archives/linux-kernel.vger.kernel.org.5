Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E375ED2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGXION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGXINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:13:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E3E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98de21518fbso698600766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186397; x=1690791197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvn9Ytvulvk1EXRz+zaqNbSkQ8OMJCRDUn6E/2+cB9o=;
        b=tV+QpqasoevnXMwEWXs3J6oR6XwrLiFCZZUpCf37Act6PRhdldtR3xB1mvxG3yUo36
         6ZzWaOXPxHWUkQhRjvLfKg5bQxoj1cEI0DkS0WoTw6c9CeDVz+3JsULY2iP3pt031EDq
         VT5STqpGNF3ik586JBJNeD0psTuWWVaA94cLOPZ7u0KVIjAihueT8HMuZUGHE0ltAvP9
         Mzo+ELsnPSM7Hztq8GFNJmbTj0qNb5nmAJEC4h2KqA/Fb29NaKLPKF8hImenn/BP5+Sv
         5KIO/CmhXUiWeY4CCXGSuSdtLW3OzshDmtf8OxA2JIJiUNrKGQ6Dj0By0TxbmXxdMvil
         8I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186397; x=1690791197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvn9Ytvulvk1EXRz+zaqNbSkQ8OMJCRDUn6E/2+cB9o=;
        b=PqklwEdbIttYSSzHa77ola8bBUabn8TLfp6xOVMDi8IbC8vsedzVhI5CmPW5fth7Pw
         u1hJLG6lMayRGS9oiu+2/yz4eEMutRDfB+4wwBnrOzu5TCDYV3n1/g6G4y+OTRK+tAij
         XIb7BuUScS9OJ6oqWp01a5cxMiestXYU3qr13Xun16KjNwXuKWc1ZpAm6QZVc9q5S7Il
         25lcjCVeGbEel8eulr6c6ty9JkoU9HQRi398f9sXClw3cCELghLv4zFWg5JDRknWskp3
         KqAKQpxK/GWp8/pTlEBMO0ERvfjUxiP/ONYpRQ+pHXZghbNDllj+qo8DuqxQB0SHZTy4
         occg==
X-Gm-Message-State: ABy/qLZ2n3RzYYDrQq49gfPZ00zSX1VtUVOeORS6SMQuztWjlcSYhOhq
        j4dhyh8uO7hIQGXHG0tACj/xUg==
X-Google-Smtp-Source: APBJJlEezsECpGZwPWX72NBkdrzZ1Q0LndDTGl9NGNm9L8lP1tvSxGyJHOB5WF+b5Q0Ee4CZazYP/g==
X-Received: by 2002:a17:906:18c:b0:98d:e696:de4f with SMTP id 12-20020a170906018c00b0098de696de4fmr10641335ejb.26.1690186397359;
        Mon, 24 Jul 2023 01:13:17 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709065f8600b0098ec690e6d7sm6355395eju.73.2023.07.24.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:13:16 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v3 09/11] mtd: spi-nor: spansion: let SFDP determine the flash and sector size
Date:   Mon, 24 Jul 2023 11:12:45 +0300
Message-Id: <20230724081247.4779-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=tudor.ambarus@linaro.org; h=from:subject; bh=pCpO/9Mvf8zp3/Qd2t0AYPeMg7+RmKPsnX2goFSGCbY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkvjJ+eWNAnfU88wBv7B1V3EOb+sqK02NWWJWNR Vt28fFlzHOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZL4yfgAKCRBLVU9HpY0U 6VS0CACVIspLQT7Pfz+tb0BedC8TvEfvu5UqqCJxPkdVQQ1hs4TLyHj/+48cTmZgRS/qWXF2VDa NEpcR8hEZ4s6/a9allG6epnM+1zitmkB9O3DNZ+u1HvK5d1xGlYw5ahwQ+75Fd789+NVIchhexD Xtnvtft12qJ1r3Yx9DIg55fqI5WKDsbxuIEZHLIMnpr6kfW6tgdO0lN9iD6LJ1kqROVxahwy8bb MREsBmYkeOxGZSdXwHAXvaBhgsIdYMrWtXjfyREyFZWdGf/JxZOPP+B4aEDeft1sIMjyMzh+S9q 0i/McXURNzlBxhjhkict7cxCcYIM8Ci9hsLLNDR8wYC6vA7t
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

sector_size is used to determine the flash size and the erase size in
case of uniform erase. n_sectors is used to determine the flash_size.
But the flash size and the erase sizes are determined when parsing SFDP,
let SFDP determine them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 1f2b4a469719..413573cdb4fc 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -875,11 +875,11 @@ static const struct flash_info spansion_nor_parts[] = {
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
@@ -888,11 +888,11 @@ static const struct flash_info spansion_nor_parts[] = {
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
@@ -903,22 +903,22 @@ static const struct flash_info spansion_nor_parts[] = {
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

