Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77DB7881BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbjHYIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbjHYIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7000CEE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff882397ecso922011e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951139; x=1693555939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoFqFLIfT/Pj/zYgo2TV8TIm3I2iaBuNZRSIlIfashI=;
        b=N8tOQE1+ggrtynhDr3biXEZNw1zz5cY70hzKKCVyFf+IMR1yXAXthVrO/VesE5LNY6
         ZFTe+aebePO3TMPyUdOZVEzyfSEQc3DteeWzMyV2gwsGhB8kOMWjjZYb6Wf5JEfx1+lz
         8TsDpUMI2g2nGjoUR29rC0agQh6w0db6a1QcHGvJg887QaBWx2t8czqalAywY0CXoOwg
         40YCYGtu37bDDcAr4YtLIVR4Jy5MjaA0st0MTxF+h46IeoWNobjmX37+IvsTNDHZ9mjk
         M9aHhdvbtyHYBSZ+6mVz7bXGNAl4LlIbJ/3sigo6Emyc+iCyMEDtEpqqG2rHBisr8V3F
         5fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951139; x=1693555939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoFqFLIfT/Pj/zYgo2TV8TIm3I2iaBuNZRSIlIfashI=;
        b=Wq5b/kKHMXjU1vcy+bLdy69XvmdIU5R31imhhFIre+cvD33ttYzDA5Ok/N9DGwTtTP
         EYSRa8GmuRhKBVyvIZsABIKTkuOTfrD2eBBaCthESLOxWRMcer1nw9vBJhnlZYBI40+O
         rKDBKT7NWuikxGc3lAWaj7KaisR/YtlkTKajAwc2KyfHNlp49/xAxTAYm2Pde1qKAUuQ
         +20hGmnjxLvmeksqXmZNGaSqEW69ygeqnmu0nRLSouPyZZq6zTDrVSPemIoEIzxC8QPq
         SfbQWrTBToNsM5hXAAYoxO0fAPFxgRBYY9hkQAnWD+jTXagsl3krpkb2+Fjr2Ed6l17z
         sgNw==
X-Gm-Message-State: AOJu0Yzqqq0A8UYxIEGyDgdeWTqRhhWm6kkiakPROWIrdoVDmrIKBv4A
        ItMw+fB7w8WV416XoTKx4PyoYg==
X-Google-Smtp-Source: AGHT+IEjrTALuwMVuRJO/f49NCeBOByJE1JiQEqP9VZfv9t+k1WQ0Gs+avCqvnzSr9p3zL8bSAc/pA==
X-Received: by 2002:a05:6512:3450:b0:4fb:99d9:6ba2 with SMTP id j16-20020a056512345000b004fb99d96ba2mr10022257lfr.24.1692951139010;
        Fri, 25 Aug 2023 01:12:19 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:18 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:17 +0200
Subject: [PATCH 7/7] ASoC: max98927: Drop pointless includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-7-b212292b2f08@linaro.org>
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
 sound/soc/codecs/max98927.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 776f23d38ac5..70db9d3ff5a5 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -15,9 +15,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98927.h"
 

-- 
2.34.1

