Return-Path: <linux-kernel+bounces-38608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B783C31A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910911F25DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F153E2A;
	Thu, 25 Jan 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwfsMCeP"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BA51000
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187845; cv=none; b=i7KJ3bj5JNlhk8y5X2F4c+JGkgY3TrSsfqxcjOvrSR/CytvmPekiWPrPAdGOWdY29wDtwFwEEpO5/mh3ptYoMhFXOO362zw41xCOLGsDqpx+BLFYsU8Nr0DfnXnH8xgGPUqkaBOtUHAhftnF7jFjVgCmXeCUR5+2JlLUNgK9eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187845; c=relaxed/simple;
	bh=L2tu3oVaNutiUYx1lhf/hq1yv4Gzm5YHggLrHFEaVTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KR7GTQtg/w8+QlXvtflETNM04OvPkoGmjiKeBbSiAA2YoVfI/SfoF3K4nz/qUlWLvASaNNGNK3Cg8sUPaCDT1UBuqePjWC0/e6vj//un2V3zCR13LmpsA2ZPKj3n+4PijJvJAgAlbts0LSnxhcaFLv2Db/lWTi9FGA02zhzAtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwfsMCeP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso8422968e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187842; x=1706792642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb0WcvqtQcLyXdbtPa/dVBnzAG+9fpalgiYlCkLzkns=;
        b=nwfsMCePpXaaySQkic5HidLnaDM3++CyyopAuk3l1AcQsYGHq9HrbASOeUXH+x0KsO
         54UFLs1Ns7/OAEjLdk2kIzP1bsAJ2QnOrNaCL8IO+6wjj2Nn0k6ifUewSm6wxC7MteeL
         juXm/gQhvvqlQUYkmh3ep89wiBzLuIeyxtH+nrrvUL9iOZbSRzDp5IcqqXDJQIyrgcQp
         h8kqFx9PhwiO6K/G1m5wCuqVBwsvPnUkiTvY7L2cSysVx2cZiTEkwHzoabdbH2hFzrfq
         039x3aBKoK/QqVF/zvLgydFTspcBxzTFP4ZYRpxd0KRSg1XkHkXkQHSsCNXPQRm3kw4M
         IO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187842; x=1706792642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yb0WcvqtQcLyXdbtPa/dVBnzAG+9fpalgiYlCkLzkns=;
        b=VfHOfA/5gMe3ssoFw22zfSnUuoX2zU538bjaKBKIQOqgsC3dVytDNuGObIDOFwY46T
         0V2X6B/1yzP81VqCQtAPw37U0dqJIR5sUuZH3bUqgAcUbizgn/KgfR280gnadR0fyr2j
         zyXD3UWoBRwTV088ycyP6sXs30GjjQiWIB3iTnb96jRSEi32v0y5EexV0grvTmRvl9js
         /asPYkUZCfwhOlrz1J5/C5KOvtpTLGfB3ObQXlR1OgOGmEJd71Rsq3c8f7jIX0isJvGW
         22XoTIJ4JOdkA2X/NlDEWmLYIYv7YJ/CGuxi4daNeoRMFO3Pdg79lkhqe7jwsCCEi6zA
         2ACA==
X-Gm-Message-State: AOJu0YyXs+Ef/2dpS3nSPIMnVCYLhnnZazA0egNTUTv/+gR5DF3Zyb3U
	9YfpZKRtkRy83be95sT2K6TJHBu6DBQc9gncvokS22eiVAThHMHk8cuq3K96zkQ=
X-Google-Smtp-Source: AGHT+IFUbJjX+Ypx5/lnO5uD083FbLjDvYECn4Rghok4vuvhNv6Vc4Des1Umco+71XNwJe9IpnF5Gg==
X-Received: by 2002:a19:f504:0:b0:50e:84ad:3e29 with SMTP id j4-20020a19f504000000b0050e84ad3e29mr228052lfb.136.1706187841993;
        Thu, 25 Jan 2024 05:04:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:04:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:27 +0100
