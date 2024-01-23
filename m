Return-Path: <linux-kernel+bounces-34867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC61B838883
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAA61F23954
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30AA5788D;
	Tue, 23 Jan 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrDo3ZqL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535056B60;
	Tue, 23 Jan 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997211; cv=none; b=j7MgUaK7wXNv7a9Mm6TWrCTKFWN6Jn/75qb+6qDiqEAlci59Do8V+JwNqsz8r6iuopjxyUTiMlx+jTJtL69bMzvCkJdIrPHiDJ1QLr4Eu7QSYYaA2cosELhKqonaUlvbSvFjHKNbkxxXC2Nw5rLcPCQwC5chbPQCZqsambG4fiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997211; c=relaxed/simple;
	bh=v5sneS2A4DjdvNMff8CoWh0i5OfqEkAj1LFAZatPbzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptkU15HdKjXNyL65+9dYXJ+uxzM6OQqYQj+dgWx/uXAO+qws7wBTte9P+fNwZKr11wvuf5wiU9sgB6hYXOUj25Nq5xyt+P0+4hHizhYBqq15yFoWMwiAFLlvpmwI5Q/eWJzGod4APhmK6A0haI9DExLwroypgnhaAZMIb1gA9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrDo3ZqL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70b0e521eso29039175ad.1;
        Tue, 23 Jan 2024 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705997210; x=1706602010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi+Ee4Ra75GhWDNWvzS2HrP3/rPXxeeFPkLpeIHFmOs=;
        b=GrDo3ZqLOMuNUDhIEp3JzLgdEqmWlWBOKn9JVgGDIEcoa4MOPgP8bY/JQBNsxU3MXO
         v7eZpGgSPrpvfGF4eG/L3MjPGxDgkkjzOys3++RszAz2RJzocmL4IGuehUcrpbLPF8oC
         PtNjBSjm7qAodFKUqPq5Jtq685G2ImDBC/7p1HGjSKC5mE7zmgvAkjM2ePlJm+1XRtZJ
         DWvX116RQx/H/Sa5eGOAxgvSXMgSTtoN+rilCZhd2QfH+I1eFYH866gzdG+6RUT41gzh
         BnW8c5TNzI7adSUBgkqahdiDaA9idQvrVR1IDoiMKRJ3l/v+IvSdsmP4td8D1vFr7Vjs
         rFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997210; x=1706602010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi+Ee4Ra75GhWDNWvzS2HrP3/rPXxeeFPkLpeIHFmOs=;
        b=sh/Pg/qfUGlS366CqFGF4ViEv2kEAtcNnrSwRRiF107nCBLgCF67IYZ9JAG2V+g6wS
         5wjaSq3qJEM3ktSkVMmV4nHHuHjM54jtnm9FEr6iOxRAeMLZJAhOoUew5HIJAbNHSdFU
         ZADG9I1VHNed/fK+XYdu14u9Kyz2nmk8ukVbHdh4gGBMI2jyrUoMUbBtDVrQZyMVUYXi
         3Sejf7jNufDrkLYoLENRXvQ4vwqLa1AdydsEnTvmbff/B8XBsifdftPyFaVAY846+8B7
         YTYL40C3g9oE5GtE5Gm14RmADEz8aRvZAQhOEEUW6aMJdDXlrLEx2rhWzPXohxZWRxaD
         aRYg==
X-Gm-Message-State: AOJu0YyhFTYItxawxTIHNFpUAbDQxnHIyiGsOzNLzW5jEmyt4n4aaB1I
	kJ9jy/IarWXjEj3L3P2oQQfocRMhjUWYsYaywvG1rehaXahxtvrN
X-Google-Smtp-Source: AGHT+IFErPq6uFCZtDpyn596RQZuTBtMTjk1QHyBDKK2gRehaIXlTLm33J3d8lPxw/fr+4EUIMq1nQ==
X-Received: by 2002:a17:902:c409:b0:1d4:c313:8081 with SMTP id k9-20020a170902c40900b001d4c3138081mr7671458plk.129.1705997209814;
        Tue, 23 Jan 2024 00:06:49 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001d4816958c2sm8277113plt.166.2024.01.23.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:06:49 -0800 (PST)
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
	schung@nuvoton.com
Subject: [PATCH v3 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date: Tue, 23 Jan 2024 08:06:35 +0000
Message-Id: <20240123080637.1902578-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123080637.1902578-1-ychuang570808@gmail.com>
References: <20240123080637.1902578-1-ychuang570808@gmail.com>
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


