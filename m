Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7875F381
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGXKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGXKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:37:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B72E4F;
        Mon, 24 Jul 2023 03:37:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36OAaXsA5031024, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36OAaXsA5031024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 18:36:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Jul 2023 18:36:44 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 18:36:43 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Mon, 24 Jul 2023 18:36:43 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Roy Luo <royluo@google.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v8 5/5] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC USB 3.0 PHY
Date:   Mon, 24 Jul 2023 18:34:52 +0800
Message-ID: <20230724103600.14164-5-stanley_chang@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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
controller and using USB 3.0 PHY transceiver.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v7 to v8 change:
    No Change
v6 to v7 change:
    Revise the commit message.
v5 to v6 change:
    Drop the labels of example.
v4 to v5 change:
    1. Remove the compatible realtek,usb3phy.
    2. Add the default of the property.
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
 .../bindings/phy/realtek,usb3phy.yaml         | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
new file mode 100644
index 000000000000..dfe2bb4e59e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,usb3phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs USB 3.0 PHY
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description: |
+  Realtek USB 3.0 PHY support the digital home center (DHC) RTD series SoCs.
+  The USB 3.0 PHY driver is designed to support the XHCI controller. The SoCs
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
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1295-usb3phy
+      - realtek,rtd1319-usb3phy
+      - realtek,rtd1319d-usb3phy
+      - realtek,rtd1619-usb3phy
+      - realtek,rtd1619b-usb3phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    maxItems: 1
+    description: A phandle to the tx lfps swing trim data provided by
+      a nvmem device, if unspecified, default values shall be used.
+
+  nvmem-cell-names:
+    items:
+      - const: usb_u3_tx_lfps_swing_trim
+
+  realtek,amplitude-control-coarse-tuning:
+    description:
+      This adjusts the signal amplitude for normal operation and beacon LFPS.
+      This value is a parameter for coarse tuning.
+      For different boards, if the default value is inappropriate, this
+      property can be assigned to adjust.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 255
+    minimum: 0
+    maximum: 255
+
+  realtek,amplitude-control-fine-tuning:
+    description:
+      This adjusts the signal amplitude for normal operation and beacon LFPS.
+      This value is used for fine-tuning parameters.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 65535
+    minimum: 0
+    maximum: 65535
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@13e10 {
+        compatible = "realtek,rtd1319d-usb3phy";
+        reg = <0x13e10 0x4>;
+        #phy-cells = <0>;
+
+        nvmem-cells = <&otp_usb_u3_tx_lfps_swing_trim>;
+        nvmem-cell-names = "usb_u3_tx_lfps_swing_trim";
+
+        realtek,amplitude-control-coarse-tuning = <0x77>;
+    };
-- 
2.34.1

