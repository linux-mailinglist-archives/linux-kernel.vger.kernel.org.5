Return-Path: <linux-kernel+bounces-71104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE385A0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7021F21142
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220E28DC0;
	Mon, 19 Feb 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="erXZxW4j"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC38286AC;
	Mon, 19 Feb 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337556; cv=none; b=fVJ56Vo4oaLFrMKexEsb+0KD83lBTFmtL50cHnjSp3BsKtLP6punG7JVgYvbN7sSWjT5VMVCgoSNJGjtzmwlBaHAiViEyqrna7pNmcY1IVy0SArc0kU5a0cXJzGsxd2k5rVzG/Iw9JQ/zdrLizMvrTWiKFRx9ALaQCp5t0Zdh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337556; c=relaxed/simple;
	bh=aV/ggkcDv9hp3EetTzkokGR0XIwelaf7CP2afkUlvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR/znRL/MBTkbxrR0c2srTs0dQbosZZLtEd/pmdEyfBT35KKRekJZkA8wBKmSCiFxAHTU8x3M4IfVAEZVFtUzY2JRi3a4a3U8Ev52E6siru+r8j2QQd7wHBX59bij1/vahrUF8WEUZgBpvfatrQaLcMkFyDp1gechOjx7PAshXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=erXZxW4j; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D90840008;
	Mon, 19 Feb 2024 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708337546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDmnqReFpMYRHKn4zXOLlP/VQyZkOX4IKcdcgZtFJfo=;
	b=erXZxW4jpfuOAUDJ1B61ZTNvy4Auw1PleMf2ZJ3kM3xHTXY3ruFQXgLyP3opPp0UYpCN3A
	kVkT5C2+OpZAie82BzGt7MMPzmVq3MogocA1AycSytMDo8fFYykWtl2mzm4L5TM9BW4HSO
	E8BRYZsrkmH7JcIwvGQ7JsvXCMsxc0uEd+zRMrjCC2hzTLAQ0IOSBBm1jYAPqzUdhXqIeX
	7JG8AqV8XyvAvZ0FEMQzG+/NPDvTSXZKlb62u1IXzFRwTVpLNEtu12+GreashD0iop/nz/
	sQd43DRBUmv35kRMOJUudpIhNOc3VvrqdM1K9BraTyX3WHZje4DjA4/ScWAo/Q==
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 2/3] dt-bindings: input: Add TouchNetix axiom touchscreen
Date: Mon, 19 Feb 2024 11:12:19 +0100
Message-ID: <20240219101221.129750-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219101221.129750-1-kamel.bouhara@bootlin.com>
References: <20240219101221.129750-1-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Add the TouchNetix axiom I2C touchscreen device tree bindings
documentation.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../input/touchscreen/touchnetix,ax54a.yaml   | 62 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
new file mode 100644
index 000000000000..66229a4d6f15
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/touchnetix,ax54a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TouchNetix Axiom series touchscreen controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    const: touchnetix,ax54a
+
+  reg:
+    const: 0x66
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdda-supply:
+    description: Analog power supply regulator on VDDA pin
+
+  vddi-supply:
+    description: I/O power supply regulator on VDDI pin
+
+required:
+  - compatible
+  - reg
+  - vdda-supply
+  - vddi-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@66 {
+        compatible = "touchnetix,ax54a";
+        reg = <0x66>;
+        interrupt-parent = <&gpio2>;
+        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+        vdda-supply = <&vdda_reg>;
+        vddi-supply = <&vddi_reg>;
+        poll-interval = <20>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c4828ab15f1a..4b3ed2f22b89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22257,6 +22257,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/toshiba-wmi.c

+TOUCHNETIX AXIOM I2C TOUCHSCREEN DRIVER
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
+
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
--
2.25.1


