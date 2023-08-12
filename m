Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A977A20B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHLT45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjHLT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B1170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe655796faso4877533e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870212; x=1692475012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A288uWvza8eejmp10gXkLXEXmbjFh4d0tMdZ3gsN+gs=;
        b=frhNXcaWs5q+snf9myqLUyER93PKuzPFFDSAV/KOAW1npfWjJQnr+pfAFBJdvldRW7
         C3QecsstVixY0/MF6imRDUPvKVh+KFv+nbwmr5TDqrk4moYIT6sqNwJ7B/fE/1xKyJRI
         LR2jfdfQfRUF7abUzMJYevz1DY0+XyE31r79g42S3DZGblB0JBi7345MHViJtBVt4uD3
         3dMY72t/3mG3xJI8j+zQR9VCrWyuFxWddDZh0qXWlIC3jTuag8+hKyRzW3+kzF39Ff1E
         RO01fdmb8zvlDYizZkt544ZA7L0Te7OjtJWX826EtXtJXwSFv5TdW+7KGu0ZU5zVK7uZ
         EhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870212; x=1692475012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A288uWvza8eejmp10gXkLXEXmbjFh4d0tMdZ3gsN+gs=;
        b=gcFsIbt5DLwY4QLrYXb3yXS2a+7Ig1hyMFVbIFR1K9bnHjH2WI5PeuVoUTaCg2idBo
         cNC5Og6f4esDVHqRmHC/vAAnaaX6buaSMkrmYSsdOE1xiHsp88YzOsqYYeIrITIAotc1
         njzEBkFu+04Gsl5I4kTvYTKsGiVctn6mNQDHzy9jpDzcUhGJ1TzcH6utgDVNOWA/9MoN
         hSjDmM7ULy3FYfQW3X3kBCIiqKZVBR+pBVASTbKcZNp22oXQL9au7N99Ggb9Va0UAVs9
         Galcvrae27Pt/PVMP0AqCsg8yoKDBjKz5Ord03wel3Aaik5Al8D64dSln9sQXzCWsN1p
         521Q==
X-Gm-Message-State: AOJu0Yw2K3Rjns4o7zjc1RbbGJhROUKJyUjuvzHESLeYz7ZA7FUOw7Sz
        l/iZbFp/qDnDiCQIQJPPQ+MJBxgzhiXnfmrAihA=
X-Google-Smtp-Source: AGHT+IESvFQDyknsL/1Q8llGhTwhb3gq6hbf1VZM6TbirajqRanWcvi/ukFP+nvL5O2jiF069jpdCQ==
X-Received: by 2002:ac2:5303:0:b0:4fd:fadc:f1e with SMTP id c3-20020ac25303000000b004fdfadc0f1emr3238735lfh.44.1691870212048;
        Sat, 12 Aug 2023 12:56:52 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:42 +0200
Subject: [PATCH 04/14] ASoC: rt1016: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-4-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt1016.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index b1e69fa290b2..919a1f25e584 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -16,7 +16,6 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>

-- 
2.34.1

