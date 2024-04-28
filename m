Return-Path: <linux-kernel+bounces-161293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2D8B4A46
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9B61C20D50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246414F8B1;
	Sun, 28 Apr 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqvr6DOm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F04EB44;
	Sun, 28 Apr 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714287789; cv=none; b=b/UDi9/NCYJ1/7I6IfbtJ+ZSdzTpMyLbTc0hIxHK442H5Re8buDzgEQKkDb/IOJ3DA+jSFoqNm8UD8P5PfehyYMSqWNYzjGQAz5rJLBEs7PjZz3a9TEdLv+KRRpj/mtKQyFCFZgf7Rj9nugf6dFXDLwD5Sq5xS4+5j6Pidl2sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714287789; c=relaxed/simple;
	bh=9ISSGTJDUQAS3WtiP+m80pYDxgAMiHL7ATtx428f4+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hinn69BDwmU4Xn2fa9a64Em80FcCzkY34riqtsJg/WFCc8UYJIK0CnY9NM5OpSL4KjWRHRjecStEkCzrOlb9bnjeAiM+/Pzllmbn588VvFi0siZ1/y9aRqk+7gKkbcgpsu3jDn8xu3j14T2A5erfgXAp+VLnvHMk4uOeN5Zi1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqvr6DOm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so34556815ad.1;
        Sun, 28 Apr 2024 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714287787; x=1714892587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtFfwrg+VWp8mRWlHFYexjYOOq/2ziBnXCFLiolsjd8=;
        b=Lqvr6DOmTmvH7ulHnTHEyw41037Hmh7/GkfRh2oWynDceEq8H3ZI8BO+QT4wHYSnav
         qidrW/i6k+JHl116IrZM2EiNw/UUFyJFs3PAkc0AesziLSTS5i31mxSqbCaZpxWEXKhJ
         IAdNVQ9l3B5NJz9Ir6KKaPR1XjHnGnZmYUaca6VGDi5QitbO9RVgIhNE6qduWrm6b0ig
         IhMyS6vNjUoGK+FGiTxOcC/QH3MbjL5N1qPN1mketJTLfxmVj7SWaKWYdMX4YwQSdWzt
         AvQfuaIjEm+Btev57UKmje1DYVcRGYBreIfKyJem6vddzhG3vPnwduP/0bpAMbUy+MTE
         9rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714287787; x=1714892587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtFfwrg+VWp8mRWlHFYexjYOOq/2ziBnXCFLiolsjd8=;
        b=Mr/K3IEuivtYhAa3yNwEW1c43awSgALx4J9rnFdwDP3h2EPPf6q9M1CdK1kKnFGscz
         hOvCUP3YXeAgkhP703+mcj5TjA/A98qR8Q2Xd42s6escArQOtv1KqldmSWBNKfZpCLCx
         tdZMqlBDyl8kponTSV2mK2VA9p/n/9kPxL9fE7HLinPguCuqi00aUtU1YzRke3O3Kd7/
         ZelG4p1rfTO3PcsECqmMo7inhihed/BCuVeE4W4gyFEIFAhGtSbfnPknOlJVz/HH2fqp
         yKH7g/R3wed/D6wBpr4YIWZa4p+iAVhd3nqXTvzWJGXAt2+/gUaFmScQw1xB8Kv5X/1W
         7o7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4rSEckIawNqmXvSf4LL0ce7GNgTGQO862D5BJuJ/MT+rO4W6oeIBXF6YQbKlEe9cMnvBD5wX7jty9wI5HH6MFaBkGvnHkYR5DFk4pQ5rmZaYzGgmid5cpIIYkXBWyA8aE6qwkGS4Ciw==
X-Gm-Message-State: AOJu0YwkVzdnwZkeoKioEI/BZufCcpKyQQKwlV9xhropeGbtpmAHPBVM
	uD0ngeKKOuexW3bBEP7JbSZoPZ5YAZpWiJgY3feuGWzBKfzVDqXY
X-Google-Smtp-Source: AGHT+IE7yhZkf715j7M8O6wlOIWoVoNMiSUKO2l07hitxKeSnsMD1vgWLqheMAZgLrh5mY0+PVVkrA==
X-Received: by 2002:a17:902:f811:b0:1eb:1808:86f1 with SMTP id ix17-20020a170902f81100b001eb180886f1mr6072212plb.40.1714287786875;
        Sun, 28 Apr 2024 00:03:06 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:f308:fdd6:4f75:1d7])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709027c8e00b001e3e244e5c0sm17972774pll.78.2024.04.28.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 00:03:06 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [RFC PATCH] spi: dt-bindings: ti,qspi: convert to dtschema
