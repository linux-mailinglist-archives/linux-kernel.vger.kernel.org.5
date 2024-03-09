Return-Path: <linux-kernel+bounces-97880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2587711E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D2C1F217AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0423FBAC;
	Sat,  9 Mar 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsG6KwUX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BA383BE;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987184; cv=none; b=CG+4wcUS59uln3B0nsXvuuUjQ3cdMzOCQA9kS6a0MDceBdfeQ1Yu3XA8cQ0rQOd+hpUGe6lLgOgUVdleS1uR2yIOFXntbtLMJSlOOWR9rVDPLkP4S35Ti2tcL6utJBQv4ua4Wxm3PVpBaVDhGadkSuGxCvmLVGmNSUnnwCWPP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987184; c=relaxed/simple;
	bh=e0q0yGSRFFLkhf3KJ0mtgBe9DUGdlUyvkBBfylc5F/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTP5KYXutclOqA/ynrcXlMHVDXvZvEVz7Hak8yGO5uCKipkQWMzu+3BndtqFc6raI7GvExx8tGIDLbHhFO2a72NS0De4Z/Kjs0SqrQ2SaFwqseCf/LbyPKRisUFHPsxBwMluxp8NCIxB/o4RGkOr8sNb3P0c5dSwYhK/O50RQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsG6KwUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69FA8C433B2;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=e0q0yGSRFFLkhf3KJ0mtgBe9DUGdlUyvkBBfylc5F/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SsG6KwUXMb0GuZ0YTQ3sHlRPnz521INSJLNpij/FwFsBKtgSV/8IplPQBTvOxrYi7
	 WEH5VtI6Wn080L0fH7iiTeR6Vl5ay5uqGildkojzir3nfRZAZBOXKRbEql2x4nQWO4
	 ExaV9hGEUjg6pa5NFc4e3HNhShvim0lLbbjn3plUQ5Cg+k53uiHrl3boySfZ7fqH3g
	 tLzdzz/u8gnXja9jThyraM/ePxxxSpeHy2RtrHG+kNaykBMLmhtNHnWT4poK/XwGjP
	 QzgS4iui8kBJbdkl/FeKBliO3g7S+ZSrlAI8q2wcMhUma9UuO0GUlCSTAH0+zxOsst
	 v/xAd4INmidww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F191C54E5D;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:26 +0800
Subject: [PATCH net-next v11 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-4-eb99b76e4a21@outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
In-Reply-To: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=5287;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=FclGbNt5IHnTCzv0cmPEOdaR/+V9vDaeVaHJ31VX4FE=;
 b=f1/QbCf0lOoaAD0ITLMjJRxOButfePhQsNssr3b0UuyBDzIS6NhXGX0PI9Jqt+2uiXWS0+6E7
 /A2VbO5H3GcDCLBBV8f3vdLmX0UkG4inWfB4ukUv1yL3KDTdmw7Pp0j
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Convert the old text binding to new YAML.

While at it, make some changes to the binding:
- The version numbers are not documented publicly. The version also does
not change programming interface. Remove it until it's really needed.
- A few clocks are missing in old binding file. Add them to match the real
hardware.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac.yaml         | 87 ++++++++++++++++++++++
 .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
 2 files changed, 87 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
new file mode 100644
index 000000000000..3344d3bfefb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Fast Ethernet MAC controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@foxmail.com>
+
+allOf:
+  - $ref: ethernet-controller.yaml
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hi3516cv300-femac
+
+  reg:
+    items:
+      - description: The first region is the MAC core register base and size.
+      - description: The second region is the global MAC control register.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC main clock
+      - description: MAC bus interface clock
+      - description: PHY clock
+
+  clock-names:
+    items:
+      - const: mac
+      - const: macif
+      - const: phy
+
+  resets:
+    items:
+      - description: MAC reset signal
+      - description: PHY reset signal
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  hisilicon,phy-reset-delays-us:
+    description: PHY reset timing requirement (in micro seconds).
+      The integrated PHY usually have a special reset timing sequence and must
+      interact with MAC controller to accomplish the entire reset procedure. So
+      these properties belong to MAC controller, not PHY.
+    items:
+      - description: pre-reset delay for PHY
+      - description: reset pulse for PHY
+      - description: post-reset delay for PHY
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - phy-mode
+  - phy-handle
+  - hisilicon,phy-reset-delays-us
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@10090000 {
+        compatible = "hisilicon,hi3516cv300-femac";
+        reg = <0x10090000 0x1000>, <0x10091300 0x200>;
+        interrupts = <12>;
+        clocks = <&clk_femac>, <&clk_femacif>, <&clk_fephy>;
+        clock-names = "mac", "macif", "phy";
+        resets = <&crg 0xec 0>, <&crg 0xec 3>;
+        reset-names = "mac", "phy";
+        mac-address = [00 00 00 00 00 00];
+        phy-mode = "mii";
+        phy-handle = <&fephy>;
+        hisilicon,phy-reset-delays-us = <10000 20000 20000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.txt b/Documentation/devicetree/bindings/net/hisilicon-femac.txt
deleted file mode 100644
index 5f96976f3cea..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Hisilicon Fast Ethernet MAC controller
-
-Required properties:
-- compatible: should contain one of the following version strings:
-	* "hisilicon,hisi-femac-v1"
-	* "hisilicon,hisi-femac-v2"
-	and the soc string "hisilicon,hi3516cv300-femac".
-- reg: specifies base physical address(s) and size of the device registers.
-  The first region is the MAC core register base and size.
-  The second region is the global MAC control register.
-- interrupts: should contain the MAC interrupt.
-- clocks: A phandle to the MAC main clock.
-- resets: should contain the phandle to the MAC reset signal(required) and
-	the PHY reset signal(optional).
-- reset-names: should contain the reset signal name "mac"(required)
-	and "phy"(optional).
-- phy-mode: see ethernet.txt [1].
-- phy-handle: see ethernet.txt [1].
-- hisilicon,phy-reset-delays-us: triplet of delays if PHY reset signal given.
-	The 1st cell is reset pre-delay in micro seconds.
-	The 2nd cell is reset pulse in micro seconds.
-	The 3rd cell is reset post-delay in micro seconds.
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt[1].
-
-[1] Documentation/devicetree/bindings/net/ethernet.txt
-
-Example:
-	hisi_femac: ethernet@10090000 {
-		compatible = "hisilicon,hi3516cv300-femac","hisilicon,hisi-femac-v2";
-		reg = <0x10090000 0x1000>,<0x10091300 0x200>;
-		interrupts = <12>;
-		clocks = <&crg HI3518EV200_ETH_CLK>;
-		resets = <&crg 0xec 0>,<&crg 0xec 3>;
-		reset-names = "mac","phy";
-		mac-address = [00 00 00 00 00 00];
-		phy-mode = "mii";
-		phy-handle = <&phy0>;
-		hisilicon,phy-reset-delays-us = <10000 20000 20000>;
-	};

-- 
2.43.0


