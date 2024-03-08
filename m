Return-Path: <linux-kernel+bounces-96674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D561875FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C8E1F217C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DD55C3F;
	Fri,  8 Mar 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSwpU1Sf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4819524D2;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887186; cv=none; b=g7xTRCSsKm/PrjYZGcv6UHT2bMCjMg2YmCqaQXz5FpgiEmC5BXIIll9vz9ulhaSex0RW6FmE8mTUdKL793pmV+nEtoSYoK8Vh06BSVoV83WSPdGazkDgKfabo+ltC9yLA8MQU4Lo1uWQ0AuyLjrCBNu4tM0zGXYO8NLEKOKdJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887186; c=relaxed/simple;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrgejpZdxJAxT9P1lwA02UEX6tjD/XN07l31RSsJjQIHLVjfUGKpXjgVFaq573MZq0pYQyVIFld+Xqwm5/rkSYX0ZpVzEYcLQlmA8VyWSRR0TGIJUBfKXqWfZRSch7OU7vwfUBDq8DYQVLk3B4HeZUJIPoGwZdiTYWCnAZAo6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSwpU1Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66F43C41612;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887185;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SSwpU1SfUbc2JrQ7TO+U85lvQAW3Xmt1LW2RAAEz4wA7uwdBvrVasEJD1DhP+6HAl
	 nqW2s4zqc9yqDSR4uW76T2vpnFXKo0RFHRI5Dtt+SXhk0PiAIfaiLqVpqEHH3Z7GU8
	 /mGuR9phpkdGTuVU2juI9gj18cYvLjj7TobEOVioaTPZODVWtEawB13WxaIHV2HH+W
	 h7KpPrkoxLoP/kKPK5EKWWuovdsKTgMOXSN5H+y5s0qPeOjEBVWauOkouilS6kNUC6
	 9/D5e7qtcU66dFsGE13+O3NRcARExU9Hhzv3D9Kugn6KmPgepYdnvw60wg+HVP13JR
	 9XB3glTYkX2gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F349C54E4A;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 08 Mar 2024 16:39:47 +0800
Subject: [PATCH net-next v10 5/8] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-net-v10-5-3684df40897e@outlook.com>
References: <20240308-net-v10-0-3684df40897e@outlook.com>
In-Reply-To: <20240308-net-v10-0-3684df40897e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709887184; l=2289;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4fkGrr79J0kJPETyUJ+upr3jatyv9l4bbxNa0d6pOpo=;
 b=EhuknQz1y81X0Cf6TpUbJgN8zxZd+XplAMExrSaQmLcjRif3OwdEle+mxocGIt0HHNzT0N4Uc
 XN9xEnEb+j5BkIt8S1TBmnjQYSJB9HrMW8y385mY0nID+VWFPWXGDX/
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
index 3344d3bfefb8..5cd2331668bc 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -22,6 +22,15 @@ properties:
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
 
@@ -57,9 +66,16 @@ properties:
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
@@ -75,6 +91,9 @@ examples:
     ethernet@10090000 {
         compatible = "hisilicon,hi3516cv300-femac";
         reg = <0x10090000 0x1000>, <0x10091300 0x200>;
+        ranges = <0x0 0x10090000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
         interrupts = <12>;
         clocks = <&clk_femac>, <&clk_femacif>, <&clk_fephy>;
         clock-names = "mac", "macif", "phy";
@@ -84,4 +103,15 @@ examples:
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


