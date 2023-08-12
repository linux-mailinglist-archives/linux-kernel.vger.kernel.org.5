Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710477A20E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjHLT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHLT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D471716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so4991186e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870215; x=1692475015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLDeZOsLJKjn9AG9yyMWHhzn7rsfeUIcb3x8lRgRJjg=;
        b=NuDbDoFGMwAupOzzOwDSE7XO6MV5ks7/jJmz03kLwZKJvxZTHbOE2kv7ttukvup37C
         j5boTJDScuyTSSNb2eAbjXZ7zbHBpsdBy8p6vyBT5KXaHOoqb1CmOaRD7cc2Z7oqwfJh
         mMsVk3DePxb5995uIdoqWG2v+BBYMMwR3cDELqulJAUGSp1GkzkTEWZ/gwIqsPiB0b6g
         U/fUQcWy0JDmY790Rilr+JI8vvKJkxpGh65EZdSEWd4sCiNYbcNBbebT6zi+0VX1/Ugb
         RCbwwNW4PPpGP4v8Xrf3IoK3lARQiTRWNf96iz2UOqm5s4iIF+2Pe7MuOuScjHy38tH0
         wwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870215; x=1692475015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLDeZOsLJKjn9AG9yyMWHhzn7rsfeUIcb3x8lRgRJjg=;
        b=QDhkSGvCyA9Jf/Jvn8VV1kfTGoVm+KTUM77UMgvdoC7gMy+hl6UYrmcTbySS2kqPLj
         9KGecKRBKXiM3kuAvx/mfH/X2HHqczpSvgr1jk+1jNnNSwuqAyJmudvMqlcacI0uTJUL
         osP2rXz3U4Ow7zMA6wzdNNe1U/Y0BT6cDv7wCfqobu03oA9QnUWbhNFMdObEhRr56S2x
         VxWs6viKZj5goKWTSMH/IVPA27dTFewbhVdG+lTDbMTaAJjg6cg1oFoyrbgwYyXQqS3a
         DiuCsVLe/+j4RSdBLalOL0fJWeJjVmafzwqrgQ8m9Ee/zDy0Wve8lvdY/RxFyV6kmTQl
         IlYw==
X-Gm-Message-State: AOJu0YxUx7L+6vynhjRgppXiP6RC5RDjijnccyKi70kDZq7FzvVpp5n8
        c13wLsu1+SZ1FtWUY0UU7u1e2w==
X-Google-Smtp-Source: AGHT+IG0gOadfyEHAHfLkjda7UNNoPUl5kjpZWfu4gyX0g5WIbk0RROX7Qqgidf6FZtyFsvoylECgA==
X-Received: by 2002:ac2:5e2f:0:b0:4fb:8bfd:32e4 with SMTP id o15-20020ac25e2f000000b004fb8bfd32e4mr3099876lfg.13.1691870215470;
        Sat, 12 Aug 2023 12:56:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:45 +0200
Subject: [PATCH 07/14] ASoC: rt1308: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-7-eb4dca1f68af@linaro.org>
References: <20230812-descriptors-asoc-v1-0-eb4dca1f68af@linaro.org>
In-Reply-To: <20230812-descriptors-asoc-v1-0-eb4dca1f68af@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver include two GPIO legacy headers yet doesn't use
symbols from any of them. Drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt1308.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index 9d07756cda40..86afb429d423 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -11,10 +11,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
-#include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>

-- 
2.34.1

