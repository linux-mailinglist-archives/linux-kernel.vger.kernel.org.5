Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB1783C08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHVIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjHVIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:51 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3ACCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a741f46fadso3235900b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693943; x=1693298743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLEot2bDhTp9fvAY+MekQ5I92rdYBwqTaNw+kjYI3xE=;
        b=bnm1i9X2gp09V0zgSPwBCRpNicnZuPQI0JQJOMCeX2jjLWF+2hvADTVUtkZqmkaHGQ
         NdznPI11uv+eYRR1cPob88YLm1ZYnwrdzCnxu7pnh4vyvrMmfHTssJwlEyr0V/DQ6pRc
         hnK1BHbAtK6RUrchYkV1DyVgM+wWCwGDzy1kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693943; x=1693298743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLEot2bDhTp9fvAY+MekQ5I92rdYBwqTaNw+kjYI3xE=;
        b=a1FMKqle2u5G0XzvJIn8zezFXGvpx571KQfG488YQbsI3hRiKNz/IY0vdZREa2RNwl
         xqdqfWV7h0q2TC7kJ7WmydDxfxR83FP+NOpRpdBOtFv01hY/rTpaqJK/lq/T5svKP2pa
         OiwyMTa87pT1Dzj1433ufr/crth1vr2s5Kw6jQeBnQicZmY9Azwe+QYEbBQTKlrPjzcz
         BXb80X2qk4HAL0rD3xB/yHxYa2TWnGf23qB1RfPxougtStJwzhh2M5X5HtukK1BsqTMI
         GRTWWUMYJQYnrE8OM2yBGSFK1rOWzHwvYhFniFE172tHsXXrH95tp3QGMsX2HdQv8FUa
         41Ng==
X-Gm-Message-State: AOJu0YySYrsKqB5Kulq74nh6mFYxytCyr+jEp8k3mM4qgKbKZIZKHyfr
        h96tsdl3/DuOQhGBCA0V+ke3AA==
X-Google-Smtp-Source: AGHT+IFNt2EgkeunTDPvWWg/on0wlZbvPpea12PvOVP6FS/BMcSpdshX9dsOIoXG4JruqK2haZdgzA==
X-Received: by 2002:aca:674d:0:b0:3a4:67b6:454e with SMTP id b13-20020aca674d000000b003a467b6454emr10552276oiy.6.1692693943041;
        Tue, 22 Aug 2023 01:45:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:42 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 05/11] regulator: dt-bindings: mediatek: Add MT6366 PMIC
Date:   Tue, 22 Aug 2023 16:45:13 +0800
Message-ID: <20230822084520.564937-6-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
29 LDO regulators, not counting ones that feed internally and basically
have no controls. The regulators are named after their intended usage
for the SoC and system design, thus not named generically as ldoX or
dcdcX, but as vcn33 or vgpu.

Add a binding document describing all the regulators and their supplies.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
[wens@chromium.org: major rework and added commit message]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Replaced underscores in supply names to hyphens
- Merged with MT6358 regulator binding
- Added MT6358 fallback compatible to MT6366 regulator

Changes since Zhiyong's last version (v4) [1]:
- simplified regulator names
- added descriptions to regulators
- removed bogus regulators (*_sshub)
- merged vcn33-wifi and vcn33-bt as vcn33
- added missing regulators (vm18, vmddr, vsram-core)
- cut down examples to a handful of cases and made them complete
- expanded commit message a lot

[1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
 .../regulator/mediatek,mt6358-regulator.yaml  | 227 +++++++++++++-----
 1 file changed, 168 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index 82328fe17680..b350181f33ff 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -16,14 +16,18 @@ description: |
 
 properties:
   compatible:
-    const: mediatek,mt6358-regulator
+    oneOf:
+      - const: mediatek,mt6358-regulator
+      - items:
+          - const: mediatek,mt6366-regulator
+          - const: mediatek,mt6358-regulator
 
   vsys-ldo1-supply:
     description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
   vsys-ldo2-supply:
-    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
+    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, vmch, vsim2
   vsys-ldo3-supply:
-    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
+    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), vemc, vibr
   vsys-vcore-supply:
     description: Supply for buck regulator vcore
   vsys-vdram1-supply:
