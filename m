Return-Path: <linux-kernel+bounces-84728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15886AACE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520511C228AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E544C6C;
	Wed, 28 Feb 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg/ULCK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD931A89;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=ukv/CZcRFP9ozWyrNJFWC40xwAXmP1AH8W0Q9xKLST/F86f+YMQwV3IPWltLrFArAXkTqzNsE7K/gNZdvGe5iSInHigjPfZkyfb62XaXN1Uz8a6oJiFvWZ+Egsu94tqy/V1N341OSmSvx2B9L/8cbbdAOagHmFz9lAxgwOkJP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=MNYEXN+BFTezcIlzVe0klHXNpA0g3TpmZO9OeiTVtnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJvGch4dIobqdaisEuMvg+zEbGYphsD/nl3wYMTknqWpXR755x0X6xBWXLynTu0Gc2ePTgbEEbz5XqNDhepYtv5DsCP6SrLCYOc2ZSIDdwNWS0z0xqSnM/MTo4g+pSEbv4sRecsfkepWzUXNM/yP3q4uofgL4pMJGNvGoGADenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg/ULCK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BC23C32784;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110947;
	bh=MNYEXN+BFTezcIlzVe0klHXNpA0g3TpmZO9OeiTVtnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yg/ULCK2NLoe4vrLCoa6gYUCIT9mNdF4KBd/yxBkpM/8RxAKZ8HEhsGRgC4Hj/TAA
	 RsIRI0Wq6LTka4MbwH+PE3KSFIkIv0x6mdGdDAyp8mIRgor5f6isIbH6m5D83g3FqO
	 qDRj7lBeWGnh0L3u0oY8TMZLIQapTG7I4puTPdVq1T8k8L4fM0pnrGM9LE57lVT9/R
	 z1J3jtf2oUJuFcCb4A6h3BJfb00V66yqQTgt2f6tvM3Wpuqr53vm9g29ipMgp2WVA6
	 h02sHzcRYgn9UeO18ZkEI9Rn7UpJkQMbTk+5klWQjmv0nWU/zdzKoz700RM6b3J3gD
	 /ycg5GIoZuvFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759FC54E4A;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:32 +0800
Subject: [PATCH net-next v6 08/11] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-8-6d78d3d598c1@outlook.com>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
In-Reply-To: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=2257;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=MD9OppYNChwYfG+o7jC+6/9qGjd639+9Q/OQeo2lPDE=;
 b=GZzpszJU5Lk1WHcFpWaL2FCo4+GVzam2ZcPlapSzzm5ZVst/XdgO4bRL4RTS5n3gUO4uYubDk
 Rq5HheLT4ZpDfvP6WYD5e+85IW39MwnY4q7DJZi800L5aNEq6csMTd/
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

FEMAC core always has an integrated MDIO bus mapped in its address
space. Add required properties '#address-cells', 'size-cells', 'ranges'
and MDIO bus subnode.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac.yaml         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index 6c5888897876..d56ff8538a86 100644
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
         phy-connection-type = "mii";
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


