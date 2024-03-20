Return-Path: <linux-kernel+bounces-108465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F043880AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CF3B21E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548071E877;
	Wed, 20 Mar 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DcQ2s9Tc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121F14A96;
	Wed, 20 Mar 2024 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914000; cv=none; b=t2Uvm3++rtGXeexg3iWmcAWQQuipEDtoa3jrfdsWhw5cp0bGEdA4/OFO0UCc+uzsYFPhxB6DUw3mZ5YNNlkZxakySy5ie5SgOuF1xevkktFeKMxTtG2WyJu1q8tSnK4USOcj0zjadMnAevDwKssdKalEJ+uWRT2Ui8xNgFGKLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914000; c=relaxed/simple;
	bh=s8Lr1M8RUL7PqBz81PGymM1Ltwj2a+he6G8+75T/hPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y/QHQhxIOAgqPb9ee5bcc+2f+fR+yFDVvSGUgF9gNw1/y4LEnCkbLgc0OEwACfCdxC8smeVQ4ASVNy4ojGmeLbH33ApGVpKTXOgJ2M74lluSfFtNci0lrdaDrd7+cqkwWd9tZmurHnxms7n62R49BTV3n8DCg2dhC6ng59Rd7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DcQ2s9Tc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710913998; x=1742449998;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s8Lr1M8RUL7PqBz81PGymM1Ltwj2a+he6G8+75T/hPo=;
  b=DcQ2s9TcWXLLbVbnpJnPj6AAzfrIxr0ZDvVpJgGnBWSxBvI5tsi28PCS
   hxm1KgjN1sw3QBZyshVo+GPzVkZGmzVSLsTE3JFwZIZGloUcEVNVh6fOD
   W1mbINsCSWjfJOqAwBECAoqajaN5aFX7CkpH8UKNIygZpx5qS5vseDl8t
   MQaDeRremoOxmSEDE8eEV+eJ1FSQpQdf5scrWyVkIVai3cNiAFAJ2ElBR
   WfX0i8zxEAuzf9h3auoPera0IaeRKZCiDDlq2fK41kdGAUOrFJM51apqq
   yAD5e0uV+Y4/JGbn1+v+RnAKiVrzy/XifB8mGjdJ6MMQziXVc7slM9eMx
   Q==;
X-CSE-ConnectionGUID: pwKNWpSMQSid8NZ/wklJJA==
X-CSE-MsgGUID: cccJKGy2TKiNMJWaOEdObQ==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="17887329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 22:53:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 22:53:11 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 22:53:05 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Date: Wed, 20 Mar 2024 11:22:09 +0530
Subject: [PATCH 3/3] dt-bindings: mtd: atmel-nand: add deprecated bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240320-linux-next-nand-yaml-v1-3-2d2495363e88@microchip.com>
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

Add nand bindings for legacy nand controllers. These bindings are not used
with the new device trees. This is still maintained to support legacy dt
bindings.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 .../bindings/mtd/atmel-nand-deprecated.yaml        | 156 +++++++++++++++++++++
 .../devicetree/bindings/mtd/atmel-nand.txt         | 116 ---------------
 2 files changed, 156 insertions(+), 116 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.yaml b/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.yaml
