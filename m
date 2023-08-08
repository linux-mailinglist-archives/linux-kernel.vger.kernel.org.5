Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C53773C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHHQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHHP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:59:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5E61B0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so4360507f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509470; x=1692114270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0cDrJs50zXCjDACInHgYpsbmw7IC3CDn78nE0wDJEU=;
        b=LJhpgs/cw2sl28MBPb11MYFpNbWKIdiDOTd4CGsCgbNyHiGvMnIeQJQWhHTYHQcttt
         T1MzO52JDa9XZ0kEgSiNgeOePcA/gt81IpW0S7r7M0YLH9Jzx9KXriVb/QQ6pM2rdNDh
         +iyn6/0etXnjAyj485Yyv2yhVxS6jiV3f/HTVCvYg+coqmpJWgezEdL+RjAt9hpnvsQC
         DRCA14VjMo3wrvkXqbLvUfLJQaiC/8yBzT7JFwMvlWGUu2QFShEDe/6hTi3yAbqUuWpE
         QtcwwqrD1PeXlY5/pFBsIJhcHD7PzbyfTNpP4sJTi61bITypC27DaDWkUgFEykvxf6Zk
         6xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509470; x=1692114270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0cDrJs50zXCjDACInHgYpsbmw7IC3CDn78nE0wDJEU=;
        b=BRiKvb9hGtgUvfiPNvvJyDQXtPxrYZy61dCjr63kQOU9sKNV2iBocWXRYUwZ/F7whB
         7ru4Ptyvnkz3QV7MLRGo2R9zeKLNkiaIUGvD05/HIQIP9nFdaz65Mf+9JLukjG9PixUN
         IXHol73ZH1vFr+K+kVbAnm20POTFMUdPcueN3sDJwKLh6E5SW+P/gXoxBDb/5AlMjRIW
         G3/vGAi5j2zV2yz1Z2XUaX0DeVGrOVXe/Mq1v4uSuf+8dcYyNkY7biPkTdEtliMS65id
         Hdzto2X457YRI3FA9uSp84lH3HeGpBOFW/MXuFJ+c0beDhA1HGekaBzM/WWo7JaJ2czK
         iK3Q==
X-Gm-Message-State: AOJu0YxoSjkYZE79/yUWfYKVusuwsRjmsYISMBOJKmZbEbirn0GRp8yt
        +ZSitHOnCE26lsALk+gJ7Iioa200q2fF4y/uwTQ=
X-Google-Smtp-Source: AGHT+IHyCb1MAZ9guoP9QuCWqFrH2Mfihs7/gMTBRCoMInNTntAhiMDP4HfHYPGkmdal7HBOrio1hg==
X-Received: by 2002:a2e:b708:0:b0:2b9:d074:1871 with SMTP id j8-20020a2eb708000000b002b9d0741871mr8655874ljo.45.1691502408584;
        Tue, 08 Aug 2023 06:46:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:35 +0200
Subject: [PATCH 08/11] regulator: max20086: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-8-939b5e84dd18@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max20086 regulator driver includes the legacy header
<linux/gpio.h> for no reason, it is already using the proper
<linux/gpio/consumer.h> include. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max20086-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index fad31f5f435e..32f47b896fd1 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -6,7 +6,6 @@
 // Copyright (C) 2018 Avnet, Inc.
 
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>

-- 
2.34.1

