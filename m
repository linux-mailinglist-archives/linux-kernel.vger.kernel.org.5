Return-Path: <linux-kernel+bounces-38610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1B83C322
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20986291742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B060A56779;
	Thu, 25 Jan 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCtfVplO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D0354FBF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187850; cv=none; b=l0pbFTjrH3WKyMxMm2yCreFG1Hyhy6TKVrrO47IwBgJrot13sPo81XQPkPiWVHVuPe9YdbWPe9HG6ZJY0RzWuL8iNJRUMYrVGLuyY3U5A57JgHcq7cGaHx/rZaLh7mf6KOWFmXCWo+KIa8/gmBttJAb/kQVCz5AvFH2jau3L1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187850; c=relaxed/simple;
	bh=Kpi+e1zOQGsMvKNsg7T6zt51ptrCq+dQp4qRk2qgV5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNSOQ1Y3D9pvQ/NJV9t8R4IzxKOJzIcM/5C6i2ez2COXklDRgzAtcp7mPkKTgwD6/8V/4zdEOI5MSh3ce84WpM7pB+YeRnuV8SLaOL92RfnVbTkWHXb4q9gU3VTLrc1bp6eoTaWL9SvYL0bhm5QR3fue+EWVXFuowcwKS9+rQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCtfVplO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101f2dfd97so547354e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187846; x=1706792646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J42QZRyE7hua2zyqMdnH79xAYGxt1x2MM5KxH2NKU8=;
        b=GCtfVplOUNq3EkRWQ6RddRmOJiRSFmjhHiDUyH6BbN2fHwJ2c28FCg2ZxfBzYIr+Et
         ekeR7vYehEqbO+d3bMEnZHa5JKhMEf+uUwL3LUqaVvretKqbywsVDoRub5VbTM77Xa9X
         ECbA5E/anHLrfDL5Pvjo6UK/h5mPlrWXC/7sucZHfYJIUaSZep0uMBJLbkR57J1v5/Vv
         as2NC/iracTbkQKpPSMwg/HXSD/40pAG2nes/9LeQ9dbbULlgJZFsVp21lwk36xgGWLD
         MY4K2EUDh9UiXmJQCpmbOhnExlO38g9wAYMcpt6PO+WmCOpTzQ+eSiphYjwmMK4B8OqI
         NfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187846; x=1706792646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J42QZRyE7hua2zyqMdnH79xAYGxt1x2MM5KxH2NKU8=;
        b=RvcJZHMuJ/ppw9P8BDEGrBoEu/Q7yGoWQBcyjIZyPJaM60BJa1/i9Bq9GqwkvBwD/d
         6uO0Kx4FItGAJ+w4DWo6bKtNIXzdZ6qJeXETb+BITMcZXUFO8pg0UYGERW3AqkuN6l/n
         wHbG8nM0a9AYQGW2Wn6wFHmeW+VquqZJp7Zx6KQrR0eJxDhVYgrLZoO6gIjgTejn0frH
         R5f8RM2xbWJWi4N8MIE+iXz4GISPpfkfodDgRAYN3OMMzW7461QnpMARqkok6QY9HS1U
         vB0RozGGzd1xLMOk6VrfvmZzKZ0clQBkQiMuyZLH6WMjnIK28A2kJo5flf0yKHcFD/gT
         m9+g==
X-Gm-Message-State: AOJu0Yx7QnOQnz3kWZQzuNOc/qUwVzMDdD6mL4WkEPJQU2eHqL7PpaGd
	/ue3UQ7Xx8Dt4CSL/X2GnDQ9Otiys0Rro1mc0jSC5hWprw6Xhgi0v5T9DY05JX8=
X-Google-Smtp-Source: AGHT+IFEK6NPEMyvxZ71K+eCJXvDTKHGZxypSdRACG8UN8h5+6DurqFfDerubF8tbcE1Z1s0X0SSkA==
X-Received: by 2002:a19:3850:0:b0:50e:71d4:a37f with SMTP id d16-20020a193850000000b0050e71d4a37fmr526746lfj.55.1706187846522;
        Thu, 25 Jan 2024 05:04:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:04:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:29 +0100
