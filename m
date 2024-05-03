Return-Path: <linux-kernel+bounces-167312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD68BA7A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F26C1C216E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EF146D4B;
	Fri,  3 May 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImjoBSnK"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5545139CE9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720887; cv=none; b=DjF9zxRtl4sndCaZLGm5eNJd5Exv701TU6f0vIZ6MZ5m8SzP0k1JrEDSk2rpGn0XdLjEkTq7sr//32GnYKD6bRoIKTHMLDKUXUdvup+GQ3V3CJNt5iZg5EH1nJaMpBLO7WQ6xUUcCDQnczNEIJ3UIW/v7RR7BnyqI+/cV1JfnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720887; c=relaxed/simple;
	bh=/1/pnGHqbr0r//obkwF78x23/Romjav3bx8KFareHag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IU2/lqj1k5XhnaW5GXtPlJFJxEPSvHLGNwoaNg1IBcApXPamQxokMuUGjiG52WOPC3kcf6Eifr8yuThqWT/Zqy2A1asmH7+HHqqkP/GcS+lQKBBkBwwNwCk8UV1jxZLgF1+fGBqKB+nO2rvC4jGsslQ5KB1BVlc/QyGoXCtFL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImjoBSnK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so1761154f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714720882; x=1715325682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEiXiQ7gL/nSboaLITCZmXfeOlMXfETriHI/46p8L/Y=;
        b=ImjoBSnKsPxBl/6OGYn0u21WJDOAMVfWgPyzA+Fr8yHPIl2WHCiodWssvqZkmisX0j
         fmjIYr5vtjTvQourpPGFOnxWsudzPelY4DFUQJXuhgqDXHJRr/OyX7hcm42mdz9C8uSQ
         fkWS5WbLjcuiiDFhMh5P1PYpiVQc/rNZUgDZoHkuWZMTEQ9vjXEgUiMlJeR/KsoAxep4
         tGRUXfvlTo2H0KOC9LM7X/GUVtxxOFvsbwQovA2+W+2Hu37dVApz8ku6zuNo6OZ2szgB
         Jjhqvqe0imkJSK4IWj8KOmCYJoalmNy3UnobdRdWVV8jOakpWwvgEmVaoAM6z7u8SHGH
         9Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714720882; x=1715325682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEiXiQ7gL/nSboaLITCZmXfeOlMXfETriHI/46p8L/Y=;
        b=fXV2Dy8q7d6XISPmwctge6luk94zCzwlH3XHbzGFte7vRQ2k/fgfJAA+8k0Gn9fuC4
         whBaUGHHMgH9ptV4XxNEfGFk4jhBVinc5CGGAghEqILCRsp36YDI0Dtjevz25H4iSZ71
         q7Lu16ISlHF/KPI3MGfh9rdIrC3+1rKc0tIjrKkhTzlgNS8HsxrV9VwFQ3b7y1cdcn+T
         Te6pMO+4RmeLm/lEVbiw04Y8wlbFDRimLqRntjmHM+cVsxUrvi1K76CVmdx2EBW/pyRv
         B+m1UcuKOsl+fPTmgrNhfVPxJ01iYvyFndG4OfL++ZlMDWXBoF/AyxVYLJjqjoavR9Cp
         haTg==
X-Forwarded-Encrypted: i=1; AJvYcCVEArM92RhqzRGYqbz0VgFDO8pF82RlsGNv16PnIVD2OMAtZQhPb7mfSt+DfnPhCd2gDkl/rjqjb545y1p+RKMWB+bC2IA0zMBGjRu0
X-Gm-Message-State: AOJu0Yz3YgbabMNj+CZgy+S252lh4mwqFn8YS5xA0L5jcZ6Fd0RqAuPX
	+JgEnz0nq5rfXk+Gft97Px9ZWKd252KG1gKrEvZSuvWlJkUxPArXHO8Sb2YuYF0=
