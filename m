Return-Path: <linux-kernel+bounces-18712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DFE826183
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E482830E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C06F513;
	Sat,  6 Jan 2024 20:46:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93841F9C2;
	Sat,  6 Jan 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4FF1A85794;
	Sat,  6 Jan 2024 21:46:11 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 06 Jan 2024 21:45:46 +0100
Subject: [PATCH v2] dt-bindings: pxa-pwm: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240106-pxa-pwm-yaml-v2-1-9578ff5f2d7f@skole.hr>
X-B4-Tracking: v=1; b=H4sIAPm7mWUC/3XMyw6CMBCF4Vchs3bMFFGRle9hWEA7tRO5NK1BC
 OHdrexd/ic53wqRg3CEKlsh8CRRxiFFfshAu2Z4MopJDTnlBSk6o58b9J8el6bvsDRtS2QsX/U
 F0sUHtjLv3KNO7SS+x7Ds+qR+6x9oUqiwMGxuhkifSnuPr7HjowtQb9v2BatjkD2nAAAA
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3332;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=KY4CNJMb5bu/b1IMZAKf3rxFy79ecGdfzqi7aByQaSA=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlmbv9kPQbYS/Zry38ioyNv2pV5E/TQ70/QmEWf
 uM9LUHqdKGJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZm7/QAKCRCaEZ6wQi2W
 4cDTD/9/orFpJLwg3vHE2JbDVLSYwM2/kqB0p4fN8meLwVyhuiha4eihm/6LX4TRdi5DliqR5H1
 IK0GiE3G+BI8WYfNyKp4rMchIUSCjQWgGFUkkdcXek6YjM9gzii7IL+UcPYpzWW/g99izT6PVub
 7He16tvmCDRY0YgwXUWOUBPtGV9GTH52qglMoI0pP9i/3bsqUyTEUydoMqyyEdecSDGjVkB7Emi
 EoBhywmo6Zz7/q3FtBYS2Sybk82kDUfid/nkHHN7oj8f2IOr4oX+0Rmf0umX5kivo7C0N0az8pY
 BgWOlUnjfs/5qzb+I46k+tLDn4HjYdVXQa59FMgcD9BizbR7FAJLzWkRxHjQ8aIb/g1UBWqQp0y
 pkbsreqVbzRQJBhgmFXSMGDU0sT8F7HWERFDJk+mIl/a9kFmV+OzuQf3aX2Byj6cM+cStYjXFDc
 oAj1ZnJx8Twl5liQHnlwBH3E6dRBW0menAUmmkqKGFGUQAZtxwaBCs5DrCt6uNppZycBHvFit4V
 KYUznjQZTaIHkx0Sb5ICOLtpxfaCHASGClZzwAxI7NDz0+qWg67AZ/IryrLgXj65yNSMUdIxgdx
 zDdJIHdxmoAV2wOYNazfIV3bbOJWbTDp16Vc+T2jo0Xmi0UYs6CndJTC87Bu6SRhmhy4arMQh4v
 PG71gxJzScjAXVQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Convert the PXA PWM binding file from TXT to YAML.

The original binding does not mention any clocks, but the PWM controller
will not probe without a clock.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
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
index 000000000000..fb20e4e1daa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
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



