Return-Path: <linux-kernel+bounces-69848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D836858F70
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BE283268
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BE7B3C4;
	Sat, 17 Feb 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZJ+9uQ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C007A737;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174337; cv=none; b=pF7E3XPC3ocd1kHgpXTPdJDobaAL66txtGwME2wHcpXKmzLoDJmrEe2bo6ul5HqB4kFAV50Y5A/m20JqBr4he5gMT/QOauqzIDlaloJfuCEJuDo93RWlzZ9o4qw7E3WMNk9T8WjnofrnLuR5EGufXcm/lhHfk1VbM2LWTrF9VvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174337; c=relaxed/simple;
	bh=gqPEFDQHpu81vXVsnhzolpglZWQoqj+GnvzWjY5MgHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKrtr5i89Vp/INBK63TFlqsm1WDGaBNzrJyZRtracMmfOkJBDYxbZqU1Y3aPvgkgsOYagwrMvCgAVbYwrIufutf5sPGed/mfpEw3E99axZVHo04mnLLwl0RlstS9XXO7jn8shmB9G2C7qVE2jX1X+oyQYeqMgEIxcWDb5zu9FtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZJ+9uQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B28E5C43394;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174336;
	bh=gqPEFDQHpu81vXVsnhzolpglZWQoqj+GnvzWjY5MgHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FZJ+9uQ+7mduduqlyUzNdetaZJQAwkDv2IsPAyhtUynbAipwbbgzDZ0zM+rxREyuC
	 8xpHW21PzohXzdF+ksjr/TSRhhzzmhw8ev69DhA8VAFXTMVzx/lMphv4TorrUuZZVv
	 WmKwz8WJ8mixF2Dkpax6+EuT7zC9C5mx8XREHI9ydZfvAMjOlrTn23AjkXhD0NqD1k
	 3j42uiD10QFRTyBBYpl/9SminzXu5fbUaE4xBL7yUHJEHz3v1yLgux3oHDWdxY9x2k
	 /Frc7jRgzJ5wTQfxs61Z74DjmSL/84JtdC6Zu3H0GMkq1VUwopibvWAFkfZ5ktxNWD
	 Mp1/Vg/QoyIpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4031C54766;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 20:52:10 +0800
Subject: [PATCH RFC v2 5/5] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-clk-mv200-v2-5-b782e4eb66f7@outlook.com>
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
In-Reply-To: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174332; l=2294;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RxQshU93zhdnmZ2d/Il86mfOujovTqohz/PSfKt9R1k=;
 b=7dvRZcX3d6TSDhTJY4jp42UE2R0R3snYsUTJH3/tG8XNPt5ikHJjKMOziv2tFvJ4R9hTbKM4q
 GQyyF4aZsqOCjILRXexRS0iLS2kn1yNPw4/PcGWx86lN269nJnWHk9g
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200.

Also document the specific DLL regs and add an example for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../clock/hisilicon,clock-reset-generator.yaml     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
index d37cd892473e..8ee844574eda 100644
--- a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
+++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
@@ -44,12 +44,17 @@ properties:
           - hisilicon,hi3519-crg
           - hisilicon,hi3798cv200-crg
           - hisilicon,hi3798cv200-sysctrl
+          - hisilicon,hi3798mv200-crg
+          - hisilicon,hi3798mv200-sysctrl
       - const: syscon
       - const: simple-mfd
 
   reg:
     maxItems: 1
 
+  ranges:
+    maxItems: 1
+
   '#clock-cells':
     const: 1
 
@@ -87,6 +92,12 @@ properties:
     description: |
       Reset controller for Hi3798CV200 GMAC module
 
+patternProperties:
+  '.*-dll@[0-9a-f]+':
+    type: object
+    description: |
+      eMMC/SD delay-locked-loop (DLL) register subnode
+
 required:
   - compatible
   - '#clock-cells'
@@ -137,3 +148,28 @@ examples:
             #clock-cells = <1>;
         };
     };
+  - |
+    crg: clock-reset-controller@8a22000 {
+        compatible = "hisilicon,hi3798mv200-crg", "syscon", "simple-mfd";
+        reg = <0x8a22000 0x1000>;
+        ranges = <0x0 0x8a22000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #clock-cells = <1>;
+        #reset-cells = <2>;
+
+        emmc_sap_dll: sap-dll@39c {
+            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";
+            reg = <0x39c 0x8>;
+        };
+
+        sdio0_sap_dll: sap-dll@3a4 {
+            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";
+            reg = <0x3a4 0x8>;
+        };
+
+        sdio1_sap_dll: sap-dll@3ac {
+            compatible = "hisilicon,sdmmc-sap-dll", "syscon", "simple-mfd";
+            reg = <0x3ac 0x8>;
+        };
+    };

-- 
2.43.0


