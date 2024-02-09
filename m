Return-Path: <linux-kernel+bounces-59051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19784F066
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A550F28793A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F4651B0;
	Fri,  9 Feb 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zhB+FFBQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367AA651B4;
	Fri,  9 Feb 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461294; cv=none; b=j65l05E4E/sJLq8pLjir9iA+ZZCe3tcnY3P4RkvWgOyHZhchDd0ZyC/xGGhzBC7D+8OuhV5llgshst98yp7Q2oLvobrD75W1j/31EXUoBNMrHKDfeFaOuJocEmk+bjWTB0aeZtlU5nl518j0aJ+X0I5MDvqavhsu19CP8CNbglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461294; c=relaxed/simple;
	bh=1ZSf+APxW2qVV/1F4MZZ3Qbx8Oczq7xhc84aIlEpvM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NggpKjkRBlZ479cgfn2IaxZ5SfDDJ+QByLOjWIsgcckKTAtVUwqTy73dyJj/wKgabE5focQFdlyKEvit21VSh4UY2feL0eAoo/dK9EsMyWloT6uBdd8xPvtryXUbF4VvYz6MPMP04Dhem1ynnBgEJ8aYIpp0Rt0xDarzXpFxbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zhB+FFBQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707461292; x=1738997292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ZSf+APxW2qVV/1F4MZZ3Qbx8Oczq7xhc84aIlEpvM0=;
  b=zhB+FFBQpYTXUUMS/mw8lb1PpKHvqh6pMBIWe7XZgu3IRDQNUxDNMZTE
   EcepeWF/bXdEOnsx0XJyaML4hWwK9ACcFIRDeKQtiOiXQJ4b2k9px0IGe
   tgarlk56ekZA5q0IiV5JRWN9eVhyf8T4EborYAC9y48zVheHodJgoHUYC
   oT4DCVOTtMEnBkngn8xfwOaubHLzdN7HyUbuxZhjUogllD+dB+0FVjDLP
   KZooKya8s4T0v0LK8/ZgVniaSqHVPhzIWGuH8Uc1+v6OVwaId43UTIS1J
   aKZZCWE01x9sQ7YdZpSyLkRrfLx0Pgylk5l/wo3L5Jj5SwyZsp7wPx5vR
   A==;
X-CSE-ConnectionGUID: FIYM4WLeRgaNRFDjepZ6hg==
X-CSE-MsgGUID: oRycRM6ITICVbkPn5DqoAQ==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; 
   d="scan'208";a="16524208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2024 23:48:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 23:48:03 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 23:47:57 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hari.prasathge@microchip.com>
Subject: [PATCH v2] dt-bindings: input: atmel,captouch: convert bindings to YAML
Date: Fri, 9 Feb 2024 12:17:55 +0530
Message-ID: <20240209064755.47516-1-dharma.b@microchip.com>
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
Changelog
v1 -> v2
- Drop autorepeat property.
- Use unevaluatedProperties instead of additionalProperties.
- Use node name "touch@51" instead of "atmel-captouch@51".
---
 .../bindings/input/atmel,captouch.txt         | 36 -----------
 .../bindings/input/atmel,captouch.yaml        | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 36 deletions(-)
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
index 000000000000..f7477091d5a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel,captouch.yaml
@@ -0,0 +1,59 @@
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - linux,keycodes
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touch@51 {
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

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


