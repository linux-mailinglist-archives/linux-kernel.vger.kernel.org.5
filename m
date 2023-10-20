Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F307D0737
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376311AbjJTDvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjJTDvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:51:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A165181;
        Thu, 19 Oct 2023 20:51:28 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K3nXGi93723204, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K3nXGi93723204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 11:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 20 Oct 2023 11:49:33 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 11:49:33 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 20 Oct 2023 11:49:33 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <jh80.chung@samsung.com>,
        <ulf.hansson@linaro.org>
CC:     <riteshh@codeaurora.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <asutoshd@codeaurora.org>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <briannorris@chromium.org>, <doug@schmorgal.com>,
        <tonyhuang.sunplus@gmail.com>, <abel.vesa@linaro.org>,
        <william.qiu@starfivetech.com>, <jyanchou@realtek.com>
Subject: [PATCH V3][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc driver
Date:   Fri, 20 Oct 2023 11:49:21 +0800
Message-ID: <20231020034921.1179-5-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020034921.1179-1-jyanchou@realtek.com>
References: <20231020034921.1179-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings for Realtek SoCs mmc driver.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v2 -> v3:
- Modify dt-bindings' content and description.
- Fix coding style.
- Update the list of maintainers.

v0 -> v2:
- Add dt-bindings.
---
---
 .../bindings/mmc/realtek-dw-mshc.yaml         | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
new file mode 100644
index 000000000000..b1e37fb37be9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/realtek-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek designware mobile storage host controller
+
+description:
+  Realtek uses the Synopsys designware mobile storage host controller
+  to interface a SoC with storage medium. This file documents the Realtek
+  specific extensions.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+maintainers:
+  - Jyan Chou <jyanchou@realtek.com>
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd-dw-cqe-emmc
+  reg:
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  cqe:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+
+  clock-freq-min-max:
+    description:
+      Clk frequency should be in the interval.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: reset
+
+  speed-step:
+    maxItems: 1
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
+  - pinctrl-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    emmc: mmc@12000 {
+        compatible = "realtek,rtd-dw-cqe-emmc";
+        reg = <0x00012000 0x00600>,
+              <0x00012180 0x00060>;
+        reg-names = "emmc", "cqhci";
+        interrupts = <0 42 4>;
+        clocks = <&cc 22>, <&cc 26>, <&cc 121>, <&cc 122>;
+        clock-names = "biu", "ciu", "vp0", "vp1";
+        clock-freq-min-max = <300000 400000000>;
+        clock-frequency = <400000>;
+        vmmc-supply = <&reg_vcc1v8>;
+        resets = <&rst 20>;
+        reset-names = "reset";
+        speed-step = <3>;
+        cqe = <1>;
+        pinctrl-names = "default", "sdr50", "ddr50", "hs200", "hs400",
+                        "tune0", "tune1", "tune2", "tune3", "tune4";
+        pinctrl-0 = <&emmc_pins_sdr50>;
+        pinctrl-1 = <&emmc_pins_sdr50>;
+        pinctrl-2 = <&emmc_pins_ddr50>;
+        pinctrl-3 = <&emmc_pins_hs200>;
+        pinctrl-4 = <&emmc_pins_hs400>;
+        pinctrl-5 = <&emmc_pins_tune0>;
+        pinctrl-6 = <&emmc_pins_tune1>;
+        pinctrl-7 = <&emmc_pins_tune2>;
+        pinctrl-8 = <&emmc_pins_tune3>;
+        pinctrl-9 = <&emmc_pins_tune4>;
+        };
-- 
2.42.0

