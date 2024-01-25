Return-Path: <linux-kernel+bounces-39044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803B83CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87991C24532
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CB131737;
	Thu, 25 Jan 2024 17:37:25 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AA1E861;
	Thu, 25 Jan 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204244; cv=none; b=DIyg/MXvirQYRm6hEScnEel/hQsKk1PTiYiOIqqlENEWlAueB6Eel4Ao/0338BAU4LS28UyBeFwNxG61Bg6S10AJA3+PxjK32IU5phPVxP6dcdV8qivjI2kkSCLj8PvU/RTjNPg36nETFrbqFR0c9AXfE3B3e4yTcLLgPp77OwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204244; c=relaxed/simple;
	bh=D5+69pz0DJ/NuhMmCIyJCiC9/OywEyKOFSRpOUxuPIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dG0ZuEecrxHVqXfjb7jzrQcQCtGsdsdXUjxOJRm+fZ+q4o1qxTBS5mI2gGRoJDRb+tvjDejgT3g/pjRmbSDW6QdjgqK7pLzb14TJsxGr7vH2M6d0+b55jsWw/sm2F9P08d4tWUPq7hLT1Yn2q/jd71IAz2WNw7CHE7mVHn4W8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id D053184F04;
	Thu, 25 Jan 2024 18:37:17 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Thu, 25 Jan 2024 18:36:33 +0100
Subject: [PATCH RESEND v3] dt-bindings: pxa-pwm: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240125-pxa-pwm-yaml-v3-1-10b0b0dc02bd@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlspwl9xCQCWwWD4o/hj495TcH5nVZzIuxxZYSv
 wPmNc/11liJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbKcJQAKCRCaEZ6wQi2W
 4WYaD/wJWL9ngZ4a3izemZly15vrf9wOY3vThQuZaOJ6dsPSzkFGkYukM3pfhaq0azk2ZWl+cQu
 Z1+89btjqie6qRr8Vqw1Hv1KlBeq0PIajbgahNRCscLXjyfziK6KrR6aF+WvIhRiLe/4YcBcqkH
 xu4QJVQp/IRpA/xf1Y+qO8Ws2t6AOLQnL1sbSMeQwZJBEoifWdb/SELVpb2BGi/AANRNbjKIcFr
 d9S9nBdJ1jQx/Cgnbg+MCr/S+Ea4uLO1lX0+YgQzh+Jl/kJR4KNvSmNAZWNqE7H/aCZMHmHSHYx
 EMX11jCxLc/VP2vflKxRNuU1L6+9psI1RewUrFPBcbK1zi4IAUDKQxQBUQD2BR5aC8SGo16Rzrh
 9lx7edvo5VMsPXrEJ5r0f1h9Q18g/MfgpAYVV60tH+DHLwvlN7m/zREFs5SzmzCLpqfwGoGO6Zy
 8G9fDy7J0g8fP979QNKOVQXaQjdi9qKfe3P4FDwjxlVB0ZtnnlDziEzmLyyrBZPbI1dHDO8ACxK
 ddzsyqzD05jCtc7JlCwCnbcS2eBoeo6Z+3JmvYKB3eR3TpwtByf88+29fS5JTBP3+siDptxbjof
 5N9lwYnM6MUgykq65eBCKAQekhqHXaCZOC6KbKC2BHl+R/8r05yTY0HHTFIxKn1RjzX4FvWBmIo
 Zwg4rUuYfgV/rTQ==
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



