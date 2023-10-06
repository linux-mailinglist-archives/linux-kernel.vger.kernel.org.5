Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E277BB9B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjJFNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjJFNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:47:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB81705
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50567477b29so2795619e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599992; x=1697204792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xkMTG9p1NQ0LVgSR1UXz8ORgmEVrpeNo+lHyOzhxw4=;
        b=IohHMP5v0hPswBYfGJLo9mo8huJ3hlAVgEmMg7uD822aX3RPnCQKBKBJHjkoh+NvgX
         k7c7QCrqL46RwS6dlIHkgq9MRqp60OqbT33GP4nz7Fmem7rHz6BRuxenRMcIu9UeQz19
         BCDhMBlTOljXJ4X0pFr3ZCJe+m1apj1e6xdAcMyLcrZZS3vmnzrdkUt8DOHmrfSFoNMV
         dbgp62WcsPVHED2luOTkDSgJsfaTWA5pYTlqqvzkYTZN6wMEVLfLq5DBok9WaNh7hlUD
         TXDgf+2lQ3vkK9yt+MGdAMjm3Ud0BU0YTEkFXaDJc9haex3APuXhIas0X/RdKVK1tIST
         qn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599992; x=1697204792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xkMTG9p1NQ0LVgSR1UXz8ORgmEVrpeNo+lHyOzhxw4=;
        b=czgmwOYox/+F5qmgOsixuP+hUe8Xyr+b3apQAheQgcd6kwgGQ955dRzoGdj3ZT/XrP
         bNiB23sSJXZzS1ewOUP2PJZ0SZOKmscbg6CksUdq28Olpl1V6iBUj3uvZAYAC9fCkg7N
         EUcc7pr0UQXGo8fdvXDfYyg7LRessqqhg+966lGAIonykafDHMmFWw0qrBpv39uKI2+F
         OVQS/6HFkyEcbYu0uz9cTeex0b6mz3eOXIr9wdDIUUM0K/yKUj37smuniI8wWUUmYxCl
         +KdBN0iOFGrJ2iJ+a5dl6kpECndhbwWC1gak/Gz8GYq5yQT/FIb8bOytSL1fXA6dY2j9
         337w==
X-Gm-Message-State: AOJu0YyKezaGe8jNGJizwBR+LrIYE22T7WLe5Mq6iddDTO+Kcqgam8KL
        zN9J0OTeSUcxLU3eKDlcVlKxVQ==
X-Google-Smtp-Source: AGHT+IGJYZb0UTK80c9PKT/6qzBCUPzMqh8bJnRydOq6QDikSosdvO3Bu1DGtamtPk12vFlTYj1sEA==
X-Received: by 2002:a05:6512:2811:b0:503:257a:7f5d with SMTP id cf17-20020a056512281100b00503257a7f5dmr9257925lfb.31.1696599992059;
        Fri, 06 Oct 2023 06:46:32 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 06 Oct 2023 15:46:28 +0200
Subject: [PATCH 5/8] ASoC: mt8173-rt5650-rt5676: Drop unused includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-5-07fe79f337f5@linaro.org>
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
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index ffb094284bfb..351b586e01b0 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
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

