Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FC7747CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHHTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjHHTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:19:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635F3DE1E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:42:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so9735409e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512957; x=1692117757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1Y4agTqAvpXPwjQ+6mnmjNw7Ui1CynMHOt3cuxZe6w=;
        b=goAeGa6Yg3/68Kr55Hh73f1IgLgoXWHLn6qGiSuL5fNktTT0vwTU0m26Tu+pRtBj9V
         vflVRU8ZiDSIgMHleSZa4nXpKGrhJP8keoB6gFOO6u8nrp7U0oFWlhTHDDnCfuYi8T1h
         uGwnFC4ChQb0Rmy+1S05hcFvpzwRlOeKrCHQ7dqTElWAiVWVKgIV9C6vUIvN97YOWh9G
         3he+aldydBrptgv0+4+AwmjI873SpYb8FrUO9JNBq4naC2Mzw8dyLmxEPsNUVKGXpCyw
         GuuPvwI24tSPzbBYQNTJOAwpJ5CiNU/F3fnjEtG0rN64tz5KruOkoka0h4CljIKTgjCi
         9wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512957; x=1692117757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1Y4agTqAvpXPwjQ+6mnmjNw7Ui1CynMHOt3cuxZe6w=;
        b=DsXR7qWC7U+toYEn6lKsrJws2z6VB3dAc1vmUNfwKuss600SVVX8MB0jI1TYYHbgW2
         6BnPBzxNyMIAmxaQMj+6/UwCMFqtdBtkBHygay5vf8H8slB/gdEUy3WMc59vIhig80nL
         qlLgkAy/1YBG5kQJJb2rCnUnPZwmb+NAl/A9149kLeud+7r6EMMc1nTb5anHlhHqwEWH
         crAC1gWdXvq/Ot+1TLZSIgxNK8z2Ugb4Ry9+3hrbcE0gT7oBqVkrsxidSr79ftZxJ+yn
         RsxfVXeJBa1gg0Pqn/nravMmw+/WeCrFOsaMxbCDU9tNcAhggJohmWwgd5SJvbAHx64Z
         OQyA==
X-Gm-Message-State: AOJu0YypKUvjKDSL+7lcgoDiPthbKEle6u8H3+XDyBpldQz0HgKwtGXT
        m3UDehVJBA837Oea9P3zDrACR337R8lGyN2+il4=
X-Google-Smtp-Source: AGHT+IE0omUPskRY/uk1H5XSLkdMB6vFjj8UCg/c58mkRX+yOkrTBA0j/8iJ1xj+dfPUVFqUwwFdrQ==
X-Received: by 2002:a2e:990c:0:b0:2b6:ecdd:16cf with SMTP id v12-20020a2e990c000000b002b6ecdd16cfmr8260383lji.40.1691502401865;
        Tue, 08 Aug 2023 06:46:41 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:30 +0200
Subject: [PATCH 03/11] regulator: rpi-panel-attiny: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-3-939b5e84dd18@linaro.org>
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

The RPI panel regulator driver includes the legacy header
<linux/gpio.h> for no reason, this is a driver and <linux/gpio/driver.h>
is already included. Drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index e9719a378a0b..949849baa7dc 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -7,7 +7,6 @@
 
 #include <linux/backlight.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/init.h>

-- 
2.34.1

