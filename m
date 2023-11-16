Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A17EE052
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:02:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFBC4;
        Thu, 16 Nov 2023 04:02:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so1100665a12.2;
        Thu, 16 Nov 2023 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700136154; x=1700740954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTrltGVBCvBoexMeOs/zFwHzylci7LZMUjyCRLBI0xs=;
        b=IaqL6myCEQ0eMgZ0LW6zavN9II+IRRqcA+BljqoI5w2CQ4jmDFIVYpOZ1PDaEZHtl+
         JAq5BDBm1VZQ900wOQIoFDjLug7wcLoY1CKgBQFCA/B2oGhIoM9ijVW5VMbYAal9AGZD
         197B4bHY6tH3zUk4Tvfaf3NAML84hrPf43Vb48pDcnt2HMmT1cEFlgATdoY4LRfAESak
         C7pNjgCzB93Yr898L+EdGqmy8KuP5td2e3yWKmXmcWJpwLlVRh5tInS02MspmlrXABIt
         3cso1xqIX1lubkP44sf8xh5QbQiUo724U04I9OgXeKtQo9/fJeWBkr797bXV4K7KBp9j
         VyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136154; x=1700740954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTrltGVBCvBoexMeOs/zFwHzylci7LZMUjyCRLBI0xs=;
        b=dOmRi2Q56LwJCqgEfFuU6GVxVm1MFsg80vpWs9ueN6fqL7ADspPVsCctz4LQXaksrl
         EO6Rc9f3KuwVyCjUeDsRycAZpgzNRuqtLpxFZeVNmNfEFLRvCiLLNoSM50exPhXOmRNw
         K7L32byT7dqJ5xWMCtEexE5v+FpPjKxmAfVON6Cy5CLx70ndnEhvfj4TKZsrmcfxn+E/
         vaD//O3zd2NViX4OcOHUlUDTyq4EvK/gB8XMgEir8bor931alWPpQEDwaSHiW6JfIim/
         V451/ehcRnZ4iMeVJqGwTnupmdSicOZ4BGBPqSttKJQZH7uKNkT//7WNHVN8MTzPIc80
         OjFg==
X-Gm-Message-State: AOJu0YywGx2rkS3vSRnSZ17Ng4XrKdV0ZNvdxZbrbs+5ydCnuQRxSTLC
        3yy8uAOJpkvnwXY2v1ttrkA=
X-Google-Smtp-Source: AGHT+IE+l1WxERw88wPP4jgQbj0W+HTBU6BoowIoSnFHFejeJjqWxu2+n49WhcpSktk8OPVh8CX1uw==
X-Received: by 2002:a17:906:fa9b:b0:9e1:e1f5:2bb9 with SMTP id lt27-20020a170906fa9b00b009e1e1f52bb9mr11833141ejb.30.1700136154241;
        Thu, 16 Nov 2023 04:02:34 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b009ddf38056f8sm8320317ejk.118.2023.11.16.04.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:02:33 -0800 (PST)
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
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: thermal: convert Mediatek Thermal to the json-schema
Date:   Thu, 16 Nov 2023 13:02:25 +0100
Message-Id: <20231116120225.29999-1-zajec5@gmail.com>
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

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/thermal/mediatek-thermal.txt     | 52 ----------
 .../bindings/thermal/mediatek-thermal.yaml    | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml

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
diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml
new file mode 100644
index 000000000000..0e036b22b82b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Thermal
+
+description: >
+  This describes the device tree binding for the Mediatek thermal controller
+  which measures the on-SoC temperatures. This device does not have its own ADC,
+  instead it directly controls the AUXADC via AHB bus accesses. For this reason
+  this device needs phandles to the AUXADC. Also it controls a mux in the
+  apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
+  is also needed.
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
+  resets: Reference to the reset controller controlling the thermal controller.
+
+  nvmem-cells:
+    items:
+      - description: >
+          NVMEM cell with EEPROMA phandle to the calibration data provided by an
+          NVMEM device. If unspecified default values shall be used.
+
+  nvmem-cell-names:
+    items:
+      - const: calibration-data
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - mediatek,auxadc
+  - mediatek,apmixedsys
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
+        reset-names = "therm";
+        mediatek,auxadc = <&auxadc>;
+        mediatek,apmixedsys = <&apmixedsys>;
+        nvmem-cells = <&thermal_calibration_data>;
+        nvmem-cell-names = "calibration-data";
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.35.3

