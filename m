Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA58136C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443618AbjLNQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:49:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DA121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:01 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so925119066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572600; x=1703177400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2Wt9fAXkZ3ocbSZ++hiJKJPMhMtN2kMdg9DBtyKus4=;
        b=UcwtWV+WdTMGR7I1zeia9qz89u1Tqwpuq0w8TDU8jeNV4CVsE5whVdEiyrWP2URiFg
         LGSKghcysSV5MbK0ttLgcqjwSUFTmoh/7WZ98M+Q0buhy84Md7WZIqc9QKDKbW/1DKYD
         6Tor/KI93QHGBjzBZ1mru+1ZWNSw6GGFYZsNcnPtsxx/jTEiHuDYZ8T7r9uDid+v9ja+
         088CszN5bSTNUa6XcS+aP3JBaGtosqY5+ARyGmnrUY1ABjlhLByuBibOGE9pvqhvSFaH
         X0lJer7J6u2a3LKAhVzAyr6n4AqkFJ8DVddn7GpM+ETfPXSb/EuqzuSK68eUz6gjHc5t
         Rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572600; x=1703177400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Wt9fAXkZ3ocbSZ++hiJKJPMhMtN2kMdg9DBtyKus4=;
        b=GKlnxq7cfGBdf7uybYzxFAWFXdhBF6KTEBXj3d19+7RJm+YiA1QW4QiBy+saTd7yv8
         M0sNZOKDPkgjurun2JrSr8kMfueZWZcy81Wd3jzkA9bzyCClH+N+j57HLJvwTMlJwwRY
         K2yqTn+qPexOSt0wB2A5y0TZbdQ3vZMfM5bGAZqZWJx/VD38kg3l8LjJ/qzD6kjeU36O
         VAkSeyiNRE4ZTCe2+ZePvt89Te8PUAqDJwMZZ6x1nFs7oy6q3GPD/eK4nzHoYfxG1pXx
         X79j3vmhMXIRMggLxZbQXavjWr2zcKjPsZxh1lLYLpRVbfHA0leigvcjMJ/KG1RSSWJ6
         f9Yg==
X-Gm-Message-State: AOJu0YyXHuu0VkWyFBiOfF1BXuuagoMGv8BqrRQ9Q5t61gQFP3qqmlLw
        j+4eKMJ2zdphgYjM5l1hQX42LA==
X-Google-Smtp-Source: AGHT+IGCOWJbqlqngxCwGXaFWU9O5TAVF+RVt3/auwMWynGWlG+iIA/H/qnW0PI1zApZu74LyvoKrA==
X-Received: by 2002:a17:907:3c1f:b0:a1d:511c:5be6 with SMTP id gh31-20020a1709073c1f00b00a1d511c5be6mr4231295ejc.76.1702572600221;
        Thu, 14 Dec 2023 08:50:00 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tn9-20020a170907c40900b00a1f7ab65d3fsm8530308ejc.131.2023.12.14.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:49:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 18:49:30 +0200
Subject: [PATCH v2 01/10] dt-bindings: clock: Drop the SM8650 DISPCC
 dedicated schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-clock-controllers-v2-1-2b0739bebd27@linaro.org>
References: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
In-Reply-To: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=k///e1KzpDnCc228R66xHigJDPcNt/klKkR8uId+QKc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezIonPrJMBNrKMCJqB+0lmi+JqU/fXmsIWFHe
 SbaGkuJyNaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXsyKAAKCRAbX0TJAJUV
 VjCPEACUp+0G5HjLrMxsKcYQw+1fo/IR4w6vFfABGxo5OGkzIhFViTu9i8JupyKGhHrdTTyl232
 kpfAjE1RPoKI4CSu0bxwMj80P+yZv3qVrBM+jwKfvJbkqL/PSxFeO4qb0lVDFADANxGcSn6zZZI
 iPu9Q2zeQnk34PE6iSH4Vg3FiL7Mhf++BF5tVgOs2gIAgucrk4sbPnf7xDaUd93Ed2DluJ8DCSX
 EOOf4XetOXp+nVZKX/3L/5UrOs4z30Zw/zJMBoCa6B5bGSRKF9dQizw4ga0pY+GzFTz347cjgGX
 Ic1F7y1C9LEiNdxEz4JkRyvQBbG4dzcP4NQv3Jam1JsL0uYZxtlPAnlm5RUhwfRxJZu0mKW5N2Z
 atqY6lwHu2Y5XW/BVUiEit5wNSYUEau3qyqqXPNJgH619ZnsIb0kLZgfcnt9sV5Wh4dHYyOuvsi
 zisI++iyR4pVGItSw7V0tAtzpFwt86Sy3Nwd6oSbmFkBjGsIg+3IXKxHpHJuprUviLHQsn8Iszb
 encfELGYlo5BbUgftxxDuNEzz7VH72y/r4AeNpsdMvADDXZiUqjdvY6cRyVKlDRFxMzC0GGRlSd
 1qBznSZ1XjEe8i1mshe/rBAJAB8x24uGDqwb88me0R4Y45tMG6n+Zw68YQ4i2OLDW5EHdFhOsCD
 kb0v3XlqhZ/TkWg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block is the same between these platforms, at least from devicetree
