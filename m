Return-Path: <linux-kernel+bounces-106137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F887E9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8827C1F21FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86B3A1BA;
	Mon, 18 Mar 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="tNHXVlmL"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F238FA0;
	Mon, 18 Mar 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766938; cv=none; b=qJPDcEtJiBMXrcg39ZUJaXiu91R9fmeZfu6iRc/8/t+JrkzGTaXjc3sGcgOm0O8wQ5bcQxEQ8CV3N+VGl17aebBOo7OXroeFsFg3zJ7abErI+FyUPW4g1njMn/PQi6QwpXbehnaHKeXGTOaBHyZW+HLuYT3n+9ryNI0E1W2feXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766938; c=relaxed/simple;
	bh=Xeh3Xh85wAPq6QKrTjMMaqZtUieeXwfUZQqVI4BpdR0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RZNgZyUCEQqnwxfSnIcSGjtD7QWVEKJFY36rlt8fx3r1zEn8sm2CvlEHEeO3MM7o36dyFniJ88rTyc50HynWPjWybY3k6WDed7h5SVkvM7OHARrB3ledmYUpjGrB92WmOQc1Du9K8JtzOuPA2s5/0HKR/xjeIcYYMvo4LNSfqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=tNHXVlmL; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9sfZOx2DCTn54LYO3IjAwhuh25pOQkcCf5EGt7OZU20=; b=tNHXVlmLU/vIQ1W5czs79Ux/VF
	yq/UDFl5wKMH3L1pBMJoZI7L7iC17AJl9/8JLiJioS7x73i7HthN0LrXTBLVbBTL3zdal70GTMK2m
	y8nsbnZNGeR2uskiIWOOFzpevXgvI3qWfUxaaefL4l5b6My8T4Bo8kFEF+9cvq8tQOiLpvT2lm6Tw
	uJMCjLNf4Xyz7zRMj6Sv+dp1AZYBfN+xhpicn5bqekLHwzHb+vJFWxRneR9I0xaUtlJDU4hG3XNjc
	LSxWwEGN4pjRY8XctouvXQwemtHSBblfw57A+a2/vBCmjFlsa0C+zyaEOy0cElk33hxJijQNELYZ2
	WQp/ZgjQ==;
Received: from p200301077701e8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7701:e800:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rmCIV-000LTn-JD; Mon, 18 Mar 2024 13:40:59 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rmCIU-00HTpq-0T;
	Mon, 18 Mar 2024 13:40:58 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	andreas@kemnade.info,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	sre@kernel.org
Subject: [PATCH] dt-bindings: mfd: twl: Convert trivial subdevices to json-schema
Date: Mon, 18 Mar 2024 13:40:50 +0100
Message-Id: <20240318124051.4166253-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert subdevices with just an interrupt and compatbile to
json-schema and wire up already converted subdevices.
RTC is available in all variants, so allow it unconditionally
GPADC binding for TWL603X uses two different compatibles, so
specify just the compatible and not include it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Well, my name is in that yaml file, so I should take care of my sheep,
in case a step-by-step approach is acceptable this is at least a
checkpoint for me that I understand multi file binding mechanics
properly.

 .../bindings/input/twl4030-pwrbutton.txt      | 21 ------
 .../devicetree/bindings/mfd/ti,twl.yaml       | 68 +++++++++++++++++++
 .../devicetree/bindings/rtc/twl-rtc.txt       | 11 ---
 .../bindings/watchdog/twl4030-wdt.txt         | 10 ---
 4 files changed, 68 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt

diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
deleted file mode 100644
index 6c201a2ba8acf..0000000000000
--- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Texas Instruments TWL family (twl4030) pwrbutton module
-
-This module is part of the TWL4030. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/ti,twl.yaml.
-
-This module provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be one of the following
-   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
-- interrupts: should be one of the following
-   - <8>: For controllers compatible with twl4030
-
-Example:
-
-&twl {
-	twl_pwrbutton: pwrbutton {
-		compatible = "ti,twl4030-pwrbutton";
-		interrupts = <8>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index 52ed228fb1e7e..03d725d5294db 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -15,6 +15,65 @@ description: |
   USB transceiver or Audio amplifier.
   These chips are connected to an i2c bus.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,twl4030
+    then:
+      properties:
+        madc:
+          type: object
+          $ref: ../iio/adc/ti,twl4030-madc.yaml
+
+          unevaluatedProperties: false
+        bci:
+          type: object
+          $ref: ../power/supply/twl4030-charger.yaml
+
+          unevaluatedProperties: false
+        pwrbutton:
+          type: object
+          properties:
+            compatible:
+              const: ti,twl4030-pwrbutton
+            interrupts:
+              const: 8
+
+          additionalProperties: false
+        watchdog:
+          type: object
+          properties:
+            compatible:
+              const: ti,twl4030-wdt
+
+          additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,twl6030
+    then:
+      properties:
+        gpadc:
+          type: object
+          properties:
+            compatible:
+              const: ti,twl6030-gpadc
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,twl6032
+    then:
+      properties:
+        gpadc:
+          type: object
+          properties:
+            compatible:
+              const: ti,twl6032-gpadc
+
 properties:
   compatible:
     description:
@@ -42,6 +101,15 @@ properties:
   "#clock-cells":
     const: 1
 
+  rtc:
+    type: object
+    properties:
+      compatible:
+        const: ti,twl4030-rtc
+      interrupts:
+        maxItems: 1
+    additionalProperties: false
+
 additionalProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
deleted file mode 100644
index 8f9a94f2f8969..0000000000000
--- a/Documentation/devicetree/bindings/rtc/twl-rtc.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* Texas Instruments TWL4030/6030 RTC
-
-Required properties:
-- compatible : Should be "ti,twl4030-rtc"
-- interrupts : Should be the interrupt number.
-
-Example:
-	rtc {
-		compatible = "ti,twl4030-rtc";
-		interrupts = <11>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt b/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
deleted file mode 100644
index 80a37193c0b86..0000000000000
--- a/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Device tree bindings for twl4030-wdt driver (TWL4030 watchdog)
-
-Required properties:
-	compatible = "ti,twl4030-wdt";
-
-Example:
-
-watchdog {
-	compatible = "ti,twl4030-wdt";
-};
-- 
2.39.2


