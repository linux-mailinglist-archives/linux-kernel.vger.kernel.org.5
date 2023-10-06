Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17287BB9B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjJFNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjJFNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:47:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CB170A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503397ee920so2701613e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599993; x=1697204793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKUwyfTTneTxSGqUZGpPDlenguAqMHPKsbdYxdaEdtE=;
        b=tmVsWWaUTaz1CtdFmAgQx56nn5SvV5LtDv9nKlx0kBmaMh1JQSmZGmTzWH7JmYX/IL
         sjUKyB3/y1cX7OWlm2fRcysiO4mMCS6xXjMQZR8id4gpfcdjR338eLyiatxmANFUnllu
         +hZj+iGC2tvRLW0N7vJKh1tzgCdOjzkIUUibparGYgy/HvUhgXubmIJR4vA+FdY9b3tU
         JyA1ambMXIBwTZAsznioQh5cRsyCOaWvNEGKB1K73nOWym6gvdN/hprlVe8z533x5VtC
         7CGhILwIJYeFgG35wwQs8uL4gd56Y9pc3sItiAVHBkycxvUmKYa1YiSrG3j/xgXUX+qX
         rmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599993; x=1697204793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKUwyfTTneTxSGqUZGpPDlenguAqMHPKsbdYxdaEdtE=;
        b=X9a/BhJmo6hlA4psCUfp4Mu+ICvo0K9AhZKYNvSQsGxD1WmpVeN6TjEg4U638ZaAEK
         Fr4OTbE6hZMU5Hs7gr3jBCmIR/x11n5QcYDUL2Guci0pY+eRs1GFlHHMDCo6ssNTtFRo
         VnnYi2TmXl3JtUQd+bdpJj77y6Spg5i573zaoMOXhXowrNqGJCRvCkpdbVF0aJ3rStIp
         8hh0pWIJ+vLtWx8po6mm9auGSohX0ZSnTKpI/BZEmkPXGIaq+oTEFIJARw6yguzOUUjB
         fRZcIw1hph5G1YGFTfAygNGJfPZXSw2GvP6TX88h8T1wdX+6pM1IqQU8G/fx8bzbkyI0
         Q4cw==
X-Gm-Message-State: AOJu0YwXXF1gr8ruzvdjzpnGZsyRI3QezGW/ayelIUXlLrjxHrXsmNRH
        dniw52dCabILr48MrF2iU+F+KA==
X-Google-Smtp-Source: AGHT+IGcwLvp1n+5FWSbw9bTwDxtSAgSpZp4HVrtvVLTsDkaltU0mqZDETpn1S5AIg0T9GnwoZL/uA==
X-Received: by 2002:a05:6512:280d:b0:501:bee7:487b with SMTP id cf13-20020a056512280d00b00501bee7487bmr8096933lfb.11.1696599992987;
        Fri, 06 Oct 2023 06:46:32 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 06 Oct 2023 15:46:29 +0200
Subject: [PATCH 6/8] ASoC: mt8173-rt5650: Drop unused includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-6-07fe79f337f5@linaro.org>
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
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

This driver includes the legacy GPIO header <linux/gpio.h> and
<linux/of_gpio.h> but does not use any symbols from either of
them so drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 18cf84bb25c7..bcec1d9d790b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -7,8 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5645.h"

-- 
2.34.1

