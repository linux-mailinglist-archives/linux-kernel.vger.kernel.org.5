Return-Path: <linux-kernel+bounces-68403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5B8579CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572A31C211A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B301CF98;
	Fri, 16 Feb 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU3vdtDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42E1C69E;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077722; cv=none; b=s/hbyCDYo/twAS3gicZkF0gzJCiFKf3QLDsIKD4ea1c4dXuNV+GbqBS1K71JEhuaJaT2fxdW5wJFwcbuDLzRC2dGq6dimEZ6iIiumGN5A4Zd2BeRbYzA756aw9WVfowpuZ+qaXntcGOPm/WsSmR76x3W4swpb/6wpqCo8HHhHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077722; c=relaxed/simple;
	bh=0stQuGcT85v7JeX1LSOyAgNGs9Jh5DtcOA5xYdFk0tQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqHT6QD+iRD5SVUjdGwOMlOsVpZ059qqECNkqbcIv6ermGnwMEKvkKkdUjG9kLE6LRWme2Wwj5o7ZSp/7iV7Q3EoMW84PWy0+O6gVoi1IXVBvUE31/P3HDLZ1pBa7zuuPdBCUeuqm16/hZhpR8jK6GWsGhDXUCtQ0WSjixZocMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU3vdtDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A239C433A6;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=0stQuGcT85v7JeX1LSOyAgNGs9Jh5DtcOA5xYdFk0tQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RU3vdtDBSkRXpzqi6XZZaNaaPHMAx4ENgUwU1msCrBgSDIuRLI4EbAwAbyWol5oJ+
	 JtP1EU1pW+9weuSKv3GFa8UYNvC4jm1KZlclPLNdaO5UO1dgDK1QGMiOr8H1mK7ivy
	 nRyuK64DyVf/kZyzu+m13meMr0a4FQpM4hn3qFM1rxDs9sS2GSZNo+S1OGxfU7PCBm
	 0rhxM6JWugiC0w+aRdXhlXxX2Ad6IXJUHRcbNV/nhEKjsUyop0keQo9Fv0wcxrRdZ7
	 y85pS3dABwBrf8mmdGft3QOoWoZ2v1nyQ7WD9JVdv2hSVgswDVZNWK3s8HOL4vQHB7
	 u6HKsDIvq3pvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D71C48BF0;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:02:03 +0800
Subject: [PATCH v2 4/6] dt-bindings: net: add hisilicon,hisi-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v2-4-89bd4b7065c2@outlook.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
In-Reply-To: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=3765;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rxjP6dkuiPPvZpkojXowwmQaRdX/I+kV6qPQIGtUIm8=;
 b=waJELSdVoE5bPPfyM3G5x7yCB2sI1SQW9/jT76++yg+icDG26+ojnZxCQxVtAJ8y0sNf0ujx4
 DdvfXXQT311BYxnjLNMpSLtxs2Mehkkjf7rLrwcRM3oAGDD/KjfjbTE
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This binding gets rewritten. Compared to previous txt based binding doc,
the following changes are made according to the TRM:

- No "hisi-femac-v1/2" binding anymore
- Remove unmaintained Hi3516 SoC, add Hi3798MV200
- add MDIO subnode
- add ahb bus clock, phy clock and reset

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


