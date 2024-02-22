Return-Path: <linux-kernel+bounces-76186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995C85F3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837D61F2520C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F53613A;
	Thu, 22 Feb 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wOAzUAZ0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9C1B59E;
	Thu, 22 Feb 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592904; cv=none; b=NnCM6Whm1AnCt/n4Ym1Y7MtgaEqV37QbrQtROloRJ6YCCRbT+/6qFydwjgLHMhrI88m0+BUlBcPYHycDSJxDejBoBnEq/pVRIhYuzv+hzdFayvuhyh9OMAtmUIW0Ftc8CwTR81MMv8HWRkex95+cSCNeHpg4k6Gk/Rxt/16/Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592904; c=relaxed/simple;
	bh=ewoE1dRNlbq6NU7A+zCssf7+EhfKtW4/Gc8uLF0C87A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eAmq55X4KJXXNfZtQ9a9PPvy73dTNFbOI5kSnlup+NYfETUzMK0Lol5QlDHx65lKYXqTzvWBgZqUKGLDdtngLPb8yYmO4OSgzx+xdqxtAG60uGZmkicUDW0yeZJEGfo+f+vHVc2aNjWb6pqB2f9GNdzbOKQ2CLK5TkhjX108tyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wOAzUAZ0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708592903; x=1740128903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ewoE1dRNlbq6NU7A+zCssf7+EhfKtW4/Gc8uLF0C87A=;
  b=wOAzUAZ0c0+DD+1lqhCWbXd76+3ZBTA4lz/K+uWLtFM/SpKfx4tZv0Dh
   lL9oPL7TtrD9Lw5/MRSCN+GGBNh7dSYIKfNlLlfUEDZ7jj6h1JJ45VZr1
   ff+1/7zO6/FEvU5ilnI9Ti6E6SkQ+Pgef3VhJlqU+vRV2ndFHAuJZfv1F
   BPKLrHsqhaF+5efh+FGqCmziaNmYggwdfBmT6WaX9QWggYUgDbEAcFaxz
   +rs4aNqyIZa5ZykzE7zpCPt/C/BJsdFBeCALu4wjh4YhBU0ZwMi6y9tot
   f3mVcUs6yW/khyI+3D00DMD/ANZ08KGyZgrA1o9hkGkdzzPmIPTlikND7
   g==;
X-CSE-ConnectionGUID: BC0EOOY3TzydnWlDlVq2TA==
X-CSE-MsgGUID: Ny/QWI5tTQGgbNHRUYjuLA==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="16647203"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2024 02:08:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 02:08:12 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 02:08:08 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <robh@kernel.org>, <tglx@linutronix.de>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4] dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema
Date: Thu, 22 Feb 2024 14:37:38 +0530
Message-ID: <20240222090738.41628-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert the Atmel AIC binding document to DT schema format using
json-schema.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changelog
v3 -> v4
- Move the allOf after "atmel,external-irqs" as it handles its restriction.
v2 -> v3
- Add constraints to the "atmel,external-irqs" property.
- Move 'reg' before 'interrupt-controller' in the example.
v1 -> v2
- Drop the '|' as there is no formatting to preserve.
- Remove unnecessary marketing statement from description.
- Drop the description for interrupts and reg, it's obvious.
- Put reg after compatible.
- Drop comment in example.
- Drop the example of device that is wired to an AIC as it's(dma) binding is
  not yet available.
---
 .../interrupt-controller/atmel,aic.txt        | 43 ---------
 .../interrupt-controller/atmel,aic.yaml       | 89 +++++++++++++++++++
 2 files changed, 89 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
deleted file mode 100644
index 7079d44bf3ba..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Advanced Interrupt Controller (AIC)
-
-Required properties:
-- compatible: Should be:
-    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
-      "sama5d3" or "sama5d4"
-    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
-
-- interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: The number of cells to define the interrupts. It should be 3.
-  The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
-  The second cell is used to specify flags:
-    bits[3:0] trigger type and level flags:
-      1 = low-to-high edge triggered.
-      2 = high-to-low edge triggered.
-      4 = active high level-sensitive.
-      8 = active low level-sensitive.
-      Valid combinations are 1, 2, 3, 4, 8.
-      Default flag for internal sources should be set to 4 (active high).
-  The third cell is used to specify the irq priority from 0 (lowest) to 7
-  (highest).
-- reg: Should contain AIC registers location and length
-- atmel,external-irqs: u32 array of external irqs.
-
-Examples:
-	/*
-	 * AIC
-	 */
-	aic: interrupt-controller@fffff000 {
-		compatible = "atmel,at91rm9200-aic";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		reg = <0xfffff000 0x200>;
-	};
-
-	/*
-	 * An interrupt generating device that is wired to an AIC.
-	 */
-	dma: dma-controller@ffffec00 {
-		compatible = "atmel,at91sam9g45-dma";
-		reg = <0xffffec00 0x200>;
-		interrupts = <21 4 5>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
new file mode 100644
index 000000000000..d4658fe3867c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/atmel,aic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Advanced Interrupt Controller (AIC)
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Dharma balasubiramani <dharma.b@microchip.com>
+
+description:
+  The Advanced Interrupt Controller (AIC) is an 8-level priority, individually
+  maskable, vectored interrupt controller providing handling of up to one
+  hundred and twenty-eight interrupt sources.
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91rm9200-aic
+      - atmel,sama5d2-aic
+      - atmel,sama5d3-aic
+      - atmel,sama5d4-aic
+      - microchip,sam9x60-aic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      The 1st cell is the IRQ number (Peripheral IDentifier on datasheet).
+      The 2nd cell specifies flags:
+        bits[3:0] trigger type and level flags:
+          1 = low-to-high edge triggered.
+          2 = high-to-low edge triggered.
+          4 = active high level-sensitive.
+          8 = active low level-sensitive.
+        Valid combinations: 1, 2, 3, 4, 8.
+        Default for internal sources: 4 (active high).
+      The 3rd cell specifies irq priority from 0 (lowest) to 7 (highest).
+
+  interrupts:
+    maxItems: 1
+
+  atmel,external-irqs:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: u32 array of external irqs.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,at91rm9200-aic
+    then:
+      properties:
+        atmel,external-irqs:
+          minItems: 1
+          maxItems: 7
+    else:
+      properties:
+        atmel,external-irqs:
+          minItems: 1
+          maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - atmel,external-irqs
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interrupt-controller@fffff000 {
+      compatible = "atmel,at91rm9200-aic";
+      reg = <0xfffff000 0x200>;
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      atmel,external-irqs = <31>;
+    };
+...

base-commit: 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
-- 
2.25.1


