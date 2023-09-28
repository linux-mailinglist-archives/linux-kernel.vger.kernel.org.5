Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78187B16AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjI1I4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjI1I4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:56:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61225CC4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3aec067556dso2008827b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891366; x=1696496166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml17AIOxe5tHr3zPSTgOdnGea7Wg+T/JGUBI6JLZOVQ=;
        b=lvrrXuxoJ659keWD6obCPt6TpLVJoYtXosHDDskTjS970VuYSpP4L/XX8bucZ+An7K
         nAJyNIJCUDGq68V+Im6JQfi5uArB+BNwTRdoIndY+z9AnBfdr7WwGp1RyuMY7MEBBv7Y
         bAWp+os+6mcFHrmmStufpt+DBIXrtCqrH7D0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891366; x=1696496166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml17AIOxe5tHr3zPSTgOdnGea7Wg+T/JGUBI6JLZOVQ=;
        b=mSP9jYD701/M4wIVmMthc4fZRknuENmwtkauvo93gev372UmVHieIZTMvX8ZSFvuNE
         PvmR1m/oQPwH6RkY0csDQxkO58IDivcgt8R5GY91DU0OK02DFzbUwns/ASb0tj2DSwZI
         ROdZQlaIdxaUisLCd1aEPZCxWbuA7uAH6DCxPf3eT7Wq59vfsweuiMkyN9VsypGqKY34
         93DWBrhD9pCNhok/atZlKfsgby5NGGTrPeXZfikPZMRFbssoavlTBSwGRWpsNZSyykNz
         AdCrmDLxNKy1xx3hZKCGxmWGXZpYOqAHn9H5aTFs+fEMa58J6p4lWj+/7c7aQ9Y13YPR
         Q79w==
X-Gm-Message-State: AOJu0YzEAr7bCEtRFTt9xLcutzpaPrLELrJ+Ei0QCGccr/76u2wdlBci
        sEoz2gWaGykRakttadCWS5zblQ==
X-Google-Smtp-Source: AGHT+IHBu1CZg5LGb52qF5VrtaNXiMiIG2wETBHHrIdDmEuoupIcRkNgt4i6rGh21fZffNiQjylfcg==
X-Received: by 2002:a05:6808:2a53:b0:3a4:2204:e9e6 with SMTP id fa19-20020a0568082a5300b003a42204e9e6mr552245oib.21.1695891366659;
        Thu, 28 Sep 2023 01:56:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:56:06 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, Lee Jones <lee@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v4 05/12] regulator: dt-bindings: mt6358: Add MT6366 PMIC
Date:   Thu, 28 Sep 2023 16:55:28 +0800
Message-ID: <20230928085537.3246669-6-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928085537.3246669-1-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The differences compared to the MT6358 are minimal:
- Regulators removed: VCAMA1, VCAMA2, VCAMD, VCAMIO, VLDO28
- Regulators added: VM18, VMDDR, VSRAM_CORE

Both PMIC models contain a chip ID register at the same address that
can be used to differentiate the actual model. Thus, even though the
MT6366 is not fully backward compatible with the MT6358, it still falls
back on the MT6358 compatible string. It is up to the implementation
to use the chip ID register as a probing mechanism.

Update the MT6358 regulator binding and add entries for all the MT6366's
regulators and their supplies. The regulator node names follow a cleaned
up style without type prefixes and with underscores replaced with hyphens.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
[wens@chromium.org: major rework and added commit message]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Expanded commit message to mention why a fallback compatible is used
- Adapted to ldo_vxo22 and ldo_vusb movement to properties in previous
  patch
- Split example into two, one for each variant
- Renamed regulator node in examples to just "regulator"

Changes since v2:
- Merged all the propertyPatterns together; the if-then sections now
  only block out invalid properties

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

 .../regulator/mediatek,mt6358-regulator.yaml  | 149 ++++++++++++++----
 1 file changed, 120 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index f2219d8656c2..c50402fcba72 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -16,30 +16,18 @@ description:
 
 properties:
   compatible:
