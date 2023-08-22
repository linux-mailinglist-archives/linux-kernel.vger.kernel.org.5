Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349EA783DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjHVK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjHVK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:29:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A11CD6;
        Tue, 22 Aug 2023 03:29:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MASR0w8032211, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MASR0w8032211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 18:28:27 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 22 Aug 2023 18:28:49 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 22 Aug 2023 18:28:49 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 22 Aug 2023 18:28:48 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC Type-C
Date:   Tue, 22 Aug 2023 18:28:41 +0800
Message-ID: <20230822102846.4683-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822102846.4683-1-stanley_chang@realtek.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings for Realtek SoCs Type-C.
Realtek DHC (digital home center) RTD SoCs support a Type-C module.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 .../bindings/extcon/extcon-rtk-type-c.yaml    | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
new file mode 100644
index 000000000000..d14b9ee544b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-rtk-type-c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD SoCs USB Type-C detection
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description: |
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
+    description: Address and length of register set for type-c module.
+
+  interrupts:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      The phandle to nvmem cell that contains the trimming data.
+      If unspecified, default value is used.
+
+  pinctrl-names:
+    const: default
+    description: A pinctrl state names "default" must be defined.
+
+  pinctrl-0:
+    description:
+      Should contain default pinctrl.
+
+  nvmem-cell-names:
+    const: usb-cal
+    description:
+      The type c parameter trimming data specified via efuse.
+
+  realtek,rd-ctrl-gpio:
+    description: The gpio node to control external Rd on board.
+    maxItems: 1
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
+    type-c@7220 {
+        compatible = "realtek,rtd1619b-type-c";
+        reg = <0x7220 0x20>;
+        interrupts = <0 60 4>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&usb_cc1_pins>, <&usb_cc2_pins>;
+        nvmem-cells = <&otp_usb_cal>;
+        nvmem-cell-names = "usb-cal";
+    };
-- 
2.34.1

