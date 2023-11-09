Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF77E65EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKIJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjKIJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:00:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BFF1FFB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:00:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so10231115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520416; x=1700125216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITFrBsMzRnXjAnS6fzAeCUU7VFisCXzwG4lcariYq7Y=;
        b=DLdP1MznjYD0M6Kax+LrZJLSqcaoRlJPXQ2ogem6dIOnDNBMqDumAMBWKrSH0y/DiE
         aSHehkwJBBs1gOo0BD5wdUu2pW3OfD+13qzrt+r+U0T4k31WZup5bixyWbbH34pZqK9F
         sVBzszD17XtJFxlBGYiyuQa9aLaSsvq2Pd9pz99CUwEDDWE/AoA3zUwxqh6vxCixxgVO
         LdcmBMYIzWhNNMiRit0PV6Sp6O4fmNue1QAhkzsn0O3nzOh4zyHYHDtRUnT0w4IJbamo
         IpEHULqa0U2Z+LxvODpi5yfI4vOaY42NSPXSnG75NelcYhRq4SHoAumTCfYeKtD+wZos
         Io5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520416; x=1700125216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITFrBsMzRnXjAnS6fzAeCUU7VFisCXzwG4lcariYq7Y=;
        b=l7mdgA77EPnHA46fNKiZEbxFfAHXasp8jR2nObNXNV2H4YlauH7ZB+0hl8Uia8h5jX
         QdoOpYZ9ASEwcnHZr1/iiPu3VewLZKsSpCOhO75cnHifmTfNVJJw82RhREWKS0zQ+8Gk
         dSk3f7vwMw5uSCDd8PElu0lVqzEHGYeV7O7OnxvCH7PiknQEIBb13N89ZRArcLe/wuVG
         3iOg+EplNOorWcMgYe+R0pCoSrSbuJLdBVxGF2yHHj1+3ikSG8QvAy3mibDkxTEb2vXT
         UkvMkqctkxDPXrrOschShAwUhFC+5GdnxRjzZlq2oxNl0m2AO6E3nojBK9aCOazHBwxy
         FWRg==
X-Gm-Message-State: AOJu0Yyt8kyf5cqTAIYX/mFMUUxZVPkHgwL1kwRNRWFS0lTqOgU0OYbD
        2AxBAnioEBuQTnEnML96/D5TRQ==
X-Google-Smtp-Source: AGHT+IHjO+bTUUKrJCY9qJI6PbshUNq9k86eOeJoeaw8Z2cXsPrb59IOUhiYM5nWZGSaAIA4THxi5Q==
X-Received: by 2002:a05:600c:3548:b0:402:ea8c:ea57 with SMTP id i8-20020a05600c354800b00402ea8cea57mr5581601wmq.7.1699520416613;
        Thu, 09 Nov 2023 01:00:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0040472ad9a3dsm1428484wmb.14.2023.11.09.01.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:00:16 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Nov 2023 10:00:04 +0100
Subject: [PATCH v8 03/12] dt-bindings: phy:
 amlogic,meson-axg-mipi-pcie-analog: drop text about parent syscon and drop
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-3-81e4aeeda193@linaro.org>
References: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
In-Reply-To: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uz/zvzsSZxXVZUEtWgeIKFxNonTPWkXwn8B0J99UAIs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlTJ+WXcjvLMOnn8fmBl3USzfGqu93t/BCoKbOlBPn
 Hv552+qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUyflgAKCRB33NvayMhJ0ee7EA
 DB8SNulWBCaChemsw6runu8nf4gmvFIJZoGuRwt/vHyNwD1V0VTJBsWBMA5V5Gh/nfb+7oaE30EMuI
 3q1gYVfp9ISlsFbqq3OWfgvUlITVjBC8kqfrJ0+ZWN7Rhyptjba41o7IckERz1gzsgU/cB2ASy4fuq
 +ysDaWLeNJR2G+ZwZOeetPzp6tnRDdSdMbSyOtKS0mMl93VLzFb226XvQ14IK/zcGuPVb1YY6sJqi5
 Gilhooh1Q4Epynfu7v3gJ7YfgQt3SCfaoHllwFtsfP2Owe6A6Iasj+l7cB/CMIACS4jSZacvc1aJsK
 4EGeLSO6ZnZ9mpbw5FCwspuBh4Mug/Wtu5oxqbTB4BqA6jwfrQzrLc/70MauDw0sSVa0EMnv/UmlGl
 SdHPs88PTWV4GBtPdRKUSDJNQkqDc/EyGJ1xhK9DF1bnDnaQeAqHkLuUCVo80qwp5Cx7GZ00w62j51
 UwAOncWLeCYvpkOKKeoGj17j9/hLce6m9f6l6RRM6FIb9GC7c5Sg8/xpLY3UBafFD6djO8MXccAUCT
 rqpF5Rj2zS7K6acr7tA/a8CXlSfD/Md+tw6hO5qEG1vbArWfnUgv8NdVyMghEcXawh80TH4+gSCPmC
 QAr0ywKT2RjfuzCynjsFZutbI2JAVasPMsnmHJoNl+baRtCw7d9dbdGz70iA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this bindings is referred from amlogic,meson-gx-hhi-sysctrl.yaml, drop the now
useless description about the parent node and also drop the unnecessary example.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 009a39808318..70def36e5688 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -9,16 +9,6 @@ title: Amlogic AXG shared MIPI/PCIE analog PHY
 maintainers:
   - Remi Pommarel <repk@triplefau.lt>
 
-description: |+
-  The Everything-Else Power Domains node should be the child of a syscon
-  node with the required property:
-
-  - compatible: Should be the following:
-                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
-
-  Refer to the bindings described in
-  Documentation/devicetree/bindings/mfd/syscon.yaml
-
 properties:
   compatible:
     const: amlogic,axg-mipi-pcie-analog-phy
@@ -31,10 +21,3 @@ required:
   - "#phy-cells"
 
 additionalProperties: false
-
-examples:
-  - |
-    mpphy: phy {
-          compatible = "amlogic,axg-mipi-pcie-analog-phy";
-          #phy-cells = <0>;
-    };

-- 
2.34.1

