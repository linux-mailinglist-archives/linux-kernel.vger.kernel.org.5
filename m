Return-Path: <linux-kernel+bounces-54221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5E84AC63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834D11F252A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E46EB78;
	Tue,  6 Feb 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHR35C3D"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2E6EB5A;
	Tue,  6 Feb 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187958; cv=none; b=VjHZG64ndOI16OgGltBpCxnMqEfIcZbGjtguCn+mC6coiAzBRndfbqqbH/Bh7hyGmuX/ukKG67lawvuk7fPJueZI33UyfLQhzJSgnAf15kk0kMO4Up8ny7pdmrS38G6CA36172WCalRxCmq7YmyfS+uVDpAxitb5+SgPjzhwrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187958; c=relaxed/simple;
	bh=wvsDcCz4V8ckm6Y5cmx24jz4vCItdVXP3OrMJQUAD+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItZTxektsdqazuXPO2JZxVVU+iDmok4bVNnma1jKUkj2+K2NrTZxBRNIc0FHMgoifA30xcpWp6brgOqCJJrWDSsNtCWhzwdG/uIafK5u0w6fHIB5qnNwWeLbWSjxh32c9jMqaueKF9eNzaKTyP/7y74odSDGgrA1JafcapthXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHR35C3D; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2af0bc0dbso161733a34.3;
        Mon, 05 Feb 2024 18:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187956; x=1707792756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=QHR35C3DX+N/L/lAndpEggtYLoBqS3Pr0QLmMFgs6ro+cZEZ/L0p+LM175LrgOvBFm
         9yCh5rx+ynz6xPVKn3xYpsusDG28aKyi56cxxKT5EFtZ9MmhRzgM2ZiZHWuKlnz76Yp8
         /Me+6Cu8b5e0g9KskMZalp1oYwlAi3N80HIibS6ZirDplaFsG8fgmulDLCjmEhG4Zngw
         9GAy5jAYLIroqlWHJaXtGlKNZQuQLCzS/qG/n5XXuUsT75TgZ5yHxxSQRpl1e/UUyATM
         M1XbZMsP+VawO7J+nLzsJp7z7PqTrC15qetSSUzswrUs7Uix5dUsmevqQTD/EiyAn2Vc
         1q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187956; x=1707792756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=xTohcIF969CwWgA7lDqE0jFis7luZ9MVyy6D73p32U1ZGjOeBIr7+eW8lFD+IqkKdA
         uF9Vne1NUrzBWzw1ybLlN7fRaBYS8mualKUostGAR/7+KZjiUQifV9x05GuRY4ceo6vo
         6YXTUjP+88rJIVbTUBRXbwacgvUwhl0oMffaMsTHld55qEZcNMBxvrwDVQ2RxT9gOMm9
         srYL5zCrh017AI+GkYhPBOY47y26nb4A4QbWOp+9O3ry/jk+zQxIMBDeTkBkUttNImTm
         RuPtnPY+bc22CS9r0lXikdeOK6WH0KKmUJDuaNw0PsAK21a2bmGzvZ/NAHAbOFvUvTqw
         9zkQ==
X-Gm-Message-State: AOJu0Yxm3TU54vDxZV/heN2A8pKAbkaQK5C0Tvb0EE8warwZ0WJGvUoF
	KQH/HxzEv/lkPf9qqb3BS75MKFbehPMeMdd/5crA7o/Iu1a0ufxg
X-Google-Smtp-Source: AGHT+IGG2uwJK1vlaQXIVf7s5zRntyAXi3MOw1wMjwDphpL5SEOFWvLMLGmIslGGVyvnqzDuSynN/A==
X-Received: by 2002:a05:6808:2e97:b0:3bd:956a:1aa3 with SMTP id gt23-20020a0568082e9700b003bd956a1aa3mr2258933oib.57.1707187956241;
        Mon, 05 Feb 2024 18:52:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGsOqzk2uWYkbvhahWgRpYekp9V5oMiWaATOu+kYTYylil/2Zdsvg5UafjOF01IOU1o4ahwiNQWhRrEls+wJb9H2RTEqG1vOX49Pz7cU9tD78mycyM9yx9DTSKzey4gyQWrWskybpDC7OJve99cLL2fKECArwn7y8YgFFSoKWPcMAZnfXZs/iiqi4OkwlgBAt/gh96Bin2Y9hueRaUhYnpLFJ9JIZweHCKn+pRpm45KKOANOeRmMO4lb+ViElGY/enouM+8dgtWavj56lDuufa2PrJkZsHzVaclD9k35QkCrNXmQpGG7MkboqITKyU2Mor9MlBCYBsHJV0dQD3dWn3+1M+zxqE7XvYlycTY2puhNqK49g7JylfAr/ndJDyELbNpsInfBrubjclfXGYrF3Yi8y2DX8JaDvZ0HiFgK2XpQpk/e1hHQE++g==
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gx22-20020a056a001e1600b006d94291679asm622542pfb.78.2024.02.05.18.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:52:35 -0800 (PST)
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
Subject: [PATCH v4 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date: Tue,  6 Feb 2024 02:52:21 +0000
Message-Id: <20240206025223.35147-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206025223.35147-1-ychuang570808@gmail.com>
References: <20240206025223.35147-1-ychuang570808@gmail.com>
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


