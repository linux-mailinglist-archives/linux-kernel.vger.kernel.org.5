Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662E75466D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGODG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGODGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:06:55 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE7635BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:06:55 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b060bce5b0so2120305fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689390414; x=1691982414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiEZGhN6TrZC53w+Bjj2YsWSjxJIYjTrnjd2cGv218A=;
        b=IKRHTI1VZkyq4NQtZPoxJDP33KZw5sT3QWK64drGIeSgxWpkSYYalJxaPlftZ1RIKK
         yWsYwtrySrM76mPNh99qvV5g2Y40VqmNrASMVNqrwKxRJPIeB/b3IpeuX9eJdTt+CBRZ
         hGuq9XDItWIHluj74nNTAZpHShSgfjHyY3ok6QGjOsHoqjBi87Vqa6q6q/FTIe3IspOI
         WuKvXOO/XD0xHCTmUDrFYNbT1ay+Q9LWpkxjgM3wd4q+55XqV3IwLRG/QipCfbbkOXB9
         Y24IXIcq9r0NdUPI15ZnHCf1j4NJPVLk16Snc0QElUAsEvjD0V4e0B6fhZeCuqGdjsI6
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689390414; x=1691982414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiEZGhN6TrZC53w+Bjj2YsWSjxJIYjTrnjd2cGv218A=;
        b=lvD2P0zG7pqwOqgau1xTSFLh+zUnY/dhqi7x9xKxZgzutqvzjoaMpcmmt6bu7249yk
         FVS7e4ILY1jr7YZ5f/g2XEMrB6/DzABfyxRZJtmCb49JN9Ugl7WD62wtgZWkCSfwwBc4
         CLo7LAv5OxfnW432dUeMBNy0gKyWTwM9j3E95j+NOO+RYzPTfsaHR4D2sSXh/DODqWSd
         4EiVojpve1fffQg2suooKB7ZBFEJO+b533tTnqddtuUrMk4APlrKBmUAVjn0KFjwTTdb
         dj0VmC5mAnbf/73GFKunFUJg/Xa/+nLS5B5mH83LiORV1vzBZAjCuRTpuIIl5uilxLl8
         bRuQ==
X-Gm-Message-State: ABy/qLanmva3Wvj2bz9VWv/UCO8U/5gNQXXvSZKHdx4kPhCzgLFMVH/2
        yf2B2dropKEHumcNOppLGUw=
X-Google-Smtp-Source: APBJJlHlqwq1t1zwhyEi9UARYJgLaxj8bVf5gVTsKQxPnvZLnTF0y1H4M5tkJgcbZ+v7+YIw+lAFng==
X-Received: by 2002:a05:6870:f697:b0:1b3:dc5b:13c7 with SMTP id el23-20020a056870f69700b001b3dc5b13c7mr7717927oab.43.1689390414192;
        Fri, 14 Jul 2023 20:06:54 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b001b80971609esm8425483plg.152.2023.07.14.20.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 20:06:53 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     codrin.ciubotariu@microchip.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH] ASoC: atmel: Fix the 8K sample parameter in I2SC master
Date:   Sat, 15 Jul 2023 11:06:20 +0800
Message-Id: <20230715030620.62328-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8K sample parameter of 12.288Mhz main system bus clock doesn't work
because the I2SC_MR.IMCKDIV must not be 0 according to the sama5d2
series datasheet(I2SC Mode Register of Register Summary).

So use the 6.144Mhz instead of 12.288Mhz to support 8K sample.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 sound/soc/atmel/atmel-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 425d66edbf86..5e43ff0b537a 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -163,11 +163,14 @@ struct atmel_i2s_gck_param {
 
 #define I2S_MCK_12M288		12288000UL
 #define I2S_MCK_11M2896		11289600UL
+#define I2S_MCK_6M144		6144000UL
 
 /* mck = (32 * (imckfs+1) / (imckdiv+1)) * fs */
 static const struct atmel_i2s_gck_param gck_params[] = {
+	/* mck = 6.144Mhz */
+	{  8000, I2S_MCK_6M144,  1, 47},	/* mck =  768 fs */
+
 	/* mck = 12.288MHz */
-	{  8000, I2S_MCK_12M288, 0, 47},	/* mck = 1536 fs */
 	{ 16000, I2S_MCK_12M288, 1, 47},	/* mck =  768 fs */
 	{ 24000, I2S_MCK_12M288, 3, 63},	/* mck =  512 fs */
 	{ 32000, I2S_MCK_12M288, 3, 47},	/* mck =  384 fs */
-- 
2.25.1

