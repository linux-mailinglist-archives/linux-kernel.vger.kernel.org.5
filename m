Return-Path: <linux-kernel+bounces-92445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB8987203A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE441C21C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495386636;
	Tue,  5 Mar 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phACKYP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496F85C66;
	Tue,  5 Mar 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645536; cv=none; b=a/wdiDnuEovOkohBc1HvHwCSgvEXONjCSgyFW5uTTgG1rjSZX1SfoMI5SSm1bQXrF17RqehUpyuKmQ2CYgRTTwta7gnlesEPMrjLQH03vUPCKnxMXPIiPnWQa3WuFeq4WWjeuwzhPBBvmr1My0ot4OnJ/DoFiuHuPqsOOOyIUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645536; c=relaxed/simple;
	bh=Nb/la9hCvIDGODkj1BLvn7upbkGoEP4jj+8C4O4Wx18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcbXj6d7Y+09VgfDUMLfgqX2KDZHKKUKi51d/m+dpsTQvsQ0c5TR/47wp8fcNEbtQyWEF4myPvOAEKO5pTxL/QVk51xHi9bSXB7DThPJiXWmzU4NUBh08GDeBnMaXVgq3Asa/cAvI2OLj9MVOgJNHyerFO/st+i2C32pKZ3peGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phACKYP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0A61C43142;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645536;
	bh=Nb/la9hCvIDGODkj1BLvn7upbkGoEP4jj+8C4O4Wx18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=phACKYP4bxHuSKTroxu12V5abLAd9RbYWBgi5lXWGpJwkRGNAebFUsWZ211RpJdjY
	 5TxzoBxNe8au723oKlhXzEyExbNBbJHEMbLx41mNlnTww8TKWsycR8HX4qy5TnwBMB
	 sd/63KcLI67sEO7BhWJxsArop6VUJ6cB4b+xkghLrEOA+A/+KZChq7y7IIWla9tlMw
	 aBIgvIq/aDwysQD+saWqXHAsRywO2XWTDSAFW+4MRHsKusEyCgX4kelcetTCXrS8wn
	 vSFanj4Ki/2nj1M48pIW/+8xJ6xb5f9RuCUQHx+xvECytRHnoSh0bjhjpMOcpe/u5g
	 KqRgOcQhEDgvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C984BC54E58;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 21:32:15 +0800
Subject: [PATCH v5 4/5] dt-bindings: phy: hisi-inno-usb2: add compatible of
 hisilicon,hi3798mv200-usb2-phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v5-4-dc1cb130ea08@outlook.com>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
In-Reply-To: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709645533; l=1981;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=wZ19rp19Vxc5/c1Dz8YVfg/y4dYjOmfzasZL5uF3AuA=;
 b=laTgr7rJDNdlboI1H7dpo6mz0du6YBTHCCt3kaSDfLB8oX1yhtR61C5PbSS3x8vGdOK9DnX/n
 /DTfBsX3T40Bjc+S1BNnjcC2yM2YTGj9HBYCSfV8afzn5V2cOrRQ1OT
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV200 INNO USB2 PHY is attached directly to system bus. Add
compatible "hisilicon,hi3798mv200-usb2-phy" for it. The ports of
Hi3798MV200 INNO PHY has its own address space, so

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 31 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
index 7f0811a2dc2b..92559bdc4fef 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
           - hisilicon,hi3798mv100-usb2-phy
+          - hisilicon,hi3798mv200-usb2-phy
 
   reg:
     maxItems: 1
@@ -22,18 +23,29 @@ properties:
       peripheral controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC,
       or direct MMIO address space.
 
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
+    items:
+      - description: port reset
+      - description: optional external test bus reset
+
+  reset-names:
+    items:
+      - const: port
+      - const: test
 
 patternProperties:
   'phy@[0-9a-f]+':
@@ -66,6 +78,21 @@ required:
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


