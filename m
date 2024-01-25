Return-Path: <linux-kernel+bounces-37913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8883B78D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BF128232E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106BCD524;
	Thu, 25 Jan 2024 03:09:04 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27279F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152143; cv=none; b=GOoB8qHh+Dz1V6JR5My1DkMa64iinLBVf0YGRqDzNjRSh2TSUyeN3UlPyDQEJheizqwRSkJX7oF08JIpw4hjAgwy+c25JqQi/8i/w8te5SBoWcFwrrwcBLTOsGpscvS7BkJCis1KFxp48OdZNySMfIzkiMdMXWbjTrSQ1UGNDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152143; c=relaxed/simple;
	bh=R2C6qolABmQGKD8qhfjxXMFPRKAELbug93bu+jBPX/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsyegnjV/CGNmThij1yWORnV6UxmwfeVViOLql2zVKFR0udCaMxzwRpFJTXC4Srzqos3bsf/Q6JuMMW5xZJhS7qdPDqent6Jl5HYv7ZVqHBqqbU/P8IhFsfRIbpuTzK1soX+dOsvN8tRJRlmBEU9f23b+IMH+P2GuENBGyIoADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38djq061628;
	Thu, 25 Jan 2024 11:08:39 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F670HYz2Rq2lq;
	Thu, 25 Jan 2024 11:01:14 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:38 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 4/6] dt-bindings: pwm: sprd: Convert to YAML
Date: Thu, 25 Jan 2024 10:55:31 +0800
Message-ID: <20240125025533.10315-5-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38djq061628

Convert Spreadtrum PWM controller bindings to DT schema.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 --------
 .../devicetree/bindings/pwm/pwm-sprd.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
deleted file mode 100644
index 87b206fd0618..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum PWM controller
-
-Spreadtrum SoCs PWM controller provides 4 PWM channels.
-
-Required properties:
-- compatible : Should be "sprd,ums512-pwm".
-- reg: Physical base address and length of the controller's registers.
-- clocks: The phandle and specifier referencing the controller's clocks.
-- clock-names: Should contain following entries:
-  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
-  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
-- #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Optional properties:
-- assigned-clocks: Reference to the PWM clock entries.
-- assigned-clock-parents: The phandle of the parent clock of PWM clock.
-
-Example:
-	pwms: pwm@32260000 {
-		compatible = "sprd,ums512-pwm";
-		reg = <0 0x32260000 0 0x10000>;
-		clock-names = "pwm0", "enable0",
-			"pwm1", "enable1",
-			"pwm2", "enable2",
-			"pwm3", "enable3";
-		clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
-		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
-		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
-		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
-		assigned-clocks = <&aon_clk CLK_PWM0>,
-			<&aon_clk CLK_PWM1>,
-			<&aon_clk CLK_PWM2>,
-			<&aon_clk CLK_PWM3>;
-		assigned-clock-parents = <&ext_26m>,
-			<&ext_26m>,
-			<&ext_26m>,
-			<&ext_26m>;
-		#pwm-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
new file mode 100644
index 000000000000..81c5fd688c3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-sprd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum PWM controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  Spreadtrum SoCs PWM controller provides 4 PWM channels.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sprd,ums512-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 8
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: pwm0
+      - const: enable0
+      - const: pwm1
+      - const: enable1
+      - const: pwm2
+      - const: enable2
+      - const: pwm3
+      - const: enable3
+    description: |
+      Should contain following entries:
+      "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
+      "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
+
+  assigned-clocks:
+    minItems: 4
+    maxItems: 4
+
+  assigned-clock-parents:
+    minItems: 4
+    maxItems: 4
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,ums512-clk.h>
+    pwms: pwm@32260000 {
+        compatible = "sprd,ums512-pwm";
+        reg = <0x32260000 0x10000>;
+        clock-names = "pwm0", "enable0",
+                      "pwm1", "enable1",
+                      "pwm2", "enable2",
+                      "pwm3", "enable3";
+        clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+                 <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+                 <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+                 <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+        assigned-clocks = <&aon_clk CLK_PWM0>,
+                          <&aon_clk CLK_PWM1>,
+                          <&aon_clk CLK_PWM2>,
+                          <&aon_clk CLK_PWM3>;
+        assigned-clock-parents = <&ext_26m>,
+                                 <&ext_26m>,
+                                 <&ext_26m>,
+                                 <&ext_26m>;
+        #pwm-cells = <2>;
+    };
+
+...
-- 
2.17.1


