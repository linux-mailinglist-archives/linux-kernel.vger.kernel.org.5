Return-Path: <linux-kernel+bounces-70579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D055885996E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017461C20C36
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496674E0D;
	Sun, 18 Feb 2024 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Q2ABaH0a"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6173199;
	Sun, 18 Feb 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289871; cv=none; b=XuiCZNmMgTVuxIfnsxs3uJdkrp4NIhWo7K3+fwq8tu37N9odlMjlRdThqAkoTppRP4bjBoCZTToIkTtCMAyl+TN6ep5e1C9Rrworit7w8VCKajB46TuX3Nhkbpdt/phiCSJCxr8UqPifv2LZwG68lm2eFxF9HKXqGAAmbWZxbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289871; c=relaxed/simple;
	bh=8IYVDm1umygJcqMzcKalprDIg1v4QTGh9VXD1McJ2BA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9vsxXbKFMhDEdQLRpPypmExhp+FsUuDQdX0B28AbYpWJyI65vB1t4AUd9Wl2d+v5BTX3WafToxrXfXGQd+ovwHdLmYam1FrR4hWlRQYH6+1dOKnqzXmcZU6Y4Kmjg1geRdpyPEHl0DYfxqiFeioS0oGPCMdjEbzI2jzssQ8hNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Q2ABaH0a; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708289861; bh=8IYVDm1umygJcqMzcKalprDIg1v4QTGh9VXD1McJ2BA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q2ABaH0a4jtn5K2k1pNxdKbHJbrBuKPvS2eMUWzVnR5b6+TwNcVFGGL6tVEfUGCIf
	 szIFbEwFymtwTsKuWJjJx3IauylzCqx2UBp3UlGgVA01rmRqNz6wKctDEy4LbqQymC
	 g8J723JNqcNKuq4WDm3vOBkmxEOmKV0M89WzfDgE=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 18 Feb 2024 21:57:25 +0100
Subject: [PATCH v2 1/3] dt-bindings: clock: qcom,hfpll: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-hfpll-yaml-v2-1-31543e0d6261@z3ntu.xyz>
References: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
In-Reply-To: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4828; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=8IYVDm1umygJcqMzcKalprDIg1v4QTGh9VXD1McJ2BA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0m9Bn0mxbaeNqTFNA3hF+hll8YYyvCs+0YvSP
 yMt1w3qJjaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdJvQQAKCRBy2EO4nU3X
 VidZD/9hsy7vQoEQBko7taavtqTHWcky9zbw0L+nu5IinVjfIRXqBLwI1ft317Ci1RDPzBnpowr
 NSCMWOnRcXY0nTORscGMYQhXwRolcAMkwMtS4r70eRkosfiL+a+YM7D2D8F8A3wq+CkjnwqcSHp
 WyTEuMTJGtaoWUd3xTIPO7q+giJXjXKmPFJtroinKpOju9X8H2+FRqRWp8LXKBb5afdH8AysKzH
 EN46XDAn6wB41M7dF9UzF61cuXUW7N51IwB52D3RBCrkmTDW7eY6z3ZDAiOrrq4Ut/wOeVvUArE
 EuTGPxrUMKRl2pg1Wd6YEKT0k8q82LnIb5gHjWxhQUEmSEuejYI3FJD5Lc/hEnf7yTJD2/g1mTb
 RGhEcrqvrqAILlgknCzw3cZYpLgZt4y9bJM1Xo5ApQTmi7eO8xclRgGzqQqixnTMHB6foUz7Tgq
 J5SvJJGhvARLpzGJbhxysumthK/Prq3Kr09Wo/7A6FLu02zHFh5rOy0+iocOBHgfVSaG291EkzZ
 ynqSi5SJ23lvcQ+aJWiDBHPvWCx8+oIeUhZIMcpjOfValvGQR2VeJp2GwjRksow03VqnTRgATii
 xjHjQQ40lHvY09B7b5XgqSVNEDaxCovzkFZ05XFJAOiLEL417INA/h9nBM4KtbcOuZYeh7WQa8y
 xRzbbqLtI4GPSng==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Convert the .txt documentation to .yaml with some adjustments.

* APQ8064/IPQ8064/MSM8960 compatibles are dropped since their HFPLLs are
  a part of GCC so there is no need for a separate compat entry.
* Change the MSM8974 compatible to follow the updated naming schema.
  Theis compatible is not used upstream yet.
* Add qcs404-hfpll. QCS404 currently uses qcom,hfpll. Mark that as
  deprecated since every SoC appears to need different driver data so
  "qcom,hfpll" makes no sense to keep

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/clock/qcom,hfpll.txt       | 63 --------------------
 .../devicetree/bindings/clock/qcom,hfpll.yaml      | 69 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
deleted file mode 100644
index 5769cbbe76be..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-High-Frequency PLL (HFPLL)
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>:
-		shall contain only one of the following. The generic
-		compatible "qcom,hfpll" should be also included.
-
-                        "qcom,hfpll-ipq8064", "qcom,hfpll"
-                        "qcom,hfpll-apq8064", "qcom,hfpll"
-                        "qcom,hfpll-msm8974", "qcom,hfpll"
-                        "qcom,hfpll-msm8960", "qcom,hfpll"
-                        "qcom,msm8976-hfpll-a53", "qcom,hfpll"
-                        "qcom,msm8976-hfpll-a72", "qcom,hfpll"
-                        "qcom,msm8976-hfpll-cci", "qcom,hfpll"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: address and size of HPLL registers. An optional second
-		    element specifies the address and size of the alias
-		    register region.
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the xo clock.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "xo".
-
-- clock-output-names:
-	Usage: required
-	Value type: <string>
-	Definition: Name of the PLL. Typically hfpllX where X is a CPU number
-		    starting at 0. Otherwise hfpll_Y where Y is more specific
-		    such as "l2".
-
-Example:
-
-1) An HFPLL for the L2 cache.
-
-	clock-controller@f9016000 {
-		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
-		reg = <0xf9016000 0x30>;
-		clocks = <&xo_board>;
-		clock-names = "xo";
-		clock-output-names = "hfpll_l2";
-	};
-
-2) An HFPLL for CPU0. This HFPLL has the alias register region.
-
-	clock-controller@f908a000 {
-		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
-		reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
-		clocks = <&xo_board>;
-		clock-names = "xo";
-		clock-output-names = "hfpll0";
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.yaml b/Documentation/devicetree/bindings/clock/qcom,hfpll.yaml
new file mode 100644
index 000000000000..8cb1c164f760
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,hfpll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm High-Frequency PLL
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  The HFPLL is used as CPU PLL on various Qualcomm SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,msm8974-hfpll
+          - qcom,msm8976-hfpll-a53
+          - qcom,msm8976-hfpll-a72
+          - qcom,msm8976-hfpll-cci
+          - qcom,qcs404-hfpll
+      - const: qcom,hfpll
+        deprecated: true
+
+  reg:
+    items:
+      - description: HFPLL registers
+      - description: Alias register region
+    minItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    items:
+      - description: board XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  clock-output-names:
+    description:
+      Name of the PLL. Typically hfpllX where X is a CPU number starting at 0.
+      Otherwise hfpll_Y where Y is more specific such as "l2".
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+  - clock-output-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@f908a000 {
+        compatible = "qcom,msm8974-hfpll";
+        reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
+        #clock-cells = <0>;
+        clock-output-names = "hfpll0";
+        clocks = <&xo_board>;
+        clock-names = "xo";
+    };

-- 
2.43.2


