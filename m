Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D575DB14
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGVIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGVIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:41:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D403A9E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:41:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so3613897a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015246; x=1690620046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvn9Ytvulvk1EXRz+zaqNbSkQ8OMJCRDUn6E/2+cB9o=;
        b=JvyIpUbRriH53rBnHb+D4GMGWApKPp7W2T+v9Gj4FL8LdjA7G4SEHovww6d5KUZYmF
         WayKaYuv0/v+7RF/LKrq6c6Ba+z5aRkAKrNUR5qcpNOJS1UAg42KzlMfL9jWoDqbnYIB
         xamHmfKyoTPL52HY0Dzozxy8mV9sj52yKEov0CcRFbjDtc20ROjMx/k2zdg2GV/4iSSJ
         o+Mu94KJkVsvSK8r+bNQmJdsKAU6gqZdiJfLfkeUnZPa/VEL4cIF6KOHTl8hSC5gVMb3
         OW78ne7O9qbNDOjE1BMquBdcqkfHoje83bxhCn5MLTxREVccqtcg+Mx2lZcCgPR4vJ5B
         eALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015246; x=1690620046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvn9Ytvulvk1EXRz+zaqNbSkQ8OMJCRDUn6E/2+cB9o=;
        b=VRkkDG5XlyB5HzWgGnS60EY3N7Yt2NZd3crIn0ol3Sq8gNboomADuxvnGQ2q+CyHgn
         mSvPr+LWAHZWFzEB3mu7BK0IZzyyin97kaNRki2dwtw1b5px3Hf03jIr4XhHA5Gcy0dZ
         rwuwgMi42OXwMU3kVHvxlnCf0glhAt1/HR7Vae7nOBxZo8lEsKsv9o3L5Zr6qIDrf6qg
         nAqX1ViNoFf0hUigBWd21pXxhLNKG0U/aLoSbz40eHnjw6VoZ+3Syl1hfT+AYVs3XaVB
         olmPq6UZqAzuTPgkbvW4Hxfx2/4Qrbst+GIcsh/reDhXmjBkX/abKv2NWxoVHmTsEfMx
         cGLA==
X-Gm-Message-State: ABy/qLYHliX3x43LTyRkgN4wwSqT/dRH8AzAfif34yi8UV4d7GOOeAb/
        PEop9ixt4O7gkdb08nbem9dwTQ==
X-Google-Smtp-Source: APBJJlGl6EjDbkneYdKpnDzWuAw5K6TChqXcbOojaV58BqH8fHLCg8p8f+yt1ZNxyqieV/MeIpkc9w==
X-Received: by 2002:a17:906:106:b0:967:21:5887 with SMTP id 6-20020a170906010600b0096700215887mr4274950eje.40.1690015246644;
        Sat, 22 Jul 2023 01:40:46 -0700 (PDT)
Received: from 1.. ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm3253861ejb.84.2023.07.22.01.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:40:44 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 09/11] mtd: spi-nor: spansion: let SFDP determine the flash and sector size
Date:   Sat, 22 Jul 2023 11:40:04 +0300
Message-Id: <20230722084004.21857-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722084004.21857-1-tudor.ambarus@linaro.org>
References: <20230722084004.21857-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=tudor.ambarus@linaro.org; h=from:subject; bh=pCpO/9Mvf8zp3/Qd2t0AYPeMg7+RmKPsnX2goFSGCbY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBku5XkeWNAnfU88wBv7B1V3EOb+sqK02NWWJWNR Vt28fFlzHOJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLuV5AAKCRBLVU9HpY0U 6fE7CACuHWnWOHXIyNeAknfgmnFAmppW2v9PJmHQOq4s4RaEvFhpT2Ou1oz1BrPmzPKg9FeriFA zPLaIqRMZ+4G0p3F4grvhenVKCHemrvnM73xQBW/L5iaLBx7dlYU4WuHQKEbQJxxnt6lWaMjllq IS75fAv+sijTrGQjRVmQHczQSH03JZq5AqmGdtfAEGtrUcNzvOsZgITC8J8e7xxpnn31xnFMJrN p5XzifBJOvsIS1aQQNqNJivIFlBywEgTTIXzffqkBmrybmF4bzhUW1WaJZMZpgYiKVk6nPtivnk Y2hQEYdcV3gMI4a8hkt6LP22oyyF/MjdyGQk+kly/pozAlcn
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

