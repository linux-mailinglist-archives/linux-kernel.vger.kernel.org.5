Return-Path: <linux-kernel+bounces-87866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D966686DA29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6121C21380
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CC5026A;
	Fri,  1 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4uJLidb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3A45BEA;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264160; cv=none; b=IOlK6Yc5xUJhnLhYaU3zFoKfd9g0FZMxSewIACBev2lWEwHu/9XgyfH91h299lhLoGNCgMrq4lFfj2cwICnoZTnSoVa53JGvQiT+2ME4HcMN/pVuB4PL7XiMVu0dzzi6oT/cbUlKS9TYPyINa4Lv6Floh/5UIhnG30dhysK3vIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264160; c=relaxed/simple;
	bh=KBkbSBUYWsrzUyqKx9vXlQcN5p5QtPpYZGQe08xtkko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nliNJGispu//5cDioiRARBv7s6QtMht+SwVi+9AiahUK0PE0OSWQ2nXdI9QjS0O2QeUQ/q6Ga8ntyEBQAQlQGI/JtJQmRUZ/3N3LjYPSLUY2v8FWBqXfhTTRC0evL7IO68kc8AlxeFVMSiSvPTR3TiP5i4qMXiniAx8L5rJwJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4uJLidb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A57BFC43609;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=KBkbSBUYWsrzUyqKx9vXlQcN5p5QtPpYZGQe08xtkko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f4uJLidbbqbZGzWGxBVyJYoB+x3gfNrBt/4NWQ3Ps1m87JP2Vgpk+4QHQr8zQGbOn
	 pNywde0xm/Ie0ygXqVTu6SPjHWySrUKHE/so7unBqkcOHNh1LEQ21tOSxTqoMcdtxt
	 Y10cwCaz8JOw4D6FITChw1xKceomzxGLJ3x3A7qOJv0JyPLS7uc4//Gq9GAEohVGXt
	 HfPjfnpEk6WqN6eCvjbvRC3P/V9iQwb476fMNCSlVYqCwMZQjUziwV4cP8F3OOThTS
	 b0RuOgx50JPMBFBNQ7egOodRCm5j7Fu6VdTrU+ixvfPAoQvkVSrxHY6aahiOtgMIk3
	 NE59pSz23q9tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD91C54798;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:35:58 +0800
Subject: [PATCH net-next v7 5/9] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-5-45823597d4d4@outlook.com>
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
In-Reply-To: <20240301-net-v7-0-45823597d4d4@outlook.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=2313;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=S6obhoBKcsATY4ri5n0BubHFcd7WZY9xaY4+Ts8DAWM=;
 b=LUN4wKIXNQS3Xd4z/N5V1bNs5FDH6+EqfSboqMyd3S52ECUqpETbf2N05vnGi4XKmY/mczBCt
 MeBd/DkvoyQAnQjqgEMz5TxYqWA7v7RTDaGk6vCdf1So9CE+yp4FWa8
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


