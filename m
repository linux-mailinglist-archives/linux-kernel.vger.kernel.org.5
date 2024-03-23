Return-Path: <linux-kernel+bounces-112357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BB8878D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEDA284D77
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9423D57A;
	Sat, 23 Mar 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwOcTdqh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC639AF1;
	Sat, 23 Mar 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200514; cv=none; b=Kud9MrdQUii7duUnc+ngtLeyiQ3JW5BbzmgI3xW9inS4fVK1ou8/wvkCQ1LGimD0wppR9rhXc0UHG0BW6Ldi2VQUcmW0tLyADn+1KF/yK6Tk73L+RbLJCLKWZ3Y1eayDLOYuMwR6GwHe6V+8eSKl6jjm863LhRtgtcI0duTJMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200514; c=relaxed/simple;
	bh=eMw1PvW/b4stSWBWB87g13rAgM1lORBa72HMdB7ekgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ5QYBkRcucMaevll8XWbd/nrflpvltcrsxJXOsgwscvpiitRgDR/DSUdK2b266iZu4qtCxZgqLuj1a6qHkZ703KaQa5wz5E2JWnl2i+pnPALPSlLghIIXQ2mUyLN9GmpkEmv6T5HBOP9NEDlf/saOh8+e9Yxq/8BIlCNw8ky5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwOcTdqh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148581945fso288835e9.2;
        Sat, 23 Mar 2024 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200511; x=1711805311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PsDCMEoJvArZ7FpaFDrW3J9rJO3aT3dwR+vHpofNMM=;
        b=jwOcTdqhgyftZrUR8ofygklVNoVkuMM5G0qyYsloqIduLO77T1Zwmkgtcsop26k3dq
         xe0e++05+6589/3YrZkLihQtWorIwpe640fhCQi+AiqlQcFzFjKWPfnkZkDhlcf4htxV
         DvnhGATCG39zG8llROrAkois9WZ+a0pXblWArCXWYeDnkmEsPlLOQQpc+48wFpEu+9vv
         3y4RLR5kyy9jll5K6UKCpXpzQHfed1l9OLQ9JSulutLJ+JNPdc2TwckPUPW7bh1ku6LA
         SoZG2oPda2E3yg/x48h3UDcLww8Y6YIS797sKvkeO+f3JuiJw6bK6hLldIdXl0djtLOA
         6UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200511; x=1711805311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PsDCMEoJvArZ7FpaFDrW3J9rJO3aT3dwR+vHpofNMM=;
        b=l+VFaFjleoHLBesXSvB06UEyFzoZRe3ZOkggUGY0KBui1hllIuf5cJmcmSNP3sGu4i
         r575ydQqm4kzIEkwaRV8V8YmWogOKdTfgWHznVxjLx45gh4SgAQKuFKfgC0GMYV4szUV
         6RP6z4gJdym+FvFIbsTesK2MiAvcQLEu2Xds6Y106Nw5f2vGTf++Bc3j4r9UG9OXbLUt
         R4CCtsOHNghmFBSZE2BL4OYEpUb0xJ1LrpqbzXs5+wzKTfv1RscTlZrrhSdaRDt9C2nz
         m53izPRU6OdLBAO6YDm+uXcVMc7grvXnONBCcBwvwECb3BiS549TjcDh+vk1UJn+z/t7
         DORQ==
X-Forwarded-Encrypted: i=1; AJvYcCV72UgrDwOV0QNyvLsgOGdzRnPiMdtLOkJU2AV3IOx0gJFrIDiDDtBFT4HwUXp8r5s7f4rCZ1oPxhUwATdX42g4YCPHHKji1P8aD4clOnBeRpZd+Zuuub8hIaNIenQ1IdZgYmZyL5+iqOAYp9BYld+OMV8oRm+/DbjZisthe9lsCxnYtTc=
X-Gm-Message-State: AOJu0YzXzvtxYJqr1+AvXgFYabegFCCUKeL0/+3tDLpdp1DwFVKrdnpq
	aS9cSk58nYEFE/0o0JZcKbArueaWa2s93aQU2fHdE+oorhDUzwg=
X-Google-Smtp-Source: AGHT+IGxQG8d/mbHn4BjiZm/SCx86waXRF8l/KiQCiAzFIZkYfEHIHpw6xI4uugcKxq6tW6Xc8qnUA==
X-Received: by 2002:a5d:5084:0:b0:33e:67c3:43cd with SMTP id a4-20020a5d5084000000b0033e67c343cdmr1395267wrt.27.1711200510895;
        Sat, 23 Mar 2024 06:28:30 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm3076061wrs.7.2024.03.23.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:28:30 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: mfd: Add rk816 binding