X-Google-Smtp-Source: AGHT+IG1TW/sH+SrCuiGflUxMjB9VgTlDp6Wc/ZaBAVym4hHBe35zh1JVAqJIAHEjW/RExe6LGLAwA==
X-Received: by 2002:a05:6000:1190:b0:34d:a5fd:977b with SMTP id g16-20020a056000119000b0034da5fd977bmr1260848wrx.60.1714720881849;
        Fri, 03 May 2024 00:21:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dz5-20020a0560000e8500b0034d10895f95sm3010071wrb.56.2024.05.03.00.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 00:21:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mfd: Use full path to other schemas
Date: Fri,  3 May 2024 09:21:16 +0200
Message-ID: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When referencing other schema, it is preferred to use an absolute path
(/schemas/....), which allows also an seamless move of particular schema
out of Linux kernel to dtschema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mfd/actions,atc260x.yaml         |  6 +--
 .../devicetree/bindings/mfd/brcm,cru.yaml     |  8 ++--
 .../devicetree/bindings/mfd/brcm,misc.yaml    |  2 +-
 .../bindings/mfd/canaan,k210-sysctl.yaml      |  6 +--
 .../bindings/mfd/delta,tn48m-cpld.yaml        |  4 +-
 .../devicetree/bindings/mfd/iqs62x.yaml       |  4 +-
 .../bindings/mfd/kontron,sl28cpld.yaml        | 10 ++--
 .../devicetree/bindings/mfd/max77650.yaml     |  8 ++--
 .../bindings/mfd/maxim,max77686.yaml          |  2 +-
 .../bindings/mfd/maxim,max77693.yaml          |  2 +-
 .../bindings/mfd/richtek,rt4831.yaml          |  4 +-
 .../bindings/mfd/ricoh,rn5t618.yaml           |  6 +--
 .../bindings/mfd/rockchip,rk805.yaml          |  2 +-
 .../bindings/mfd/rockchip,rk808.yaml          |  2 +-
 .../bindings/mfd/rockchip,rk817.yaml          |  2 +-
 .../bindings/mfd/rockchip,rk818.yaml          |  2 +-
 .../bindings/mfd/rohm,bd71815-pmic.yaml       |  2 +-
 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  4 +-
 .../bindings/mfd/rohm,bd71837-pmic.yaml       |  2 +-
 .../bindings/mfd/rohm,bd9571mwv.yaml          |  2 +-
 .../bindings/mfd/rohm,bd9576-pmic.yaml        |  2 +-
 .../bindings/mfd/samsung,s2mpa01.yaml         |  2 +-
 .../bindings/mfd/samsung,s2mps11.yaml         | 12 ++---
 .../bindings/mfd/samsung,s5m8767.yaml         |  4 +-
 .../devicetree/bindings/mfd/st,stmfx.yaml     |  2 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml   |  4 +-
 .../bindings/mfd/stericsson,ab8500.yaml       | 48 +++++++++----------
 .../bindings/mfd/stericsson,db8500-prcmu.yaml | 40 ++++++++--------
 .../devicetree/bindings/mfd/ti,tps65086.yaml  |  4 +-
 29 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
index 6811246c5771..9ae419748aa7 100644
--- a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
+++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
@@ -21,7 +21,7 @@ description: |
   regulators.
 
 allOf:
-  - $ref: ../input/input.yaml
+  - $ref: /schemas/input/input.yaml
 
 properties:
   compatible:
@@ -57,7 +57,7 @@ properties:
 
       switchldo1:
         type: object
-        $ref: ../regulator/regulator.yaml
+        $ref: /schemas/regulator/regulator.yaml
 
         properties:
           regulator-name: true
@@ -76,7 +76,7 @@ properties:
 
       "^(dcdc[0-4]|ldo[0-9]|ldo1[1-2])$":
         type: object
-        $ref: ../regulator/regulator.yaml
+        $ref: /schemas/regulator/regulator.yaml
 
         properties:
           regulator-name: true
diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
index b85819fbb07c..04910e4f88b2 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
@@ -34,19 +34,19 @@ properties:
 
 patternProperties:
   '^clock-controller@[a-f0-9]+$':
-    $ref: ../clock/brcm,iproc-clocks.yaml
+    $ref: /schemas/clock/brcm,iproc-clocks.yaml
 
   '^phy@[a-f0-9]+$':
-    $ref: ../phy/bcm-ns-usb2-phy.yaml
+    $ref: /schemas/phy/bcm-ns-usb2-phy.yaml
 
   '^pinctrl@[a-f0-9]+$':
-    $ref: ../pinctrl/brcm,ns-pinmux.yaml
+    $ref: /schemas/pinctrl/brcm,ns-pinmux.yaml
 
   '^syscon@[a-f0-9]+$':
     $ref: syscon.yaml
 
   '^thermal@[a-f0-9]+$':
-    $ref: ../thermal/brcm,ns-thermal.yaml
+    $ref: /schemas/thermal/brcm,ns-thermal.yaml
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/brcm,misc.yaml b/Documentation/devicetree/bindings/mfd/brcm,misc.yaml
index cff7d772a7db..abe24526f3d7 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,misc.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,misc.yaml
@@ -33,7 +33,7 @@ properties:
 
 patternProperties:
   '^reset-controller@[a-f0-9]+$':
-    $ref: ../reset/brcm,bcm4908-misc-pcie-reset.yaml
+    $ref: /schemas/reset/brcm,bcm4908-misc-pcie-reset.yaml
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
index 3b3beab9db3f..2451d0f0e4e3 100644
--- a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
@@ -36,7 +36,7 @@ properties:
   clock-controller:
     # Child node
     type: object
-    $ref: ../clock/canaan,k210-clk.yaml
+    $ref: /schemas/clock/canaan,k210-clk.yaml
     description:
       Clock controller for the SoC clocks. This child node definition
       should follow the bindings specified in
@@ -45,7 +45,7 @@ properties:
   reset-controller:
     # Child node
     type: object
-    $ref: ../reset/canaan,k210-rst.yaml
+    $ref: /schemas/reset/canaan,k210-rst.yaml
     description:
       Reset controller for the SoC. This child node definition
       should follow the bindings specified in
@@ -54,7 +54,7 @@ properties:
   syscon-reboot:
     # Child node
     type: object
-    $ref: ../power/reset/syscon-reboot.yaml
+    $ref: /schemas/power/reset/syscon-reboot.yaml
     description:
       Reboot method for the SoC. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
index f6967c1f6235..d3b79140cce2 100644
--- a/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
@@ -42,10 +42,10 @@ required:
 
 patternProperties:
   "^gpio(@[0-9a-f]+)?$":
-    $ref: ../gpio/delta,tn48m-gpio.yaml
+    $ref: /schemas/gpio/delta,tn48m-gpio.yaml
 
   "^reset-controller?$":
-    $ref: ../reset/delta,tn48m-reset.yaml
+    $ref: /schemas/reset/delta,tn48m-reset.yaml
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
index f438c2374966..e79ce447a800 100644
--- a/Documentation/devicetree/bindings/mfd/iqs62x.yaml
+++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
@@ -38,10 +38,10 @@ properties:
       device name with ".bin" as the extension (e.g. iqs620a.bin for IQS620A).
 
   keys:
-    $ref: ../input/iqs62x-keys.yaml
+    $ref: /schemas/input/iqs62x-keys.yaml
 
   pwm:
-    $ref: ../pwm/iqs620a-pwm.yaml
+    $ref: /schemas/pwm/iqs620a-pwm.yaml
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
index eb3b43547cb6..37207a97e06c 100644
--- a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
+++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
@@ -39,19 +39,19 @@ properties:
 
 patternProperties:
   "^gpio(@[0-9a-f]+)?$":
-    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
+    $ref: /schemas/gpio/kontron,sl28cpld-gpio.yaml
 
   "^hwmon(@[0-9a-f]+)?$":
