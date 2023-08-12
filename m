Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6128277A209
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjHLT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHLT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:57:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A71716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so4991284e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870222; x=1692475022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZOLhHjKuDBfZLCcqXla+H1wF0I6i75in4cCXdLBit0=;
        b=g7opv1tDms3O6d0z8wjPzhnJWiuJRIYWwrt4iw6UcYJsFZ6iWBDmYKsvr6Wz+O43WI
         qDiytfrd2PAZDmGjuICIPUhkBDa+5PJwMVMYyr5nXdZn+dNZWT9VHfj2yTwNV6u8AhpZ
         Hjv/oldOs3zs2CclIK5VUe5XfY2lcD19eQXJpL7n9VfmOc1Rc+qJU4/z7V0pVcc59vFT
         W9GKYcPYYEqSimXzxoi2l9XFcfL/Q44VkKkjt/6fPWCLAW9jXdGoe2hXiyGSPoRftKFa
         Jv3xfcS6uaHryMdUxzZLWasyAcIK4Lxsq9djYxgVMVUWoSkN45NKEDK4egC0JyAsZ7iI
         nofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870222; x=1692475022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZOLhHjKuDBfZLCcqXla+H1wF0I6i75in4cCXdLBit0=;
        b=SPYaJdmqM/GQJjUQr1OR2wTKQkx4e7RBnIXuDA2GnDGa+pfWSyzDv6UeGEOXka8Wc6
         Ci04wiOX35G1GDActXtWsqoMCntR3Y8kQqj0X+qFa9soALoDNxqrsZcjkvzOpMn4BGvF
         eJbHSPSK7WFNi/cWGAKPnssvnN1Vsl+owoNRWtfTWB7COv9VzBa5K8gDAyqh6ufVFWXI
         jOgwq9wxu4H+ad+BTJNSsOvi3LHFSg9qRmGwR0fVq/Ph21Oqvv+bLYVb988W3WV1/10P
         KY3Fkd4WU2tqSYLgBGRqMYKQt2e9bB52SqG2I6jKzTSXdgbSfrMpPAM3K59Lcgo5997g
         7XZw==
X-Gm-Message-State: AOJu0YwHDXDjvOchzOPoz7cQm70Byn9YjyPWEWzSIec+cq2Mxi8bGs4t
        cNWxTD1wyNeiTzhthyDtX+stUA==
X-Google-Smtp-Source: AGHT+IEu19QYx0jZ96LEO51YJ8uVpT9B2qofHJqWU2xiDe2qu1kqFFU+8ncZ8MPdCJecMD3WQ7lrBQ==
X-Received: by 2002:ac2:5452:0:b0:4f8:4216:e91f with SMTP id d18-20020ac25452000000b004f84216e91fmr3153918lfn.63.1691870222301;
        Sat, 12 Aug 2023 12:57:02 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:57:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 21:56:51 +0200
Subject: [PATCH 13/14] ASoC: rt5682-sdw: Drop GPIO includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-descriptors-asoc-v1-13-eb4dca1f68af@linaro.org>
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
 sound/soc/codecs/rt5682-sdw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 67404f45389f..3d13ea74b074 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -12,8 +12,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>

-- 
2.34.1

