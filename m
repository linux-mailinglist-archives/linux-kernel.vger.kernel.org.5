Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7C77CAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjHOJz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbjHOJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:55:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E97B98;
        Tue, 15 Aug 2023 02:55:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37F9sZJV1008509, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37F9sZJV1008509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Aug 2023 17:54:35 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 15 Aug 2023 17:54:54 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 15 Aug 2023 17:54:54 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 15 Aug 2023 17:54:54 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC DWC3 USB
Date:   Tue, 15 Aug 2023 17:54:38 +0800
Message-ID: <20230815095452.4146-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815095452.4146-1-stanley_chang@realtek.com>
References: <20230815095452.4146-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Document the DWC3 USB bindings for Realtek SoCs.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v3 to v4 change:
    Add reg for register set for pm control.
    Remove maximum-speed in example.
v2 to v3 change:
    Add description for reg
    Remove property for realtek,unlink-usb3-port.
    Remove property for realtek,disable-usb3-phy.
    Use the maximum-speed instead of the above two properties.
v1 to v2 change:
    Revise the subject.
    Rename the file.
    Fix dtschema warnings.
    Remove the property realtek,enable-l4icg.
    Drop status.
---
 .../bindings/usb/realtek,rtd-dwc3.yaml        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
new file mode 100644
index 000000000000..345d0132d4a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
@@ -0,0 +1,80 @@
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
+    items:
+      - description: Address and length of register set for wrapper of dwc3 core.
+      - description: Address and length of register set for pm control.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
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
+additionalProperties: false
+
+examples:
+  - |
+    usb@98013e00 {
+        compatible = "realtek,rtd1319d-dwc3", "realtek,rtd-dwc3";
+        reg = <0x98013e00 0x140>, <0x98013f60 0x4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
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

