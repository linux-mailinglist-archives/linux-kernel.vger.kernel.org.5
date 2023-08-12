Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDDB77A213
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHLT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHLT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631881716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe0c566788so4814714e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870210; x=1692475010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiL5v7jj8mIZHkZU95wy2FCQioY2BGnV8JkGSJ5FZHY=;
        b=fnUqqzpSgxz2XvCuCH7qhwxuGA5n8G3u2XVHZyQX03Ulyn4REbrnYu/nPq9Z7ZjoLV
         bNw86NL8b3HdkVsYAKtnomXE/oHfRclFkzkEeioLLn+kCab7eV0ehN7FuL37S3bGsOVx
         Q3GxuaLpSNXAe9HyBwLUClsyHGK67MLec4STexyWy2qiC6gfp87ZekTDG/Z9aT7jrzxm
         +iJxo4ykG1mCOn8O3g9eTGk4t9aOZNnMqOnF3rQXWDUg+W9SWyyqZZ6PnnciTy4Jle7S
         FO5kovtS2sykrGmEsArfleBFQo2Zo+zo7U//npth3aeqoPH4mTd/0+6PinONYCzwWudT
         3FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870210; x=1692475010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiL5v7jj8mIZHkZU95wy2FCQioY2BGnV8JkGSJ5FZHY=;
        b=A3M33roM3RFQrvWKFkwqZdCPMXC6PXLKTY6W7wkypjbu0yM5JNXNNZ9q/p1Z2WOG4F
         MDVprPi+2yliE6mpoMm9dV6VCtvi5GFJHbwKMGggHkIERNx8VUoDrP33fiP828+K+Few
         KbuG6CCSpSSLuxG9bIrPJ9RcWYO93wYKm6ndEzKEixBW0zYqXc4D93jaSPFZMCMVCXVh
         AzkYosKAP8uP20lSC1SRyB5sl5Ccr22KL926Crbub4NGlXDRzu99bd5l4vKlV8oOwQZq
         7J9F27M2n8zA943BBymllQ5IqgKkgyYEMkGE9hnMq+y2DMVsdxnKno8+QJ5TbQXNznut
         Y+3w==
X-Gm-Message-State: AOJu0YxacKoGv6dbagSlVZpmc2aA5mEhbsmQh9xcInAKfXfQbR8FpM4Y
        kFvvoB7G4yVJEgSOAUFgoT16vA==
X-Google-Smtp-Source: AGHT+IHzE5b7z+cG6l3X4BVKnk4QzhVZesjM+1wIJSE+4AXnSwDN4H4WxEVfqruYL3qx4o6sKdybxA==
X-Received: by 2002:a05:6512:20c5:b0:4fe:ef9:c8d0 with SMTP id u5-20020a05651220c500b004fe0ef9c8d0mr3559460lfr.35.1691870210722;
        Sat, 12 Aug 2023 12:56:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:41 +0200
Subject: [PATCH 03/14] ASoC: rt1015p: Drop legacy GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-3-eb4dca1f68af@linaro.org>
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

This driver include the GPIO legacy header <linux/gpio.h> yet
doesn't use symbols from it. It is using the new consumer
include <linux/gpio/consumer.h> already. Drop the surplus
include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt1015p.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
index 06800dad8798..44e7fe3c32da 100644
--- a/sound/soc/codecs/rt1015p.c
+++ b/sound/soc/codecs/rt1015p.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>

-- 
2.34.1

