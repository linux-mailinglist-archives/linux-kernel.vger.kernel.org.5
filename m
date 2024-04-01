Return-Path: <linux-kernel+bounces-127085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E8894692
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC85B23C50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77257878;
	Mon,  1 Apr 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXh0Qu64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97092A1BF;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006655; cv=none; b=CbJG/u1/SHbeQEINKTGq2DNPHe0Ssn/XQVurYiIsOf9wOXpym4tIoY7ANZo2UbZ9zTIoEHEne0bSyNHoiLkhpxOBgIpfP0O05P1/n3FHxRcdgfFiUBWPAzc4QKpeGBr1xma6yUvP8E7FZssbC2OS2229A/1mm76L2RN2uHVYS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006655; c=relaxed/simple;
	bh=7PNroOoNcSozKXZaTo+xY8DjgQ9Ph0at2E5Zu60uSDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCqR++wd/TSInBNHlTmdY0eA8HAbPrSdcLFa/IV8xJAmxmY1ZFxpaAQqyXNzhm89xwB0qG149iaT9kilDSbdGf6tjxKpfgZPSxyecY1pKnlmYBQRkgyHCvMTrhLt7VXBtQilItlkZYuzKgZ5pG03hU9RPYVuRGepLl/1X3FUo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXh0Qu64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDAC4C43394;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006654;
	bh=7PNroOoNcSozKXZaTo+xY8DjgQ9Ph0at2E5Zu60uSDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sXh0Qu64VJBB9AhBiy/8p0Bj58UOqnQd57igpzSvXCNezwZcR+q9IccEyxOXOto1y
	 DkR4KCMMvI20HXLmTw7RzkDhlQiSmQfgP9rU2ts017uEXEhlilsgOahKsfB/negII2
	 n5eYPr1iuJizz/MmPx9OhVY0F7TwCCR9K/3dRVIpDnYp7aoI4HZePhyREreCBPaU0o
	 sT0ziUYFmbrUXttGNszG13z0SM6gxYIJBDor4wTp0pbzQI0LCSX3R/BaMczeUhU4ln
	 CejBjSMYN0XxGjtZyHPL6Vdxg/vR8IiCEyKqxE1gikxjlxHjIxpzysGkFETtVx0VDf
	 RHT6h159KsJVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5000CD1293;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Mon, 01 Apr 2024 23:23:55 +0200
Subject: [PATCH v2 1/3] dt-bindings: leds: Add Silergy SY7802 flash LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240401-sy7802-v2-1-1138190a7448@apitzsch.eu>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
In-Reply-To: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712006653; l=2814;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=oNM0ya5oNykHINhTxOzzwyy/jcGSPZfyaMMYcdcGZWM=;
 b=/zydaTt+SHiXn+Dz5Npbr9hbi+pY9nvC43lHAbEZ0Se1tEy3tq9tO3IEqw7t0L0NlSLMPaDBH
 VR8GP458pcGA0DNm8DZSKO7NAs+3Ga5Z2m+bn0SUCYbI/+j1EZPYtEz
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

From: André Apitzsch <git@apitzsch.eu>

Document Silergy SY7802 flash LED driver devicetree bindings.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../devicetree/bindings/leds/silergy,sy7802.yaml   | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
new file mode 100644
index 000000000000..46b8e5452b62
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/silergy,sy7802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silergy SY7802 1800mA Boost Charge Pump LED Driver
+
+maintainers:
+  - André Apitzsch <git@apitzsch.eu>
+
+description: |
+  The SY7802 is a current-regulated charge pump which can regulate two current
+  levels for Flash and Torch modes.
+
+  The SY7802 is a high-current synchronous boost converter with 2-channel
+  high side current sources. Each channel is able to deliver 900mA current.
+
+properties:
+  compatible:
+    enum:
+      - silergy,sy7802
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+    description: A connection to the 'EN' pin.
+
+  flash-gpios:
+    maxItems: 1
+    description: A connection to the 'FLEN' pin.
+
+  vin-supply:
+    description: Regulator providing power to the 'VIN' pin.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Index of the LED.
+        minimum: 0
+        maximum: 1
+
+      led-sources:
+        minItems: 1
+        maxItems: 2
+        items:
+          minimum: 0
+          maximum: 1
+
+    required:
+      - reg
+      - led-sources
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash-led-controller@53 {
+            compatible = "silergy,sy7802";
+            reg = <0x53>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+            led@0 {
+                reg = <0>;
+                function = LED_FUNCTION_FLASH;
+                color = <LED_COLOR_ID_WHITE>;
+                led-sources = <0>, <1>;
+            };
+        };
+    };

-- 
2.44.0



