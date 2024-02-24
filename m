Return-Path: <linux-kernel+bounces-79625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B418624DE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976141C20C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8EC3F8E4;
	Sat, 24 Feb 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9guFfAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385A250EA;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776620; cv=none; b=lIxXH+beYIgdkeIFoOg9etSYg8pa0CCZKdkK8gLvooefhf6T6RStw3OqVIU4Nr212Z3AO0Vd5bL/jcapWNao7EDwymtHtnG2XNSCxW95nrUNi0vi87B5zQ8ao9eib8C2DYE2N14/zYblc3yutvOwIfKurwlUryMUt5UYVBkfkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776620; c=relaxed/simple;
	bh=Y/mv5b45NNa7XhCnyle8CDh3gsyrXcnhCzFA4aYSuaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0RV3TkI+pAxlL4sMSfe+rD7jwrQTITouAPPh6fjIs9f8Pn6PfpcqI2hxELDnNcQPgLAN27lEvJclhoIvFL6/1x92vCnV9QKxv0NCT681yWiqkx9XQXsn48w7oUlWHZBxoCa8zfLrC6pwcXD3bvX6oaUP3t13eVUDajh1ZrNfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9guFfAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F98EC433C7;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776619;
	bh=Y/mv5b45NNa7XhCnyle8CDh3gsyrXcnhCzFA4aYSuaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q9guFfAjFg3Kpd80dy8WG9xevz+dOvi5rFVPtX4sQpS24kf6kjalQJf6YALJ6Kcvj
	 OTXn7iizuWkUd1F6CQQbMVCB9hZ+CqFvDgV9tlt0BuOWPHIxV4vSpLQGl/tyFjc8Hg
	 mH+nGH5RSP7fhIBvZW3F8B8HISdAP1pdWtCWo48otp61tSg3opOmDTBJj5omxkCH+6
	 dWVwVhhDEH2Mx0GRtYRCGP5GW3zx60Aq5cqk/W/272KA0msINfVVHkMhnt2btpflqt
	 acfAVIqBSdGRheeHjhbHPSVP0YXsiKXjCz5fsY/EBM6+22Bbh9+fiI1r9RDYSKSQkq
	 3xJN4BsrQ1qrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79816C54E4A;
	Sat, 24 Feb 2024 12:10:19 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 20:10:18 +0800
Subject: [PATCH v3 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v3-1-2535fcee7f08@outlook.com>
References: <20240224-dwc3-v3-0-2535fcee7f08@outlook.com>
In-Reply-To: <20240224-dwc3-v3-0-2535fcee7f08@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708776618; l=3057;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jRJYka21Rl3jtVAQxHQtRgS06ZtXY4Ef7fNvMXm1l9Y=;
 b=14y9842xN9JS6FBVs22HlDE4O7AMN9Q7TM0Mxrfu9Yh8BIeVQIL5JcdNk8w/sZUQjJfNuMqYh
 3/KLUFYNPwGA8LkKQlypHN9azB6ciK2EzIEptWC5L57E33iG7G7RHci
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Document the DWC3 controller used by Hi3798MV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
new file mode 100644
index 000000000000..0c26191e9d74
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hisilicon,hi3798mv200-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Hi3798MV200 DWC3 USB SoC controller
+
+maintainers:
+  - Yang Xiwen <forbidden405@foxmail.com>
+
+properties:
+  compatible:
+    const: hisilicon,hi3798mv200-dwc3
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  clocks:
+    items:
+      - description: Controller bus clock
+      - description: Controller suspend clock
+      - description: Controller reference clock
+      - description: Controller gm clock
+      - description: Controller gs clock
+      - description: Controller utmi clock
+      - description: Controller pipe clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: suspend
+      - const: ref
+      - const: gm
+      - const: gs
+      - const: utmi
+      - const: pipe
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: soft
+
+patternProperties:
+  '^usb@[0-9a-f]+$':
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb {
+        compatible = "hisilicon,hi3798mv200-dwc3";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&clk_bus>,
+                 <&clk_suspend>,
+                 <&clk_ref>,
+                 <&clk_gm>,
+                 <&clk_gs>,
+                 <&clk_utmi>,
+                 <&clk_pipe>;
+        clock-names = "bus", "suspend", "ref", "gm", "gs", "utmi", "pipe";
+        resets = <&crg 0xb0 12>;
+        reset-names = "soft";
+
+        usb@98a0000 {
+            compatible = "snps,dwc3";
+            reg = <0x98a0000 0x10000>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk_bus>,
+                     <&clk_suspend>,
+                     <&clk_ref>;
+            clock-names = "bus_early", "suspend", "ref";
+            phys = <&usb2_phy1_port2>, <&combphy0 0>;
+            phy-names = "usb2-phy", "usb3-phy";
+            maximum-speed = "super-speed";
+            dr_mode = "host";
+        };
+    };

-- 
2.43.0