-    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
+    $ref: /schemas/hwmon/kontron,sl28cpld-hwmon.yaml
 
   "^interrupt-controller(@[0-9a-f]+)?$":
-    $ref: ../interrupt-controller/kontron,sl28cpld-intc.yaml
+    $ref: /schemas/interrupt-controller/kontron,sl28cpld-intc.yaml
 
   "^pwm(@[0-9a-f]+)?$":
-    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
+    $ref: /schemas/pwm/kontron,sl28cpld-pwm.yaml
 
   "^watchdog(@[0-9a-f]+)?$":
-    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml
+    $ref: /schemas/watchdog/kontron,sl28cpld-wdt.yaml
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
index 4181174fcf58..d93d84171a31 100644
--- a/Documentation/devicetree/bindings/mfd/max77650.yaml
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -53,16 +53,16 @@ properties:
       Single string containing the name of the GPIO line.
 
   regulators:
-    $ref: ../regulator/max77650-regulator.yaml
+    $ref: /schemas/regulator/max77650-regulator.yaml
 
   charger:
-    $ref: ../power/supply/max77650-charger.yaml
+    $ref: /schemas/power/supply/max77650-charger.yaml
 
   leds:
-    $ref: ../leds/leds-max77650.yaml
+    $ref: /schemas/leds/leds-max77650.yaml
 
   onkey:
-    $ref: ../input/max77650-onkey.yaml
+    $ref: /schemas/input/max77650-onkey.yaml
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77686.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
index d027aabe453b..c13d51e462ba 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 1
 
   voltage-regulators:
-    $ref: ../regulator/maxim,max77686.yaml
+    $ref: /schemas/regulator/maxim,max77686.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
index 6a6f222b868f..cce273ba4034 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
@@ -81,7 +81,7 @@ properties:
       - pwms
 
   regulators:
-    $ref: ../regulator/maxim,max77693.yaml
+    $ref: /schemas/regulator/maxim,max77693.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
index 4762eb1439ce..e3ccba177b21 100644
--- a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -37,10 +37,10 @@ properties:
     maxItems: 1
 
   regulators:
-    $ref: ../regulator/richtek,rt4831-regulator.yaml
+    $ref: /schemas/regulator/richtek,rt4831-regulator.yaml
 
   backlight:
-    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
+    $ref: /schemas/leds/backlight/richtek,rt4831-backlight.yaml
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
index 032a7fb0b4a7..e3d64307b531 100644
--- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
+++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
@@ -28,7 +28,7 @@ allOf:
         regulators:
           patternProperties:
             "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
-              $ref: ../regulator/regulator.yaml
+              $ref: /schemas/regulator/regulator.yaml
           additionalProperties: false
   - if:
       properties:
@@ -40,7 +40,7 @@ allOf:
         regulators:
           patternProperties:
             "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
-              $ref: ../regulator/regulator.yaml
+              $ref: /schemas/regulator/regulator.yaml
           additionalProperties: false
   - if:
       properties:
@@ -52,7 +52,7 @@ allOf:
         regulators:
           patternProperties:
             "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
-              $ref: ../regulator/regulator.yaml
+              $ref: /schemas/regulator/regulator.yaml
           additionalProperties: false
 
 properties:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
index 44f8188360dd..da2391530c16 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
@@ -82,7 +82,7 @@ properties:
     patternProperties:
       "^(DCDC_REG[1-4]|LDO_REG[1-3])$":
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
index d2ac6fbd5ce6..50dfffac8fbf 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
@@ -109,7 +109,7 @@ properties:
     patternProperties:
       "^(DCDC_REG[1-4]|LDO_REG[1-8]|SWITCH_REG[1-2])$":
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index 92b1592e8942..8c2fd0fabb92 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -91,7 +91,7 @@ properties:
       "^(LDO_REG[1-9]|DCDC_REG[1-4]|BOOST|OTG_SWITCH)$":
         type: object
         unevaluatedProperties: false
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
     unevaluatedProperties: false
 
   clocks:
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
index fd4b9de364aa..90d944c27ba1 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
@@ -101,7 +101,7 @@ properties:
     patternProperties:
       "^(DCDC_REG[1-4]|DCDC_BOOST|LDO_REG[1-9]|SWITCH_REG|HDMI_SWITCH|OTG_SWITCH)$":
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index 05747e012516..bb81307dc11b 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -61,7 +61,7 @@ properties:
     default: 30000000
 
   regulators:
