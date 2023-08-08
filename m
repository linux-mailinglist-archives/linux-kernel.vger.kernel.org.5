Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD50773C05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHHP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjHHP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B85FE4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962c226ceso93352321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509447; x=1692114247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXrzYWYweDcdHrf5UFjLFPgu3A2nA2Ia2fp24TPU+2A=;
        b=em0cv0h/lQDx0YperzwvClLTD7o0T3uCzFzfERurmeNPkJ1E//4/X09K8ZM1NQHnq4
         bQ4ZP8RaGCJ/TRGkrjdN7tlNA4QytAwxLerpYSIl0ye9s21WWw19kIQv9zrRanFJiMuG
         aclVYABNoNR4DKy+m1KyPaPLr/1p55qwVhBUuPUrWGRzh6L1bE2u3rhnVoTuoo6J87TC
         fTC2DD1fq85Aq8kFRK6pIviu0QFXy4twswVZM1z7MMs0pOOHHN7BljMhmu55uwmDR49V
         FhC9Lc3R7WJ7GKlmpBV0NsX65F96Q9l6QTQdIXZpNhtGPHvTWaFD3YMoZZvURRUiZfwi
         9cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509447; x=1692114247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXrzYWYweDcdHrf5UFjLFPgu3A2nA2Ia2fp24TPU+2A=;
        b=AQqKq50GTOAYouYdcfxj5l8FP6YGn4BZskFgLHj3jNJs4okqjBuhwiAgeT737vUdto
         4NeUgVsTraE8jr8TZIzYeBnf1UrmA7U0c35ObLikgxqTWOKlWd5hlD/2XnjOfBKEXzA0
         MX4816K5gQXM60lJMqiGDY7vYGhv8fIzRwJ+G4RlQ+7HKT1YX62bCVlB2cJ7Y/u0pyjU
         VdGDKY4tMxfKlc5JlWdW3H6sBQhkVox5mLQU0A3i3786VfgUIpVXv+e6AgFKgfaw/cW7
         weMsMckfiwidU5kdZjZlnhr9tEQ3dICiXROsDkRQkoGw/B72ZsvDtloNFLnKekXqcn3f
         zTAA==
X-Gm-Message-State: AOJu0YyM4+suBGh2m0rxr/6AuzneP53g5eDft61DxHT4BQDHprAJu7jf
        xDf48/g3zZPT3PLWxlEflwsDl09+6KwWS3vzHPE=
X-Google-Smtp-Source: AGHT+IEowhkuCmUF+r4Qwu7Ea/j6SLAKl0ohXdiWZmoM/iU49rY/8TQNDS4E142VCQ8PM8iR2Ecgeg==
X-Received: by 2002:a2e:90c4:0:b0:2b9:615b:39a9 with SMTP id o4-20020a2e90c4000000b002b9615b39a9mr8639502ljg.52.1691502399150;
        Tue, 08 Aug 2023 06:46:39 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:28 +0200
Subject: [PATCH 01/11] regulator: tps65910: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-1-939b5e84dd18@linaro.org>
References: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
In-Reply-To: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS65910 includes the legacy header <linux/gpio.h> for no
reason, drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/tps65910-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 2a0965ba1570..3a3027e0b94e 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -17,7 +17,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/regulator/of_regulator.h>
 

-- 
2.34.1