Subject: [PATCH v2 4/6] dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-4-6b58efd91a7a@linaro.org>
References: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
In-Reply-To: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7937;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L2tu3oVaNutiUYx1lhf/hq1yv4Gzm5YHggLrHFEaVTI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslw1HCDINfvmJk3s6gXTL1ZMT6TJ7iI6Xrc/B
 BbDMUfFMzeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcNQAKCRDBN2bmhouD
 16J3D/0WLrFSq2QPB8aT2I64+6619ZRQC13AJHi2vHzxpxCwJvJ5jmGIr/nWzousY7O+UYEM42H
 IE3RccPGsp01MO0KHSnG74lH6HUQsYAERFyOtht5a+bJNyuE5wPgz2RlJkUohWaq8HNYrkB0ogG
 v3IdL4SHYUjB0I0myRKH3vhqbdm6wjYcgy4MshbRCzYJ3tVNnYPgMBgeQ4+IZ/KQdP+45pB6uKq
 VhrkXXzqiIAsug8ZTXzijgMrgkWzIcoTobEl4M1/ZDKnvOqUwHSlo+xqUOLsWZoNjqy/mY0J4b0
 zduW901+zEdj/F8fDWvh7RI1gvOqn24MK06hqC3SRW2LrpVwwVVMM+bVda5QJrFggeb+pE7hnKS
 eqjHA2w8r4sRnsF4/Pk9+F5mHlQY/499alowYl4IMYgOXWNIiRNHXnOpzSqQIFLxqTv/dkBU2F4
 +mfhDRaeJM3xGm7jcXwTgGl9vmXVfv6rzzc9uk3w89hZE5gKt/is3AgOhoyIAsjXZjuzyusbBTh
 VkptkniFevcakw9E6c8BCuf35ey6raWcyemEgsyZGHcuwZTAUuvcfazaUeM8Z11/Ua9hR+IWmRC
 VnSjl+q1RgKUVmmRA3VeJo8ha/TJqlc3CmKlL1+d9dYMAkImVHufCm6zQq9Ssu1XHFQV1myCJri
 GKqP58wly86ItRw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8150 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 158 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  29 ----
 2 files changed, 158 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
new file mode 100644
index 000000000000..9d569644fda9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8150 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sm8150
+
+  reg:
+    minItems: 5
+    maxItems: 6
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: parf # Qualcomm specific registers
+      - const: dbi # DesignWare PCIe registers
+      - const: elbi # External local bus interface registers
+      - const: atu # ATU address space
+      - const: config # PCIe configuration space
+      - const: mhi # MHI registers
+
+  clocks:
+    minItems: 8
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: pipe # PIPE clock
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: tbu # PCIe TBU clock
+      - const: ref # REFERENCE clock
+
+  interrupts:
+    minItems: 8
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8150";
+            reg = <0 0x01c00000 0 0x3000>,
+                  <0 0x60000000 0 0xf1d>,
+                  <0 0x60000f20 0 0xa8>,
+                  <0 0x60001000 0 0x1000>,
+                  <0 0x60100000 0 0x100000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            num-lanes = <1>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                     <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+                     <&rpmhcc RPMH_CXO_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ref";
+
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                              "msi4", "msi5", "msi6", "msi7";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
+                        <0x100 &apps_smmu 0x1d81 0x1>;
+
+            phys = <&pcie0_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie0_default_state>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc PCIE_0_GDSC>;
+
+            resets = <&gcc GCC_PCIE_0_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 14341d210063..47888b5b1a13 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -35,7 +35,6 @@ properties:
           - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
-          - qcom,pcie-sm8150
           - qcom,pcie-sm8350
       - items:
           - const: qcom,pcie-msm8998
@@ -541,33 +540,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8150
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 8
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: tbu # PCIe TBU clock
-            - const: ref # REFERENCE clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -729,7 +701,6 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-              - qcom,pcie-sm8150
               - qcom,pcie-sm8350
     then:
       oneOf:

-- 
2.34.1


