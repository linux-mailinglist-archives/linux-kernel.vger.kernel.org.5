Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990927988CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbjIHObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbjIHObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:31:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5AB211C;
        Fri,  8 Sep 2023 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694183459; x=1725719459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeHB0y9kfzmaAN0kkVn5rf9xamWzRSUzTry5VZYVrXg=;
  b=yGkGgXfVJ85d/6qW39ne3e/tnsETkfd4NWedguo5PVSbFI5LYW1G793f
   nBJOAGTu/mSliRhrSxVMjPgwczgqgfeTMvMB3KSV7nPVSlbJyeACzpTE2
   b05fcYBsLZ5hVPjFBkt2B4DtDESTlj/SbJim/K5/kUUAP+YUQ0+lCsHCz
   wuT519fd85JVMGnae5uFjEAka/WNQ3P/CQJeIJdPQZ7xDp1f2h485sr5y
   BsxhgAZVXfO3tbWJSLk3PULin9j0CfXOkWvoYD87zfEIIcwDWlukVCPdz
   4pjT3BXsjdGBGhPuVT6PL2Xap38zJwTaa2Czaa5a4zeTqTiEYPkMbkKRx
   g==;
X-CSE-ConnectionGUID: BfdJWj6dSkej858jQph4IQ==
X-CSE-MsgGUID: urbI0jbkRtODixBn6MAIdw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="170641889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 07:30:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 07:30:39 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 07:30:32 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree support for Microchip's LAN865X MACPHY
Date:   Fri, 8 Sep 2023 19:59:19 +0530
Message-ID: <20230908142919.14849-7-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree support for Microchip's LAN865X MACPHY for configuring
the OPEN Alliance 10BASE-T1x MACPHY Serial Interface parameters.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 .../bindings/net/microchip,lan865x.yaml       | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
new file mode 100644
index 000000000000..3465b2c97690
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
+  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+
+description: |
+  Device tree properties for LAN8650/1 10BASE-T1S MACPHY Ethernet
+  controller.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microchip,lan865x
+  reg:
+    maxItems: 1
+
+  local-mac-address: true
+  oa-chunk-size: true
+  oa-tx-cut-through: true
+  oa-rx-cut-through: true
+  oa-protected: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1{
+            compatible = "microchip,lan865x";
+            reg = <1>; /* CE0 */
+            local-mac-address = [04 05 06 01 02 03];
+            oa-chunk-size = <64>;
+            oa-tx-cut-through;
+            oa-rx-cut-through;
+            oa-protected;
+       };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 666c042a15b2..2bbb7f17d74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13883,6 +13883,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 F:	drivers/net/ethernet/microchip/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1

