Return-Path: <linux-kernel+bounces-95432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050A874D97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620191C20A14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21912CD80;
	Thu,  7 Mar 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGV7TXmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3028129A67;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811290; cv=none; b=CWnt47hodPI5Usu1GIh3i853X2kt9M65Q2HwuPlXjjpK4FFwTnbMHDYp9YT0mKidlXY+x9LWLDqf9hbMC6gHF2L0Kgqu5uXhqCKFZicTiQhxxOfYjYvtI0qhBaRH01+LZk5XVyPHJpqFV0EYV9OooFmgBZ74krmppzDUj2EcmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811290; c=relaxed/simple;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WE3dr6riBjq31uCbn32NYjrLsnHyjtroX7LcMynDbpR4B6OhS+j5aAukVZ4QYUjzIvBD7pIn+la1vC6YRocNctay/0tdoAO3y5t98Vp4Bsm8OhjK7ARG3sIkru4WJi+yIKeaeroeSxEFL8QY92Zv9TGQ5Wv3Dh5MTysuc8mnn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGV7TXmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78409C43609;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cGV7TXmfBXZ/jusmM4qoE+iGY/ncftIuvMgz734AYJVYJt7qTNhGMHegP0pGxjlKw
	 5aoK3KdSpwW6O147hyefhg9ZhpA6OWrMi1AE+CVdPtA0TCPuLV22QGKymUxkgQK4LE
	 CiZ3wa4MkgFDliRbh9lPtXHWneQKD0mJWGkVuH+7+IlWjx99jnOQvyLK6PCHmo7a3X
	 qUuX494RIuGdMklq35PDBjkbke9xcUAAeQce9fAZrBHapNvgNfLDkxpexcCssif5o5
	 8YZ/d3Hoc/0GAvCeFvUZrdbqHN2PWpF5umI7l/3BLIgy2DD7UtEbjwMejUfGF4KJMC
	 MmxOiBX8J1gRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C30C54E49;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:51 +0800
Subject: [PATCH net-next v9 5/9] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-5-6e0cf3e6584d@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=2289;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4fkGrr79J0kJPETyUJ+upr3jatyv9l4bbxNa0d6pOpo=;
 b=yF6Gx/oIFBH+QWLXV0eN7Eef9X95SzYrHB731UFAKoOQnbjbgNaCe+fXI+uRjCXp7glRixFZN
 3QSQL+2OC/pASE+rIGPMuKRZgXLYqZw+Mwg+uRt8K3mN8wt6vNyS3po
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


