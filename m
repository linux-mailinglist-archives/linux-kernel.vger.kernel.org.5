Return-Path: <linux-kernel+bounces-95429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585DC874D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0251C20A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DEA12B142;
	Thu,  7 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9m/SjU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A331292CE;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811289; cv=none; b=dgo31IK7PogLlJpj/zVzAZRvFML/MDGPyyoX5BSpJoisvf3DXKn2AsO9iVk56qqmqkXt/te8lveZvJUtdKlFgVmvy3AQqY/9YTuMzK0yeZHi1XBpEefo6rgtKO2XsUxJH3bh/P1p8IWRQlMwiyATqEvegHrIEuYVXfbzCLTxUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811289; c=relaxed/simple;
	bh=c01HggYsG7UVeihptCV7G01V4aTHo04UjLf74pTqkvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auz8SwcYzlXl4h0o/D3fkTeBy2/ubdRDfX80tjTwGCr8W2YAN07+YxGY8KTfypak73eSBRtSA0/pbczRPLZVfuUskIz1eb56PIgQ0R+dRnAOOVeTiCktSNp9rdXZyJypr/la1p3OXjNshJLu17lPsCVXgI24ufujLdMtRWfON/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9m/SjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB42C43330;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=c01HggYsG7UVeihptCV7G01V4aTHo04UjLf74pTqkvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=on9m/SjUODPRzPD8K+bdgJWPTmavAHeTFgNWE2BYja2WkJELSOVGJD/m/mwBMMeWs
	 7TZNSvtFXQZleWAe0ilXBjRbwuPSVxW2XyuJk5AnlRsq+g3a2rX/kxrrBbeGAQqvkx
	 myLI/KpHU7zFJi3bpPtQh0fi67QRRgikvf1PllWFGfsgIWWgzTY73cUhY573JilSJa
	 W5iZ4tcY6RwnOz/KM9Jnw7Jue7XT/6TyPpgOHQ4sh8pQGYb3rLLpl0L+O/BCrtF8V4
	 ZaN74DXljr0X65kGb4KSYvQdPYlRN+VZuube6KcPEtxuW39Kjb39M6HN505YGNJh2m
	 6BsUXndJDoI2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D02C54E5C;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:50 +0800
Subject: [PATCH net-next v9 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-4-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=5220;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=uiezMY2DCteYHM0P+l+HGnsL5XUDuLgoCSyIIdl/Lc4=;
 b=HummQZy6B+cyoBBY2k7pxtBhG3NUCeUvMyaTQZH7zi6VlZzwUpUI1Arv15UsVOfXy0JeFfyzr
 yQkZhqgAvAPAxd3CuOGzQWzaIIjflUr72W+IHJaxkno1RuHY8vtcJCW
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


