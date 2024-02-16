Return-Path: <linux-kernel+bounces-69342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E498858795
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CF0290331
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BB146010;
	Fri, 16 Feb 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C07eQKQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15913A253;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117351; cv=none; b=uv4NrML19DiYgjzx8pAFLtpP80V/UfCcUGZw93PS9wkglDiaU87MLz56dnwt+lHYy3JhgwiTQhIsK5CjKQXqduEGSQh1Jk8Ro7xfy6d8jdvEu5BEQfKFHNFGHTqXq/UL5RN0Ps4CxT1iVZSRdDyr6BySnsGHJzedFlRZt/OqDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117351; c=relaxed/simple;
	bh=kE1iyc4ikKEePbnss5tHCv37+9gy1c6VUZo9PtTp2VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sft8clUTRvFd0OIwR7wwzKYb3cfY3hNYwTvjWYRzU/SOnLfY3s0Qm1jIApzx0OnZiHM40j0FupzY/7SdFJ8NRiQwvzWmX6LGU3+elXNO3Lq6jrXG0fOsCYKkZc+JjAsGwwImk7WtQkV8d+Hvu3Airk1N6UOr+gZ3DiLXGk5ESUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C07eQKQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AECC5C43390;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708117350;
	bh=kE1iyc4ikKEePbnss5tHCv37+9gy1c6VUZo9PtTp2VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C07eQKQuKatfj2Ac8JpK08JodsOWphQ4g5sN/WEGrnqZdH2QsknZASQZf7c2Huajg
	 lhsjswgwz8TIF9siW9rQmz5/ZhnZgqhReVScmKvDJ9ZJsyBFRW5VD3IvyBdZTlkXhA
	 DwaW8Xxrk9mUvqgfiNk7AVcICubKuQe2j6vcptlWCWDgs68sVNyzwXjHGTO1hatPkK
	 +4AVJYz84KuhOvSUDb9qPXzpZEFFePoa/LtINMOgUvtR3zZ+P5iuZUnuhEwO2bQ6Cs
	 BjJAlZY42117iy6FVZVmX4Oh2i/lGG1EWxu8mL+p2vafApPprjUt8QnCUIa8Z8WRan
	 24/TMCBiulcfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453BC48BF7;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 05:02:31 +0800
Subject: [PATCH v3 3/4] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to
 YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v3-3-f15464176947@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708117349; l=4642;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=2gvcPOcC0W9JjDo7uuJyb8+Jf0I4Z6n3x2BDfI4hOUA=;
 b=XQLOvaUzbqwudm3uFoDFpaPXJ74fVzy8FO5758AmTMQ5ydj2UwcnG5gkaFV8xtWgmuQ8n6bdB
 7IXYLHTxOSvAYTbQeGJbgmbRh5aI1LtH8q/KibB5viAWCr9MLt+UmZz
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

convert the legacy txt binding to modern YAML and rename to
hisilicon,hi3798cv200-dw-mshc.yaml. No semantic change.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ------------
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         | 75 ++++++++++++++++++++++
 2 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
deleted file mode 100644
index a0693b7145f2..000000000000
--- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Hisilicon Hi3798CV200 specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-Read synopsys-dw-mshc.txt for more details
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
-specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-- compatible: Should contain "hisilicon,hi3798cv200-dw-mshc".
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed
-  in clock-names.
-- clock-names: Should contain the following:
-	"ciu" - The ciu clock described in synopsys-dw-mshc.txt.
-	"biu" - The biu clock described in synopsys-dw-mshc.txt.
-	"ciu-sample" - Hi3798CV200 extended phase clock for ciu sampling.
-	"ciu-drive"  - Hi3798CV200 extended phase clock for ciu driving.
-
-Example:
-
-	emmc: mmc@9830000 {
-		compatible = "hisilicon,hi3798cv200-dw-mshc";
-		reg = <0x9830000 0x10000>;
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&crg HISTB_MMC_CIU_CLK>,
-			 <&crg HISTB_MMC_BIU_CLK>,
-			 <&crg HISTB_MMC_SAMPLE_CLK>,
-			 <&crg HISTB_MMC_DRV_CLK>;
-		clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
-		fifo-depth = <256>;
-		clock-frequency = <200000000>;
-		cap-mmc-highspeed;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		non-removable;
-		bus-width = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
new file mode 100644
index 000000000000..f3dc973cb490
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/hisilicon,hi3798cv200-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hi3798cv200-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: bus interface unit clock
+      - description: card interface unit clock
+      - description: card input sample phase clock
+      - description: controller output drive phase clock
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+      - const: ciu-sample
+      - const: ciu-drive
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@9830000 {
+        compatible = "hisilicon,hi3798cv200-dw-mshc";
+        reg = <0x9830000 0x10000>;
+        interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg HISTB_MMC_CIU_CLK>,
+                 <&crg HISTB_MMC_BIU_CLK>,
+                 <&crg HISTB_MMC_SAMPLE_CLK>,
+                 <&crg HISTB_MMC_DRV_CLK>;
+        clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+        resets = <&crg 0xa0 4>;
+        reset-names = "reset";
+        pinctrl-names = "default";
+        pinctrl-0 = <&emmc_pins_1 &emmc_pins_2
+                     &emmc_pins_3 &emmc_pins_4>;
+        fifo-depth = <256>;
+        clock-frequency = <200000000>;
+        cap-mmc-highspeed;
+        mmc-ddr-1_8v;
+        mmc-hs200-1_8v;
+        non-removable;
+        bus-width = <8>;
+    };

-- 
2.43.0


