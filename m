Return-Path: <linux-kernel+bounces-162606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDB8B5DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA18B1F21D49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41F8289B;
	Mon, 29 Apr 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHC/oj5X"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0B82498;
	Mon, 29 Apr 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405504; cv=none; b=cai1IluAkRRAo/aDcPbPxlMsfozrB2dibPBbqs7kyEXB3TNxYzYeR7pmJIVlIIHkmPeyO6W3cU37GpYCHqSZtyG8EreokjUMYiqCp29OgM1MgMbYMPSlKMei1FJFPpE3z/YxuZIkOLoyUnrVzyEWK0rV2plHh5Om0e+eE4/cKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405504; c=relaxed/simple;
	bh=XwzkrXLO6vx+SR42imzQ68UrIetXiXjTzt8yHJHoysk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFK9Q7gqfGZZFQ7JCVae5+F9UxIxUk25G/zlBetaVXc/TetTAggo5Lrn7XzrxAwe4gFELaarsFGQAy5uNAgWztwQqdOrvxQGT5xTGcE6FulBJMpSU2/Rrpc7LraMmGXrMv9LYylO7Ty7Px+sCIhxbCp3qEgbj5T6InEgHN73q/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHC/oj5X; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ad2da2196aso3136103eaf.2;
        Mon, 29 Apr 2024 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714405502; x=1715010302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsixJocqKRrJSdTlkXXMM1uFnu6GRPalHDiE6LQw+iA=;
        b=BHC/oj5XKFWx5sR52jh7JP7rnTERuscqx0p3GVe66ow0ChiIu7bcNu4h+3B4Dict1z
         vuw6H3LQs5MOykkPsxKbCyCKlmfqUaM9ZwmBCuqB65V+gz5boPWr3eNyPNtIEIRdV/hh
         k51x0CLVJeof09F0AmD/QTiA9q6ms2jtcw+f3inkPYNNpfFd1uYiQojUsiqxizU2Eh1b
         QJtDfl3g7C2CkfVPgjnpRxXbj1mLanv5odJEl9s7eUbVpKKMmsDfeSx3/ZWhXD0rj8fs
         lSdO0h/JIFEX3TE4OkER/eQSL8yFVnzuF0bZA4OUsWw6PhC6HXnig8nftV1xtRH4I49H
         z/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405502; x=1715010302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsixJocqKRrJSdTlkXXMM1uFnu6GRPalHDiE6LQw+iA=;
        b=LYasco//IQ7W1FFxWtsAFcl3ui7BAlDr9EbhB5S2d2qXoX9Bk9cLaGLk6fhMMEOv4s
         YfNOQ2BMCRZRUSVHrt7YUtJhbeBcQV7k8g27xsUwrlJbn2IoNhETe1kk3RuoFG5tSjkL
         HdW5JyaWVb1LSNO6bQD0rIvEvZ5Kiiyu/6ugEt7g8fdLkmifyD+NQwvjRCs5wpi/JUTn
         QkrnBjZHR/8P7m/eIG394u2QfgC/RGsPsbpR553KEOaVxRarM2lCeT6e4bmfkWoIzDzI
         WEAlm6RbFn212dX+RBWxTel/ruVVdAibkigSH0rP38N6gE/QZ7r5tk375fmKM0z/MbCi
         w4nw==
X-Forwarded-Encrypted: i=1; AJvYcCWdVaB1+uHAyoqB0A332K/8dPn6OTzXdAEhzp21TILD+vieo2FmPmypZrU09qq3ubUy+mUsKtqmVxWOejYswWlLh+3bCRFV4OZRvjbD3FZyPbsBEKj2tyFnxdZMLI3eluhBG9D0B2w6Zw==
X-Gm-Message-State: AOJu0YxDKLsIF2WMwwJ/6JQxoLM9bgusc+OUNXpDxnw5AgDwl1EcNuad
	8+q9Vc8DZfHfJ9ghNlAyuPZylLmYSqeQ5aN+0n6JtVCFz58yeRiQ
X-Google-Smtp-Source: AGHT+IH2UgungYdtxm6RWWb0CTysruEWgx9cRu6/hWTC96VlZGZxvb4MgrNcWHjjmfynT6Lw0kE7dA==
X-Received: by 2002:a05:6358:990:b0:186:3c3:b40f with SMTP id t16-20020a056358099000b0018603c3b40fmr9375082rwi.20.1714405501887;
        Mon, 29 Apr 2024 08:45:01 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:99f3:b2ed:50d6:5ff8])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm13125169pgl.30.2024.04.29.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:45:01 -0700 (PDT)
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
Subject: [PATCH v2] spi: dt-bindings: ti,qspi: convert to dtschema
Date: Mon, 29 Apr 2024 21:14:21 +0530
Message-ID: <20240429154443.5907-1-five231003@gmail.com>
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

The changes, w.r.t. the original txt binding, are:

- Introduce "clocks" and "clock-names" which was never mentioned.
- Reflect that "ti,hwmods" is deprecated and is not a "required"
  property anymore.
- Introduce "num-cs" which allows for setting the number of chip
  selects.
- Drop "qspi_ctrlmod".

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
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


