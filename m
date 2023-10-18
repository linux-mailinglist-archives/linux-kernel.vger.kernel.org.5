Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9C7CD3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjJRFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJRFxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:53:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29DBA;
        Tue, 17 Oct 2023 22:53:47 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39I5rau071104752, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39I5rau071104752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:53:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 18 Oct 2023 13:53:36 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 13:53:35 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 18 Oct 2023 13:53:35 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <jh80.chung@samsung.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benchuanggli@gmail.com>, <jyanchou@realtek.com>
Subject: [PATCH V2][4/4] mmc: Add dt-bindings for realtek mmc driver
Date:   Wed, 18 Oct 2023 13:53:24 +0800
Message-ID: <20231018055326.18256-5-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018055326.18256-1-jyanchou@realtek.com>
References: <20231018055326.18256-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings for Realtek SoCs mmc driver.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v0 -> v2:
- Add dt-binding.
---
---
 .../bindings/mmc/realtek-dw-mshc.yaml         | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
new file mode 100644
index 000000000000..f398a595c5c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
@@ -0,0 +1,119 @@
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
+# Everything else is described in the common file
+properties:
+  compatible:
+    enum:
+      - realtek,rtd-dw-cqe-emmc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+    description:
+      Handle to "biu" and "ciu" clocks for the bus interface unit clock and
+      the card interface unit clock.
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: biu
+      - const: ciu
+      - const: vp0
+      - const: vp1
+    description:
+      "vp0" and "vp1" are used to control the clock phases.
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: reset
+
+  speed-step:
+    maxItems: 1
+    description:
+	"speed-step" represents the bus speed mode of emmc. "3" means HS400,
+	"2" means HS200, "0" means HS.
+
+  pinctrl-names:
+    maxItems: 10
+    items:
+      - const: default
+      - const: sdr50
+      - const: ddr50
+      - const: hs200
+      - const: hs400
+      - const: tune0
+      - const: tune1
+      - const: tune2
+      - const: tune3
+      - const: tune4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - pinctrl-names
+  - pinctrl
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    emmc: emmc@12000 {
+        compatible = "realtek,rtd-dw-cqe-emmc";
+        reg = <0x00012000 0x00600>,
+		<0x00012180 0x00060>;
+        reg-names = "emmc","cqhci";
+        interrupts = <0 42 4>;
+        clocks = <&cc RTD1319D_CRT_CLK_EN_EMMC>,
+		<&cc RTD1319D_CRT_CLK_EN_EMMC_IP>,
+                <&cc RTD1319D_CRT_PLL_EMMC_VP0>,
+                <&cc RTD1319D_CRT_PLL_EMMC_VP1>;
+        clock-names = "biu", "ciu", "vp0", "vp1";
+        clock-freq-min-max = <300000 400000000>;
+        clock-frequency = <400000>;
+        vmmc-supply = <&reg_vcc1v8>;
+        resets = <&cc RTD1319D_CRT_RSTN_EMMC>;
+        reset-names = "reset";
+        speed-step = <3>;
+        cqe = <1>;
+        pinctrl-names = "default", "sdr50", "ddr50", "hs200", "hs400", "tune0", "tune1", "tune2", "tune3", "tune4";
+	pinctrl-0 = <&emmc_pins_sdr50>;
+        pinctrl-1 = <&emmc_pins_sdr50>;
+        pinctrl-2 = <&emmc_pins_ddr50>;
+        pinctrl-3 = <&emmc_pins_hs200>;
+        pinctrl-4 = <&emmc_pins_hs400>;
+        pinctrl-5 = <&emmc_pins_tune0>;
+	pinctrl-6 = <&emmc_pins_tune1>;
+	pinctrl-7 = <&emmc_pins_tune2>;
+	pinctrl-8 = <&emmc_pins_tune3>;
+	pinctrl-9 = <&emmc_pins_tune4>;
+        };
-- 
2.42.0

