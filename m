Return-Path: <linux-kernel+bounces-15570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF59822E48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270992857A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4019BD9;
	Wed,  3 Jan 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="elEQX34n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA419BB1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0656F3F5B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704288536;
	bh=lN7QxaajzrvpBlbQTOF6hDrc4xdY0uP48KXpLPsfjdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=elEQX34nii3FKdMNl/er+QN4I7Q8LEk7QOLGW30Cc7B6Znc6cLV0MlqJt+aI0ghoD
	 bwdd7q5HiuDKcmur1OCI/rs81DCt5K9RdCTaUqIymFc2HQwHjJhRpDuM7IkUk2J2Iu
	 oiqMtFX9cBfYI1sAVBc8sxa3/0+9CngJRyky/0N4UP3eoFEVeGJKc1Gt5Ax5d5LNqd
	 zzjReiGhvZB5LDPBEffjbxaU0OhtjIXdPaVoMkWDBdYgjpWPcmzsa19iy5jLtWcycB
	 tjDgKpYke5xWMXSIGOD3/rnvmNlNFp1HVDLH8yJTov8PqOTyguJCPCGyAN71Xo3n3E
	 R7qsMfUa2ZXMw==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e55470b49so8150396e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288535; x=1704893335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN7QxaajzrvpBlbQTOF6hDrc4xdY0uP48KXpLPsfjdI=;
        b=Jpgd9CQaNazhFpVDWLNF4DKAly+9Oqm88kwsskVLJFhA2cHmcIS79LG8jc5U06jqSA
         cLdhKOMnFWx/eJKs+KnnV501F/jtPi/51seTIX7b8xwSvUdhtOWeMxhVCznTQpO+/KV1
         hn6ZDaJAYwKlkPdyYWCCyU/KagirSraobDQwb86CoKHVw/iw+Gq0FwIOJ3mS2L8YIsiH
         txTFnvmy0gPOXdtKHuwMnmkCxGawXc6enU2bNnOgViS7mz7jZWv4tjJ3JeSMSqjFfPc6
         xjEO4mxa9K3mRoAelH61ELumzqzDiRBc31bgdGQ4AtHuiOyPjFrGArwfa0Sdse+NGeqZ
         J37A==
X-Gm-Message-State: AOJu0YyYabkny4FPcYZe2Z7mQ4WncETy/0DrN9MDt3XlhiFvYRPL/myj
	7JMAcX31qatjrwmAp8BuyW6q6Wvyzf/7NMHFCJvR1Ua0xwH3n6xgO86I0rDtdzW/laVgt4e6eUB
	wK518aBjrnM7ecBG3UG8YVrH9tWr/Vfnfm5+U3KtQnVgmeaWIdH+zZovm
X-Received: by 2002:a05:6512:3e10:b0:50e:815f:50d1 with SMTP id i16-20020a0565123e1000b0050e815f50d1mr5797352lfv.105.1704288534878;
        Wed, 03 Jan 2024 05:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt1Eu/ihnqJcTy9xJ3HzcwJWfnNjjiBgAIOs526DjSHN+s/rQtmU3iRfzWNow4FzuYEHUttA==
X-Received: by 2002:a05:6512:3e10:b0:50e:815f:50d1 with SMTP id i16-20020a0565123e1000b0050e815f50d1mr5797342lfv.105.1704288534499;
        Wed, 03 Jan 2024 05:28:54 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:5af0:999b:bb78:7614])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm9549873ejc.44.2024.01.03.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:54 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
Date: Wed,  3 Jan 2024 14:28:38 +0100
Message-ID: <20240103132852.298964-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the pin controllers on the T-Head TH1520 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../pinctrl/thead,th1520-pinctrl.yaml         | 372 ++++++++++++++++++
 1 file changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
