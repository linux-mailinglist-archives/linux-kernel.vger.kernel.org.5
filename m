Return-Path: <linux-kernel+bounces-110158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A6885AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CDBB20D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E485C77;
	Thu, 21 Mar 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRkfBUNz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B035A947;
	Thu, 21 Mar 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031979; cv=none; b=l+Uu3PzL56dje+wId9Lr50EHWRVXi8hIKK2dkYonaOGeuLF0XYjKKnO9M3OZJvJm7tCb84Nrq2Q5ZSv+FE2rXjgtzPCaeuwwZxuBuyfQhwai9qXXqgjehZHm7uIJyCd6OwAe5bpolZX8GDMuY+re2El0Whl56ZSa09FMQUBaDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031979; c=relaxed/simple;
	bh=+NpUKQ5iB0YePuDf7WiBAzzLkKvERDjDBLGFEo9274o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYGcvL56DQ4yI0BHp0IXKbjSsMtj2QqoMtLhPLfIS1U78jJhdSPIaXvf1tbrT7B3ji6Gdxp63PhGEqxZ2wg+Yf/E9Hw8+YmEjIgIdEUYOEP7b0QyZvziqBGcmG05g6AuoTuZSwnhpO7QSk0gFxnwXB8re5TAJnLKRkIcX+6Y77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRkfBUNz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1496092a12.0;
        Thu, 21 Mar 2024 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031975; x=1711636775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt8p4RY6k043MwULpqhdmkYzdtutmtSYnRG7ixAL6cQ=;
        b=nRkfBUNzfNPBYlT9stuiyIVuC36nM8CMJBG3TKNTNLy08HB5BQZT2iWfyiOhT6kH1b
         sSpDAKUtDukktnv34mqhHft6nb/E3lPM7AJIn8B0hbnTIV/d3IVpzdjDk9kP5x0egNGo
         qdg0jUwRwWjaTUI9nMiG4x6ldgtH5QArhlb70KXmqXtCCfuTKvtjYfwvDpXhz8ZdvZsi
         71GifZ1ITndsFyz8lcUmVTHlYyBl2V4NpvZS+VwL1hAYEppb1DRM350hhjwnO595BqYo
         Eq1um3x3lr+LLjropu/drnjMu9fh58UV8We0uAo72TymKVa55In8iO0w8a+94CaufQWD
         sWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031975; x=1711636775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt8p4RY6k043MwULpqhdmkYzdtutmtSYnRG7ixAL6cQ=;
        b=FxOrWFspf/UXFICmiUtS80QG9ORRin+VQi6z91zthsUE/NWB30DWi45sEMUTnUjYpr
         bPD5Ctr30yybFt+sS9EmO3JFS81ICJFs6Jm1Jn/Dbp/htk04EDIV7ORwj33p1lWSEWi/
         K5GdkmgfBNv0DYtKWQTbwuIfEl78n7p8fcEJ7zz1nY7kllDZaRBUsn4bSvUu+89G8WDP
         5ZKzOlSv7bfJG3bkCBYbuZHjRPPaKnt1TXGRaHbaWVtVghy/mb2GKAUCRQxswjk+0McO
         rGm14vaUgNxZ3bAiWDxGxMVGe5CvPUgTf9W34zbHuDQ6JkLfbc9X9LZEzq0FNeL6VoeL
         Q2iA==
X-Forwarded-Encrypted: i=1; AJvYcCVc733oj+no8dDja5iEy1HW9Q9wdfn8ztkIjc1t29yxEp1FeKAAeUYWB0I3wZbCnmsl2b1bIGU1SDZk7U9P4HW419zgBVkJAjBmwNsBbfRlObhKSIzU/wea2knX2vkXcYrzuKKWyfQqmzrS1j7qoyr3GH5s22gYTG1GZH3l12kP7TCJ7Hg=
X-Gm-Message-State: AOJu0YyCZ9uTJCDXjB2RfKgwB2JnrqBSlJA6TabaFBJFU7qFXLP1EEm5
	s2dzycigERb9sVk56YVGFlu1TiKudYzL358XDIH271JIY2nRDuE=
X-Google-Smtp-Source: AGHT+IGjKKL/8jQHlXcH90JXlNKIhdKLi9UJuSrfaawd5b8R4sBEFnY1PIvJdbq4+rqf2e0WmemiTA==
X-Received: by 2002:a17:906:254b:b0:a46:cf63:d96b with SMTP id j11-20020a170906254b00b00a46cf63d96bmr3819163ejb.51.1711031975555;
        Thu, 21 Mar 2024 07:39:35 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b39:dab4:8e20:e918])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b00a46abaeeb1csm6147923ejb.104.2024.03.21.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:39:35 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: mfd: Add rk816 binding
Date: Thu, 21 Mar 2024 15:39:09 +0100
Message-ID: <20240321143911.90210-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321143911.90210-2-knaerzche@gmail.com>
References: <20240321143911.90210-2-knaerzche@gmail.com>
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
 .../bindings/mfd/rockchip,rk816.yaml          | 259 ++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
new file mode 100644
index 000000000000..b46de99f60ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
@@ -0,0 +1,259 @@
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
+description: |
+  Rockchip RK816 series PMIC. This device consists of an i2c controlled MFD
+  that includes regulators, a RTC, a gpio controller, and a power button.
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
+    description: |
+      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
+    const: 1
+
+  clock-output-names:
+    description:
+      From common clock binding to override the default output clock name.
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
+    description:
+      Device can be used as a wakeup source.
+
+  vcc1-supply:
+    description:
+      The input supply for DCDC_REG1.
+
+  vcc2-supply:
+    description:
+      The input supply for DCDC_REG2.
+
+  vcc3-supply:
+    description:
+      The input supply for DCDC_REG3.
+
+  vcc4-supply:
+    description:
+      The input supply for DCDC_REG4.
+
+  vcc5-supply:
+    description:
+      The input supply for LDO_REG1, LDO_REG2, and LDO_REG3.
+
+  vcc6-supply:
+    description:
+      The input supply for LDO_REG4, LDO_REG5, and LDO_REG6.
+
+  vcc7-supply:
+    description:
+      The input supply for BOOST.
+
+  vcc8-supply:
+    description:
+      The input supply for OTG_SWITCH.
+
+  regulators:
+    type: object
+    patternProperties:
+      "^(DCDC_REG[1-4]|LDO_REG[1-6]|BOOST|OTG_SWITCH)$":
+        type: object
+        $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
+    unevaluatedProperties: false
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
+
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
+                vdd_cpu: DCDC_REG1 {
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
+                vdd_logic: DCDC_REG2 {
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
+                vcc_ddr: DCDC_REG3 {
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
+                vcc33_io: DCDC_REG4 {
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
+                vccio_pmu: LDO_REG1 {
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
+                vcc_tp: LDO_REG2 {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-name = "vcc_tp";
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_10: LDO_REG3 {
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
+                vcc18_lcd: LDO_REG4 {
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
+                vccio_sd: LDO_REG5 {
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
+                vdd10_lcd: LDO_REG6 {
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


