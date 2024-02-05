Return-Path: <linux-kernel+bounces-52983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCD849F26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E62281F22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54E3FB34;
	Mon,  5 Feb 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQ97R27L"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD532C8C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148697; cv=none; b=RLld3WseVwmaVbSOOYQfdJHEiQGfjjQWAUVduq8jT/D6hFNcQQsT4PFbAf5x0VkYHdYpKBqiqnSFJ2DLdqC3pkPKQOzV6QqBXtakQVVlQtzsOANtGTXBdN0siSLtQiiLd59tA4w9Ts+0/kCMt8h9FnF9aUHtS7Vb6vID3RrEdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148697; c=relaxed/simple;
	bh=UlgmKA7fput+Jw2071NXXQ/hgdNYm+uo+/T8PMXGNHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wj3E0Y1O7dsUrFWyzj5WhgbOaupnzlYdbohzUGqifgCiNMrw3bBB+8/P7F5wVZqVtqSPwvuMcKGU+3zOsjZLvYOROOcLiCsdRwu4L5XvElhlv9CU8UutGWk364+Hvk5AdZEN6/1wQVCdYwR8TkLxKTRCZ0UIR2h+4RLkpCiJPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQ97R27L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so41882165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707148693; x=1707753493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq2ageHzU6+oLC8qHYDuL/7l8YQHp3KvKqh1qwA0ffw=;
        b=vQ97R27LuX9+mMaJ2VsOWGQ6vr1bIgwcXKa6rLCG9LYeLNfnhBclO3qmTwvWYBCAfx
         YN4gyguCVTzNa5lyJoQP8sLHUdZKePLL9TAI+IhuJG9lK1JfsC+nrcTVi39doJa+wJpB
         Z0F17xLKO6uWL0pIzbbx7DMqsCFGQDyk/4drVzTcGxgMQLRXVOIzroSqzEosSLXIGBzf
         g9bdAJPOQY5HgywpwGsl4ZhazqA8LinTDuqlWi8JwWTguyAZq0zWp5dBuyYm9Dty/74x
         YWA418tMldbCSMGZ10m7mah/dYaBRfllnhptRcY75ncp8QLp8uFRKtpWn4ONwCe6/QTM
         ZF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148693; x=1707753493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq2ageHzU6+oLC8qHYDuL/7l8YQHp3KvKqh1qwA0ffw=;
        b=XptH/4N1X3WNaa1JL/ToCQdV7mhn5IF8ZrzojWEoPMAT/qUGH2fed54qDFiFwBCqie
         fznvjBwUvgdN6tWvMQCH98oVel2Ge9x60g3zNYj062Q399CP8myODbktIpWl2lqTJ4BQ
         sEV0aINIFqQmsuDsIVLozH+mnLOKt4GEo4tiRfFtfL+vIgn7+S0rZhP/snb9UZUhpcMD
         Tzw2/iXpigbGiYri0fMPtV51AXNTCUkjo1G7NtUrld0R41zIXW2jrda9I7AO1UDI8pAP
         ZqKIJQxzClapm1xf6BTzBpYXB8zIMAvUVjzioUKWA24fvpiS9qdEDgHWtw4cUlv9dffN
         9jDQ==
X-Gm-Message-State: AOJu0Yw1NNit41nj6ofKIg0aIPi6hdyQ4LYqBj2WG6mHrV7cOO45k4Nt
	9kfqmUnlz+2XFPRRH//dIQOcLNLuoIpYnGPAzwOKpKKbLs67UXN7ffnSBzsRb0w=