Subject: [PATCH v2 6/6] dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-6-6b58efd91a7a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9872;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Kpi+e1zOQGsMvKNsg7T6zt51ptrCq+dQp4qRk2qgV5Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslw2eVZ+DtBTiXEACy/qc/+UWpYBJWibKQEJm
 duAvC+I+o+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcNgAKCRDBN2bmhouD
 1+NJD/9rxjKlKpqkhmU1aTe39vSeUGaEQdQGgnGeLINMq+N5r2TmpSSrbUD/Hnbl/JcRFcexNLq
 1VW6+WuUQfYWzzAJiqc88T6KI2Dt2KWq1ktcqrH8ZFbSNa+jOW3Lfbw4stNdq3XUZgRhdgKENRv
 4vX/oQcErPnNJ0fE5MFVwbPqd/7s5PUbrQibZ8e57bEJ2GNNKU34UfKllJinrVS033NoEKvBRz4
 tttOrTq0MNSHCNn1tyUI7iokOCw8jrPjWAl02iEjUSpY7qdYUIxPxLtkNNeA+Bxd0FHfxdfsnvM
 4MH3zK9GmPkLE4smTvnYktqQl+hVZ6GN1xr9kxWt5VTxE4mpkg4wqS4UpSBGalnp1EAwkf+evGw
 d6I7A3n9yf31vkI9Rj86q7v3QZdHsuASf5q/cXwiN/HgLx4snDb6ETtB9XakKv0MA1Gu9aCkh12
 7c9dXLJAPIH6aBfMUfaPtNVe4h7bbn6skaQCzOkPGcE3sNejj0Uya8qcOWqRnnntzgfdqkb4HVH
 dooRKa+KmIWP0zu8BsJS8DgCNNia+/cpRqomGcRDOFkJNlKw90eXdSsPvXjDEq5hQT5DWmjF2hm
 ZFeXW8WsUHRSqIijP/oP1Ib5QmtkU7I60vEQkotPC+Y0HHsyswyHAGnVugka9kPifliiiz5vN4S
 tSn/45eG8qfs+WA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SC8280XP compatible PCIe devices from qcom,pcie.yaml binding to a
dedicated file to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  54 -------
 2 files changed, 180 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
new file mode 100644
index 000000000000..25c9f13ae977
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8280XP PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8280XP SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sa8540p
+      - qcom,pcie-sc8280xp
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
+    maxItems: 9
+
+  clock-names:
+    minItems: 8
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: noc_aggr_4 # NoC aggregate 4 clock
+      - const: noc_aggr_south_sf # NoC aggregate South SF clock
+      - const: cnoc_qx # Configuration NoC QX clock
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+required:
+  - interconnects
+  - interconnect-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8280xp
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: msi
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sc8280xp.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c20000 {
+            compatible = "qcom,pcie-sc8280xp";
+            reg = <0x0 0x01c20000 0x0 0x3000>,
+                  <0x0 0x3c000000 0x0 0xf1d>,
+                  <0x0 0x3c000f20 0x0 0xa8>,
+                  <0x0 0x3c001000 0x0 0x1000>,
+                  <0x0 0x3c100000 0x0 0x100000>,
+                  <0x0 0x01c23000 0x0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <2>;
+            num-lanes = <4>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            assigned-clocks = <&gcc GCC_PCIE_2A_AUX_CLK>;
+            assigned-clock-rates = <19200000>;
+            clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+                     <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_2A_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "noc_aggr_4",
+                          "noc_aggr_south_sf";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &intc 0 0 GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &intc 0 0 GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &intc 0 0 GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
+
+            interconnects = <&aggre2_noc MASTER_PCIE_2A 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2A 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            phys = <&pcie2a_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie2a_default>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc PCIE_2A_GDSC>;
+
+            resets = <&gcc GCC_PCIE_2A_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
+            vddpe-3v3-supply = <&vreg_nvme>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6e03a1bce5d4..c8f36978a94c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -28,11 +28,9 @@ properties:
           - qcom,pcie-ipq8074-gen3
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
-          - qcom,pcie-sa8540p
           - qcom,pcie-sa8775p
           - qcom,pcie-sc7280
           - qcom,pcie-sc8180x
-          - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
       - items:
@@ -210,7 +208,6 @@ allOf:
               - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
-              - qcom,pcie-sc8280xp
               - qcom,pcie-sdx55
     then:
       properties:
@@ -538,36 +535,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sa8540p
-              - qcom,pcie-sc8280xp
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 9
-        clock-names:
-          minItems: 8
-          items:
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: noc_aggr_4 # NoC aggregate 4 clock
-            - const: noc_aggr_south_sf # NoC aggregate South SF clock
-            - const: cnoc_qx # Configuration NoC QX clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -623,9 +590,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sa8540p
               - qcom,pcie-sa8775p
-              - qcom,pcie-sc8280xp
     then:
       required:
         - interconnects
@@ -692,24 +657,6 @@ allOf:
                 - const: msi6
                 - const: msi7
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sc8280xp
-    then:
-      properties:
-        interrupts:
-          minItems: 4
-          maxItems: 4
-        interrupt-names:
-          items:
-            - const: msi0
-            - const: msi1
-            - const: msi2
-            - const: msi3
-
   - if:
       properties:
         compatible:
@@ -724,7 +671,6 @@ allOf:
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
-              - qcom,pcie-sa8540p
     then:
       properties:
         interrupts:

-- 
2.34.1


