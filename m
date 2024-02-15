Return-Path: <linux-kernel+bounces-67855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470D8571E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CDA1C2258D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B57146911;
	Thu, 15 Feb 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqWuSeSW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BC145B18;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=J81JbDeWtIWamxX/A30j5Xg7JstLBb1RhAzU1yv7Jkz5EzaK/olkA9IwwjDFKi1noYKI990XPy1Px2zwwg/8j2uFpEUJ70lcVjadMA4dqd67lohaaql4e/VlgCTB02ULZCHwhMBaB0qB+b85lsvRrjoqoFAOR1CoOqQ2x0I0H5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=dwG+Zq2OviJrgx903WZkhrqBopa6+N02UuKRpguueHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6Ybmfb2eOyTHbQED27s9ujPCfr1+Cs0GEkHjVhOG8d2ENWaluLGkgvASewbZMZllGQ4tk20mEt/5PiHXilfLqxsrYP81fN8DEvhrUEgZRTu6Bt5LkCTJM2CYgVkcTFEhUuvGQiN7T98SNBgXJcmm4gCLMHEAczBPUPDIBgL6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqWuSeSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC9AC43142;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040933;
	bh=dwG+Zq2OviJrgx903WZkhrqBopa6+N02UuKRpguueHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uqWuSeSWrhv2TjeFqs8wGgEjOEp4Kf3BHin9D57H+IQH4H7yJ3wkYZEpWtt4qnpk6
	 bKEix9cEsHcchGvzD3uIDZTmIVC+wAoyk3PlL9tFRfmcZO4H4pMxjvk51q2+GxVz+E
	 fP5e6YC03J071YSoAqhHwYUBJ24qcSbijac1E5b8NKGItA9YQCtRAfaJE3HhPxiRh7
	 oNtO5P/A9aP4wyq7cxCEc0GFpmgGZfZZ9p51HSNkY5M5+u5y934pn0BoQhDM5tlU8k
	 F4KDDtSKvnKX1y1hmnQZPL9slQn751HDvgISf59L24A7vk1x2iBaOXuNtaEpDINFEJ
	 wXAHJrYQdqTAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E3C48BC4;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:56 +0800
Subject: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-4-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
In-Reply-To: <20240216-net-v1-0-e0ad972cda99@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=3806;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=DJxzgsmEBlHh9lBL/uI/3VbIKC/AIol7DNEC5Vfzj9E=;
 b=1sKSohKyPR+wipV8br+qVxleQc6iVOq6lcuPziMYN1mgVhfUH/LZcoGTSerKMi8Cz3Tyhj/BP
 wPzw2KeWGxmCJgzdeNSAaYOWYrio54EqlcaNBY9DPLMllyoFHgae/py
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This binding gets rewritten. Compared to previous txt based binding doc,
the following changes are made:

- No "hisi-femac-v1/2" binding anymore
- Remove unused Hi3516 SoC, add Hi3798MV200
- add MDIO subnode
- add phy clock and reset

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml
new file mode 100644
index 000000000000..008127e148aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon-femac.yaml#
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
+      - hisilicon,hi3798mv200-femac
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    description: |
+      The first region is the MAC core register base and size.
+      The second region is the global MAC control register.
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
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mac
+      - const: macif
+      - const: phy
+
+  resets:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  hisilicon,phy-reset-delays-us:
+    minItems: 3
+    maxItems: 3
+    description: |
+      The 1st cell is reset pre-delay in micro seconds.
+      The 2nd cell is reset pulse in micro seconds.
+      The 3rd cell is reset post-delay in micro seconds.
+
+patternProperties:
+  '^mdio@[0-9a-f]+$':
+    type: object
+    description: See ./hisi-femac-mdio.txt
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
+    #ifndef HISTB_ETH0_PHY_CLK
+    #define HISTB_ETH0_PHY_CLK 0
+    #endif
+    femac: ethernet@9c30000 {
+        compatible = "hisilicon,hi3798mv200-femac";
+        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
+        ranges = <0x0 0x9c30000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg HISTB_ETH0_MAC_CLK>,
+                 <&crg HISTB_ETH0_MACIF_CLK>,
+                 <&crg HISTB_ETH0_PHY_CLK>;
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
+        mdio: mdio@1100 {
+            compatible = "hisilicon,hisi-femac-mdio";
+            reg = <0x1100 0x20>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            status = "okay";
+
+            fephy: ethernet-phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+            };
+        };
+    };

-- 
2.43.0