X-Google-Smtp-Source: AGHT+IFWs4BBcNAzKn9t/JQ0IfRIdWVq1tc1GpuIOA27LDDMGuwjBHJMQ69zjrmQg+0r7PSXdCtPtw==
X-Received: by 2002:a05:600c:3581:b0:40f:de6a:2a27 with SMTP id p1-20020a05600c358100b0040fde6a2a27mr128097wmq.40.1707148693556;
        Mon, 05 Feb 2024 07:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5s7FwBFjihWK11cg5pNLTr08O+20NeC148yDHy8BtXuiVtB6yPmsW6zFdWTiwyTI0UJR24dm7bsa9fiHld4cGl0t/gi6jTgT90STovsxKvN7feEnf6ZYg1h3MADoq4jjxpNXIKxx0I4Yv0VtCUDjHbeF93G2Ze9tM+g3FRnL0uCCkpzu2OL4k5EZwBOHvHthRqCFjEYfq9XAMpYn9W3i6Peg9dNwq8TY7xt7kjuwW8ycim9/cwJDcSh/aPIFHoWBeYauldHLOb0u5tT375MBoW8+/9LqordiITFkGXeND95+W0a1Y0k0iv7i/uni+1WCoB4rWcjNjqnQZ2/FbigwSaFdbOIhywrI63BvdI/Dxx3Fn3Bpqa85k/ejSsIoguAnY7ghRSQKefXOOjmIRI1retP1St+h/XiAvN5QN3hoO5Jzf7FcCtG9DxkqjvMu/GZW7vJip
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0040fddae917bsm243714wmb.9.2024.02.05.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:58:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 05 Feb 2024 16:58:02 +0100
Subject: [PATCH 2/3] dt-bindings: PCI: qcom,pcie-sc7280: move SC7280 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-dt-bindings-pci-qcom-split-continued-v1-2-c333cab5eeea@linaro.org>
References: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
In-Reply-To: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8783;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UlgmKA7fput+Jw2071NXXQ/hgdNYm+uo+/T8PMXGNHo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlwQWPIFWoh8Kcd0FzHGoM7IPJeael3u7afBNxq
 d5YMDggLimJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZcEFjwAKCRDBN2bmhouD
 17ZwD/96lWCDd3c6UY21mUs9fXow9qQXQeEeDYk+pzi1+3nSQ1m04oyLJApJF6w8MxAIdur4nl7
 Utzrn5anb6s9owlio9OZSrswK2gWSFKWfxR2Okno+cqu8F4X2jr4EiTTLXnW8XZItByixtzOxKm
 xIwPxfxN5UJo1R4hXFbw8nYmUOrlB8myDW/tm1TCNJ/2ItGaNy+O0mv/LnccZcrVT2uJEx07Zuu
 fLhYCi5FpvBMhvmsfSTo4++BOTU37ZuVkkDbgrZ2/3hx/5br39ljI7WfCdtR9a0vApMrII6YXqV
 jn3zMp7Be4/jLl85+c+Xa40Dgl3uaKjPD9HRn1fjbklY5YhJcpuVA7T3O+SgtkMAdnmDe3He/8g
 8YHNQ4eYiUfY/XZ2BgLsWGCQ39xzUDBpZjCIa77PcAdWgjN+AdfLPWfCqynj+VvffGJBjQWVlIm
 Gv5CeroNb07PULZ0wFpM6HkRyl1sQkxnseroDogUsT9oSPVDFgshbxFqPV5thtlbkZlDSTF6liL
 COV+0ASbP2PkmVwxWE2fZr6TU2MGku28DW3R74i7IEdvkVGbUmLFMofzX2JoBo9aFrpDywgJv3A
 v1KevnIgODWyqpzYmMg4u7nzd1QxREZ23K/qklpI3RFtFiXMFUsivB+odtcaf8SK6H8fsmViNhf
 glxBRZGKz8VOc6Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SC7280 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting exactly one MSI interrupt, instead of eight, because I
   could not find interrupt details for this model and current DTS uses
   one interrupt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 166 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 -----
 2 files changed, 166 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
new file mode 100644
index 000000000000..634da24ec3ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sc7280.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC7280 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sc7280
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
+    minItems: 13
+    maxItems: 13
+
+  clock-names:
+    items:
+      - const: pipe # PIPE clock
+      - const: pipe_mux # PIPE MUX
+      - const: phy_pipe # PIPE output clock
+      - const: ref # REFERENCE clock
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: tbu # PCIe TBU clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
+      - const: aggre1 # Aggre NoC PCIe1 AXI clock
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+  vddpe-3v3-supply:
+    description: PCIe endpoint power supply
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c08000 {
+            compatible = "qcom,pcie-sc7280";
+            reg = <0 0x01c08000 0 0x3000>,
+                  <0 0x40000000 0 0xf1d>,
+                  <0 0x40000f20 0 0xa8>,
+                  <0 0x40001000 0 0x1000>,
+                  <0 0x40100000 0 0x100000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <1>;
+            num-lanes = <2>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+                     <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
+                     <&pcie1_phy>,
+                     <&rpmhcc RPMH_CXO_CLK>,
+                     <&gcc GCC_PCIE_1_AUX_CLK>,
+                     <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
+
+            clock-names = "pipe",
+                          "pipe_mux",
+                          "phy_pipe",
+                          "ref",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ddrss_sf_tbu",
+                          "aggre0",
+                          "aggre1";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
+
+            iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
+                        <0x100 &apps_smmu 0x1c81 0x1>;
+
+            phys = <&pcie1_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pcie1_clkreq_n>;
+
+            power-domains = <&gcc GCC_PCIE_1_GDSC>;
+
+            resets = <&gcc GCC_PCIE_1_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+            vddpe-3v3-supply = <&pp3300_ssd>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 9bfd35aa1df1..6c50d887ad5f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -29,7 +29,6 @@ properties:
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sa8775p
-          - qcom,pcie-sc7280
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
       - items:
@@ -93,9 +92,6 @@ properties:
   vdda_refclk-supply:
     description: A phandle to the core analog power supply for IC which generates reference clock
 
-  vddpe-3v3-supply:
-    description: A phandle to the PCIe endpoint power supply
-
   phys:
     maxItems: 1
 
@@ -205,7 +201,6 @@ allOf:
           contains:
             enum:
               - qcom,pcie-sa8775p
-              - qcom,pcie-sc7280
               - qcom,pcie-sdx55
     then:
       properties:
@@ -431,38 +426,6 @@ allOf:
             - const: pwr # PWR reset
             - const: ahb # AHB reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sc7280
-    then:
-      properties:
-        clocks:
-          minItems: 13
-          maxItems: 13
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: pipe_mux # PIPE MUX
-            - const: phy_pipe # PIPE output clock
-            - const: ref # REFERENCE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: tbu # PCIe TBU clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
-            - const: aggre1 # Aggre NoC PCIe1 AXI clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -603,7 +566,6 @@ allOf:
             enum:
               - qcom,pcie-msm8996
               - qcom,pcie-sa8775p
-              - qcom,pcie-sc7280
               - qcom,pcie-sdm845
     then:
       oneOf:

-- 
2.34.1


