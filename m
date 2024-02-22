Return-Path: <linux-kernel+bounces-75879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320385F038
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AA31C22D47
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E31772F;
	Thu, 22 Feb 2024 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PvLgNeIU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC812E40;
	Thu, 22 Feb 2024 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573964; cv=none; b=Vfv8+9vGHJGVghJli+mCaQHZI8zQflTXZF3hdbiCyPSOYtmVmNJdGB5uwi6VuQlLjmZVhV9wE0H1uImM3/0FytK3FsZYAO2bXRwrP5GFUGCKiQFogyDYpD78GA27CHylXY405bURo5A8+sKLFhjpPR+mvaeQKwHnAz6DCpDB8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573964; c=relaxed/simple;
	bh=cSLePklJRGa7EwTCUgV8JALvq9ooAhj+vmAxxI7oRD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dfcZ7jW3h3FU3GmEfftUdoz0IYEksElWfbrhsejMYXnoDXu85f9lt2yETkv/UMAQvXgzNkorXLlE0HbgFSCwCQpqOn2OjGsxiKVlIWbiyFbK8jh+apeDnAOCcpmd3tGBEu7hIiVtp0rpDnYT0wvLBv/BDWYe4LaaoBylZbIPVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PvLgNeIU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708573962; x=1740109962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cSLePklJRGa7EwTCUgV8JALvq9ooAhj+vmAxxI7oRD8=;
  b=PvLgNeIUeJvqJIZ/40E8rIu7Fnhi3Cd5lLsRAr5Esjp8lMrY5c1yWdYk
   0FilG8ukLLG2z56J/7Ca73NtGvAYuLfdBuBgLJina7avt79gki2yD51YM
   1FSHVklHtUhangyTTrw5lieBXV17lwdBuhuOJpvt0azj+ccbKRy7IcbWc
   rUePGzgWaAzPxi4jAynACLz7syzTlqVIxCj7jRFhsMyO7KDslmUnNk/wB
   GTIvNN/6JLwD659aTgeLV0biXc3PlPCREFVm7QId2SXyXZeLugudUZiWf
   iJ1Y8dFLhg0/WxzyXEV7ER3UZeGXfDi+JtnL2SxpoJMVikvyku8THcrX9
   Q==;
X-CSE-ConnectionGUID: Hyb6skOcSdW7f9xiLL00sA==
X-CSE-MsgGUID: 5TaGlClNQhmCF4oHXNQfaQ==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="16633854"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2024 20:52:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:52:07 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 20:52:03 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <robh@kernel.org>, <tglx@linutronix.de>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema
Date: Thu, 22 Feb 2024 09:21:58 +0530
Message-ID: <20240222035158.195265-1-dharma.b@microchip.com>
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
index 000000000000..0d51bd78bf2b
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


