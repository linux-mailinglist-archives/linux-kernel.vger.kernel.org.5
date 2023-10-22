Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4287D22E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjJVLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:31:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C3E9;
        Sun, 22 Oct 2023 04:31:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9936b3d0286so358378466b.0;
        Sun, 22 Oct 2023 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697974313; x=1698579113; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4Qod9SfFzfNb+2PWWBwTLsMwnklAaKGCWb4rKbRixc=;
        b=ctw+5TpDLorzC1ydeBra6vc1IW998cUrtAgADfxQKXW3KATLWutGexyMg+GtoXFK78
         uvXj2ZlJ74Ezvr/Ww6xyfWNHo6q3tURbygCG/9EUy8bCzEVSvTvIcCmnpHmcFgKQko8g
         3dctf30Q3G/0gnoApk3WUOoPfpQMY/eFEa0qHFVh4XtMCUsyhTYRf0GXAaU3pRmcMI0x
         ZgC5IhUj5bGgoHAZRno0iwtTaGVcwKRbmBjWcwXbWhyhG/IGc+eFbARuMAMzUXC9MWLV
         QhidPWcBD3B5tNMKWlNPEdF2EtNQqhOqRnHYkzKWpoxeZlDxCvbyhmXmn9Sxj6dFekkM
         RrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697974313; x=1698579113;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Qod9SfFzfNb+2PWWBwTLsMwnklAaKGCWb4rKbRixc=;
        b=hUf0jkbi1QiC+1Pvxv8IwA40qvrS35ykPNpBf78JXMYmUvK3Yk7+eLsKx1Eu996D1J
         7cygnZx8Cz23DUI/yfpu1hDc4emimjRThFyID4tx1izSj9j/uNqIMC0IGbfS6P6XzEaa
         82ibfrN/j7SouiB09dIcU8xHJuWRDHzIi5pcR6XfkhvFO13ko/NfTzkWGb2N4/cWj2uX
         EOPPBTT/8H96vFLzwNE3GCMBnJHWZQ0Huht7nNsJ7i6c9H+1KLcIsIuwiYcQhi8Zhdqz
         bI/hiVrQet0g+tVgzfqFhQjRVQEZ1U5j0YfmckKtskJPlcjfU2PUBmOVhb3nYKy54hYx
         39kA==
X-Gm-Message-State: AOJu0YyTEE91f67vl8tgUvjFVl0DDE5EkeR9iQkagWguVzEue1l7NPj9
        JkO0ZJ6tGWlUX4kxtlBuoDY=
X-Google-Smtp-Source: AGHT+IHL9Mv18nlC0bf4nv8iD44dIVeR3uTDT4xHFi62XfcAgUa+XtM5cdjUwY6RAADfDiNgPffFDQ==
X-Received: by 2002:a17:907:9344:b0:9ae:7870:1539 with SMTP id bv4-20020a170907934400b009ae78701539mr5130729ejc.76.1697974312757;
        Sun, 22 Oct 2023 04:31:52 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id s16-20020a1709066c9000b0099bc08862b6sm5016897ejr.171.2023.10.22.04.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 04:31:52 -0700 (PDT)
