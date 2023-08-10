Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C07776C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHJLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjHJLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:20:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872A271F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5237365f3a6so1002222a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666400; x=1692271200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UVeu2Vv5taFKAYD/0MyJDQO4Vei8wwY49dAsoAUbBI=;
        b=GaS0OiypQfO7c2N6lrMtUELzqhh0hwcvcP5tbOJmrE0KkY5OemOqSs0Q/Y2HyzaZQx
         8uS94SAAXLzzHVVw4wKspvQOqjVQUFBtGgmL0J0Rp4dpwLfBL+KSrvFvZFF5oOPdqvGv
         473VAEJSejFFnkiNDxyoAzjmhzEgFTamNOJ9NT2FfsLWqjnILtLviGF+bPF4f8sTwRcB
         TfN1CVAUqxEohtc6nTqieXA9/1Gs2ZP7p1Jinz3ncUby2368+EwEvr95r7SgwfJvfTrF
         Rdydpvnv9NXV1Dy9H8QZqMaVq6BKIOAOt7sNAFkbUZNMd7htzIAPmiyWNMaGgTxX3GGm
         1g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666400; x=1692271200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UVeu2Vv5taFKAYD/0MyJDQO4Vei8wwY49dAsoAUbBI=;
        b=VvODOFOI6OeBxQGrPsPfHsN2CUQHnzTa56w0c/nmFah/mK1BCvq4Oc53qb07nDT2Yd
         FxcJbDKNFfSu4XQIVzO6DY3RO5hAMfdAZSUqtoZKNZZ9oNsDg3ECs6TvK0vpYn1fz23C
         RTp/dFOmr1760jjP/hSPk3E7xZiXnki01GwNBmdxDfIJHHDMNqT75TdK+4VtX2/etxQI
         6LMJD/PsOvI4RNPxED2HAdcgJT5pMiXQ12Ab/h1p81gvKefPZJldsa0Ut1+X98H7x6VZ
         Vjc3Kc+3nrOXYYZiLbgnooWD5bX/CB1wizTzDOg+J7CrZZuZESADgMZgYguKxuFqJyy9
         eD/A==
X-Gm-Message-State: AOJu0YxwAAX7fZ+HoU7OjZwGHZ2cXL2mBKfBedDxibXR1t4Pp9/3kwdR
        1BLIUXHbfjvI5PvSGIHUEZLZIg==
X-Google-Smtp-Source: AGHT+IE+/JXX6dWHY8t8osAFBHjh3S7EUWZJudr4+gH89YF9Ru/wR/Q59FEe5Hxs7Oi+9jjhxy8t6w==
X-Received: by 2002:a05:6402:5152:b0:522:2af1:1ffe with SMTP id n18-20020a056402515200b005222af11ffemr1797584edd.9.1691666400714;
        Thu, 10 Aug 2023 04:20:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0051a2d2f82fdsm672190eds.6.2023.08.10.04.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:20:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] phy: broadcom: sata: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:55 +0200
Message-Id: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'version' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  phy-brcm-sata.c:775:19: error: cast to smaller integer type 'enum brcm_sata_phy_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 769c707d9b71..ed9e18791ec9 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -772,7 +772,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 
 	of_id = of_match_node(brcm_sata_phy_of_match, dn);
 	if (of_id)
-		priv->version = (enum brcm_sata_phy_version)of_id->data;
+		priv->version = (uintptr_t)of_id->data;
 	else
 		priv->version = BRCM_SATA_PHY_STB_28NM;
 
-- 
2.34.1

