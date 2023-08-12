Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647277A210
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHLT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHLT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BCD1716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso5037395e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870216; x=1692475016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFp6ohpQAy0qgaCQvNHy6wTpHUejID3heF/y5EZlwqA=;
        b=HLKuxxsLNzG+9fBXfLsTJ4lMg7pp/9ZhiWQgY9OEeoUrUfqA/Vkom9akvWYupYDHmH
         0CQ1EdqEbYAJwIWfbMhNZPcA6QEDsgA38oE6rfmKNWTHuZQPinRveq41bnd6M2WeFe/M
         PeSrEBFd81Pk4IMSuAr5XHvWrVkAYD4ypLmaurupYOVqTavkIjii1Kbxow+ZQlCn3SIC
         mQu8WE+ZspJaTcdyYw7ZwoC1Hoo7ZnMapNas2CkeP6ihDUWOPRcoZzvlGOaHYeWHAx2G
         rDUnynscxVzejn2DEeI3EvT/U3WsBKB4EztJQjltDbaKe4C5fo3W8/kRZ1O0sOyfvuHA
         o3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870216; x=1692475016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFp6ohpQAy0qgaCQvNHy6wTpHUejID3heF/y5EZlwqA=;
        b=Qqtzq0UvPfH574mUuEDLwBtrattDFNiyE2EhXVm+zt0k+Ywn/9e7h+MAU+QprLfIMd
         JgOhkJZGEh+x/omBhfPhVZlRkSsdR4XArKqy36oS53uWR3gqPqrDKhJHWOeODoJvopJi
         /8DAKAv/E03Mw6adoNNMxRhCi9G1XidXIdhQ2CGsn18ApPFNMx9qLXet/Q+rExFV1J2/
         wGWVhaGnGM1Eh/GVMGIDiltzSb/VpD/c0MhKmHOSqlz1GQX/gPPBi82p3hyeMQrygvaL
         iCeQitQi7WTqfWyPIk4NflKMnDYoJ/CfNtFkMBTJSy4nnlnt8FDnwODPA+HSJNPzYg/Y
         8TOA==
X-Gm-Message-State: AOJu0Yz4CC5SLpSPhP+HdqQAfZg0/74INWX/xNxXKPKLF4pA9u4A66dT
        UyqsfDDD9y7+i/bDDRaNF7hQ1dGhd/miQY6NC/Q=
X-Google-Smtp-Source: AGHT+IFrad42poYZJOADdCM0/Oz/0ggXBbC/pjnaPvLhErWVxCZGe0TZApZuU9e5lsjZlwsM4qJDSw==
X-Received: by 2002:a05:6512:159e:b0:4f8:7772:3dfd with SMTP id bp30-20020a056512159e00b004f877723dfdmr4735246lfb.11.1691870216748;
        Sat, 12 Aug 2023 12:56:56 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:46 +0200
Subject: [PATCH 08/14] ASoC: rt5514-spi: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-8-eb4dca1f68af@linaro.org>
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
doesn't use symbols from it. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt5514-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 362663abcb89..3ee6d85268ba 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>

-- 
2.34.1

