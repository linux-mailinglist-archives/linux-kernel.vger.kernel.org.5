Return-Path: <linux-kernel+bounces-97883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C8877125
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713BE1F20F89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDA47F7D;
	Sat,  9 Mar 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV8fOuGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37E3B190;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987185; cv=none; b=isQSlBh9a+Ha6TvqqdqDI4je1Q7gk8B6+6zxysfBLnrvPybKhQdlYMeFH8qg4Uq6bC9aNr30Lbt0xvrtVKKueJUNI/EEtufBkRQyy0xLSv6lYo5JtG3vjEYbLqcMdGhY8AB9pULTpgUOvSrDn5er3jyTpUFIV4BZAaEzQ1hmN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987185; c=relaxed/simple;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lt9/bkdnlvpyLMHgP8aQgbqiWpBrrVvELobUIw+5Cu3P3YLm6nXG5k/Qp8BKD4UnFS4F+qF+XKHX20p/oK2cSWbg/dJgpynS1F3cJ0x81K0acl0NPo0bFVPJmJhSftLBa8ErrYFErlM3cKP8cJzYAY0AAB+7z/UJtAxJFsiR81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV8fOuGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6E0C43141;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709987184;
	bh=S/doFh+gAKWZAIIBgfTAfdC4/d/iX9a1igOHcKDtz+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tV8fOuGYO9o5NS7Db+RIGTgHQ5OddoRjPblkjQM1gbEc9LjkV0dhMm7TNOEldvjjK
	 DNVYRtdgb8Kw62mLa1/sTejcScQrT4sqQOsGegApKGwEpUL/tdeqeUjm1k5C4uN5o1
	 asdGoVBCeuCloLD1v5hIeCZGGhYlqPt94TixludZcQaseSxiih8wrx8oumv0ImV0oi
	 Nn92relKbuobJZDHC7n/TotnOsaupZ+Fq16CNkOEPUL7IVp23yXIU51LOpTBa8CiKS
	 TUNaQN4ykaZPOMr3gPgC3j+76sztofllc3pbC28QXxcfo6b951ht57CxQ8eRs3+o3o
	 rnGg2dzXRylmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB5C54798;
	Sat,  9 Mar 2024 12:26:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 09 Mar 2024 20:26:27 +0800
Subject: [PATCH net-next v11 5/9] dt-bindings: net: hisi-femac: add
 mandatory MDIO bus subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-net-v11-5-eb99b76e4a21@outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
In-Reply-To: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709987182; l=2289;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4fkGrr79J0kJPETyUJ+upr3jatyv9l4bbxNa0d6pOpo=;
 b=2GHYPHV/hc07ybivl621iErFTLb+UDsZtdcnRa5QfnSLwu268J7fiAlr09l9J1B5BUcYdGKlL
 P5KL9rPfxEwCkuLzgSJZu2pSnAON0YJixUW6m/GdgoL8kUnprhBseMe
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


