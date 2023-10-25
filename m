Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A07D63C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJYHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJYHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:44:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9583869
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso42159085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219311; x=1698824111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH6+SKEBg2ErHK8vn7SqXE6OlEOYPGfMHpeZuULBKos=;
        b=cXSWtd8JKGqa45eluHyocEL7mSbYNmZtYIPjQ/czGl+fgtjbe6uppBkM257qNmXTvX
         GvUgJUguwfV5NGqFomJG6nOvWK7kG4zLWRkB7lqjDgPK5dRapWUG7fy3n/dJXqlNQM+F
         124v5qDutPmIENsg4neMcvEkYXfXq9Te4IAOXQu3ZXJK8FfZBI/L9sH7cncWiZT5WMzT
         l3D9EMK28slmQ5KbRM4OnTxhhGhIST6pjo0WPqkKqy7Ch60zoXlHlp0k3v9UXGnGSs5l
         95BkuLb3XASo+xCbGl8/JnOAxhYe+dmgpv8O8TjGWsAZ3GbTEvdaVh5FfGb3PirtTC7q
         Bn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219311; x=1698824111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH6+SKEBg2ErHK8vn7SqXE6OlEOYPGfMHpeZuULBKos=;
        b=sevyIKPhhPh33SnHvcOJQfFqo3ScfwDYG3qUgcuvF0qaVro96hCqPQRWXl3V7MOuRh
         OUhmz9VkZ3OG6gIOzwnpiuj0wulSNP+DzMeATI4mpzaC+dnZXJhthXRI76/DxteDxxKa
         SsWTnTSoHCiXGsPG06+LZi6iUyZj0WK88xvxty56MPn0itZEEYqjtR8t9HyMCj1fDDeU
         wXw0Ya+TTUIbWEJ73q0R8Rkz0yEnAj6HJ2Qu0I9rS6DcgB9lE5ETip7K8lTb/XB0BPwK
         Guu6qfZcfySbtxUszF3tCG/AI+rzEslxUsoDqNZ4BmVZIYCKwQj2et41tZ53ii8U/n0R
         wpLA==
X-Gm-Message-State: AOJu0Yzu3SX3gsDNYmA63D4WYKgPHQVVLOsMdBiajnw+A66IZFrAgwYB
        kkV35otW2xoLgonLvB2VwEpG1VqP97GgLowBIOK+C3HW
X-Google-Smtp-Source: AGHT+IEC4DU2PCCHDJTDYUrTMSEBm8iMhlM4zkmticDLQl4ZNfNMwHRh5+xi0EUW3N5iKlui4bfAMg==
X-Received: by 2002:adf:e5d1:0:b0:31f:fa66:5852 with SMTP id a17-20020adfe5d1000000b0031ffa665852mr10943818wrn.21.1698219311466;
        Wed, 25 Oct 2023 00:35:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm11449058wrt.39.2023.10.25.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:35:02 +0200
Subject: [PATCH 4/8] dt-bindings: display: msm: document the SM8650 Mobile
 Display Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-mdss-v1-4-bb219b8c7a51@linaro.org>
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10068;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=R1byPdDBsex5CD78UmGLGBCsZXzyhYsUPPAR+SOJIhA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUnwWxYqUEtMPvBrKy8pLTzcnrxuBsrQqkvW5a9
 k5ocgo2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFJwAKCRB33NvayMhJ0dJnD/
 4oBNahnq1gzcv60wcfuXcUexoSeMvRMTks2DgKBH+FctnIRqKBS0EL2/t2r/7FpTtZ1FpvB+GC5qFH
 mQXssPAlojZvT7V+KkMqTCIoVpBDzgTXOkweyCU9H4u2w8jbeMVm13KTJKLNSQ0150PTO5LL2HtjEr
 HmO6EtY76JITSJz9Q24ZX2LlxRlKr3R9lfCf4syRgCV3haAf2BKoNgn1/+UyOLgQeiF9P/p/xKEUyP
 jyIWoW+MP7g5n4RDtv4o3qvS8BmVN5NWTFWnyZ6yHpEATXiOfHeZQsxX8Iy99VPXkhphSu11WkX4xg
 cVZ6qWCJSAf6mtLkwaZphkHgn//4nk9JFkMigbxrSe0vmM6EBt/1FGtlCppe2JeXYBU15uo1BjEQFj
 O5VCq2x2+cZuzMj6pwMQOwHtqw3HsjfqLNOZ/+h25HKVCvScJu0/sF0QiDwDKDVvyvf+QoH5YK2rQV
 PCMUEhnwRTaW/41Uo1Gtgbj0564YiPWUZXzVLTCjPlXrDiPITKUP/bbE+VR6PWnzF4gofngD/d8mEZ
 2QN/6R5wPcgIS/CTo6gBLRY7e+yGi2Wh6T+pg1IQGIPpZujgjeVGtmWGtBzHvtBiDNP7KPzUx2YWOD
 Iwtg1HH3n/vG7wfUWxvD/m12VFSunmFRIMT7dBqlQbdQ6+Lmrtex6+g7TTjg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Mobile Display Subsystem (MDSS) on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     | 322 +++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
