Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5201277A20F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHLT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHLT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B68172D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe45da0a89so4840246e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870219; x=1692475019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0crdb9cw+jjwI8pN3ZhoF0R0PN/j+2M0tGVn01qC/g=;
        b=H2CIsnu+od6hFKeqI7TH7aKGc9aH0I/R++IS+uEzgdApJKzed7JZuynfLxkUcHUdWM
         poe/X6r4Hhpt9NqG2eb0Y09wXb0QFefDr1OyWIb8uYMTp5bkwt3XkIc/qvmFup47hjDL
         eDw0iLqBZV+S/WDoQCee7J1Y9a/mLdFbaV9hgKkUK0jAidOOT7ehKqQOZKbQK5LQQ5a8
         dCZqLS+bbMyiPHCXfmpoDkfx8y6YR3H1PDWUKkUz5at6gq5zmyC+eO9q56hZVd3hDBLl
         Ry5MRqnRP51vlboOPj+DZL+NYG1eDAv7SRBpdRIHdPD5ynCXb8bVUfIVg6+pnzlnUeJv
         z1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870219; x=1692475019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0crdb9cw+jjwI8pN3ZhoF0R0PN/j+2M0tGVn01qC/g=;
        b=gWK31faAXsqGZzAN68oDx9kvlAEHFuMN9bA0a/qolZj6IZ0Qe4ANyFgng7l7UvexBI
         p3Cci70KA/XSadi8psd7NuVvOyDZOLVDpsHv1VlKFnFHrdzFHgs4rVRUWzK/s5shJ9oc
         FyT8LnLdGGD2b7RHd2ykBD4BNKkWB/X5wM/7XvnEf7ZKAXeoWlNmmwgiSFlcRDz2l8mi
         VyCuVAfusVYmklsJdi6ObAMF5cTjg+kIfDaCNdShzlQeXz4nvCJMXrTpBe1hW0vVAkzI
         vh0mxs5dzhczUAXhkZHizl9Lmm3nTrOoWbrI6pujPlHMiS8QEmPMQkci5GFOJT5Gsy4w
         PXmg==
X-Gm-Message-State: AOJu0YwGijaJJNKu6eFTij0G6xnzxocvhL3jfGGVcUpoNPuODzHePLAF
        TJvZ+qLXiypCEr+ya5iXF9x+aw==
X-Google-Smtp-Source: AGHT+IE8gCqiErMbQX4Flaf4yvnwSMdbXgZwdnOvhLRn1rUy6fgQkLn7KEb/MbhUTFZESt3ZGs4Z3g==
X-Received: by 2002:a05:6512:3111:b0:4fb:8938:48ab with SMTP id n17-20020a056512311100b004fb893848abmr1537577lfb.16.1691870218857;
        Sat, 12 Aug 2023 12:56:58 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:48 +0200
Subject: [PATCH 10/14] ASoC: rt5645: Drop legacy GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-10-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt5645.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index acc7fb1581b2..1a28fb541255 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -14,7 +14,6 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>

-- 
2.34.1

