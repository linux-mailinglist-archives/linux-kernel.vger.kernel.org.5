Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F201675F37E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGXKh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGXKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:37:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563E1E55;
        Mon, 24 Jul 2023 03:37:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36OAaMq05029515, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36OAaMq05029515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 18:36:22 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Jul 2023 18:36:33 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 18:36:32 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Mon, 24 Jul 2023 18:36:32 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Roy Luo <royluo@google.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v8 4/5] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC USB 2.0 PHY
Date:   Mon, 24 Jul 2023 18:34:51 +0800
Message-ID: <20230724103600.14164-4-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724103600.14164-1-stanley_chang@realtek.com>
References: <20230724103600.14164-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the USB PHY bindings for Realtek SoCs.
Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
controller and using USB 2.0 PHY transceiver.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v7 to v8 change:
    No change
v6 to v7 change:
    1. Revise the commit message
    2. Change the property name for realtek,driving-level-compensate
    3. Add if/then schema for specific properties
v5 to v6 change:
    Drop the redundant examples
    Drop the label of example
v4 to v5 change:
    1. Add more examples.
    2. Remove the compatible realtek,usb2phy.
    3. Revise the descriptor of the property.
    4. Add the default of the property.
v3 to v4 change:
    1. Remove the parameter and non hardware properties from dts.
    2. Using the compatible data included the config and parameter
       in driver.
v2 to v3 change:
    1. Broken down into two patches, one for each of USB 2 & 3.
    2. Add more description about Realtek RTD SoCs architecture.
    3. Removed parameter v1 support for simplification.
    4. Revised the compatible name for fallback compatible.
    5. Remove some properties that can be set in the driver.
v1 to v2 change:
    Add phy-cells for generic phy driver
---
 .../bindings/phy/realtek,usb2phy.yaml         | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
new file mode 100644
index 000000000000..9911ada39ee7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB 2.0 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description: |
+  Realtek USB 2.0 PHY support the digital home center (DHC) RTD series SoCs.
+  The USB 2.0 PHY driver is designed to support the XHCI controller. The SoCs
+  support multiple XHCI controllers. One PHY device node maps to one XHCI
+  controller.
+
+  RTD1295/RTD1619 SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on some
+  controllers.
+  XHCI controller#0 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+
+  RTD1395 SoCs USB
+  The USB architecture includes two XHCI controllers.
+  The controller#0 has one USB 2.0 PHY. The controller#1 includes two USB 2.0
+  PHY.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+                               |- phy#1
+
+  RTD1319/RTD1619b SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#2.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+
+  RTD1319d SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each xhci maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#0.
+  XHCI controller#0 -- usb2phy -- phy#0
+                    |- usb3phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+
+  RTD1312c/RTD1315e SoCs USB
+  The USB architecture includes three XHCI controllers.
+  Each XHCI maps to one USB 2.0 PHY.
+  XHCI controller#0 -- usb2phy -- phy#0
+  XHCI controller#1 -- usb2phy -- phy#0
+  XHCI controller#2 -- usb2phy -- phy#0
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1295-usb2phy
+      - realtek,rtd1312c-usb2phy
+      - realtek,rtd1315e-usb2phy
+      - realtek,rtd1319-usb2phy
+      - realtek,rtd1319d-usb2phy
+      - realtek,rtd1395-usb2phy
+      - realtek,rtd1395-usb2phy-2port
+      - realtek,rtd1619-usb2phy
+      - realtek,rtd1619b-usb2phy
+
+  reg:
+    items:
+      - description: PHY data registers
+      - description: PHY control registers
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    maxItems: 2
+    description:
+      Phandles to nvmem cell that contains the trimming data.
+      If unspecified, default value is used.
+
+  nvmem-cell-names:
+    items:
+      - const: usb-dc-cal
+      - const: usb-dc-dis
+    description:
+      The following names, which correspond to each nvmem-cells.
+      usb-dc-cal is the driving level for each phy specified via efuse.
+      usb-dc-dis is the disconnection level for each phy specified via efuse.
+
+  realtek,inverse-hstx-sync-clock:
+    description:
+      For one of the phys of RTD1619b SoC, the synchronous clock of the
+      high-speed tx must be inverted.
+    type: boolean
+
+  realtek,driving-level:
+    description:
+      Control the magnitude of High speed Dp/Dm output swing (mV).
+      For a different board or port, the original magnitude maybe not meet
+      the specification. In this situation we can adjust the value to meet
+      the specification.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 8
+    minimum: 0
+    maximum: 31
+
+  realtek,driving-level-compensate:
+    description:
+      For RTD1315e SoC, the driving level can be adjusted by reading the
+      efuse table. This property provides drive compensation.
+      If the magnitude of High speed Dp/Dm output swing still not meet the
+      specification, then we can set this value to meet the specification.
+    $ref: /schemas/types.yaml#/definitions/int32
+    default: 0
+    minimum: -8
+    maximum: 8
+
+  realtek,disconnection-compensate:
+    description:
+      This adjusts the disconnection level compensation for the different
+      boards with different disconnection level.
+    $ref: /schemas/types.yaml#/definitions/int32
+    default: 0
+    minimum: -8
+    maximum: 8
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - realtek,rtd1619b-usb2phy
+    then:
+      properties:
+        realtek,inverse-hstx-sync-clock: false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - realtek,rtd1315e-usb2phy
+    then:
+      properties:
+        realtek,driving-level-compensate: false
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@13214 {
+        compatible = "realtek,rtd1619b-usb2phy";
+        reg = <0x13214 0x4>, <0x28280 0x4>;
+        #phy-cells = <0>;
+        nvmem-cells = <&otp_usb_port0_dc_cal>, <&otp_usb_port0_dc_dis>;
+        nvmem-cell-names = "usb-dc-cal", "usb-dc-dis";
+
+        realtek,inverse-hstx-sync-clock;
+        realtek,driving-level = <0xa>;
+        realtek,disconnection-compensate = <(-1)>;
+    };
-- 
2.34.1

