Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408A7881BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbjHYIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbjHYIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4691FF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso927800e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951137; x=1693555937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/HhJkYfqyaXs9yIGYFPPzlpsmAC+qKTgrrYF36b8es=;
        b=bPi55yZm+3mup9ggSLUCjMWmRb49okeCF+W/OznEmbeZRtK02YnHTszrQ5+Yy1lVJE
         FtbEsbpuiImJA7hZOJNZCCRgfo0YFxdKzRiKy5UEzNhL+4M53w7sMmYRHZOG7ewHXJF1
         BGPt8tIiHS34hZgZkYVGV0pg3iYwr9/LpwQwMeStJUz3XwO4kMfB6XH/0W6V2Bmphf5o
         O3mmgi3GY25eEL+fFun4wUcaJCesVXoeNpS/trH8TQeIMS38WSV4b0MMNYAWKb0boreu
         7cW/63vZlUtX245mPHNpyw782/X9SAa/rAKyRgmXzZkGLLnXiCqFdpQDiQmQsAIYCPVD
         +hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951137; x=1693555937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/HhJkYfqyaXs9yIGYFPPzlpsmAC+qKTgrrYF36b8es=;
        b=LqASPCuBgP7J27OrS8498qDAUA5fmdWZgCl5l6iuBoM5LL/L8hdXjM6xxeGCu/fFZm
         x9HGENqnZGY988F2bYwe+zB+0p4izj7YaBd1fjCSXzipKTWjfSBf0jPoevJvsjGF9J6/
         wDTU3Gjkl7TgblBjGDO82xruzfkHa3bdjGdKvgfFenKOYnoFKOlNoN5nOZGbVtbKz0py
         OGU5oYkZC0cHYnSLdEA85o3QDUg4h7yUlrozcDZPkQD74tT1itU0ddRog9wjmnLyW066
         KSQRNME6CvnLc2ayVFMspmU3iu0WeWwjjVv7AswfuzFEPLUF0HmWvkTkZlY9/0Sig1/J
         na5A==
X-Gm-Message-State: AOJu0YxJySRzekZ3Sr8+ru+4PHyGLJhroeKCL4lbo2VkKz6jQ0rdNFk4
        9fvyWapCQdkakMerx7kdppBKBw==
X-Google-Smtp-Source: AGHT+IEyHJmheRscOX7UBeg6Z7DcJVfwt0W14guOb3+tSfGq9EVhRyrhY8ha1hu6hxSTW7rsulAyig==
X-Received: by 2002:a05:6512:32cc:b0:4fd:fabf:b6ee with SMTP id f12-20020a05651232cc00b004fdfabfb6eemr14730764lfg.9.1692951137399;
        Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:15 +0200
Subject: [PATCH 5/7] ASoC: max98396: Drop pointless include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-5-b212292b2f08@linaro.org>
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
do not need to include the legacy header <linux/gpio.h>.
Drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98396.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98396.c b/sound/soc/codecs/max98396.c
index 3a1d8c211f3c..e52bb2266fa1 100644
--- a/sound/soc/codecs/max98396.c
+++ b/sound/soc/codecs/max98396.c
@@ -7,7 +7,6 @@
 #include <sound/pcm_params.h>
 #include <linux/regulator/consumer.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
 #include <sound/tlv.h>
 #include "max98396.h"
 

-- 
2.34.1

