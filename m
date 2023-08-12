Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429477A20A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHLT4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHLT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E7170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so4901977e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870208; x=1692475008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcTJEbiNL31Kvz83mrddFrf0wFvjK1FO1pL9qlAeK+U=;
        b=CAjovOC9bYNxcVXg6vLLlP9DnYLniTfkOSqcP4cRfXl8tILamlaYAZxscJYs8xDQyx
         EQ+FojQBauAr6ZN/0uOr5KyL3yp8dekipMn0uhaG9SEnfW9Zl6FvF86g01Lntil+SDmD
         ppwupHENJdqCyMx6E2sONuiXp3GIJhSB0OQYtw9T4Ua6IS+kNU6clvK0LnZMEZ1fHU/u
         W5rxWkKGl+o+u7zqz2WppiMr8CxXvuWHvbFCF/DKTV7dXvryVdSB/VSesHRuO7m3TTsO
         OcuZbbALB4GHGIfgxkrDjGP4Jd2EUKJY7yyaFh2TYX1vUeCq/VEOA5Qp2+4JgnmM/AjF
         t+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870208; x=1692475008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcTJEbiNL31Kvz83mrddFrf0wFvjK1FO1pL9qlAeK+U=;
        b=XCWmZAtnQzKZEUgI8pNdRfDswrtxBKfQMeCYf8Hh5QixS3CGmU09xZUYicNbRWEKmJ
         75o25//TXe8jjUnmI4BviWD03HZQX+HwT7xiTrNK+Bg6pGXpsHf1spyKPOVA0vr7evJV
         tOfKDd33n6CqWFEjWGgFbHSHYqLCNK94AUPuKi/IOfxfRL8ChYezoVipxmg2fDs8zCWe
         G8eUC+LQVeFnmnGKbNy3LkBQ1OygZgJQc7S/ya+fZxa3A2QOXqrk545Sh2gvLUOCVHfN
         gVRBn6ZnaDmq/xD1wn4TPW8ZpnUi2bg9GvssriTB93jdgwtpymEFhBgAc8hGjKz/Fc1V
         3E1A==
X-Gm-Message-State: AOJu0YznLMcXX+rRxQxjmS/lS+SkwTAvIHC3V2iuplSww0gaLFwOtJ+5
        zG1DUCzaOtzRe6Cd45mBpe1dNQ==
X-Google-Smtp-Source: AGHT+IG8zbXQcaUnsdPhVNyOvip0dIQcP4gsychvQyNQbwHdKdXk+CZ0L2sStXi89aGEVcFe8d3Ylw==
X-Received: by 2002:a05:6512:3246:b0:4fd:cc8c:54e5 with SMTP id c6-20020a056512324600b004fdcc8c54e5mr3202419lfr.41.1691870208282;
        Sat, 12 Aug 2023 12:56:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:39 +0200
Subject: [PATCH 01/14] ASoC: rt1011: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-1-eb4dca1f68af@linaro.org>
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

This driver include two GPIO legacy headers yet doesn't use
symbols from any of them. Drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt1011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 42bac8150f62..d5285baad53a 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -13,11 +13,9 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/regmap.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
 #include <sound/core.h>

-- 
2.34.1

