Return-Path: <linux-kernel+bounces-166849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F78BA0D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD641F231C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602E1802C8;
	Thu,  2 May 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="VVybXyDH"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116E15E5CE;
	Thu,  2 May 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676312; cv=none; b=IfV5oMwAvZQ/MqWHLeBjC/dbjbelYc6eXHYgJ3eEZwd+Doj7jiVui1v+4+ywSICFbiCkE+skx2Ju5kT3qpPU6G5KS7b9DrqfOBOF3AwrGP5zxSTWpzSUcFVzB4IG1+5BOKANN7h9UQ25gXhLZ2ghPtqf+tJvDZZdPkviu/AGPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676312; c=relaxed/simple;
	bh=1ddELZ3rv7/x2FMyMnZThIFs8dk075U55LChIsF4djo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZ+2DPaVwSh23d+xKiD1Bd5HU99age6mSBBkV/xr+9dFuFj9omVI+NtLYKlzAVvoySIef5ksSJJvaKTQ/GNqc/c2lTHgXV8oX6Emfuy13oVj8O73bWGTTuVvW36UnIBwD1cA9a44BtWMvVp5hQ0Fw4/w9Tgi1G4546IuSOW/0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=VVybXyDH; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdQ-005SoS-1F;
	Thu, 02 May 2024 20:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eOa7z2BB2RrbUPKNWTzARvpY9sFJebL6N8r4Bi6ZY8c=; b=VVybXyDHiAVomT+iJTmAt7+Ut/
	PNTRndoK1LlVEaqXqdoA+BqJywRqK9RaNEIHcu+ceif6QpDwpXGFBOGrZhIcDlDH7HYhzbG9tJrZV
	niDohH4XAhiqu5SG1yJ+19fG+5H/hoBVEbEFrU2FYwk8qW2qFB6wxV0WqeLJM3BjoXqlxkUqz2q9Z
	dOgILdpIRMHezsG35wGfF0JDKycXAGWWtJjv1Gs5BAigTaoZOSnDpzZJGYujqY5k4VEjY/v7/mmgF
	o9sp1DlhTv+PnE86BYom/0uXmulRqniwffukpz2pHrR8+K0PeN0t+13Ti5gB6ZZFXJiesUZgk+YbO
	K8JLCPCg==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdO-000RVW-0I;
	Thu, 02 May 2024 20:58:23 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdP-003JBv-0J;
	Thu, 02 May 2024 20:58:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	siebren.vroegindeweij@hotmail.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: touchscreen: convert elan,ektf2127 to json-schema
Date: Thu,  2 May 2024 20:58:18 +0200
Message-Id: <20240502185819.788716-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502185819.788716-1-andreas@kemnade.info>
References: <20240502185819.788716-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert EKTF2127 infrared touchscreen controller binding to DT schema
and add ektf2232 compatible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/input/touchscreen/ektf2127.txt   | 25 --------
 .../input/touchscreen/elan,ektf2127.yaml      | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/elan,ektf2127.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
deleted file mode 100644
index c9f2c9f578e34..0000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Elan eKTF2127 I2C touchscreen controller
-
-Required properties:
- - compatible		  : "elan,ektf2127" or "elan,ektf2132"
- - reg			  : I2C slave address of the chip (0x40)
- - interrupts		  : interrupt specification for the ektf2127 interrupt
- - power-gpios		  : GPIO specification for the pin connected to the
-			    ektf2127's wake input. This needs to be driven high
-			    to take ektf2127 out of its low power state
-
-For additional optional properties see: touchscreen.txt
-
-Example:
-
-i2c@00000000 {
-	ektf2127: touchscreen@15 {
-		compatible = "elan,ektf2127";
-		reg = <0x15>;
-		interrupt-parent = <&pio>;
-		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
-		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
-		touchscreen-inverted-x;
-		touchscreen-swapped-x-y;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,ektf2127.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,ektf2127.yaml
new file mode 100644
index 0000000000000..66cda99a2ddd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,ektf2127.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/elan,ektf2127.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Elan eKTF2127 I2C touchscreen controller
+
+maintainers:
+  - Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - elan,ektf2127
+      - elan,ektf2132
+      - elan,ektf2232
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-gpios
+
+unevaluatedProperties: false
+
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@15 {
+            compatible = "elan,ektf2127";
+            reg = <0x15>;
+            interrupt-parent = <&pio>;
+            interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>;
+            power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
+            touchscreen-inverted-x;
+            touchscreen-swapped-x-y;
+        };
+    };
+...
-- 
2.39.2


