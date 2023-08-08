Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C627747E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHHTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjHHTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:21:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8242AE0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:44:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so3373490a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513073; x=1692117873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtIG2M/ca+5GsdX8n1RK00emvWGjV3tMf5tcX7VIHus=;
        b=VtRLX9V6pg1MLxheMEDKqjbU4cOW4VDRLvR2z1bNJtgIf5f+c9yS7lmVmMlF7DATb7
         497POMDL1s6JragCdo9W8n/Fcf8x8cuGFKLRB6Tsl6ZKQETm5+Ah2AyTS9XH/jW2E4pK
         0Dm7xpwsZso0FdUYkI0WGB6Ue6+gPu4/3zD6h4JEGKz5GAFevmt998o3aC4DoV2+xqqT
         BoYiRGNmXMaLCYq2zZrkQSce18/UGpwAJm07TLPEPEFxpdTRCf1QOU3rgV97dcmpaP3X
         oqUSh4/yj4n4VeguRRxjc/rb5ajKWY9FOb+FA4ElF7TIyFRXpv7Wx9JW9mC+tjlQ9ZAk
         1ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513073; x=1692117873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtIG2M/ca+5GsdX8n1RK00emvWGjV3tMf5tcX7VIHus=;
        b=eCwkJGjZ8LbBNB1dhDcq//Doyt5MlWyKgKm4EuZpXR2u+WInMhNOrMlnBZIJGSDqxq
         ZPQKoE9iirVaco4O00RUr1/zxuTR98Neg9qdDaIcrd+MVcT/qbT8dzG2NXN7VgGMLPEg
         DGZwD9LWgtrF2ZVErLNG2o1vmLHcFym2yDJAikuxhXERLcYtFHJUJ1a2Uk++1DvqMbT1
         NmLtWswj+9UDIUTrwLNJeZWAeomXLeMBl/LpFq3qsL5tg7vnWhrW1Z4rdmgWJ0QB/J5r
         fq0+av9xKzNGyTqm/gf42GKWTxm2S8NWGp1GsvWEekt0AywueyNExP3f0bNEs5TAfj7Z
         cnMw==
X-Gm-Message-State: AOJu0YwxxbWBpUKwaeihPyMcXmNflHCybhnnepXfwD/kmZ4HvscnFAlp
        T1kmN/p0cCRnWrup/PkaBDWoIK4rFDD/mdXbe78=
X-Google-Smtp-Source: AGHT+IGabpvcf+YfqqvSp128b6pb/ZcVi3xmONq1O6a4S0szO5ZdOqerklrUaTjPj2ZyYc9Tu1UkPA==
X-Received: by 2002:a2e:6817:0:b0:2b5:8a21:5627 with SMTP id c23-20020a2e6817000000b002b58a215627mr9324746lja.51.1691502403287;
        Tue, 08 Aug 2023 06:46:43 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:42 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:31 +0200
Subject: [PATCH 04/11] regulator: rk808: Drop useless headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-4-939b5e84dd18@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK808 is already using the proper <linux/gpio/consumer.h>
header and includes the legacy headers <linux/gpio.h> and
<linux/of_gpio.h> for no reason, drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/rk808-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 460525ed006c..e65339ef47ad 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -15,10 +15,8 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/mfd/rk808.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>

-- 
2.34.1

