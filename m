Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB27D3B56
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjJWPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJWPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:49:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0310A;
        Mon, 23 Oct 2023 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076170; x=1729612170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4Pt0gwBLyBOMj0Wnjreub+jmFGjoXYgtnrkexWrKuQ=;
  b=WWNyD9nEl7TtbCz9BEaY2DrVpnbdtPDJbjx2WQ5JaO24PyuymYRq/CJZ
   0zcNvf8nIoMENwmcgo5LdmiuYEkjSdAjALxCquamSSYs5JZIkCiDB08TL
   4waZgWhxDDPBpM73lNvRsDihwosQtLDdWjOb4716UH3ljPMKxvxgi7eZD
   jpVdV3Ya/3V46Ng0ZzLin71tHInCgchlBfRUaPvNlOSe3lgdKdvY64G/d
   SPHrXIIHab930TR6UExWe1j4C7q75RmHwLWiYSj1UBsjjt7r1PgVV6h5+
   1nXWd4p32ag6B44BukvRSJlYIMbEgnibzZ7h8n1E0LznniUUJIsDbfopQ
   g==;
X-CSE-ConnectionGUID: R4tFaVLSQ02v5bYQOZNT7Q==
X-CSE-MsgGUID: i+IzyY15S9G3s11hpzaXEw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="177613932"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:49:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:49:12 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:48:58 -0700
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
Subject: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
Date:   Mon, 23 Oct 2023 21:16:49 +0530
Message-ID: <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Microchip's LAN865X 10BASE-T1S MACPHY. The LAN8650/1
combines a Media Access Controller (MAC) and an Ethernet PHY to enable
10BASE‑T1S networks. The Ethernet Media Access Controller (MAC) module
implements a 10 Mbps half duplex Ethernet MAC, compatible with the IEEE
802.3 standard and a 10BASE-T1S physical layer transceiver integrated
into the LAN8650/1. The communication between the Host and the MAC-PHY is
specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 .../bindings/net/microchip,lan865x.yaml       | 101 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
new file mode 100644
index 000000000000..974622dd6846
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
@@ -0,0 +1,101 @@
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
+description:
+  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
+  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
+  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
+  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
+  integrated into the LAN8650/1. The communication between the Host and
+  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
+  Interface (TC6).
+
+  Specifications about the LAN8650/1 can be found at:
+    https://www.microchip.com/en-us/product/lan8650
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,lan865x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt from MAC-PHY asserted in the event of Receive Chunks
+      Available, Transmit Chunk Credits Available and Extended Status
+      Event.
+    maxItems: 1
+
+  local-mac-address:
+    description:
+      Specifies the MAC address assigned to the network device.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 6
+    maxItems: 6
+
+  spi-max-frequency:
+    minimum: 15000000
+    maximum: 25000000
+
+  oa-tc6:
+    $ref: oa-tc6.yaml#
+    unevaluatedProperties: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - pinctrl-names
+  - pinctrl-0
+  - interrupts
+  - interrupt-parent
+  - local-mac-address
+  - spi-max-frequency
+  - oa-tc6
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "microchip,lan865x";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth0_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+        local-mac-address = [04 05 06 01 02 03];
+        spi-max-frequency = <15000000>;
+        status = "okay";
+        oa-tc6 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          oa-cps = <64>;
+          oa-txcte;
+	  oa_rxcte;
+	  oa-prote;
+	  oa-dprac;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b1bd3218a2d..d2b3c0e8d97e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14005,6 +14005,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 F:	drivers/net/ethernet/microchip/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1

