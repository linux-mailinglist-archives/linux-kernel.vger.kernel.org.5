Return-Path: <linux-kernel+bounces-68407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E68579CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD701C21D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B920B09;
	Fri, 16 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7z5qE8w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4E1CD18;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077723; cv=none; b=hl/XWCYEnPKGcjJFTuIsKMTzYFzeiYjQfDAgjivyTY5EruHP1pnRDyFB4rWKFgJdmQuhBraxZW8iBi6OCdeHEFmmK/PTzRLQsnIHQZxhzWDU2SqSO9y3JyWAr6Epq6u32aNGtVHuVwnn034VTz3afWj7oC+7drmVUvHTzXn5iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077723; c=relaxed/simple;
	bh=nop/OiGp844/xYKXXVQI+2hWwg8MMGvYavV5eOdNyP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbjYYfHsn46fdDbeBTTYN1rSixZ3betpOdeRVBaLSbcG894GCH/Nqlty/nNvXDefKohV33XujRFTxPQdhtN/y3xv/AeI9uLB4dxcCxYj0WQcVEK9KScZLCAdIoJBIZ/e3i/CGjkUxoHPDvf20z9U8RJeKPb1BRPioHCA22eXuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7z5qE8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CA6CC4166A;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077722;
	bh=nop/OiGp844/xYKXXVQI+2hWwg8MMGvYavV5eOdNyP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R7z5qE8wA13oagIgw9yE/nc7ra8LGlh/LaljN6XzRou2xoFkeR/qmoyVSlfys5Bec
	 xh7BkzB+qY74BXS2SafJXEtPsQBYplTbx1CBx8ANhA79mk7p4B6jsJQlLz91etkfR0
	 phLUzVJUM1W2HSG11qKOhKZL3tjSrFw/kL1gVuizwfLI6AHFXyU6hD29KNGw0mz3Om
	 shMJ9V4r1yfNMPJEbwT92ga9szDXKPyhbC0OTccKVsimjVlprbHIr8VU4vQZeuefAW
	 z7r/4Ta0lc/i1JvajqGII+ZFyxGQG/3NxpIt9CHQAau9i4Feds2tyYIkajcFnTYRaw
	 VTw8diWwjDkHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29139C48BF5;
	Fri, 16 Feb 2024 10:02:02 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:02:05 +0800
Subject: [PATCH v2 6/6] dt-bindings: net: hisilicon-femac-mdio: convert to
 YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v2-6-89bd4b7065c2@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708077720; l=2430;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=iR9T/nPDOpVW3CABLZDGaiOeC7P5ZbMOoE+OAc1rwbA=;
 b=dlWdIEfs9sbKqrT0xpD5XZbZFy5CAi4go7n+kDnxJBVH/rZDSM6sNxQaxhy+QZ06XM1bL5lfX
 tqjAGdcktdVCBLmjvNKEzWTdMaLBYlJgN4l2j+ON/zqHoP5I7E4sbo5
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Also mark the clock optional

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    | 48 ++++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          | 22 ----------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
new file mode 100644
index 000000000000..1c85e6e7f8f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon FEMAC MDIO bus
+
+maintainers:
+  - Yang Xiwen <forbidden405@formail.com>
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  compatible:
+    const: hisilicon,hisi-femac-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@10091100 {
+        compatible = "hisilicon,hisi-femac-mdio";
+        reg = <0x10091100 0x20>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy@1 {
+            reg = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
deleted file mode 100644
index 23a39a309d17..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Hisilicon Fast Ethernet MDIO Controller interface
-
-Required properties:
-- compatible: should be "hisilicon,hisi-femac-mdio".
-- reg: address and length of the register set for the device.
-- clocks: A phandle to the reference clock for this device.
-
-- PHY subnode: inherits from phy binding [1]
-[1] Documentation/devicetree/bindings/net/phy.txt
-
-Example:
-mdio: mdio@10091100 {
-	compatible = "hisilicon,hisi-femac-mdio";
-	reg = <0x10091100 0x10>;
-	clocks = <&crg HI3516CV300_MDIO_CLK>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	phy0: phy@1 {
-		reg = <1>;
-	};
-};

-- 
2.43.0


