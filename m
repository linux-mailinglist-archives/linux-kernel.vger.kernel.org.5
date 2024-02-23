Return-Path: <linux-kernel+bounces-79223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFAC861F32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC82A1F28A48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E214CAD1;
	Fri, 23 Feb 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfHyfDqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EC1493B1;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724595; cv=none; b=VYgBQKFjsJ9w4C7dLv8qpBP5sd6OeH8KeUfE8xFhDzPgUUpvcBJEQ5E3BRU2ugi8/toCQeV6RuuRnJP62exTgoOkTTCULMO+l28fEPVu3lfTIMcNyNNRLheyeCxczSoxvJ4LVjuN/g0pqoyTuU+p1J1lrgkswgqe1TRP97w3Lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724595; c=relaxed/simple;
	bh=JlDIzPVB8g61Il6cA8cxo+FBqhvdebJU8biCKYxI6Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2Dz3DGydgpuobYjCLfJN4yL/MfMfvRRyhVm/XQ/GZxsHPsHHEdWaHDawr3vY86R0oqV1jgZq9NOGlbWsD+RyXeu3OS8eKfxiNuqraQseMdPnZGPv9PRN1Ys8HfQJOXQcx3ZPtfrwtzKUA8jiOQcr1zQJ9fjdZT0Lg2jycBLvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfHyfDqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A20C43399;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708724594;
	bh=JlDIzPVB8g61Il6cA8cxo+FBqhvdebJU8biCKYxI6Dc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QfHyfDqmGzHQNKQviFH+J8TSfb20QU++tD5qTpSwYS5lz8Lhidn1UBrO7Mi6oq2k+
	 V9Jp2mwtO95t3RbrkhNUex3XYv0xjDtvaBLhpxaeERQjMH2l3Q8MOAyfnFK5V/3G6b
	 D/LI5oyCXq4SYcrTkcUf4Bkavl/r5mFGlj5ByWmzqswO2Pc7q27D7xJLU3oP79bMio
	 XswpYRzalUekwDsWqJh1ylMSJzN9yKQwtaNV2KBbB5vhu/VCmhIfM109ao3JU4bA+8
	 jt9S8th4K131WYNoH+k8U618Jh+EL9yWt1hfeBtF7nFAt88RjEQ79iWbrCm/aInrn3
	 n0rsasHdqOPqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262DC54E49;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 05:43:12 +0800
Subject: [PATCH v2 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v2-1-8e4fcd757175@outlook.com>
References: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
In-Reply-To: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708724592; l=3287;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rL7ggdfkzgLl7HD8zLKVvIZ6BF4Gsjs6h7u7dfg1NOA=;
 b=fIUhTl/a+yP8sRgMXvR8ghG2OF5PEG5WLuu3h1YrqoaaddGF1ygaFfVBffAGOmHMZR5MtWP0e
 mlF7MO9hxuVDvBvq0kdEKhYisN90w44La89aCns1R1qxhCCCi6hhsYo
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
 .../bindings/usb/hisilicon,hi3798mv200-dwc3.yaml   | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
new file mode 100644
index 000000000000..2a93d659414d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
@@ -0,0 +1,103 @@
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
+  reg: true
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
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@98a0000 {
+            compatible = "hisilicon,hi3798mv200-dwc3";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x98a0000 0x10000>;
+            ranges;
+            clocks = <&clk_bus>,
+                     <&clk_suspend>,
+                     <&clk_ref>,
+                     <&clk_gm>,
+                     <&clk_gs>,
+                     <&clk_utmi>,
+                     <&clk_pipe>;
+            clock-names = "bus", "suspend", "ref", "gm", "gs", "utmi", "pipe";
+            resets = <&crg 0xb0 12>;
+            reset-names = "soft";
+
+            usb@98a0000 {
+                    compatible = "snps,dwc3";
+                    reg = <0x98a0000 0x10000>;
+                    interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+                    clocks = <&clk_bus>,
+                             <&clk_suspend>,
+                             <&clk_ref>;
+                    clock-names = "bus_early", "suspend", "ref";
+                    phys = <&usb2_phy1_port2>, <&combphy0 0>;
+                    phy-names = "usb2-phy", "usb3-phy";
+                    maximum-speed = "super-speed";
+                    dr_mode = "host";
+            };
+    };

-- 
2.43.0


