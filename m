Return-Path: <linux-kernel+bounces-69892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142C858FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7681F22158
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811D7B3FE;
	Sat, 17 Feb 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwDnRDzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1507AE52;
	Sat, 17 Feb 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178572; cv=none; b=Eb5EPsQo6Ws5LjnJwRQWE1ibwUdoY0g0lkrWzF4ciZA8JqEfenNDw2SQYjaqQgNLS4nkAjKMfmlrfb9DnPlT+dsOZigbeIyfHPr6sB5C3l10SPl3vJjq5WvS7jr+2/enhifP1sgbWPDyJYiWsG+LU7RCsO2Bu2uQ2uJa2mFOWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178572; c=relaxed/simple;
	bh=jFL/RZ2ZDCgiqAKnWhKvV31YON6zb+pCMW1UeDu3mgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1egdUFcYbjTHUYzE0JQoBpezNYVVAJvOARZrh0xj2aNB6mwmRV286oEe6sOHnUZzgcbT8GNa262vpBlWrEJDagnwM3DGUCO2Dj9ls6qugsxW3Wwd5GExRsHno5xCy5+at7oGO78gba6juRzSG9og22IaMLRo13xj5u6uqq61So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwDnRDzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06897C43399;
	Sat, 17 Feb 2024 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708178572;
	bh=jFL/RZ2ZDCgiqAKnWhKvV31YON6zb+pCMW1UeDu3mgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UwDnRDzhm31AMlD15S1Nen8w6hcqxyTSSKeUCGMkmgra+lE3U5RuFZC957o0jtLHj
	 yEtp6AFznQxgQ5dZFTVML27gFxfq6u0HCSgFrsfZyyq2wxnUKt8aDkEDUX9lvSybhz
	 tGgFRL3gc+8/fD8/Yn0OQaGjJRfFKAlAzH2WoES/5TQpMYYNZxA4W0hpZUtsJSGZUZ
	 61xefRx84SIbjoUiQwShr2gtKppAJ+9XKuujllW9M5jcPNfOMtvwYuc7n0hpv5XKPq
	 RZjkaj5AfW9N+yaYWM9Hk7+XvHJX2hNtqWAuJd6lAt3dQumRNc5U1e2mcKS92Rkwvx
	 sKFIwUUdIeb9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CCBC54764;
	Sat, 17 Feb 2024 14:02:51 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 22:02:48 +0800
Subject: [PATCH RFC v2 4/4] dt-bindings: phy: hisi-inno-usb2: add
 compatible of hisilicon,hi3798mv200-usb2-phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-inno-phy-v2-4-3bf7e87b0e9e@outlook.com>
References: <20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com>
In-Reply-To: <20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178566; l=2016;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jLZWuS47anxDC0v84kYOmUKJTlxPytV3qZbHvwpp28g=;
 b=Q/aLZDrqeMAj7mGpkxaMVPftjiJie2s2j/B2+LT4yWcdXm2FhadHAELA55FE9PjR3yynydw5y
 IDMBjWQCPJoCX6q6Hc93VBJWE1lkbYzChX1fhYBozhNb3cuFi8sj+TC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It is accessed by direct MMIO, making "ranges" property mandatory for
it. Also there is an extra clock for the phy.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
index bfbda1568557..105dd9eebd4c 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
           - hisilicon,hi3798mv100-usb2-phy
+          - hisilicon,hi3798mv200-usb2-phy
       - const: hisilicon,inno-usb2-phy
 
   reg:
@@ -25,18 +26,27 @@ properties:
       controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
       Or direct MMIO address space.
 
+  ranges:
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
   '#size-cells':
-    const: 0
+    enum: [0, 1]
 
   clocks:
     maxItems: 1
     description: reference clock
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: port
+      - const: test
 
 patternProperties:
   'phy@[0-9a-f]+':
@@ -54,6 +64,9 @@ patternProperties:
       resets:
         maxItems: 1
 
+      phy_type:
+        const: utmi
+
     required:
       - reg
       - '#phy-cells'
@@ -67,6 +80,21 @@ required:
   - '#size-cells'
   - resets
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-usb2-phy
+    then:
+      required:
+        - ranges
+        - reset-names
+    else:
+      properties:
+        ranges: false
+        reset-names: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


