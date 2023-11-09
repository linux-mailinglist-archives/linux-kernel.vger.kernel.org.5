Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81167E6524
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjKIIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjKIIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:22:18 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73C2D57;
        Thu,  9 Nov 2023 00:22:13 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A98Knv561426852, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A98Knv561426852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 16:20:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Nov 2023 16:20:49 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Nov 2023 16:20:48 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 9 Nov 2023 16:20:48 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <jh80.chung@samsung.com>, <riteshh@codeaurora.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <conor+dt@kernel.org>, <asutoshd@codeaurora.org>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <briannorris@chromium.org>, <doug@schmorgal.com>,
        <tonyhuang.sunplus@gmail.com>, <abel.vesa@linaro.org>,
        <william.qiu@starfivetech.com>, <jyanchou@realtek.com>
Subject: [PATCH V6][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc driver
Date:   Thu, 9 Nov 2023 16:20:43 +0800
Message-ID: <20231109082043.27147-5-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109082043.27147-1-jyanchou@realtek.com>
References: <20231109082043.27147-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings for Realtek SoCs mmc driver.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v5 -> v6:
- Drop the incorrect, generic compatible and modify it to specific.
- Drop useless properties.
- Modify bindings to make DTS and driver match.

v4 -> v5:
- Remove unused property, e.g.,cqe, resets, clock-freq-min-max.
- Fix indentation.

v3 -> v4:
- Describe the items to make properties and item easy to understand.
- Fix examples' indentation and compiling error.
- Drop useless properties.

v2 -> v3:
- Modify dt-bindings' content and description.
- Fix coding style.
- Update the list of maintainers.

v1 -> v2:
- Add dt-bindings.
---
 .../bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
new file mode 100644
index 000000000000..d7118cf457e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/realtek,rtd-dw-cqe-emmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DesignWare mobile storage host controller
+
+description:
+  Realtek uses the Synopsys DesignWare mobile storage host controller
+  to interface a SoC with storage medium. This file documents the Realtek
+  specific extensions.
+
+maintainers:
+  - Jyan Chou <jyanchou@realtek.com>
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1325-dw-cqe-emmc
+      - realtek,rtd1319-dw-cqe-emmc
+      - realtek,rtd1315e-dw-cqe-emmc
+      - realtek,rtd1619b-dw-cqe-emmc
+
+  reg:
+    items:
+      - description: emmc base address
+      - description: cqhci base address
+
+  reg-names:
+    items:
+      - const: emmc
+      - const: cqhci
+
+  realtek,m2tmx:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to m2tmx syscon register region.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: biu
+      - const: ciu
+      - const: vp0
+      - const: vp1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: reset
+
+  pinctrl-0:
+    description:
+      should contain default/high speed pin ctrl.
+    maxItems: 1
+
+  pinctrl-1:
+    description:
+      should contain sdr50 mode pin ctrl.
+    maxItems: 1
+
+  pinctrl-2:
+    description:
+      should contain ddr50 mode pin ctrl.
+    maxItems: 1
+
+  pinctrl-3:
+    description:
+      should contain hs200 speed pin ctrl.
+    maxItems: 1
+
+  pinctrl-4:
+    description:
+      should contain hs400 speed pin ctrl.
+    maxItems: 1
+
+  pinctrl-5:
+    description:
+      should contain tune0 pin ctrl.
+    maxItems: 1
+
+  pinctrl-6:
+    description:
+      should contain tune1 pin ctrl.
+    maxItems: 1
+
+  pinctrl-7:
+    description:
+      should contain tune2 pin ctrl.
+    maxItems: 1
+
+  pinctrl-8:
+    description:
+      should contain tune3 pin ctrl.
+    maxItems: 1
+
+  pinctrl-9:
+    description:
+      should contain tune4 pin ctrl.
+    maxItems: 1
+
+  pinctrl-names:
+    maxItems: 10
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - vmmc-supply
+  - pinctrl-names
+  - pinctrl-0
+  - pinctrl-1
+  - pinctrl-3
+  - pinctrl-4
+  - pinctrl-5
+  - pinctrl-6
+  - pinctrl-7
+  - pinctrl-8
+  - pinctrl-9
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    emmc: mmc@12000 {
+      compatible = "realtek,rtd1315e-dw-cqe-emmc";
+      reg = <0x00012000 0x00600>,
+            <0x00012180 0x00060>;
+      reg-names = "emmc", "cqhci";
+      realtek,m2tmx = <&m2tmx>;
+      interrupts = <0 42 4>;
+      clocks = <&cc 22>, <&cc 26>, <&cc 121>, <&cc 122>;
+      clock-names = "biu", "ciu", "vp0", "vp1";
+      resets = <&rst 20>;
+      reset-names = "reset";
+      vmmc-supply = <&reg_vcc1v8>;
+      pinctrl-names = "default", "sdr50", "ddr50", "hs200", "hs400",
+                      "tune0","tune1", "tune2","tune3", "tune4";
+      pinctrl-0 = <&emmc_pins_sdr50>;
+      pinctrl-1 = <&emmc_pins_sdr50>;
+      pinctrl-2 = <&emmc_pins_ddr50>;
+      pinctrl-3 = <&emmc_pins_hs200>;
+      pinctrl-4 = <&emmc_pins_hs400>;
+      pinctrl-5 = <&emmc_pins_tune0>;
+      pinctrl-6 = <&emmc_pins_tune1>;
+      pinctrl-7 = <&emmc_pins_tune2>;
+      pinctrl-8 = <&emmc_pins_tune3>;
+      pinctrl-9 = <&emmc_pins_tune4>;
+      supports-cqe;
+    };
-- 
2.42.0

