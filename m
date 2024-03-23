Return-Path: <linux-kernel+bounces-112268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00D8877A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A441C20E61
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479510A14;
	Sat, 23 Mar 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMocXM0Y"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155526D39;
	Sat, 23 Mar 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184352; cv=none; b=qgy/XsAFAGdlZXe3ntrNliCedFwD/i1+S7KvWgtYiClV6K+c4p0/Myzmi+fV//yTwutV7AR+i7+ZuPHDQ2AQIkyEgrLRHFSLjC3yrVk0W5OxdBjGxWnXfFscGEwlwQnzEmopkdJs8Jr/a3sS7z4CRt5aS1/lQrbfjQwJgeIss8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184352; c=relaxed/simple;
	bh=Vqifu8mRy03yc9hxmkLVxhFCcOQ+t8i7MU4w17tJHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+DRjd6wQ6VpJgxv0/W5yoPPNOJsMRmZyVUkzSyn9I8Ic4IsvCvw1tqcYfHA6ef5GsVcZX37i6nhQW/dy82/Xf/coF9FwnNxjFKlhcXaKvq217WQZEMPdd2sM+W9YSS/6oqm/qO7VWaQYKx1OsWvDXHROy2Ka52mdKEDOP+mviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMocXM0Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so2427987f8f.0;
        Sat, 23 Mar 2024 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711184348; x=1711789148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeiDpdLt3OHpoJFzv4AowOVwoakno99KYbuX0Mq1LqI=;
        b=HMocXM0YWKFq6PanXKXHFRJU1Mp4bfg44ITMYRmxP9Aqp2HoGU6m54y8JPbdSH2fmp
         c//objQGihVmtjPbtu7s9CkpE10POeh7UkweXX2bPlbvutW/kAIBemcgMOM5yYUsar8F
         P1lXs11k8Mk4gffWTQ59LgkDj8fP4sSslCpZAc6buaO6mxeHSyUIKUJXQ8g67L0q21xj
         OuyJtmIMDOkZcd+nP+5Q/rlUSx+zfNHXufsbM40NibJcwNUx/esmzRu28hK7pwsHx9yo
         tTlA0V/iqY71ipDM5TBCr1n98IgsWds6joGI29DSXcAr5iLbEoJ1M4evkjHqxkYLL2TD
         r4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184348; x=1711789148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeiDpdLt3OHpoJFzv4AowOVwoakno99KYbuX0Mq1LqI=;
        b=c5yNRAX1liAOYPybCs0G4NUnoGiV1Hvc9jnmPnhk5yGdiKBgGbwJfLH4JAQDbji58D
         tUmv+g9X/QZGhB6bOaT9lvcwshgtP8yQ41l2eYSxhA7PaCBxZRae/s4x6qEZF4M1ueNv
         wjahUo1xEH3OZIalpRjdXNikYR2uAK8SfA0BFYHTldlWjBeffMynyQL+9kbLFrzfbNpT
         7b16qzGki3Tykc9EP/TOnURAOn2Xi4V35LXbIsnvlqSzZ10CbvUE6Qqc6ugdcfn3zLxw
         /vW/W/rfv2uztRVIT1CiyjMTHtAwW+qBhaX5ehppe2c4TFUOPSDtptw11nUC0+kuLNWK
         6W+g==
X-Forwarded-Encrypted: i=1; AJvYcCXKl/3tt3QwCaNEn41eTL+5KeznlUpGkXlcXJ1aQNj86OOvto5Fc3xc6Q8H2C75zI4fL2Heivsm1BbdKp8uvYdPYtljgx6TLHX51OBwqPUYoLwTauCCO7yxgfxujyKMg7CXG43iNhNahb0TbkHeNSYYlBWZt/8p0NiHkHSBqQLalIHSTyc=
X-Gm-Message-State: AOJu0YwKmqTDeajcmI5cjqJ6clbJuqjm3pl8jXMp+vgn/Y49CYaDnGsD
	TsKtKvjv933X3Li4BUL+2P84pUnQrpD7Vc8ajneXwEp6K2deY/E=
X-Google-Smtp-Source: AGHT+IFOvXxg88CSUJQXEc5P5ooxQCKvpLZAAZkdRjM2xnjqNZ3oVD3uh0QNymxTTgJ4P35FSGROAQ==
X-Received: by 2002:a5d:6acf:0:b0:341:c487:fb44 with SMTP id u15-20020a5d6acf000000b00341c487fb44mr285574wrw.11.1711184348345;
        Sat, 23 Mar 2024 01:59:08 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm3965031wrw.61.2024.03.23.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:59:08 -0700 (PDT)
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
Subject: [PATCH v2 1/5] dt-bindings: mfd: Add rk816 binding
Date: Sat, 23 Mar 2024 09:58:48 +0100
Message-ID: <20240323085852.116756-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323085852.116756-1-knaerzche@gmail.com>
References: <20240323085852.116756-1-knaerzche@gmail.com>
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
 
 .../bindings/mfd/rockchip,rk816.yaml          | 269 ++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
new file mode 100644
index 000000000000..9664162f4f75
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
@@ -0,0 +1,269 @@
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
+      The input supply for dcdc1-regulator.
+
+  vcc2-supply:
+    description:
+      The input supply for dcdc2-regulator.
+
+  vcc3-supply:
+    description:
+      The input supply for dcdc3-regulator.
+
+  vcc4-supply:
+    description:
+      The input supply for dcdc4-regulator.
+
+  vcc5-supply:
+    description:
+      The input supply for ldo1-regulator, ldo2-regulator, and ldo3-regulator.
+
+  vcc6-supply:
+    description:
+      The input supply for ldo4-regulator, ldo5-regulator, and ldo6-regulator.
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
+      "^(boost|dcdc[1-4]-regulator|ldo[1-6]-regulator|otg-switch)$":
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
+        enum: [pin_fun_gpio, pin_fun_thermistor]
+
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        const: gpio0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#clock-cells"
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
+                vdd_cpu: dcdc1-regulator {
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
+                vdd_logic: dcdc2-regulator {
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
+                vcc_ddr: dcdc3-regulator {
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
+                vcc33_io: dcdc4-regulator {
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
+                vccio_pmu: ldo1-regulator {
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
+                vcc_tp: ldo2-regulator {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc_tp";
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_10: ldo3-regulator {
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
+                vcc18_lcd: ldo4-regulator {
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
+                vccio_sd: ldo5-regulator {
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
+                vdd10_lcd: ldo6-regulator {
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
+        };
+    };
-- 
2.43.2


