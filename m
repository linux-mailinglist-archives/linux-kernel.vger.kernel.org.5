Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE6800914
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378369AbjLAKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378350AbjLAKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:52:56 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D210FF;
        Fri,  1 Dec 2023 02:53:02 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B1AqFGZ1299709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B1AqFGZ1299709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 18:52:15 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Dec 2023 18:52:15 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Dec 2023 18:52:14 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Fri, 1 Dec 2023 18:52:14 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        Tzuyi Chang <tychang@realtek.com>
Subject: [PATCH 1/2] dt-bindings: phy: realtek: Add Realtek DHC RTD SoC PCIe PHY
Date:   Fri, 1 Dec 2023 18:52:06 +0800
Message-ID: <20231201105207.11786-2-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201105207.11786-1-tychang@realtek.com>
References: <20231201105207.11786-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
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

Add the device tree bindings for the Realtek DHC(Digital Home Center)
RTD SoCs PCIe PHY.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
 .../bindings/phy/realtek,rtd-pcie-phy.yaml    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/realtek,rtd-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/realtek,rtd-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/realtek,rtd-pcie-phy.yaml
new file mode 100644
index 000000000000..44ff23f698e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/realtek,rtd-pcie-phy.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/realtek,rtd-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC PCIe PHY
+
+maintainers:
+  - Tzuyi Chang <tychang@realtek.com>
+
+description:
+  Realtek PCIe PHY supports the DHC(Digital Home Center) RTD series SoCs.
+  The PCIe PHY driver is designed to support physical layer functionality
+  of the PCIe controller.
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1319-pcie0-phy
+      - realtek,rtd1319-pcie1-phy
+      - realtek,rtd1319-pcie2-phy
+      - realtek,rtd1619b-pcie1-phy
+      - realtek,rtd1619b-pcie2-phy
+      - realtek,rtd1319d-pcie1-phy
+      - realtek,rtd1315e-pcie1-phy
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Phandle to nvmem cell that contains 'Tx swing trim'
+      tuning parameter value for PCIe phy.
+
+  nvmem-cell-names:
+    items:
+      - const: tx_swing_trim
+
+  realtek,pcie-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of syscon used to control PCIe MDIO register.
+
+required:
+  - compatible
+  - realtek,pcie-syscon
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie1_phy {
+        compatible = "realtek,rtd1319d-pcie1-phy";
+        realtek,pcie-syscon = <&pcie1>;
+        #phy-cells = <0>;
+        nvmem-cells = <&otp_pcie_tx_swing_trim>;
+        nvmem-cell-names = "tx_swing_trim";
+    };
-- 
2.43.0

