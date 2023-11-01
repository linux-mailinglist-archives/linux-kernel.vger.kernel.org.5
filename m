Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFAB7DDC70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376749AbjKAFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376579AbjKAFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:45:51 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878CF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:45:44 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A15iikE023619;
        Wed, 1 Nov 2023 13:44:44 +0800 (+08)
        (envelope-from pu.li@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SKwnb6S6cz2LjbCw;
        Wed,  1 Nov 2023 13:40:03 +0800 (CST)
Received: from zebjkernups01.spreadtrum.com (10.0.93.153) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 1 Nov 2023 13:44:42 +0800
From:   Pu Li <pu.li@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Pu Li <pu.li@unisoc.com>, Zhiyong Liu <zhiyong.liu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: phy: Add Spreadtrum usb20 hsphy yaml
Date:   Wed, 1 Nov 2023 13:44:31 +0800
Message-ID: <20231101054432.27509-2-pu.li@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231101054432.27509-1-pu.li@unisoc.com>
References: <20231101054432.27509-1-pu.li@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.153]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3A15iikE023619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Spreadtrum
usb20 hsphy driver.

Signed-off-by: Pu Li <pu.li@unisoc.com>
---
 .../bindings/phy/phy-sprd-usb20-hs.yaml       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml b/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml
new file mode 100644
index 000000000000..102b49d3482e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020-2023 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-sprd-usb20-hs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum USB20 High Speed PHY
+
+maintainers:
+  - Pu Li <lip308226@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sprd,pike2-phy
+              - sprd,sharkle-phy
+              - sprd,sharkl3-phy
+              - sprd,sharkl5-phy
+              - sprd,sharkl5pro-phy
+              - sprd,qogirl6-phy
+              - sprd,qogirn6lite-phy
+              - sprd,uis8520-phy
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: phy_glb_regs
+
+  sprd,syscon-enable:
+    description:
+      Phandle to aon apb syscon register region.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  sprd,syscon-ana:
+    description:
+      Phandle to analog syscon register region.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  sprd,vdd-voltage:
+    description:
+      It represents the value of one analog power supply of phy,
+      the unit is uV.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hsphy@64570000 {
+      compatible = "sprd,qogirl6-phy";
+      reg = <0x64570000 0x3030>;
+      reg-names = "phy_glb_regs";
+      sprd,syscon-enable = <&aon_apb_regs>;
+      sprd,syscon-ana = <&anlg_phy_g2_regs>;
+      sprd,vdd-voltage = <3300000>;
+      #phy-cells = <0>;
+    };
-- 
2.17.1

