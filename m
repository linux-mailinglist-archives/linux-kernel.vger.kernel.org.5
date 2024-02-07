Return-Path: <linux-kernel+bounces-56170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2184C6EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E9C284DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8684220B34;
	Wed,  7 Feb 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hxDASHby"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6320B12;
	Wed,  7 Feb 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296982; cv=none; b=gOtYhRKEZVN2/2jJXgCBt6QSgLHVtAQJx0B1KyVGA84hqVNGrjZRrkEZgfEsdptRC3dxdpnKU0wUuDaAKXYQQa5SXUeswae0CQOtOiITgxSCA6fgsBjmZSrsUnX0tWvSsgDd02Nys2Y7SrkO/CkExiXlRD63SCdYMzSJzpLR/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296982; c=relaxed/simple;
	bh=beBlKUnQlMjIIycAlMHD9WeMz6PrzSQqI+kN25ySIK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZG+gXVPhq0KgImi8bWOkRlqZ52B1FjLsZvM2r1afuT3HKM9JpEtgDKN2aB3BFND0xJg4jEHj5pa7qBYigC50aQbZfOWPc5E4nn/KM7XvA879FS06p3zsp4rz3axpnkhjY9k4zvCTlgZbcimBFPZmgJk5AsvkdFUYXzEGGedXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hxDASHby; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707296981; x=1738832981;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=beBlKUnQlMjIIycAlMHD9WeMz6PrzSQqI+kN25ySIK8=;
  b=hxDASHbybRG3IN29HIn7CjcJw63QLjd0ABxX66grbNl0fh+hTC/aMAXY
   AhotpiWlj37BElL4H0IFWKAawt+k3wUSf/vqWKYOUK8BIhiXJLY0JMMyK
   I5RqdKVLqbk1xXpsvpqUFPnqMHbaRRkEPDJRVGbW/GYMC5icz2/uR65lX
   HO0PvH+P5NJNllFYSCaF+MNtJTuiweZpWsE6E0/XUzX4piI5fLN5maZr5
   HlB40FjDuiNOg2KbeOsQzuQQvqM685PPP5ztCSi5zz1TJbeUYeqCnHVCp
   52PHGnZTvj7enoWppmVCpxEPKOcsDShvebeUp0Vo/ewePPOAWkDdcVVXu
   g==;
X-CSE-ConnectionGUID: eOi1+RARQkqo8bSeKgzAhg==
X-CSE-MsgGUID: TsHSek2YRS+KrX5nlr7uxw==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="15882619"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 02:09:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 02:09:02 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 02:08:57 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to YAML
Date: Wed, 7 Feb 2024 14:38:53 +0530
Message-ID: <20240207090853.188400-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert the Atmel capacitive touchscreen bindings to YAML format.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../bindings/input/atmel,captouch.txt         | 36 -----------
 .../bindings/input/atmel,captouch.yaml        | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt
 create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.yaml

diff --git a/Documentation/devicetree/bindings/input/atmel,captouch.txt b/Documentation/devicetree/bindings/input/atmel,captouch.txt
deleted file mode 100644
index fe9ee5c53bcc..000000000000
--- a/Documentation/devicetree/bindings/input/atmel,captouch.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Device tree bindings for Atmel capacitive touch device, typically
-an Atmel touch sensor connected to AtmegaXX MCU running firmware
-based on Qtouch library.
-
-The node for this device must be a child of a I2C controller node, as the
-device communicates via I2C.
-
-Required properties:
-
-	compatible:	Must be "atmel,captouch".
-	reg:		The I2C slave address of the device.
-	interrupts:	Property describing the interrupt line the device
-			is connected to. The device only has one interrupt
-			source.
-	linux,keycodes:	Specifies an array of numeric keycode values to
-			be used for reporting button presses. The array can
-			contain up to 8 entries.
-
-Optional properties:
-
-	autorepeat:	Enables the Linux input system's autorepeat
-			feature on the input device.
-
-Example:
-
-	atmel-captouch@51 {
-		compatible = "atmel,captouch";
-		reg = <0x51>;
-		interrupt-parent = <&tlmm>;
-		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
-		linux,keycodes = <BTN_0>, <BTN_1>,
-			<BTN_2>, <BTN_3>,
-			<BTN_4>, <BTN_5>,
-			<BTN_6>, <BTN_7>;
-		autorepeat;
-	};
diff --git a/Documentation/devicetree/bindings/input/atmel,captouch.yaml b/Documentation/devicetree/bindings/input/atmel,captouch.yaml
new file mode 100644
index 000000000000..5d5679896bc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel,captouch.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/atmel,captouch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel capacitive touch device
+
+maintainers:
+  - Dharma balasubiramani <dharma.b@microchip.com>
+
+description:
+  Atmel capacitive touch device, typically an Atmel touch sensor connected to
+  AtmegaXX MCU running firmware based on Qtouch library.
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    const: atmel,captouch
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  linux,keycodes:
+    minItems: 1
+    maxItems: 8
+
+  autorepeat:
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - linux,keycodes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      atmel-captouch@51 {
+        compatible = "atmel,captouch";
+        reg = <0x51>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
+        linux,keycodes = <BTN_0>, <BTN_1>,
+                         <BTN_2>, <BTN_3>,
+                         <BTN_4>, <BTN_5>,
+                         <BTN_6>, <BTN_7>;
+        autorepeat;
+      };
+    };
-- 
2.25.1


