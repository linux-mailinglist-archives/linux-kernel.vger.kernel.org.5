Return-Path: <linux-kernel+bounces-13719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6957820B9D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425161F219B5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F95C8F51;
	Sun, 31 Dec 2023 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="ucpQZ5xr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD02566D;
	Sun, 31 Dec 2023 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1704034144; bh=Lx0FC98/0gE08HEK7xJ1hiqG6ByZ/mdt3NanhLx06NM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ucpQZ5xri5T6iALYuYUU8m4Nwnmqu53cncpb6vJsZHWM8eYtJjkhPleMdSAsPS82p
	 Ch2uymvipLNmSOSxQNo8xKaKW3GJafRnio+10A25E6GZXM5x3zSBN0o7ZIX7n6TRpX
	 O2YTiokzrTe9m5RR+e+Lt4G1ZvsqDWP5u3ZBtBds=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 31 Dec 2023 15:48:43 +0100
Subject: [PATCH 1/3] dt-bindings: clock: qcom,hfpll: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231231-hfpll-yaml-v1-1-359d44a4e194@z3ntu.xyz>
References: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
In-Reply-To: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Lx0FC98/0gE08HEK7xJ1hiqG6ByZ/mdt3NanhLx06NM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlkX9cHC+mUiso4MvUpQhE+5UjJwHC2SL/VEFEQ
 F0fO2tkhnOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZZF/XAAKCRBy2EO4nU3X
 VinuD/94pNG7EB8oGoI97FDf73TD9OUksxEaI/fWdKQOvGskIQ7H/vGriJtUREOa1YMwzuOAPJ5
 WqwzcrPIMIMzpyUsKp4IoGpm5+NdtdBd+RvVIh6jvpcb/bfFNGvSAGNQoA2L1QPXU0dODQfAOoL
 mUhdxgbOMbbbfYHn06dSYHmM2dUTiY8QXNb9qt+D5qM5V8w8qBFLWS26btqRAYppLSoQANWuRKW
 nQGucFY/PPOOXy3quvi3Q+bs2xGoaywAG60PZUn0ILzGEaIfgvOsb+hmczYUSF8rFKSTsVkRjf2
 QZ59bFz53Ax+KyrlU7I8d5Z/a9ZyH9pjnI/qCC0Y6e9opTqkNF/7UwsKK0ztj2eWW6iLiEuPajA
 1NzO/WQrnFm7UldfmGDV+u2Nh/P+OAt3r2BLIEHsc4oBV2gGP3lTCh5EHcyKUJcGEKnZKT2Lvgk
 vhXYHzsh+6ND/+n1yZnTR7iri+3oFXDLwtgTIkNM3nRXpRjmZSgt9JxUz9/5AQ7T9ItIjv0hmse
 C5vBPSQ5FiF+0/kl1tg4V4EWXz9XIcLRwzppDSuPxZzHtivebSFnGhoaU7PBg9laLefGtYNIWtr
 M6EsMYW83IrtkhpwMlIvVZky0CphwqxJzmCiMJ3tX9V6Coci2d063I2B+1Ok+93la92j3+MFaRc
 T202nzeFtM8upew==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Convert the .txt documentation to .yaml.

Take the liberty to change the compatibles for ipq8064, apq8064, msm8974
and msm8960 to follow the updated naming schema. These compatibles are
not used upstream yet.

Also add a compatible for QCS404 since that SoC upstream already uses
qcom,hfpll compatible but without an SoC-specific string.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/clock/qcom,hfpll.txt       | 63 -----------------
 .../devicetree/bindings/clock/qcom,hfpll.yaml      | 82 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 63 deletions(-)

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
index 000000000000..2cb4098012bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.yaml
@@ -0,0 +1,82 @@
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
+    items:
+      - enum:
+          - qcom,apq8064-hfpll
+          - qcom,ipq8064-hfpll
+          - qcom,msm8960-hfpll
+          - qcom,msm8974-hfpll
+          - qcom,msm8976-hfpll-a53
+          - qcom,msm8976-hfpll-a72
+          - qcom,msm8976-hfpll-cci
+          - qcom,qcs404-hfpll
+      - const: qcom,hfpll
+
+  reg:
+    items:
+      - description: Base address and size of the register region
+      - description: Optional base address and size of the alias register region
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
+  # Example 1 - HFPLL for L2 cache
+  - |
+    clock-controller@f9016000 {
+        compatible = "qcom,ipq8064-hfpll", "qcom,hfpll";
+        reg = <0xf9016000 0x30>;
+        clocks = <&xo_board>;
+        clock-names = "xo";
+        clock-output-names = "hfpll_l2";
+        #clock-cells = <0>;
+    };
+  # Example 2 - HFPLL for CPU0
+  - |
+    clock-controller@f908a000 {
+        compatible = "qcom,ipq8064-hfpll", "qcom,hfpll";
+        reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
+        clocks = <&xo_board>;
+        clock-names = "xo";
+        clock-output-names = "hfpll0";
+        #clock-cells = <0>;
+    };

-- 
2.43.0


