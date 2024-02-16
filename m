Return-Path: <linux-kernel+bounces-68861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB63858119
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A507B26404
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D4130E37;
	Fri, 16 Feb 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBxiFFNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCB12EBFB;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096887; cv=none; b=nZgfqsua1Qa+OPJPxMAIo4XgOXL0r76a+1AyAgOYxPXwbU79vBf0+ILY0pVt/yVCsGPGejaA1j3yLwnHQLeZ2zScZxZzFWxmsKwyB1PeFwJwIqFPXmthIFC5VK93oDW6hOtuwOhVRMAhtmelGjiHKSJrCXxB24LcYMjLltzhVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096887; c=relaxed/simple;
	bh=TRmVZH+PZ59+C0TEtARg738Y2o6iYiZC8Ky45LjLJSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNiPZUm5XRPNQK3wSfmHSw7X9aErZW/oK3yYTzdILhT+IJZcTYBkkp1ybsH7c+92mD6RvK9898Fvm5mcNmCq3T8HYQJLqf5/2xnGe7WJ7WxE9L7sbPqBSduXMkHcAWUbhjGrt/7e9me566OEGPxQJM/wv104/4Ze2R8G26IViA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBxiFFNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F17EC433F1;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096887;
	bh=TRmVZH+PZ59+C0TEtARg738Y2o6iYiZC8Ky45LjLJSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YBxiFFNiiyfTYhqoomzmP4UeXXGkxJuZ70x7AUZk/HagzZt57oafcUglg3Sl7nTcz
	 Gg/f7/HUpv2faOooIdsFcKsJFgVSHxVqtTbya/w0/G/1ZEkW05WDzUTpG8cw3qVLjv
	 btrcY90qgNuTJ5htK3OcayNa5WoB4C8HlGf8bLYVnup3EoktiWNZZ7b+wW9nUsiQTZ
	 ecN1Hxj7TfOVFcgmRrF5zZoucWSWLH1oyEjsQcpjDKIPjMnI8c9cILFwQ6keC3G3YB
	 PI0EzZVf0tXOXiYjpeX4m+Ra2pwGCNOSfRThJ/3YHiENQwLOA9+7VS+IpK8jxqRFDK
	 r3sI2hhe/8Uyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3944BC48BC4;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 23:21:01 +0800
Subject: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
In-Reply-To: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708096886; l=5966;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=l2ypu5YlW9CWMPkZmrwjgcd2IjIfU7LZ/QhuKeoEs5U=;
 b=RZhPg7bOXtCnLnhOnPvU31l6XXB2L3mNOEDisGfSglBCTAd29oMaVQfbWq6MOoAXduRzISDbH
 NW0AULX6Bm2Al+ajA/8kB5/HGXGgfc95jw0ePqdl+PFsRhAFn8QQDTP
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
compatible lists.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 115 +++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 -------------
 2 files changed, 115 insertions(+), 71 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
new file mode 100644
index 000000000000..73256eee10f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon HiSTB SoCs INNO USB2 PHY device
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+properties:
+  compatible:
+    minItems: 1
+    items:
+      - enum:
+          - hisilicon,hi3798cv200-usb2-phy
+          - hisilicon,hi3798mv100-usb2-phy
+      - const: hisilicon,inno-usb2-phy
+
+  reg:
+    maxItems: 1
+    description: |
+      Should be the address space for PHY configuration register in peripheral
+      controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
+      Or direct MMIO address space.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clocks:
+    maxItems: 1
+    description: reference clock
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  'phy@[0-9a-f]+':
+    type: object
+    additionalProperties: false
+    description: individual ports provided by INNO PHY
+
+    properties:
+      reg:
+        maxItems: 1
+
+      '#phy-cells':
+        const: 0
+
+      resets:
+        maxItems: 1
+
+    required: [reg, '#phy-cells', resets]
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+
+    peripheral-controller@8a20000 {
+        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
+        reg = <0x8a20000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x8a20000 0x1000>;
+
+        usb2-phy@120 {
+            compatible = "hisilicon,hi3798cv200-usb2-phy";
+            reg = <0x120 0x4>;
+            clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+            resets = <&crg 0xbc 4>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy@0 {
+                reg = <0>;
+                #phy-cells = <0>;
+                resets = <&crg 0xbc 8>;
+            };
+
+            phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+                resets = <&crg 0xbc 9>;
+            };
+        };
+
+        usb2-phy@124 {
+            compatible = "hisilicon,hi3798cv200-usb2-phy";
+            reg = <0x124 0x4>;
+            clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
+            resets = <&crg 0xbc 6>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy@0 {
+                reg = <0>;
+                #phy-cells = <0>;
+                resets = <&crg 0xbc 10>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
deleted file mode 100644
index 104953e849e7..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-Device tree bindings for HiSilicon INNO USB2 PHY
-
-Required properties:
-- compatible: Should be one of the following strings:
-	"hisilicon,inno-usb2-phy",
-	"hisilicon,hi3798cv200-usb2-phy".
-- reg: Should be the address space for PHY configuration register in peripheral
-  controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
-- clocks: The phandle and clock specifier pair for INNO USB2 PHY device
-  reference clock.
-- resets: The phandle and reset specifier pair for INNO USB2 PHY device reset
-  signal.
-- #address-cells: Must be 1.
-- #size-cells: Must be 0.
-
-The INNO USB2 PHY device should be a child node of peripheral controller that
-contains the PHY configuration register, and each device supports up to 2 PHY
-ports which are represented as child nodes of INNO USB2 PHY device.
-
-Required properties for PHY port node:
-- reg: The PHY port instance number.
-- #phy-cells: Defined by generic PHY bindings.  Must be 0.
-- resets: The phandle and reset specifier pair for PHY port reset signal.
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties
-
-Example:
-
-perictrl: peripheral-controller@8a20000 {
-	compatible = "hisilicon,hi3798cv200-perictrl", "simple-mfd";
-	reg = <0x8a20000 0x1000>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x0 0x8a20000 0x1000>;
-
-	usb2_phy1: usb2-phy@120 {
-		compatible = "hisilicon,hi3798cv200-usb2-phy";
-		reg = <0x120 0x4>;
-		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
-		resets = <&crg 0xbc 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb2_phy1_port0: phy@0 {
-			reg = <0>;
-			#phy-cells = <0>;
-			resets = <&crg 0xbc 8>;
-		};
-
-		usb2_phy1_port1: phy@1 {
-			reg = <1>;
-			#phy-cells = <0>;
-			resets = <&crg 0xbc 9>;
-		};
-	};
-
-	usb2_phy2: usb2-phy@124 {
-		compatible = "hisilicon,hi3798cv200-usb2-phy";
-		reg = <0x124 0x4>;
-		clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
-		resets = <&crg 0xbc 6>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb2_phy2_port0: phy@0 {
-			reg = <0>;
-			#phy-cells = <0>;
-			resets = <&crg 0xbc 10>;
-		};
-	};
-};

-- 
2.43.0