Date:   Sun, 22 Oct 2023 13:31:50 +0200
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
Subject: [PATCH] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family clock controller unit (CCU) bindings
to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/clock/brcm,kona-ccu.txt          | 138 ---------------
 .../bindings/clock/brcm,kona-ccu.yaml         | 158 ++++++++++++++++++
 2 files changed, 158 insertions(+), 138 deletions(-)
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
index 000000000000..80c834951d6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -0,0 +1,158 @@
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
+description:
+  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
+  manages a set of clock signals.
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm11351-aon-ccu
+              - brcm,bcm11351-hub-ccu
+              - brcm,bcm11351-master-ccu
+              - brcm,bcm11351-root-ccu
+              - brcm,bcm11351-slave-ccu
+    then:
+      properties:
+        clock-output-names:
+          description: |
+            The following table defines the set of CCUs and clock specifiers
+            for BCM281XX family clocks.
+            These clock specifiers are defined in:
+                "include/dt-bindings/clock/bcm281xx.h"
+
+            CCU     Clock        Type  Index  Specifier
+            ---     -----        ----  -----  ---------
+            root    frac_1m      peri    0    BCM281XX_ROOT_CCU_FRAC_1M
+
+            aon     hub_timer    peri    0    BCM281XX_AON_CCU_HUB_TIMER
+            aon     pmu_bsc      peri    1    BCM281XX_AON_CCU_PMU_BSC
+            aon     pmu_bsc_var  peri    2    BCM281XX_AON_CCU_PMU_BSC_VAR
+
+            hub     tmon_1m      peri    0    BCM281XX_HUB_CCU_TMON_1M
+
+            master  sdio1        peri    0    BCM281XX_MASTER_CCU_SDIO1
+            master  sdio2        peri    1    BCM281XX_MASTER_CCU_SDIO2
+            master  sdio3        peri    2    BCM281XX_MASTER_CCU_SDIO3
+            master  sdio4        peri    3    BCM281XX_MASTER_CCU_SDIO4
+            master  dmac         peri    4    BCM281XX_MASTER_CCU_DMAC
+            master  usb_ic       peri    5    BCM281XX_MASTER_CCU_USB_IC
+            master  hsic2_48m    peri    6    BCM281XX_MASTER_CCU_HSIC_48M
+            master  hsic2_12m    peri    7    BCM281XX_MASTER_CCU_HSIC_12M
+
+            slave   uartb        peri    0    BCM281XX_SLAVE_CCU_UARTB
+            slave   uartb2       peri    1    BCM281XX_SLAVE_CCU_UARTB2
+            slave   uartb3       peri    2    BCM281XX_SLAVE_CCU_UARTB3
+            slave   uartb4       peri    3    BCM281XX_SLAVE_CCU_UARTB4
+            slave   ssp0         peri    4    BCM281XX_SLAVE_CCU_SSP0
+            slave   ssp2         peri    5    BCM281XX_SLAVE_CCU_SSP2
+            slave   bsc1         peri    6    BCM281XX_SLAVE_CCU_BSC1
+            slave   bsc2         peri    7    BCM281XX_SLAVE_CCU_BSC2
+            slave   bsc3         peri    8    BCM281XX_SLAVE_CCU_BSC3
+            slave   pwm          peri    9    BCM281XX_SLAVE_CCU_PWM
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm21664-aon-ccu
+              - brcm,bcm21664-master-ccu
+              - brcm,bcm21664-root-ccu
+              - brcm,bcm21664-slave-ccu
+    then:
+      properties:
+        clock-output-names:
+          maxItems: 8
+          description: |
+            The following table defines the set of CCUs and clock specifiers
+            for BCM21664 family clocks.
+            These clock specifiers are defined in:
+                "include/dt-bindings/clock/bcm21664.h"
+
+            CCU     Clock         Type  Index  Specifier
+            ---     -----         ----  -----  ---------
+            root    frac_1m       peri    0    BCM21664_ROOT_CCU_FRAC_1M
+
+            aon     hub_timer     peri    0    BCM21664_AON_CCU_HUB_TIMER
+
+            master  sdio1         peri    0    BCM21664_MASTER_CCU_SDIO1
+            master  sdio2         peri    1    BCM21664_MASTER_CCU_SDIO2
+            master  sdio3         peri    2    BCM21664_MASTER_CCU_SDIO3
+            master  sdio4         peri    3    BCM21664_MASTER_CCU_SDIO4
+            master  sdio1_sleep   peri    4    BCM21664_MASTER_CCU_SDIO1_SLEEP
+            master  sdio2_sleep   peri    5    BCM21664_MASTER_CCU_SDIO2_SLEEP
+            master  sdio3_sleep   peri    6    BCM21664_MASTER_CCU_SDIO3_SLEEP
+            master  sdio4_sleep   peri    7    BCM21664_MASTER_CCU_SDIO4_SLEEP
+
+            slave   uartb         peri    0    BCM21664_SLAVE_CCU_UARTB
+            slave   uartb2        peri    1    BCM21664_SLAVE_CCU_UARTB2
+            slave   uartb3        peri    2    BCM21664_SLAVE_CCU_UARTB3
+            slave   uartb4        peri    3    BCM21664_SLAVE_CCU_UARTB4
+            slave   bsc1          peri    4    BCM21664_SLAVE_CCU_BSC1
+            slave   bsc2          peri    5    BCM21664_SLAVE_CCU_BSC2
+            slave   bsc3          peri    6    BCM21664_SLAVE_CCU_BSC3
+            slave   bsc4          peri    7    BCM21664_SLAVE_CCU_BSC4
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clock-output-names
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