new file mode 100644
index 000000000000..d3ad7a7cfdd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
@@ -0,0 +1,372 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/thead,th1520-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-Head TH1520 SoC pin controller
+
+maintainers:
+  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
+
+description: |
+  Pinmux and pinconf controller in the T-Head TH1520 RISC-V SoC.
+
+  The TH1520 has 3 groups of pads each controlled from different memory ranges.
+  Confusingly the memory ranges are named
+    PADCTRL_AOSYS  -> PAD Group 1
+    PADCTRL1_APSYS -> PAD Group 2
+    PADCTRL0_APSYS -> PAD Group 3
+
+  Each pad can be muxed individually to up to 6 different functions. For most
+  pads only a few of those 6 configurations are valid though, and a few pads in
+  group 1 does not support muxing at all.
+
+  Pinconf is fairly regular except for a few pads in group 1 that either can't
+  be configured or has some special functions. The rest have configurable drive
+  strength, input enable, schmitt trigger, slew rate, pull-up and pull-down in
+  addition to a special strong pull up.
+
+  Certain pads in group 1 can be muxed to AUDIO_PA0 - AUDIO_PA30 functions and
+  are then meant to be used by the audio co-processor. Each such pad can then
+  be further muxed to either audio GPIO or one of 4 functions such as UART, I2C
+  and I2S. If the audio pad is muxed to one of the 4 functions then pinconf is
+  also configured in different registers. All of this is done from a different
+  AUDIO_IOCTRL memory range and is left to the audio co-processor for now.
+
+properties:
+  compatible:
+    enum:
+      - thead,th1520-group1-pinctrl
+      - thead,th1520-group2-pinctrl
+      - thead,th1520-group3-pinctrl
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+
+    additionalProperties: false
+
+    patternProperties:
+      '-pins$':
+        type: object
+        $ref: /schemas/pinctrl/pincfg-node.yaml
+
+        additionalProperties: false
+
+        description:
+          A pinctrl node should contain at least one subnode describing one
+          or more pads and their associated pinmux and pinconf settings.
+
+        properties:
+          pins:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
+            description: List of pads that properties in the node apply to.
+
+          function:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/function
+            enum: [ gpio, pwm, uart, ir, i2c, spi, qspi, sdio, audio, i2s,
+                    gmac0, gmac1, dpu0, dpu1, isp, hdmi, bootsel, debug,
+                    clock, jtag, iso7816, efuse, reset ]
+            description: The mux function to select for the given pins.
+
+          bias-disable: true
+
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+                description: Enable the regular 48kOhm pull-up
+              - enum: [ 2100, 48000 ]
+                description: Enable the strong 2.1kOhm pull-up or regular 48kOhm pull-up
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - const: 44000
+            description: Enable the regular 44kOhm pull-down
+
+          drive-strength:
+            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25 ]
+            description: Drive strength in mA
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            maximum: 1
+
+        required:
+          - pins
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - $ref: pinctrl.yaml#
+  - if:
+      properties:
+        compatible:
+          const: thead,th1520-group1-pinctrl
+    then:
+      patternProperties:
+        '-[0-9]+$':
+          patternProperties:
+            '-pins$':
+              properties:
+                pins:
+                  items:
+                    enum:
+                      - OSC_CLK_IN
+                      - OSC_CLK_OUT
+                      - SYS_RST_N
+                      - RTC_CLK_IN
+                      - RTC_CLK_OUT
+                      - TEST_MODE
+                      - DEBUG_MODE
+                      - POR_SEL
+                      - I2C_AON_SCL
+                      - I2C_AON_SDA
+                      - CPU_JTG_TCLK
+                      - CPU_JTG_TMS
+                      - CPU_JTG_TDI
+                      - CPU_JTG_TDO
+                      - CPU_JTG_TRST
+                      - AOGPIO_7
+                      - AOGPIO_8
+                      - AOGPIO_9
+                      - AOGPIO_10
+                      - AOGPIO_11
+                      - AOGPIO_12
+                      - AOGPIO_13
+                      - AOGPIO_14
+                      - AOGPIO_15
+                      - AUDIO_PA0
+                      - AUDIO_PA1
+                      - AUDIO_PA2
+                      - AUDIO_PA3
+                      - AUDIO_PA4
+                      - AUDIO_PA5
+                      - AUDIO_PA6
+                      - AUDIO_PA7
+                      - AUDIO_PA8
+                      - AUDIO_PA9
+                      - AUDIO_PA10
+                      - AUDIO_PA11
+                      - AUDIO_PA12
+                      - AUDIO_PA13
+                      - AUDIO_PA14
+                      - AUDIO_PA15
+                      - AUDIO_PA16
+                      - AUDIO_PA17
+                      - AUDIO_PA27
+                      - AUDIO_PA28
+                      - AUDIO_PA29
+                      - AUDIO_PA30
+  - if:
+      properties:
+        compatible:
+          const: thead,th1520-group2-pinctrl
+    then:
+      patternProperties:
+        '-[0-9]+$':
+          patternProperties:
+            '-pins$':
+              properties:
+                pins:
+                  items:
+                    enum:
+                      - QSPI1_SCLK
+                      - QSPI1_CSN0
+                      - QSPI1_D0_MOSI
+                      - QSPI1_D1_MISO
+                      - QSPI1_D2_WP
+                      - QSPI1_D3_HOLD
+                      - I2C0_SCL
+                      - I2C0_SDA
+                      - I2C1_SCL
+                      - I2C1_SDA
+                      - UART1_TXD
+                      - UART1_RXD
+                      - UART4_TXD
+                      - UART4_RXD
+                      - UART4_CTSN
+                      - UART4_RTSN
+                      - UART3_TXD
+                      - UART3_RXD
+                      - GPIO0_18
+                      - GPIO0_19
+                      - GPIO0_20
+                      - GPIO0_21
+                      - GPIO0_22
+                      - GPIO0_23
+                      - GPIO0_24
+                      - GPIO0_25
+                      - GPIO0_26
+                      - GPIO0_27
+                      - GPIO0_28
+                      - GPIO0_29
+                      - GPIO0_30
+                      - GPIO0_31
+                      - GPIO1_0
+                      - GPIO1_1
+                      - GPIO1_2
+                      - GPIO1_3
+                      - GPIO1_4
+                      - GPIO1_5
+                      - GPIO1_6
+                      - GPIO1_7
+                      - GPIO1_8
+                      - GPIO1_9
+                      - GPIO1_10
+                      - GPIO1_11
+                      - GPIO1_12
+                      - GPIO1_13
+                      - GPIO1_14
+                      - GPIO1_15
+                      - GPIO1_16
+                      - CLK_OUT_0
+                      - CLK_OUT_1
+                      - CLK_OUT_2
+                      - CLK_OUT_3
+                      - GPIO1_21
+                      - GPIO1_22
+                      - GPIO1_23
+                      - GPIO1_24
+                      - GPIO1_25
+                      - GPIO1_26
+                      - GPIO1_27
+                      - GPIO1_28
+                      - GPIO1_29
+                      - GPIO1_30
+  - if:
+      properties:
+        compatible:
+          const: thead,th1520-group3-pinctrl
+    then:
+      patternProperties:
+        '-[0-9]+$':
+          patternProperties:
+            '-pins$':
+              properties:
+                pins:
+                  items:
+                    enum:
+                      - UART0_TXD
+                      - UART0_RXD
+                      - QSPI0_SCLK
+                      - QSPI0_CSN0
+                      - QSPI0_CSN1
+                      - QSPI0_D0_MOSI
+                      - QSPI0_D1_MISO
+                      - QSPI0_D2_WP
+                      - QSPI1_D3_HOLD
+                      - I2C2_SCL
+                      - I2C2_SDA
+                      - I2C3_SCL
+                      - I2C3_SDA
+                      - GPIO2_13
+                      - SPI_SCLK
+                      - SPI_CSN
+                      - SPI_MOSI
+                      - SPI_MISO
+                      - GPIO2_18
+                      - GPIO2_19
+                      - GPIO2_20
+                      - GPIO2_21
+                      - GPIO2_22
+                      - GPIO2_23
+                      - GPIO2_24
+                      - GPIO2_25
+                      - SDIO0_WPRTN
+                      - SDIO0_DETN
+                      - SDIO1_WPRTN
+                      - SDIO1_DETN
+                      - GPIO2_30
+                      - GPIO2_31
+                      - GPIO3_0
+                      - GPIO3_1
+                      - GPIO3_2
+                      - GPIO3_3
+                      - HDMI_SCL
+                      - HDMI_SDA
+                      - HDMI_CEC
+                      - GMAC0_TX_CLK
+                      - GMAC0_RX_CLK
+                      - GMAC0_TXEN
+                      - GMAC0_TXD0
+                      - GMAC0_TXD1
+                      - GMAC0_TXD2
+                      - GMAC0_TXD3
+                      - GMAC0_RXDV
+                      - GMAC0_RXD0
+                      - GMAC0_RXD1
+                      - GMAC0_RXD2
+                      - GMAC0_RXD3
+                      - GMAC0_MDC
+                      - GMAC0_MDIO
+                      - GMAC0_COL
+                      - GMAC0_CRS
+
+examples:
+  - |
+    padctrl0_apsys: pinctrl@ec007000 {
+        compatible = "thead,th1520-group3-pinctrl";
+        reg = <0xec007000 0x1000>;
+        clocks = <&apb_clk>;
+
+        uart0_pins: uart0-0 {
+            tx-pins {
+                pins = "UART0_TXD";
+                function = "uart";
+                bias-disable;
+                drive-strength = <3>;
+                input-disable;
+                input-schmitt-disable;
+                slew-rate = <0>;
+            };
+
+            rx-pins {
+                pins = "UART0_RXD";
+                function = "uart";
+                bias-disable;
+                drive-strength = <1>;
+                input-enable;
+                input-schmitt-enable;
+                slew-rate = <0>;
+            };
+        };
+    };
+
+    padctrl1_apsys: pinctrl@e7f3c000 {
+        compatible = "thead,th1520-group2-pinctrl";
+        reg = <0xe7f3c000 0x1000>;
+        clocks = <&apb_clk>;
+
+        i2c5_pins: i2c5-0 {
+            i2c-pins {
+                pins = "QSPI1_CSN0",    /* I2C5_SCL */
+                       "QSPI1_D0_MOSI"; /* I2C5_SDA */
+                function = "i2c";
+                bias-pull-up = <2100>;
+                drive-strength = <7>;
+                input-enable;
+                input-schmitt-enable;
+                slew-rate = <0>;
+            };
+        };
+    };
-- 
2.43.0


