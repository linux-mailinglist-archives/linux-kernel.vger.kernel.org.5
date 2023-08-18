Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1278111D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378897AbjHRQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378845AbjHRQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:58:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957073A8B;
        Fri, 18 Aug 2023 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692377896; x=1723913896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxphbyHk/T6UEz7vFFVTPl2Q8laSgxaLvUwE5ctdBPE=;
  b=ntaD7qTZNm3Mb24CnpCDT+iMxQpa3L9jlLoToijqxZNB0st0cG2SRxFo
   vbS5tE+lzK0FS+BMoS/cjxmwvexjCasVnpLC+DjENU7/SoD8YfBPjjjSU
   L9n7kNx/9LWcimPDLmPfRcCotvNZUgc/iUqLlFMTBimReR4iyRiyYbg7X
   N78JYWsIkExWHT/8HTuUyFgyBNWYPxtpyj/EYw8dyYE/FmcvOH2/uREta
   /woQhUEgi9Zr/1YEhm6eBp/Iux4jeoUK3deS6xYK/arReUUIIrpkAiCHP
   7oqLBAZ4Zsj2DZMPiKuB3iI0zORJsR1IqGUXDmHPiDinND5XGJTeS0b2A
   w==;
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="167165730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2023 09:58:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 18 Aug 2023 09:58:01 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 18 Aug 2023 09:57:58 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Date:   Fri, 18 Aug 2023 19:57:49 +0300
Message-ID: <20230818165750.55406-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818165750.55406-1-marius.cristea@microchip.com>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
Delta-Sigma ADCs with an SPI interface (Microchip's
MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
MCP3562R and MCP3564R analog to digital converters).

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,mcp3564.yaml   | 205 ++++++++++++++++++
 1 file changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
new file mode 100644
index 000000000000..675319276197
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3564.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP346X and MCP356X ADC Family
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  Bindings for the Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
+  Delta-Sigma ADCs with an SPI interface. Datasheet can be found here:
+  Datasheet for MCP3561, MCP3562, MCP3564 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP3561-2-4-Family-Data-Sheet-DS20006181C.pdf
+  Datasheet for MCP3561R, MCP3562R, MCP3564R can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
+  Datasheet for MCP3461, MCP3462, MCP3464 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-Noise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
+  Datasheet for MCP3461R, MCP3462R, MCP3464R can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4R-Family-Data-Sheet-DS20006404C.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3461
+      - microchip,mcp3462
+      - microchip,mcp3464
+      - microchip,mcp3461r
+      - microchip,mcp3462r
+      - microchip,mcp3464r
+      - microchip,mcp3561
+      - microchip,mcp3562
+      - microchip,mcp3564
+      - microchip,mcp3561r
+      - microchip,mcp3562r
+      - microchip,mcp3564r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  vdd-supply: true
+
+  avdd-supply: true
+
+  clocks:
+    description:
+      Phandle and clock identifier for external sampling clock.
+      If not specified, the internal crystal oscillator will be used.
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line of the ADC
+    maxItems: 1
+
+  drive-open-drain:
+    description:
+      Whether to drive the IRQ signal as push-pull (default) or open-drain. Note
+      that the device requires this pin to become "high", otherwise it will stop
+      converting.
+    type: boolean
+
+  vref-supply:
+    description:
+      Some devices have a specific reference voltage supplied on a different
+      pin to the other supplies. Needed to be able to establish channel scaling
+      unless there is also an internal reference available (e.g. mcp3564r). In
+      case of "r" devices (e. g. mcp3564r), if it does not exists the internal
+      reference will be used.
+
+  microchip,hw-device-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description:
+      The address is set on a per-device basis by fuses in the factory,
+      configured on request. If not requested, the fuses are set for 0x1.
+      The device address is part of the device markings to avoid
+      potential confusion. This address is coded on two bits, so four possible
+      addresses are available when multiple devices are present on the same
+      SPI bus with only one Chip Select line for all devices.
+      Each device communication starts by a CS falling edge, followed by the
+      clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
+      which is first one on the wire).
+
+  "#io-channel-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@([0-9]|([1-7][0-9]))$":
+    $ref: adc.yaml
+    type: object
+    unevaluatedProperties: false
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number in single-ended and differential mode.
+        minimum: 0
+        maximum: 79
+
+    required:
+      - reg
+
+dependencies:
+  spi-cpol: [ spi-cpha ]
+  spi-cpha: [ spi-cpol ]
+
+required:
+  - compatible
+  - reg
+  - microchip,hw-device-address
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - # External vref, no internal reference
+    if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp3461
+              - microchip,mcp3462
+              - microchip,mcp3464
+              - microchip,mcp3561
+              - microchip,mcp3562
+              - microchip,mcp3564
+    then:
+      required:
+        - vref-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "microchip,mcp3564r";
+            reg = <0>;
+            vref-supply = <&vref_reg>;
+            spi-cpha;
+            spi-cpol;
+            spi-max-frequency = <10000000>;
+            microchip,hw-device-address = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                /* CH0 to AGND */
+                reg = <0>;
+                label = "CH0";
+            };
+
+            channel@1 {
+                /* CH1 to AGND */
+                reg = <1>;
+                label = "CH1";
+            };
+
+            /* diff-channels */
+            channel@11 {
+                reg = <11>;
+
+                /* CN0, CN1 */
+                diff-channels = <0 1>;
+                label = "CH0_CH1";
+            };
+
+            channel@22 {
+                reg = <0x22>;
+
+                /* CN1, CN2 */
+                diff-channels = <1 2>;
+                label = "CH1_CH3";
+            };
+
+            channel@23 {
+                reg = <0x23>;
+
+                /* CN1, CN3 */
+                diff-channels = <1 3>;
+                label = "CH1_CH3";
+            };
+        };
+    };
+...
-- 
2.34.1

