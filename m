Return-Path: <linux-kernel+bounces-7998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14C81B065
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1043628586B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C091772A;
	Thu, 21 Dec 2023 08:36:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51BB168B4;
	Thu, 21 Dec 2023 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id A0DA424E24C;
	Thu, 21 Dec 2023 16:36:38 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:38 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:31 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, "Ley
 Foon Tan" <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Drew Fustini" <drew@beagleboard.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100 pinctrl bindings
Date: Thu, 21 Dec 2023 16:36:17 +0800
Message-ID: <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add dt-binding documentation and header file for JH8100 pinctrl
driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  | 183 +++++++++++
 .../starfive,jh8100-sys-east-pinctrl.yaml     | 188 +++++++++++
 .../starfive,jh8100-sys-gmac-pinctrl.yaml     | 124 +++++++
 .../starfive,jh8100-sys-west-pinctrl.yaml     | 188 +++++++++++
 .../pinctrl/starfive,jh8100-pinctrl.h         | 303 ++++++++++++++++++
 5 files changed, 986 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-east-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-gmac-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-west-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-ao=
n-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh810=
0-aon-pinctrl.yaml
new file mode 100644
index 000000000000..ec099a0d4c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinct=
rl.yaml
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-aon-pinctrl.y=
aml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 AON Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, a=
nd aon.
+  This document provides an overview of the "aon" pinctrl domain.
+
+  The "aon" pinctrl domain contains a pin controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - function selection for GMAC0 interface modes.
+  - GPIO pins which support external GPIO interrupts or external wake-up=
.
+  - syscon for device reference voltage.
+
+  In the AON Pin Controller, the pins named PAD_RGPIO0 to PAD_GPIO15 can=
 be
+  multiplexed and have configurable bias, drive strength, schmitt trigge=
r etc.
+  Only peripherals in the AON domain can have their I/O go through the 1=
6
+  "PAD_RGPIOs". This includes I2C, UART, watchdog, eMMC, SDIO0, XSPI etc=
.
+
+  All these peripherals can be connected to any of the 16 PAD_RGPIOs in =
such a way
+  that any iopad can be set up to be controlled by any of the peripheral=
s.
+
+  The pin muxing is illustrated by the diagram below.
+                          _____________
+                         |             |
+    RGPIO0 --------------|             |--- PAD_RGPIO0
+    RGPIO1 --------------| AON I/O MUX |--- PAD_RGPIO1
+      ...                |             |       ...
+    I2C8 SDA interface --|             |--- PAD_RGPIO15
+                         |             |
+                          -------------
+
+  Alternatively, the "PAD_RGPIOS" can be multiplexed to other peripheral=
s through
+  function selection. Each iopad has a maximum of up to 3 functions - 0,=
 1, and 2.
+  Function 0 is the default function or peripheral signal of an iopad.
+  The function 1 and function 2 are other optional functions or peripher=
al signals
+  available to an iopad.
+
+  The AON Pin Controller provides regmap based syscon to configure
+
+  1. reference voltage level of
+  - eMMC I/O interface (1.8V)
+  - SDIO0 I/O interface (3.3V, 1.8V)
+  - RGPIO bank (3.3V)
+        - Each RGPIO in the RGPIO bank share the same voltage level
+  - GMAC0 (3.3V, 2.5V, 1.8V)
+        - RMII mode,  DVDD 2.5V/3.3V
+        - RGMII mode, DVDD 1.8V/2.5V
+  - XSPI (3.3V)
+
+  Voltage regulator supply the actual voltage to the device while the sy=
scon register
+  configuration in bit [1:0] indicates the current voltage setting.
+
+  +------+------+-------------------+
+  | Bit1 | Bit0 | Reference Voltage |
+  +------+------+-------------------+
+  |  0   |  0   |     3.3 V         |
+  +------+------+-------------------+
+  |  0   |  1   |     2.5 V         |
+  +------+------+-------------------+
+  |  1   |  x   |     1.8 V         |
+  +------+------+-------------------+
+
+  To increase the device voltage, set bit [1:0] to the new operating sta=
te first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operatin=
g state until
+  the actual voltage has stabilized at the lower operating point before =
changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by firs=
t setting syscon
+  register bit [1:0] =3D 0, the safe 3.3V startup condition, before chan=
ging the device
+  voltage. Then once the actual voltage is changed and has stabilized at=
 the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-aon-pinctrl
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representin=
g the
+          pinctrl groups available in the domain. Each subnode will list=
 the
