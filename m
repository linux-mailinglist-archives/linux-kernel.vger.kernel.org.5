Return-Path: <linux-kernel+bounces-10596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C881D6C0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72461C217B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13871D68F;
	Sat, 23 Dec 2023 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="W1MHS6GB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E26179A1;
	Sat, 23 Dec 2023 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fbKwDDXwndQhx6klD6d+ZZNbZaa2yIeQizw0w4XCPfY=; b=W1MHS6GBmasrz2GYyrkZ3QaMbm
	R4+LVb5eRKkk3Ty9VZqcMrH1UZ4iNtndrqDdLPNAvKfZuW+f98V5cTGrMs0RrmR3sjGda3X1veeby
	726vTC75sV8XTqs/d6sv6jTuLzmKD1S2J5nvlM5n0QuW7jQMRVRpxnOVOU+oJp6DoYFvQaZxKmikY
	xoXfLgmDU3SbKiDLgaJLx4qfauZrTkgKmRWg26J1CXQOF7UxhlwZdO+cwJEZxo3R21YscgdAfkfYG
	oj/0fBVnx954sptbQ6DtDgA+zz2mUCmk7ATUKNpCYlup9ukBSoGadJz8FLI1xRz/4OPXUzTQgxAFU
	01SNZ8rg==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEJ-007f7Y-Kf; Sat, 23 Dec 2023 23:12:23 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEI-003Fa7-3D;
	Sat, 23 Dec 2023 23:12:23 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	rydberg@bitmath.org,
	andreas@kemnade.info,
	linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de,
	heiko@sntech.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: touchscreen: convert neonode,zforce to json-schema
Date: Sat, 23 Dec 2023 23:12:10 +0100
Message-Id: <20231223221213.774868-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223221213.774868-1-andreas@kemnade.info>
References: <20231223221213.774868-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Neonode infrared touchscreen controller binding to DT schema.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../input/touchscreen/neonode,zforce.yaml     | 67 +++++++++++++++++++
 .../bindings/input/touchscreen/zforce_ts.txt  | 34 ----------
 2 files changed, 67 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
new file mode 100644
index 0000000000000..c39662815a6c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/neonode,zforce.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Neonode infrared touchscreen controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: neonode,zforce
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  irq-gpios:
+    maxItems: 1
+
+  x-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  y-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - x-size
+  - y-size
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@50 {
+            compatible = "neonode,zforce";
+            reg = <0x50>;
+            interrupts = <2 0>;
+            vdd-supply = <&reg_zforce_vdd>;
+
+            reset-gpios = <&gpio5 9 0>; /* RST */
+            irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
+
+            x-size = <800>;
+            y-size = <600>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
deleted file mode 100644
index e3c27c4fd9c85..0000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Neonode infrared touchscreen controller
-
-Required properties:
-- compatible: must be "neonode,zforce"
-- reg: I2C address of the chip
-- interrupts: interrupt to which the chip is connected
-- reset-gpios: reset gpio the chip is connected to
-- x-size: horizontal resolution of touchscreen
-- y-size: vertical resolution of touchscreen
-
-Optional properties:
-- irq-gpios : interrupt gpio the chip is connected to
-- vdd-supply: Regulator controlling the controller supply
-
-Example:
-
-	i2c@00000000 {
-		/* ... */
-
-		zforce_ts@50 {
-			compatible = "neonode,zforce";
-			reg = <0x50>;
-			interrupts = <2 0>;
-			vdd-supply = <&reg_zforce_vdd>;
-
-			reset-gpios = <&gpio5 9 0>; /* RST */
-			irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
-
-			x-size = <800>;
-			y-size = <600>;
-		};
-
-		/* ... */
-	};
-- 
2.39.2


