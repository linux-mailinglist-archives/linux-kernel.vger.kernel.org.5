Return-Path: <linux-kernel+bounces-60954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D712F850B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1682D1C21542
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED15F49C;
	Sun, 11 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="b199vNbE"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8C5DF10;
	Sun, 11 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684744; cv=none; b=EJQV9kjX1km0yQwRZUmfujIhJAU+s+KVcVOvc9KIFmav9n7PkjmAi4oXuUKWppHsWs29dOqfWLJ4NiLK7So488St0JzDXovuOQXV7NHSqNMoDwOWHtKtmqzkx7a8Lmpq0sCVe39Z4RgEp/p3L/fXR9m3thI9vCYXWMqUglTN78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684744; c=relaxed/simple;
	bh=RY4ulIBr47Q0nyCLXIK7t8729sReukS+pt9cj0YsfDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVMR6SkoPK4x4Evch324+mcuj+aQFqVJuu9V1K6+N6xBznMjfsNEDnponlLi7gvLeK2x064EsNTLOonDHUxHTdS8mct4Jlydg5VXACeDlE61DjrrlrLncRyZW+ZJM3grb7R4Zt3XLIDcgGyRJft0rrcRTwCq7nLqX7JkkmEsaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=b199vNbE; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707684739; bh=RY4ulIBr47Q0nyCLXIK7t8729sReukS+pt9cj0YsfDA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=b199vNbE2m8c/4zJ/MMKmOL1ppqreK+7IhuqOTR0Vksbiyb+19t1OiJPkXbxPZuE7
	 Va+chEoMp/DkV5Sr/yGgIVYaVD9LShDAfuWhnoVmNj77mKPAefF0BKMCzbhfdl0Q6l
	 CHva/mETNjdgcTkrfxNROhm01U1VITSFW7/zP5MY=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for Voltafield AF8133J
Date: Sun, 11 Feb 2024 21:51:58 +0100
Message-ID: <20240211205211.2890931-3-megi@xff.cz>
In-Reply-To: <20240211205211.2890931-1-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <icenowy@aosc.io>

Voltafield AF8133J is a simple magnetometer sensor produced by Voltafield
Technology Corp, with dual power supplies (one for core and one for I/O)
and active-low reset pin.

The sensor has configurable range 1.2 - 2.2 mT and a software controlled
standby mode.

Add a device tree binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Ondřej Jirman <megi@xff.cz>
---
 .../iio/magnetometer/voltafield,af8133j.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
new file mode 100644
index 000000000000..ab56c0f798ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Voltafield AF8133J magnetometer sensor
+
+maintainers:
+  - Ondřej Jirman <megi@xff.cz>
+
+properties:
+  compatible:
+    - voltafield,af8133j
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: |
+      an pin needed for AF8133J to set the reset state. This should be usually
+      active low.
+
+  avdd-supply:
+    description: |
+      an optional regulator that needs to be on to provide AVDD power (Working
+      power, usually 3.3V) to the sensor.
+
+  dvdd-supply:
+    description: |
+      an optional regulator that needs to be on to provide DVDD power (Digital
+      IO power, 1.8V~AVDD) to the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@1c {
+            compatible = "voltafield,af8133j";
+            reg = <0x1c>;
+            avdd-supply = <&reg_dldo1>;
+            dvdd-supply = <&reg_dldo1>;
+            reset-gpios = <&pio 1 1 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.43.0


