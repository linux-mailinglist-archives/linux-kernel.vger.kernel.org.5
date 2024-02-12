Return-Path: <linux-kernel+bounces-62151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDA851C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C313E1C21A18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C594C618;
	Mon, 12 Feb 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="xnSouA+T"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F945BEC;
	Mon, 12 Feb 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760459; cv=none; b=LTtP8QOCRxDj+ewGJWUTvzVGVaaa4yF34RCXJJjNfR3YqjGFBMFFJQ2pbbhlzBqaa2CcyptusNQpd8IEDaq6J0O28vdLsS3zOef0bV/i/QMTebjOVn3IHrLz2OIevzWhYlxkgnoc0EK+howItnTxp12d3cuM/LGZqU9CfPkhSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760459; c=relaxed/simple;
	bh=oF9i+Z8BdopTqVTnBumsz4Nu/Iy7VmW+wAYqm2kOVt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAczeDaRutAVU3R1hRHcj11/a6l5LLLaSv2eorYjKi15D1gtL65s4u2hIF7EytkHEjZo9nILTIv6wH/82SSKJzsqGjLh8uFm6MZwA3YFX5QdlmaRW3iVfOdnD+Y7g7wgbLOIcrGeYPgvEEzmOKpwuSWauzecgoBnU/N652DZ1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=xnSouA+T; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707760454; bh=oF9i+Z8BdopTqVTnBumsz4Nu/Iy7VmW+wAYqm2kOVt4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=xnSouA+T8OAdh2amQX5sJlpaKHMJ6LK8nbkiDRhmQOwVNcjGBl6Po95bAsnLkyn04
	 tfvwds7hXsmDCuHnNEZFqgqmz3Pk4S02ZYCn0u1EUkSp/pVFjbXN7iQ8MWS6x/IQFa
	 ixxH0fx3VrR4yuhzef3IN1J7F9gaBFoHI3lsVfJs=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v2 2/4] dt-bindings: iio: magnetometer: Add Voltafield AF8133J
Date: Mon, 12 Feb 2024 18:53:54 +0100
Message-ID: <20240212175410.3101973-3-megi@xff.cz>
In-Reply-To: <20240212175410.3101973-1-megi@xff.cz>
References: <20240212175410.3101973-1-megi@xff.cz>
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
 .../iio/magnetometer/voltafield,af8133j.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
new file mode 100644
index 000000000000..b6ab01a6914a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
@@ -0,0 +1,60 @@
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
+    const: voltafield,af8133j
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      A signal for active low reset input of the sensor. (optional; if not
+      used, software reset over I2C will be used instead)
+
+  avdd-supply:
+    description:
+      A regulator that provides AVDD power (Working power, usually 3.3V) to
+      the sensor.
+
+  dvdd-supply:
+    description:
+      A regulator that provides DVDD power (Digital IO power, 1.8V - AVDD)
+      to the sensor.
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
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


