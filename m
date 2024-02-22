Return-Path: <linux-kernel+bounces-76527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B352D85F87E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684FA1F24393
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587913328D;
	Thu, 22 Feb 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFy86V0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221912DD82;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605822; cv=none; b=AhTndIaOp4F094K8WoI9rd2OnR/zCxo9UGiObPQZVsnMesiPLdGWibrHaZExNdnns6o+FLnASlv0or6F5pgyTySB0DBBZOjChansKQ9GkMT9rDvMj8WfOEUbzwHeXIK451xFAOW8DgllTWaryS4bFUN3aPqLCDrtb9wGHHPb/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605822; c=relaxed/simple;
	bh=dU0HjJgUNo33Wr86FpAaPRHjBCYGelpAaLa0iwZ1osU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyqPoFUido0G9qRy3PY0TeNqGz1WqH4SQlKLFTbSOXhwH9089Dy1QMNv3A+lVYieF2wplJ5d9hjBEiNLO2NT2+Ftfbcx9wCcG3C9mLvPKEgbGlPPjE6S4oZamPQ8FGddbg21Z+A8UoXL8phbSApXy352Ss6xg76DBG9GDwJOJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFy86V0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4E7DC433C7;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605821;
	bh=dU0HjJgUNo33Wr86FpAaPRHjBCYGelpAaLa0iwZ1osU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sFy86V0bmpvV1NpzvFQ50N8T2DTKDhx4tka5nj6Usvyfllp4VKsaEBh5q5FP3gLpD
	 UCOJOL2Mi6bYnj1Ahbex1nvB8bpxxEfhNSTiZjQ+zD1QaCTepL9jmPXRTUbe9XV8IP
	 eHXZvsqPyZlkrQXQZN/d+sR3zqxQY0ESg7OTV8K1lAG7JR2ULp51dhcLTKv+pmgDa9
	 ChqDuPC2EUgaSjONyFYiBHVhZE5ifmMAYTTo5BDfp2gfgnIiCoYTNbkBUPLrc4dtfn
	 TDxSM15MG6687fUXMJNMhnNDYS2XMaccxsw7Hy0zCJ6gb8mE/NypGFFgHYjsy3jCyG
	 Wt9b4uEtrcbFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBDC48BF8;
	Thu, 22 Feb 2024 12:43:41 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 20:43:21 +0800
Subject: [PATCH net-next v4 1/6] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-net-v4-1-eea68f93f090@outlook.com>
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
In-Reply-To: <20240222-net-v4-0-eea68f93f090@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708605802; l=2707;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=kBNRfWKBQ0id01gl7avKkUC4CeGpm5ZtYlqpv6WG6d8=;
 b=z8h7WVhMvCqDOAxS7nz/ePDZ0zE/t1zWZkPmj4E2Xmaa5JM686ebtGI5YHp2MZY/Y6wJwYvxI
 ryr+FCIiwAXB029JDU/DsG37u/5iCqz9IFcxqW2YtUSt1vZKTOAYk3U
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

For some FEMAC cores, MDIO bus is integrated to the MAC controller. So
We don't have a dedicated MDIO bus clock.

Also due to the PHY reset procedure, it's required to manage all clocks
and resets in the MAC controller driver. MAC controller clock can not be
shared with MDIO bus node in dts.

Mark the clock optional to resolve this problem.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    | 43 ++++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          | 22 -----------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
new file mode 100644
index 000000000000..ee8650ad98fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
@@ -0,0 +1,43 @@
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
+        clocks = <&clk_mdio>;
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


