Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE977782E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjHJVxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHJVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:53:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476702728
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:53:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe11652b64so2167490e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691704399; x=1692309199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl39W48anKXS5n6538TAVSUfWEGP6WWAAdxUHvad6Ds=;
        b=qnnScIs6rUoYOe86WmSSvTVQTFUNMjqDVneTF7QaT4A3LAPZGqMPsQ1ySgufiJJ8q+
         YEFrpXdV0K9EsgfVrM51MyptgBBF1/UpZa/PjhnjzlUK7ZF+lN3l12Y62Oyz1tZdToXd
         Udw2RCfW73KzmgYQu3j3mkR+RLAMhumG9GIQd0+pLVj4cHNYr/oDeAt3BBapjwOgci0V
         NNQN3Dvl9Th/Txj/yYi8IU8iZKAweaU0psLs0yemuDiwhIvDzBh7z+wnDnWBT2J5/NwU
         dn31CHI43F5KHCWgk0buHwxSpW88HlB3nH+xdJjqXnpKi8bTjSVQMvYHIxE9qok6sAzB
         xGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704399; x=1692309199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fl39W48anKXS5n6538TAVSUfWEGP6WWAAdxUHvad6Ds=;
        b=esAOTavEbZa41QbUD60NfMTboB1d5zptFmq8xk3mxUjWcrd7InXwgcMi9LCn3WZ9TR
         UsO3lVMo19xcoH7DrIUFyKJdpVm05g/VzFW6CjUcY+3EhyaGNmbq3ZVdzONZomwcZJLa
         BmmJdkh0Zj7NIo9YJ/oI9izBh++GuaWKrL3H1BcBKDUBD0m4SauBsa7wuBzWZvtqzqGJ
         PdI0MB0LaYoOSA+fkARJgnqM94gN2ySqrVJr9ZoLexSC+FpHrI8chzgecphIYaUGZ/6H
         0AE+KlNDzZ4CXOq0qc3Lb3Na9oir2Q1y3a6++5ui5bcePBqWHBfw7yGV6Ej6j/At++6h
         CJUg==
X-Gm-Message-State: AOJu0Yx15aObACi7SCH3QqLiY+xy8KQMFELeLj/H0ySPezYVCcJ3Sk3m
        B105hsr/vj56MQkU2q2V2klYlQ==
X-Google-Smtp-Source: AGHT+IFOekTA0B9mBZY2GSmny1sub6PCxEKjhqehYaLg/yj+Mf0dRKqa32OQ9Tp/KuhkCCaeAE+IsQ==
X-Received: by 2002:a05:6512:ba6:b0:4fe:21f2:a04a with SMTP id b38-20020a0565120ba600b004fe21f2a04amr3398984lfv.8.1691704399159;
        Thu, 10 Aug 2023 14:53:19 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n4-20020ac242c4000000b004fe3e3a0973sm448055lfl.262.2023.08.10.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:53:18 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 23:53:17 +0200
Subject: [PATCH] dt-bindings: Convert the sti pin controller bindings to
 YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org>
X-B4-Tracking: v=1; b=H4sIAExc1WQC/x3MPQqAMAxA4atIZgP9s4hXEQe1ac1SpRERxLtbH
 L/hvQeECpPA0DxQ6GLhPVfotoF1m3Mi5FANRhmreq0wnLhwDpyToJyM3rkYve2U6zzU6igU+f6
 P4/S+H1/WWUVhAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Peter Griffin <peter.griffin@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the STi pin control bindings to use YAML.

These bindings came early in the development of pin control
bindings so they are a bit obscure, and required a bit of
uncommon regexp work.

The reason why these bindings need to be converted and
preserved can be seen in the two new added compatibles,
which are for the SpaceX Starlink chip "gllcff" which uses
a derivative of this pin controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-st.txt     | 174 ---------------
 .../bindings/pinctrl/st,sti-pinctrl.yaml           | 238 +++++++++++++++++++++
 2 files changed, 238 insertions(+), 174 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