new file mode 100644
index 000000000000..5638c1ea692e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
@@ -0,0 +1,322 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8650 Display MDSS
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  SM8650 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8650-mdss
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
+    maxItems: 2
+
+  interconnect-names:
+    maxItems: 2
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm8650-dpu
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: qcom,sm8650-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm8650-dsi-phy-4nm
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,sm8650-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        resets = <&dispcc_core_bcr>;
+
+        power-domains = <&dispcc_gdsc>;
+
+        clocks = <&gcc_ahb_clk>,
+                 <&gcc_axi_clk>,
+                 <&dispcc_mdp_clk>;
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
+            compatible = "qcom,sm8650-dpu";
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
+        dsi@ae94000 {
+            compatible = "qcom,sm8650-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <4>;
+
+            clocks = <&dispc_byte_clk>,
+                     <&dispcc_intf_clk>,
+                     <&dispcc_pclk>,
+                     <&dispcc_esc_clk>,
+                     <&dispcc_ahb_clk>,
+                     <&gcc_bus_clk>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc_byte_clk>,
+                              <&dispcc_pclk>;
+            assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&dsi0_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dsi0_out: endpoint {
+                    };
+                };
+            };
+
+            dsi_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-187500000 {
+                    opp-hz = /bits/ 64 <187500000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-300000000 {
+                    opp-hz = /bits/ 64 <300000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-358000000 {
+                    opp-hz = /bits/ 64 <358000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+            };
+        };
+
+        dsi0_phy: phy@ae94400 {
+            compatible = "qcom,sm8650-dsi-phy-4nm";
+            reg = <0x0ae95000 0x200>,
+                  <0x0ae95200 0x280>,
+                  <0x0ae95500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc_iface_clk>,
+                     <&rpmhcc_ref_clk>;
+            clock-names = "iface", "ref";
+        };
+
+        dsi@ae96000 {
+            compatible = "qcom,sm8650-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae96000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <5>;
+
+            clocks = <&dispc_byte_clk>,
+                     <&dispcc_intf_clk>,
+                     <&dispcc_pclk>,
+                     <&dispcc_esc_clk>,
+                     <&dispcc_ahb_clk>,
+                     <&gcc_bus_clk>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc_byte_clk>,
+                              <&dispcc_pclk>;
+            assigned-clock-parents = <&dsi1_phy 0>, <&dsi1_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&dsi1_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dsi1_in: endpoint {
+                        remote-endpoint = <&dpu_intf2_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dsi1_out: endpoint {
+                    };
+                };
+            };
+        };
+
+        dsi1_phy: phy@ae96400 {
+            compatible = "qcom,sm8650-dsi-phy-4nm";
+            reg = <0x0ae97000 0x200>,
+                  <0x0ae97200 0x280>,
+                  <0x0ae97500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc_iface_clk>,
+                     <&rpmhcc_ref_clk>;
+            clock-names = "iface", "ref";
+        };
+    };
+...

-- 
2.34.1

