Return-Path: <linux-kernel+bounces-41994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CB83FA6C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E0C1F230DC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45E45955;
	Sun, 28 Jan 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDx0Nqrm"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17941C7A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482363; cv=none; b=BBr6V1IXf1m2b+z5pzY9MVAGYWaxTXmflE4Pw+y0uxoOSumW14vaXaIbQtFMnIeihNmAH49yf6W2/oTVf4oJFiCFPoxBrZ06KD+RmYoK5Oz6cLCsz/Pq5Lg3twmn/w+Y6j5XngF2lqwlcWOyjOo2FozecN3Ad7BbrkkmeUJFklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482363; c=relaxed/simple;
	bh=k///e1KzpDnCc228R66xHigJDPcNt/klKkR8uId+QKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZuDf4fO+l2EWrALUHYKJfNnCzltkjhGMvWbAoeNDaM9susX2+SeWlq5hFm335ssGGWl6Cfh2x4Puh4WOa7HM0kOins3m19Su2IWLOas6oZxNSlXJCoE/cZLDWjCyb/msaX6q8paxhvwdZsyTvND2gqyq5EvRBpJ1zo+5UeHADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDx0Nqrm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so409210966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706482360; x=1707087160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2Wt9fAXkZ3ocbSZ++hiJKJPMhMtN2kMdg9DBtyKus4=;
        b=sDx0Nqrm/k1x6JOHl2hkCTu42oMFT8fHCKwUAM/NVSR9VtGr1HxS0he5MfbKpmX9Fo
         nGTo3TT3VvyjGwTkLrxWhk4nlVHSzm8Y+U7bdCtiw9lZl2cppuQaNs1gHTwqSKrHaZ0F
         A9Piqq4Pj7IqI+Fg9+/wWCM3QurN4VEEpTMwhnshQW1U/unK6lRX5D9ra+0i73W8fRS7
         VRj8rR71IYvW/zO4C6Ss5rZgR4SHuUO8dj3+esEtODu+BWMPewjWnDLv2sKy6gCUDQUt
         LrmR3Y4xmSboBi+XKK1yTo/xDi6BT0l2XMDvJAVm31Z368DsoZSeGzKlTtuvxRsN2v1t
         Jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482360; x=1707087160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Wt9fAXkZ3ocbSZ++hiJKJPMhMtN2kMdg9DBtyKus4=;
        b=YIgWleii3v35ejUhXjzZZyrSsyQMmYXZ9jmkIRvndUMLCqItW1fw7ycwJSNSsy6JYN
         FVGduRFeQ2kc0DV74qcuIff5C05FDR3poDKfqpvu7JAV3f0jC604jL1UfLTRDbD6zbas
         FCy8LmloE21rH6aoQdRAIyPCfhPuIWm1UWyEQp9cS3YVQo3El4hyYrZnT9DR1grORl5O
         2VXY0rs4h1TQm4GqBVGzzcW4YwoRrNp0RhZpTE6O4Qtynqt4Ac0dhsP1S1cW8i9iTQaX
         ZsbRWmw/GtHXaOb4Sw6MzZSKtn/taeJjA/jRCt/Yzy28jRjrhsoDqAj2JkCt3Xu/4+6o
         M1qg==
X-Gm-Message-State: AOJu0YwAWRjdhcinTHkQ7xBVMZA403j4DnFCUIEuuIMM3GpF1v5fB5Qn
	7mfBVzLWpjxTx4fAzKh8bv/kpaEmJA+vUHKNbHBEMDWpvxxGuZZmv4R2NxXWRCQ=
X-Google-Smtp-Source: AGHT+IGSHaJxwO7Qs1dkpVaLZIxSPiO98wx3U9tcNmKne7pVKTer3q/l44rN7CfqBDYL7bSzYC2wtg==
X-Received: by 2002:a17:906:d291:b0:a35:84fb:a707 with SMTP id ay17-20020a170906d29100b00a3584fba707mr2017992ejb.16.1706482360120;
        Sun, 28 Jan 2024 14:52:40 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b00a30cd599285sm3259996ejg.223.2024.01.28.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:52:39 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 00:52:14 +0200
Subject: [PATCH v3 01/10] dt-bindings: clock: Drop the SM8650 DISPCC
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-clock-controllers-v3-1-d96dacfed104@linaro.org>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=k///e1KzpDnCc228R66xHigJDPcNt/klKkR8uId+QKc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlttqpVPj0OwWvnZH4EOTxVL1WOeYCReHs19UDJ
 yTT2B8B+R6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbaqQAKCRAbX0TJAJUV
 VnxxEACwZgdwNwD/JcBcKtc1ncVi6COMEA9tj5C672SdYl3718K/Sma3jRr0Byaux88LZ1RWWua
 XWqI43tqFVC6KgD3VXv3ycwUyxyUaKV4WIn8zvFTEtW3385kJa1K/z271VJiNriLQgWiFg51oO4
 n7B+VIa77suv9ny/UOyp434JumZXoY8rIYH5AzCwkrJYXQElqEwER0LzHfOh+bBsMPmRJkCTOob
 8ycpq15B7lxYlp3wlSLuzR1l+WMallTVo2kIB0fruhbj4KFzcTUa3vagRKAz4C141CXYjmhfP55
 phksQLnYymC+0lNGDjhjWOOG0pgfXcxLe9vO2HUH2Kv5NBoMr9f+EdQA/3/zIQhSeuq0TuXd6E6
 abAiuN+Re+jwm7IU70skfLWU3Puy85OA2Jc+DxsxLAUgB1yBySp+YQufOTkvMBUcJk3IcaM9tup
 1WpGhK5u/hIffkzoftxCiM4NJdrKt5k1WPxYw4H6WA2KTvWpACOaXwvvciiPW4OUDxdulFx1xX+
 kIny5hEFt6mi8PhuIElRCD7Tq3WiaLOuZEyBDfQ3EumX0DIzu6+zQNUFx6atA7yjxFrZZitkRpQ
 4Z51tiHQhIIlE4I4TWYozhPpgio+0GFNpIEpl1yjK/BnJ/JyX/Z8KP1ORPUcOOimOYXD3sHrg6I
 1nSiRbfKV6HIvZg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

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


