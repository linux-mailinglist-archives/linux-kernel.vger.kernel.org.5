Return-Path: <linux-kernel+bounces-72003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AD85ADB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF05E282CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF356B89;
	Mon, 19 Feb 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcvjZdSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65554770;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378080; cv=none; b=qLTfAhwHyKoJCTk+e/akv99TqpZANmXSVLZW+Wg0+FuwarlUGZYn1NjqAWdBFgwWtLUHqlZi7YuSZ1eczngjFtW2TFWLGjDSv9jeiOvLW10kRd77l2TTNVclAu0mVZLFGQghfjog/UcJGqliBsFk968FEJvmYZ0nKOvpcbkKuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378080; c=relaxed/simple;
	bh=bubzY9/Q81Ml7PldAcrUeOkRxvvoWWMJMf+jhZFDA1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRMaJ3HIHCkX3nSxyxrUQvClYeZqikuERYc/lCyTZKiV2ifZtHRxKoEfOHgbmu1fhrenErz6HjnM6Az6LQAxdLW2ToGDsQAZGlAsgZPjDHSCdectuwL3O6kfRNFkZaVOYJ+CTlL6i5wzrkKLKPfwX31fWMgYIF/Q4zhuKDznVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcvjZdSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C9C6C4166B;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708378079;
	bh=bubzY9/Q81Ml7PldAcrUeOkRxvvoWWMJMf+jhZFDA1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OcvjZdSXTUQpicinGKWLlKRUdttBhzQoryWSwgH+x/FBTFVIak/f/s8jJacvGs93z
	 8l+KQT0s9XmzcR7bNeGOci0jOcUP2Yn+qCFoVx77mWH320r23D3cliX+M07XeOFcA6
	 zqorjNs5D/sivfkdUTb1FCL8Qs1U/7fDPrJEuoFnNgtmXg5099Q1f28We6QtepsLcX
	 YQDUvuW/ql4+akdghsOBhG6dKK/9gpH5/w7MDb5PyIpJTgr8M/slfG/Z+PwGYGFjfw
	 zEiaJ1X6N4rnOhOocp9VgrZ2qyPQ4R81l9NHbDsDQCkKphdg2s4iMgq1KAvW8K0V0f
	 hrPjO8fcOJ3EA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A5C48BC3;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 05:28:02 +0800
Subject: [PATCH RFC v3 5/5] dt-bindings: phy: hisi-inno-usb2: add
 compatible of hisilicon,hi3798mv200-usb2-phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-inno-phy-v3-5-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
In-Reply-To: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708378078; l=2027;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=avj4AQctpHODHrI4Gj2Nnv22VVypJnyWPLnjEGJEEdE=;
 b=xZ9uDnvgbLGc44UOmznpNLi5rmjnlS/9CKX9jmNtOvRqOBPi6PeuTIZpq5jyKB4Ty1XXjQjBh
 x660NzaUFhPD8H222qtB1e2SROUGiE+AjJFtRO97Ci2oNfsllIBvmhi
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
index 1b57e0396209..969fd3fb7537 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
           - hisilicon,hi3798mv100-usb2-phy
+          - hisilicon,hi3798mv200-usb2-phy
       - const: hisilicon,inno-usb2-phy
 
   reg:
@@ -23,18 +24,27 @@ properties:
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


