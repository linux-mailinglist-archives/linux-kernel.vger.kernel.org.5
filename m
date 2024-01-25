Return-Path: <linux-kernel+bounces-38605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717183C310
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13CD2914B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19A650A84;
	Thu, 25 Jan 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHvwtTPW"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97F4F885
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187840; cv=none; b=O1fAFnPsURoUf8lxm8SE3C3ArcRnXAi8lTCgGgzrWl6i2X/2bYS4vJt/HgicVMik4W/Ue883aJtRMwuKfaWD9lidLAjeBhjwI515fpij4GRcW4GKsTgDoIPrWq9blupi1ljkp6cKYdZ/ggDCTdxC1Pdzwp45J2+E1ZvGzJGrePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187840; c=relaxed/simple;
	bh=AD9m1Tc3JH0KdVSduNbc60lgjjhiyGGP68IdBbBdqnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boFI0mwAGsBftA9JV1Gp7mxXt4Wy0EzrAZa1K0FFpdnHxUwy8ImZ6NvApPVD28mEG2F66hZIL1e9DxOUzT6qU3B8811qq1euYV/4SZFQ76E6K2odoFPvXSRYxrOxR0RPufRP1pOv6WF8Bi1ftGiV7tsFRBQVl96tv+cGK//QKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHvwtTPW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so72932611fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187836; x=1706792636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzOVeuE69v/d3EzLsuJBODa/XxSCc4J0jffACJapMek=;
        b=KHvwtTPWwXam+XgzOzp118DzKeXeMQ0ZmvWNXXksdP69em2Nyjxpqm2JmE87co4neo
         zZ9ZS/9cIJZzzIpF9vnFq4TO2QwU8kDWKBJc2OAH3fLK8SeS/N/XCS9wGXDeYut5ZT1O
         hg16+qG126mPuQQx5kgmpW3LoZrRUSZQjoy2xFy7UIBRQaQ7NNmyZnEfPpYYMpsfA18b
         huJjAErZ9wJseC8+xW0sbrhMR4PVo3PFAYJ++ytlXy07pnDhTiD9CCK6o8+FGbVVz5zs
         qmObZGJNJjIMsKugbOtv8hf30aNWx8T5LKxWsa3IesuvXvOpoJwCberW44FlokaqZKvv
         Oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187836; x=1706792636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzOVeuE69v/d3EzLsuJBODa/XxSCc4J0jffACJapMek=;
        b=ejG1t8uM11WB4cxKT0UoNMeWuk4l3d95c2k4MF/Z7TG1Y59VA6EO6PiSu++J4L000P
         qHXkU7TItITnTe192LcqLs66jrPj7/1JaBX795/yoOp11fmTutfC8GEsVU4Z4DJnRCCR
         P4Oh/isXgPF248mu16tZfVmIjNomyyp537E7DCJPRvyK0DAA/pbWw1lQLFtYn19Jzvv6
         90p+hHaXhsST/iWQGCJgSHB6hiq1VRsSTz/eJAKrQGhRy96yfQ86mxznN7ZunDW9cJWM
         q6CE8rbv9kt5fRkXiB/lwtZegX/44aIwaWuZ9EtOhvUJtOEw8hr5yvcRwgMRc3IFrL/K
         WgKA==
X-Gm-Message-State: AOJu0YyTY/4fVSTDDojPX1HH2xb4WG8UVmnsaYlvQJYU/xP4CcZlXy0L
	WDk/qOrtDiLPz8433z58GwK0PfY/PWP4n4FOebAPXZHqRUN3ep8YSP50cAD29hA=
X-Google-Smtp-Source: AGHT+IFXmz4Yvk0uxlp3U8eL2jzoqiv3fmFauXONR8I1lD9oV15vH+nKNk8axGh1qgr1fmAJ1juItg==
X-Received: by 2002:ac2:4557:0:b0:510:125a:e3bf with SMTP id j23-20020ac24557000000b00510125ae3bfmr235010lfm.139.1706187835682;
        Thu, 25 Jan 2024 05:03:55 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:03:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:24 +0100
