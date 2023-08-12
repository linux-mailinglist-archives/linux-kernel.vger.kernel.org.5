Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1077A208
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHLT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjHLT4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FE170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff09632194so517639e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870209; x=1692475009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWfVbPxe6pLHw0PJClWoga5Ee9u2ZK8xEvPaP3dj5KU=;
        b=NAhMbM59ePSVz+eoff551Rlvf3tX4RlJL08m5mVpwQUMmROS/sYMJM5p3YfccCiOmG
         JnhC7hL+dV9VCRdBW+zbJf10ATUmsl7VQ6oRXstrabUvsSeZvHY3DX2sug7PKlCFAGoQ
         gw4/+cMnm7Qig1npfb8ciBCC0Hkzf/ccdcOBwsvzuWZviowUE10Wu+ti3VZ9giRFyDn/
         rccttZcQ6xNjwWBV8uc/7FLr3pBLpjItC+rvXI7mzraDlu7K/fAkpBne1IzeXQwFTQtA
         7o43dDlW2J+UKDyJ5GHZnwyiBHocYgBlyT9l7cEGphfdfpnd2taidfbsW4RzTVnLPLi5
         kpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870209; x=1692475009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWfVbPxe6pLHw0PJClWoga5Ee9u2ZK8xEvPaP3dj5KU=;
        b=HdF5AxrFury/soHGXRJK8efbDxCuNlEK1gt6VMLoTqjT/2Ml7CbLl2fW7iWGYAsOvr
         Ry4ILU/zK4CUvfgC/p3Nx65rKV6dY3G3qzKmUURsn/5Y308LZzxwMd1D0HVdfcoV2Ghd
         BfbBYUDA8pyzP9gKs3H7QcKUsRCZsc9LpVzEpzLGL4ChzKREc8fabu/fVUlGCLs6D8/1
         eAMy/NdUFzhCEyFAoDWR4v27prER11spvUdILy4LWTfSNC58WahqE8gqqjJdxikT2n6J
         g5DBoXKWHHjjaT30uBvzVQzDpxUggpxLKDIhOGXEsDd0SHySfmosqinY24wMDa5HeSLn
         FKFA==
X-Gm-Message-State: AOJu0YwRueLd5bdWZn4uPfDQQRIRLkrFXGbWAIq+z+TYin7+0jX/gIg+
        H4SYBNkcydUeN3S9Q1zWdvd8pA==
X-Google-Smtp-Source: AGHT+IEsvenVnsCRuiXEU5fmXIPlw4xiavXtVVagdK1ZX2jt5Q2SVY4vSn8JIpplF6KPPKyIQqsWnQ==
X-Received: by 2002:a05:6512:2212:b0:4f9:5781:8628 with SMTP id h18-20020a056512221200b004f957818628mr4788088lfu.24.1691870209471;
        Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:40 +0200
Subject: [PATCH 02/14] ASoC: rt1015: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-2-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt1015.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 38d9f69b08d6..99ec0f9a8362 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>

-- 
2.34.1

