Return-Path: <linux-kernel+bounces-72153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033D85B017
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CEB22D19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4220308;
	Tue, 20 Feb 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOVtWsyM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB417545;
	Tue, 20 Feb 2024 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389733; cv=none; b=XMu3a8c2F8Xn/icTXDSJ5UpboaLt0M5PW0egU8O+JaGGlCJbR07+lFLhqeUdjvqgMbslz92XhaT/gvYH8F3Zy6bECQnVvuTeXh3y5Clw/4V1t0t4rRggYqf6hfselgiADyUjvpL0AysN/GOnQlWiFawQHBaJx/IXjVIKEkmpMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389733; c=relaxed/simple;
	bh=wvsDcCz4V8ckm6Y5cmx24jz4vCItdVXP3OrMJQUAD+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU4OGZKvFzC5nZI/6nedXzpBfYpBfb0RPB9IgJqHzv1ZRJX4PrA6yNMFtYBkvGVbgH4lA321HlAEp/BtbGOEDCfczvxhcBqRP0Zd5eP8MHb9aFVzCB566h6LzpUN0yBqbAyw+9mWgXbWngXuCDrupkathN696GBjVZRlnEuMGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOVtWsyM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so24266b3a.2;
        Mon, 19 Feb 2024 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708389731; x=1708994531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=lOVtWsyMAoR1shtesMzlxXSkU+jyZGI9Ks93i4UXE+7J9SWfZ6wq1073IZIhAmUjQZ
         cBxo2jki4rn59l2EXoT6TgKwOHHCvUE0h6an0vhm3Nv01oSaT7twQzVTUh4vElreGkUg
         ndfFWg02AIpzW+tToJ1JHXSWfJxACJqqLb2hKFctjrJLon/VN4277lTKoqWWpobwJdyg
         rAkcdgsXDmySfZ7x5LRCHFAokayac3IbeHlDFed+DSqUX6uIQiJuCSoXhofEQvEPO0vK
         M6lcUaSG0kNS2DCYwbhRVOX1wU8/kY/7yChfMQv8aL2oCAx0idwy4tia+VvAEX1XypRL
         sAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389731; x=1708994531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=oMmgvZcUnN+GMSkM9m3in81VdOy6wBOsaIK+sHLGkKyCIcGSAlCiihqOsYQT3fqdpv
         gEuxWFiuAkAS5cqqAn5/jN5oPbtoMoG7ZIr79ItTdSXt0Ln2p26GJi/AnclvlRE/bb8R
         hLJlwxyKB7yFdVxrbwZblev5mITe0sn6owgdFPl0X6dxSrjGwPLILmlEBl8mgXhy+yCZ
         xdrWHdc/qZUxX9NeiTVNIE3Anwq/J2+asIACQ99r/sKwoJjrkVnf3CKsmWQKZudODyVf
         hQQ3UGaEITnslkUonYmc3zoI7J/oUsSt8T4HHWG+9rjBG7ik7AkqwZ1XqVd/KpITrWer
         g6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWLLQYA6bv1uYMZIrBqo02hLHiRX7YIo5qfZiSV+/YQie81vuA3DgK/w+xShWBx1N5J64iRD/lcSjNgv7GaEMqj3tt/EDUg3YYR0/UxXHm86ny03B2ACWjpmQVL5zQHv9mjb0e30D0K5LWAS1pQLzdP01iCRHeTDjx4O/Gep1fCHqprnNE=
X-Gm-Message-State: AOJu0YzPYjBfTDilGy8nOz7qybG7zqIqD7aIIfWr/xZOTY9EiCQMM0Up
	YOUKW8PmhVWhhwdW4AfhZxtQTN5kuXMhxj9F2M1KofirN1RckfbD
X-Google-Smtp-Source: AGHT+IE6bKNKyKZ3hqK5XTHVqzc2/53Dn4fQop9JMbvvzjDeglOR0sPQgvLjWxBf7gPMIJPZQmYZQw==
X-Received: by 2002:a05:6a21:1394:b0:1a0:9b59:c167 with SMTP id oa20-20020a056a21139400b001a09b59c167mr6984082pzb.35.1708389731369;
        Mon, 19 Feb 2024 16:42:11 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id cz3-20020a17090ad44300b00299bf19e872sm1831393pjb.44.2024.02.19.16.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:42:11 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date: Tue, 20 Feb 2024 00:41:57 +0000
Message-Id: <20240220004159.1580108-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220004159.1580108-1-ychuang570808@gmail.com>
References: <20240220004159.1580108-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 pin control and GPIO.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
new file mode 100644
index 000000000000..8b9ec263213f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 pin control and GPIO
+
+maintainers:
+  - Shan-Chun Hung <schung@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pinctrl
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of the system-management node.
+
+  ranges: true
+
+patternProperties:
+  "^gpio@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    properties:
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+
+      interrupts:
+        description:
+          The interrupt outputs to sysirq.
+        maxItems: 1
+
+    required:
+      - gpio-controller
+      - '#gpio-cells'
+      - reg
+      - clocks
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts
+
+  "^pin-[a-z0-9]+$":
+    type: object
+    description:
+      A pinctrl node should contain at least one subnodes representing the
+      pinctrl groups available on the machine. Each subnode will list the
+      pins it needs, and how they should be configured, with regard to muxer
+      configuration, pullups, drive strength, input enable/disable and input
+      schmitt.
+
+    $ref: pincfg-node.yaml#
+
+    properties:
+      power-source:
+        description: |
+          Valid arguments are described as below:
+          0: power supply of 1.8V
+          1: power supply of 3.3V
+        enum: [0, 1]
+
+      drive-strength-microamp:
+        oneOf:
+          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
+            description: 1.8V I/O driving strength
+          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
+            description: 3.3V I/O driving strength
+
+    unevaluatedProperties: false
+
+  "-grp$":
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    properties:
+      nuvoton,pins:
+        description:
+          Each entry consists of 4 parameters and represents the mux and config
+          setting for one pin.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        items:
+          items:
+            - minimum: 0
+              maximum: 13
+              description:
+                Pin bank.
+            - minimum: 0
+              maximum: 15
+              description:
+                Pin bank index.
+            - minimum: 0
+              maximum: 15
+              description:
+                Mux 0 means GPIO and mux 1 to 15 means the specific device function.
+
+required:
+  - compatible
+  - nuvoton,sys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pinctrl@40040000 {
+        compatible = "nuvoton,ma35d1-pinctrl";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        nuvoton,sys = <&sys>;
+        ranges = <0 0x40040000 0xc00>;
+
+        gpio@0 {
+            reg = <0x0 0x40>;
+            interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk GPA_GATE>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        uart-grp {
+            uart11-pins {
+                nuvoton,pins = <11 0 2>,
+                               <11 1 2>,
+                               <11 2 2>,
+                               <11 3 2>;
+                bias-disable;
+                power-source = <1>;
+            };
+        };
+    };
-- 
2.34.1


