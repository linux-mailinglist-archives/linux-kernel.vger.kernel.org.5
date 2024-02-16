Return-Path: <linux-kernel+bounces-69004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA085834C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4EB250FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB02132C2E;
	Fri, 16 Feb 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqSLq9PL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC36131E52
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102887; cv=none; b=IPZx//16/dfGcfFS3zttahI6LnHcLfkpIgIU2JbQ/YwSveP14BR9cV17Jn631sG0Pdzvx5KEFDiZQHf07u1b6rwf+itRdbQb3K9IRcCBAFl5q3uqHvSIz3hqxynpuMvk9zk3FgJNInjr8GwcqM9lt2J/zFsBXwxRm8T/YE3d3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102887; c=relaxed/simple;
	bh=D6FjYEeIRirUmJdoyL9czcYWbZneMKaVnTNx9zorPJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWMM+BrPQ2QT/NoAdInig0sTZeO1OEND4WiURl2A0cOguiP1P8q0/pfO0bCEteAJfqGIr1IiFLAUVjqdbsrYYq8XZEXd+Um3xLVVlwlD4ncFzi6WHlfETWbyCGnv52iXPenmA0xxogjUhkqcK/3awqh+zqdO4LIJREwsi4NbMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GqSLq9PL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso2455109a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708102882; x=1708707682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crKQXHujlEPtk+uGMVKxkMxMZ3Lju0dDrB83Csxz81I=;
        b=GqSLq9PLbIl/3ifyKDcJH9k51+39jf/VlWhtX5mIFNGdGn+ZoqVyxzzUWRIVsExddR
         AwGjjnaVdTwceFCDtvdxkbPUkeXRtSdeGqrfEttct8yyIjXcyOI2aS3LjRqQALVFPfR8
         SoXGl9n0B6kmYqsuN9pC2+YttbD7DIPGkZBpEbm70T16Q0XAcgq9d7JDsBdMTWPGs/nP
         +YzsU1THLxnXwYoidG5P0JQcXdTUEuqloT+mKvElXqjKLAWTt3WXanMxB6JnBryeap/T
         +VvruemZIqNIsr9qQOMuobmLagiyFKw/HyR9fY5ht0pu9i5Mns4BfkV3euiiIOL5JvsC
         E6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102882; x=1708707682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crKQXHujlEPtk+uGMVKxkMxMZ3Lju0dDrB83Csxz81I=;
        b=rdzPDZjLyO+X3ZxIUml5EzZ4/W/+bZnPCacMJqa2qS8apHuGgLIu0xzLL/Vty8CoNP
         +v8ScB1HvUPl70MwzBI4cZVZarAd8E0SJnbjKIO1O1Q2jaEY1fbYCsnXPD93nvf1TsYT
         K8Z6M71rLhEOkdubg0fRWTJ+MKXO2a5g3a4XzqJwcm2UNIh9td47ZaVyKY9QjBbkASg7
         qQMcCBheQqIpA3SMh/hZ+JN/2FnGXU0R01CkjeA1LqvkdZaxV3O/oREBqpbKgOLU5ktU
         EtdEruPgKIsVW0UWp0JZ0TCeDwRb3/osJQn1I2jcXlFY5sixEJjAukqVtywBLNmFB7VG
         AJEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVy1FnF06+8FHYplZ8dtaonwDVEr24yFO8U9tey99yicEn36B5gxDJcQfusNfIMF3K0RFT/o7HcqsU7sgEE9GnQ4LwUNH+/Tbpykpi
X-Gm-Message-State: AOJu0Yz+qd9elqG4yJynf4K1dVfeL2g47nfdK6QOk3OfNdbYmpRIYk2d
	g1ihXx+Tw2J07UfNNjfCdpbOjvgAeuzalU2yoDCtPnY6RdFKbjqCOkDoscaY+wAY2EubBB95o/y
	A
X-Google-Smtp-Source: AGHT+IHyjtsHD0YHNwlqDvyJbPbnV0gKGx4PIjyqtGjkSpBJr21RhfvWdQUkYwtmB7kWgFLvc88Mcw==
X-Received: by 2002:aa7:d6cb:0:b0:564:6fc:7cf8 with SMTP id x11-20020aa7d6cb000000b0056406fc7cf8mr962831edr.1.1708102882315;
        Fri, 16 Feb 2024 09:01:22 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d894000000b00563a6c9fd71sm159706edq.16.2024.02.16.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:01:21 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 16 Feb 2024 19:01:06 +0200
