Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA87881BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbjHYIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbjHYIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0061FF7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ffa248263cso972107e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951138; x=1693555938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44JIVg8xfT/EISToMUTEvN6PJWh2bmWBrdxrTpht5uo=;
        b=eFQD4cq8n2Fct8am3VeuEldkXRZ1tKBntwqnqD83Ex1Nr4ejqLxsjn7wE4+qyoKqKQ
         sVq0njntmTxoUdnoBWXC/4s+dCmMoE1cBOKu3QouzqfEJhaXa8ZCcBjYXWYI395Oor7R
         +hfvzByRJWEJGlkHOCaPtGggPLdnU2tvqLZS6fkeuOV4Kvc8Co+GB1fqqfydPWBYsfNC
         FEZZvAkN4PHfmxWWRgWzbEo0pHyn1XHZDXeTUSyHlUNBAn88ysXgTs32FDJEqsGRJAO7
         kUMjWAkuXkUXM9Xcaz31hMYrJD/BMgNLztCapcSVPnuWja8QEQ8oDy1UzjIJmF+lu3xV
         kZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951138; x=1693555938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44JIVg8xfT/EISToMUTEvN6PJWh2bmWBrdxrTpht5uo=;
        b=gOcpy3grd9VDzefQ1HqZVfO3kFzqutFyD/y0BDjcvKWGeoOECokir5WaReJZCcPy7n
         YdeqCDTQdj/HIiWYcOvC16+jombLVtzzJlGCZ3KYDuelKs0fGHXica7beyJ2v/U8k3is
         ED5VVgbroN/7brcR2xO6n7sZk5Zt5JGzQODdBR7xhN7bih1O1x+wUPfZzjCrcjv4PsKy
         N3dnexNg6fYIVWeeytHZkt8hpZ/zvDfJiUgtqep8dn6h43ttZGieAGnNTFu49C0YdbYz
         2Em6xEkZWrM20nYjiBYzkZ/N9+atNdXq+2g4uew3V0zhe+I+yT3HotR8mbRi24nJaV2G
         j1Jg==
X-Gm-Message-State: AOJu0Yx1yhId6+FgtlocaTLhAgfLmgluEtffzI8svfnSfDoWFiwkAWGE
        TalGDG7sfab2eUqdkGnp2g9z4w==
X-Google-Smtp-Source: AGHT+IEodFZz3bqeeFdOiK7hMl+uUlbSgt9vuSKj8ccHrNjvWe6heS8Ntxi3tANPFEcCQKm5bqj6mw==
X-Received: by 2002:a05:6512:e99:b0:500:7de4:300e with SMTP id bi25-20020a0565120e9900b005007de4300emr13571895lfb.58.1692951138141;
        Fri, 25 Aug 2023 01:12:18 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:16 +0200
Subject: [PATCH 6/7] ASoC: max98520: Drop pointless includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-6-b212292b2f08@linaro.org>
References: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
In-Reply-To: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
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

This driver is already using solely GPIO descriptors and
do not need to include the legacy headers <linux/gpio.h>
or <linux/of_gpio.h>. Drop them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98520.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98520.c b/sound/soc/codecs/max98520.c
index 8637fff307ad..edd05253d37c 100644
--- a/sound/soc/codecs/max98520.c
+++ b/sound/soc/codecs/max98520.c
@@ -11,10 +11,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98520.h"
 

-- 
2.34.1

