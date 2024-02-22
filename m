Return-Path: <linux-kernel+bounces-77272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1D8602F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EEC1F22438
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B06E5FE;
	Thu, 22 Feb 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5nu4Iek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4354902;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=Zd7SxnmcuQHe23eR7/Cr2t1hOW1l/0Vidx3Gnj2+kDuyxeA7vXmwYSbv4LfbnrvVGqcf50G3xK6zTX3kfeTMUzp6Dj3dncXfvTJJuB83YXSIfYcJW6y0P0pTiM78XLitwo09Snkru1CT1/GeH/9zSZG/7XXYhkeupFnr21wsoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=AH78cCTr7dhEVWFYAwhWrhR8lqe7nzIAxBDvIRMgfUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MREQLbNBqPEmTjNQEBhGqJsG+eeGE/04LgjhCChRg7y7LsdTbP93W+DGiWO+e17DOC1UBffih9XPQIb7Cg2UI0uryOG72jEmvycJ91gBC92VZJo9QJJyQWrooo2o41OD/tPqMMBAHZQeCSO2hs7CQORQNi9o08e7bwV3jCCuEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5nu4Iek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B229C433F1;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=AH78cCTr7dhEVWFYAwhWrhR8lqe7nzIAxBDvIRMgfUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g5nu4IekCQG+A8Yt/S4nShiR18VzfnpJ5nYiE3ddQtu22+I/ztm8qHBjRrZ9LBcVo
	 09R7tzUlnjnTCjofN6rP60MjXWb8JXN7K9cDeMPZehkCDYDoFRG2TRelqbURvqa7Fo
	 Eq+JiMpMhbAVKu36mpJexyVDUh2rE1mMGnxTYxDxlTS6ZCEqKcCEP6y+wVzHqClrsR
	 bY9V4nIQJJ4b63zySUdZXip7Y7KvMMPO8mUfLSgpgFu0WEYHa0XvYIO46wrZsQUBFG
	 jEPQlDQlYOYyaOlpBhSIrm5k0Ohqm0pOWiHbhwBg+i2AMueF5W5Hpe4EVzeXXRXrsS
	 umN9nnq1WejiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD0C5478C;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 03:40:11 +0800
Subject: [PATCH v4 1/7] dt-bindings: clock: convert hisi-crg.txt to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-clk-mv200-v4-1-3e37e501d407@outlook.com>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
In-Reply-To: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=4441;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=BpMVKDzX1uOIaNylx4gkghc96HEFugmrUQEA+SEAU8g=;
 b=zmLi+nFDKGMq0GTgpZ6YrTY4/pnALpM6nt9vGWYTTXNsYF9GP/qjnEQ3Tegun4yOivFgLdWAw
 CvkYxdT1DPgAssOK62o/fIx8D+p47I/6hIONsjCkpOTfqGE/p/wof+B
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Also rename to hisilicon,hisi-crg.yaml. While at it, add "syscon" and
"simple-mfd" compatibles to match the existing hi3798cv200.dtsi.

Add reset-controller subnode for hisilicon,hi3798cv200-crg to match the
existing hi3798cv200.dtsi.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../devicetree/bindings/clock/hisi-crg.txt         | 50 ---------------
 .../bindings/clock/hisilicon,hisi-crg.yaml         | 74 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
deleted file mode 100644
index cc60b3d423f3..000000000000
--- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* HiSilicon Clock and Reset Generator(CRG)
-
-The CRG module provides clock and reset signals to various
-modules within the SoC.
-
-This binding uses the following bindings:
-    Documentation/devicetree/bindings/clock/clock-bindings.txt
-    Documentation/devicetree/bindings/reset/reset.txt
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "hisilicon,hi3516cv300-crg"
-  - "hisilicon,hi3516cv300-sysctrl"
-  - "hisilicon,hi3519-crg"
-  - "hisilicon,hi3798cv200-crg"
-  - "hisilicon,hi3798cv200-sysctrl"
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes use this identifier
-to specify the clock which they consume.
-
-All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
-
-- #reset-cells: should be 2.
-
-A reset signal can be controlled by writing a bit register in the CRG module.
-The reset specifier consists of two cells. The first cell represents the
-register offset relative to the base address. The second cell represents the
-bit index in the register.
-
-Example: CRG nodes
-CRG: clock-reset-controller@12010000 {
-	compatible = "hisilicon,hi3519-crg";
-	reg = <0x12010000 0x10000>;
-	#clock-cells = <1>;
-	#reset-cells = <2>;
-};
-
-Example: consumer nodes
-i2c0: i2c@12110000 {
-	compatible = "hisilicon,hi3519-i2c";
-	reg = <0x12110000 0x1000>;
-	clocks = <&CRG HI3519_I2C0_RST>;
-	resets = <&CRG 0xe4 0>;
-};
diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
new file mode 100644
index 000000000000..251156905a7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/hisilicon,hisi-crg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon SOC Clock and Reset Generator (CRG) module
+
+maintainers:
+  - Yang Xiwen <forbidden405@foxmail.com>
+
+description: |
+  Hisilicon SOC clock control module which supports the clocks, resets and
+  power domains on various SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: hisilicon,hi3519-crg
+      - items:
+          - enum:
+              - hisilicon,hi3798cv200-crg
+              - hisilicon,hi3798cv200-sysctrl
+              - hisilicon,hi3516cv300-crg
+              - hisilicon,hi3516cv300-sysctrl
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 2
+    description: |
+      First cell is reset request register offset.
+      Second cell is bit offset in reset request register.
+
+  reset-controller:
+    type: object
+    description: |
+      Reset controller for Hi3798CV200 GMAC module
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798cv200-crg
+    then:
+      required:
+        - reset-controller
+    else:
+      properties:
+        reset-controller: false
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-reset-controller@12010000 {
+        compatible = "hisilicon,hi3519-crg";
+        reg = <0x12010000 0x10000>;
+        #clock-cells = <1>;
+        #reset-cells = <2>;
+    };

-- 
2.43.0


