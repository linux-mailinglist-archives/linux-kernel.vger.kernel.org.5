Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD5768633
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjG3PXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjG3PXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:23:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3C1A6;
        Sun, 30 Jul 2023 08:23:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9891c73e0fbso774456066b.1;
        Sun, 30 Jul 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690730615; x=1691335415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PX8xKK6O5wTvwtcUjC9IemCaEOi5PCdC3MyRdH4mEU=;
        b=ZZeauXSqR4Gj+o9zgwWzvae9cSHIy1Q3fNln5iTZWZPGQudHC/xIEOv4XI+4ebjwx9
         PrGZbv3RrQcMu4eSUDzWFTPBzGLkLYIHaZifRFnrzQ1892eXnLQn3pspUoIyLndhnlPt
         oGSUIZlWK80gsqBpIXuuX4Im0uGOqtIwYRX4dlihJb9s4VXDthECEGX3i6XxKEqosebq
         MBMoGhtV68DIizvmu9acc8zY9Ew7m6eQlKgDOqMVnCgGFBEWYeDLgIRwy8gCmvqSnmPB
         vTqbMX9wZ6KVt0rlmexLjunx30Ldo5kSO76VjFksq+E9uXgIUK1czxFRkdeBYy3VrT3i
         TS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730615; x=1691335415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PX8xKK6O5wTvwtcUjC9IemCaEOi5PCdC3MyRdH4mEU=;
        b=EAUnDuqENXEDM2hO9XderGMt4iuZGIOniy01Ny5RI81Cwo1kc50OVfEgGGJc05sOY3
         mkLFIdWifmqLTEv3L5Y6oh9/TFQm6FxLabvMjBRuYQzqP+dEueFA7eq/wMd2W1Qzj1YI
         OsFMBpKpkAagL8gUGXTQ6W3f1TkC3EFM1mxZwWo/3UNe4/a4IxjwDycykRLbIwWrWI8a
         Rxq/+U8fhTjoUcSGOAqe0dWx+D8S32KzXZP6/lkUR+2Brrh+Gv9E8Ut5dx2sPCjjGgRn
         N6zJuHfDIos/Md7R3KnSGaL3XQjMDOvhm6pN/G2Pie8oAlwInczeAZz/tME6Hxq98JP0
         b1Cg==
X-Gm-Message-State: ABy/qLY0HI0m4k1cTHHwKutGGljy9iJ831o62NTnQwd+nAju2ZXDtzk5
        H8qYNRVbTgB2I1YYcMin97MbPnN8iGY=
X-Google-Smtp-Source: APBJJlHQ3IYa7n9r9AgEUAqsmkPfnF5daq7th+7HqRWkx3Qk1N6gibmKlrcWC8pXoXPYmgr5B+NkZA==
X-Received: by 2002:a17:906:304f:b0:99b:4bab:2841 with SMTP id d15-20020a170906304f00b0099b4bab2841mr5425707ejd.26.1690730614887;
        Sun, 30 Jul 2023 08:23:34 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b009934855d8f1sm4733868ejr.34.2023.07.30.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:23:34 -0700 (PDT)
Date:   Sun, 30 Jul 2023 17:23:32 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: brcm,kona-gpio: convert to YAML
Message-ID: <ZMaAdG9Zj9AL1NiR@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family GPIO controller bindings to DT schema.

Changes during conversion:
  - add used, but previously undocumented SoC-specific compatibles

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes since RFC:
  - fix interrupts maxItems
  - narrow interrupts min/maxItems per each variant
  - thanks for the feedback Linus, Krzysztof :)

 .../bindings/gpio/brcm,kona-gpio.txt          |  52 ---------
 .../bindings/gpio/brcm,kona-gpio.yaml         | 100 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 101 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
deleted file mode 100644
index 4a63bc96b687..000000000000
--- a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-Broadcom Kona Family GPIO
-=========================
-
-This GPIO driver is used in the following Broadcom SoCs:
-  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-The Broadcom GPIO Controller IP can be configured prior to synthesis to
-support up to 8 banks of 32 GPIOs where each bank has its own IRQ. The
-GPIO controller only supports edge, not level, triggering of interrupts.
-
-Required properties
--------------------
-
-- compatible: "brcm,bcm11351-gpio", "brcm,kona-gpio"
-- reg: Physical base address and length of the controller's registers.
-- interrupts: The interrupt outputs from the controller. There is one GPIO
-  interrupt per GPIO bank. The number of interrupts listed depends on the
-  number of GPIO banks on the SoC. The interrupts must be ordered by bank,
-  starting with bank 0. There is always a 1:1 mapping between banks and
-  IRQs.
-- #gpio-cells: Should be <2>. The first cell is the pin number, the second
-  cell is used to specify optional parameters:
-  - bit 0 specifies polarity (0 for normal, 1 for inverted)
-  See also "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
-- #interrupt-cells: Should be <2>. The first cell is the GPIO number. The
-  second cell is used to specify flags. The following subset of flags is
-  supported:
-  - trigger type (bits[1:0]):
-      1 = low-to-high edge triggered.
-      2 = high-to-low edge triggered.
-      3 = low-to-high or high-to-low edge triggered
-      Valid values are 1, 2, 3
-  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
-- gpio-controller: Marks the device node as a GPIO controller.
-- interrupt-controller: Marks the device node as an interrupt controller.
-
-Example:
-	gpio: gpio@35003000 {
-		compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
-		reg = <0x35003000 0x800>;
-		interrupts =
-		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
-			GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		gpio-controller;
-		interrupt-controller;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
new file mode 100644
index 000000000000..296fdd6b8f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/brcm,kona-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family GPIO controller
+
+description:
+  The Broadcom GPIO Controller IP can be configured prior to synthesis to
+  support up to 8 banks of 32 GPIOs where each bank has its own IRQ. The
+  GPIO controller only supports edge, not level, triggering of interrupts.
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm11351-gpio
+          - brcm,bcm21664-gpio
+          - brcm,bcm23550-gpio
+      - const: brcm,kona-gpio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 6
+    description:
+      The interrupt outputs from the controller. There is one GPIO interrupt
+      per GPIO bank. The number of interrupts listed depends on the number of
+      GPIO banks on the SoC. The interrupts must be ordered by bank, starting
+      with bank 0. There is always a 1:1 mapping between banks and IRQs.
+
+  '#gpio-cells':
+    const: 2
+
+  '#interrupt-cells':
+    const: 2
+
+  gpio-controller: true
+
+  interrupt-controller: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#gpio-cells'
+  - '#interrupt-cells'
+  - gpio-controller
+  - interrupt-controller
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm11351-gpio
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm21664-gpio
+              - brcm,bcm23550-gpio
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    gpio@35003000 {
+        compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
+        reg = <0x35003000 0x800>;
+        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+        #gpio-cells = <2>;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        interrupt-controller;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 733bcfa0209a..368fee1ef5b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4221,7 +4221,7 @@ BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
+F:	Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
 F:	drivers/gpio/gpio-bcm-kona.c
 
 BROADCOM MPI3 STORAGE CONTROLLER DRIVER
-- 
2.34.1

