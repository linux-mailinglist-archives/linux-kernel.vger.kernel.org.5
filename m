Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314227E91B7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjKLQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKLQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:57:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FF1BEC;
        Sun, 12 Nov 2023 08:56:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c41e95efcbso551698766b.3;
        Sun, 12 Nov 2023 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699808214; x=1700413014; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byjIoGTRKKP6Yru0xo4Lk+ItPgk7g9H5HT4yy5ccjk8=;
        b=SRnwT5KQZ7J7yT+6RGsxu4bnoMVUSYbAOmsnjSHZtQT/9e8H5UVltFB/uFR+02rsM0
         4D+H/o9FtdOXtX50F0N+vM0WIdo4amxzBEp1N7HUlMsxaqxyyV/ETSTQGji7NvBROoBE
         2TbnjslaX9B+vDHeEDk+cP4lHR7x0j8jV+HRkYW4mysC8O9bSksD9miA0Ob4vkBhoykL
         XzMRyLQPjcIGn88xSYTzJGcUqeOYpSiIZFOVWssrzh8KHdkL22F9ogOMbalREuTJ3u46
         Hsjh/UOJA2y9YPW2JFNd5MvzHMOdcbZSNIWD8XBZHRdX2Pq7bUbAX1Pw0yrSmjhEz4WG
         DDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699808214; x=1700413014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byjIoGTRKKP6Yru0xo4Lk+ItPgk7g9H5HT4yy5ccjk8=;
        b=cOLGHghOTHaLk+dGvnAjlK6HqsLePkfbp/iEw9hEBU0eg6Vj/37fNQQhRXHA7wa6/j
         ZlGOT6AWJbsdughDzXSdCJMbl8ynsbbqBERi+FnQPG95QZK0PpGfm0dL9BJyE0tsb9Ol
         sdkiN8QsX2BiuOBhcrA5g8cflK6+szFxkPQM1xRTST+//GGHmCDTf8pwf3sSzf1OilT3
         1U4ehMBaur1XUbMETSjwRqK+g67n/NvyUqHqza4J0oJYCUUFPMwgH3M8vTkpWAP3eo9H
         zJGcpCYHIynjYfnYdY4f9G6Ej9X/DxeKIY4jKJpLXba4RfgV0Z+6kvJVMMpEQf7ziVw+
         0xfQ==
X-Gm-Message-State: AOJu0YwdXeu4x3Hp8/ucPun0XGVaWJBEUf+MBIbt/AOwdAD/gkDN4c2Z
        qNLDOuDKrKxYXCCg5SUSfKs=
X-Google-Smtp-Source: AGHT+IE2mS+jzq0gvdaQ/f1Ud55X/x9LNxKqr5zVlPWQxqv5EfYGnUe2Dh7isCAqmIeJ375FJ3fZvw==
X-Received: by 2002:a17:906:5fc7:b0:9b2:aa2f:ab69 with SMTP id k7-20020a1709065fc700b009b2aa2fab69mr2748317ejv.30.1699808214257;
        Sun, 12 Nov 2023 08:56:54 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906054900b00997d7aa59fasm2804273eja.14.2023.11.12.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 08:56:53 -0800 (PST)
Date:   Sun, 12 Nov 2023 17:56:51 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <ZVED01t3+coBd44x@standask-GA-A55M-S2HP>
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

Convert Broadcom Kona family clock controller unit (CCU) bindings
to DT schema.

Changes during conversion:
  - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
    such a clock doesn't exist
  - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
    such a clock doesn't exist

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V3:
  - collect Conor's R-b
  - changed reasoning for the removal of the 2 clocks to "such a clock doesn't
    exist", as it better reflects the situation
  - Link to V2: https://lore.kernel.org/lkml/ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP/

Changes in V2:
  - remove the table copied from the old txt bindings, replace it with if-then
    blocks individually listing the allowed clock-output-names per compatible
  - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
    it is not used in DT nor the dt-bindings
  - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
    it is not used in DT nor the dt-bindings
  - move allOf: after required:
  - Link to V1: https://lore.kernel.org/lkml/ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP/

 .../bindings/clock/brcm,kona-ccu.txt          | 138 -------------
 .../bindings/clock/brcm,kona-ccu.yaml         | 181 ++++++++++++++++++
 2 files changed, 181 insertions(+), 138 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
