Return-Path: <linux-kernel+bounces-71999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14D85ADB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209B81F2299B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A354FAA;
	Mon, 19 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2QOFmIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8353E1E;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378079; cv=none; b=DFNcgaPgl0HewozGJF5kRhJ0d7ws7Ruo0PxKg7mQtO7ZreyOf3FAJr6lWFUIldX2GSquFRODGw+Mg2hdeAYW24cVpBbCeghHT+5Ru1+zN8Y1Hr3hC3sEqLcXPGwLC0PyYGtDRMG02ZEzsQMu/4yY8gD1Mg1tva7Bz++maPllhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378079; c=relaxed/simple;
	bh=mxN1ZkEXW2mgTzfWWUyIZjDudn+fs3HVQgmWVyZDq4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4VwMtfhiblIqwcWRn65ChSt1ZnGqsp+NODV5X7qFpeDVaQ4sB66nFJDnQzxr6kE8jXgO6wAPDUOxWWuSFNfiFEOVjoXQa9A6htSo2mNCh3CcmxUD1N9GKrqY7JW7rYzV+aEYLewXOh7FpS3snScPWght9YH7yx0a6Kg7TUgmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2QOFmIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36231C433C7;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708378079;
	bh=mxN1ZkEXW2mgTzfWWUyIZjDudn+fs3HVQgmWVyZDq4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y2QOFmIRHjyFbPkJMUN51fXL0P40hmihbedRpirrjAD3xk7igcPVnvCqOgPId1JVK
	 LzRLk3KL1xOd0nLHmdLeuB673w5QCtnUgzWsJCk8cwl4C3iqmHcwbThPIRsVICe8Dl
	 MkB+b9fM7JYVXO4oSYMjIALtwmNWq7WNFQl94t+Q7YZt6GRfTQ0qkf8+xFXd+K4Zqk
	 ib2vZiYIDPw1ppwISvyVIGmP6DUWzc4dt4uVEnEDM2aoGt5CsEZWSi2np8O5xPQ3rK
	 P7n0PuiIG1oqvXOKmhNcVwryCW9VNo8qgu9aPI4146oY5YaQDtzdNBkkWTI2er6DW2
	 DHXO6ixZQcmMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D63C48BF8;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 05:27:58 +0800
Subject: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
In-Reply-To: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708378078; l=5498;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=U6z/RQ0uF+ViR2t96pmwIWGjVhr4jNGIoMn6+B3Bm2E=;
 b=E5hi8gD7t05khy6nno5iubPtNEc5E3qKveeyoqOyV7D+B/Bnny83UrvRJVgHrakxYcTMKO4j2
 TAIcn+qUQNRBiledFodaXR778qj8Zk5EJf3bKAYV+NlgJvttEPEvwxS
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
list due to prior driver change.

Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
compatible lists.

Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
 2 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
new file mode 100644
index 000000000000..1b57e0396209
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -0,0 +1,95 @@
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
+    items:
+      - enum:
+          - hisilicon,hi3798cv200-usb2-phy
+          - hisilicon,hi3798mv100-usb2-phy
+      - const: hisilicon,inno-usb2-phy
+
+  reg:
+    maxItems: 1
+    description: Should be the address space for PHY configuration register in
+      peripheral controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC,
+      or direct MMIO address space.
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
+        descrption: should be the port index (if under a perictrl node)
+          or port address space
+
+      '#phy-cells':
+        const: 0
+
+      resets:
+        maxItems: 1
+
+    required:
+      - reg
+      - '#phy-cells'
+      - resets
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
+    usb2-phy@120 {
+        compatible = "hisilicon,hi3798cv200-usb2-phy", "hisilicon,inno-usb2-phy";
+        reg = <0x120 0x4>;
+        clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+        resets = <&crg 0xbc 4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy@0 {
+            reg = <0>;
+            #phy-cells = <0>;
+            resets = <&crg 0xbc 8>;
+        };
+
+        phy@1 {
+            reg = <1>;
+            #phy-cells = <0>;
+            resets = <&crg 0xbc 9>;
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