+          pins it needs, and how they should be configured, with regard =
to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        additionalProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function selec=
t.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength:
+            enum: [ 2, 4, 8, 12 ]
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
+required:
+  - compatible
+  - reg
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100.h>
+    #include <dt-bindings/reset/starfive-jh8100.h>
+    #include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        pinctrl_aon: pinctrl@1f300000 {
+                compatible =3D "starfive,jh8100-aon-pinctrl",
+                             "syscon", "simple-mfd";
+                reg =3D <0x0 0x1f300000 0x0 0x10000>;
+                resets =3D <&aoncrg 0>;
+                interrupts =3D <160>;
+                interrupt-controller;
+                gpio-controller;
+                #gpio-cells =3D <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sy=
s-east-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,=
jh8100-sys-east-pinctrl.yaml
new file mode 100644
index 000000000000..849fc19558af
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-=
pinctrl.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-east-pinc=
trl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_EAST Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, a=
nd aon.
+  This document provides an overview of the "sys_east" pinctrl domain.
+
+  The "sys_east" pinctrl domain contains a pin controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - function selection for GPIO pads.
+  - GPIO interrupt handling.
+  - syscon for device voltage reference.
+
+  In the SYS_EAST Pin Controller, the pins named PAD_GPIO0_E to PAD_GPIO=
47_E can
+  be multiplexed and have configurable bias, drive strength, schmitt tri=
gger etc.
+  Only peripherals in the SYS_EAST domain can have their I/O go through =
the 48
+  "PAD_GPIOs". This includes CANs, I2Cs, I2Ss, SPIs, UARTs, PWMs, SMBUS0=
, SDIO1 etc.
+
+  All these peripherals can be connected to any of the 48 PAD_GPIOs in s=
uch a way
+  that any iopad can be set up to be controlled by any of the peripheral=
s.
+
+  The pin muxing is illustrated by the diagram below.
+                                 __________________
+                                |                  |
+    GPIO0 ----------------------|                  |--- PAD_GPIO0_E
+    GPIO1 ----------------------| SYS_EAST I/O MUX |--- PAD_GPIO1_E
+    GPIO2 ----------------------|                  |--- PAD_GPIO2_E
+      ...                       |                  |      ...
+    I2C0 Clock interface -------|                  |--- PAD_GPIO9_E
+    I2C0 Data interface  -------|                  |--- PAD_GPIO10_E
+      ...                       |                  |      ...
+    UART0 transmit interface ---|                  |--- PAD_GPIO20_E
+    UART0 receive interface ----|                  |--- PAD_GPIO21_E
+      ...                       |                  |       ...
+    GPIO47 ---------------------|                  |--- PAD_GPIO47_E
+                                |                  |
+                                 ------------------
+
+  Alternatively, the "PAD_GPIOs" can be multiplexed to other peripherals=
 through
+  function selection. Each iopad has a maximum of up to 3 functions - 0,=
 1, and 2.
+  Function 0 is the default function or peripheral signal of an iopad.
+  The function 1 and function 2 are other optional functions or peripher=
al signals
+  available to an iopad.
+
+  The "sys_east" pinctrl domain has 4 GPIO banks - E0, E1, E2, and E3. E=
ach GPIO bank
+  can be set to a different voltage level (3.3V or 1.8V) while GPIOs in =
the same bank
+  will share the same voltage level.
+
+  The SYS_EAST Pin Controller provides regmap based syscon registers to =
configure the
+  reference voltage level in each GPIO bank.
+
+  Voltage regulator supply the actual voltage to the GPIO bank while the=
 syscon register
+  configuration in bit [1:0] indicates the current voltage setting.
+
+  +------+------+-------------------+
+  | Bit1 | Bit0 | Reference Voltage |
+  +------+------+-------------------+
+  |  0   |  0   |     3.3 V         |
+  +------+------+-------------------+
+  |  1   |  x   |     1.8 V         |
+  +------+------+-------------------+
+
+  To increase the device voltage, set bit [1:0] to the new operating sta=
te first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operatin=
g state until
+  the actual voltage has stabilized at the lower operating point before =
changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by firs=
t setting syscon
+  register bit [1:0] =3D 0, the safe 3.3V startup condition, before chan=
ging the device
+  voltage. Then once the actual voltage is changed and has stabilized at=
 the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-sys-pinctrl-east
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representin=
g the
+          pinctrl groups available in the domain. Each subnode will list=
 the