point of view. So drop the dedicated schema and use the SM8550 one instead.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |   5 +-
 .../bindings/clock/qcom,sm8650-dispcc.yaml         | 106 ---------------------
 2 files changed, 4 insertions(+), 107 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index c129f8c16b50..369a0491f8d6 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -14,12 +14,15 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM8550.
 
-  See also:: include/dt-bindings/clock/qcom,sm8550-dispcc.h
+  See also:
+  - include/dt-bindings/clock/qcom,sm8550-dispcc.h
+  - include/dt-bindings/clock/qcom,sm8650-dispcc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8550-dispcc
+      - qcom,sm8650-dispcc
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
deleted file mode 100644
index 5e0c45c380f5..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.yaml
+++ /dev/null
@@ -1,106 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sm8650-dispcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Display Clock & Reset Controller for SM8650
-
-maintainers:
-  - Bjorn Andersson <andersson@kernel.org>
-  - Neil Armstrong <neil.armstrong@linaro.org>
-
-description: |
-  Qualcomm display clock control module provides the clocks, resets and power
-  domains on SM8650.
-
-  See also:: include/dt-bindings/clock/qcom,sm8650-dispcc.h
-
-properties:
-  compatible:
-    enum:
-      - qcom,sm8650-dispcc
-
-  clocks:
-    items:
-      - description: Board XO source
-      - description: Board Always On XO source
-      - description: Display's AHB clock
-      - description: sleep clock
-      - description: Byte clock from DSI PHY0
-      - description: Pixel clock from DSI PHY0
-      - description: Byte clock from DSI PHY1
-      - description: Pixel clock from DSI PHY1
-      - description: Link clock from DP PHY0
-      - description: VCO DIV clock from DP PHY0
-      - description: Link clock from DP PHY1
-      - description: VCO DIV clock from DP PHY1
-      - description: Link clock from DP PHY2
-      - description: VCO DIV clock from DP PHY2
-      - description: Link clock from DP PHY3
-      - description: VCO DIV clock from DP PHY3
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-  power-domains:
-    description:
-      A phandle and PM domain specifier for the MMCX power domain.
-    maxItems: 1
-
-  required-opps:
-    description:
-      A phandle to an OPP node describing required MMCX performance point.
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,sm8650-gcc.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    #include <dt-bindings/power/qcom-rpmpd.h>
-    #include <dt-bindings/power/qcom,rpmhpd.h>
-    clock-controller@af00000 {
-      compatible = "qcom,sm8650-dispcc";
-      reg = <0x0af00000 0x10000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
-               <&rpmhcc RPMH_CXO_CLK_A>,
-               <&gcc GCC_DISP_AHB_CLK>,
-               <&sleep_clk>,
-               <&dsi0_phy 0>,
-               <&dsi0_phy 1>,
-               <&dsi1_phy 0>,
-               <&dsi1_phy 1>,
-               <&dp0_phy 0>,
-               <&dp0_phy 1>,
-               <&dp1_phy 0>,
-               <&dp1_phy 1>,
-               <&dp2_phy 0>,
-               <&dp2_phy 1>,
-               <&dp3_phy 0>,
-               <&dp3_phy 1>;
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-      power-domains = <&rpmhpd RPMHPD_MMCX>;
-      required-opps = <&rpmhpd_opp_low_svs>;
-    };
-...

-- 
2.34.1

