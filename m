Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BA777543
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjHJKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjHJKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:00:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6EF3A9B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d43so6429895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661592; x=1692266392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJXvTg58XDbx4i4A8NrA1fC2E4j4PcqR0iCH6KEa268=;
        b=XKMjJDmMFUurPthBODl+2KlNLRPYXp0+KFyY2I0nZpzv46ZY3yxvoRHCZN1uF8Z0qc
         rO5a0FBDVJvowNnwdG97IzkweVNR7xNg07G1a5v5O5cqJ1zNtyNiFENJnyGMVGADfTY5
         rsAoPqIRDxI9TZIMGg5b0bOT0Nr01yBllk66CpItzTI6nBYOeyv05OjCCuA43MsZOSX1
         ymHXT8nnAhJ9C3z9PSma9zOK36h1Rk/UtnqewAP/308c8C6ZzB1x7ELNhJoOg7snmPea
         idYVj40m4Orzjk2YXhB6svg6za9Q6OLf3cjQqJKK5r/KUnP6s/NrnkVrJyFJaAQKg1NH
         nRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661592; x=1692266392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJXvTg58XDbx4i4A8NrA1fC2E4j4PcqR0iCH6KEa268=;
        b=AJaB4ORw41xmNY7Ngl/eRM/jgaKI6/4Qn/f/ehrUZpfZXAZZdbaWGeze4jubqLz7Yt
         B68dtWimcwBEZUbQDXvhq0sjY74JhhU2P4g0fRjMnHC/bq/qA06zj9Nx0SBJKagWMqnL
         8Z2b+PQAPmbhbR3NJUSP0KwxXRCMDA9/vX3Molpv8WqLLdODCvzMEWQ6Cmxwf3FGab33
         YyDDOxg6JKNKjTINSJ00Fxc4dEbd8Rp6zd8yuVWt8UbBVHjinZShnsSk/DUk5oZmDBue
         iVsz9oZPoIluCHoziU9mdgGfeDUcT6C0eXzjRXWcw0P/hhlkfsaxPHTZis6ol0BNziw2
         QbHA==
X-Gm-Message-State: AOJu0YyxTeKke6IGarZKfCkOjFkC9ZbTZ3LSpghu3BgoJYVmQeEvRDk/
        pw0P7BLky7aiEpLgoa4QFpjOXA==
X-Google-Smtp-Source: AGHT+IGd10fu9EAcIecdqEAWBZhHVO1Yz+JANm/al9RrEnhLlQT/PNyBInSUk1GU5oE1piekumI+xw==
X-Received: by 2002:a05:600c:2113:b0:3fe:1fdb:cf5 with SMTP id u19-20020a05600c211300b003fe1fdb0cf5mr1652257wml.1.1691661592083;
        Thu, 10 Aug 2023 02:59:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b0031455482d1fsm1640069wrn.47.2023.08.10.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: mxs: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:59:49 +0200
Message-Id: <20230810095949.123473-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'devid' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  gpio-mxs.c:274:16: error: cast to smaller integer type 'enum mxs_gpio_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 8e04c9c4b5a2..024ad077e98d 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -271,7 +271,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	port->id = of_alias_get_id(np, "gpio");
 	if (port->id < 0)
 		return port->id;
-	port->devid = (enum mxs_gpio_id)of_device_get_match_data(&pdev->dev);
+	port->devid = (uintptr_t)of_device_get_match_data(&pdev->dev);
 	port->dev = &pdev->dev;
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)
-- 
2.34.1

