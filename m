Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63579AF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjIKUtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjIKIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A6E7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500760b296aso5011465e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420634; x=1695025434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/HhJkYfqyaXs9yIGYFPPzlpsmAC+qKTgrrYF36b8es=;
        b=lj0YQGFIq7FIQU2MOO5aB8dJfDXuSnTHyoMj7VoaqzgqrKe59OzG2vKsCncZmCgr+b
         neDDyeCU2dN0VF4dWOappPBOvfIvBE2r/pHrbknBSvpkyZ0wLfrydDiEA+dRlUavHxH4
         88uDXuw6FGskjVobA7Fjy8afBWi90huGWstsxjzx5SEyK65duQ0LUsF6B3hRXKN7LCSu
         n57g+G0ink+kHQMRzlfyeMo3sTF1vGF0NwZOV/5JCy28SkHqCHktGekfk3tqU4JJN3xS
         4oQYX9Qm9f6vz9D2791RsH472FIumL8xGYEovrzVacIchCvwNb1YB0hVvt9UfI2XzNRh
         jCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420634; x=1695025434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/HhJkYfqyaXs9yIGYFPPzlpsmAC+qKTgrrYF36b8es=;
        b=sDN49Pnuuh1kfwUvBBL8zicFwnRQuJGEGDgF6EMAb46f/koan+GQ9NtBBjX6ckpi3b
         K5gMAazSgexG/ePDxOvXNuI4ryWOQFCQn0/NUyZM7equNHsd8m03rf2Z7RYa1PBl/d49
         o9FOMYzd5WRjniydLqDA+pQmTSRsiqJ7/xqWSAF2LSBNQBKEW9dTWm5xfUB78pqWjM+d
         nwvI6pF/srOby2PZfFBvI61ijm8Q8c2q0TEdeOVMamzNaozOPXKWj00T1fPnqNdlwMwE
         XT2mtGd3xuNsPFzD/c2JwOcXkgV2zxlj8jGlp2eDopxhb+RbryurSC04xTQGAWDLt+ZR
         8Cgg==
X-Gm-Message-State: AOJu0YxqDhM9X7JEXtSObkeNGXGiwXHSOdH4ALZA38KnII1OcLC9ODPf
        5ePrmu3yDixXXbLykfDl57fZ+Q==
X-Google-Smtp-Source: AGHT+IE6WCFsa0bFZLixppvL9WUrXFO38to59wdYHxNCXTqD4Xc/xeONINSL8v0RojtmsjmZbNdCFA==
X-Received: by 2002:a05:6512:3f14:b0:500:d96e:f6eb with SMTP id y20-20020a0565123f1400b00500d96ef6ebmr3927961lfa.19.1694420634181;
        Mon, 11 Sep 2023 01:23:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:52 +0200
Subject: [PATCH v2 5/7] ASoC: max98396: Drop pointless include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-5-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
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