@@ -43,75 +47,138 @@ properties:
   vsys-vs2-supply:
     description: Supply for buck regulator vs2
   vs1-ldo1-supply:
-    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
+    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358 only), vio18
   vs2-ldo1-supply:
-    description: Supply for LDOs vdram2
+    description: Supply for LDOs vdram2, vmddr (MT6366 only)
   vs2-ldo2-supply:
     description: Supply for LDOs vrf12, va12
   vs2-ldo3-supply:
-    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
-  vs2-ldo4-supply:
-    description: Supply for LDO vcamd
-
-patternProperties:
-  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
-    description: Buck regulators
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_v(a|rf)12":
-    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_v((aux|cn|io|rf)18|camio)":
-    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_vxo22":
-    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_v(aud|bif|cn|fe|io)28":
-    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_vusb":
-    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_vsram_(gpu|others|proc1[12])$":
-    description: LDOs with variable output
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
-
-  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
-    description: LDOs with variable output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    unevaluatedProperties: false
+    description: Supply for LDOs vsram-core (MT6366 only), vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
 
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt6358-regulator
+    then:
+      properties:
+        vs2-ldo4-supply:
+          description: Supply for LDO vcamd
+
+      patternProperties:
+        "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
+          description: Buck regulators
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_v(a|rf)12":
+          description: LDOs with fixed 1.2V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_v((aux|cn|io|rf)18|camio)":
+          description: LDOs with fixed 1.8V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_vxo22":
+          description: LDOs with fixed 2.2V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_v(aud|bif|cn|fe|io)28":
+          description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_vusb":
+          description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_vsram_(gpu|others|proc1[12])$":
+          description: LDOs with variable output
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
+          description: LDOs with variable output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6366-regulator
+    then:
+      patternProperties:
+        "^v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
+          description: Buck regulators
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^v(a|rf)12":
+          description: LDOs with fixed 1.2V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^v(aux|io|rf)18":
+          description: LDOs with fixed 1.8V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^vxo22":
+          description: LDOs with fixed 2.2V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^v(aud|bif|cn|fe|io)28":
+          description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^vusb":
+          description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^vsram-(core|gpu|others|proc1[12])$":
+          description: LDOs with variable output
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
+
+        "^v(cn18|cn33|dram2|efuse|emc|ibr|m18|mc|mch|mddr|sim[12])$":
+          description: LDOs with variable output and 0~100/10mV tuning
+          type: object
+          $ref: regulator.yaml#
+          unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
 
-    regulator {
+    mt6358-regulator {
         compatible = "mediatek,mt6358-regulator";
 
         buck_vgpu {
@@ -137,4 +204,46 @@ examples:
         };
     };
 
+    mt6366-regulator {
+        compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
+
+        vdram1 {
+            regulator-name = "pp1125_emi_vdd2";
+            regulator-min-microvolt = <1125000>;
+            regulator-max-microvolt = <1125000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <0>;
+            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+                                       MT6397_BUCK_MODE_FORCE_PWM>;
+            regulator-always-on;
+        };
+
+        vproc11 {
+            regulator-name = "ppvar_dvdd_proc_bc_mt6366";
+            regulator-min-microvolt = <600000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-ramp-delay = <6250>;
+            regulator-enable-ramp-delay = <200>;
+            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+                                       MT6397_BUCK_MODE_FORCE_PWM>;
+            regulator-always-on;
+        };
+
+        vmddr {
+            regulator-name = "pm0750_emi_vmddr";
+            regulator-min-microvolt = <700000>;
+            regulator-max-microvolt = <750000>;
+            regulator-enable-ramp-delay = <325>;
+            regulator-always-on;
+        };
+
+        vsram-proc11 {
+            regulator-name = "pp0900_dvdd_sram_bc";
+            regulator-min-microvolt = <850000>;
+            regulator-max-microvolt = <1120000>;
+            regulator-ramp-delay = <6250>;
+            regulator-enable-ramp-delay = <240>;
+            regulator-always-on;
+        };
+    };
 ...
-- 
2.42.0.rc1.204.g551eb34607-goog

