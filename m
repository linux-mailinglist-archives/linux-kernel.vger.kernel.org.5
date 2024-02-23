Return-Path: <linux-kernel+bounces-78379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033ED8612B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6761F22DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D280C0C;
	Fri, 23 Feb 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j31xawSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE787F460;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694909; cv=none; b=hcatRDjRNReDJQ/bSYdMoiZyxwbkmvTo4wSVQ1Bhps51SfPOelbf6mf5fUQFXAMRTN6oYMBCJBVDf4DNdU6RhegXXCfNJi9uDZrh5uXJHdw1I+o6otb54ZvQ3V+WZazMItci4EjnVPCybMzv132v7Ks/4i/7gbarVu0DQA0+rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694909; c=relaxed/simple;
	bh=oJuSPJD8GR/wjJbE+mVqeaijIrE2Zu4CuUFl6OFH/pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjZLY+jqEhHrIJHmAJQL0PVZpHGbU09pFYPpgnz/ILQfeLJSgEzJ2aeLqiaKHBbgM7XU/X5xPEq+z8Ecev3bLuXYPxO+EFoAuoHvKbH35YP6gpGsZ9m7QpMUl9uKB6vW5LbzBsSQRw5WFadQIqF549Xkd4NUjMuYjeEx5zxDk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j31xawSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C19BBC4166C;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=oJuSPJD8GR/wjJbE+mVqeaijIrE2Zu4CuUFl6OFH/pQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j31xawSj5kF506lb2tUaavA0lAWC9CsVB+c0SRfSQfgU/HnDwgjC6Ez5W6yiqhxA/
	 7aLwnpoNKOPVATHoNkg4YS1ZyeLREOD2DLD7UfoSz0z16fzQoqkfegjlrAr3WZoVsZ
	 UiMP+mhGTRTNJoTHzLegCDlBZ74XHPgMae6isfrL5+XsHNOwUm6yxeM49IW6uCtxCs
	 KjUEbE1tEOl/dKuEyII/dIt4nfVWxhYzy2sQBHR2XmwhVoSntqmDJzEXqifthfPCC5
	 B1BRrz421IboliTRdNBKnmRMeGK9ufHVAGZaZCirJTWL7Fu1cGFrDRVo8xMc1dpYUW
	 LkZ6+XPfmvHUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E2C54E4F;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 21:28:20 +0800
Subject: [PATCH net-next v5 5/7] dt-bindings: net: add hisilicon,hisi-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-net-v5-5-43b22d39c013@outlook.com>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
In-Reply-To: <20240223-net-v5-0-43b22d39c013@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=3843;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=s74McZo3tz0CRQGXU249Pq+NWVbKcQ+gU6lSPVvGiGw=;
 b=C/Jxx6VzW7in2k+7wNuuXLjxORu4pAhGuCV1heg8ZvhjlSKfoNpN1NqxEFFuKrjlYid4ThfUv
 YRVbuXlJLMUC+OE/YJ7R5G8kdX5rT31hneCmFoY4DjEHcDDxPT56CEo
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
 .../bindings/net/hisilicon,hisi-femac.yaml         | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
new file mode 100644
index 000000000000..56d7c8a26d0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -0,0 +1,116 @@
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
+
+    ethernet@9c30000 {
+        compatible = "hisilicon,hi3798mv200-femac", "hisilicon,hisi-femac";
+        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
+        ranges = <0x0 0x9c30000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_femac>,
+                 <&clk_femacif>,
+                 <&clk_fephy>;
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


