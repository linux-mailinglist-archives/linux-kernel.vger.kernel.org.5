Return-Path: <linux-kernel+bounces-18849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708A8263F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96B6B216E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D012E4E;
	Sun,  7 Jan 2024 11:47:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD012E45;
	Sun,  7 Jan 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 387B8829CB;
	Sun,  7 Jan 2024 12:47:26 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sun, 07 Jan 2024 12:46:59 +0100
Subject: [PATCH v3] dt-bindings: pxa-pwm: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240107-pxa-pwm-yaml-v3-1-92ac90911c3f@skole.hr>
X-B4-Tracking: v=1; b=H4sIADKPmmUC/3XMyw6CMBCF4Vcxs3bMtNxd+R7GBdCpNHJLayqE8
 O4WVsTE5TnJ9y/g2Bp2cD0tYNkbZ4Y+jOh8grop+yejUWGDJBmToATHqcTx0+Fcdi3mqqqIlOa
 sTiGQ0bI20567P8JujHsPdt7rXmzvn5AXKDBWrApFVEe5vrnX0PKlsbB1vDza9MfKYIsky7VOt
 FTZ0a7r+gWndv7T4wAAAA==
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=D5+69pz0DJ/NuhMmCIyJCiC9/OywEyKOFSRpOUxuPIM=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlmo83hLsKp79wDlnFj7VAeWO8yn1C80KlCtp2Q
 LjOAXq4o6eJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZqPNwAKCRCaEZ6wQi2W
 4SGcD/4mlTp6zanjhNOCnKZpcZLQch0MmSVz8zJvdvnI7V+oxWg7d6K5jxRPd30jCL971t6BxYF
 Rg+jg3jcJlUS0sSxj79CIZwa4H69NUsvaPkNFXxDt4jDiw1pvSU8EhFGAb9rkY4TtyXrWYcnjaK
 zztr63oTYHBBvzR2TPbvmK5/O+mVdlirbRQwNlRDJtVik2AXySOoXvPY8LWbcAJQEqd+eo/S6EC
 4ESYIl3D60/pCGaEVzNBV1N0EWtCnumHpXn89JgRrn9mRSb4N1Rw3/0EaAD5HQScZ8URHD/E5VA
 UCDSAvfGdbnR7kKE8x0F30IyjAbdW/oCSNT98HLNBRE2mSJVkjIEVp2Cs/6XF+F+vG60G8FUqNU
 AaMxoGaqT6uH9ZPiRep/Y44kJhea7qTmL0NQa9VBztbT5FgKJcmoBdCyJXfMkrWSTD2hbQo6/lq
 g0yjlzgcZAo7mRz6zzVjC9qbkNeIU0N9ViitPExOyiXmDu5X03sxOWwr8/YhM+oz7Str6sOiLtE
 k89ls8GicN6XeppYsun+QONFltiiQVD6nDBJWhV0WU9ZAo2Gcucs9WTh5E28TMN55Ps2BvwkJWf
 BEvrAWnWNdTNoAaEonOieQ4tMYIWbMJTXD5US1zWVAjMObWTW0Rksnnhj8ypATJAsAcqVlgyrQG
 r4a/rjectKGuh4w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Convert the PXA PWM binding file from TXT to YAML.

The original binding does not mention any clocks, but the PWM controller
will not probe without a clock.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v3:
- Change id to marvell,pxa-pwm.yaml (forgot to do in v2)
- Link to v2: https://lore.kernel.org/r/20240106-pxa-pwm-yaml-v2-1-9578ff5f2d7f@skole.hr

Changes in v2:
- Rename to marvell,pxa-pwm.yaml
- Note addition of clock property
- Update trailers
- Link to v1: https://lore.kernel.org/r/20240105-pxa-pwm-yaml-v1-1-4ded9d00c38f@skole.hr
---
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 51 ++++++++++++++++++++++
 Documentation/devicetree/bindings/pwm/pxa-pwm.txt  | 30 -------------
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
new file mode 100644
index 000000000000..ba6325575ea0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/marvell,pxa-pwm.yaml#
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



