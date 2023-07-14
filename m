Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD27530DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjGNFDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjGNFDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:03:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B92D65
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:03:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so13782505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689311008; x=1691903008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tX9dAg9Z2unJC3pHf2Z5DOZUouKHxctPcJNS/6UJayM=;
        b=NDIMRZFXfKhI/GbAFRavn+QkEDqPzVXBMp4CkFHf86pBeSvyemf8lx+GUs0O3ypGqh
         Dii/aJ820X0TTGUs14N+bu5DEoO5aRoelF2zkkkgDoDzp09ZYy5o6fdC2g8rQAytazvz
         MrmtYDppmH61VZttMbX8KxfyZpzpN6smiHbtbL0b0cvmG3qyvUKdWUr4U9siA8HKKEAs
         oJImnPKndiXIObEd+0Kz00owImyj3uWSH6CjusTXAOckDRKe2c0qC/WEel2ydryFz4Fo
         P2Ns0YAoplh8FWJchQjSh3kmrIJpXml3d6J3Oga3k0A7bxMuM4yV2Pc84noKpm8R/cnK
         TSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689311008; x=1691903008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX9dAg9Z2unJC3pHf2Z5DOZUouKHxctPcJNS/6UJayM=;
        b=VrRgZp393SMDaON5eEQ9LthChUMxGiGKSRJKHQlmbEyIvFv+BqXnU2Ro4xIKA3lI9a
         4ukCHf5ir3aL1FDkaPAXgyMsgqBGF8W8xCi4hXOKPnNx0wPao9CTscRtzp5L02DwzU4X
         bgu94pkLEucV1xemqev+5KjlTm8JeRRPKQHJh2MDB0Qax52K8qEVYc0YZ5YyLNuuo6/v
         lj/SUXcrKSeGWVoje9WWR9LL1rnxUz9lcuOTCJNPJbMEaidsGv4ZjMKSJsR6hZ4Gw9jH
         SP2N3mSzCOL9PHgXlZE5B6zLNytJA7zQ9h+0PQ0jySQNXvFp791r2Gs99d5wbKbss3Ni
         KczQ==
X-Gm-Message-State: ABy/qLb+4nfXOtAm9AaK3f7jdSfMk3kezKSJa+mp3JF/PQAXaVOLUMRf
        cdAG26DFuAbaiIakkh/87pE+6w==
X-Google-Smtp-Source: APBJJlGXloEV5t6PJTFoUlQh2npgiYtXnhIvDspCbHc4ipFaroX1UaF04+28soNd3GA8b3nthzAxvA==
X-Received: by 2002:a05:6000:c3:b0:316:f00c:7682 with SMTP id q3-20020a05600000c300b00316f00c7682mr221875wrx.65.1689311008095;
        Thu, 13 Jul 2023 22:03:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b00315a1c160casm9690702wrq.99.2023.07.13.22.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 22:03:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC drivers
Date:   Fri, 14 Jul 2023 07:03:13 +0200
Message-Id: <20230714050313.8424-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since few years no one is really paid to support drivers for: Maxim
MUICs/PMICs for Exynos based boards and Samsung PMICs.  Correct the
status to keep them as maintained.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab839af24fc3..0b8cd03f5e52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12840,7 +12840,7 @@ F:	drivers/power/supply/max77976_charger.c
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-pm@vger.kernel.org
-S:	Supported
+S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -12851,7 +12851,7 @@ MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-S:	Supported
+S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
@@ -18809,7 +18809,7 @@ SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
-- 
2.34.1

