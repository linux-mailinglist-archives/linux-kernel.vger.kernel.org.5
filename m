Return-Path: <linux-kernel+bounces-118057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A888B311
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF18B304208
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86E71738;
	Mon, 25 Mar 2024 21:46:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E066EB52;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403171; cv=none; b=S6HZzqIuMgHaNQK57u6Xf8k6IL0IRRCnM295ez53pN7Eh8i900NVJ5kF3+ZZ3mezB7Rj/ZLvbIqMPq8RApq30DhkCvtnTdqPBJUjjRQ9yV8/TNiTrcUvV5KPPBoogIQ9t/Qr0zagdRmrYzA7yaKI+Fzfeaxyv5TOsF4Kn9QCWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403171; c=relaxed/simple;
	bh=UNtFXPbUwr6nmT6fS/0A1tgHczoulL3R3EQ8VVhZs1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3uZPh89orlBborXrmSEh09Jw0D17xH3LaGIn8+wFdBU4xOKiSzZm9cgM2KAmRALxMLvo1K8ykGsIdMvaNXKXopvwOab5q/UI4VNBcyXmslC7yHTLdcwfrunkGV9tb8rg3XAy8EI8cIBE+OxpnyLsCKIDznGLWX8wQL8Bb9qzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C61C43390;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A476A1060BFF; Mon, 25 Mar 2024 22:46:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 25 Mar 2024 22:45:28 +0100
Subject: [PATCH 2/3] dt-bindings: hsi: nokia-modem: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-hsi-dt-binding-v1-2-88e8e97c3aae@collabora.com>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
In-Reply-To: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5194;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=UNtFXPbUwr6nmT6fS/0A1tgHczoulL3R3EQ8VVhZs1c=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmAfCeHUNBq71MARdrtLBzb4f2IpwiQwfxBVA4B
 QAmrvkuMoeJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgHwngAKCRDY7tfzyDv6
 mubeD/9DdJ7uzTfqv6JHqDaVrIECGcN/3cvKT6h21yoy20F6RiZ4nYMH21p7G4R6PJdepW9nt1F
 ibtKsKdtpPDS4kM8999LlWj/npqAKFVO5ZVJpSYR42hvyDtHyU3Ze3bWZq3hyC26sZWBe5mYY+I
 35fgdZ4vcDsAk9QoNB/gaeaWK4yMcVbO0tvdTIlW7kl96ykuG0tILt9C7xZML6V9Jmej848l7wz
 2z5QXr7oH1kpERnO9KK4rN+uHVvrSa3mqjGex5gTtA8tXrJRZLRXh1nlfb9cSJHR4XGwmbzDVY0
 zfPH4jsOrf9sNV9lv3ZgzmiIpgz5Yd4Xe6nkMfqODRL6WqBkPJqx/KBbDw2I7opai9r0C/ZS0O2
 1/IqhmHUnyWkZ/JDmvmdbBiIJS7qaSLM+E2JWzrtavmDcC8kXnrZDqZTj/vAxXb53UzsYjGfoOo
 ZcBQ5ScFjJMnpNYeqNKBL3ApH2M3B/BbEc9q3JBuV7W8dMc2vbKCJsuW2BVdP65Uw1BXyavO8GJ
 JD+L9Lr+d4nBQCfd+Ptrf0gvih1XlwiGWNElKPIa0uc0aYNudZsybB+l7AFkqzh92r2FjNFw/+P
 kT07cBMDLCw45zC8/NXYUMvZr2ZF8N+zjD62P0cuXR5Bdv+oHPhwIlYHSkwu2Yu9NYw5nhVdR4f
 HU2f8giYDlv0+Yg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML.
No semantic change.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/hsi/nokia-modem.txt        |  59 ------------
 .../devicetree/bindings/hsi/nokia-modem.yaml       | 101 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 59 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/hsi/nokia-modem.yaml b/Documentation/devicetree/bindings/hsi/nokia-modem.yaml
new file mode 100644
index 000000000000..c57cbcc7b722
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/nokia-modem.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hsi/nokia-modem.yaml#
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
+    hsi-client {
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

-- 
2.43.0


