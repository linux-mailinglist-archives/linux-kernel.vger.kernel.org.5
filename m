Return-Path: <linux-kernel+bounces-67431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC129856B74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AE286417
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B350136674;
	Thu, 15 Feb 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLjXtOH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A21369A5;
	Thu, 15 Feb 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019203; cv=none; b=dROd8umKn4JQ9VX+Xim+949xdPhwPbeFWWEZ9loDNZ+RWFDVB2W2Dq888C3/tLEGRaJL5AMlB9IycJJG5g3/Dq/4IIzgpVJJ3me+SerXyqvXKZ9d1k8swfNKL3w8CNMgTnOlIt+4iW36GT1YICQSoPN2v5Y6swzq1deiHMT3OrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019203; c=relaxed/simple;
	bh=lxL66dGE1BOrYm4QxshP0XHSqTdjMz4TaApVwNhX5NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Td7RRu6YPdKvH8Brkq0pJk4KE+yRNj9LCKNa8Stm7aj6wXP4HGB18j9oh6pZLrPeRReA0Re9OaE0YM9APtPMnFC61MbDOmJWCkvgt1Ls9ChD7qZJaDJGWjUgKv/05t+iIBMWue3ATih2rEsQMRPEl8QMfuvUGlYXO+EVhuAtt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLjXtOH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A3DC433C7;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019202;
	bh=lxL66dGE1BOrYm4QxshP0XHSqTdjMz4TaApVwNhX5NM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GLjXtOH98lDkvnrRRk2+8Ugn4KCsQAZKIo09HAD3zQv5OmMv6gbn4v55lzbgCBssh
	 bPH7Tmj9o1DfIzEnVUUnlZCpHAWff6sJmBmPYyJ7obH8DhL/+tvcHvSjVQIlhb22iM
	 RJ8yglF4fikHWbCQzQKa8D1SbyJ8FZia53bC+FlnkyLldL43ftuaUNRvUAS/LY+tMW
	 lm+iKv4tKTb76tYBJ+BqleC/Ui+BEqdj/3njKdovyHqQon8anJQwipwWNnq/g0bbU1
	 C+L/WB9UeO1y/mIH5jKTsUye8Y8MmBeQnryGcI7+6OofxQFJ5fYX4L0PxR2cnM3Jlq
	 n6Io7+/hwUIOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8EC48BC4;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 01:46:43 +0800
Subject: [PATCH 2/3] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-b4-mmc-hi3798mv200-v1-2-7d46db845ae6@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708019203; l=5102;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=0sfwzUJFuIVX0g0d41ym9HjyV3Dmi6BtolqAT23dmoI=;
 b=svcO27zuOfcdnzZZ4edz71kuiUhQEZdFeRSN7MkC8maea9lDXe19IsHNuNpKSMS06hhgNlDbl
 E5NE4QOKQeJAao9TqTcn5QNXZgUyfv6HuAN/KwSuMV4+JTNUD9GU8ws
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

convert the legacy txt binding to modern YAML. No semantic change.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ----------
 .../bindings/mmc/hi3798cv200-dw-mshc.yaml          | 86 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 40 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
new file mode 100644
index 000000000000..5db99cd94b90
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@outlook.com>
+
+description:
+  The Synopsys designware mobile storage host controller is used to interface
+  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+  differences between the core Synopsys dw mshc controller properties described
+  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
+  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
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
+    minItems: 4
+    maxItems: 4
+    description: A list of phandles for the clocks listed in clock-names
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+      - const: ciu-sample
+      - const: ciu-drive
+    description:
+      Apart from the clock-names "biu" and "ciu" two more clocks
+      "ciu-drive" and "ciu-sample" are added. They are used to
+      control the clock phases, "ciu-sample" is required for tuning
+      high speed modes.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    emmc: mmc@9830000 {
+      compatible = "hisilicon,hi3798cv200-dw-mshc";
+      reg = <0x9830000 0x10000>;
+      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&crg HISTB_MMC_CIU_CLK>,
+               <&crg HISTB_MMC_BIU_CLK>,
+               <&crg HISTB_MMC_SAMPLE_CLK>,
+               <&crg HISTB_MMC_DRV_CLK>;
+      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+      resets = <&crg 0xa0 4>;
+      reset-names = "reset";
+      pinctrl-names = "default";
+      pinctrl-0 = <&emmc_pins_1 &emmc_pins_2
+                   &emmc_pins_3 &emmc_pins_4>;
+      fifo-depth = <256>;
+      clock-frequency = <200000000>;
+      cap-mmc-highspeed;
+      mmc-ddr-1_8v;
+      mmc-hs200-1_8v;
+      non-removable;
+      bus-width = <8>;
+      status = "okay";
+    };

-- 
2.43.0


