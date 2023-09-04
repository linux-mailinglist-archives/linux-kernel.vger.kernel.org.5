Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6187910C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352172AbjIDFN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjIDFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:13:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C82C180;
        Sun,  3 Sep 2023 22:13:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3845CSkX4017014, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3845CSkX4017014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Sep 2023 13:12:29 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Sep 2023 13:12:55 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 4 Sep 2023 13:12:55 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Mon, 4 Sep 2023 13:12:55 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: usb: Add Realtek DHC RTD SoC Type-C
Date:   Mon, 4 Sep 2023 13:12:48 +0800
Message-ID: <20230904051253.23208-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904051253.23208-1-stanley_chang@realtek.com>
References: <20230904051253.23208-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
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

Document the device-tree bindings for Realtek SoCs Type-C.
Realtek DHC (digital home center) RTD SoCs support a Type-C module.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v2 to v3 change:
  changed the commit message (extcon to usb)
v1 to v2 change:
  1. moved this binding from extcon to usb.
  2. removed the property of pinctrl.
  3. revised the properties of nvmem and gpio.
  4. added connector node.
  5. revised the example.
---
 .../bindings/usb/realtek,rtd-type-c.yaml      | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml

diff --git a/Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml b/Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml
new file mode 100644
index 000000000000..6142b0b5b534
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/realtek,rtd-type-c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD SoCs USB Type-C Connector detection
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description:
+  Realtek digital home center (DHC) RTD series SoCs include a type c module.
+  This module is able to detect the state of type c connector.
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1295-type-c
+      - realtek,rtd1312c-type-c
+      - realtek,rtd1315e-type-c
+      - realtek,rtd1319-type-c
+      - realtek,rtd1319d-type-c
+      - realtek,rtd1395-type-c
+      - realtek,rtd1619-type-c
+      - realtek,rtd1619b-type-c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nvmem-cell-names:
+    items:
+      - const: usb-cal
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      The phandle to nvmem cell that contains the trimming data.
+      The type c parameter trimming data specified via efuse.
+      If unspecified, default value is used.
+
+  realtek,rd-ctrl-gpios:
+    description: The gpio node to control external Rd on board.
+    maxItems: 1
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+    description: Properties for usb c connector.
+    type: object
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    type-c@7220 {
+        compatible = "realtek,rtd1619b-type-c";
+        reg = <0x7220 0x20>;
+        interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&usb_cc1_pins>, <&usb_cc2_pins>;
+        nvmem-cells = <&otp_usb_cal>;
+        nvmem-cell-names = "usb-cal";
+
+        connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            data-role = "dual";
+            power-role = "dual";
+        };
+    };
-- 
2.34.1

