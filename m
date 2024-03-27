Return-Path: <linux-kernel+bounces-122133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1388F24D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5641C299DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3911552E7;
	Wed, 27 Mar 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTZTy47o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2F53360;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580238; cv=none; b=UULnWco/o/QNpCHboyDtCPPTq1TPWs9d6/5qThrIxQVpmuXKAd42zbbATUVXSG5vtVcmTn5SRLYBhvEXn6Jk+Zk1M+GcfmoFxY6rKmVOFK1nGbwf9xanPbGT0YtHdoS8P+phxEIz5uppvoRsNhBJhVbgqlZ/JlnwWpscAaMYypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580238; c=relaxed/simple;
	bh=SdLkIrwBwlDqhRSTn7XKcsPbMseHwVKadJ866sBVejM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3fnN6xJ6bKAXl/88bgW71f1jcXz57XF15iRuWIp6AGnnnTEhpqqz8hmpOhNW1NgiydR9BSGwoCFswUPb1HlsJYw5EbOKY7eoBp49KecEIVZIn4DEfO2PaHRnHRiEBoGf+zoKIL6OC5jqcyndFLLevvvLZ3hNWN5raOkOvvURaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTZTy47o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CC8CC433F1;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711580238;
	bh=SdLkIrwBwlDqhRSTn7XKcsPbMseHwVKadJ866sBVejM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qTZTy47oDrrR3VHQ84dkFvpSYzyBmLA+qyCLH7fImZPphCkGl70Ufuo7lZBXgOQVv
	 PCUy9LofmzKg3EUmL0dk6Xlilp7Cv3jEsO4/6zYrOHttkofQhXVDKxMjgP3hsna4yx
	 M1FHtaTzWvOMqvFdEfABC1zLXO2uHp1kXOF6FI50mGIreSDVlOU6VcFUDG41qvQnfC
	 e2XI5u1RVLjgoPDjVo3Kh4HH32TKiZueC17UWFkZPPi+0A3AWWtbQhiZSTuxcuEjND
	 tpR6I6nSmVK0gqebD5tU+PhL9lDeKK2Ixl9uYKA1WhccpW6AdNITvSGK16o2z6+1ph
	 NU+oOk3LUEYvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B3C54E67;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Wed, 27 Mar 2024 23:51:33 +0100
Subject: [PATCH 1/3] dt-bindings: leds: Add Silergy SY7802 flash LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu>
References: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
In-Reply-To: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
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
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711580236; l=2712;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=U/eSmdRufn8GTM9VsJqXDQS2YTIMzPsUBcDHhRD6uJM=;
 b=UNB93cFuyeZHiGIWzC7//lSuWkKfdA8GDdBaqtCedU5tMFPZk2eo6TkdknsT+zn+DKnHgqL1R
 pJmqdrIh8t0COrl16OW9ntviq+O5D1mSvo31tUQV4v9xeFv+lvTJlaE
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
 .../devicetree/bindings/leds/silergy,sy7802.yaml   | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
new file mode 100644
index 000000000000..d32efac8baa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
@@ -0,0 +1,96 @@
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
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
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
+    flash-led-controller@53 {
+        compatible = "silergy,sy7802";
+        reg = <0x53>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+        led@0 {
+            reg = <0>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            led-sources = <0>, <1>;
+        };
+    };

-- 
2.44.0



