Return-Path: <linux-kernel+bounces-78814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EB861936
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282B01F2586D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162AD13248A;
	Fri, 23 Feb 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHPPPYMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20D823AA;
	Fri, 23 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708674; cv=none; b=rxgWLCiEp6B+UTIDXMT3FMpd8Oz/pNf+bF1Wwo7IPs+g3fnQN17M7JpEU2jKIY2n55ZWAI6/oYf3oGj1qKsrZ5EdBpmGDmRXs8/eYF59Slx6LN/74PBMYghwDC7EfmSYnmQ+ryh7iTfelDok95ux9aJbMoyy57cF5OQiaPfE1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708674; c=relaxed/simple;
	bh=XqhHlRFOh0p3EzbWAlXwzezqrqqunXvXPS2teqhfFtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiTFGibMKxE4UOi/tbkt7p9XM3tO/jeACT6bfXW3lJ8gpptGwgjCDdjHEd+GZccwxvi21OVDIQ5Ivv2axHbOuvRzmAlquqi8HhlZPuT6Sw4xSJtFLHCX7Nx00q95dt7gEX3XUBvhShJc2pFIZwWGGaKh1ZtEtfjnicySBt1NPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHPPPYMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E20D4C433C7;
	Fri, 23 Feb 2024 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708673;
	bh=XqhHlRFOh0p3EzbWAlXwzezqrqqunXvXPS2teqhfFtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHPPPYMHk3SD6zFHr5mT0/7v5w7sJGl0SVyCcPz6mNL3Yax5nBepIdzrgz9mt5Np8
	 F7kqUVsmmFFxdfJ9Jqz712L16S/yUEWEALHndSpzZBYAo/FqFnXornew+DOliMOsjh
	 VniKrAnduCNFKXdLm/T7oBUf4cBi6z8bPWnGgdTEGa2iYnJlUOZXiEX7gzweXnaLjC
	 GfkARMVY6ptQagew9blIoly7xWybAT9VFcXYl0jzmIZU9a9dqxd7U9SeWgq1y+nSQZ
	 qthuAaZIdfPDBYiuxt+Bxft5o4nu2TZe5j+he29NHzWeYJQZzlk0195Qw9xQjJETac
	 JAadwxBAhtpGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A41C5478C;
	Fri, 23 Feb 2024 17:17:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 01:17:49 +0800
Subject: [PATCH 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v1-1-7ffb2e2baa73@outlook.com>
References: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
In-Reply-To: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708708670; l=3418;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=9rvmNBv3Zah3IzddwZbZZSDtAcRKW+fEa/VQRxUOm4Q=;
 b=8Dm4hLdraiulGflzrU3rl1gEYtOktMQJHdPIsBeyoR/te/pnHcrgJ/JaddJYf0N4qRKVuf7Jf
 hDU+0XGE7lSAV4Wfo/W4X/gjOZ6Cwz5+DIYvvCaaYJrB33xvOHL5E22
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
 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
new file mode 100644
index 000000000000..0884d1ba6723
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
@@ -0,0 +1,100 @@
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
+  '^usb@[0-9a-z]+$':
+    $ref: snps,dwc3.yaml#
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@98a0000 {
+            compatible = "hisilicon,hi3798mv200-dwc3";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+            clocks = <&crg HISTB_USB3_BUS_CLK>,
+                     <&crg HISTB_USB3_SUSPEND_CLK>,
+                     <&crg HISTB_USB3_REF_CLK>,
+                     <&crg HISTB_USB3_GM_CLK>,
+                     <&crg HISTB_USB3_GS_CLK>,
+                     <&crg HISTB_USB3_UTMI_CLK>,
+                     <&crg HISTB_USB3_PIPE_CLK>;
+            clock-names = "bus", "suspend", "ref", "gm", "gs", "utmi", "pipe";
+            resets = <&crg 0xb0 12>;
+            reset-names = "soft";
+
+            usb@98a0000 {
+                    compatible = "snps,dwc3";
+                    reg = <0x98a0000 0x10000>;
+                    interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+                    clocks = <&crg HISTB_USB3_BUS_CLK>,
+                             <&crg HISTB_USB3_SUSPEND_CLK>,
+                             <&crg HISTB_USB3_REF_CLK>;
+                    clock-names = "bus_early", "suspend", "ref";
+                    phys = <&usb2_phy1_port2>, <&combphy0 0>;
+                    phy-names = "usb2-phy", "usb3-phy";
+                    maximum-speed = "super-speed";
+                    dr_mode = "host";
+            };
+    };

-- 
2.43.0


