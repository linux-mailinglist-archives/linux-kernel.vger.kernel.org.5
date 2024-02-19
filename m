Return-Path: <linux-kernel+bounces-71925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5F85ACA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B611C20A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F353E0D;
	Mon, 19 Feb 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqCbaPoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DC51C2C;
	Mon, 19 Feb 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372657; cv=none; b=HdIANu/hHrAt/b++nUir8TlXFvT21xv6ia7Kpm+jRm57/4teHL5njZvxE+GkkPHl9mX6OYoxNQhaoWM7kr0scXXmNT/P8uMcobIpu7o/rhvXdhQlorgUArzw6ixWYQIAV97MnwA1iQFrT78pE0kfRip/fZHN3ulpgzncpEoJE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372657; c=relaxed/simple;
	bh=9aIghlxeqzChANrPfA2YpDKFNRonntQEBzqWAmC5jDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gs/h0kGvtNJco0uK29OOJqXI36zg4G7CeHwsJ5oWLtQoZ/grU8mkIRaQAwdBRzfwX1eB5bzLqTdLh0ZUojKKPc4aJof1JaWOKbRiwyqPxPYjLkr74mPViMawaqUUNDKCD68zPGvK1tfvUj3vCbf5vfYkC5KwhThiTY4SZ0hWNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqCbaPoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E78E0C41674;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372657;
	bh=9aIghlxeqzChANrPfA2YpDKFNRonntQEBzqWAmC5jDk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lqCbaPoAsBp7fxpk86/VA5iNC0rEGT556w8oekvxYWdDM7oHHpLEA8i2dL6pb6+Oy
	 f4NuVo7qLCGN3thw4a2otJShagKtKpODFZ87ZcSTI/MnUyR3XSxNJ9wkZuydTV3ERn
	 H1QnbQpAS/FD7PSF134YSu73Qtz5Tk6RibjF6KE/wXY7DvLGWVtMvbx40qFWiu4UqL
	 Ma371OHwdw2sCBVvXoa90L8dsgYy3w8ffILLRB5ssoJDUDk9/hH4B0slVGLRi6ZbXP
	 Le/Bp6+Sx6NESFkOhdmwO0MRcCS8WrCLmEwDXBiHx/A43n2i3Yq0pLzkj3vVZmRH1W
	 RfuG4GpTrmA2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B8C54764;
	Mon, 19 Feb 2024 19:57:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:57:41 +0800
Subject: [PATCH net-next v3 6/6] dt-bindings: net: add hisilicon,hisi-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-net-v3-6-b68e5b75e765@outlook.com>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
In-Reply-To: <20240220-net-v3-0-b68e5b75e765@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708372656; l=3915;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Nts7rFC7ZJnOR4Zjj/ZOJP7dSjglr6qAZxoBphrP6Qs=;
 b=lKbGXB7F16qjB+dIqsrXXeb6lpS0Agnowg7HTPRq4IHnFat3Yje5aVFPHgw61R88LAwRCaNnM
 ja1UYPt7E14ArZynJWqZuu7lW4blGojCXiQ12R1FNXhO0aI5xCEgMMx
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Compared to previous txt based binding doc, the following changes are
made according to the TRM:

- Remove unmaintained Hi3516 SoC, add Hi3798MV200
- add MDIO subnode, because MDIO bus is integrated
- add ahb bus clock, phy clock and reset

Also remove "hisi-femac-v1/2" binding.

The difference between versions is unknown and not documented anywhere.
Nor is it used in driver. Remove it until it's needed in the future.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
new file mode 100644
index 000000000000..08158118c9c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -0,0 +1,117 @@
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
+          - hisilicon,hi3798mv200-femac
+      - const: hisilicon,hisi-femac
+
+  reg:
+    items:
+      - description: The first region is the MAC core register base and size.
+      - description: The second region is the global MAC control register.
+
+  ranges:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mac
+      - const: macif
+      - const: phy
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  hisilicon,phy-reset-delays-us:
+    items:
+      - description: The 1st cell is reset pre-delay in micro seconds.
+      - description: The 2nd cell is reset pulse in micro seconds.
+      - description: The 3rd cell is reset post-delay in micro seconds.
+
+patternProperties:
+  '^mdio@[0-9a-f]+$':
+    $ref: hisilicon,hisi-femac-mdio.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phy-connection-type
+  - phy-handle
+  - hisilicon,phy-reset-delays-us
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/histb-clock.h>
+
+    ethernet@9c30000 {
+        compatible = "hisilicon,hi3798mv200-femac", "hisilicon,hisi-femac";
+        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
+        ranges = <0x0 0x9c30000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg HISTB_ETH0_MAC_CLK>,
+                 <&crg HISTB_ETH0_MACIF_CLK>,
+                 <&crg 62>;
+        clock-names = "mac", "macif", "phy";
+        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
+        reset-names = "mac", "phy";
+        phy-handle = <&fephy>;
+        phy-connection-type = "mii";
+        // To be filled by bootloader
+        mac-address = [00 00 00 00 00 00];
+        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
+        status = "okay";
+
+        mdio@1100 {
+            compatible = "hisilicon,hisi-femac-mdio";
+            reg = <0x1100 0x20>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            status = "okay";
+
+            ethernet-phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+            };
+        };
+    };

-- 
2.43.0


