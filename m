Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B577A216
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHLT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHLT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:57:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354D1FE7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso912537e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870223; x=1692475023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joD4NVoVgEzLCIT5I6+1AqpToQVxZ3o18MkipM6/yQo=;
        b=Dk9KtfKHAHrYY2ZvfAdrjNlrRWb22Nk7SFgmVsi1mqCtV2S4NZFFC5Uy4EKP3dCVml
         S/CR9c53B+PKb3FNykeXUlepMzZUQIz+Qr8IYnxEBM1WH+0DKrPKoi7teCAM6sCHvI0n
         8lqWenFlY5ku9A9kmZi/v6Wfr8H0Vk5APg00rPQLVuh7AUh0iusFWeMoYP5tBqo6BsaY
         HCF0kIbJ5BE2zdV0UudBskVjM+n6CpbOag3ZyVeV0afBvv5xpMAbZdtcS1F8BKoQTJBk
         oQ0biUZsHzlyB2fnapqG9VsqIpLox6GIqPjJvKcvNWH5uMcJVllC/GgQsxY5X27ZcqZH
         t2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870223; x=1692475023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joD4NVoVgEzLCIT5I6+1AqpToQVxZ3o18MkipM6/yQo=;
        b=ZIUNnoEXrWmBXKbYaw5Uq8Lk15FFfsaMA2tf0k3qtMPpu43WdKUS8RtVkh3XqOfNeX
         qFJ27IsTcG16QlICmohTjdkLSifIgMob1WinbbWks53AhEcLgiAjhoPdVUvUtiU0Lf/4
         rvS+9sa9ple90jhmra9YXnNCgrbJ7x3dl9XIuwFjhN5Rg4cw3XdtEe6imKMGAoIhcuxh
         IlEnrdMdf8F//3oBIPKrKCFHZDfg2PKAFdLcEiXU8RRnquiY7JKePkl7ki/74Y8yNUbC
         IrIX43qyoSv9gRp2Pf6qMiHHYwg8ExloCXyA4nhQPQaOP7/proc0ZpAvoVnE/bnL6xqf
         eVrA==
X-Gm-Message-State: AOJu0Yz8wFIu8/Y7pw2edPSeykUfn5q2M0GjgMKV3aJWeff/zvL67jP/
        GC23yKCt7mTy0d4/fVcdVB/spwKgeLDxW3dFxLM=
X-Google-Smtp-Source: AGHT+IHC5BwFPYA1EOllat0Kiu/RrZXnK7ZiXqungICDni44A0LCY//IzybKAlaqRoXDyWV4gc37Rw==
X-Received: by 2002:ac2:447a:0:b0:4fd:fac4:2016 with SMTP id y26-20020ac2447a000000b004fdfac42016mr3459696lfl.31.1691870223346;
        Sat, 12 Aug 2023 12:57:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:57:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:52 +0200
Subject: [PATCH 14/14] ASoC: rt715: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-14-eb4dca1f68af@linaro.org>
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

This driver include two GPIO legacy headers and one contemporary,
yet doesn't use symbols from any of them. Drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt715.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 6c2e165dd621..1c70fa2d3e5b 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -16,14 +16,11 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/soundwire/sdw.h>
-#include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>

-- 
2.34.1