Date: Sat, 23 Mar 2024 14:27:55 +0100
Message-ID: <20240323132757.141861-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323132757.141861-2-knaerzche@gmail.com>
References: <20240323132757.141861-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT binding document for Rockchip's RK816 PMIC

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
  - lowercase/hyphens for regulator node names
  - rename "-reg" to "-regulator" to make node names generic
  - dropped superfluous description for clock-output-names and
    wakeup-source
  - dropped "|" for text blocks that don't require to preserve formatting
  - use full path for `$ref`s
  - added pins description to the binding
  - added charger function to description

changes since v2:
  - dropped "-regulator"-suffix from regulator device names
  - use "'"-quotes consistently in the binding
  - dropped "pin_fun"-prefix from pin-function names
  - added pin to example

 .../bindings/mfd/rockchip,rk816.yaml          | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
new file mode 100644
index 000000000000..b960ded35e99
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
@@ -0,0 +1,274 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rockchip,rk816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RK816 Power Management Integrated Circuit
+
+maintainers:
+  - Chris Zhong <zyw@rock-chips.com>
+  - Zhang Qing <zhangqing@rock-chips.com>
+
+description:
+  Rockchip RK816 series PMIC. This device consists of an i2c controlled MFD
+  that includes regulators, a RTC, a GPIO controller, a power button, and a
+  battery charger manager with fuel gauge.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk816
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#clock-cells':
+    description:
+      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
+    const: 1
+
+  clock-output-names:
+    maxItems: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  system-power-controller:
+    type: boolean
+    description:
+      Telling whether or not this PMIC is controlling the system power.
+
+  wakeup-source:
+    type: boolean
+
+  vcc1-supply:
+    description:
+      The input supply for dcdc1.
+
+  vcc2-supply:
+    description:
+      The input supply for dcdc2.
+
+  vcc3-supply:
+    description:
+      The input supply for dcdc3.
+
+  vcc4-supply:
+    description:
+      The input supply for dcdc4.
+
+  vcc5-supply:
+    description:
+      The input supply for ldo1, ldo2, and ldo3.
+
+  vcc6-supply:
+    description:
+      The input supply for ldo4, ldo5, and ldo6.
+
+  vcc7-supply:
+    description:
+      The input supply for boost.
+
+  vcc8-supply:
+    description:
+      The input supply for otg-switch.
+
+  regulators:
+    type: object
+    patternProperties:
+      '^(boost|dcdc[1-4]|ldo[1-6]|otg-switch)$':
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    unevaluatedProperties: false
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+    $ref: /schemas/pinctrl/pinmux-node.yaml
+
+    properties:
+      function:
+        enum: [gpio, thermistor]
+
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        const: gpio0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/rockchip.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rk816: pmic@1a {
+            compatible = "rockchip,rk816";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+            clock-output-names = "xin32k", "rk816-clkout2";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pmic_int_l>;
+            gpio-controller;
+            system-power-controller;
+            wakeup-source;
+            #clock-cells = <1>;
+            #gpio-cells = <2>;
+
+            vcc1-supply = <&vcc_sys>;
+            vcc2-supply = <&vcc_sys>;
+            vcc3-supply = <&vcc_sys>;
+            vcc4-supply = <&vcc_sys>;
+            vcc5-supply = <&vcc33_io>;
+            vcc6-supply = <&vcc_sys>;
+
+            regulators {
+                vdd_cpu: dcdc1 {
+                    regulator-name = "vdd_cpu";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <1450000>;
+                    regulator-ramp-delay = <6001>;
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_logic: dcdc2 {
+                    regulator-name = "vdd_logic";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-ramp-delay = <6001>;
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+
+                vcc_ddr: dcdc3 {
+                    regulator-name = "vcc_ddr";
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                vcc33_io: dcdc4 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc33_io";
+                    regulator-initial-mode = <1>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vccio_pmu: ldo1 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vccio_pmu";
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vcc_tp: ldo2 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc_tp";
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_10: ldo3 {
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-name = "vdd_10";
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+
+                vcc18_lcd: ldo4 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-name = "vcc18_lcd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1800000>;
+                    };
+                };
+
+                vccio_sd: ldo5 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vccio_sd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <3300000>;
+                    };
+                };
+
+                vdd10_lcd: ldo6 {
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-name = "vdd10_lcd";
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1000000>;
+                    };
+                };
+            };
+
+            rk816_gpio_pins: gpio-pins {
+                function = "gpio";
+                pins = "gpio0";
+            };
+        };
+    };
-- 
2.43.2