Subject: [PATCH v2 1/6] dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-1-6b58efd91a7a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11515;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AD9m1Tc3JH0KdVSduNbc60lgjjhiyGGP68IdBbBdqnI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslwyedyn5xJluigTX76ku4Lwj3vsmK2JOvXdE
 seoG6NSw7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcMgAKCRDBN2bmhouD
 1/voEACa9eCdUWU63Zaej9Cv2bVIkaf0AAiyArx6tQE2qpS2leJcwKYRGYDs7r7kY6QNNSKoYUS
 +FcZ2NKN7VgPUI7/hURXqaJDAQRTxcec6nGxfK+qBB88VdQq6dkPitNp7aimyKQgJsqQDGk16EQ
 KskKH4x/upa5L6HGWu+nt9TjwXaFh+eUDBWuA1DPaYXG2ZGZpdooaYkban0OJpQ4gKMcAsYNlf3
 5uFcJFnpWqTaFBye0+OWJ89rckHoDfX58Pi3xVELIedYa89AXBSss3e/ikuI3koBJiuAifGNUNw
 Hl7qj21SIjPja4EWUirtB907OTymEy0eEPK6iYKYrcuvgDoR6QB/z6BSFym2lGV+2/JRS0EyVW2
 gZUnWonQDpaYx+pORvueQJbFkgYksK2el7KQZhXYHirdSn+6/SEwjkd+nG1X1f/Mrr9jIQjaNgj
 Nb4Wg1iaDs0R8ZGm2GIArZYUNeT4pHX7/JGYh0tst5GeJf5VjBvCllYYxkbFEY1tjEA5fGksI/m
 jErNkMkxdjziDG5wWjneZUxmzd4IZEvEbrgaPeKHUtLjYXZ2bziYv/NcDJJg1e7WycIDjdobaWr
 Mk5OGgunJjLWN5PV7CuKiznbzK04v0hDWNcYqIky1rwtOij2iU5FHx7P9kSy08cxNqCv2qp3mqa
 QTt1Uem3P32q5vg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The qcom,pcie.yaml binding file containing all possible Qualcomm SoC
PCIe root complexes gets quite complicated with numerous if:then:
conditions customizing clocks, interrupts, regs and resets.  Adding and
reviewing new devices is difficult, so simplify it by having shared
common binding and file with only one group of compatible devices:

1. Copy all common qcom,pcie.yaml properties (so everything except
   supplies) to a new shared qcom,pcie-common.yaml schema.
2. Move SM8550 PCIe compatible devices to dedicated binding file.

This creates equivalent SM8550 schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 -----
 3 files changed, 269 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
new file mode 100644
index 000000000000..125136176f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PCI Express Root Complex Common Properties
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  reg:
+    minItems: 4
+    maxItems: 6
+
+  reg-names:
+    minItems: 4
+    maxItems: 6
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 8
+
+  iommu-map:
+    minItems: 1
+    maxItems: 16
+
+  clocks:
+    minItems: 3
+    maxItems: 13
+
+  clock-names:
+    minItems: 3
+    maxItems: 13
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: pcie-mem
+      - const: cpu-pcie
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pciephy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 12
+
+  reset-names:
+    minItems: 1
+    maxItems: 12
+
+  perst-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# signal
+    maxItems: 1
+
+required:
+  - reg
+  - reg-names
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - clock-names
+
+anyOf:
+  - required:
+      - interrupts
+      - interrupt-names
+      - "#interrupt-cells"
+  - required:
+      - msi-map
+      - msi-map-mask
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
new file mode 100644
index 000000000000..24cb38673581
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8550 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8550 SoC (and compatible) PCIe root complex controller is based on
+  the Synopsys DesignWare PCIe IP.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,pcie-sm8550
+      - items:
+          - enum:
+              - qcom,pcie-sm8650
+          - const: qcom,pcie-sm8550
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
+    minItems: 7
+    maxItems: 8
+
+  clock-names:
+    minItems: 7
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: noc_aggr # Aggre NoC PCIe AXI clock
+      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
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
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: pci # PCIe core reset
+      - const: link_down # PCIe link down reset
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8550";
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
+            num-lanes = <2>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "noc_aggr";
+
+            dma-coherent;
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
+            interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
+                        <0x100 &apps_smmu 0x1401 0x1>;
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
+            perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..3b7dd9a4ef60 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -40,11 +40,6 @@ properties:
           - qcom,pcie-sm8350
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
-          - qcom,pcie-sm8550
-      - items:
-          - enum:
-              - qcom,pcie-sm8650
-          - const: qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -226,7 +221,6 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
-              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -715,37 +709,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8550
-    then:
-      properties:
-        clocks:
-          minItems: 7
-          maxItems: 8
-        clock-names:
-          minItems: 7
-          items:
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: noc_aggr # Aggre NoC PCIe AXI clock
-            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
-        resets:
-          minItems: 1
-          maxItems: 2
-        reset-names:
-          minItems: 1
-          items:
-            - const: pci # PCIe core reset
-            - const: link_down # PCIe link down reset
-
   - if:
       properties:
         compatible:
@@ -883,7 +846,6 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
-              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:

-- 
2.34.1


