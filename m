Return-Path: <linux-kernel+bounces-65981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F08554BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE5428C036
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32395141992;
	Wed, 14 Feb 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwJl2pOa"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1E13EFEF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945893; cv=none; b=qX7mXo/9QlNYHbWasOSOOkim/T6d5nyIO0ZfA9MYZ5V/5yyknQ6fqLDmgx7fPn8HVeEra74EZstOs5Y2zbQb8t7kjg+jPZSSTb7GlR/ayHexZNjLAlwVSr8VWjy0SPqM7ezg9Mj5nuAYFw2spo1sCyRGNOs1JOMW9fSZo4DHGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945893; c=relaxed/simple;
	bh=trzMRuYmSH6OFe2YghfrCBvROS8FZbNBmhJApiP3SIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKFnsxp7PG5IT/KKCBzi9vQmYvFurPEnQrlS9hr79VEwhaVNll/qzl8NM9DfgFOEN4qtoOCrbMXnKQ5T9eHm5H7ffcoPJB88aCShxZJVWLhMDVSVtnESEuhVr7LLkQ8pfiGbAhdiNAFAE0TaSaP1kDOsQLkyZGICLje+IviJpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwJl2pOa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5116b540163so300560e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945889; x=1708550689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPi8ivh2mN2y9Vi73CkpxPTlBJdM04NlyerCxruRnno=;
        b=mwJl2pOaRognMEpMJOQwZTfFM63mau3tfX2iOvrAbJuTw6c7cOngCk7ptrSRS5vanH
         zufN+adluSu0pi15SGkRHW8zb4pvOlL9zu3nL8qr83GoZDejJ70pKg9SOza/m4rnSi32
         hdkKvIyQ2pv2VmfMpiXgULIQkF6CXoss/gAbWWOeKC7sSf6aTP6JYeJyyb35WWuVHeec
         oiow4rWEU8hPBFFnnpuU2UXDbnZku+BaVoiSP/8BhqDCysJAfLbgqxFbbqjn9eIZ+jIa
         SxrUv6s1HIFVhLZbTtA0OQ0UJeEShvxBoZi2xSgkdux6sLMmm7ZRUT/iVvb9rqizi+ZT
         MNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945889; x=1708550689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPi8ivh2mN2y9Vi73CkpxPTlBJdM04NlyerCxruRnno=;
        b=sqZCey+a//MghldfX7Er9i3i0/Ptt+1A/FayMgN1kP+n1Ws7n1ygMEiITLg1YQe5mm
         vgqRSdqgnI/iSrXmnwQkq4i/4xJ3H611OJMOzJB6FQRbY9b9pcsbZjciM5CbSphZR70S
         fG+PjG7NyWtFbYPf3NMXImc8ja3EToR/LDBEj0LoObUMDvgT8rmMsmCjZVz22cHZLF9B
         7Uot1sDYdxvtP/JHyZq2q2Mwb59UJbOS8QsRwGdxXoDzXUBtc6e2SjydrDlRWAoDaFZP
         OL0PYYcSW1gg9H+mSAcR7P8LmLlVIDwPD7G6vu1PuNZzITvmWHtkJGkVRliwuoCUHYQV
         Urwg==
X-Forwarded-Encrypted: i=1; AJvYcCWtEkPrUEDO3Ur8wvWc17uQGBKJtS1Y1LMcWJN/C9wr6bOTrLclgevNZO9skmf3OXtrBj2bTYzrpRhoQUW+bnKBXQ7Ej9+rupocRrVF
X-Gm-Message-State: AOJu0Yxhn9r49PFiggVlUUFTRNs1HTpGbDhT0Xef9ynIkULYudWn1BhR
	3e82hme24a8ZTFaY8GRhSOTLbMzVf4yClRRPcYkquxG8vx8FEk0GQOZwCJ11fpY=
