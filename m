Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA377A214
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjHLT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHLT4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31031716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so5064119e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870213; x=1692475013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+jObdMKSESaARWvH4sYIIFj0cX3x7m2NcZ1VMPhPPg=;
        b=V4RrNVkmVM0ijTjz6pIpW/B+eNcie2OgbbUYMjk1rrgyD5OutTMoV+1r7a0C/Aap4J
         NR9SZO6fsn2ck9fkktZXZbNmmxJGtIyFBpThrAHtfafAztlxhwI2aYclAkXyBcGm9b3o
         fJyLetwaqKZBUaT+VXAJeAwtoRTOLc+zpPu7BFh9Dq5Fv/BcrY/OsXDjMQSRjlZF7wEz
         85j3KHd274cWLXS2af+2bptb0CAWriyd0ou0MCbtX2/PsO3hE2xXT61Y/m69exYA5vku
         aEDJ+pM0xbPXYDNNFE9oNXIQDR3Ta9ufT3F2ccQlVbKovcsY2X10WslqKaeS3PUR+cY4
         lB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870213; x=1692475013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+jObdMKSESaARWvH4sYIIFj0cX3x7m2NcZ1VMPhPPg=;
        b=TNVnr5voVZoXRZlj0DacmREniioL8u5CgN1REqeF56idM6p7EO9FjVlftfFIvcnaSq
         IXSuaBhFsmFr3zHOFSphSJQVw4p4DCmLAfmlhR5cx6DXLx52LzXnld9hzL+K5QC2nZDP
         O7gC8nwy38OAtP+yEZZ4EXFF0dN6uwu2I8TZILpkHw6eIDkDmUAk8H+zKKCNqrkgSS0D
         dDLLvxOY4PsXezTMZn6VX2zabnDFDPdHEEAEKklhAAKtGXI5pAB/rGOVs8GbdIc+8TAt
         2ZW7zPUMw/5yDLu9nGOElcC28oT0LzQGqlEOpLouQJmI+0GlHILQubR7/zjenXnIzSNq
         9gLg==
X-Gm-Message-State: AOJu0YwhzXb0cxHCl3Z/AAwnNw405+HV9X2OHt01OJtY1EEZkfcYsZwD
        TdPpmbtLOzBxQD/uoyVwCQpMzg==
X-Google-Smtp-Source: AGHT+IHyb1vwhHnjuIMbdJ3qHM7wISjVjYq785y8Quj3jbA+tvB4M41iQkGH+FKy9lUay4wPGtMwCA==
X-Received: by 2002:a05:6512:1048:b0:4fb:8585:eefe with SMTP id c8-20020a056512104800b004fb8585eefemr4852964lfb.57.1691870213302;
        Sat, 12 Aug 2023 12:56:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:43 +0200
Subject: [PATCH 05/14] ASoC: rt1019: Drop GPIO include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-5-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt1019.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1019.c b/sound/soc/codecs/rt1019.c
index fd55049920c1..ceb8baa6a20d 100644
--- a/sound/soc/codecs/rt1019.c
+++ b/sound/soc/codecs/rt1019.c
@@ -18,7 +18,6 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>

-- 
2.34.1