+          pins it needs, and how they should be configured, with regard =
to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        additionalProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function selec=
t.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength:
+            enum: [ 2, 4, 8, 12 ]
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100.h>
+    #include <dt-bindings/reset/starfive-jh8100.h>
+    #include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        pinctrl_east: pinctrl@122d0000 {
+            compatible =3D "starfive,jh8100-sys-pinctrl-east",
+                         "syscon", "simple-mfd";
+            reg =3D <0x0 0x122d0000 0x0 0x10000>;
+            clocks =3D <&syscrg_ne 153>;
+            resets =3D <&syscrg_ne 48>;
+            interrupts =3D <182>;
+            interrupt-controller;
+            gpio-controller;
+            #gpio-cells =3D <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sy=
s-gmac-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,=
jh8100-sys-gmac-pinctrl.yaml
new file mode 100644
index 000000000000..301690456e40
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-=
pinctrl.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-gmac-pinc=
trl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_GMAC Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, a=
nd aon.
+  This document provides an overview of the "sys_gmac" pinctrl domain.
+
+  The "sys_gmac" pinctrl domain contains a pin-controller which provides
+  - function selection for GMAC1 interface modes.
+  - syscon for device voltage reference.
+  - syscon for GMAC modes and slew rate control.
+
+  The SYS_GMAC Pin Controller does not have any PAD_GPIOs, therefore, it=
 does not
+  support the GPIO pads' I/O Multiplexing and interrupt handling.
+
+  The SYS_GMAC Pin Controller provides regmap based syscon to configure
+
+  1. reference voltage level of
+  - SDIO1 (3.3V, 1.8V)
+  - GMAC1 (3.3V, 2.5V, 1.8V)
+        - RMII mode,  DVDD 2.5V/3.3V
+        - RGMII mode, DVDD 1.8V/2.5V
+
+  +------+------+-------------------+
+  | Bit1 | Bit0 | Reference Voltage |
+  +------+------+-------------------+
+  |  0   |  0   |     3.3 V         |
+  +------+------+-------------------+
+  |  0   |  1   |     2.5 V         |
+  +------+------+-------------------+
+  |  1   |  x   |     1.8 V         |
+  +------+------+-------------------+
+
+  To increase the device voltage, set bit [1:0] to the new operating sta=
te first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operatin=
g state until
+  the actual voltage has stabilized at the lower operating point before =
changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by firs=
t setting syscon
+  register bit [1:0] =3D 0, the safe 3.3V startup condition, before chan=
ging the device
+  voltage. Then once the actual voltage is changed and has stabilized at=
 the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+  2. GMAC1 interface slew rate
+
+  +------+-----------+
+  | Bit2 | Slew Rate |
+  +------+-----------+
+  |  0   |   Fast    |
+  +------+-----------+
+  |  1   |   Slow    |
+  +------+-----------+
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-sys-pinctrl-gmac
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representin=
g the
+          pinctrl groups available in the domain. Each subnode will list=
 the
