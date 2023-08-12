Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491FA77A212
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHLT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjHLT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758811998
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe98583a6fso2437602e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870218; x=1692475018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kjlHniAc6arc0m9mehA9++EC6OU5C4FNQAGRJcfJBM=;
        b=Umz6Aba3IwiPvqp0pIvSt1/oXpJnp2i5Bvow+UDzhclwbwdPRlNYJWzyOme7HYL/7X
         xlL9i6sKFN5qorPb0c3qhz9J3ONNgBVm9BiqllFaCIy8UvdSSfT0qCFjv3eG/09nEjA1
         j/GHzBcrH+OuKH7eX64kImiWgbTKThoYoTa1bHkEJPsqkeyX5sz4xV2ANIica3lWz2Hz
         F4ndN/5oepA9H1cXff+sk6ETYlOBD7ubLHfZcdNMT9OTJ8NOux4hK4msnrnYEXU84f55
         IgtONxgnUgiDQ8lBukQj/abiQz/ZSR58N4atRNMPsFpX9hqpJWa3vOn7P4DY00z10yz8
         6QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870218; x=1692475018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kjlHniAc6arc0m9mehA9++EC6OU5C4FNQAGRJcfJBM=;
        b=IGOBOls/JDYEywSB1uhXyE+MSosLQJvxAgLvTWUy41iGnJ0g79JpVTp2noEbLrSStp
         Y1GLWgo0EMgAK+gYF2ROsDUyikkra+I5TRGKgNvP3WQd8wCZGaMtHzGym1sPvLNfWsS1
         DsC6wqyKky5Bb33z8TZc65nUHpJB4NbMGPXVo5TPDMMkQkcLgrdisftBmwGBd7fDxgra
         otO0U2Fnmcug1yAiQJcq6qdKamYCDfVkTD2f3Z171TE45UyYkvHso6uPRqZXcxBUxGEk
         8HeCzo5qiS3Fa82EBrPYITuOcy+9bBycjB9w+T2oJXy/mgKE3MGBoS3dwdKmQyxgFY1f
         d2ZQ==
X-Gm-Message-State: AOJu0YyDE+HEEcKVeSsfc5t8MFEBrfNVMLeaguE5j0/dzu4oXz05WYOZ
        vm9fJs1uGBqNrCUl7R9oLYR6og==
X-Google-Smtp-Source: AGHT+IEeqDc5TPoIkGhEAP1dF+YwTumn3HvnCWPJn8ypksCk6Ddts9ujT0t4hMTYY6mX3/4l7SM9rA==
X-Received: by 2002:a19:e009:0:b0:4fa:5e76:7ad4 with SMTP id x9-20020a19e009000000b004fa5e767ad4mr3716056lfg.10.1691870217856;
        Sat, 12 Aug 2023 12:56:57 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:47 +0200
Subject: [PATCH 09/14] ASoC: rt5514: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-9-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt5514.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b3aac2373357..43fc7814fdde 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -17,7 +17,6 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>

-- 
2.34.1

