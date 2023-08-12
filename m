Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830977A20D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHLT5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHLT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBE170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so4890913e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870214; x=1692475014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljcwz63QBt82/HDrqpWWycZs9ottLR07mV0FHtlMMVU=;
        b=yyIRu+VluWw+d+IfRjGZ2vbpWCWnk8dfq+mtcZfA3kUAoTul9P4sO4N1fe3lUhVTl4
         k5I6E5fiGEaLgL6KljX6uIDsI6w+qkvsqHZ19pimJOMHB8T1AbhnrPkzSQTuncp6kZUL
         SnHe0s+5wh/cqecUG57KDXmxZe80alNjmEsBW75vzDK/6q+2BWpUoL9wPX6RjtYhI/ud
         XUa2t8acOP+0Lj02e+DpRPy1gRuAZqF9Ufy48qUaIMUhX9rz9aispjyDi91ivp9fiDlN
         M4CWpXmhCpOrJ2bIOY9wYBKeg9G7pC8vrDto4PVDkSkKIoRixbmecYUxgW7vGsXViPtO
         VyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870214; x=1692475014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljcwz63QBt82/HDrqpWWycZs9ottLR07mV0FHtlMMVU=;
        b=dwH2twklP2bKSW2liGjB4Os9pecWYvqyS1epeUM5M+toyV99CYnKpCVb5yHzWS9FVk
         doVyi7BFhkM1Tc2G7WUw42j3Ns1PpL/3xJkoEdNgonmQEoGuBQaELUXHMfHmqYfQhJNe
         j/z3XT0Rh+yW2dgMHlG0GMfebe7/AgXiUgrMznoiOetw5cmhaK7d2vXMldXwkDibyqjZ
         z0Obggse0trfW6X7DKM1Tr+vt+Urw1aCT4cybyF1CnGx1HT5WQ0ih9OT4CPOb1NwbRJQ
         WwccqnZDIZcWnMem5uB7JOXgBnxxz59hYd0rbNJwwdmsUTBaRmr0ou03QYsUfJ3mZudx
         jqFg==
X-Gm-Message-State: AOJu0Yzg3+XlAn3QQI4nFWSkeW63Aigc+E0aDEWhW/M2rfopjhlrPNC4
        IM8jrsGe1mZfHDZnW94bqQJCcQ==
X-Google-Smtp-Source: AGHT+IE/oG/6CUyoTG47PFAP+Byygh/pQjt6QyQqGvxBE5CNJa7bSz6ljzf9J1J21Us2eh6Bzq3XDA==
X-Received: by 2002:a05:6512:360a:b0:4f8:8be4:8a82 with SMTP id f10-20020a056512360a00b004f88be48a82mr3224264lfs.22.1691870214420;
        Sat, 12 Aug 2023 12:56:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:44 +0200
Subject: [PATCH 06/14] ASoC: rt1305: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-6-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt1305.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 59895131e6e0..80888cbcf49c 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -12,10 +12,8 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
 #include <sound/core.h>

-- 
2.34.1

