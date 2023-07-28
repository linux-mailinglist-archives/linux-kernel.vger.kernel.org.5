Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE816767636
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjG1TUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1TUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:20:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F2119A1;
        Fri, 28 Jul 2023 12:20:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962c226ceso37566871fa.3;
        Fri, 28 Jul 2023 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690572016; x=1691176816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYEWkHSYcduFek+PO+7j9FDj8sl1ZVG8Sli0W6im7aU=;
        b=siTBRNtsAvOAVYQ/uzSXsPLB+yZ4GKo8hMFmknQaZMGLxZE5Y2Alif88gEIVBjN6Et
         O4NA1PIL8qxSk7G9qGdjvdhCPSTyJIOc8MXcxT2DEELStTq7rWZ4OQYe/QklCaAozHaX
         nMtlHcgNajI1AuA/uZxX12n6okwkfgsKX2pvnadHxXtDYlve6sHV0i8eh/+C8znQXOfH
         pkVv2rauxlCGxE+IgdCFqDGA5VChUMoJYoJDbWgQ6gEIZS10FXCAwtB3Z3/bcD6FT0j2
         rIJ7c0Iu3WX6EvPErA93GqI9EnvbYR37erHtBhehuHRbUXX+iu89ipsoj2kgZB3l7gwP
         T7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690572016; x=1691176816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYEWkHSYcduFek+PO+7j9FDj8sl1ZVG8Sli0W6im7aU=;
        b=GEi+GHTpCUPLknMh+wzeUNs0Z3OmmiyDEGblEBjhW3Zqb6yLPOHuMbVmS3fBKgPDp8
         flrLbJAXy7DfaAa1yCFIbf+iUV1zQCKlW/HZZFc8tois61CY76oOQlKpzMrmqcTijdAD
         M5BAhx0q+oxy0APYXZmvovlA/TJgnKx7VuWUCqSPxqfizXbm9TSa6l/MVQ7+BIUbciTv
         QDubG+JE2z0TNdlQIFMPCNksRBgbtVZiOfj28YdtiRFgs1dPvzjaxxLly7neup3RcXKZ
         xyAryVx2oakAsDG5UjOOwX+Kc3Itysr7RNxAQs2zACSl7pCQNqymImUDDN8i8CYuFUi8
         d8Lg==
X-Gm-Message-State: ABy/qLaWgKs86jsFNDG29xx8/JyylQYJ+MHHU1ccAhZaqMPODgvwy9RQ
        KCHD168m53n9wXTlc8FqEt0=
X-Google-Smtp-Source: APBJJlGOhxk0I4bO1Wjypwep0rikNr3/mEj74cNkX53Mxi5voMhM70HT6skZ74ciz5OPnXhNoP8MqQ==
X-Received: by 2002:a2e:958b:0:b0:2b4:6bc2:a540 with SMTP id w11-20020a2e958b000000b002b46bc2a540mr2744363ljh.15.1690572015764;
        Fri, 28 Jul 2023 12:20:15 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b0098ce63e36e9sm2394909ejb.16.2023.07.28.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:20:15 -0700 (PDT)
Date:   Fri, 28 Jul 2023 21:20:13 +0200
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
Subject: [RFC] dt-bindings: gpio: brcm,kona-gpio: convert to YAML
Message-ID: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
RFC since dt_binding_check is giving me these errors/warnings:

Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dts:21.23-34.11: Warning (interrupts_property): /example-0/gpio@35003000: Missing interrupt-parent

The old txt bindings and all current DTs do not use interrupt-parent AFAICT,
so I'm not sure what to do about that.

Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dtb: gpio@35003000: interrupts: [[0], [106], [4], [0], [115], [4], [0], [114], [4], [0], [113], [4], [0], [112], [4], [0], [111], [4]] is too long

Here I'm not even sure what the issue is.

 .../bindings/gpio/brcm,kona-gpio.txt          | 52 -------------
 .../bindings/gpio/brcm,kona-gpio.yaml         | 77 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 78 insertions(+), 53 deletions(-)
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
index 000000000000..9d0b0a1af832
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
@@ -0,0 +1,77 @@
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
+    maxItems: 1
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
+        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+                      GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
+                      GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
+                      GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+                      GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
+                      GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
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

