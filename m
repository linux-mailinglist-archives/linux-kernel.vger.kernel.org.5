Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C57742B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjHHRsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHHRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:48:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF652631E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:21:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bf91956cdso768995866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511654; x=1692116454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tJ6rclTR0PEh2oroSnTnDtEG+/lNahgfPTnucDt2ik=;
        b=NIG7Ucx6yPsI4wanRi+W9dyUjQ3VzkdIhC6btmvukucrAJmgoEz0ZvWlVYeaYiCV0V
         DusCoDN5dCvT2qTEMvqRUkKCXniHZY5o9nWPfj2hT/EAhISs3PWzmCNXmK2yM1Z7n7QB
         tkeNf642g/kbisx1iYts9D0t9ZJQpJEZqu6SPb8ab28KNcpeKWQ0NrL9npI3/iGaoe38
         JGux+FR2zNuR0ylUFYQEhV4AWf3TTIgPFrtiKV6aRT4ox92hXApM7mSD8jaLfCyDsOWe
         PCis0gpYoYOUvcskiiNo/E1gz+BvzWSIDhwOs57xCpk3DzLnF/SV3NoxDMzBEgGpXVeW
         B+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511654; x=1692116454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tJ6rclTR0PEh2oroSnTnDtEG+/lNahgfPTnucDt2ik=;
        b=DnrXqa0udgq4AFt75hjiMHunz1dNjx20jurrmJUPhy+Du7ZcTECoBJYYoM43Lew/yd
         ag8MkDt141uMr1VlS8t8ofjp6G1OgPaz0uhPVOW81cVbnor/Vulx9xxFxoMvH513zCi3
         bpOTrzrg9YrUhz3tuzN6Sd/u0zWJKDLkLaN0g7hMa8pR0hURa1IUhIStlwtsJ5mNR45J
         4UVxSkdJlK3InSVEyJbHsDD6Bgueh4k+5xs4wUC8czrcfVv/Omky3jYUCElgBkg4uLh5
         KKWo351QOTtidtYIcGS+cGVpgoHZWicWGW6TKiCGiZ5ubkzG1TbQDD5b3kbkI97YroBc
         Ri/g==
X-Gm-Message-State: AOJu0YyGQl/6yW4gOZjqVeFIW4uAZv+dqz0jpfA0Ugwf5XUXxEhxXH4P
        cla8ITdhwQJVpnDogOxvn1eNmt4/wNcDlPKuspA=
X-Google-Smtp-Source: AGHT+IFYJ1tDnISQpqIa3O1xFstJdgHXSmoJBbKAjvv0Omwmg90Vc69nrF9vgwo5e9S+tacn/hSCZQ==
X-Received: by 2002:a2e:9b01:0:b0:2b6:c790:150a with SMTP id u1-20020a2e9b01000000b002b6c790150amr9582164lji.22.1691502405476;
        Tue, 08 Aug 2023 06:46:45 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 15:46:33 +0200
Subject: [PATCH 06/11] regulator: mt6311: Drop useless header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-descriptors-regulator-v1-6-939b5e84dd18@linaro.org>
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

The mt6311 includes the legacy header <linux/gpio.h> for no
reason, drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/mt6311-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index b0771770cc26..63a51485f2cc 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -4,7 +4,6 @@
 // Author: Henry Chen <henryc.chen@mediatek.com>
 
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>

-- 
2.34.1

