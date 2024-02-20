Return-Path: <linux-kernel+bounces-73165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBA85BE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8203D1F24C17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866671B57;
	Tue, 20 Feb 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNiJA6U7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C406BB3C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438577; cv=none; b=LwEx6vzf/0GjLywXXk8Ax8FkUWpBFvR1/FpMbWKVYcW2WNhjqdegUE7izqsncJTEjg544yOP/tnOsZRyQMsHX87eiyCTOb74xegpM88ZbrZXYCxPClc3NHZf8cmmHm7CvAYOb5BYWHJajFVqL3DdIF551NF2gPfLXF70Ir4mdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438577; c=relaxed/simple;
	bh=nPlC29ZbxpkdPU+n7s8OVjVEs1W/WVcx0QHigtIG7QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An7+tpKcA8W3tZ1TozVZ9rAmUuyfi6BYIZWYuN6u4GlYedAKINI7GFqzKSRvTb6nyuKWPas6caUwOmiGotUk5WEKcEQchmG6FmVb/PR0rVECMGRvn949KAH+WSJPg/eLtNNvFPqglfVmdFvNn1VwFWdkZkDYCZRt/LPzpsUdrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNiJA6U7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3122b70439so673237966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438573; x=1709043373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfhJy8/JRE8DqIVKTngBtKbHnuGXe8GwfAek8ToxJJI=;
        b=xNiJA6U7VHk3WCvR3AEq6256na+cunLDUwPwhgWHD31oV6Z35vxKNkfIVKzGWul7+P
         yGeOMqNskwgEhScp911fC8xFglAEHvR8vFFsqTGqNJCqPlRxplGVF+cfgrdgvGvHlcSq
         ApgmwUdL3ePfaPtRiMEOqmks3zMxq6Q1asnR6MIuMSbFafNRi07Wtjzl6cJTlKALrI3d
         b6SPiq8pMZOed/yzvonYqc75dvIDnJrXWmrraVQtePE4EfzFJX0vihpq/22q3BC9C/7+
         l9l2jWJvkOrrwClWAq3Vb3QtDWCndK31DuzG/JbrlSBJKCB8V/MWkZhf+egKjNfwQPZY
         tCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438573; x=1709043373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfhJy8/JRE8DqIVKTngBtKbHnuGXe8GwfAek8ToxJJI=;
        b=hi7MxIC7scfqgFcQOWYjluuXezP2NXnYEFlLsTr7gVqmU545cuTWS9HM6NU/6OrkBi
         nQSKr7Eo6zwObYSk61S4Ohm8rZObj8/ZONVYpkbPUGBwfjjQvQDMaO2A/erOkDCkfynu
         fmLYdSXZ7zil9QsedDDDZ+fmTZ/d4lJ1oeNOI+2/0SPs2kV20kh7xel73i04i2HzK5MP
         vG2CnbLjk9SmX8uhG1H0sSCsYYUKtRlldANrrTyF+NX5SXx/4V+xlh8qx7SYvLdqVO1L
         DVS4bz+Ar22oskztruotYQirP+SLtlt506I9zkBDLbIFl22y3RWETVpB6+XKr1oINs3W
         33EA==
X-Forwarded-Encrypted: i=1; AJvYcCU0bEYLx7bHNjaoSe+SUIEcJoBVNW+pLzoItBIBBNYhDdj45JjIFDKcz5yqRoHcUWXxhXeENSIFZt8iwZCGjgrWtloaz0zu8J7JxuTM
X-Gm-Message-State: AOJu0Yyn79VIfSNKNSbXrfR+3sbqUKnpBfQ6VPzAhpPVGVJe6/B5JW76
	QcjBS97Xu1D/CYY7v7G2BndHf+YMdGjyOIo2XVp7jG2mzrWcdzsxAEI5yx0dSXs=
X-Google-Smtp-Source: AGHT+IHNHQAIvQ62q+Vmzy6wLV4CB/QAF7qEZFsSaRimH1BMmxt4cKHEcFdPMtjiPdsY8mywdd7QiQ==
X-Received: by 2002:a17:906:abc5:b0:a3f:1941:849 with SMTP id kq5-20020a170906abc500b00a3f19410849mr484555ejb.65.1708438573482;
        Tue, 20 Feb 2024 06:16:13 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a3de4c7bf00sm3998534ejj.79.2024.02.20.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:16:13 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 16:15:57 +0200
Subject: [PATCH v4 2/4] dt-bindings: display/msm: Document MDSS on X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-x1e80100-display-v4-2-971afd9de861@linaro.org>
References: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
In-Reply-To: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8158; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=nPlC29ZbxpkdPU+n7s8OVjVEs1W/WVcx0QHigtIG7QE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1LQlM68IG0MOuny2rWWcT+ddEb3/413+JE7JT
 PNBzefXhW6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdS0JQAKCRAbX0TJAJUV
 VjMcD/4hNl9h6VIwl3H1phYQqBWq0MS9H1ZaT5f5wJ0lcbkkv4lBr5PlwdFGCpmf3nzDkTveYtC
 Qud4PcqJni3R1G3P/lRcyQYIftnqDa6jLJVFMz/qVZ3MrCoF9GUuAAmYwi7P2vd+DWpU3zpOJyS
 3hYpH4Rvqi+mbpI0Pyb3Ik2sWnKTz6E88bIDklRNMUUUVBhz0AZOEjUqw4VnnwaxjwqYkK9ZFXs
 aSW0INvcp9GLg2f0EQg7eZCCTX/BjWRiN2ptaEf/KLNxwRRbOwiemmrD+CycXqEj/dqCvKdI7/v
 FWYPKq9JX/AmhUGNglhJGVDmEjeTuzuhJNe0QF5NwGfloQQGjQI4c1M1Wd5h4zWuHrl0ErHbpoq
 AG8D9OU/H2TLqe1zlhsDIZLOgYdhe//tjTzk7fbv2gq8SxgV5TETRwrrVSySDtHRn6GgiSAPzfH
 JK81jqZ4O2hSpm5jOWkTZd28KjSG6tdqEM6gg0EoyQ43g6WP5pRdQKKVkI7JnyQgYpmQwk2hSv8
 HypfyIMvRnCRILBDwgzuvnCfEY7fNYwTQ5y/jZUI8QeBzTsduCiu7gvYlURGBwC0HiAoxc1Xb9r
 AD1gnQV3rrjHFP+iW2CdNpjAv8Zyv+tfj+b5GpJy4Uurc984UJjAbifdn/LL/ZRo3CXb3pqAwmg
 I1Pa4SqapdW8tkQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the MDSS hardware found on the Qualcomm X1E80100 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 251 +++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
new file mode 100644
index 000000000000..3b01a0e47333
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -0,0 +1,251 @@
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
+        clocks = <&dispcc_ahb_clk>,
+                 <&gcc_disp_hf_axi_clk>,
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
+            clocks = <&dispcc_mdss_ahb_clk>,
+               <&dispcc_dptx0_aux_clk>,
+               <&dispcc_dptx0_link_clk>,
+               <&dispcc_dptx0_link_intf_clk>,
+               <&dispcc_dptx0_pixel0_clk>;
+            clock-names = "core_iface", "core_aux",
+                    "ctrl_link",
+                    "ctrl_link_iface",
+                    "stream_pixel";
+
+            assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
+                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
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


