Return-Path: <linux-kernel+bounces-68535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32440857BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2451F26387
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AB78681;
	Fri, 16 Feb 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPBYIdpK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0077F29;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083475; cv=none; b=IZDhRBSNOaDshjwveKK5GXbtwQ00gQiV3e/DjTiSOoy+WD5v8KmuORsDcelrin1t347w/c5tuLeW3bHG5DTWa+ogl4H68Iu8J0XlLWDav/ckK32ZEtlyq4F63EeKOSQUognhjFs+A4TBHaPLq3AFXA0dJtiWUGf8bVMRJh5wUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083475; c=relaxed/simple;
	bh=gqPEFDQHpu81vXVsnhzolpglZWQoqj+GnvzWjY5MgHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXNVll2KGNbdQ4DEoMF+WLAWPtLsTfJqJPwtDYHC8GkSAFmJgaso7iftAEdyLBbANNnu7ZVY2M7e1T/O2rH3bHf3q2p8dY6TIh6bOCTavB2p6YG/9OB0tRtfVYVlgjkgrconJhl+gmtJnjGNKqbShL1Dri3o2Uy/u5XAzjFWKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPBYIdpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEB9FC433B2;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083474;
	bh=gqPEFDQHpu81vXVsnhzolpglZWQoqj+GnvzWjY5MgHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XPBYIdpKGU+2ZmLx5+32gxHiCHvvO6IKmoSBmreMQZ1iorNrNEjj+efxAYMHb/F+g
	 aHLtyI2Doop1MR9VU6VNI8wVfCuFHedyMU0e23dYMrJlk1R/A+u6MzZ2VT7CnWQ/pe
	 iwySjZ5GHOjcwMuWgPlVzCKcZUFlbWHHLyBDziXElu8ym3WhTxcZt9fgGWmkTOH8/n
	 EKcNDPD4jL3EMx13+n29GKw5lOBMhUX7Bb3TVrVIpIj6UiiLX6cYPrkpFaxP8tOxRZ
	 a/rL3+3/I7DbYglyHpL2WJk/i7rbJU25BN6zVxjPAQ9zh3zAkhZxL0n3tRq0EctYKk
	 DhOMPGKycjqtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E3C48BF5;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 19:37:54 +0800
Subject: [PATCH RFC 4/4] dt-binding: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-clk-mv200-v1-4-a29ace29e636@outlook.com>
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
In-Reply-To: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708083473; l=2294;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RxQshU93zhdnmZ2d/Il86mfOujovTqohz/PSfKt9R1k=;
 b=HeGs7bkTJR06qX5l+QDDNsx44/mocS0/PjmA9206O/LAGsmCIJOVNyiaJ6TNDvBIk1wiN9xRl
 zwHj4z36O6dD6EujUb+qIUvEc4k3PI1Fqfdmb6Q9aTIrSEMq8aW6n47
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


