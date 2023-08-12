Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F203577A211
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjHLT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHLT5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:57:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914C1BD2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso4830654e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870220; x=1692475020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vz4oZLX7aphcgmxSItSZXEOAiLbMHclJfp0/mh5VAk=;
        b=Y6B04XcWZaqYabmSmq2xh2EYwqjQkG/gc5IcFlRrNqjbSYtqaOkF3pdmJLjqIDq7qr
         XcN/LvAY85IekgHH9xgHj3oJc6fOnwkxRdGtC/joDct1j24UiocfkJIwI2+He6xbtg6f
         J7+re20ypMF+erb/4oi0VT3h3G0PD7HbCb4Aq3df+I7JqGnUO45k7HoP/lK8ymLSMjah
         7HXXGj+kwb2Nyy1uMhlgCB0QJ8reADEm3I8jPIghqvCQw8ToD+d5Ny9jui0/QoQ6i2Cn
         giX7vG4fcDXENsuHbUY3jwjO8FCqLgYIfy4YSrsoyR2/dphxmJTjI6GrcYPtHM2Zj39S
         B53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870220; x=1692475020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vz4oZLX7aphcgmxSItSZXEOAiLbMHclJfp0/mh5VAk=;
        b=cmsHutKE+iCJ0PGXi+Ty0lBwnL64RAFP/v1dDWwcOCIvwBJLFUAmBZ58YfsFNMasnh
         5nDV0LPsSlOu9G+IiXetKCfEMXA8uY2a5hSa44FX3xdhIvmtJ0s9sfTeGB0xWfxcbhdA
         GMEY4YrXpPCy/jW9KOun6UNxBew6cEzp+dF1stq2Q3OCXdYudC3jt3LxKUGWjIn9/+gJ
         /T6Fv6T3/PNtQiftodXs5joqdDgtnoTbZrrhy4CgUJ8wXt58rbIUOcuu7HX34srlDqKu
         bIfkYSeTg+9hkeH1ec1XwvrJo8eDnKJQ6MY6AFDxYvKu/ZDXN4ZukaD3vYKwTxERa6MD
         Fa0Q==
X-Gm-Message-State: AOJu0Yxng/M8LjWT6kh7RXo7K8kEM4iylC/qZy1fRUVkaIAzVYk4Gu0k
        HJExDLGjbSpp4mEuQqLZ+5eg6A==
X-Google-Smtp-Source: AGHT+IG3pLCSb6mncPYmIU/Atnw7rF/zG/h9pPTjY7T/XsmK4zV9HC7UoEK92XLXTIQU7FoMmFVCcw==
X-Received: by 2002:ac2:4e08:0:b0:4fe:551:3d3c with SMTP id e8-20020ac24e08000000b004fe05513d3cmr5161643lfr.36.1691870220053;
        Sat, 12 Aug 2023 12:57:00 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:49 +0200
Subject: [PATCH 11/14] ASoC: rt5659: Drop legacy GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-11-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt5659.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index df6f0d769bbd..a061028a16d8 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>

-- 
2.34.1

