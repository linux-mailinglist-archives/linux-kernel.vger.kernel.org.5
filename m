Return-Path: <linux-kernel+bounces-57716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCD84DCB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0040EB232DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB16DCE5;
	Thu,  8 Feb 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y3BgmHh7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C496A03A;
	Thu,  8 Feb 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384055; cv=none; b=EVQJCCDi8MU4pN6mJAVzEpnxfhBPUs+Lt58n93d4nYOte426WnUkGCeNVi+KBX9TB4Rp3D4J1HyhY8cc5u7maEDnRNZt0gGriJ4fno2nCk3lblI+VxZs8v74zJVZkfkpLqm3RNRCw+/k8CLI5N3j1c8Xe5fgwPLEJ+goOvQAmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384055; c=relaxed/simple;
	bh=4hfqZVleXT6Y3NFEbrSgvIveo82gukJg4CkL7/6vfw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LiwC7uLSnYxLqDVKIJW9g1t3+Y/Ae4V094PjfUzrjA6r/GPn+kAo0e8yjoTmx+CWdDmkCuxaKe+mQuuv0+/QoDL4n+OCBqwxrRElWYo+OsZcnBG69QFjFMMnTRLL36mbZhVJ6XgXXBaT/ygAzKE3TVBp4FGQt2kHa6JwsHt+p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y3BgmHh7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707384053; x=1738920053;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4hfqZVleXT6Y3NFEbrSgvIveo82gukJg4CkL7/6vfw4=;
  b=y3BgmHh71tsYPT2b/iULuf8xJrHn9rfhqx4jQUFVZTOmYxLYcOJXOhQD
   tNe1c+TqKpl2fG5DbuOrj5to1p6mx79Bn+vnzx0E7uG57DE38Ho+21wiw
   VzSHFDO23GG3yPHtOyPag1Y3e7TrYa0sOntvc5KN5lLwqLXWEXwjfH8nc
   Kj9rU1qORjOOE1lQGLoQYC/kgbH+DmpFBvtc/Se/BswoJk5qxOJFPA+3k
   fRETieU7I8N54cUyHtwrA0YD7qK0rz3hDhILvHVq5jS3xBA1fgQfTVeW2
   pZ80AO0FrGk+npACFD6yJncT56lUk3NAU3GUz7yefZ7RAX+EmiSJreMrc
   A==;
X-CSE-ConnectionGUID: /OK1/V5OQPGFg36ypVfDrQ==
X-CSE-MsgGUID: +Tr4CF2aQeWQihcHw0n6qA==
X-IronPort-AV: E=Sophos;i="6.05,253,1701154800"; 
   d="scan'208";a="17348955"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 02:20:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 02:20:22 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 02:20:18 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema
Date: Thu, 8 Feb 2024 14:50:15 +0530
Message-ID: <20240208092015.263210-1-dharma.b@microchip.com>
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
---
Note: I get the following warnings on latest kernel but not in 6.7.
Should I be worried?

usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR [FILE_OR_DIR ...]]
yamllint: error: one of the arguments FILE_OR_DIR - is required

 .../interrupt-controller/atmel,aic.txt        | 43 ---------
 .../interrupt-controller/atmel,aic.yaml       | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 43 deletions(-)
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
index 000000000000..396eac53da3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -0,0 +1,88 @@
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
+description: |
+  The Advanced Interrupt Controller (AIC) is an 8-level priority, individually
+  maskable, vectored interrupt controller providing handling of up to one
+  hundred and twenty-eight interrupt sources. It is designed to substantially
+  reduce the software and real-time overhead in handling internal and external
+  interrupts.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
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
+    description: Interrupt source of the parent interrupt controller.
+    maxItems: 1
+
+  reg:
+    description: Specifies base physical address(s) and size of the AIC registers.
+    maxItems: 1
+
+  atmel,external-irqs:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: u32 array of external irqs.
+
+required:
+  - compatible
+  - interrupt-controller
+  - "#interrupt-cells"
+  - reg
+  - atmel,external-irqs
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* AIC */
+    aic: interrupt-controller@fffff000 {
+      compatible = "atmel,at91rm9200-aic";
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      reg = <0xfffff000 0x200>;
+      atmel,external-irqs = <31>;
+    };
+
+  - |
+    /* An interrupt generating device that is wired to an AIC. */
+    dma: dma-controller@ffffec00 {
+      compatible = "atmel,at91sam9g45-dma";
+      #dma-cells = <2>;
+      reg = <0xffffec00 0x200>;
+      interrupts = <21 4 5>;
+    };
+...

base-commit: 047371968ffc470769f541d6933e262dc7085456
-- 
2.25.1


