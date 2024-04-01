Return-Path: <linux-kernel+bounces-126513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047378938E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FFB1C20CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12453D52B;
	Mon,  1 Apr 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="E0FhWtPN"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE79BE4C;
	Mon,  1 Apr 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959530; cv=none; b=fP9UN009ne54EiJy9KGvVziH9rpqYwQZJGTlef72qeldCwg4yrJ8z+vmnXds6COcYzHQdERhMcqHW5bPj1qD9Yekn2uky+cN9dAZEWVcSG0I9SMQwgrh7z7QD+mUuq78KF1klrQuPkHqfnmwrIT1s7PhUTo95Ubq94vW9y/EblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959530; c=relaxed/simple;
	bh=RalONbHJmjL+5dC6j9f7WkhK0rfe+l8VIoPe6ry5m+o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tO0ojZ10TPuPoxHdBGlnd7fWcwpy3IK6at8AZQPENjWH4sILqqsqPfS4sBZKp722KR77T0vrZjTTmmMawHsZ1+a/1XcyjfQNUTJofKoKkjJJqnW48HyOM+0INWvSuf95hhC2Hdi/yBIpsQoMUehVglSMFLF+iKcjKVL+Iwrg4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=E0FhWtPN; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrCsI-003hxX-2o;
	Mon, 01 Apr 2024 10:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=matAENjD3Sff8egEAIeTHD8iydE2FAZ42pT+Mb7DKIo=; b=E0FhWtPNWyOeG0OVnjy/ib27pB
	wMRNgiJKSDOas2ukg+bkXWMQb2/Py/jAJAZq843x1lyO4uQFOIpTWlYVafJLi/FaOuswqBMTZ7ano
	vvUW2BavHNbXMuHjMoEb95xXfw8bZuP/bCLfQdY759RL0LFZOnpj/4SFAO9bQjkz4FeVd76UtEhBo
	pgkuonYWVcvYvbisNUViwUmQrZ0HkinGKZRAs/YIO3kLtfcu6CtBS0rnmakWHuuaZmzStoC2f5GKv
	66QlnYuGq/nf7Bhe/gBE4DeEwEjgskjDouxoakCMNFaILTiR+sjC6Ecm3WwN8TQWaXlB4xsNCzniG
	PsHox9NQ==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrCsB-000Fdf-2I;
	Mon, 01 Apr 2024 10:18:32 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrCsB-001uqP-1y;
	Mon, 01 Apr 2024 10:18:31 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
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
	sre@kernel.org
Subject: [PATCH v3] dt-bindings: mfd: twl: Convert trivial subdevices to json-schema
Date: Mon,  1 Apr 2024 10:18:31 +0200
Message-Id: <20240401081831.456828-1-andreas@kemnade.info>
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
RTC is available in all variants, so allow it unconditionally.
GPADC binding for TWL603X uses two different compatibles, so
specify just the compatible and do not include it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v3:
- added Ack
  (apparantly many recipients did not receive the V2 patch,
   so there is a need for a resend)

Changes in v2:
- style cleanup
- absolute paths
- unevalutedProperties instead of additionalProperties
  due to not accepting things in if: clauses without it

 .../bindings/input/twl4030-pwrbutton.txt      | 21 ------
 .../devicetree/bindings/mfd/ti,twl.yaml       | 72 ++++++++++++++++++-
 .../devicetree/bindings/rtc/twl-rtc.txt       | 11 ---
 .../bindings/watchdog/twl4030-wdt.txt         | 10 ---
 4 files changed, 71 insertions(+), 43 deletions(-)
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
index 52ed228fb1e7e..c2357fecb56cc 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -15,6 +15,67 @@ description: |
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
+          $ref: /schemas/iio/adc/ti,twl4030-madc.yaml
+          unevaluatedProperties: false
+
+        bci:
+          type: object
+          $ref: /schemas/power/supply/twl4030-charger.yaml
+          unevaluatedProperties: false
+
+        pwrbutton:
+          type: object
+          additionalProperties: false
+          properties:
+            compatible:
+              const: ti,twl4030-pwrbutton
+            interrupts:
+              items:
+                - items:
+                    const: 8
+
+        watchdog:
+          type: object
+          additionalProperties: false
+          properties:
+            compatible:
+              const: ti,twl4030-wdt
+
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
@@ -42,7 +103,16 @@ properties:
   "#clock-cells":
     const: 1
 
-additionalProperties: false
+  rtc:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        const: ti,twl4030-rtc
+      interrupts:
+        maxItems: 1
+
+unevaluatedProperties: false
 
 required:
   - compatible
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