-    $ref: ../regulator/rohm,bd71815-regulator.yaml
+    $ref: /schemas/regulator/rohm,bd71815-regulator.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 07f99738fcf6..fa17686a64f7 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -65,12 +65,12 @@ properties:
       here in Ohms.
 
   regulators:
-    $ref: ../regulator/rohm,bd71828-regulator.yaml
+    $ref: /schemas/regulator/rohm,bd71828-regulator.yaml
     description:
       List of child nodes that specify the regulators.
 
   leds:
-    $ref: ../leds/rohm,bd71828-leds.yaml
+    $ref: /schemas/leds/rohm,bd71828-leds.yaml
 
   gpio-reserved-ranges:
     description: |
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
index 7aa343f58cb6..08f958dc700d 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -109,7 +109,7 @@ properties:
       - 14000
 
   regulators:
-    $ref: ../regulator/rohm,bd71837-regulator.yaml
+    $ref: /schemas/regulator/rohm,bd71837-regulator.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
index 89f9efee465b..534cf03f36bb 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
@@ -67,7 +67,7 @@ properties:
     patternProperties:
       "^(vd09|vd18|vd25|vd33|dvfs)$":
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
 
         properties:
           regulator-name:
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
index b7b323b1a4f2..70fd9b5e4c3f 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
@@ -71,7 +71,7 @@ properties:
       # (HW) minimum for max timeout is 4ms, maximum 4416 ms.
 
   regulators:
-    $ref: ../regulator/rohm,bd9576-regulator.yaml
+    $ref: /schemas/regulator/rohm,bd9576-regulator.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
index 055dfc337c2f..ad92eb6fcd3a 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
@@ -27,7 +27,7 @@ properties:
     maxItems: 1
 
   regulators:
-    $ref: ../regulator/samsung,s2mpa01.yaml
+    $ref: /schemas/regulator/samsung,s2mpa01.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
index 5ff6546c72b7..bc8b5940b1c5 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -27,7 +27,7 @@ properties:
       - samsung,s2mpu02-pmic
 
   clocks:
-    $ref: ../clock/samsung,s2mps11.yaml
+    $ref: /schemas/clock/samsung,s2mps11.yaml
     description:
       Child node describing clock provider.
 
@@ -75,7 +75,7 @@ allOf:
     then:
       properties:
         regulators:
-          $ref: ../regulator/samsung,s2mps11.yaml
+          $ref: /schemas/regulator/samsung,s2mps11.yaml
         samsung,s2mps11-wrstbi-ground: false
 
   - if:
@@ -86,7 +86,7 @@ allOf:
     then:
       properties:
         regulators:
-          $ref: ../regulator/samsung,s2mps13.yaml
+          $ref: /schemas/regulator/samsung,s2mps13.yaml
         samsung,s2mps11-acokb-ground: false
 
   - if:
@@ -97,7 +97,7 @@ allOf:
     then:
       properties:
         regulators:
-          $ref: ../regulator/samsung,s2mps14.yaml
+          $ref: /schemas/regulator/samsung,s2mps14.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
 
@@ -109,7 +109,7 @@ allOf:
     then:
       properties:
         regulators:
-          $ref: ../regulator/samsung,s2mps15.yaml
+          $ref: /schemas/regulator/samsung,s2mps15.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
 
@@ -121,7 +121,7 @@ allOf:
     then:
       properties:
         regulators:
