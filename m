Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD739773BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHHPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjHHPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:54:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E259CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:43:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1339195f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509390; x=1692114190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUr4rBKoQ5U9kNDxTC6J3Fd6dDx63tGiQB8aHXquZB0=;
        b=k1F1uonPED3qVJKABw4VSZxF26Pn4j3rz6tC2GvQ2dbgHYdhCnUulbWD12N2+oEUyb
         mwZ8/IUZE6UhIuC3GDFitw2by2fLEkkIkzAXAywA/N3V1LfOn+J2Z8X/XkHbhI0te1LY
         DsnpF49kttOaSt8aCkL7hTjA46FPaJom7duMkdvzxza87mvcgNI5x1+saW7n1KqIzrFg
         wleD9S/CJ4kkL37t8YMhucaRgunHxQDjOayBDpu8SIKUA/sB1K9M9WX6yYkrOL00xbGU
         J8TapQ/ZpgVECPnXFrUiFUqJrVaUeHEZ5u+jPbpJUeXz/+rmvpCyJAHevh3KFbXkyG+P
         jCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509390; x=1692114190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUr4rBKoQ5U9kNDxTC6J3Fd6dDx63tGiQB8aHXquZB0=;
        b=W0N+NdqB0XuawK6MpM9uCyRBGsSsuoyxVxskv7ArIJfMI1gnO0ETWvaGlyW3JjoHZV
         gWoysktyc9UcOJqJCDjQmHLAgyrPDCZ7/T248h41D5+9wSvwElODOU6nQD7D/WDuTfVb
         YB484sf+wb9FCwRRo/kVLfcSzTODVhppZfhcpioEf93YpeLyFhCzar0l2NtRymUVChx/
         V0QHMR+610OhiFRxD+7nEPVb4ZA+xATdjMHE5TbuOsr5SlB7Ip2UmSl7RPIQyaTR+MyO
         2gxMzU9frqEjxqpLVSggIPn1CSWq0CCQr0vnsseIEccveoVGVBjIfnRqoPiW447FY9fB
         WhqA==
X-Gm-Message-State: AOJu0YwpVNs4kbRzkcE2b7/gk2Fp49IVNM2ExqeomJy8yMICnXmAq9Z7
        no9/+W3kUvI3trHNFwn8HtSsjXdvggN+7A3y4yw=
X-Google-Smtp-Source: AGHT+IGl6ac+w+vJLfJZuq8P35/Ynv+o1liAhoqzrNLA3A9/ISpnNwHIwbTBb6DgRgGMJoZAmBq78w==
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id y15-20020a2e95cf000000b002b6a7635d13mr8927600ljh.27.1691502409667;
        Tue, 08 Aug 2023 06:46:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:36 +0200
Subject: [PATCH 09/11] regulator: lp8755: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-9-939b5e84dd18@linaro.org>
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

The lp8755 includes the legacy header <linux/gpio.h> for no
reason, drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/lp8755.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 4bc310f972ed..8d01e18046f3 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/driver.h>

-- 
2.34.1