deleted file mode 100644
index 8e5a7d868557..000000000000
--- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
+++ /dev/null
@@ -1,138 +0,0 @@
-Broadcom Kona Family Clocks
-
-This binding is associated with Broadcom SoCs having "Kona" style
-clock control units (CCUs).  A CCU is a clock provider that manages
-a set of clock signals.  Each CCU is represented by a node in the
-device tree.
-
-This binding uses the common clock binding:
-    Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible
-	Shall have a value of the form "brcm,<model>-<which>-ccu",
-	where <model> is a Broadcom SoC model number and <which> is
-	the name of a defined CCU.  For example:
-	    "brcm,bcm11351-root-ccu"
-	The compatible strings used for each supported SoC family
-	are defined below.
-- reg
-	Shall define the base and range of the address space
-	containing clock control registers
-- #clock-cells
-	Shall have value <1>.  The permitted clock-specifier values
-	are defined below.
-- clock-output-names
-	Shall be an ordered list of strings defining the names of
-	the clocks provided by the CCU.
-
-Device tree example:
-
-	slave_ccu: slave_ccu {
-		compatible = "brcm,bcm11351-slave-ccu";
-		reg = <0x3e011000 0x0f00>;
-		#clock-cells = <1>;
-		clock-output-names = "uartb",
-				     "uartb2",
-				     "uartb3",
-				     "uartb4";
-	};
-
-	ref_crystal_clk: ref_crystal {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
-	};
-
-	uart@3e002000 {
-		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
-		reg = <0x3e002000 0x1000>;
-		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
-		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
-
-BCM281XX family
----------------
-CCU compatible string values for SoCs in the BCM281XX family are:
-    "brcm,bcm11351-root-ccu"
-    "brcm,bcm11351-aon-ccu"
-    "brcm,bcm11351-hub-ccu"
-    "brcm,bcm11351-master-ccu"
-    "brcm,bcm11351-slave-ccu"
-
-The following table defines the set of CCUs and clock specifiers for
-BCM281XX family clocks.  When a clock consumer references a clocks,
-its symbolic specifier (rather than its numeric index value) should
-be used.  These specifiers are defined in:
-    "include/dt-bindings/clock/bcm281xx.h"
-
-    CCU     Clock           Type    Index   Specifier
-    ---     -----           ----    -----   ---------
-    root    frac_1m         peri      0     BCM281XX_ROOT_CCU_FRAC_1M
-
-    aon     hub_timer       peri      0     BCM281XX_AON_CCU_HUB_TIMER
-    aon     pmu_bsc         peri      1     BCM281XX_AON_CCU_PMU_BSC
-    aon     pmu_bsc_var     peri      2     BCM281XX_AON_CCU_PMU_BSC_VAR
-
-    hub     tmon_1m         peri      0     BCM281XX_HUB_CCU_TMON_1M
-
-    master  sdio1           peri      0     BCM281XX_MASTER_CCU_SDIO1
-    master  sdio2           peri      1     BCM281XX_MASTER_CCU_SDIO2
-    master  sdio3           peri      2     BCM281XX_MASTER_CCU_SDIO3
-    master  sdio4           peri      3     BCM281XX_MASTER_CCU_SDIO4
-    master  dmac            peri      4     BCM281XX_MASTER_CCU_DMAC
-    master  usb_ic          peri      5     BCM281XX_MASTER_CCU_USB_IC
-    master  hsic2_48m       peri      6     BCM281XX_MASTER_CCU_HSIC_48M
-    master  hsic2_12m       peri      7     BCM281XX_MASTER_CCU_HSIC_12M
-
-    slave   uartb           peri      0     BCM281XX_SLAVE_CCU_UARTB
-    slave   uartb2          peri      1     BCM281XX_SLAVE_CCU_UARTB2
-    slave   uartb3          peri      2     BCM281XX_SLAVE_CCU_UARTB3
-    slave   uartb4          peri      3     BCM281XX_SLAVE_CCU_UARTB4
-    slave   ssp0            peri      4     BCM281XX_SLAVE_CCU_SSP0
-    slave   ssp2            peri      5     BCM281XX_SLAVE_CCU_SSP2
-    slave   bsc1            peri      6     BCM281XX_SLAVE_CCU_BSC1
-    slave   bsc2            peri      7     BCM281XX_SLAVE_CCU_BSC2
-    slave   bsc3            peri      8     BCM281XX_SLAVE_CCU_BSC3
-    slave   pwm             peri      9     BCM281XX_SLAVE_CCU_PWM
-
-
-BCM21664 family
----------------
-CCU compatible string values for SoCs in the BCM21664 family are:
-    "brcm,bcm21664-root-ccu"
-    "brcm,bcm21664-aon-ccu"
-    "brcm,bcm21664-master-ccu"
-    "brcm,bcm21664-slave-ccu"
-
-The following table defines the set of CCUs and clock specifiers for
-BCM21664 family clocks.  When a clock consumer references a clocks,
-its symbolic specifier (rather than its numeric index value) should
-be used.  These specifiers are defined in:
-    "include/dt-bindings/clock/bcm21664.h"
-
-    CCU     Clock           Type    Index   Specifier
-    ---     -----           ----    -----   ---------
-    root    frac_1m         peri      0     BCM21664_ROOT_CCU_FRAC_1M
-
-    aon     hub_timer       peri      0     BCM21664_AON_CCU_HUB_TIMER
-
-    master  sdio1           peri      0     BCM21664_MASTER_CCU_SDIO1
-    master  sdio2           peri      1     BCM21664_MASTER_CCU_SDIO2
-    master  sdio3           peri      2     BCM21664_MASTER_CCU_SDIO3
-    master  sdio4           peri      3     BCM21664_MASTER_CCU_SDIO4
-    master  sdio1_sleep     peri      4     BCM21664_MASTER_CCU_SDIO1_SLEEP
-    master  sdio2_sleep     peri      5     BCM21664_MASTER_CCU_SDIO2_SLEEP
-    master  sdio3_sleep     peri      6     BCM21664_MASTER_CCU_SDIO3_SLEEP
-    master  sdio4_sleep     peri      7     BCM21664_MASTER_CCU_SDIO4_SLEEP
-
-    slave   uartb           peri      0     BCM21664_SLAVE_CCU_UARTB
-    slave   uartb2          peri      1     BCM21664_SLAVE_CCU_UARTB2
-    slave   uartb3          peri      2     BCM21664_SLAVE_CCU_UARTB3
-    slave   uartb4          peri      3     BCM21664_SLAVE_CCU_UARTB4
-    slave   bsc1            peri      4     BCM21664_SLAVE_CCU_BSC1
-    slave   bsc2            peri      5     BCM21664_SLAVE_CCU_BSC2
-    slave   bsc3            peri      6     BCM21664_SLAVE_CCU_BSC3
-    slave   bsc4            peri      7     BCM21664_SLAVE_CCU_BSC4
diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
new file mode 100644
index 000000000000..e5656950b3bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family clock control units (CCU)
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+description: |
+  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
+  manages a set of clock signals.
+
+  All available clock IDs are defined in
+  - include/dt-bindings/clock/bcm281xx.h for BCM281XX family
+  - include/dt-bindings/clock/bcm21664.h for BCM21664 family
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm11351-aon-ccu
+      - brcm,bcm11351-hub-ccu
+      - brcm,bcm11351-master-ccu
+      - brcm,bcm11351-root-ccu
+      - brcm,bcm11351-slave-ccu
+      - brcm,bcm21664-aon-ccu
+      - brcm,bcm21664-master-ccu
+      - brcm,bcm21664-root-ccu
+      - brcm,bcm21664-slave-ccu
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clock-output-names:
+    minItems: 1
+    maxItems: 10
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clock-output-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm11351-aon-ccu
+    then:
+      properties:
+        clock-output-names:
+          items:
+            - const: hub_timer
+            - const: pmu_bsc
+            - const: pmu_bsc_var
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm11351-hub-ccu
+    then:
+      properties:
+        clock-output-names:
+          const: tmon_1m
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm11351-master-ccu
+    then:
+      properties:
+        clock-output-names:
+          items:
+            - const: sdio1
+            - const: sdio2
+            - const: sdio3
+            - const: sdio4
+            - const: usb_ic
+            - const: hsic2_48m
+            - const: hsic2_12m
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm11351-root-ccu
+              - brcm,bcm21664-root-ccu
+    then:
+      properties:
+        clock-output-names:
+          const: frac_1m
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm11351-slave-ccu
+    then:
+      properties:
+        clock-output-names:
+          items:
+            - const: uartb
+            - const: uartb2
+            - const: uartb3
+            - const: uartb4
+            - const: ssp0
+            - const: ssp2
+            - const: bsc1
+            - const: bsc2
+            - const: bsc3
+            - const: pwm
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm21664-aon-ccu
+    then:
+      properties:
+        clock-output-names:
+          const: hub_timer
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm21664-master-ccu
+    then:
+      properties:
+        clock-output-names:
+          items:
+            - const: sdio1
+            - const: sdio2
+            - const: sdio3
+            - const: sdio4
+            - const: sdio1_sleep
+            - const: sdio2_sleep
+            - const: sdio3_sleep
+            - const: sdio4_sleep
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm21664-slave-ccu
+    then:
+      properties:
+        clock-output-names:
+          items:
+            - const: uartb
+            - const: uartb2
+            - const: uartb3
+            - const: bsc1
+            - const: bsc2
+            - const: bsc3
+            - const: bsc4
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@3e011000 {
+      compatible = "brcm,bcm11351-slave-ccu";
+      reg = <0x3e011000 0x0f00>;
+      #clock-cells = <1>;
+      clock-output-names = "uartb",
+                           "uartb2",
+                           "uartb3",
+                           "uartb4",
+                           "ssp0",
+                           "ssp2",
+                           "bsc1",
+                           "bsc2",
+                           "bsc3",
+                           "pwm";
+    };
+...
-- 
2.34.1

