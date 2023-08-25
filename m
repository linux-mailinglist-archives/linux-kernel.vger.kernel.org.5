Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB07881B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbjHYIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbjHYIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1471FFD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff88239785so973939e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951135; x=1693555935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl5LD8wtUJwzoyPBhKwaRw4zVOgRkHeCisg4Hejkfc8=;
        b=UE6boKGPVqfXjOj6kezrHZuNuqoenlcbBk1UNq75Dzm0g2Pi9P0X9/2H+ehfTwgThp
         VeDtlpy3T7kyjtfxQ49VGYrCVg1ZGDaZYxuP7AY8TpexJxy7Bux81QenPI11jgpmOQQB
         JVxSqxJJEjUe8HksIlDdkS5iLxHuE6B7tLGJJomdLR82bq0GVOGDYZHgkUOArZcfkJqQ
         1Wuo8wyJvkN/8Wj4DI+iLmCefZmkJSf2KrxDV3tY21KQxQkKDsCm3+SDcZv4Ax2HN2rW
         LwST9/gqyG3fK33e++9Rc6bfQWz+d4ZzvsxL3QMoUnToF6BIENTY6o0X1JPUvmD4y5sO
         UR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951135; x=1693555935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl5LD8wtUJwzoyPBhKwaRw4zVOgRkHeCisg4Hejkfc8=;
        b=iXs8y2N/XswyyKmpYbdlIr2vRlli2Eo/S7ISD8LBOYVUyH3Xgc6Ll8IaoHKqHYAFud
         eoFWzVcbjODXqI85gqRO4hN/jzQva5offdM2oucPyduIJNAbwALbNYJaCQ77zrJRFI/l
         6wC9cBmybLdEgz53EYTqjTzz6zgl1V7VXmnjNGITYDYDo9tRIRM9HD9cnYsC9xwFBYdU
         ecUCZq0CrPsekJUbBWU+KTHjEvoNkQyxpyX6LxivE8xzsU6l883L8MfQ6+alh8dt6Veo
         TA45ywzIXUZ61CjC6YB+vr0LUiuNeZH9WSFILeTUZAPSjR2sNIoIlrEJwxM20ENBMFKI
         IUGg==
X-Gm-Message-State: AOJu0Yw893BL0HD4hnjIYgdXGJ3B3De7oodEt44WGmUpLHx7c6U/Vfz0
        dr2fR4aY29OfAuBxv9ZY3XVPKg==
X-Google-Smtp-Source: AGHT+IGxHJkRNODVm8P/TbKsQyAV+vSBwvi23v8AHQLwDxjxd7+pzwYP7Kx6g7WRigVcKLEdglU1zg==
X-Received: by 2002:a19:6451:0:b0:4fb:893e:8ffc with SMTP id b17-20020a196451000000b004fb893e8ffcmr11486265lfj.17.1692951134839;
        Fri, 25 Aug 2023 01:12:14 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:12 +0200
Subject: [PATCH 2/7] ASoC: max98357a: Drop pointless include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-2-b212292b2f08@linaro.org>
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
 sound/soc/codecs/max98357a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 2a2b286f1747..cc811f58c9d2 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -8,7 +8,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>

-- 
2.34.1