-    const: mediatek,mt6358-regulator
-
-  ldo_vxo22:
-    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    properties:
-      regulator-allowed-modes: false
-    unevaluatedProperties: false
-
-  ldo_vusb:
-    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
-    type: object
-    $ref: regulator.yaml#
-    properties:
-      regulator-allowed-modes: false
-    unevaluatedProperties: false
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
@@ -59,18 +47,20 @@ properties:
   vsys-vs2-supply:
     description: Supply for buck regulator vs2
   vs1-ldo1-supply:
-    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
+    description:
+      Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358 only), vio18, vm18 (MT6366 only)
   vs2-ldo1-supply:
-    description: Supply for LDOs vdram2
+    description: Supply for LDOs vdram2, vmddr (MT6366 only)
   vs2-ldo2-supply:
     description: Supply for LDOs vrf12, va12
   vs2-ldo3-supply:
-    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
+    description:
+      Supply for LDOs vsram-core (MT6366 only), vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
   vs2-ldo4-supply:
     description: Supply for LDO vcamd
 
 patternProperties:
-  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
+  "^(buck_)?v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
     description: Buck regulators
     type: object
     $ref: regulator.yaml#
@@ -85,7 +75,7 @@ patternProperties:
           enum: [0, 1]
     unevaluatedProperties: false
 
-  "^ldo_v(a|rf)12$":
+  "^(ldo_)?v(a|rf)12$":
     description: LDOs with fixed 1.2V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
@@ -93,15 +83,24 @@ patternProperties:
       regulator-allowed-modes: false
     unevaluatedProperties: false
 
-  "^ldo_v((aux|cn|io|rf)18|camio)$":
-    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
+  "^(ldo_)?v((aux|cn|io|rf)18|camio)$":
+    description:
+      LDOs with fixed 1.8V output and 0~100/10mV tuning (vcn18 on MT6366 has variable output)
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?vxo22$":
+    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
     properties:
       regulator-allowed-modes: false
     unevaluatedProperties: false
 
-  "^ldo_v(aud|bif|cn|fe|io)28$":
+  "^(ldo_)?v(aud|bif|cn|fe|io)28$":
     description: LDOs with fixed 2.8V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
@@ -109,7 +108,15 @@ patternProperties:
       regulator-allowed-modes: false
     unevaluatedProperties: false
 
-  "^ldo_vsram_(gpu|others|proc1[12])$":
+  "^(ldo_)?vusb$":
+    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?vsram[_-](core|gpu|others|proc1[12])$":
     description: LDOs with variable output
     type: object
     $ref: regulator.yaml#
@@ -117,7 +124,7 @@ patternProperties:
       regulator-allowed-modes: false
     unevaluatedProperties: false
 
-  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
+  "^(ldo_)?v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|m18|mc|mch|mddr|sim[12])$":
     description: LDOs with variable output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
@@ -130,6 +137,45 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt6358-regulator
+    then:
+      patternProperties:
+        # Old regulator node name scheme (with prefix and underscores) only
+        # ([^y-] is used to avoid matching -supply
+        "^(?<!buck_)(?<!ldo_)v.*[^y-](?!-supply)$": false
+        "^ldo_vsram-": false
+        # vsram_core regulator doesn't exist on MT6358
+        "^ldo_vsram[-_]core$": false
+
+      properties:
+        # vm18 and vmddr regulators don't exist on MT6358
+        ldo_vm18: false
+        ldo_vmddr: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6366-regulator
+    then:
+      patternProperties:
+        # Prefer cleaned up regulator node names
+        "^(buck|ldo)_": false
+        # Don't allow underscores
+        "^vsram_": false
+        # vcam* regulators don't exist on MT6366
+        "^vcam": false
+
+      properties:
+        # vldo28 regulator doesn't exist on MT6366
+        vldo28: false
+        # vs2_ldo4 supply pin doesn't exist on MT6366
+        vs2-ldo4-supply: false
+
 examples:
   - |
     #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
@@ -156,4 +202,49 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
+
+    regulator {
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
2.42.0.582.g8ccd20d70d-goog

