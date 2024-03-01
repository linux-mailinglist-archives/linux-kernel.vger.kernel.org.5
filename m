Return-Path: <linux-kernel+bounces-87869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B234086DA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57FF1C21410
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A595102D;
	Fri,  1 Mar 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY4wL1QZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1E47F63;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264161; cv=none; b=HfzKfQ/bjVReWZStN1MYU461qu4kmcOK7lSCu3fZ6wyxmcknMVEmx+V/rbbmS0dolpN4UAfqJKbJZduF2GSTFmNMccFRWV1FGmBvxo62KrBeFL5ETD00lYzEKh8qxw/qITVAB8jXiB/ZN33g7wUh1JUUOpx1HH8yHfDwvjF45lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264161; c=relaxed/simple;
	bh=Mv+wjnpaqjDPxpuudt6hmB75f7eiz4A9FMh4nOvAHfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNykv03MT7gPN+RX9arT39Rp3gVAB75LENiM0uO6LK/2JTEPSmHImMMaIdo5LdZUVpKaJXhN4fWjKagyQTYJiF7EeErfeUL9/ZwYY0M489joJlsB7A5rsBPr/+KIDYNl9yksGzqeY81Gsof2ZuIG7oXBoSmi/v0V3Chwmyi5cNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY4wL1QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C541C43141;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=Mv+wjnpaqjDPxpuudt6hmB75f7eiz4A9FMh4nOvAHfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aY4wL1QZZIKTXEhVFS9tdpnvD6LFRYXiMfym3JCw552ajEVxw895UnVXlIGaHtKYj
	 NEG7deqEbwWuAOhENeKXg4b1V9JJMBi0DBLVDt5d1CfruW+pXY+87e+mK+hHShBnWT
	 /bu6/MWY71E9eAU5ozHrjtXm8U92QxMgXg8+hfBkuuynGhrAk/FrLPp6AJ5UeWcZ8i
	 Wt778GJuw3U0g89xj9R8vKJlZxocuIqmQMjeWQphP5ZkykCpiNfS3lE4N5yw1W1JH2
	 I+ZOFHRsnUsL8nX/+AvqLHcawNjhPgNoPNOnd+tfkg93mW0nT/BSWb8kls3Jv1Y054
	 wK9P9oYPGQnRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF5C54E59;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:35:57 +0800
Subject: [PATCH net-next v7 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-4-45823597d4d4@outlook.com>
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
In-Reply-To: <20240301-net-v7-0-45823597d4d4@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=5303;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=Y31W+EBTMTCB+g3jeFUiVgLCSMs5MTAdgXmolrXBmrQ=;
 b=U3x1tHE7aPBoRfqnNe5Vdo+X2BhLWZlb9syW0kR5I+pLw5+r2g3d+SFhX9MPp7GjgJgUk2doh
 mA7/+QCl3qrC0OO38YZ3dfj4u+V2CKxqjqHGcF2sZNSYRcHer4nXe+D
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Convert the old text binding to new YAML.

While at it, make some changes to the binding:
- The version numbers are not documented publicly. The version also does
not change programming interface. Remove it until it's really needed.
- A few clocks are missing in old binding file. Add them to match the real
hardware.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
 .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
 2 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
new file mode 100644
index 000000000000..ba207f2c9ae4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -0,0 +1,89 @@
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
+    items:
+      - enum:
+          - hisilicon,hi3516cv300-femac
+      - const: hisilicon,hisi-femac
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
+        compatible = "hisilicon,hi3516cv300-femac", "hisilicon,hisi-femac";
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


