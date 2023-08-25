Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6E7881BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbjHYIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbjHYIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E31FF9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff9b389677so916626e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951136; x=1693555936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZvQIqiJILx7Vu44bdAP6xXOlwSKHGpCyi7z1wxsqaw=;
        b=YYmfBumd1OqmN1kcJfKuQGJb+t6phEs/bHy0wzfEWEPqcBhHzQFEh7HWO5r7zI3KzK
         rlE/o9gkuU4tb4GOeW4HKbUsN4tkJmcv9YMo41BmkTy+9R1GtaXSAsW3wVlwpfWsEaQj
         8pklm/io7r+91riwH1xb5DOgZnUTBIZ0vR8JR1x2dqCZS97VqmBV8Ur1otWfoIshvjrz
         LkVGMccfYQkq52qo+UQfxt4+1PtThFLeIEJhJmU3qzaD2IjQ7a7EB360vPqny0hrF3W0
         /mVzGnGBe1gq8JM9tvtCVn/0J5kT2aFW1S95QT0J17Uq8WsOaG7xNMP2r1qD5UbtS/5r
         Sk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951136; x=1693555936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZvQIqiJILx7Vu44bdAP6xXOlwSKHGpCyi7z1wxsqaw=;
        b=kVHk5LFwarZb2g8zDpZXezNqzhNgujHr46uq/1FYXFmlKs2t7xy1YdxgDFNk36w/EG
         NuCBHlISJmOWL8LWjDX5k6tfrJgu3fczaxsrxkQxSjg10DmlYMi74+vaArQ2TqwXD+nm
         dRomgyQvaMqeAp6UmPNpKTN6z4u8AE+gysq3FT+0xlzv8kZUrCi1lzdU+Eja28xwQjpY
         kbng080klfu5p1LUJ/VJznQM5+iipRxfoutEz9ANPVxzjRFhWcTBlSfwmDVJcNcf0f0G
         lV9eL99o4qJeVEHkRpU8PHGZ6uSUXevTFDcMPMZ70hXM1b/24ZSHcCUSNAPDalWQvYGF
         ic8g==
X-Gm-Message-State: AOJu0YzV+qa1aZD0Z5yj1DKGnloOTsjhT1Xrw5Eqwx2dJ6cmHrq7bmZ8
        eLa2ZXeHImBV6WTyK0YI/6toqQ==
X-Google-Smtp-Source: AGHT+IG2PpNK4ugGGs+dTr6KbXE8uHau4dcclyQjik08hXAm1AW/KDfAXQLnuJhnsM+8CSpY83s9Ig==
X-Received: by 2002:a05:6512:32a9:b0:500:a6c1:36f7 with SMTP id q9-20020a05651232a900b00500a6c136f7mr1030311lfe.3.1692951136501;
        Fri, 25 Aug 2023 01:12:16 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:14 +0200
Subject: [PATCH 4/7] ASoC: max98388: Correct the includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-4-b212292b2f08@linaro.org>
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

The MAX98388 driver is using the modern GPIO descriptor API
but uses legacy includes. Include the proper <linux/consumer.h>
header instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98388.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index cde5e85946cb..078adec29312 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -3,12 +3,11 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>

-- 
2.34.1

