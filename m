Return-Path: <linux-kernel+bounces-39825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941783D67C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E235F1F2BDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D13140765;
	Fri, 26 Jan 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceymd7dK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01513EFE0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259418; cv=none; b=a2iVinaiZxGS5NAqWwVwxCj2ThvLI5K/jbZYqrDFj40Kp4277U6ACZCzsAvatZWW0NRO9jr36sqxbK1gw54TOW/8wIWNKqi0zfMovBYOEapihw6kgt7Ek0UDwU1spyrfl3wDRi3EV92QekF3kJ1370HFOZieRHofIcNq7i16RT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259418; c=relaxed/simple;
	bh=AD9m1Tc3JH0KdVSduNbc60lgjjhiyGGP68IdBbBdqnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6X49v3KP9ubFNzwsLWvhpaM4XZRZhf+KTGqBBqfYpOuNt3oM7H0jgU4DXfU5gA5Da+hYmDTTNamiqPSB2ChNpgF/WgnjKHDDH7xMnsxhtniveCBn9zm+qVSSB/LmH2yHv+WZhk41RsJn4zTPDbzjGnN902RjQ/TRsaDZ3Q8aAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceymd7dK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so1838175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259415; x=1706864215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzOVeuE69v/d3EzLsuJBODa/XxSCc4J0jffACJapMek=;
        b=ceymd7dKaEAc6CcQ8tBdvlz9TCspjaIYpm6Ul5nzMZhFNRncJ+V+NmQZtoTNsbnuCN
         6KcqqiMWFeQCyLKovs7lhj7wPB/GdWQpRO1QZ84wKm0WorQ6wnnoNog5q4voPKXAig1F
         NXd+LXKqWT6389ahpXSuDK6kTb31krwH1vHirZfpuh4cK4wuHd09NPFvPd+kKkPo1f/e
         xS/BjWB4xYa1UrC9lS6Hq2eS+x/AgJ3q7nWn/+scyK2/BT7TSHTgbHQG1KxSaqFG/1Tq
         g8S6w0QJfuAZNhSQMiLrQMEIkBn6J2ehYhlLKgnTbLpn3lgrNT9RlxdbpWxUNAmF092Q
         pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259415; x=1706864215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzOVeuE69v/d3EzLsuJBODa/XxSCc4J0jffACJapMek=;
        b=S3al33MbGPr0KmuDSVKaXSye1LgsYdlaifXr2yWJ06WPtEp+x7M5fPCcj8ms+2Fc8Q
         4kndVwlz+5uX+yZfr6LGbt4ExDWCgp//YEfQNUIsT510aqvyNblro2AenWMsbSR2KFb8
         gNjrftsuHy5y17ZSMN7aIvFUxo4BMYV/Eis1e5B1jsQrUUjdvU/d9ZJXb4vYcDg1KcnB
         waWySPmcJut/OsgKvZ4wId4sW3FOl9d7rIhNqbTFseux9ssfembN/raip+Vww8ep5LOO
         fsfMyu5EJVi9OxIJ/h/vZQ6TkTjDnoXT+wJgvxC+sDQScyB9cEbctsJSiPbiBuvSo7fs
         RZcQ==
X-Gm-Message-State: AOJu0YzNaVj1w/PCVm3HGHuQIgtSM+6pjjEMvPDvHHMO0jF3YTI8YgAl
	YsRi3v7Al5WxBY6fpEOYf4XYxxELbebaxhiRWI0M+/V/JUacLXZBS7adURa1cx/2gvg+0A8sB1q
	8
X-Google-Smtp-Source: AGHT+IEeuBcEWwVxKGnhXLhhaYf8dQ6dKAM6IyBYHbj46NkXMHL8+O166fL+ZowfCLqZ+7gHFEZhVA==
X-Received: by 2002:a05:600c:a385:b0:40e:5c7c:f357 with SMTP id hn5-20020a05600ca38500b0040e5c7cf357mr628361wmb.133.1706259414890;
        Fri, 26 Jan 2024 00:56:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:56:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:42 +0100
Subject: [PATCH v3 1/6] dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-1-f23cda4d74c0@linaro.org>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
In-Reply-To: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PO2J3/JHJ2ApYWW27i94ESWMFoCO4+x2FtI
 mnPK8ity4aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNzzgAKCRDBN2bmhouD
 18IrD/9UuaPx1DzV5Vj4g7DpHVKjtG0NgUkVhSAKKJooOq4GsYyhLI2wl2Ur1bX4Bswvg5yg1YK
 4XDnYl1eDiKsQGwCoRKqPoHnzX7qBirh6+bYVkjvn06rsEaOgJDyMZjBTcVeEx0kXFqhzu6+ekc
 48ABXhiMDocYW8QtUD30ySQJAiUGjrDBbLbqaIubpg7St6UkErExXKjZd/674jz/wBdn44+Hy6s
 TqfYsOMRoplK2aWDtaIS0BMpGW8kMX5DCuKre4DBBS7rIXGqwLAv9L1WsDeWtio62/PxXVbyzOU
 DyHKetIlaPHHdH/VguSn2Kyx65Nck9LlDVnoWiUuLwPV6RLEP1GTBjAewzFts21f9oYm1/58LF0
 ISudXCpaAxrn/ZVJIECq6ATINmlJnTsdY6gwKAXy9v1SEWhx7sl5Q8sTMC64xzBLrN3F4oMNKIz
 8Wlon4UahKHVuE7v6GWV2BX5I3i9Ph/ZidoIS6rugefl/Szvm7VTotzYlmL4bdZwyP8UY6+DCza
 dL+15hiWI8gxEDkBcrUWBH0oEjdovEjHFvV+wRFLktY7uSDEXD4YyHeYRakpQik0K8dBq8KkO1R
 dkGBd+5mvHDgprCiI2B1YY/QlsLBcmbrivnOjgdSt2GrSww5YGOHF7m/jbPt7ZBJo7Q0t28wwle
 0mlDiZVbRMCyQZA==
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