deleted file mode 100644
index 48b9be48af18..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
+++ /dev/null
@@ -1,174 +0,0 @@
-*ST pin controller.
-
-Each multi-function pin is controlled, driven and routed through the
-PIO multiplexing block. Each pin supports GPIO functionality (ALT0)
-and multiple alternate functions(ALT1 - ALTx) that directly connect
-the pin to different hardware blocks.
-
-When a pin is in GPIO mode, Output Enable (OE), Open Drain(OD), and
-Pull Up (PU) are driven by the related PIO block.
-
-ST pinctrl driver controls PIO multiplexing block and also interacts with
-gpio driver to configure a pin.
-
-GPIO bank can have one of the two possible types of interrupt-wirings.
-
-First type is via irqmux, single interrupt is used by multiple gpio banks. This
-reduces number of overall interrupts numbers required. All these banks belong to
-a single pincontroller.
-		  _________
-		 |	   |----> [gpio-bank (n)    ]
-		 |	   |----> [gpio-bank (n + 1)]
-	[irqN]-- | irq-mux |----> [gpio-bank (n + 2)]
-		 |	   |----> [gpio-bank (...  )]
-		 |_________|----> [gpio-bank (n + 7)]
-
-Second type has a dedicated interrupt per gpio bank.
-
-	[irqN]----> [gpio-bank (n)]
-
-
-Pin controller node:
-Required properties:
-- compatible	: should be "st,stih407-<pio-block>-pinctrl"
-- st,syscfg		: Should be a phandle of the syscfg node.
-- st,retime-pin-mask	: Should be mask to specify which pins can be retimed.
-	If the property is not present, it is assumed that all the pins in the
-	bank are capable of retiming. Retiming is mainly used to improve the
-	IO timing margins of external synchronous interfaces.
-- ranges : defines mapping between pin controller node (parent) to gpio-bank
-  node (children).
-
-Optional properties:
-- interrupts	: Interrupt number of the irqmux. If the interrupt is shared
-  with other gpio banks via irqmux.
-  a irqline and gpio banks.
-- reg		: irqmux memory resource. If irqmux is present.
-- reg-names	: irqmux resource should be named as "irqmux".
-
-GPIO controller/bank node.
-Required properties:
-- gpio-controller : Indicates this device is a GPIO controller
-- #gpio-cells	  : Must be two.
-     - First cell: specifies the pin number inside the controller
-     - Second cell: specifies whether the pin is logically inverted.
-       - 0 = active high
-       - 1 = active low
-- st,bank-name	  : Should be a name string for this bank as specified in
-  datasheet.
-
-Optional properties:
-- interrupts	: Interrupt number for this gpio bank. If there is a dedicated
-  interrupt wired up for this gpio bank.
-
-- interrupt-controller : Indicates this device is a interrupt controller. GPIO
-  bank can be an interrupt controller iff one of the interrupt type either via
-irqmux or a dedicated interrupt per bank is specified.
-
-- #interrupt-cells: the value of this property should be 2.
-     - First Cell: represents the external gpio interrupt number local to the
-       gpio interrupt space of the controller.
-     - Second Cell: flags to identify the type of the interrupt
-       - 1 = rising edge triggered
-       - 2 = falling edge triggered
-       - 3 = rising and falling edge triggered
-       - 4 = high level triggered
-       - 8 = low level triggered
-for related macros look in:
-include/dt-bindings/interrupt-controller/irq.h
-
-Example:
-	pin-controller-sbc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "st,stih407-sbc-pinctrl";
-		st,syscfg = <&syscfg_sbc>;
-		reg = <0x0961f080 0x4>;
-		reg-names = "irqmux";
-		interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>;
-		interrupt-names = "irqmux";
-		ranges = <0 0x09610000 0x6000>;
-
-		pio0: gpio@9610000 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x0 0x100>;
-			st,bank-name = "PIO0";
-		};
-		...
-		pin-functions nodes follow...
-	};
-
-
-Contents of function subnode node:
-----------------------
-Required properties for pin configuration node:
-- st,pins	: Child node with list of pins with configuration.
-
-Below is the format of how each pin conf should look like.
-
-<bank offset mux mode rt_type rt_delay rt_clk>
-
-Every PIO is represented with 4-7 parameters depending on retime configuration.
-Each parameter is explained as below.
-
--bank		: Should be bank phandle to which this PIO belongs.
--offset		: Offset in the PIO bank.
--mux		: Should be alternate function number associated this pin.
-		Use same numbers from datasheet.
--mode		:pin configuration is selected from one of the below values.
-		IN
-		IN_PU
-		OUT
-		BIDIR
-		BIDIR_PU
-
--rt_type	Retiming Configuration for the pin.
-		Possible retime configuration are:
-
-		-------		-------------
-		value		args
-		-------		-------------
-		NICLK		<delay> <clk>
-		ICLK_IO		<delay> <clk>
-		BYPASS		<delay>
-		DE_IO		<delay> <clk>
-		SE_ICLK_IO	<delay> <clk>
-		SE_NICLK_IO	<delay> <clk>
-
-- delay	is retime delay in pico seconds as mentioned in data sheet.
-
-- rt_clk	:clk to be use for retime.
-		Possible values are:
-		CLK_A
-		CLK_B
-		CLK_C
-		CLK_D
-
-Example of mmcclk pin which is a bi-direction pull pu with retime config
-as non inverted clock retimed with CLK_B and delay of 0 pico seconds:
-
-pin-controller {
-	...
-	mmc0 {
-		pinctrl_mmc: mmc {
-			st,pins {
-				mmcclk = <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
-				...
-			};
-		};
-	...
-	};
-};
-
-sdhci0:sdhci@fe810000{
-	...
-	interrupt-parent = <&pio3>;
-	#interrupt-cells = <2>;
-	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>; /* Interrupt line via PIO3-3 */
-	interrupt-names = "card-detect";
-	pinctrl-names = "default";
-	pinctrl-0	= <&pinctrl_mmc>;
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml
new file mode 100644
index 000000000000..846b9438ac06
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/st,sti-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST STi/GLLCFF GPIO and Pin Mux/Config controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  In the ST STi/GLLCFF pin controller each multi-function pin is controlled,
+  driven and routed through the PIO multiplexing block. Each pin supports
+  GPIO functionality (ALT0) and multiple alternate functions(ALT1 - ALTx)
+  that directly connect the pin to different hardware blocks.
+
+  The STi SoCs are used for consumer electronics. The GLLCFF SoCs are
+  used for SpaceX Starlink.
+
+  When a pin is in GPIO mode, Output Enable (OE), Open Drain(OD), and
+  Pull Up (PU) are driven by the related PIO block.
+
+  ST pinctrl driver controls PIO multiplexing block and also interacts with
+  gpio driver to configure a pin.
+
+  GPIO bank can have one of the two possible types of interrupt-wirings.
+
+  First type is via irqmux, single interrupt is used by multiple gpio banks. This
+  reduces number of overall interrupts numbers required. All these banks belong to
+  a single pincontroller.
+                  _________
+                 |         |----> [gpio-bank (n)    ]
+                 |         |----> [gpio-bank (n + 1)]
+        [irqN]-- | irq-mux |----> [gpio-bank (n + 2)]
+                 |         |----> [gpio-bank (...  )]
+                 |_________|----> [gpio-bank (n + 7)]
+
+  Second type has a dedicated interrupt per gpio bank.
+
+        [irqN]----> [gpio-bank (n)]
+
+properties:
+  compatible:
+    enum:
+      - st,gllcff-pinctrl
+      - st,gllcff-flash-pinctrl
+      - st,stih407-front-pinctrl
+      - st,stih407-rear-pinctrl
+      - st,stih407-flash-pinctrl
+      - st,stih407-sbc-pinctrl
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  reg: true
+
+  reg-names:
+    const: irqmux
+
+  ranges: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: irqmux
+
+  st,syscfg:
+    description: Should be a phandle of the syscfg node
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: syscon node to be used with the pin controller
+
+patternProperties:
+  # GPIO banks below the main node
+  '^(gpio|pio)@[0-9a-f]+$':
+    type: object
+    additionalProperties: false
+
+    properties:
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+
+      reg:
+        maxItems: 1
+
+      resets:
+        maxItems: 1
+
+      gpio-line-names: true
+
+      st,bank-name:
+        description:
+          Should be a name string for this bank as specified in the datasheet.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - PIO0
+          - PIO1
+          - PIO2
+          - PIO3
+          - PIO4
+          - PIO5
+          - PIO10
+          - PIO11
+          - PIO12
+          - PIO13
+          - PIO14
+          - PIO15
+          - PIO16
+          - PIO17
+          - PIO18
+          - PIO19
+          - PIO20
+          - PIO30
+          - PIO31
+          - PIO32
+          - PIO33
+          - PIO34
+          - PIO35
+          - PIO40
+          - PIO41
+          - PIO42
+
+      st,retime-pin-mask:
+        description:
+          Should be mask to specify which pins can be retimed.
+          If the property is not present, it is assumed that all the pins in the
+          bank are capable of retiming. Retiming is mainly used to improve the
+          IO timing margins of external synchronous interfaces.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 63
+
+    patternProperties:
+      "^(.+-hog(-[0-9]+)?)$":
+        type: object
+        required:
+          - gpio-hog
+
+    required:
+      - gpio-controller
+      - '#gpio-cells'
+      - reg
+      - st,bank-name
+
+  # Explicitly match all other nodes, EXCEPT the gpio nodes
+  # these contain the actual pin control states
+  '^(cec|rc|sbc_serial|i2c|keyscan|gmac|pwm|spi|serial|mmc|tsin|tsout|mtsin|systrace|usb|i2s_out|i2s_in|spdif_out|fsm|nand)[0-9]*$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '[-_0-9a-z]+$':
+        type: object
+        additionalProperties: false
+
+        patternProperties:
+          '^st,pins':
+            type: object
+            additionalProperties: false
+            description: The st,pins is a custom key equals value list. The value
+              is a phandle with 4 or 7 parameters.
+
+            patternProperties:
+              ^[-_0-9a-zA-Z]+$:
+                description: the parameters to the phandle configures the pin.
+                   Arg 0 = pio node phandle for the bank of the pin
+                   Arg 1 = pin offset for the pin in the pio unit
+                   Arg 2 = mux alternate function taken from the datasheet
+                   Arg 3 = pin configuration mode for the pin, bits for a register
+                   Arg 5 = retiming configuration for the pin
+                   Arg 6 = retiming delay in picoseconds
+                   Arg 7 = retiming clock to be used for the delay
+                $ref: /schemas/types.yaml#/definitions/phandle-array
+                minItems: 1
+                maxItems: 1
+                items:
+                  minItems: 4
+                  maxItems: 7
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - reg
+  - reg-names
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@961f080 {
+      compatible = "st,stih407-sbc-pinctrl";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      st,syscfg = <&syscfg_sbc>;
+      reg = <0x0961f080 0x4>;
+      reg-names = "irqmux";
+      interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "irqmux";
+      ranges = <0 0x09610000 0x6000>;
+
+      pio0: gpio@9610000 {
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x0 0x100>;
+        st,bank-name = "PIO0";
+      };
+
+      sbc_serial0 {
+        pinctrl_sbc_serial0: sbc_serial0-0 {
+          st,pins {
+            tx = <&pio0 4 1 (1 << 27)>;
+            rx = <&pio0 5 1 0>;
+          };
+        };
+      };
+    };
+...

---
base-commit: d6f3b83206bdbd9b969663f0eeedd963bdc13fcb
change-id: 20230810-dt-bindings-sti-644ff6350456

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