Date: Sun, 28 Apr 2024 12:28:59 +0530
Message-ID: <20240428070258.4121-1-five231003@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.8.ge326e52010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert txt binding of TI's qspi controller (found on their omap SoCs) to
dtschema to allow for validation.

It is however to be noted that it is not a one-to-one conversion, in the
sense that the original txt binding needed to be updated, but these
changes are included in the dtschema and are mentioned below.

The changes, w.r.t. the original txt binding, are:

- Introduce "clocks" and "clock-names" which was never mentioned.
- Reflect that "ti,hwmods" is deprecated and is not a "required"
  property anymore.
- Introduce "num-cs" which allows for setting the number of chip
  selects.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
I'm a bit iffy about this one as I guess the original txt binding failed
to cover some things about the properties.  I added the properties based
on their use in the *.dtsi files when I grepped for the compatible string

        arch/arm/boot/dts/ti/omap/dra7.dtsi
        arch/arm/boot/dts/ti/omap/am4372.dtsi

I also looked at the probe function in the driver for it, which can be
found at

        drivers/spi/spi-ti-qspi.c

 .../devicetree/bindings/spi/ti,qspi.yaml      | 94 +++++++++++++++++++
 .../devicetree/bindings/spi/ti_qspi.txt       | 53 -----------
 2 files changed, 94 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti,qspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/ti,qspi.yaml b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
new file mode 100644
index 000000000000..77cabd7158f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI QSPI controller
+
+maintainers:
+  - Kousik Sanagavarapu <five231003@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am4372-qspi
+      - ti,dra7xxx-qspi
+
+  reg:
+    items:
+      - description: base registers
+      - description: mapped memory
+
+  reg-names:
+    items:
+      - const: qspi_base
+      - const: qspi_mmap
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: fck
+
+  interrupts:
+    maxItems: 1
+
+  num-cs:
+    maxItems: 1
+
+  ti,hwmods:
+    description:
+      Name of the hwmod associated to the QSPI.  This is for legacy
+      platforms only.
+    $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
+
+  syscon-chipselects:
+    description:
+      Handle to system control region contains QSPI chipselect register
+      and offset of that register.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle to system control register
+        - description: register offset
+
+  spi-max-frequency:
+    description: Maximum SPI clocking speed of the controller in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/dra7.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    qspi: spi@0 {
+        compatible = "ti,dra7xxx-qspi";
+        reg = <0x4b300000 0x100>,
+              <0x5c000000 0x4000000>;
+        reg-names = "qspi_base", "qspi_mmap";
+        syscon-chipselects = <&scm_conf 0x558>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
+        clock-names = "fck";
+        num-cs = <4>;
+        spi-max-frequency = <48000000>;
+        interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
deleted file mode 100644
index 47b184bce414..000000000000
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-TI QSPI controller.
-
-Required properties:
-- compatible : should be "ti,dra7xxx-qspi" or "ti,am4372-qspi".
-- reg: Should contain QSPI registers location and length.
-- reg-names: Should contain the resource reg names.
-	- qspi_base: Qspi configuration register Address space
-	- qspi_mmap: Memory mapped Address space
-	- (optional) qspi_ctrlmod: Control module Address space
-- interrupts: should contain the qspi interrupt number.
-- #address-cells, #size-cells : Must be present if the device has sub-nodes
-- ti,hwmods: Name of the hwmod associated to the QSPI
-
-Recommended properties:
-- spi-max-frequency: Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-- syscon-chipselects: Handle to system control region contains QSPI
-		      chipselect register and offset of that register.
-
-NOTE: TI QSPI controller requires different pinmux and IODelay
-parameters for Mode-0 and Mode-3 operations, which needs to be set up by
-the bootloader (U-Boot). Default configuration only supports Mode-0
-operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
-specified in the slave nodes of TI QSPI controller without appropriate
-modification to bootloader.
-
-Example:
-
-For am4372:
-qspi: qspi@47900000 {
-	compatible = "ti,am4372-qspi";
-	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
-	reg-names = "qspi_base", "qspi_mmap";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <25000000>;
-	ti,hwmods = "qspi";
-};
-
-For dra7xx:
-qspi: qspi@4b300000 {
-	compatible = "ti,dra7xxx-qspi";
-	reg = <0x4b300000 0x100>,
-	      <0x5c000000 0x4000000>,
-	reg-names = "qspi_base", "qspi_mmap";
-	syscon-chipselects = <&scm_conf 0x558>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <48000000>;
-	ti,hwmods = "qspi";
-};
-- 
2.45.0.rc1.8.ge326e52010


