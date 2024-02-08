Return-Path: <linux-kernel+bounces-58867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C784EDDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DFE1C23D51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8065579F;
	Thu,  8 Feb 2024 23:24:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C655798;
	Thu,  8 Feb 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434695; cv=none; b=pXBq/SYe5hCEAlKqnKxH0hjseld4/svR0NA3DyjZYQhX2QQP/1q2f0xLSOlKn5l+fEhEnCMkxwrpiO9E9CmEx4OCihcGwZVeuR9/XsIgWp1s89Ollm6txL6kriyeWyYzhuUyd4bRUi0266e/MH4tkf8GDh/wFcE3M1szhUEoXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434695; c=relaxed/simple;
	bh=svvyA2OoPQBEnjShQYCWi04NK7mkxjERO0s6YZk0HkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLKaXQ3Wp785pkKfZ2CFj2siQ9Cfs0HmBsOxGn1/9LKJvoiGgpIkKw1PI/ks+T2AoMm1uD3cuMvYsMWCiJLCCZObRT6IyZjcoNWi27SXbGLPy1+MFX6b8/ETpTlx/oCXVAstzVAZ5TEQzrlvf+M9sW/dGZtnBeEYs2I28Y587Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.05,255,1701097200"; 
   d="scan'208";a="197291926"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Feb 2024 08:24:52 +0900
Received: from mulinux.home (unknown [10.226.92.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E00E4009BDC;
	Fri,  9 Feb 2024 08:24:47 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
Date: Thu,  8 Feb 2024 23:24:08 +0000
Message-Id: <20240208232411.316936-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
References: <20240208232411.316936-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

v5->v6:
 * No change
v4->v5:
 * No change
v3->v4:
 * No change
v2->v3:
 * Added Rb tag from Geert.
v1->v2:
 * Added Rb tag from Krzysztof and the keep the Rb tag as the below
 * changes
   are trivial
 * Updated the description for APB clock
 * Added resets required property
 * Updated the example with resets property

 .../bindings/pwm/renesas,rzv2m-pwm.yaml       | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
new file mode 100644
index 000000000000..ddeed7550923
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzv2m-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2{M, MA} PWM Timer (PWM)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The RZ/V2{M, MA} PWM Timer (PWM) composed of 16 channels. It supports the
+  following functions
+  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
+  * The frequency division ratio for internal counter operation is selectable
+    as PWM_CLK divided by 1, 16, 256, or 2048.
+  * The period as well as the duty cycle is adjustable.
+  * The low-level and high-level order of the PWM signals can be inverted.
+  * The duty cycle of the PWM signal is selectable in the range from 0 to 100%.
+  * The minimum resolution is 20.83 ns.
+  * Three interrupt sources: Rising and falling edges of the PWM signal and
+    clearing of the counter
+  * Counter operation and the bus interface are asynchronous and both can
+    operate independently of the magnitude relationship of the respective
+    clock periods.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwm  # RZ/V2M
+          - renesas,r9a09g055-pwm  # RZ/V2MA
+      - const: renesas,rzv2m-pwm
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB clock
+      - description: PWM clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: pwm
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwm8: pwm@a4010400 {
+        compatible = "renesas,r9a09g011-pwm", "renesas,rzv2m-pwm";
+        reg = <0xa4010400 0x80>;
+        interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A09G011_CPERI_GRPF_PCLK>,
+                 <&cpg CPG_MOD R9A09G011_PWM8_CLK>;
+        clock-names = "apb", "pwm";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A09G011_PWM_GPF_PRESETN>;
+        #pwm-cells = <2>;
+    };
-- 
2.34.1


