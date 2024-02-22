Return-Path: <linux-kernel+bounces-75756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C185EE83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24231C21A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADA14284;
	Thu, 22 Feb 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="dhMGQMOA"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB8111AC;
	Thu, 22 Feb 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564435; cv=none; b=ckoDNbDvClBshKxqQ0rC6ySpd5H2ytpJiBF6KqG75eM81wpBO0NQEE2KewfmHWgsXrPasKxCYyHPiy38oJP0MKm2UT4mSraWHy8aEpLbUPsJmVkTXLRAb69Gzuu8Mswm0vE5kaIdEy0ayUvfAI6pX+3O+j8Ql25v8uZnf/XFxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564435; c=relaxed/simple;
	bh=MzFWAiynKIMfBbcmFyJFSn3s5kPBd8miZrCSWWhxnWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmuQFeOuikvbfYXgUWRfPUOc1pdP/tfiDYug/L7bjyX9c9h5iQ1mlNlT+Bokj6GvAgZ9X0zJ2i0F96fG26JVLKdjPrvKpobTWgF7gvjDrhFLHTufeAP/Esczi5kaJZe345k2R4I7ZUb5c1MwUpIpqp4uUDr4+cye/FeTR9WNH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=dhMGQMOA; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708564424; bh=MzFWAiynKIMfBbcmFyJFSn3s5kPBd8miZrCSWWhxnWw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=dhMGQMOA2FK4mh9vjgz7pkGx2PXSrLmgK+AC0RpdVMO828BaO9KvHWSw1n8BiBUmW
	 JaNsidtFsjm6d+LHuPVGWd2piXWtdIs8h7Uhmt22m4tl+VnNWQpat+zk6KgtkEi14G
	 KZLU1f7zbVbLLbbE852xq3eOnzczOExM/O302bDM=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
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
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/4] dt-bindings: iio: magnetometer: Add Voltafield AF8133J
Date: Thu, 22 Feb 2024 02:13:36 +0100
Message-ID: <20240222011341.3232645-3-megi@xff.cz>
In-Reply-To: <20240222011341.3232645-1-megi@xff.cz>
References: <20240222011341.3232645-1-megi@xff.cz>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


