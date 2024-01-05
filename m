Return-Path: <linux-kernel+bounces-18404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAD8825C9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195191C2345F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09F360AC;
	Fri,  5 Jan 2024 22:51:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2136094;
	Fri,  5 Jan 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id C4FA7852C5;
	Fri,  5 Jan 2024 23:51:05 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Fri, 05 Jan 2024 23:50:32 +0100
Subject: [PATCH] dt-bindings: pxa-pwm: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240105-pxa-pwm-yaml-v1-1-4ded9d00c38f@skole.hr>
X-B4-Tracking: v=1; b=H4sIALeHmGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNT3YKKRN2C8lzdysTcHF2LlKQkA4OUtFTzZDMloJaCotS0zAqwcdG
 xtbUA6x6XOF4AAAA=
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=exJFcZMfLakzLW30XCN4B+b4XSe/8POoE4BDRUIR0eM=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlmIfChkSh+CgUu/dIC5qbtD5pY+rHr6ydJk/RV
 aTDzQY4m42JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZiHwgAKCRCaEZ6wQi2W
 4dxwD/9TfUze7+TN88Hg8yHNR7YIBQZvmqCYKjo7YA1FpAf1qrSuGQvzfM/If8UjDPXKOheXriX
 7WC5xCwb8dFe5yaefC+rIDQH1WsjZpZcik9V9P72hGMGR2HYNhjNDF0hMTbzesQ1IlNNjU4afoF
 VgMKpD0agGn3GQaKe6O6pgQLwcaLiBr+m+ukqlq1tn1Ps3kCZpdJH3OLqUsxJ3hfPwS1zpKQ59b
 zB3OJaPpp9kC2vBjq1aW4UfZiiw6zde1ilk5+paRG/vihqdY1OXfJ0fsf7gy1fFc9xrfRwmPt8H
 zjtANB/r/DF2Zdj4Bskn5vULn+neGfxkddNokV3zXx/c7Mkudt0A14da4/SXX2WAj8PdFwp0Dp+
 KXV5Ybt6cKX56BFdy3cg/9BgMEBuAno62+5Iyh7emBF5HTfYfbDEpmHS6d1xIpNKFBs/zIu/TzQ
 cOMt73isETCb53+iGADWX0gCXcJoHC6yRHp75GhLJHNVWNyTyNDDbsb1HPlcBvEFAFHM5vcSVK2
 4FJFEIB2DywIIk1pxxybqxgmSuQgfMr0vs0z7DiWYKRM6VPkbiabuW88WZmChd7J0zktlhFNlZ0
 7L4l+OPUyzDAfOdn8ua616idpPWYsBmUxdY6J4y+7W3y2s1N4ticl+KwHy0lzilB5Ldbi0Q8i9N
 vG/ZHe56sarjNDw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Convert the PXA PWM binding file from TXT to YAML.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/pwm/pwm-pxa.yaml | 51 ++++++++++++++++++++++
 Documentation/devicetree/bindings/pwm/pxa-pwm.txt  | 30 -------------
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-pxa.yaml b/Documentation/devicetree/bindings/pwm/pwm-pxa.yaml
new file mode 100644
index 000000000000..fb20e4e1daa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-pxa.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-pxa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA PWM
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,pxa250-pwm
+      - marvell,pxa270-pwm
+      - marvell,pxa168-pwm
+      - marvell,pxa910-pwm
+
+  reg:
+    # Length should be 0x10
+    maxItems: 1
+
+  "#pwm-cells":
+    # Used for specifying the period length in nanoseconds
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/pxa-clock.h>
+
+    pwm0: pwm@40b00000 {
+      compatible = "marvell,pxa250-pwm";
+      reg = <0x40b00000 0x10>;
+      #pwm-cells = <1>;
+      clocks = <&clks CLK_PWM0>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
deleted file mode 100644
index 5ae9f1e3c338..000000000000
--- a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Marvell PWM controller
-
-Required properties:
-- compatible: should be one or more of:
-  - "marvell,pxa250-pwm"
-  - "marvell,pxa270-pwm"
-  - "marvell,pxa168-pwm"
-  - "marvell,pxa910-pwm"
-- reg: Physical base address and length of the registers used by the PWM channel
-  Note that one device instance must be created for each PWM that is used, so the
-  length covers only the register window for one PWM output, not that of the
-  entire PWM controller.  Currently length is 0x10 for all supported devices.
-- #pwm-cells: Should be 1.  This cell is used to specify the period in
-  nanoseconds.
-
-Example PWM device node:
-
-pwm0: pwm@40b00000 {
-	compatible = "marvell,pxa250-pwm";
-	reg = <0x40b00000 0x10>;
-	#pwm-cells = <1>;
-};
-
-Example PWM client node:
-
-backlight {
-	compatible = "pwm-backlight";
-	pwms = <&pwm0 5000000>;
-	...
-}

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240105-pxa-pwm-yaml-8dbb00dfe7c6

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



