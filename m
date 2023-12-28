Return-Path: <linux-kernel+bounces-12573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013381F702
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE02281D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EDA6FA4;
	Thu, 28 Dec 2023 10:48:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28156AA8;
	Thu, 28 Dec 2023 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BSAmIFg91892683, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BSAmIFg91892683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 18:48:18 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 28 Dec 2023 18:48:18 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 28 Dec 2023 18:48:17 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 28 Dec 2023 18:48:17 +0800
From: Tzuyi Chang <tychang@realtek.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH v5 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Date: Thu, 28 Dec 2023 18:47:59 +0800
Message-ID: <20231228104800.24913-2-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228104800.24913-1-tychang@realtek.com>
References: <20231228104800.24913-1-tychang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add the device tree bindings for the Realtek DHC(Digital Home Center)
RTD SoCs GPIO controllers.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4 to v5 change:
    No change.
v3 to v4 change:
    1. Arrange the compatible list in alphanumerical order.
v2 to v3 change:
    1. Remove generic compatible and use SoC-specific compatible instead.
v1 to v2 change:
    1. Add description for DHC RTD SoCs.
    2. Revise the compatible names.
    3. Add descriptions for reg and interrupts properties.
---
 .../bindings/gpio/realtek,rtd-gpio.yaml       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
new file mode 100644
index 000000000000..dd768db37a98
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/realtek,rtd-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC GPIO controller
+
+maintainers:
+  - Tzuyi Chang <tychang@realtek.com>
+
+description:
+  The GPIO controller is designed for the Realtek DHC (Digital Home Center)
+  RTD series SoC family, which are high-definition media processor SoCs.
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1295-misc-gpio
+      - realtek,rtd1295-iso-gpio
+      - realtek,rtd1315e-iso-gpio
+      - realtek,rtd1319-iso-gpio
+      - realtek,rtd1319d-iso-gpio
+      - realtek,rtd1395-iso-gpio
+      - realtek,rtd1619-iso-gpio
+      - realtek,rtd1619b-iso-gpio
+
+  reg:
+    items:
+      - description: GPIO controller registers
+      - description: GPIO interrupt registers
+
+  interrupts:
+    items:
+      - description: Interrupt number of the assert GPIO interrupt, which is
+                     triggered when there is a rising edge.
+      - description: Interrupt number of the deassert GPIO interrupt, which is
+                     triggered when there is a falling edge.
+
+  gpio-ranges: true
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-ranges
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@100 {
+      compatible = "realtek,rtd1319d-iso-gpio";
+      reg = <0x100 0x100>,
+            <0x0 0xb0>;
+      interrupt-parent = <&iso_irq_mux>;
+      interrupts = <19>, <20>;
+      gpio-ranges = <&pinctrl 0 0 82>;
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
-- 
2.43.0