+          pins it needs, and how they should be configured, with regard =
to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100.h>
+    #include <dt-bindings/reset/starfive-jh8100.h>
+    #include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        pinctrl_gmac: pinctrl@12770000 {
+            compatible =3D "starfive,jh8100-sys-pinctrl-gmac",
+                         "syscon", "simple-mfd";
+            status =3D "disabled";
+            reg =3D <0x0 0x12770000 0x0 0x10000>;
+            clocks =3D <&gmac_sdio_crg 16>;
+            resets =3D <&gmac_sdio_crg 3>;
+        };
+
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sy=
s-west-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,=
jh8100-sys-west-pinctrl.yaml
new file mode 100644
index 000000000000..608acb76230c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-=
pinctrl.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-west-pinc=
trl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_WEST Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, a=
nd aon.
+  This document provides an overview of the "sys_west" pinctrl domain.
+
+  The "sys_west" pinctrl domain contains a pin-controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - function selection for GPIO pads.
+  - GPIO interrupt handling.
+  - syscon for device voltage reference.
+
+  In the SYS_WEST Pin Controller, the pins named PAD_GPIO0_W to PAD_GPIO=
15_W can
+  be multiplexed and have configurable bias, drive strength, schmitt tri=
gger etc.
+  Only peripherals in the SYS_WEST domain can have their I/O go through =
the 16
+  "PAD_GPIOs". This includes I2Cs, HD_AUDIO, HIFI4, SPIs, UARTs, SMBUS1 =
etc.
+
+  All these peripherals can be connected to any of the 16 PAD_GPIOs in s=
uch a way
+  that any iopad can be set up to be controlled by any of the peripheral=
s.
+
+  The pin muxing is illustrated by the diagram below.
+                                 __________________
+                                |                  |
+    GPIO0 ----------------------|                  |--- PAD_GPIO0_W
+    GPIO1 ----------------------| SYS_WEST I/O MUX |--- PAD_GPIO1_W
+    GPIO2 ----------------------|                  |--- PAD_GPIO2_W
+      ...                       |                  |      ...
+    HIFI4 JTAG TDO interface ---|                  |--- PAD_GPIO10_W
+    HIFI4 JTAG TDI interface ---|                  |--- PAD_GPIO11_W
+    SMBUS1 Data interface  -----|                  |--- PAD_GPIO12_W
+    SMBUS1 Clock interface -----|                  |--- PAD_GPIO13_W
+      ...                       |                  |      ...
+    GPIO14 ---------------------|                  |--- PAD_GPIO14_W
+    GPIO15 ---------------------|                  |--- PAD_GPIO15_W
+                                |                  |
+                                 ------------------
+
+  Alternatively, the "PAD_GPIOs" can be multiplexed to other peripherals=
 through
+  function selection. Each iopad has a maximum of up to 3 functions - 0,=
 1, and 2.
+  Function 0 is the default function or peripheral signal of an iopad.
+  The function 1 and function 2 are other optional functions or peripher=
al signals
+  available to an iopad.
+
+  The "sys_west" pinctrl domain consist of 1 GPIO bank. The GPIO bank ca=
n be set to
+  a different voltage level (3.3V or 1.8V) while GPIOs in the same bank =
will share
+  the same voltage level.
+
+  The SYS_WEST Pin Controller provides regmap based syscon registers to =
configure the
+  reference voltage level in the GPIO bank.
+
+  Voltage regulator supply the actual voltage to the GPIO bank while the=
 syscon register
+  configuration in bit [1:0] indicates the current voltage setting.
+
+  +------+------+-------------------+
+  | Bit1 | Bit0 | Reference Voltage |
+  +------+------+-------------------+
+  |  0   |  0   |     3.3 V         |
+  +------+------+-------------------+
+  |  1   |  x   |     1.8 V         |
+  +------+------+-------------------+
+
+  To increase the device voltage, set bit [1:0] to the new operating sta=
te first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operatin=
g state until
+  the actual voltage has stabilized at the lower operating point before =
changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by firs=
t setting syscon
+  register bit [1:0] =3D 0, the safe 3.3V startup condition, before chan=
ging the device
+  voltage. Then once the actual voltage is changed and has stabilized at=
 the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-sys-pinctrl-west
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representin=
g the
+          pinctrl groups available in the domain. Each subnode will list=
 the
