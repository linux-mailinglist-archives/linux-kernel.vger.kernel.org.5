Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2C77A215
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjHLT52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHLT5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:57:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D961BEB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff1b5c93e7so501885e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870221; x=1692475021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXJricpF9lgZYw/3PpheO5mxmeogEd16fIt7MiNI/NQ=;
        b=z7WObcqhaUUYnsE8xahVgD98J2aj80IxasZ3ztQhTJDPQ8cwcDRx6MBjNddj20RH+N
         M2mjJm+lPvW5V7n0BmVI2gDyTIenZ7eYIXV3CWLAblyAKs8EUbIsVoZvil0SdZ99tYto
         f9kzQqfb/zwtoE7KxsqeIzjN1WcYoI4+6/CL5mI6jrySGpXO3hZdA1fjbr4hF9pHwyrY
         DsDdKTHcmIcx0CwhFV6281I6vzQbzWIpWnlDy3i3mwbPBN4yD5mTY6o3cJBKgJL4LoJ6
         +o1vVSJGRD0f7PqAvtrY9f7bT7bP8pM/lUlT8s4eSenBOf202zFbU3jK9xPiCC/ty9Kq
         Vc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870221; x=1692475021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXJricpF9lgZYw/3PpheO5mxmeogEd16fIt7MiNI/NQ=;
        b=GOWRkP4Tn+0i6s0QyIJ5b/FMz6zMkW6QaGjz3PNchkjQywA1xvOvIyFjMMpIceM9Vg
         JWBFLFw7aL6cL9BKKzb+Cj5qv97aN/STOio/VhrwtMqsc6BAOnOvm1WXK4OXSKyT3c9X
         Lp9FmtMUjDxYM3Gt6r2y/S1WNWMXacEROd5HpetVm1/rx1tLd9zft69yjmcMmwpgyIgQ
         LZPlcBfzQpCff9qWgAJn8HC0Vx+wGXHbfaHXJRprbFR1+jrlnYBysod4g66VB/rc9G4i
         qXG8QoLpV6P/darYjnhpfuHZm5/LarXoAwHGlfM7cSUUgqdgAbeYFDreHCkyhrIXmQ34
         /rTg==
X-Gm-Message-State: AOJu0YzhpohUa2DlgA1M06Mtl82xymoeuoxxtEkm/HGExjSEdPR4h+XG
        EifIE8+Bt+QqYPd/R+jk0OHFRA==
X-Google-Smtp-Source: AGHT+IFscEEhpL8UYOTZOQUNTJ8UbRNpv1oL7Zrr5J2dIsX9lXyKoBIqNP2YwNFObaLML+VxpDPLrQ==
X-Received: by 2002:a05:6512:10d5:b0:4f8:6dfd:faa0 with SMTP id k21-20020a05651210d500b004f86dfdfaa0mr4323785lfg.2.1691870221177;
        Sat, 12 Aug 2023 12:57:01 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:57:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:50 +0200
Subject: [PATCH 12/14] ASoC: rt5660: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-12-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt5660.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index eade087b2d8b..0cecfd602415 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -11,11 +11,9 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>

-- 
2.34.1

