Return-Path: <linux-kernel+bounces-59190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6255384F2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC49BB25CA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A767E86;
	Fri,  9 Feb 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c0kNo2SP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614703FDF;
	Fri,  9 Feb 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472933; cv=none; b=QbGWUFk7hADUjUhmc8mUy/dA+N7Hk5wVwvBR74fcWaJzgCt7FrxCCNH9p0Feqfh1NJQGjqzWfmEepM+Uag3j/0A7N1VWiFr2jgavUTSY5knakKg511AUIymarWixepMP8Kq9kJAaDlt3jThapuaZDXmBbfVIJiwQR97weshaLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472933; c=relaxed/simple;
	bh=dHt3XARATvm47LBWteX4AQlK8JTfzsMgBrvHp9qNz0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nL29ZPvtz2cDbI8BHXFRUzZ7Ioh2CGFvsuigH9Lc2PUNX/z+09E8iJyqthb7R1HyXUV+6FoAj8W/3W9xvCW86obSFocqw2dKjWL0GHi9yKGC/jsrATYmmGRCKvnbHh60p7Ubq2cwWw6n6B3I9yI9SI6GOqnTpUOkxUZmECrXsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c0kNo2SP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707472931; x=1739008931;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dHt3XARATvm47LBWteX4AQlK8JTfzsMgBrvHp9qNz0k=;
  b=c0kNo2SPI6EbSBVthgfSe7+zNz01vqweSIlSvXFdQOlDGWCZ9uBlHjMP
   +aZBawe2TSaSqwe1a062RYEKHgQeuAHWCxgQfG+sMt5kRiDl86wtH+nI4
   OzxMUPnQ+dqjm4hyvuFO8rqgkH8uDpY3FFd4dyVJvSbcl3a0TQaqEJQ2/
   6r7LjuFiqC8ECqfWf9uEiCkH474Bhj1oPSogu4ckH2xDdbX+KGvztBDRA
   EMe9o25yE7wtfaFhp0dcofbjrrMaiqi68ha/KAiZ/7TuGfJyK1BOfTOWE
   nlpTt5BcJU3RtWF1+khwaQVr8tFnlUxBRAcaBjHEpy0PnfIegM4psKtow
   A==;
X-CSE-ConnectionGUID: fX7JcovPRN+JJx0KDfcpAQ==
X-CSE-MsgGUID: gvdEMF7UTZGKu02Cq+Yz3Q==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="17415429"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 03:02:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 03:01:29 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 03:01:25 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema
Date: Fri, 9 Feb 2024 15:31:22 +0530
Message-ID: <20240209100122.61335-1-dharma.b@microchip.com>
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
Changelog
v1 -> v2
- Drop the '|' as there is no formatting to preserve.
- Remove unnecessary marketing statement from description.
- Drop the description for interrupts and reg, it's obvious.
- Put reg after compatible.
- Drop comment in example.
- Drop the example of device that is wired to an AIC as it's(dma) binding is
  not yet available.
---
 .../interrupt-controller/atmel,aic.txt        | 43 -----------
 .../interrupt-controller/atmel,aic.yaml       | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 43 deletions(-)
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
index 000000000000..df81115a8b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -0,0 +1,74 @@
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
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      reg = <0xfffff000 0x200>;
+      atmel,external-irqs = <31>;
+    };
+...

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


