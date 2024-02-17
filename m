Return-Path: <linux-kernel+bounces-69858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C8858F91
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC11B21EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067507B3D5;
	Sat, 17 Feb 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZueS9SS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA837A73A;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174882; cv=none; b=DwYls3mK3RRG8dIrMS7ykLAms9HygOjxbyKHfmCPmE/7Z3nwzFQLWyR7seayGJez8pWf8YIG6AaprywlPO7QJSWU4jpNYGIc4nPHtv4VelKzAg5YLdAYztVUXJmWJWgehok8n+5zEXB5YnOgOxRd56UHsHHLQM3WnKwArd07hZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174882; c=relaxed/simple;
	bh=ZAX9Em2I3TtnHcZcltf0TchJ6NPlrQE8PyBaCkDKCT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0XFIA2JNr4gAnfWzLhgJmtuAsqn1Lo2DKoYmBuOI40oSfBlmEzfXMe5faJsJYasQZchlRKn/ten2WEQOz2ziYzWzgkmBsIUdQnmxPYSRYDGZ0g1JWg5nNTj4OZXItI/oMl9juFZ3r/A1E/T6D5SjpWHHqI4XUQZvO4wEQnedhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZueS9SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A58D5C43394;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174881;
	bh=ZAX9Em2I3TtnHcZcltf0TchJ6NPlrQE8PyBaCkDKCT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WZueS9SS2pr3d2SQlDx7zGR2e5lKIQ6SqFK3dlCbExrAiYgG8YyE7B92UzMkPbUHA
	 mpQAdf+s/UXDgviAvbx147zfIJhGSACsopMqs8tWmWoVktrT2WXM3mFZ3+cRelzn/O
	 hObmaD0cUWieje6qXkOeN4/5UdNGSuMnc5zawvj1nUFx4gRWYKZx7CC8ri3LaNgGf6
	 5XN74tpmqZCotmLIYMZL5ElrFmbavSmAYFhPsOxATelxb0Hd7po5S0f62aJehQLrh/
	 Utis8qEBDxzeFzY5gnTYS2bhJQax4hnFv2D5ejmkbARxpcsoI/8N5Hk4ToLyD9Rihz
	 4S6uWTQ7u6nCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E985C54766;
	Sat, 17 Feb 2024 13:01:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 21:00:56 +0800
Subject: [PATCH v4 3/4] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to
 YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v4-3-0fdd9bd48532@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v4-0-0fdd9bd48532@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174876; l=4709;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=z5/cBD8zJzGgT2WFAWSZ2rRYPe9PGIgRVLWNL1lYtXo=;
 b=3/y8yFfax0Z8i0ogUexGcigrwWgsMQl5uH6jU/k+dW4L1ySMvgIZWa0msJ7KVjz4sN6a5gpim
 Eworul8TuAaBYJVlrk2o95GaEGeJ03Mkh3UlbgZ5hyxWjw0M7LDOXsX
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

convert the legacy txt binding to modern YAML and rename to
hisilicon,hi3798cv200-dw-mshc.yaml. No semantic change.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


