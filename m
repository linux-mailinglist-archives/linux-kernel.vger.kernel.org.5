Return-Path: <linux-kernel+bounces-118058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B803588B312
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B6630421D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA37174D;
	Mon, 25 Mar 2024 21:46:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0E6F525;
	Mon, 25 Mar 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403171; cv=none; b=uNglCdtRn1KQ2C5OQBvZt+6DzBHzK8RfdRy+SArhQLyznjfBSa9FKDlopX9nQxIrOk7uOpU9jzOCmquP4yV3sWlzQkc8tYwOeYnO/ojtzTm6PIePQepZvsWgqS5UsEEheMCTQpo7IvJfnNnhOrz5ycDlRLuBsHf6wU3QoB5ndtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403171; c=relaxed/simple;
	bh=1JhEs5m91UCp5brlxZNh69rmkjVEA1dKonpWmVOpYkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afbMUDNm0mne8nxnwRuwE521vDgBeaQ+XQ+mlj+nLg2gcY1aBigf7FT+WxAgCUYrK9pN98JS/J5TBSPUQZhyDRu+3iORAqX829tUFuY9Lq9VPjqyGwfxr98tzg8iva1qPFI08tGC8CcphzbZ1Y3inmiGh1CftACbYalFkJAL7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471EC43399;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A2559106062A; Mon, 25 Mar 2024 22:46:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 25 Mar 2024 22:45:27 +0100
Subject: [PATCH 1/3] dt-bindings: hsi: hsi-client: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
In-Reply-To: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4253;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=1JhEs5m91UCp5brlxZNh69rmkjVEA1dKonpWmVOpYkM=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmAfCdgUr7yexfEM4lIn7G2dStu42/SxWqJBCpP
 S28233Jw8KJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgHwnQAKCRDY7tfzyDv6
 mvAiEACZVO7gn7ratc1ojnyF68NtKfwOeicARMgsfaLkmvl40iXDuqoAW3lRbjTfZvMuYYdI70B
 T5hYgQbJFvc2c9FyW2r1WhrzTTjdiSTG4j35wmF7rclGriphS4l4W5XzsNYIR+0OLY7b3dS5HZi
 WUWv3+zVBGnvGHc0pBx/J6aMf6v0+hC/CjMK2UcxrRe9PNkctKJ+Bk/JUiwi6cuRPPwapSVUilP
 x/mFfkuIAlTNu6T2iw+BgaXQRC9+wMn7W5DUb5KfJw+zhYfq+VkEzaMQ4PsblfCVC1CF7BpgPWO
 wAfOlQ1nxXKyVnhylRAag/s3LDfzhzYENm8P0amLUxapHQaVGOzeDUKRN9C7j6rp50UbvCJ6ok9
 8xNG4pgmoI33M3dnIqL9cS9Nwhz1zReN1tf94tnl54y24AL7Ya2OkJrYimcJvcx1bZR/eJuYvrt
 x0jdLZyeX6ZnMQ8SMYGmdPkUc0CMZkzk60JGQ2d9S13jDB2udrDc56OOcDBbQH2g1dJJk7qR+nf
 8Uuoj+UdiwDCdYSDqZfRD1BpQCTfV51SUpLvL9OPmdPJA6vYARbyfNSP/6cIyjTMdKPLd+JsNCS
 s4S4E+jC8Q789EW8wYn0s7DWyPHi76ShfcqvEKNFnXFUEQcaqe/H0/o0t2ZF5rXZgE5vkjQ3Gz8
 feLHRhTP/SogWUA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML and rename from
client-devices to hsi-client. No semantic change.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/hsi/client-devices.txt     | 44 ------------
 .../devicetree/bindings/hsi/hsi-client.yaml        | 84 ++++++++++++++++++++++
 2 files changed, 84 insertions(+), 44 deletions(-)

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
index 000000000000..df6e1fdd2702
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
@@ -0,0 +1,84 @@
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
+  $nodename:
+    const: hsi-client
+
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
+anyOf:
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


