Return-Path: <linux-kernel+bounces-80050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D5862A31
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46DAB20D10
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E20114006;
	Sun, 25 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZeTwsNu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80912B6C;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862643; cv=none; b=HprROPRi0BN5EDuUZ5WKIKYgCMqPKK+MNbUH98E6bDSRTikHKbFCmXumICSHDebwUNI9wKxPpdCAse7q/lYU7nNFtrh2/IQSKCPKyaKODpgE3bOmq+ethba/MpxGYaPk0r4XeKlS712Gmup28L/6TlgvZSKVAjteBGfSnCOkVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862643; c=relaxed/simple;
	bh=G8ub14H/UFjsvGpsnX+JxTo4g+Xp7Uh6sxopc63ZR5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XF9G3R2RnKXtfdiYaQbgZWihdE/hFdYV6WltElLBOfWZY5fETdFGsluc/9VrLnvMuzxnVaKx4aUm9mhv5H9dzoiUQSuPA7HeX/5KA8/7i7/KnIT+5hdu5IIbZ7RfdN8v5O8QYs9yG3X/+7PLp8sUbdM0gZpCXphpw7/MpPH5efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZeTwsNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D1BC433C7;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708862643;
	bh=G8ub14H/UFjsvGpsnX+JxTo4g+Xp7Uh6sxopc63ZR5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LZeTwsNufN1cu92JPfd363vX0VP0Kj/WRJTwEYWo/W+WXISH9ehnPQz8flgqT4MbA
	 wWNdu1483wxFCu/mCIMazflXiggyiuIjJzLz/RyYTUkBJjUVKOugLO1ur/dZH5q1Q5
	 /9+mx9VJx2ZX/o7hl3O55mbuaaE/nlsImrN9/tgYPqn+AWTeg/mhVqRYTtiS1nNI1Y
	 R+JUEyQdOHYN0B1M3WxhVdccqgo0Qlyi6Zi74AvMSZYeTKBfhuFT7kgZ2ECiR09FVK
	 qLrIo4P0JJDh2NMKUCaNleny6jB1qDokzN9pdnxWQpnr3EOD43j5pt1CILAiJ6YKVv
	 1MgFwtUwbI+jQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF4C54E41;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 25 Feb 2024 20:03:48 +0800
Subject: [PATCH v4 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-dwc3-v4-1-8c1fd6c6f615@outlook.com>
References: <20240225-dwc3-v4-0-8c1fd6c6f615@outlook.com>
In-Reply-To: <20240225-dwc3-v4-0-8c1fd6c6f615@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708862628; l=3124;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=TbIIsLb8wqVTCtqqeG/liaxRoSs/eRWYcg7QPbnIgSo=;
 b=tVwGmT7az1FU3fbwJTBcEWSw9tsPGkJZ+u6uN1rLKxH6Ie+oZJ42eYFoB68jNUI+cvIaRbx38
 11Qz04FPRFKBwLk57nRugFHWTewUrNoftNUIWUrecM72qd1H+Bwnu50
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Document the DWC3 controller used by Hi3798MV200.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
new file mode 100644
index 000000000000..f3011694393d
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
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
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


