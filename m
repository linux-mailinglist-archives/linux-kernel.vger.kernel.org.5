Return-Path: <linux-kernel+bounces-121889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E74E88EEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22B71F33AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B69152529;
	Wed, 27 Mar 2024 19:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFA152187;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566710; cv=none; b=cf3jpDlWZOYPHULPhr3ux6ARWFsBdauTJv1HuMaJwsbV6az1I0yXYge8qCuduxeXOR6SaXYBVhyHqhmWFmNG/yusGc19D963zl5sUEa126eBdigkCF6yrWSyMGaYRrLJH+EreNwUCTLpIcnNETY9EHLH8XfaN2oo5HZjI9ae4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566710; c=relaxed/simple;
	bh=tIFCfgf+3D7TdIVE0ZdE2tSE7iH4jRinyIvff5gv8yI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbM+Ltj5QyYlzdFuBj9d70OZCxdlAGpzEhOnm7leiCQsZHTZkeujWbOdOyDDjfmkp+A7+/CPwP+safe8j+X8FS8rfQVo88SW0PF2z7Df7A9Z6zhUiwVshIsDU5l/1Xe+/nsbcuc4FKA6ZGNBrNiOOEAq5Z8zCE6UnsuEk8EeOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E9AC43601;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AB94A1060992; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:33 +0100
Subject: [PATCH v2 2/7] dt-bindings: hsi: nokia-modem: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-2-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5307;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=tIFCfgf+3D7TdIVE0ZdE2tSE7iH4jRinyIvff5gv8yI=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9xESFLsmU9PrlmwWaBhkW2IWl5iC4Fx4xWa
 BAk/X+EN3uJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcQAKCRDY7tfzyDv6
 ms/0D/9PM/pXIrq5uR+J+47qLOAobSWIVB4frfxUJB+0Ej5YCe0AyDv7zCUHM8znJZCB04xrwwW
 /AF/+6gcgOqBWSY+jgHecpyw3teLyR6r10dCEP48oOwDHJVzS47VXdI9jx1P98PIHpZyHegv9dX
 iTiCDd3tR3GOkWd6WktrW4U5IW8pia6MFT22PlNncCsz7bv1YoUnujod9dnSECOlGmZ1FBTcOlP
 Xj63u2HfqKyi/c9jzwda/mIrfRSylybCYs3N766lfs23PAbGUXphMwEXU+6X0EWK8PSiO3oY1QI
 w6yjeXEuvI+Ot1sSyCeNboZpjSGppEwKYEnGRxKg0mTlA1jbnmIRn/oHmA7/FVEaCkQCE0OcnCp
 UTotJ6U/5MB3mCExcQByBaSg2gLIEGcpixYOAXjUTw2P7fBgTe9PLp4Cbru54L49qEsFfWlBMew
 TuLhLAzQ5MXxB0ELSCNlrYVZUP1NWZ0sSS7WPn6qcvwOb7pnAaF54x7CU6MFM/ASGneNHn1jKjx
 VZmi1Yl/0cD53FZGnQrRd8hbjnj0vfLT64UNEEXBozAd5ge2JdWifWKuO9jw6dNGgaOlmchbo82
 dYGM93WS1QqxzjLCtwKQ62bTf1fr2FfWOdzE54b7uU3gnvSnk+IbTO2QqP2rmqhGaIPBu9xQl2v
 dXWiSb9gYKwf8Zw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML.
No semantic change.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/hsi/nokia,modem.yaml       | 106 +++++++++++++++++++++
 .../devicetree/bindings/hsi/nokia-modem.txt        |  59 ------------
 2 files changed, 106 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/hsi/nokia,modem.yaml b/Documentation/devicetree/bindings/hsi/nokia,modem.yaml
