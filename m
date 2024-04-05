Return-Path: <linux-kernel+bounces-133198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9289A042
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F6B1F217EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84116F822;
	Fri,  5 Apr 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zy4/hhk/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EB16DEAB;
	Fri,  5 Apr 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328821; cv=none; b=luRPzonNxbIRVChv8LD43DIU/bIPAEdBZTZX0La09LEz6iIqRfNQsysDNKr2laFAlKFlsydmXWwNUMAaEZoxt9zL4R2sm27wQvHP9kBFWWecyj3MZRiMi4MVVf7LrDqclSFTWXcYSsiWrX1wH7ptsf2R+PvjFyIZB8VYWPlD+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328821; c=relaxed/simple;
	bh=H+V6Pev4js4HSCeSItpTFruA1Ni2g1JyzcjIpJViqrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XW1jhxClq44OY9A6IaerGZIjdoJXTeuLYXjJ9WY5l2QyMwQHGlHI73kYiAGa60t5tLiS2VoVqHD0gGmt1zlqxL/rF7uP/qhxSgfEokmtEx6G7VJE73tmb4tptHtzadRul1M0IBx3PNjBWIOnGJ4BPUSWk2Xd4j1FItLcPS4gdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zy4/hhk/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328820; x=1743864820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H+V6Pev4js4HSCeSItpTFruA1Ni2g1JyzcjIpJViqrg=;
  b=Zy4/hhk/UkETyPFIg9WTVzFsaq1XvNQRWXWe3hEs8NbMAuFE2OxP4Bxg
   +IxkpxVYqaZE/oZ5P7XhQ/5KwZYw6B/bgGkiJD/OB0KXBJHt6BHcX7xoj
   WJoTh22aMaMFs64DwGCVXE0+7D4Bri3Wcy3D5stMN2gdmqyjrVRckCzWT
   w2LlagWVBm0EZbCaO9N6VPfUJppM5FQ9GVN7u+cvKTiTydrIsMEJChX3H
   c4ygZwJvKgnajWNrNoxTlaaelr+1M9DolILMZ5Q0tF87HacsUE+1x2lfl
   Fki8/kPcRVR4YIuAJU0dmT0IXgPnf8465JCQIhxQ6E/4Ls2GycBqd1Rpu
   A==;
X-CSE-ConnectionGUID: LoDM7ZXJQ9auBlcwBCk/kg==
X-CSE-MsgGUID: IG8oY8E7QgmPMxjOlaxL8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18269813"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18269813"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:53:39 -0700
X-CSE-ConnectionGUID: V2Gk/VcsQvSMQOvH8IT/sw==
X-CSE-MsgGUID: tehVrCpHRwW7hVxSyp12bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19285495"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by fmviesa008.fm.intel.com with ESMTP; 05 Apr 2024 07:53:38 -0700
From: matthew.gerlach@linux.intel.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
Date: Fri,  5 Apr 2024 09:53:22 -0500
Message-Id: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Convert the device tree bindings for the Altera Root Port PCIe controller
from text to YAML.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
 - Move allOf: to bottom of file, just like example-schema is showing
 - add constraint for reg and reg-names
 - remove unneeded device_type
 - drop #address-cells and #size-cells
 - change minItems to maxItems for interrupts:
 - change msi-parent to just "msi-parent: true"
 - cleaned up required:
 - make subject consistent with other commits coverting to YAML
 - s/overt/onvert/g
---
 .../devicetree/bindings/pci/altera-pcie.txt   |  50 ---------
 .../bindings/pci/altr,pcie-root-port.yaml     | 106 ++++++++++++++++++
 2 files changed, 106 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
deleted file mode 100644
index 816b244a221e..000000000000
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Altera PCIe controller
-
-Required properties:
-- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
-- reg:		a list of physical base address and length for TXS and CRA.
-		For "altr,pcie-root-port-2.0", additional HIP base address and length.
-- reg-names:	must include the following entries:
-		"Txs": TX slave port region
-		"Cra": Control register access region
-		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
-- interrupts:	specifies the interrupt source of the parent interrupt
-		controller.  The format of the interrupt specifier depends
-		on the parent interrupt controller.
-- device_type:	must be "pci"
-- #address-cells:	set to <3>
-- #size-cells:		set to <2>
-- #interrupt-cells:	set to <1>
-- ranges:	describes the translation of addresses for root ports and
-		standard PCI regions.
-- interrupt-map-mask and interrupt-map: standard PCI properties to define the
-		mapping of the PCIe interface to interrupt numbers.
-
-Optional properties:
-- msi-parent:	Link to the hardware entity that serves as the MSI controller
-		for this PCIe controller.
-- bus-range:	PCI bus numbers covered
-
-Example
-	pcie_0: pcie@c00000000 {
-		compatible = "altr,pcie-root-port-1.0";
-		reg = <0xc0000000 0x20000000>,
-			<0xff220000 0x00004000>;
-		reg-names = "Txs", "Cra";
-		interrupt-parent = <&hps_0_arm_gic_0>;
-		interrupts = <0 40 4>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		bus-range = <0x0 0xFF>;
-		device_type = "pci";
-		msi-parent = <&msi_to_gic_gen_0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &pcie_0 1>,
-			            <0 0 0 2 &pcie_0 2>,
-			            <0 0 0 3 &pcie_0 3>,
-			            <0 0 0 4 &pcie_0 4>;
-		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
-			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
new file mode 100644
index 000000000000..999dcda05f55
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2024, Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera PCIe Root Port
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - altr,pcie-root-port-1.0
+          - altr,pcie-root-port-2.0
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  interrupt-map:
+    maxItems: 4
+
+  "#interrupt-cells":
+    const: 1
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - altr,pcie-root-port-1.0
+    then:
+      properties:
+        reg:
+          items:
+            - description: TX slave port region
+            - description: Control register access region
+
+        reg-names:
+          items:
+            - const: Txs
+            - const: Cra
+
+    else:
+      properties:
+        reg:
+          items:
+            - description: Hard IP region
+            - description: TX slave port region
+            - description: Control register access region
+
+        reg-names:
+          items:
+            - const: Hip
+            - const: Txs
+            - const: Cra
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pcie_0: pcie@c00000000 {
+        compatible = "altr,pcie-root-port-1.0";
+        reg = <0xc0000000 0x20000000>,
+              <0xff220000 0x00004000>;
+        reg-names = "Txs", "Cra";
+        interrupt-parent = <&hps_0_arm_gic_0>;
+        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <1>;
+        bus-range = <0x0 0xff>;
+        device_type = "pci";
+        msi-parent = <&msi_to_gic_gen_0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
+                  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+    };
-- 
2.34.1


