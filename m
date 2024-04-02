Return-Path: <linux-kernel+bounces-128508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4F895BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E21C22C40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582C15B542;
	Tue,  2 Apr 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrOsOdEx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78615B573;
	Tue,  2 Apr 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082775; cv=none; b=hR+j99a7Lil32FP8FffD7paxQMl/tGfLAGY10PwHyF6uuBfMu6TPqx9BW5kKXWwbCIlbgCZfq7cNwdo4nA3/FjM4nm7aD83gtSGmAd/6ZX7+myufPRoUlnTzIFKsLE+2qJ64xWE9m0m0lFS5cAALV/aQrf0feqa6sM+G1iJVmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082775; c=relaxed/simple;
	bh=Tkc1wkxhjy4lTBWpmN6ywzBBN9sIhelXSsaqaqbZTRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNlP2DoXRWElgaWg08YGTEB0yzBPe0nm1V3LrDOMNjpPqXL5TJBVDCb4u+LNcootA2q/BrqIx7Fo5F0irE0/7io+SXgq2+oSn/PN6xScBgfZ+PK++cvtgHDn9ZfX/h9FdMYu63pAXOC7udZzA3O0m/LFQG1qDedvHGNHnItbB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrOsOdEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FCCC433F1;
	Tue,  2 Apr 2024 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082775;
	bh=Tkc1wkxhjy4lTBWpmN6ywzBBN9sIhelXSsaqaqbZTRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrOsOdEx9YsalLcENbahAGFye7mnX2y3D7cOgpoypb2pTm1URyl5GgAzWqnTSVOxX
	 Z/IKX7ZVW90KNdO5s98eIUEROBRYoxQuJu9E28GVV/5UWZ0cXdHzUjFnzpm0Dzrwjl
	 ceFOOODlI58CgTYbw3gyvgwavasfL4qHMAHtruHk5y1teu3oXDxEqgtstCrtHFLUpV
	 VqDZdgz7y5cX/V9Trt98sOIUPbApm4WkOG1cD+JfLxuu88L9ILBOBEjrZLioliXP4t
	 dlmyR41tYITuckKVL0K7wipww5qg/OqP1rVNE8bE5w7yeX2NOX8RAkcPhWwaUAlE+l
	 JQQNd1AgZghMg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: marvell: espressobin-ultra: fix Ethernet Switch unit address
Date: Tue,  2 Apr 2024 20:32:40 +0200
Message-Id: <20240402183240.49193-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402183240.49193-1-krzk@kernel.org>
References: <20240402183240.49193-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Espressobin Ultra DTS includes Espressobin DTSI which defines
ethernet-switch@1 node.  The Ultra DTS overrides "reg" to 3, but that
leaves still old unit address which conflicts with the new phy@1 node
(W=1 dtc warning):

  armada-3720-espressobin.dtsi:148.29-203.4: Warning (unique_unit_address_if_enabled): /soc/internal-regs@d0000000/mdio@32004/ethernet-switch@1: duplicate unit-address (also used in node /soc/internal-regs@d0000000/mdio@32004/ethernet-phy@1)

Fix this by deleting ethernet-switch@1 node and merging original node
with code from Ultra DTS into new ethernet-switch@3.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 .../marvell/armada-3720-espressobin-ultra.dts | 104 +++++++++++-------
 1 file changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 870bb380a40a..b3cc2b7b5d19 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -114,54 +114,84 @@ &usb3 {
 };
 
 &mdio {
+	/* Switch is @3, not @1 */
+	/delete-node/ ethernet-switch@1;
 	extphy: ethernet-phy@1 {
 		reg = <1>;
 
 		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
 	};
-};
 
-&switch0 {
-	reg = <3>;
+	switch0: ethernet-switch@3 {
+		compatible = "marvell,mv88e6085";
+		reg = <3>;
 
-	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
+		dsa,member = <0 0>;
 
-	ethernet-ports {
-		switch0port1: ethernet-port@1 {
-			reg = <1>;
-			label = "lan0";
-			phy-handle = <&switch0phy0>;
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0port0: ethernet-port@0 {
+				reg = <0>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			switch0port1: ethernet-port@1 {
+				reg = <1>;
+				label = "lan0";
+				phy-handle = <&switch0phy0>;
+			};
+
+			switch0port2: ethernet-port@2 {
+				reg = <2>;
+				label = "lan1";
+				phy-handle = <&switch0phy1>;
+			};
+
+			switch0port3: ethernet-port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy-handle = <&switch0phy2>;
+			};
+
+			switch0port4: ethernet-port@4 {
+				reg = <4>;
+				label = "lan3";
+				phy-handle = <&switch0phy3>;
+			};
+
+			switch0port5: ethernet-port@5 {
+				reg = <5>;
+				label = "wan";
+				phy-handle = <&extphy>;
+				phy-mode = "sgmii";
+			};
 		};
 
-		switch0port2: ethernet-port@2 {
-			reg = <2>;
-			label = "lan1";
-			phy-handle = <&switch0phy1>;
-		};
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-		switch0port3: ethernet-port@3 {
-			reg = <3>;
-			label = "lan2";
-			phy-handle = <&switch0phy2>;
-		};
-
-		switch0port4: ethernet-port@4 {
-			reg = <4>;
-			label = "lan3";
-			phy-handle = <&switch0phy3>;
-		};
-
-		switch0port5: ethernet-port@5 {
-			reg = <5>;
-			label = "wan";
-			phy-handle = <&extphy>;
-			phy-mode = "sgmii";
-		};
-	};
-
-	mdio {
-		switch0phy3: ethernet-phy@14 {
-			reg = <0x14>;
+			switch0phy0: ethernet-phy@11 {
+				reg = <0x11>;
+			};
+			switch0phy1: ethernet-phy@12 {
+				reg = <0x12>;
+			};
+			switch0phy2: ethernet-phy@13 {
+				reg = <0x13>;
+			};
+			switch0phy3: ethernet-phy@14 {
+				reg = <0x14>;
+			};
 		};
 	};
 };
-- 
2.34.1


