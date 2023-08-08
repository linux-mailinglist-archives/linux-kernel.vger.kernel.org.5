Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFC7748E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjHHToi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHHTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:44:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9E1159A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:47:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so40081675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513254; x=1692118054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+dlxZR3XfI563ojSxefCjRIUUjTHomDfo7z0fT83jY=;
        b=q07fediRofco+Yvcy6U1DWzgPZnRf250OwWYV6wv7ZtUdzWbtCGuL5YVPZ6tFkh/QA
         AccOWezxyrGXKitrrnN9zOtOTEsHWLoOjBqaPx5bDjog8cJd+PyrTg0h/myk2KT/bYKc
         2vXYUnDKUjYCr8LIcJ+LRhoocNIH2HLEMjxQGJ680g1evwSLcZjTnHibxmZN5EDbxwJ6
         h+LmB3Nl7A2Y1NNO79mvU6q9/mGnAlTGIcfCcZG7hLgVYTsiO2suSHFQ0C8yZOwFBaE2
         pgpiHWx/7VQt+thH5v4yQFk+/GmlpM+nToZFxahhu7Io3ZQTzDjN7ZJawxwiip/75VpN
         KDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513254; x=1692118054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+dlxZR3XfI563ojSxefCjRIUUjTHomDfo7z0fT83jY=;
        b=Ry5SYSxeDqlnTp/oCkY4x9o4WPDBdB/KOjppTEllMQaZnLPbItXntr1kgjaRNwL24R
         Xa6f58GdFCMXs4bai06WozrO1AgRCu0mAlfy6A7rXHCDD3Mc5M+F6o182yDLVOc/1CSX
         sXHnlYjIovRn89Va1F945tDmmNt99V0EWMkGM8tcx+mD8wloHEeTNGH2MjWBtC2MS8eT
         w+it/idInFZLd3shKMe5M65QwXVKCDGUBkX3Scj3iGdzQgFLhgp6saybDk/9vzmK15/f
         xt9cE8nr9VSVSKYFlAdHu68RvuJ1GAjsRhkd97C4274tbiNIQCMBRj9E3zJI3BqYl+Oh
         7eKA==
X-Gm-Message-State: AOJu0YxgdxFnzgcuL3uEDOMvtBVX2JDBNeh4/DS8uj1dVzfioFPWdE/O
        CX2CMLnFmr4oFNH61PLUSoZqBPfxBgfbavZwU1o=
X-Google-Smtp-Source: AGHT+IE+SDMqqQOfzDMcBQm6Q8z18mxaHPEwNvAM53y4c2JzhwsSdcZlgBmTg4v2rNjwyQRUpQmonw==
X-Received: by 2002:a2e:8791:0:b0:2b4:7f66:8c92 with SMTP id n17-20020a2e8791000000b002b47f668c92mr9274596lji.31.1691502410752;
        Tue, 08 Aug 2023 06:46:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:37 +0200
Subject: [PATCH 10/11] regulator: bd71828: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-10-939b5e84dd18@linaro.org>
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

The bd71828 includes the legacy header <linux/gpio.h> for no
reason, drop the include. The documentation mentions GPIO but there
is no usage of the GPIO namespace.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/bd71828-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index f3205dc9d4fc..08d4ee369287 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -5,7 +5,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd71828.h>

-- 
2.34.1