-          $ref: ../regulator/samsung,s2mpu02.yaml
+          $ref: /schemas/regulator/samsung,s2mpu02.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
 
diff --git a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
index aea0b7d57d04..249248078c59 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
@@ -21,7 +21,7 @@ properties:
     const: samsung,s5m8767-pmic
 
   clocks:
-    $ref: ../clock/samsung,s2mps11.yaml
+    $ref: /schemas/clock/samsung,s2mps11.yaml
     description:
       Child node describing clock provider.
 
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   regulators:
-    $ref: ../regulator/samsung,s5m8767.yaml
+    $ref: /schemas/regulator/samsung,s5m8767.yaml
     description:
       List of child nodes that specify the regulators.
 
diff --git a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
index 76551c90b128..61daf36b3c80 100644
--- a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
@@ -60,7 +60,7 @@ properties:
         additionalProperties: false
 
         allOf:
-          - $ref: ../pinctrl/pinmux-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
 
         properties:
           pins: true
diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index b17ebeb0a42f..e822817188fd 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -29,7 +29,7 @@ properties:
   onkey:
     type: object
 
-    $ref: ../input/input.yaml
+    $ref: /schemas/input/input.yaml
 
     properties:
       compatible:
@@ -67,7 +67,7 @@ properties:
   watchdog:
     type: object
 
-    $ref: ../watchdog/watchdog.yaml
+    $ref: /schemas/watchdog/watchdog.yaml
 
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
index 94f9767a927d..b2cfa4120b8a 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
@@ -126,7 +126,7 @@ properties:
     patternProperties:
       "^channel@[0-9a-f]+$":
         type: object
-        $ref: ../iio/adc/adc.yaml#
+        $ref: /schemas/iio/adc/adc.yaml#
         description: Represents each of the external channels which are
           connected to the ADC.
 
@@ -180,22 +180,22 @@ properties:
   ab8500_fg:
     description: Node describing the AB8500 fuel gauge control block.
     type: object
-    $ref: ../power/supply/stericsson,ab8500-fg.yaml
+    $ref: /schemas/power/supply/stericsson,ab8500-fg.yaml
 
   ab8500_btemp:
     description: Node describing the AB8500 battery temperature control block.
     type: object
-    $ref: ../power/supply/stericsson,ab8500-btemp.yaml
+    $ref: /schemas/power/supply/stericsson,ab8500-btemp.yaml
 
   ab8500_charger:
     description: Node describing the AB8500 battery charger control block.
     type: object
-    $ref: ../power/supply/stericsson,ab8500-charger.yaml
+    $ref: /schemas/power/supply/stericsson,ab8500-charger.yaml
 
   ab8500_chargalg:
     description: Node describing the AB8500 battery charger algorithm.
     type: object
-    $ref: ../power/supply/stericsson,ab8500-chargalg.yaml
+    $ref: /schemas/power/supply/stericsson,ab8500-chargalg.yaml
 
   phy:
     description: Node describing the AB8500 USB PHY control block.
@@ -339,40 +339,40 @@ properties:
       ab8500_ldo_aux1:
         description: The voltage for the auxiliary LDO regulator 1
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_aux2:
         description: The voltage for the auxiliary LDO regulator 2
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_aux3:
         description: The voltage for the auxiliary LDO regulator 3
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_aux4:
         description: The voltage for the auxiliary LDO regulator 4
           only present on AB8505
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_aux5:
         description: The voltage for the auxiliary LDO regulator 5
           only present on AB8505
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_aux6:
         description: The voltage for the auxiliary LDO regulator 6
           only present on AB8505
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       # There is never any AUX7 regulator which is confusing
@@ -381,21 +381,21 @@ properties:
         description: The voltage for the auxiliary LDO regulator 8
           only present on AB8505
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_intcore:
         description: The LDO regulator for the internal core voltage
           of the AB8500
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_adc:
         description: Analog power regulator for the analog to digital converter
           ADC, only present on AB8505
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_tvout:
@@ -404,39 +404,39 @@ properties:
           the temperature of the NTC thermistor on the battery.
           Only present on AB8500.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_audio:
         description: The LDO regulator for the audio codec output
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_anamic1:
         description: The LDO regulator for the analog microphone 1
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_anamic2:
         description: The LDO regulator for the analog microphone 2
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_dmic:
         description: The LDO regulator for the digital microphone
           only present on AB8500
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ldo_ana:
         description: Analog power regulator for CSI and DSI interfaces,
           Camera Serial Interface CSI and Display Serial Interface DSI.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
     required:
