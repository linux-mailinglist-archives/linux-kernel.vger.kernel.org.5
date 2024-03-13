Return-Path: <linux-kernel+bounces-101086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F4A87A221
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B2A2825B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66C1642A;
	Wed, 13 Mar 2024 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ0jq3ZY"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B980134BE;
	Wed, 13 Mar 2024 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302254; cv=none; b=Skq+RLWKbn9JD34ESVvsL9BRcnc/Vg6Any/bZBSDfLUQhySTXpQ/LdNzunhcxxZ+M14RRLR8RMaX9m2z4WoaGwGuGZiTZNxkS48dWDobiYKzCXpjDo9sIKV4Xlybip9QVPaY2C2KyOAn1MPvEV61HtfWK9OAZDATTs94C93aCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302254; c=relaxed/simple;
	bh=wvsDcCz4V8ckm6Y5cmx24jz4vCItdVXP3OrMJQUAD+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYjDiMNCQPoyYBK/Ud6TTX9mnhJjexEY8vw9LXLFccW8wZ5Tn7Ah4AsLGBav73YFEWAc4fC2nlR0P51ug9gBelru3lITlEgaF3/HEhiyVSpZ34fT7DDZCDKIYw13obyfPRsf8TLSMcihncr6XIoXg4wq0p7kdKIRnK9PPbL3YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ0jq3ZY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a057b6601so42645377b3.2;
        Tue, 12 Mar 2024 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710302252; x=1710907052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=MZ0jq3ZYaB7fx49bQ242mG353zU8JKh8VsbzorwkhKwuyoLKaEK14dtPhVD4nTEbSS
         XoP1c5bvetXqN1m1/X5sEzn5HJ/8Gm1aRUFbJtUVuXpxAEfywM8aCEXe1fxElOHVlvES
         /RUR8u+qeagEHXLo/+DhN+80tvKazfEQSfwjwp+gDd8WfcBOWZdv6Jmoqg2IX/eosJGL
         8noTDiTrVHoc99xffvt2JgAtwbLxrmvhvuueHIqZHn2latx27OGPIQ+UGIldqmXgtFUI
         /qsE+gEz/N2Tmijf+dxGAGcg+VpaemJQhoI6s61l5uFFvWMzzthjCZ4nk9r9tXiKfxIT
         iYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302252; x=1710907052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBNT1NwAXcdBlViFBBFgJVd26xGIToLjTiUG+Kqd4r4=;
        b=U7QnpNlqnZd++9947pceOpmCxHdaOM8KxZ7n9duM4Imu8z1Nx6MKoURM6DcpaTEvRV
         MeaxYSW5PZ27ZZlnOKSjMhXBxPx2OyQ9PMlRMC5VRtkJgzPBmPAP/lXCp7BEu5ZYYvbb
         Sf7bKi/ydWsasuVkVRHOmW51AlErNoMjGg2+QA+NmFzZUgIPy+6c/FEtXpCzTTFPsuaR
         4CasvCktFwLBISH9Ds5etbPe7ACSl/FztqeI20CNJ8l+exqzBWnstLHjTI7IY6CSoKuS
         ewA/98INSKOurVHOqocfuvi4LKJDSVoAPuzkdzODSrSUbnL5WYeAiAtpzztvbCANk5CH
         V5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT4Bv/nl4oGHvktZ5cPArsxtpfCvXnQneD7fP3k/ovL81NIsM+23qGn63Qm/pnZHpUxuPO5HKAyL9OHBSJ3fZtMaKZLRabpngUPv3PJKycYdL2YWerpok0IZ3pLaH174PNulehUlTENXTWT1e2A9xWxad0QhwF42acHXJiSSMlOLEtR44=
X-Gm-Message-State: AOJu0YwTQqhkr4V5xk0z8k5w9zl2IFytfoWE7Ef74gNIjWrLNamir8qG
	7UQufM+CQZ5JsRZ9gC4Sxok/sNUnUlHSqoeX0IiMwi3JG3NadPlkzYl1VaEX
X-Google-Smtp-Source: AGHT+IFeSx4vDBoy4d72XKzA4vxVgu7Fn7DUZSxchndF8QDvZkz7d+Ipebl1Cgwc8UXZs54swBsYXA==
X-Received: by 2002:a81:770a:0:b0:60a:1b1:5f61 with SMTP id s10-20020a81770a000000b0060a01b15f61mr1465017ywc.35.1710302251945;
        Tue, 12 Mar 2024 20:57:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a63fb11000000b005cd835182c5sm6721605pgh.79.2024.03.12.20.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:57:31 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date: Wed, 13 Mar 2024 03:57:18 +0000
Message-Id: <20240313035719.768469-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313035719.768469-1-ychuang570808@gmail.com>
References: <20240313035719.768469-1-ychuang570808@gmail.com>
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