+          pins it needs, and how they should be configured, with regard =
to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        additionalProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function selec=
t.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength:
+            enum: [ 2, 4, 8, 12 ]
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100.h>
+    #include <dt-bindings/reset/starfive-jh8100.h>
+    #include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        pinctrl_west: pinctrl@123e0000 {
+            compatible =3D "starfive,jh8100-sys-pinctrl-west",
+                         "syscon", "simple-mfd";
+            interrupts =3D <183>;
+            reg =3D <0x0 0x123e0000 0x0 0x10000>;
+            clocks =3D <&syscrg_nw 6>;
+            resets =3D <&syscrg_nw 1>;
+            interrupt-controller;
+            gpio-controller;
+            #gpio-cells =3D <2>;
+        };
+    };
diff --git a/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
new file mode 100644
index 000000000000..c57b7ece37a2
--- /dev/null
+++ b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+
+/* sys_iomux_west pins */
+#define PAD_GPIO0_W				0
+#define PAD_GPIO1_W				1
+#define PAD_GPIO2_W				2
+#define PAD_GPIO3_W				3
+#define PAD_GPIO4_W				4
+#define PAD_GPIO5_W				5
+#define PAD_GPIO6_W				6
+#define PAD_GPIO7_W				7
+#define PAD_GPIO8_W				8
+#define PAD_GPIO9_W				9
+#define PAD_GPIO10_W				10
+#define PAD_GPIO11_W				11
+#define PAD_GPIO12_W				12
+#define PAD_GPIO13_W				13
+#define PAD_GPIO14_W				14
+#define PAD_GPIO15_W				15
+
+/* sys_iomux_west syscon */
+#define SYS_W_VREF_GPIO_W_SYSCON_REG		0x6c
+#define SYS_W_VREF_GPIO_W_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_W_VREF_GPIO_W_SYSCON_SHIFT		0
+#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_REG	0x70
+#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_MASK	GENMASK(1, 0)
+#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_SHIFT	0
+
+/* sys_iomux_east pins */
+#define PAD_GPIO0_E				0
+#define PAD_GPIO1_E				1
+#define PAD_GPIO2_E				2
+#define PAD_GPIO3_E				3
+#define PAD_GPIO4_E				4
+#define PAD_GPIO5_E				5
+#define PAD_GPIO6_E				6
+#define PAD_GPIO7_E				7
+#define PAD_GPIO8_E				8
+#define PAD_GPIO9_E				9
+#define PAD_GPIO10_E				10
+#define PAD_GPIO11_E				11
+#define PAD_GPIO12_E				12
+#define PAD_GPIO13_E				13
+#define PAD_GPIO14_E				14
+#define PAD_GPIO15_E				15
+#define PAD_GPIO16_E				16
+#define PAD_GPIO17_E				17
+#define PAD_GPIO18_E				18
+#define PAD_GPIO19_E				19
+#define PAD_GPIO20_E				20
+#define PAD_GPIO21_E				21
+#define PAD_GPIO22_E				22
+#define PAD_GPIO23_E				23
+#define PAD_GPIO24_E				24
+#define PAD_GPIO25_E				25
+#define PAD_GPIO26_E				26
+#define PAD_GPIO27_E				27
+#define PAD_GPIO28_E				28
+#define PAD_GPIO29_E				29
+#define PAD_GPIO30_E				30
+#define PAD_GPIO31_E				31
+#define PAD_GPIO32_E				32
+#define PAD_GPIO33_E				33
+#define PAD_GPIO34_E				34
+#define PAD_GPIO35_E				35
+#define PAD_GPIO36_E				36
+#define PAD_GPIO37_E				37
+#define PAD_GPIO38_E				38
+#define PAD_GPIO39_E				39
+#define PAD_GPIO40_E				40
+#define PAD_GPIO41_E				41
+#define PAD_GPIO42_E				42
+#define PAD_GPIO43_E				43
+#define PAD_GPIO44_E				44
+#define PAD_GPIO45_E				45
+#define PAD_GPIO46_E				46
+#define PAD_GPIO47_E				47
+
+/* sys_iomux_east syscon */
+#define SYS_E_VREF_GPIO_E0_SYSCON_REG		0x0fc
+#define SYS_E_VREF_GPIO_E0_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_GPIO_E0_SYSCON_SHIFT		0
+#define SYS_E_VREF_GPIO_E1_SYSCON_REG		0x100
+#define SYS_E_VREF_GPIO_E1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_GPIO_E1_SYSCON_SHIFT		0
+#define SYS_E_VREF_GPIO_E2_SYSCON_REG		0x104
+#define SYS_E_VREF_GPIO_E2_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_GPIO_E2_SYSCON_SHIFT		0
+#define SYS_E_VREF_GPIO_E3_SYSCON_REG		0x108
+#define SYS_E_VREF_GPIO_E3_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_GPIO_E3_SYSCON_SHIFT		0
+#define SYS_E_VREF_ATB_STG1_SYSCON_REG		0x10c
+#define SYS_E_VREF_ATB_STG1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_ATB_STG1_SYSCON_SHIFT	0
+#define SYS_E_VREF_ATB_USB_SYSCON_REG		0x110
+#define SYS_E_VREF_ATB_USB_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_E_VREF_ATB_USB_SYSCON_SHIFT		0
+
+/* sys_iomux_gmac pins */
+#define PAD_GMAC1_MDC				0
+#define PAD_GMAC1_MDIO				1
+#define PAD_GMAC1_RXD0				2
+#define PAD_GMAC1_RXD1				3
+#define PAD_GMAC1_RXD2				4
+#define PAD_GMAC1_RXD3				5
+#define PAD_GMAC1_RXDV				6
+#define PAD_GMAC1_RXC				7
+#define PAD_GMAC1_TXD0				8
+#define PAD_GMAC1_TXD1				9
+#define PAD_GMAC1_TXD2				10
+#define PAD_GMAC1_TXD3				11
+#define PAD_GMAC1_TXEN				12
+#define PAD_GMAC1_TXC				13
+
+/* sys_iomux_gmac vref syscon registers */
+#define SYS_G_VREF_GMAC1_SYSCON_REG		0x08
+#define SYS_G_VREF_GMAC1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_VREF_GMAC1_SYSCON_SHIFT		0
+#define SYS_G_VREF_SDIO1_SYSCON_REG		0x0c
+#define SYS_G_VREF_SDIO1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_VREF_SDIO1_SYSCON_SHIFT		0
+
+/* sys_iomux_gmac interface (rmii/rgmii) syscon registers */
+#define SYS_G_GMAC1_MDC_SYSCON_REG		0x10
+#define SYS_G_GMAC1_MDC_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_MDC_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_MDIO_SYSCON_REG		0x14
+#define SYS_G_GMAC1_MDIO_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_MDIO_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXD0_SYSCON_REG		0x18
+#define SYS_G_GMAC1_RXD0_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXD0_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXD1_SYSCON_REG		0x1c
+#define SYS_G_GMAC1_RXD1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXD1_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXD2_SYSCON_REG		0x20
+#define SYS_G_GMAC1_RXD2_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXD2_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXD3_SYSCON_REG		0x24
+#define SYS_G_GMAC1_RXD3_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXD3_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXDV_SYSCON_REG		0x28
+#define SYS_G_GMAC1_RXDV_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXDV_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_RXC_SYSCON_REG		0x2c
+#define SYS_G_GMAC1_RXC_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_RXC_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXD0_SYSCON_REG		0x30
+#define SYS_G_GMAC1_TXD0_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXD0_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXD1_SYSCON_REG		0x34
+#define SYS_G_GMAC1_TXD1_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXD1_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXD2_SYSCON_REG		0x38
+#define SYS_G_GMAC1_TXD2_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXD2_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXD3_SYSCON_REG		0x3c
+#define SYS_G_GMAC1_TXD3_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXD3_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXEN_SYSCON_REG		0x40
+#define SYS_G_GMAC1_TXEN_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXEN_SYSCON_SHIFT		0
+#define SYS_G_GMAC1_TXC_SYSCON_REG		0x44
+#define SYS_G_GMAC1_TXC_SYSCON_MASK		GENMASK(1, 0)
+#define SYS_G_GMAC1_TXC_SYSCON_SHIFT		0
+
+/* sys_iomux_gmac timing (slew rate) registers */
+#define SYS_G_GMAC1_MDC_SLEW_REG		0x10
+#define SYS_G_GMAC1_MDC_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_MDC_SLEW_SHIFT		2
+#define SYS_G_GMAC1_MDIO_SLEW_REG		0x14
+#define SYS_G_GMAC1_MDIO_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_MDIO_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXD0_SLEW_REG		0x18
+#define SYS_G_GMAC1_RXD0_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXD0_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXD1_SLEW_REG		0x1c
+#define SYS_G_GMAC1_RXD1_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXD1_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXD2_SLEW_REG		0x20
+#define SYS_G_GMAC1_RXD2_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXD2_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXD3_SLEW_REG		0x24
+#define SYS_G_GMAC1_RXD3_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXD3_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXDV_SLEW_REG		0x28
+#define SYS_G_GMAC1_RXDV_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXDV_SLEW_SHIFT		2
+#define SYS_G_GMAC1_RXC_SLEW_REG		0x2c
+#define SYS_G_GMAC1_RXC_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_RXC_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXD0_SLEW_REG		0x30
+#define SYS_G_GMAC1_TXD0_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXD0_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXD1_SLEW_REG		0x34
+#define SYS_G_GMAC1_TXD1_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXD1_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXD2_SLEW_REG		0x38
+#define SYS_G_GMAC1_TXD2_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXD2_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXD3_SLEW_REG		0x3c
+#define SYS_G_GMAC1_TXD3_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXD3_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXEN_SLEW_REG		0x40
+#define SYS_G_GMAC1_TXEN_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXEN_SLEW_SHIFT		2
+#define SYS_G_GMAC1_TXC_SLEW_REG		0x44
+#define SYS_G_GMAC1_TXC_SLEW_MASK		BIT(2)
+#define SYS_G_GMAC1_TXC_SLEW_SHIFT		2
+
+/* aon_iomux pins */
+#define PAD_RGPIO0				0
+#define PAD_RGPIO1				1
+#define PAD_RGPIO2				2
+#define PAD_RGPIO3				3
+#define PAD_RGPIO4				4
+#define PAD_RGPIO5				5
+#define PAD_RGPIO6				6
+#define PAD_RGPIO7				7
+#define PAD_RGPIO8				8
+#define PAD_RGPIO9				9
+#define PAD_RGPIO10				10
+#define PAD_RGPIO11				11
+#define PAD_RGPIO12				12
+#define PAD_RGPIO13				13
+#define PAD_RGPIO14				14
+#define PAD_RGPIO15				15
+#define PAD_TESTEN				16
+#define PAD_RSTN				17
+#define PAD_OSCK_XIN				18
+#define PAD_OSCK_XOUT				19
+#define PAD_OSCM_XIN				20
+#define PAD_OSCM_XOUT				21
+#define PAD_GMAC0_MDC				22
+#define PAD_GMAC0_MDIO				23
+#define PAD_GMAC0_RXD0				24
+#define PAD_GMAC0_RXD1				25
+#define PAD_GMAC0_RXD2				26
+#define PAD_GMAC0_RXD3				27
+#define PAD_GMAC0_RXDV				28
+#define PAD_GMAC0_RXC				29
+#define PAD_GMAC0_TXD0				30
+#define PAD_GMAC0_TXD1				31
+#define PAD_GMAC0_TXD2				32
+#define PAD_GMAC0_TXD3				33
+#define PAD_GMAC0_TXEN				34
+#define PAD_GMAC0_TXC				35
+
+/* aon_iomux vref syscon registers */
+#define AON_VREF_RGPIO_SYSCON_REG		0x58
+#define AON_VREF_RGPIO_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_RGPIO_SYSCON_SHIFT		0
+#define AON_VREF_GMAC_SYSCON_REG		0X5c
+#define AON_VREF_GMAC_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_GMAC_SYSCON_SHIFT		0
+#define AON_VREF_XSPI_SYSCON_REG		0x60
+#define AON_VREF_XSPI_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_XSPI_SYSCON_SHIFT		0
+#define AON_VREF_EMMC_U0_SYSCON_REG		0x64
+#define AON_VREF_EMMC_U0_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_EMMC_U0_SYSCON_SHIFT		0
+#define AON_VREF_EMMC_U1_SYSCON_REG		0x68
+#define AON_VREF_EMMC_U1_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_EMMC_U1_SYSCON_SHIFT		0
+#define AON_VREF_EMMC_U2_SYSCON_REG		0x6c
+#define AON_VREF_EMMC_U2_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_EMMC_U2_SYSCON_SHIFT		0
+#define AON_VREF_SDIO_U0_SYSCON_REG		0x70
+#define AON_VREF_SDIO_U0_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_SDIO_U0_SYSCON_SHIFT		0
+#define AON_VREF_SDIO_U1_SYSCON_REG		0x74
+#define AON_VREF_SDIO_U1_SYSCON_MASK		GENMASK(1, 0)
+#define AON_VREF_SDIO_U1_SYSCON_SHIFT		0
+
+#define GPOUT_LOW				0
+#define GPOUT_HIGH				1
+
+#define GPOEN_ENABLE				0
+#define GPOEN_DISABLE				1
+
+#define GPI_NONE				255
+
+/* vref syscon value  */
+#define PAD_VREF_SYSCON_IO_3V3			0
+#define PAD_VREF_SYSCON_IO_1V8			2
+
+/* gmac interface (rmii/rgmii) syscon value */
+#define GMAC_RMII_MODE				0	/* RMII mode,  DVDD 2.5V/3.3V */
+#define GMAC_RGMII_MODE				1	/* RGMII mode, DVDD 1.8V/2.5V */
+
+/* gmac timing syscon value */
+#define GMAC_SLEW_RATE_FAST			0
+#define GMAC_SLEW_RATE_SLOW			1
+
+#endif
--=20
2.25.1