Subject: [PATCH v3 2/4] dt-bindings: display/msm: Document MDSS on X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org>
References: <20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org>
In-Reply-To: <20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8377; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=D6FjYEeIRirUmJdoyL9czcYWbZneMKaVnTNx9zorPJo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlz5TZzqeq1DwHb+s3WCfqX6J8OUEFZ0djz4uj8
 f1hEhqtgGOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc+U2QAKCRAbX0TJAJUV
 VtbhEACJVHz1cG7R7jwbLBuH+OUGNmilQH3ro9L6zo64VVA3+nmgISRBhhaF2Nb6ZUCmXCNBmfB
 wkUDjHioSCezdPfg7NZS+TYCtUyzUGAM/JbjJsihElql/Mn36F3SceZxNLHJFIPF51k1ZsD86If
 BJR0XngJkx99Oh7NSpnrOicoliJV7Kn/1sDlVphIF7PgE7w1/qdodRO0FPCqCqWAUYPepofGMNC
 uGAiQIJdqUFZOHgULDExulcap8hhA2HK9lhQ25CRmI8yhNflstLB/b5wLV0pGfKCEIq9f8/ixMA
 PGwalPV3B1iXfoiZAIMQejOpPVnit10jk2q4cHsAuGucmo3YgiCHCDQ9r9TXh2vUr4FSAN1IAMU
 KhBIDSLCUXTrGfgBwfQpJ2HPMpeyxOFA1tyFecMZtPDg6T807D3SWcoyTOIvBhGUsu3WUXUvWpw
 Kwg3MtfABMS8JMbnuud7hq7kA353HUJ4QVe2SbK/StV0GaNyklSgmpUMrGeuwQIWVyUTp5vFe6U
 HurEK+6r0WBoNTDrNG77asDHZkHNA30petKyaSdSKbqwcxl53yHnq7kIyha3eZmSf1tNngZqRhU
 5Qew4SA9xHhuLqEfp1rvh9S+Y/swCAb5XWWhKc7MgQX6OHkMnBohuQplTd+mmA3d8pXWGo12/Bf
 TnirYkNzBcKEhhg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the MDSS hardware found on the Qualcomm X1E80100 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 253 +++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
new file mode 100644
index 000000000000..09a034b9ee7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -0,0 +1,253 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,x1e80100-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm X1E80100 Display MDSS
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  X1E80100 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DP interfaces, etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,x1e80100-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    maxItems: 3
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,x1e80100-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,x1e80100-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,x1e80100-dp-phy
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
+    #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
+    #include <dt-bindings/phy/phy-qcom-qmp.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,x1e80100-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
+                        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>,
+                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_DISPLAY_CFG 0>;
+        interconnect-names = "mdp0-mem", "mdp1-mem", "cpu-cfg";
+
+        resets = <&dispcc_core_bcr>;
+
+        power-domains = <&dispcc_gdsc>;
+
+        clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+        clock-names = "bus", "nrt_bus", "core";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x1c00 0x2>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,x1e80100-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc_axi_clk>,
+                     <&dispcc_ahb_clk>,
+                     <&dispcc_mdp_lut_clk>,
+                     <&dispcc_mdp_clk>,
+                     <&dispcc_mdp_vsync_clk>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc_mdp_vsync_clk>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&dsi0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&dsi1_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-200000000 {
+                    opp-hz = /bits/ 64 <200000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-325000000 {
+                    opp-hz = /bits/ 64 <325000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-375000000 {
+                    opp-hz = /bits/ 64 <375000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-514000000 {
+                    opp-hz = /bits/ 64 <514000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+
+        displayport-controller@ae90000 {
+            compatible = "qcom,x1e80100-dp";
+            reg = <0 0xae90000 0 0x200>,
+                  <0 0xae90200 0 0x200>,
+                  <0 0xae90400 0 0x600>,
+                  <0 0xae91000 0 0x400>,
+                  <0 0xae91400 0 0x400>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+               <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+               <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+               <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+               <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+            clock-names = "core_iface", "core_aux",
+                    "ctrl_link",
+                    "ctrl_link_iface",
+                    "stream_pixel";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+                  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+            assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+            operating-points-v2 = <&mdss_dp0_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_PHY>;
+            phy-names = "dp";
+
+            #sound-dai-cells = <0>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                  reg = <0>;
+
+                  mdss_dp0_in: endpoint {
+                    remote-endpoint = <&mdss_intf0_out>;
+                  };
+              };
+
+              port@1 {
+                  reg = <1>;
+
+                  mdss_dp0_out: endpoint {
+                  };
+              };
+            };
+
+            mdss_dp0_opp_table: opp-table {
+              compatible = "operating-points-v2";
+
+              opp-160000000 {
+                 opp-hz = /bits/ 64 <160000000>;
+                 required-opps = <&rpmhpd_opp_low_svs>;
+              };
+
+              opp-270000000 {
+                 opp-hz = /bits/ 64 <270000000>;
+                 required-opps = <&rpmhpd_opp_svs>;
+              };
+
+              opp-540000000 {
+                 opp-hz = /bits/ 64 <540000000>;
+                 required-opps = <&rpmhpd_opp_svs_l1>;
+              };
+
+              opp-810000000 {
+                 opp-hz = /bits/ 64 <810000000>;
+                 required-opps = <&rpmhpd_opp_nom>;
+              };
+            };
+        };
+    };
+...

-- 
2.34.1