new file mode 100644
index 000000000000..f6d5e2c14329
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/nokia,modem.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hsi/nokia,modem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nokia modem
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - nokia,n900-modem
+      - nokia,n950-modem
+      - nokia,n9-modem
+
+  hsi-channel-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
+  hsi-channel-names:
+    items:
+      - const: mcsaab-control
+      - const: speech-control
+      - const: speech-data
+      - const: mcsaab-data
+
+  interrupts:
+    items:
+      - description: modem reset indication
+
+  gpios:
+    minItems: 3
+    maxItems: 5
+
+  gpio-names:
+    items:
+      - const: cmt_apeslpx
+      - const: cmt_rst_rq
+      - const: cmt_en
+      - const: cmt_rst
+      - const: cmt_bsi
+    minItems: 3
+
+required:
+  - gpios
+  - gpio-names
+  - interrupts
+
+allOf:
+  - $ref: hsi-client.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nokia,n950-modem
+              - nokia,n9-modem
+    then:
+      properties:
+        gpios:
+          maxItems: 3
+        gpio-names:
+          maxItems: 3
+    else:
+      properties:
+        gpios:
+          minItems: 5
+        gpio-names:
+          minItems: 5
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    modem {
+        compatible = "nokia,n900-modem";
+
+        hsi-channel-ids = <0>, <1>, <2>, <3>;
+        hsi-channel-names = "mcsaab-control",
+                            "speech-control",
+                            "speech-data",
+                            "mcsaab-data";
+        hsi-speed-kbps = <55000>;
+        hsi-mode = "frame";
+        hsi-flow = "synchronized";
+        hsi-arb-mode = "round-robin";
+
+        interrupts-extended = <&gpio3 8 IRQ_TYPE_EDGE_FALLING>;
+
+        gpios = <&gpio3  6 GPIO_ACTIVE_HIGH>,
+                <&gpio3  9 GPIO_ACTIVE_HIGH>,
+                <&gpio3 10 GPIO_ACTIVE_HIGH>,
+                <&gpio3 11 GPIO_ACTIVE_HIGH>,
+                <&gpio5 29 GPIO_ACTIVE_HIGH>;
+        gpio-names = "cmt_apeslpx",
+                     "cmt_rst_rq",
+                     "cmt_en",
+                     "cmt_rst",
+                     "cmt_bsi";
+    };
diff --git a/Documentation/devicetree/bindings/hsi/nokia-modem.txt b/Documentation/devicetree/bindings/hsi/nokia-modem.txt
deleted file mode 100644
index 53de1d9d0b95..000000000000
--- a/Documentation/devicetree/bindings/hsi/nokia-modem.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-Nokia modem client bindings
-
-The Nokia modem HSI client follows the common HSI client binding
-and inherits all required properties. The following additional
-properties are needed by the Nokia modem HSI client:
-
-Required properties:
-- compatible:		Should be one of
-      "nokia,n900-modem"
-      "nokia,n950-modem"
-      "nokia,n9-modem"
-- hsi-channel-names:	Should contain the following strings
-      "mcsaab-control"
-      "speech-control"
-      "speech-data"
-      "mcsaab-data"
-- gpios:		Should provide a GPIO handler for each GPIO listed in
-                        gpio-names
-- gpio-names:		Should contain the following strings
-      "cmt_apeslpx" (for n900, n950, n9)
-      "cmt_rst_rq"  (for n900, n950, n9)
-      "cmt_en"      (for n900, n950, n9)
-      "cmt_rst"     (for n900)
-      "cmt_bsi"     (for n900)
-- interrupts:		Should be IRQ handle for modem's reset indication
-
-Example:
-
-&ssi_port {
-	modem: hsi-client {
-		compatible = "nokia,n900-modem";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&modem_pins>;
-
-		hsi-channel-ids = <0>, <1>, <2>, <3>;
-		hsi-channel-names = "mcsaab-control",
-				    "speech-control",
-				    "speech-data",
-				    "mcsaab-data";
-		hsi-speed-kbps = <55000>;
-		hsi-mode = "frame";
-		hsi-flow = "synchronized";
-		hsi-arb-mode = "round-robin";
-
-		interrupts-extended = <&gpio3 8 IRQ_TYPE_EDGE_FALLING>; /* 72 */
-
-		gpios = <&gpio3  6 GPIO_ACTIVE_HIGH>, /* 70 */
-			<&gpio3  9 GPIO_ACTIVE_HIGH>, /* 73 */
-			<&gpio3 10 GPIO_ACTIVE_HIGH>, /* 74 */
-			<&gpio3 11 GPIO_ACTIVE_HIGH>, /* 75 */
-			<&gpio5 29 GPIO_ACTIVE_HIGH>; /* 157 */
-		gpio-names = "cmt_apeslpx",
-			     "cmt_rst_rq",
-			     "cmt_en",
-			     "cmt_rst",
-			     "cmt_bsi";
-	};
-};

-- 
2.43.0


