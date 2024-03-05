Return-Path: <linux-kernel+bounces-91839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6E871762
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C304A1F221A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79C81746;
	Tue,  5 Mar 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSmLJ0x2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A97EF0D;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625073; cv=none; b=SdSvFKtU2FVdX6Je/W87ur7dGaUfgOyq5MdS541nUKJGnhpT1BO5SkoVz4rCGJxkHLCP/wfjEQOR0Winf5NVgR9BrPomIBwHZ/GoleHL7PeU/FaF5lJsRkBm/G8/sDr7Ao+/rgIkgoZ8XfFHTCy2yo1Cy/3223qLlnf2GFR2+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625073; c=relaxed/simple;
	bh=KBkbSBUYWsrzUyqKx9vXlQcN5p5QtPpYZGQe08xtkko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGPkMkaQxfTUsoLkZz7AoTRnBfXqL1+cKmseExyZ7U+nkFWn6I3DDX5ytWAcs+wwfTNc6o7QHJIfGEJ+IvSnuFkf7gudHT6I4FcUuxrpOUc21QZlKWWsqEx+C+cdOdQngohJdDuXph+a5bLKFm3hC91GRVMHpm4fJmD/Dcx8pwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSmLJ0x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8E2C43330;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=KBkbSBUYWsrzUyqKx9vXlQcN5p5QtPpYZGQe08xtkko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dSmLJ0x2jw/a8G5bOS9gRrUXubX3Js+M+nLXCqI++/e3HToMlw2O1KlD7NwBFnCfc
	 rjwjwRsXfLdvZyROHZ170flTpA8IEbvnmi7LGPye3osyvUSKz2BlQgNc+dQXRCY0Cc
	 hyNIRWoswYgN58n7ukSRrzQx0xyzgnQIW2o/vTcY9krDgJs8dXgQpugq0ibcuwy95O
	 SAOSNHkb7ZXz87vxCR67w/2qLWsEjcb9A616/GwVwfLpo3JTWeIF6ea8BZDdPtrUBe
	 R+XCI68D6rvwswqUrNblG9ZnelgcxLlmXNNOfMDOc8t9ZNN4VZtax4LyjEfI1nAr8o
	 jO5bU8DnIlwVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F6C54E58;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:14 +0800
Subject: [PATCH net-next v8 5/9] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-5-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=2313;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=S6obhoBKcsATY4ri5n0BubHFcd7WZY9xaY4+Ts8DAWM=;
 b=slQY/8XIF3Ek9MZs/Xbnyg3WHsVOtruFWskH0YxEQvGj0R5Ay7isYcUAFiGhPU0SpPY7svZmm
 eMsI1UC5fv5AmxsePl1JfvpD8OmlakH4tjAXUgkNIubTl+rJ3VLhWDw
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

FEMAC core always has an integrated MDIO bus mapped in its address
space. Add required properties '#address-cells', 'size-cells', 'ranges'
and MDIO bus subnode.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac.yaml         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index ba207f2c9ae4..ff6b090ed34e 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -24,6 +24,15 @@ properties:
       - description: The first region is the MAC core register base and size.
       - description: The second region is the global MAC control register.
 
+  ranges:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
   interrupts:
     maxItems: 1
 
@@ -59,9 +68,16 @@ properties:
       - description: reset pulse for PHY
       - description: post-reset delay for PHY
 
+patternProperties:
+  'mdio@[0-9a-f]+':
+    $ref: hisilicon,hisi-femac-mdio.yaml#
+
 required:
   - compatible
   - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
   - interrupts
   - clocks
   - resets
@@ -77,6 +93,9 @@ examples:
     ethernet@10090000 {
         compatible = "hisilicon,hi3516cv300-femac", "hisilicon,hisi-femac";
         reg = <0x10090000 0x1000>, <0x10091300 0x200>;
+        ranges = <0x0 0x10090000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
         interrupts = <12>;
         clocks = <&clk_femac>, <&clk_femacif>, <&clk_fephy>;
         clock-names = "mac", "macif", "phy";
@@ -86,4 +105,15 @@ examples:
         phy-mode = "mii";
         phy-handle = <&fephy>;
         hisilicon,phy-reset-delays-us = <10000 20000 20000>;
+
+        mdio@1100 {
+            compatible = "hisilicon,hisi-femac-mdio";
+            reg = <0x1100 0x20>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy@1 {
+                reg = <1>;
+            };
+        };
     };

-- 
2.43.0


