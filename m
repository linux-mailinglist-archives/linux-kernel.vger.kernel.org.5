Return-Path: <linux-kernel+bounces-121885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681088EEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8809E1C34BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D64515250B;
	Wed, 27 Mar 2024 19:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180B13E043;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566710; cv=none; b=TaXZG6Kb+odw1UZJWlc4rzf/17hXU0NOFLN43zFORZWMszSfRxD+u8gPmx+HE+lkOlnmop3RcbdCJE3+2OC8OP2T/CVcCxEgKIwiQOVuJyGXRGQN9g0YjXGyUMMgtVPxiHPPP0qsOv8UlsoIpV4L3uzn4JB1lFUhXiEm3AzszsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566710; c=relaxed/simple;
	bh=BOiUDY1X5fzeGOqE1IIej5iszJIV6a41YoYson7zgZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyMBy3g/rXFjbbqA9h6qDu4507RlB6fwauAp5teJezSryQ1ghQ/ORIqSJe081InqgetrbGtTj33xU7yafwsb8Of5aBOCEB2QmXBc+yGDdc/Lqa3f+R/eazFGZgUWPiBIkxuB83eGKSsEW4l6WjFIMQQPZ4l9Du+sdmW+2URQhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1395C433F1;
	Wed, 27 Mar 2024 19:11:49 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AA64D1060704; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:32 +0100
Subject: [PATCH v2 1/7] dt-bindings: hsi: hsi-client: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-1-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=BOiUDY1X5fzeGOqE1IIej5iszJIV6a41YoYson7zgZE=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9xveG5FkVLMTBd0NfOMim9KvuljtMYjGmro
 ExRuuz6eEiJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcQAKCRDY7tfzyDv6
 muYSD/9911Opo8umunu4+xNuQwSXbmunqYpyPswxPiHkliaQhMq7fXNUvZJsVVAXLtYGrAvjY9A
 KXX1XJMwiIlrTVnPFStvwDJj0aAjTUYb1YB1zBp4cDCCLpH9se2joREXspawEzCxeXBgbkexaat
 N82IJ1ZCxIz68CH6zNywh+ZiAheb+E7/29iLRAqkAViUndWIvIXaO3Eal+1xrbRQIJGtl8h8kzx
 s9eyOaxfi9eBn/hyz2QlGVsS6jxQpTsyCQ/8kbJff1xwRrmSsV/w57JsAPWVE4C+FpAAUoaYiOT
 Am4vDVamhRlpnOT/lW7DfX3mlYD9E4VoNmzFZrXKIUfhv3iowAT20JaCc4Zquf+bzShn7LXZzRS
 GipF245CyoGD+Ib9feOgabN/8mGsZRjAwd5E/EvEP9tVhYHX2Pd/gVLxe6vLBhFQ4RUZed/IW11
 Im0qkpIR+cW4R9pzGvCGw3/H4Hb+qlpXgzjzjju6P+AGOQNyhOisngOF1KYvq1HBlLvYEten9ps
 1gEvhFH1XYLU753N+xvlu7El4mMuhbt0FsxMWQ1GKC7n74eLjnekse/K6oDvT/sQkuWp8sxxcNy
 sUYezIArQPGDXXUck5jo5znKIepbswhg8YF0ntS8OTHQuIHs+eJXPhmpe+Ms4YZlzmntLecQwVl
 s1Pn4bOifNCbM1Q==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML and rename from
client-devices to hsi-client. Also the example got dropped,
since this is a shared schema. No semantic change in the binding
itself.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/hsi/client-devices.txt     | 44 ------------
 .../devicetree/bindings/hsi/hsi-client.yaml        | 81 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/hsi/client-devices.txt b/Documentation/devicetree/bindings/hsi/client-devices.txt
deleted file mode 100644
index 104c9a3e57a4..000000000000
--- a/Documentation/devicetree/bindings/hsi/client-devices.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Each HSI port is supposed to have one child node, which
-symbols the remote device connected to the HSI port. The
-following properties are standardized for HSI clients:
-
-Required HSI configuration properties:
-
-- hsi-channel-ids:	A list of channel ids
-
-- hsi-rx-mode:		Receiver Bit transmission mode ("stream" or "frame")
-- hsi-tx-mode:		Transmitter Bit transmission mode ("stream" or "frame")
-- hsi-mode:		May be used instead hsi-rx-mode and hsi-tx-mode if
-			the transmission mode is the same for receiver and
-			transmitter
-- hsi-speed-kbps:	Max bit transmission speed in kbit/s
-- hsi-flow:		RX flow type ("synchronized" or "pipeline")
-- hsi-arb-mode:		Arbitration mode for TX frame ("round-robin", "priority")
-
-Optional HSI configuration properties:
-
-- hsi-channel-names:	A list with one name per channel specified in the
-			hsi-channel-ids property
-
-
-Device Tree node example for an HSI client:
-
-hsi-controller {
-	hsi-port {
-		modem: hsi-client {
-			compatible = "nokia,n900-modem";
-
-			hsi-channel-ids = <0>, <1>, <2>, <3>;
-			hsi-channel-names = "mcsaab-control",
-					    "speech-control",
-					    "speech-data",
-					    "mcsaab-data";
-			hsi-speed-kbps = <55000>;
-			hsi-mode = "frame";
-			hsi-flow = "synchronized";
-			hsi-arb-mode = "round-robin";
-
-			/* more client specific properties */
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/hsi/hsi-client.yaml b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
new file mode 100644
index 000000000000..9c8d6887e840
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hsi/hsi-client.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HSI bus peripheral
+
+description:
+  Each HSI port is supposed to have one child node, which
+  symbols the remote device connected to the HSI port.
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  hsi-channel-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  hsi-channel-names:
+    minItems: 1
+    maxItems: 8
+
+  hsi-rx-mode:
+    enum: [stream, frame]
+    description: Receiver Bit transmission mode
+
+  hsi-tx-mode:
+    enum: [stream, frame]
+    description: Transmitter Bit transmission mode
+
+  hsi-mode:
+    enum: [stream, frame]
+    description:
+      May be used instead hsi-rx-mode and hsi-tx-mode if the
+      transmission mode is the same for receiver and transmitter.
+
+  hsi-speed-kbps:
+    description: Max bit transmission speed in kbit/s
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  hsi-flow:
+    enum: [synchronized, pipeline]
+    description: RX flow type
+
+  hsi-arb-mode:
+    enum: [round-robin, priority]
+    description: Arbitration mode for TX frame
+
+additionalProperties: true
+
+required:
+  - compatible
+  - hsi-channel-ids
+  - hsi-speed-kbps
+  - hsi-flow
+  - hsi-arb-mode
+
+oneOf:
+  - required:
+      - hsi-mode
+  - required:
+      - hsi-rx-mode
+      - hsi-tx-mode
+
+allOf:
+  - if:
+      required:
+        - hsi-mode
+    then:
+      properties:
+        hsi-rx-mode: false
+        hsi-tx-mode: false
+  - if:
+      required:
+        - hsi-rx-mode
+    then:
+      properties:
+        hsi-mode: false

-- 
2.43.0


