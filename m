Return-Path: <linux-kernel+bounces-108464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98C880AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716691C2103A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E591D52C;
	Wed, 20 Mar 2024 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b1M49elK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498D11C83;
	Wed, 20 Mar 2024 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913998; cv=none; b=ZzAOrQ2CJPA9RulSkPyFxFBt3U9derlgxQs09gFFxu2D40M0H0clF/oUD52UYpaKF/zPp5NuALiw7oH+ERTpQKC2hOJ4MLMTcjRihTunZNy0rh+58MI3JrmbkGPrvTrddiuBQ0BdF+NxT9RA4+9iX86zaUkjN+AVdtk1l2m9qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913998; c=relaxed/simple;
	bh=++8vvQ5hirZaSfFCqLhFu4Spw6Ti2cR5DDvaSvz/peI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YpFFXDwuFZeWzKt5WyV2BTJuV3Ii14TtqIlOX2KV0fBvM9knCGheG2tiVXUEnPVJuJW6mE+jQh0NOsbPEFote7kgQFJWm+FSg0HQTBdU2LFIo/PZNQxU+WqEn6s9yA0/C4icvIvFztCEsC70sI2BCMmO74Wb13IwGCbZvfM/EJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b1M49elK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710913996; x=1742449996;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=++8vvQ5hirZaSfFCqLhFu4Spw6Ti2cR5DDvaSvz/peI=;
  b=b1M49elKLlA/4GH/+qBYOa1zv5JhlNQlQWERr/fm501yqEvjqBP5vq6q
   FRBkayMtlRecNJGuc7ALCDaqbVnemNCUq0oCMtKCFCIZVQZv1lVrdfjYA
   ymPtie0gPK68T2B3xZqgD8hsAeO6OkRL3uV5CeWDu2h3TI+AxRK7kFPHJ
   1iJfApqv3hL/t9zG8iKmacZPsmtIkjvnHrvoUxtCuReMpt6ARE9NeV15i
   tf3A1R/uk1yWY+5rnVt+8pmEsrXR+NkhZA2vdXEXsiTRUzZwWswN2W5RN
   ZJpUfBVuS5HuyzsRxt+oWb5I/NuGGVolEv/gyH5Qd2FdKPwmaJME2Ii5d
   A==;
X-CSE-ConnectionGUID: pwKNWpSMQSid8NZ/wklJJA==
X-CSE-MsgGUID: UF2ibNYSTCWylwLOawa1NQ==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="17887323"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 22:53:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 22:53:05 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 22:52:57 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Date: Wed, 20 Mar 2024 11:22:08 +0530
Subject: [PATCH 2/3] dt-bindings: mtd: atmel-nand: add atmel pmecc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240320-linux-next-nand-yaml-v1-2-2d2495363e88@microchip.com>
References: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
In-Reply-To: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
X-Mailer: b4 0.13.0

Add bindings for programmable multibit error correction code controller
(PMECC).

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 .../devicetree/bindings/mtd/atmel-nand.txt         | 70 ----------------------
 .../devicetree/bindings/mtd/atmel-pmecc.yaml       | 58 ++++++++++++++++++
 2 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index e332515c499a..1934614a9298 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -1,73 +1,3 @@
-* ECC engine (PMECC) bindings:
-
-Required properties:
-- compatible: should be one of the following
-	"atmel,at91sam9g45-pmecc"
-	"atmel,sama5d4-pmecc"
-	"atmel,sama5d2-pmecc"
-	"microchip,sam9x60-pmecc"
-	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
-- reg: should contain 2 register ranges. The first one is pointing to the PMECC
-       block, and the second one to the PMECC_ERRLOC block.
-
-* SAMA5 NFC I/O bindings:
-
-SAMA5 SoCs embed an advanced NAND controller logic to automate READ/WRITE page
-operations. This interface to this logic is placed in a separate I/O range and
-should thus have its own DT node.
-
-- compatible: should be "atmel,sama5d3-nfc-io", "syscon".
-- reg: should contain the I/O range used to interact with the NFC logic.
-
-Example:
-
-	nfc_io: nfc-io@70000000 {
-		compatible = "atmel,sama5d3-nfc-io", "syscon";
-		reg = <0x70000000 0x8000000>;
-	};
-
-	pmecc: ecc-engine@ffffc070 {
-		compatible = "atmel,at91sam9g45-pmecc";
-                reg = <0xffffc070 0x490>,
-                      <0xffffc500 0x100>;
-	};
-
-	ebi: ebi@10000000 {
-		compatible = "atmel,sama5d3-ebi";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		atmel,smc = <&hsmc>;
-		reg = <0x10000000 0x10000000
-		       0x40000000 0x30000000>;
-		ranges = <0x0 0x0 0x10000000 0x10000000
-			  0x1 0x0 0x40000000 0x10000000
-			  0x2 0x0 0x50000000 0x10000000
-			  0x3 0x0 0x60000000 0x10000000>;
-		clocks = <&mck>;
-
-                nand_controller: nand-controller {
-			compatible = "atmel,sama5d3-nand-controller";
-			atmel,nfc-sram = <&nfc_sram>;
-			atmel,nfc-io = <&nfc_io>;
-			ecc-engine = <&pmecc>;
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges;
-
-			nand@3 {
-				reg = <0x3 0x0 0x800000>;
-				atmel,rb = <0>;
-
-				/*
-				 * Put generic NAND/MTD properties and
-				 * subnodes here.
-				 */
-			};
-		};
-	};
-
------------------------------------------------------------------------
-
 Deprecated bindings (should not be used in new device trees):
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/mtd/atmel-pmecc.yaml b/Documentation/devicetree/bindings/mtd/atmel-pmecc.yaml
new file mode 100644
index 000000000000..872401e9dda3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-pmecc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/atmel-pmecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip pmecc controller
+
+maintainers:
+  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
+
+description: |
+  Bindings for microchip Programmable Multibit Error Correction Code
+  Controller (PMECC). pmecc is a programmable BCH encoder/decoder. This
+  block is passed as the value to the "ecc-engine" property of microchip
+  nand flash controller node.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9g45-pmecc
+          - atmel,sama5d2-pmecc
+          - atmel,sama5d4-pmecc
+          - microchip,sam9x60-pmecc
+          - microchip,sam9x7-pmecc
+      - items:
+          - const: microchip,sam9x60-pmecc
+          - const: atmel,at91sam9g45-pmecc
+
+  reg:
+    description:
+      The first should point to the PMECC block. The second should point to the
+      PMECC_ERRLOC block.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,sam9x7-pmecc
+    then:
+      properties:
+        clocks:
+          description:
+            The clock source for pmecc controller
+          maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pmecc: ecc-engine@ffffc070 {
+            compatible = "microchip,sam9x7-pmecc";
+            reg = <0xffffe000 0x300>,
+                  <0xffffe600 0x100>;
+            clocks = <&pmc 2 48>;
+    };

-- 
2.25.1


