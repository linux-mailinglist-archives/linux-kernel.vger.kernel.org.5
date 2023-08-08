Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1995774027
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjHHQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHHQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:58:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC8213B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:43:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so1228004166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509378; x=1692114178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcDUBR/c5KhjxO4gQ1CxNRP1ojo3Pb8MjcUkheghccA=;
        b=NzLfNu/4AnzGh2kYvADUPWaJIwzxtSzpmMgZQBVD7Jj2igpU2SC1sWa3ZF9ZU0c3g1
         cHuWP8bVMyl7iTCsUSy5fUVWqUkEMegrmhZ1tF6x3XMSrQNA097everTpoYtEUvcnnKM
         ahXl7i5P+dOiqUL/Z0fATkdneV7aDSFUajlSPjblwfRD5qUSM0VbhtlCwy8Wat9z3seD
         S1vIvjcv7ERYzh7GEeopDO67VR9K4b1fuBo+sNEYKOXaJjvIa1M2j1djlJoJTOjPsf2I
         PDmdSKY5DHAy6nrLLHu2WYx7Biy5F5S9yUtLBReYyLzZSi2ea+rV/hux8pCGvMoqi6Jd
         /aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509378; x=1692114178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcDUBR/c5KhjxO4gQ1CxNRP1ojo3Pb8MjcUkheghccA=;
        b=D3/h/1i8YPKJVneY3ZWPsXVxTqIIou1EpuT51TVBlqg5/fXoriZStDExuXMczWKSF+
         Y7hOfN3UbeS5c+gIdnkFSbeavAdIn6hLYWX0M0IS0ODGB3IW459EzCC2fy6NX8QiPgwy
         e9s4Q9VVjVjd2pVx3yCWrRVNLpSjuGB9elhxKhpCXqZta6vSH+4cURnGY0cBE6zhFqPg
         W1a8fW7vk9vTKsOjKGrgwuZkIPP/njNY3MQ/rNANo5ycMK4+k9enmPNttlxNVBYHd2x6
         P0KxZXEjU5hrN0o1ulGKu01RYAUFK6UFjK8g8hKkZLe87PdBIjHXtG2TiKXZbMRXLfc3
         Lo2w==
X-Gm-Message-State: AOJu0YzZc3HBQpuRKazcA3s5/DuCWNLpE483vZAI7VFnOSkgkOwVp78v
        uAWblTyozMJEDxmGcxeI4GyouKX69kmA8npxCkE=
X-Google-Smtp-Source: AGHT+IFZRIPMWmSHgF0DTwYm5vWTgh/ZPFdc/lFtKvf3yaRIIaD/Q5hQaG6S670n+MjP6HDGCY+KnQ==
X-Received: by 2002:a2e:9442:0:b0:2b6:d0c1:7cd0 with SMTP id o2-20020a2e9442000000b002b6d0c17cd0mr2966685ljh.22.1691502400352;
        Tue, 08 Aug 2023 06:46:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:29 +0200
Subject: [PATCH 02/11] regulator: s2mpa01: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-2-939b5e84dd18@linaro.org>
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
 drivers/regulator/s2mpa01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index b147ff6a16b1..c22fdde67f9c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -5,7 +5,6 @@
 
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>

-- 
2.34.1