@@ -459,19 +459,19 @@ properties:
       ab8500_ext1:
         description: The voltage for the VSMPS1 external regulator
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ext2:
         description: The voltage for the VSMPS2 external regulator
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       ab8500_ext3:
         description: The voltage for the VSMPS3 external regulator
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
     required:
@@ -482,7 +482,7 @@ properties:
 patternProperties:
   "^pwm@[1-9]+?$":
     type: object
-    $ref: ../pwm/pwm.yaml#
+    $ref: /schemas/pwm/pwm.yaml#
     unevaluatedProperties: false
     description: Represents each of the PWM blocks in the AB8500
 
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
index cb2a42caabb5..d6c13779d44e 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -71,52 +71,52 @@ properties:
         description: The voltage for the application processor, the
           main voltage domain for the chip.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_varm:
         description: The voltage for the ARM Cortex-A9 CPU.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vmodem:
         description: The voltage for the modem subsystem.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vpll:
         description: The voltage for the phase locked loop clocks.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vsmps1:
         description: Also known as VIO12, is a step-down voltage regulator
           for 1.2V I/O. SMPS means System Management Power Source.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vsmps2:
         description: Also known as VIO18, is a step-down voltage regulator
           for 1.8V I/O. SMPS means System Management Power Source.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vsmps3:
         description: This is a step-down voltage regulator
           for 0.87 thru 1.875V I/O. SMPS means System Management Power Source.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_vrf1:
         description: RF transceiver voltage regulator.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sva_mmdsp:
@@ -124,21 +124,21 @@ properties:
           voltage regulator. This is the voltage for the accelerator DSP
           for video encoding and decoding.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sva_mmdsp_ret:
         description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
           voltage regulator for retention mode.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sva_pipe:
         description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
           voltage regulator for the data pipe.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sia_mmdsp:
@@ -146,21 +146,21 @@ properties:
           voltage regulator. This is the voltage for the accelerator DSP
           for image encoding and decoding.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sia_mmdsp_ret:
         description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
           voltage regulator for retention mode.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sia_pipe:
         description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
           voltage regulator for the data pipe.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_sga:
@@ -168,7 +168,7 @@ properties:
           This is in effect controlling the power to the MALI400 3D
           accelerator block.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_b2r2_mcde:
@@ -176,33 +176,33 @@ properties:
           Display Engine (MCDE) voltage regulator. These are two graphics
           blocks.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_esram12:
         description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_esram12_ret:
         description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator for
           retention mode.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_esram34:
         description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
       db8500_esram34_ret:
         description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator for
           retention mode.
         type: object
-        $ref: ../regulator/regulator.yaml#
+        $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
     required:
diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
index bd36a07c1721..a8eed9065d96 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
@@ -49,7 +49,7 @@ properties:
     patternProperties:
       "^buck[1-6]$":
         type: object
-        $ref: ../regulator/regulator.yaml
+        $ref: /schemas/regulator/regulator.yaml
 
         properties:
           regulator-name: true
@@ -72,7 +72,7 @@ properties:
 
       "^(ldoa[1-3]|swa1|swb[1-2]|vtt)$":
         type: object
-        $ref: ../regulator/regulator.yaml
+        $ref: /schemas/regulator/regulator.yaml
 
         properties:
           regulator-name: true
-- 
2.43.0


