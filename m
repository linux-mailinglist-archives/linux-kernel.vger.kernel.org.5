Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C567EEBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKQFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKQFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:22:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1748D52;
        Thu, 16 Nov 2023 21:22:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c3aec5f326so544155766b.1;
        Thu, 16 Nov 2023 21:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700198567; x=1700803367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v27wSqqrShCzztVlfwu/zWkCL4FJgwhMdx/No5LYqKU=;
        b=fCIWPhNrmcUuocfy+nJNKMMmwWH2q8is6D+RLwtc52vR8fyp5uE6wJLXECNy9meFQ+
         joxreVmcf4g1knIpmY5UQHR9wRSN6tZ39VO6rNrFr4dbGRaQp5PRSSFxD+s0ns3sxUwD
         ZyhJhBHgkj80jDoMuInIa9Axn/5bqW+loKs/GXxRaa9kztC58ZYpEkNKyiyQMU8XHY74
         BpzLbjgsrbfv9g8xCYLeEd3jp+lvoBxkrAQqjQCYk5+kHlTNTkurIff/MkdsVjTo3sD0
         qNi4q0RYZ97m1TrjKlInC2tOc2S8kl+810OV0TDowHbsjnVrSKZ8aFZBAD3w5ZKhZ2Yt
         DZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700198567; x=1700803367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v27wSqqrShCzztVlfwu/zWkCL4FJgwhMdx/No5LYqKU=;
        b=XeOSiUyY9XPCa7HUYh0ZlQ0ji6o7jky4uEOmuq37jwWXyf4iZ4JuwiP9oSgjqyndvf
         NMWZQv/VjKfbffE2LNnkdNFhfydNTWxnVvVA1wq+5rV+Rn9DoH7xvmVSc2aaRfsVJCYj
         xQSinamUFS46zupY8qxbF3YwjPksICTI2py9a/N3KL1vNCHk8IaSshmGgsi90s4FmZOi
         ZSCGuiBdTXUmecy10P81L3JkXhRZ12FiReTpbxvIWW+eRCnWFNcpOVhYApMgi5Jp1gnj
         DFz1ur0657bd/OdgjuT2eZ7ee3+quDIU4CZYV7tqpBjAPxbOb6VqKqC5QxyPQWD+HL8e
         ARhw==
X-Gm-Message-State: AOJu0YyB+N1X8kLeCZ6JUW7njRI6BA372pUPDAFAFJVKKeWdTb3pyfOc
        30/q5iLcBCyi6xmByg9lRNc=
X-Google-Smtp-Source: AGHT+IFWYXXsNUiwsA640Taj8FVTPG3BMMTjDOpghUVLL6KpPkR4Qh5oftQ0IlSbTvHeL6rafpGPEw==
X-Received: by 2002:a17:907:970f:b0:9ad:e3fd:d46c with SMTP id jg15-20020a170907970f00b009ade3fdd46cmr4388479ejc.10.1700198567153;
        Thu, 16 Nov 2023 21:22:47 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id lt16-20020a170906fa9000b009e71efcce28sm380238ejb.210.2023.11.16.21.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 21:22:46 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3] dt-bindings: thermal: convert Mediatek Thermal to the json-schema
Date:   Fri, 17 Nov 2023 06:22:14 +0100
Message-Id: <20231117052214.24554-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Improved title
2. Simplified description (dropped "This describes the device tree...")
3. Dropped undocumented "reset-names" from example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add "maintainers"
V3: Introduce changes described in commit body
    Fix schema syntax
    Move unevaluatedProperties to the bottom
    Rename file to match compatible more closely

I'm totally sorry for sending broken schema patch yesterday. Brainfart.
There is no excuse for sth that doesn't even pass dt_binding_check.
  DTEX    Documentation/devicetree/bindings/thermal/mediatek,thermal.example.dts
  DTC_CHK Documentation/devicetree/bindings/thermal/mediatek,thermal.example.dtb

 .../bindings/thermal/mediatek,thermal.yaml    | 99 +++++++++++++++++++
 .../bindings/thermal/mediatek-thermal.txt     | 52 ----------
 2 files changed, 99 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
