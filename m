Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF3773CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjHHQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHHQGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A772A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:45:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso804597966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509550; x=1692114350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7mP4H675HuYuOMx1xcJqbSqbpr2VMcAkjxgMIL4uqE=;
        b=uFmyOiBdUEBJiyeNZbqa7Nlph4T2VmYGqAc0SsGJDLP6eDrmofGOtJlxEWi/kL6Nxl
         gjDU91qp+TjuV8bczjetymMQtn1SAkY1Ig9GqNla0bMuvBTX/uH4VkzKOLf4mQgn9sks
         vChW10wdP9BeZ1T0rr8G2Jq6uTfwNaOV4VApi45BaF/s9Oy5OV7NcQJiSnqRA1DjWx08
         mQyaXFLW5577IPJC17IYS96HiY4pTFGLHSF11Olcr0hHi44MzhirTC42JNG6nOCWic7Y
         G1XC5AdVNFUB7BiimJkoPfe9azOpih2142vKPOAFADTHNlNIFv/YZ8qUzLR488/H0GLQ
         5obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509550; x=1692114350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7mP4H675HuYuOMx1xcJqbSqbpr2VMcAkjxgMIL4uqE=;
        b=FOPzwuf0L6BT9bZzelCj6qeKwwCWJN8RZ7aSmsbEgOabAAevHE/PzVAVPBGmxzcHF/
         RtJbYHdcCsaSWLAi/aA07kjcNelGdBBuhQxBafGKI89PTEVYuzqpOd5SbIos5pC6trru
         2bTFIK2t8lY+ye0T5oaNk1Omd1RqFB6WQJuYNo3cyYywfoMxfToJYLMJBM5HdDt26kSz
         udaQHepd1SBIeScVyLlBeY6Dlz4PzpRggduq0mNuHydy7st+8lytK04Z4rQp0wyba2NG
         A8uglTUhRwTqp60HfgOSIKUer5uPSuyDd/+df5yckx+Dik+WLQLrci8rQVoP0M4JumGC
         g/Mw==
X-Gm-Message-State: AOJu0YyDnv2fWUJ+ebjcFg9Gh0mNG6YUyFY50pgX3gF6c4A5BBIq3giQ
        wLO24J5Vd+vZPZflwZth3llEQ3emMjRAaXKtZ+g=
X-Google-Smtp-Source: AGHT+IFqBorBvecJ4DsCotdQRzKRs6+3bXazzEJyN+B+FiwvRNYD3ybpCup1aLJlqFYk3XPz1XFCeA==
X-Received: by 2002:a2e:9e0c:0:b0:2b5:8bb9:4dd6 with SMTP id e12-20020a2e9e0c000000b002b58bb94dd6mr8345831ljk.12.1691502404392;
        Tue, 08 Aug 2023 06:46:44 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:32 +0200
Subject: [PATCH 05/11] regulator: rc5t583: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-5-939b5e84dd18@linaro.org>
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

The RC5T583 includes the legacy header <linux/gpio.h> for no
reason, drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/rc5t583-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index a5afca73715d..a25a141e86c4 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/gpio.h>
 #include <linux/mfd/rc5t583.h>
 
 struct rc5t583_regulator_info {

-- 
2.34.1

