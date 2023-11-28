Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50A7FBBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjK1NZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjK1NZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:25:36 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADB10D7;
        Tue, 28 Nov 2023 05:25:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 9F59A6000B;
        Tue, 28 Nov 2023 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701177940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psebKNsdqvnIQUttY1jWFp3xKW3lCnuxbNEJnK1Je/k=;
        b=Qr0NjEMMNYTl2PtLGDw+zeqbPV5V2Lvh1UdE+jKgtj9Clvrp1rgxLkVHyQ0qDJQmcPi7ge
        so8FzaKcUQsSCp+mzUm/xvjU2/w2h/0ZHXZIHnpOu6YRTzAysbIuBhdBRSxEU+NZ/PbvIZ
        dlrroG3MK+ngKnh7Z+SqkZYSCBmdzaTD8H/18//5P9bczVH8x7j2rPbXaK6f0dvfKh5FKK
        wF1CqeXV/fkXXsKVPQJpEuTuAfLs96S044O2U0yvaXesreVC8Odf5KjWNMGy6ylknQAyy+
        GGfXGOU3yy9p25sAoNzBweFmWirTGIh89ggQe9S/9Y7SSF+lCgn/O0nWLIpkKA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/5] dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
Date:   Tue, 28 Nov 2023 14:25:31 +0100
Message-ID: <20231128132534.258459-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128132534.258459-1-herve.codina@bootlin.com>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/lantiq,pef2256.yaml          | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml

diff --git a/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
new file mode 100644
index 000000000000..7da8370e2468
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
@@ -0,0 +1,213 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/lantiq,pef2256.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq PEF2256
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
+  line interface component designed to fulfill all required interfacing between
+  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
+
+properties:
+  compatible:
+    items:
+      - const: lantiq,pef2256
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Master Clock
+      - description: System Clock Receive
+      - description: System Clock Transmit
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: sclkr
+      - const: sclkx
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO used to reset the device.
+    maxItems: 1
+
+  pinctrl:
+    $ref: /schemas/pinctrl/pinctrl.yaml#
+    additionalProperties: false
+
+    patternProperties:
+      '-pins$':
+        type: object
+        $ref: /schemas/pinctrl/pinmux-node.yaml#
+        additionalProperties: false
+
+        properties:
+          pins:
+            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
+
+          function:
+            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, LOS,
+                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XLT,
+                    GPI, GPOH, GPOL ]
+
+        required:
+          - pins
+          - function
+
+  lantiq,data-rate-bps:
+    enum: [2048000, 4096000, 8192000, 16384000]
+    default: 2048000
+    description:
+      Data rate (bit per seconds) on the system highway.
+
+  lantiq,clock-falling-edge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Data is sent on falling edge of the clock (and received on the rising
+      edge). If 'clock-falling-edge' is not present, data is sent on the
+      rising edge (and received on the falling edge).
+
+  lantiq,channel-phase:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 0
+    description: |
+      The pef2256 delivers a full frame (32 8-bit time-slots in E1 and 24 8-bit
+      time-slots 8 8-bit signaling in E1/J1) every 125us. This lead to a data
+      rate of 2048000 bit/s. When lantiq,data-rate-bps is more than 2048000
+      bit/s, the data (all 32 8-bit) present in the frame are interleave with
+      unused time-slots. The lantiq,channel-phase property allows to set the
+      correct alignment of the interleave mechanism.
+      For instance, suppose lantiq,data-rate-bps = 8192000 (ie 4*2048000), and
+      lantiq,channel-phase = 2, the interleave schema with unused time-slots
+      (nu) and used time-slots (XX) for TSi is
+        nu nu XX nu nu nu XX nu nu nu XX nu
+        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
+      With lantiq,data-rate-bps = 8192000, and lantiq,channel-phase = 1, the
+      interleave schema is
+        nu XX nu nu nu XX nu nu nu XX nu nu
+        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
+      With lantiq,data-rate-bps = 4096000 (ie 2*2048000), and
+      lantiq,channel-phase = 1, the interleave schema is
+        nu    XX    nu    XX    nu    XX
+        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
+
+patternProperties:
+  '^codec(-([0-9]|[1-2][0-9]|3[0-1]))?$':
+    type: object
+    $ref: /schemas/sound/dai-common.yaml
+    unevaluatedProperties: false
+    description:
+      Codec provided by the pef2256. This codec allows to use some of the PCM
+      system highway time-slots as audio channels to transport audio data over
+      the E1/T1/J1 lines.
+      The time-slots used by the codec must be set and so, the properties
+      'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+      'dai-tdm-slot-rx-mask' must be present in the sound card node for
+      sub-nodes that involve the codec. The codec uses 8-bit time-slots.
+      'dai-tdm-tdm-slot-with' must be set to 8.
+      The tx and rx masks define the pef2256 time-slots assigned to the codec.
+
+    properties:
+      compatible:
+        const: lantiq,pef2256-codec
+
+      '#sound-dai-cells':
+        const: 0
+
+    required:
+      - compatible
+      - '#sound-dai-cells'
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pef2256: framer@2000000 {
+      compatible = "lantiq,pef2256";
+      reg = <0x2000000 0x100>;
+      interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+      interrupt-parent = <&intc>;
+      clocks = <&clk_mclk>, <&clk_sclkr>, <&clk_sclkx>;
+      clock-names = "mclk", "sclkr", "sclkx";
+      reset-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+      lantiq,data-rate-bps = <4096000>;
+
+      pinctrl {
+        pef2256_rpa_sypr: rpa-pins {
+          pins = "RPA";
+          function = "SYPR";
+        };
+        pef2256_xpa_sypx: xpa-pins {
+          pins = "XPA";
+          function = "SYPX";
+        };
+      };
+
+      pef2256_codec0: codec-0 {
+        compatible = "lantiq,pef2256-codec";
+        #sound-dai-cells = <0>;
+        sound-name-prefix = "PEF2256_0";
+      };
+
+      pef2256_codec1: codec-1 {
+        compatible = "lantiq,pef2256-codec";
+        #sound-dai-cells = <0>;
+        sound-name-prefix = "PEF2256_1";
+      };
+    };
+
+    sound {
+      compatible = "simple-audio-card";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      simple-audio-card,dai-link@0 { /* CPU DAI1 - pef2256 codec 1 */
+        reg = <0>;
+        cpu {
+          sound-dai = <&cpu_dai1>;
+        };
+        codec {
+          sound-dai = <&pef2256_codec0>;
+          dai-tdm-slot-num = <4>;
+          dai-tdm-slot-width = <8>;
+          /* TS 1, 2, 3, 4 */
+          dai-tdm-slot-tx-mask = <0 1 1 1 1>;
+          dai-tdm-slot-rx-mask = <0 1 1 1 1>;
+        };
+      };
+      simple-audio-card,dai-link@1 { /* CPU DAI2 - pef2256 codec 2 */
+        reg = <1>;
+        cpu {
+          sound-dai = <&cpu_dai2>;
+        };
+        codec {
+          sound-dai = <&pef2256_codec1>;
+          dai-tdm-slot-num = <4>;
+          dai-tdm-slot-width = <8>;
+          /* TS 5, 6, 7, 8 */
+          dai-tdm-slot-tx-mask = <0 0 0 0 0 1 1 1 1>;
+          dai-tdm-slot-rx-mask = <0 0 0 0 0 1 1 1 1>;
+        };
+      };
+    };
-- 
2.42.0

