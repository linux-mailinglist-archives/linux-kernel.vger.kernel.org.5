Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4776AD3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjHAJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjHAJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:27:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0328E1738;
        Tue,  1 Aug 2023 02:25:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3719PUpnC019521, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3719PUpnC019521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 17:25:30 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 17:25:43 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Aug 2023 17:25:43 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 1 Aug 2023 17:25:43 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC DWC3 USB
Date:   Tue, 1 Aug 2023 17:25:27 +0800
Message-ID: <20230801092541.25261-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801092541.25261-1-stanley_chang@realtek.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DWC3 USB bindings for Realtek SoCs.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v1 to v2 change:
    Revise the subject.
    Rename the file.
    Fix dtschema warnings.
    Remove the property realtek,enable-l4icg.
    Drop status.
---
 .../bindings/usb/realtek,rtd-dwc3.yaml        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
new file mode 100644
index 000000000000..8b9050724b97
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/realtek,rtd-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DWC3 USB SoC Controller Glue
+
+maintainers:
+  - Stanley Chang <stanley_chang@realtek.com>
+
+description:
+  The Realtek DHC SoC embeds a DWC3 USB IP Core configured for USB 2.0
+  and USB 3.0 in host or dual-role mode.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - realtek,rtd1295-dwc3
+          - realtek,rtd1315e-dwc3
+          - realtek,rtd1319-dwc3
+          - realtek,rtd1319d-dwc3
+          - realtek,rtd1395-dwc3
+          - realtek,rtd1619-dwc3
+          - realtek,rtd1619b-dwc3
+      - const: realtek,rtd-dwc3
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  realtek,unlink-usb3-port:
+    description: Disable link between USB 3.0 PHY and USB mac.
+      Only for RTD1619 SoC, if the board design support maximum 2.0 speed.
+    type: boolean
+
+  realtek,disable-usb3-phy:
+    description: Close USB 3.0 PHY if the board design not support USB 3.0.
+    type: boolean
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+    description: Required child node
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - realtek,rtd1619-dwc3
+    then:
+      properties:
+        realtek,unlink-usb3-port: false
+
+additionalProperties: false
+
+examples:
+  - |
+    usb@98013e00 {
+        compatible = "realtek,rtd1319d-dwc3", "realtek,rtd-dwc3";
+        reg = <0x98013e00 0x200>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        realtek,disable-usb3-phy;
+
+        usb@98050000 {
+            compatible = "snps,dwc3";
+            reg = <0x98050000 0x9000>;
+            interrupts = <0 94 4>;
+            phys = <&usb2phy &usb3phy>;
+            phy-names = "usb2-phy", "usb3-phy";
+            dr_mode = "otg";
+            usb-role-switch;
+            role-switch-default-mode = "host";
+            snps,dis_u2_susphy_quirk;
+            snps,parkmode-disable-ss-quirk;
+            snps,parkmode-disable-hs-quirk;
+            maximum-speed = "high-speed";
+        };
+    };
-- 
2.34.1

