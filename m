Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8480DE95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjLKWqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjLKWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:46:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F38D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso6968436a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702334773; x=1702939573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB4Npi79dJoGgJV6xHblONM0PBpsg/vfJ0azkjd87Cs=;
        b=Bvvhzu4+ODmkVKueC0j+uiPeLBHJhib7uOxv+5G2NHXSlogZm6ARCPaUUSROOf28he
         Jl2yTpPMlEHaCmNeoMoiDlD1IBIyoqIPvjUxfZR73WLtz99dvRTFoPtUFMXBfHO1QYzY
         3Ns3ig3xpxJBnCzjzXQynRn3w3vCfByblL0pRS/Q9+/AyuzrTWUkiohHbI+ZZbhLHngc
         zG3VWKQXva/1g3kZfP8b2S+tdkrvDIJccSxPBbJN5f1LKV/8eJoFAutkqQR1mWoHOxCo
         IcKnMUrxKwsaLOADZ880NtYVlhLvPue1I4+TO8fD464XV9FoS8lqPXxQ9TR9xCH/BnED
         fEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334773; x=1702939573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB4Npi79dJoGgJV6xHblONM0PBpsg/vfJ0azkjd87Cs=;
        b=d4J8CrGnz9ZZoWr7Kb/yUNox06XKKAzKrqpo2tT6O8pYKDsuUfHxK2MmZ9K3tLNWds
         JusqtgsZZzZhE1ob1VUINEDhpFGPPQ35FFjeQjwZaj3mnO2HajqJWaJd8maT2fBK85WF
         cvp7lejcacFiUJfE5j4Hu32w05B5jex8dy2ngkEXfM0Avuefq9MhF/y+1lt5H9PQ6L6x
         SgziF3we2nKAup3vm+rLbxxenazshrbGE7JXN97wjoyJvxSfvQLch33c69YC2xVKjhV/
         AcAx9Pn3DRk+Nebysb3qbo3NxkOgY+BhygIjT3S9L11wANBAwZACgYFr/Dr9y/8Uw0Kx
         FOlQ==
X-Gm-Message-State: AOJu0YzayHd2MRJYd0Ylxgq7TjVr4RyvqLWgfWpCv6YWH7zQzNsDe9zA
        deot7G1UuE+k4IZGWeR/Z179dA==
X-Google-Smtp-Source: AGHT+IHLLFCc5S24BWi6sKGDUPvpsJd5Ztx95EOpYUqFZB+MtYlnb2LdXpgCPinzZQ/iwpbtBPtDNw==
X-Received: by 2002:a50:955d:0:b0:54c:b88a:7a6c with SMTP id v29-20020a50955d000000b0054cb88a7a6cmr2028377eda.33.1702334773049;
        Mon, 11 Dec 2023 14:46:13 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm4091789edb.59.2023.12.11.14.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:46:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 12 Dec 2023 00:45:41 +0200
Subject: [PATCH 01/10] dt-bindings: clock: Drop the SM8650 DISPCC dedicated
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-x1e80100-clock-controllers-v1-1-0de1af44dcb3@linaro.org>
References: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
In-Reply-To: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org>
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
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=AHPyIWOICuLjecHeAnWx996Z2Ye/AhmSW6Jop4+KOgs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBld5EkB4c91sn3EisyfcWDJbZ9mVYlHX+iriNx2
 pPKooda+ICJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXeRJAAKCRAbX0TJAJUV
 Vta6EACn/rlK11Ao80BkmnxUAZOciejuKhdNwHelaidZ3dDtLy2k+S2QZy+HmljJ4uXX2JZMz7M
 dvFl+ruOhOZY/0yRJgXli9UINiDsU0uwBx3AjH5kIYGkBYrzPPHfGuNCllBY99MGHCJDaehS3XI
 /BiMqCWOSU6DWPDaaOc5f9heSt4etWrpREzmMhLN7YzDtWPWfnYeB7rNAoa3Dry915tA8K62zpn
 QhVCG3EeukuQf2nuwrVp5aoeLO75qs1bp7iIuZ7BM7DZFb19RMO0TXiF8yC1q1jWpI1iSixr9uR
 znBN1Ke3OEaSoOava6I5/zwtybCPPoWBS84X497HcBNkbZduFxlfH/dILKF6lMypL1bK6idHGI6
 6og+/+b2sfa/vv5+0EX1n1Z7XsY0PQwAvn4uHSoeyrWkX52SdccHFS+SCPB6Y4cErd0DOtQoNeO
 EHc28NKoH7As1qZdyqU0+sEe9HGAbC8slwfApBZzf0H3alswCzejXitJ7Sy6hVhxmCXZW5pFvC9
 rmuDw2Ya43n3sNQHqHQZX1mVGwAbU0GZb1Em7+zs2AtgqLuDDJuvVAR1CY9matAMEAHaOm0Hxtb
 V+ap2HxTJQygO6Mt99Us3w3sldyKfU14IixBJzgsQxXR3Sj96KNQElqY67/ODHYpPKKAjMKGb7r
 F6KeBIDN5l4Fzwg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block is the same between these platforms, at least from devicetree
point of view. So drop the dedicated schema and use the SM8550 one instead.

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