X-Google-Smtp-Source: AGHT+IG8KujhAEcU3OWwmtH7y6vZdBy/4trbNuu0hjW4OzZLVm7aDW6ZzkIeQdlkslTipuhXMdA/MQ==
X-Received: by 2002:ac2:490e:0:b0:511:ad7f:e284 with SMTP id n14-20020ac2490e000000b00511ad7fe284mr9417lfi.31.1707945889401;
        Wed, 14 Feb 2024 13:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmAft90PfwwJ+F4UGl7VBzcUm7bicbsvS4Gq1g55cT9xqSqreUkJOp7KNX3C2Py9BYM8UMhvxfFP5Jqz3Q8RkTT7oJ7nZCTOFpwiQuXag6L5epTZJ3v8SH9DpguWxsBXtt6n4pjJSkpQ9uYLS741W6f0t9BE617HIF7nRYLa5PEGIsOUokW0MyrwmFwxYSK2hRoWrAaCPOuC3N0RsA1uO0miF4AQbzjDRguBeNxafN1IBlm0oYBJACMJJ2t/VBdPRCGP4RhVdNWq4gdmVW8ZfYummm9qefhQuB1380RAaCSdOQzi7cQYddl0YsLTGrrMYXWjl/35PlN4Ynbnpu0i1nXoMDffqTYE5jzUdCzH+D/4Qb87MHMDDFcBVq+LiD2gM60o2mt0YtYqfR837gj+xA5afOJqzPfR8F7BXcoczxchpKJIgXkbsoy6TKGSPvxjy2we/fl+m1TFs7gP8EpM5TOcFul7l/Y76r/T4cRVljqGAhRMxajQuMlCN3+vgCrqD1KKkoZLhqcbwCombkjwfU3sTclPVd+Nxt7pwU9WCC3i1kwDf0CUeTV4Ky6xcrlHFacpCvOhPUJR3dwzSaDHax9sSyhRCJ7DaOdpB5air+w0sAh0zhJOC9z/Y96V4oArYUJHYx2979TMXdIVL6mw+prAil0IoqLbV3/foXEd81ob6iL9jma3/PAoiFWoAC7fwVgKSyQ0qwWjCrhAP/IecXz8hnSnDg9yTzY06VNoY2Yg==
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7c150000000b0056399fa69absm257298edp.26.2024.02.14.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:24:48 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 14 Feb 2024 23:24:30 +0200
Subject: [PATCH v2 1/4] dt-bindings: display/msm: document MDSS on X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-x1e80100-display-v2-1-cf05ba887453@linaro.org>
References: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
In-Reply-To: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8316; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=trzMRuYmSH6OFe2YghfrCBvROS8FZbNBmhJApiP3SIA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlzS+XBSJtLaHwyVF7YAoVPVRNDnkK9zJbqYzO4
 vykL+7gdTOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc0vlwAKCRAbX0TJAJUV
 Vm/RD/95CWuJMvQI3Jm5AIrS7WryIcLUciwq241Yzf7GWiCAXP6GQb35RgKBY1KrW1ojgLEspId
 fmUK3VK8qy/qXH4rZdIOPBoZABFuzmxMpvFi6nly65mYdIyIlK0ScQ9P4AGfOaPHGDD8CdfGPpc
 gyXI1nETFuhBWTLe+ENJ5Ms7hioloZ6q0UoD4kNdVzraUFg017hciOQhW74TrmdOYOO7oXCZtAg
 ZUUPOT5WnNgXxE/QZvY5Q+8QUlD5hH2hMEtmRn7suDvCrbFqHbJIg4kMNFbSaQkYXFh9NfPQd7J
 zsOlvheV6eyymyM6mBdVyhBmtrlX58eFBCFSaTtqsn3gEg9H21YwsQUvVZGqm9aY6Xth0DbUMPS
 7BjdeSQUJXn7pgZarSQLX1oq/YjfpkcfXOcSaiSFjMVynLOQ3TWMbChnf6U9V7KbVUOZPVE4WUB
 jpoUPwtFkXCHXU6+LJrHJa3kmT39o2v1hH5BSL2VSXE9tyX9Qr8Bh7oshYCf+LJwsu6Z5mXJI5t
 H61lW8PM1JLjSmIu1EB69mymk0Ge71LRiN1la3WjnfbgPOrYd0yShvgHNKy/OAblQLGjcEGWeC7
 GO9VpOOsV9bO3KTqvArz2C0T51PcESvaegik4Ix3LPq5rIWIuBqFz5wBhwu+ukUV4EbyIodcld/
 g+zihpt1KtcnEmQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the MDSS hardware found on the Qualcomm X1E80100 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 252 +++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
new file mode 100644
index 000000000000..c3e38afab76e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -0,0 +1,252 @@
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
+    properties:
+      compatible:
+        const: qcom,x1e80100-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,x1e80100-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
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
+            status = "disabled";
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