new file mode 100644
index 000000000000..c8922ab0f1d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/atmel-nand-deprecated.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel NAND flash controller deprecated bindings
+
+maintainers:
+  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
+
+description: |
+  This should not be used in the new device trees.
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91rm9200-nand
+      - atmel,sama5d2-nand
+      - atmel,sama5d4-nand
+
+  reg:
+    description:
+      should specify localbus address and size used for the chip, and
+      hardware ECC controller if available. If the hardware ECC is PMECC,
+      it should contain address and size for PMECC and PMECC Error Location
+      controller.  The PMECC lookup table address and size in ROM is
+      optional. If not specified, driver will build it in runtime.
+
+  atmel,nand-addr-offset:
+    description:
+      offset for the address latch.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  atmel,nand-cmd-offset:
+    description:
+      offset for the command latch.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  "#address-cells":
+    description:
+      Must be present if the device has sub-nodes representing partitions
+
+  "#size-cells":
+    description:
+      Must be present if the device has sub-nodes representing partitions.
+
+  gpios:
+    description:
+      specifies the gpio pins to control the NAND device. detect is an
+      optional gpio and may be set to 0 if not present.
+
+  atmel,nand-has-dma:
+    description:
+      support dma transfer for nand read/write.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  atmel,has-pmecc:
+    description:
+      enable Programmable Multibit ECC hardware, capable of BCH encoding
+      and decoding, on devices where it is present.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nand-on-flash-bbt:
+    description:
+      enable on flash bbt option if not present false
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nand-ecc-mode:
+    description:
+      operation mode of the NAND ecc mode, soft by default.  Supported
+    enum:
+      [none, soft, hw, hw_syndrome, hw_oob_first, soft_bch]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  atmel,pmecc-cap:
+    description:
+      error correct capability for Programmable Multibit ECC Controller. If
+      the compatible string is "atmel,sama5d2-nand", 32 is also valid.
+    enum:
+      [2, 4, 8, 12, 24]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  atmel,pmecc-sector-size:
+    description:
+      sector size for ECC computation.
+    enum:
+      [512, 1024]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  atmel,pmecc-lookup-table-offset:
+    description:
+      includes two offsets of lookup table in ROM for different sector
+      size. First one is for sector size 512, the next is for sector size
+      1024. If not specified, driver will build the table in runtime.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  nand-bus-width:
+    description:
+      nand bus width
+    enum:
+      [8, 16]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - atmel,nand-addr-offset
+  - atmel,nand-cmd-offset
+  - "#address-cells"
+  - "#size-cells"
+  - gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand0: nand@40000000,0 {
+            compatible = "atmel,at91rm9200-nand";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x40000000 0x10000000
+                   0xffffe800 0x200>;
+            atmel,nand-addr-offset = <21>;	/* ale */
+            atmel,nand-cmd-offset = <22>;	/* cle */
+            nand-on-flash-bbt;
+            nand-ecc-mode = "soft";
+            gpios = <&pioC 13 0	/* rdy */
+                     &pioC 14 0 /* nce */
+                     0		/* cd */
+                    >;
+    };
+  - |
+    /* for PMECC supported chips */
+    nand1@40000000 {
+            compatible = "atmel,at91rm9200-nand";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x40000000 0x10000000	/* bus addr & size */
+                   0xffffe000 0x00000600	/* PMECC addr & size */
+                   0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
+                   0x00100000 0x00100000>;	/* ROM addr & size */
+
+            atmel,nand-addr-offset = <21>;	/* ale */
+            atmel,nand-cmd-offset = <22>;	/* cle */
+            nand-on-flash-bbt;
+            nand-ecc-mode = "hw";
+            atmel,has-pmecc;	/* enable PMECC */
+            atmel,pmecc-cap = <2>;
+            atmel,pmecc-sector-size = <512>;
+            atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
+            gpios = <&pioD 5 0	/* rdy */
+                     &pioD 4 0	/* nce */
+                     0		/* cd */
+                    >;
+    };
diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
deleted file mode 100644
index 1934614a9298..000000000000
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ /dev/null
@@ -1,116 +0,0 @@
-Deprecated bindings (should not be used in new device trees):
-
-Required properties:
-- compatible: The possible values are:
-	"atmel,at91rm9200-nand"
-	"atmel,sama5d2-nand"
-	"atmel,sama5d4-nand"
-- reg : should specify localbus address and size used for the chip,
-	and hardware ECC controller if available.
-	If the hardware ECC is PMECC, it should contain address and size for
-	PMECC and PMECC Error Location controller.
-	The PMECC lookup table address and size in ROM is optional. If not
-	specified, driver will build it in runtime.
-- atmel,nand-addr-offset : offset for the address latch.
-- atmel,nand-cmd-offset : offset for the command latch.
-- #address-cells, #size-cells : Must be present if the device has sub-nodes
-  representing partitions.
-
-- gpios : specifies the gpio pins to control the NAND device. detect is an
-  optional gpio and may be set to 0 if not present.
-
-Optional properties:
-- atmel,nand-has-dma : boolean to support dma transfer for nand read/write.
-- nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
-  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
-  "soft_bch".
-- atmel,has-pmecc : boolean to enable Programmable Multibit ECC hardware,
-  capable of BCH encoding and decoding, on devices where it is present.
-- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
-  Controller. Supported values are: 2, 4, 8, 12, 24. If the compatible string
-  is "atmel,sama5d2-nand", 32 is also valid.
-- atmel,pmecc-sector-size : sector size for ECC computation. Supported values
-  are: 512, 1024.
-- atmel,pmecc-lookup-table-offset : includes two offsets of lookup table in ROM
-  for different sector size. First one is for sector size 512, the next is for
-  sector size 1024. If not specified, driver will build the table in runtime.
-- nand-bus-width : 8 or 16 bus width if not present 8
-- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
-
-Nand Flash Controller(NFC) is an optional sub-node
-Required properties:
-- compatible : "atmel,sama5d3-nfc".
-- reg : should specify the address and size used for NFC command registers,
-        NFC registers and NFC SRAM. NFC SRAM address and size can be absent
-        if don't want to use it.
-- clocks: phandle to the peripheral clock
-Optional properties:
-- atmel,write-by-sram: boolean to enable NFC write by SRAM.
-
-Examples:
-nand0: nand@40000000,0 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = <0x40000000 0x10000000
-	       0xffffe800 0x200
-	      >;
-	atmel,nand-addr-offset = <21>;	/* ale */
-	atmel,nand-cmd-offset = <22>;	/* cle */
-	nand-on-flash-bbt;
-	nand-ecc-mode = "soft";
-	gpios = <&pioC 13 0	/* rdy */
-		 &pioC 14 0 	/* nce */
-		 0		/* cd */
-		>;
-	partition@0 {
-		...
-	};
-};
-
-/* for PMECC supported chips */
-nand0: nand@40000000 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = < 0x40000000 0x10000000	/* bus addr & size */
-		0xffffe000 0x00000600	/* PMECC addr & size */
-		0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
-		0x00100000 0x00100000	/* ROM addr & size */
-		>;
-	atmel,nand-addr-offset = <21>;	/* ale */
-	atmel,nand-cmd-offset = <22>;	/* cle */
-	nand-on-flash-bbt;
-	nand-ecc-mode = "hw";
-	atmel,has-pmecc;	/* enable PMECC */
-	atmel,pmecc-cap = <2>;
-	atmel,pmecc-sector-size = <512>;
-	atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
-	gpios = <&pioD 5 0	/* rdy */
-		 &pioD 4 0	/* nce */
-		 0		/* cd */
-		>;
-	partition@0 {
-		...
-	};
-};
-
-/* for NFC supported chips */
-nand0: nand@40000000 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-        ...
-        nfc@70000000 {
-		compatible = "atmel,sama5d3-nfc";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		clocks = <&hsmc_clk>
-		reg = <
-			0x70000000 0x10000000	/* NFC Command Registers */
-			0xffffc000 0x00000070	/* NFC HSMC regs */
-			0x00200000 0x00100000	/* NFC SRAM banks */
-		>;
-	};
-};

-- 
2.25.1


