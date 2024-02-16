Return-Path: <linux-kernel+bounces-68457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DAB857A76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D121C21F20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D726537EC;
	Fri, 16 Feb 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB7i8Ce5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649C50264;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079897; cv=none; b=IXW5BzHF9Va3Rjd/T0PdfDpqXwWPX23ZxLwJu24zo1WcpoPzuvmlsqwNnc5Br3FeUfiBAy0l4wACh1oSLlIGM550EoqIIwbANnwaLiGLilYswU4SyOHLGGMizY0dBQOfwPyZy00MJ9mP6JtsEB0sFjB/0a2yK1DY1+GFSTzRNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079897; c=relaxed/simple;
	bh=i+Vuj43hsVEPzoGgz4a3Q8F7l2DMBvqiA2pf0UdwPck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IvRq7+duozHVo8MWimq7GnLE8LSx4cl1TrWNZ+kx6C2kUmH14QjolOxdTz2vlSa9Ke4UWiqFWc3YgfXM5MaAGbjd2kCEyQkfbQa+7rFay3/JlAVRtmkq51K53bkKc+eQ6hY9WIpNj/+/UyNlxmDXDWN8+Ky/wq05Fy7BPY+fEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB7i8Ce5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E323C433A6;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079897;
	bh=i+Vuj43hsVEPzoGgz4a3Q8F7l2DMBvqiA2pf0UdwPck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sB7i8Ce5UUgG9ucieupKaEFItFfnzHNTCPkTa2rGWHRGq7AmjN7yjDaFiJ3J6p7uw
	 1ZMR1CXehjtluTmUymbqksOtTFIehqF+ASDec7gL1FE79Nf6e56vPM4SLUhDejw++1
	 f+RJrYYAxfpm4E30yL08PpKbEoOd1UcV2BD8SjSQec1HctCNnCr88KJu7VbiVenWpZ
	 T809n7gqrkNnnZDKKPMyfbRXvG+S3Vhtma0Wl624OhlzpCLQf/W0kL0B/mQKJoB+Do
	 36liCZ1uW1EsQk6JlZ7cHEa1mXlLYX8bMZsLvbUrTXCixWhzZlfaMG64RqI7h1o13S
	 a017nFdFnhQsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05343C48BF3;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:38:01 +0800
Subject: [PATCH v2 3/4] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to
 YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-b4-mmc-hi3798mv200-v2-3-010d63e6a1d5@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708079892; l=4548;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MhYnP89qf0tfDgyE6N4KsU2Wv7bDRFW26kU5gL/YxOg=;
 b=WE4X6hv6ceAvBU3ol3qST43ErtQX4Hb5LOCHmHe0PqYeriaJbNN3CxfiAaBGQJywnIMnGMY1X
 C8dHZX2ugsbBLaahrlTe2M5+loTh8mDaee+eFleO/sNUQfv5VuVlH9B
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
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         | 73 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 40 deletions(-)

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
index 000000000000..9db85a0fa41c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
@@ -0,0 +1,73 @@
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
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+      - const: ciu-sample
+        description: card output sampling phase clock
+      - const: ciu-drive
+        description: card input driving phase clock
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


