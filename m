Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB179BAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354022AbjIKVwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjIKIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DDADC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502a25ab777so3860199e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420633; x=1695025433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZvQIqiJILx7Vu44bdAP6xXOlwSKHGpCyi7z1wxsqaw=;
        b=GGD1ZRhCBOJNxp6i0epWwNF8SZSiCOMtc3GUFqAEooW8pclhoupWqrAbmrApDeBwkZ
         o/F63LqUdl8hEZWOQY4+kV0AR6+Bwl+4NjXTJRl8rq4Y65temU2I2ziQCSLvFdwJlIOM
         J2UybqozivOJ1YxwA9tWYMkVZ3gIwKQCbBOU1vQIAMJW3apZyrXS8LVoHDFyU2jaVOm3
         VY0tCVePA1gyMKpB4BH45hw4p+WK3HWWnt2bcwx7/0DCDqTdXptGVCNEzwtT/sSTca40
         0KZAI/X+NbsC29p7EDF7cxQD2H7BlBzbKWp2xDP1CBbjSR5JHWbSDyKFK0d0Q4MhAQtm
         j/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420633; x=1695025433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZvQIqiJILx7Vu44bdAP6xXOlwSKHGpCyi7z1wxsqaw=;
        b=Yt73h7StXQr8v+6RfP+neET6SlAKZTXiZzzgVJ4uPSMv0x9m0Z40+IsB+Qbvs6Qv7M
         AVPTSDRJv9X+3yJFqJ4TAzqF7Ohy9JvqUQQ5Tu+6SGlSK/gZqj4uiO04ul4iqCrXiCDB
         HmEvn31OUmEqz5l15t2IM3Tt0tLBOUTwDoMDSGzuJ+0lyQdHqBaQ483k3y9PPiC2tyyO
         UdfD8z8i1eT6/5C5n2DnOahl19cNCm3KFhgUjpY4+2xTDDxFjZB/wkTA+cfta0miAT98
         xbrOoGMKLnFDjMd5J/+eLZXG9EVTB+EE5uHPRUoaRPtgQseWcOVLYRRX3WMO5BhDv/ep
         fB6Q==
X-Gm-Message-State: AOJu0Yy59aqNt8e6r7PqHsnvkrhWPskO2QBmoRjzbHBASfNcr9RsKCC2
        aCvjPztRcUZKLs1TOfgQEcXBVA==
X-Google-Smtp-Source: AGHT+IHLa00uwx18Fzy5EPh4buiYBYfThSk+G9oIq720hxnYrYyiXAOCwPIUdXV/kNi+50d/4ljcyw==
X-Received: by 2002:a19:c505:0:b0:500:b302:3281 with SMTP id w5-20020a19c505000000b00500b3023281mr6564384lfe.27.1694420633260;
        Mon, 11 Sep 2023 01:23:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:51 +0200
Subject: [PATCH v2 4/7] ASoC: max98388: Correct the includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-4-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX98388 driver is using the modern GPIO descriptor API
but uses legacy includes. Include the proper <linux/consumer.h>
header instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98388.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index cde5e85946cb..078adec29312 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -3,12 +3,11 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>

-- 
2.34.1