new file mode 100644
index 000000000000..d96a2e32bd8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek thermal controller for on-SoC temperatures
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+description:
+  This device does not have its own ADC, instead it directly controls the AUXADC
+  via AHB bus accesses. For this reason it needs phandles to the AUXADC. Also it
+  controls a mux in the apmixedsys register space via AHB bus accesses, so a
+  phandle to the APMIXEDSYS is also needed.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-thermal
+      - mediatek,mt2712-thermal
+      - mediatek,mt7622-thermal
+      - mediatek,mt7981-thermal
+      - mediatek,mt7986-thermal
+      - mediatek,mt8173-thermal
+      - mediatek,mt8183-thermal
+      - mediatek,mt8365-thermal
+      - mediatek,mt8516-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main clock needed for register access
+      - description: The AUXADC clock
+
+  clock-names:
+    items:
+      - const: therm
+      - const: auxadc
+
+  mediatek,auxadc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the AUXADC which the thermal controller uses
+
+  mediatek,apmixedsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the APMIXEDSYS controller
+
+  resets:
+    description: Reset controller controlling the thermal controller
+
+  nvmem-cells:
+    items:
+      - description:
+          NVMEM cell with EEPROMA phandle to the calibration data provided by an
+          NVMEM device. If unspecified default values shall be used.
+
+  nvmem-cell-names:
+    items:
+      - const: calibration-data
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - mediatek,auxadc
+  - mediatek,apmixedsys
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/reset/mt8173-resets.h>
+
+    thermal@1100b000 {
+        compatible = "mediatek,mt8173-thermal";
+        reg = <0x1100b000 0x1000>;
+        interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+        clock-names = "therm", "auxadc";
+        resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+        mediatek,auxadc = <&auxadc>;
+        mediatek,apmixedsys = <&apmixedsys>;
+        nvmem-cells = <&thermal_calibration_data>;
+        nvmem-cell-names = "calibration-data";
+        #thermal-sensor-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
deleted file mode 100644
index ac39c7156fde..000000000000
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Mediatek Thermal
-
-This describes the device tree binding for the Mediatek thermal controller
-which measures the on-SoC temperatures. This device does not have its own ADC,
-instead it directly controls the AUXADC via AHB bus accesses. For this reason
-this device needs phandles to the AUXADC. Also it controls a mux in the
-apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
-is also needed.
-
-Required properties:
-- compatible:
-  - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
-  - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
-  - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
-  - "mediatek,mt7622-thermal" : For MT7622 SoC
-  - "mediatek,mt7981-thermal", "mediatek,mt7986-thermal" : For MT7981 SoC
-  - "mediatek,mt7986-thermal" : For MT7986 SoC
-  - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
-  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
-  - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
-- reg: Address range of the thermal controller
-- interrupts: IRQ for the thermal controller
-- clocks, clock-names: Clocks needed for the thermal controller. required
-                       clocks are:
-		       "therm":	 Main clock needed for register access
-		       "auxadc": The AUXADC clock
-- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
-- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
-- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Optional properties:
-- resets: Reference to the reset controller controlling the thermal controller.
-- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
-               unspecified default values shall be used.
-- nvmem-cell-names: Should be "calibration-data"
-
-Example:
-
-	thermal: thermal@1100b000 {
-		#thermal-sensor-cells = <1>;
-		compatible = "mediatek,mt8173-thermal";
-		reg = <0 0x1100b000 0 0x1000>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
-		clock-names = "therm", "auxadc";
-		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
-		reset-names = "therm";
-		mediatek,auxadc = <&auxadc>;
-		mediatek,apmixedsys = <&apmixedsys>;
-		nvmem-cells = <&thermal_calibration_data>;
-		nvmem-cell-names = "calibration-data";
-	};
-- 
2.35.3

