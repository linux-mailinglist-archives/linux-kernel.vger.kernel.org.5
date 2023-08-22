Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB352783C04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjHVIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHVIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB8CC9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-689f9576babso2746329b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693938; x=1693298738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxGCtJ2Wep5efB+WkbsRfN8SMwC+vT6DRMJNr+uJtTM=;
        b=cee35XBJgWrPIQZvclRYmKKPTK9TteoVtq9KR3/9hzVU2nQck7y1o5DKhwVRs7XFKK
         4NNAL4bucDmYnAC41qmpYUalcs3WZJxxorUDN3ByYWT2Z+itOdYmg9JElY4L3SgA0z+D
         Aw6ZodFVgTHZEDCF6UcY5gD1H1sWwuxiB5K0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693938; x=1693298738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxGCtJ2Wep5efB+WkbsRfN8SMwC+vT6DRMJNr+uJtTM=;
        b=igfSarFH1Qhjx8sxbDb61wr7fgsO9tbvH0muaa7ODL3ivdBOWWOnjdx7Z00JxPJPjy
         2vxAdHCEjyKkncNCNeQxr3KgIFB9inDDWBL85SDqErabUc85fgglBYMW17QVBTzWsjhY
         1c+eij5j18+46gS9AF3Sw3R4PA2P00u015ZHUSpksUyHWIbTU3DZUeqLsGn12yv9tNfM
         hPawedEU1koBdmjPYdUNN+c2YN2p2BI8+IopTfA1UE9Fli8IKgwfUcwDJ4wdlM2Yd8ap
         VvQDTcwkIpTNPN8KzEIoytUgO16AnCngDTeBxky1NusdCsYA+PiqEZGFq+Pry/QImUXw
         tAYw==
X-Gm-Message-State: AOJu0YwzS8ktE1RRVDt3uCqUwQ2DiuOgCdg053R+evqNfiP5pCltNDeD
        YBz+dGFauJlPy2B8g+oAw9yPHg==
X-Google-Smtp-Source: AGHT+IFYd2YL0KrDWvgUIXKMErFKQPaxg058X5tel5M+GH8U6Yi8Ag0PHyjiaxw7yRafBPsTLXVK+A==
X-Received: by 2002:a05:6a00:2389:b0:688:9516:f703 with SMTP id f9-20020a056a00238900b006889516f703mr8179341pfc.31.1692693937996;
        Tue, 22 Aug 2023 01:45:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:37 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 03/11] regulator: dt-bindings: mt6358: Convert to DT schema
Date:   Tue, 22 Aug 2023 16:45:11 +0800
Message-ID: <20230822084520.564937-4-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this from the old style text based binding to the new DT schema
style. This will make adding the MT6366 portion easier.

The examples have been trimmed down considerably, and the remaining
entries now match what is seen in actual device trees.

The original submitter seems to have left MediaTek, so instead the
submitter and maintainer for the MT6366 binding is listed.

Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../regulator/mediatek,mt6358-regulator.yaml  | 105 ++++++
 .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
 2 files changed, 105 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
new file mode 100644
index 000000000000..4d7924c5cc7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6358-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6358 Regulator
+
+maintainers:
+  - Zhiyong Tao <zhiyong.tao@mediatek.com>
+
+description: |
+  Regulator node of the PMIC. This node should under the PMIC's device node.
+  All voltage regulators provided by the PMIC are described as sub-nodes of
+  this node.
+
+properties:
+  compatible:
+    const: mediatek,mt6358-regulator
+
+patternProperties:
+  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_v(a|rf)12":
+    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_v((aux|cn|io|rf)18|camio)":
+    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_vxo22":
+    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_v(aud|bif|cn|fe|io)28":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_vusb":
+    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_vsram_(gpu|others|proc1[12])$":
+    description: LDOs with variable output
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
+    description: LDOs with variable output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
+
+    regulator {
+        compatible = "mediatek,mt6358-regulator";
+
+        buck_vgpu {
+            regulator-name = "vgpu";
+            regulator-min-microvolt = <625000>;
+            regulator-max-microvolt = <900000>;
+            regulator-ramp-delay = <6250>;
+            regulator-enable-ramp-delay = <200>;
+            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+                                       MT6397_BUCK_MODE_FORCE_PWM>;
+            regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
+            regulator-coupled-max-spread = <100000>;
+        };
+
+        ldo_vsram_gpu {
+            regulator-name = "vsram_gpu";
+            regulator-min-microvolt = <850000>;
+            regulator-max-microvolt = <1000000>;
+            regulator-ramp-delay = <6250>;
+            regulator-enable-ramp-delay = <240>;
+            regulator-coupled-with = <&mt6358_vgpu_reg>;
+            regulator-coupled-max-spread = <100000>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
deleted file mode 100644
index b6384306db5c..000000000000
--- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
+++ /dev/null
@@ -1,350 +0,0 @@
-MediaTek MT6358 Regulator
-
-All voltage regulators provided by the MT6358 PMIC are described as the
-subnodes of the MT6358 regulators node. Each regulator is named according
-to its regulator type, buck_<name> and ldo_<name>. The definition for each
-of these nodes is defined using the standard binding for regulators at
-Documentation/devicetree/bindings/regulator/regulator.txt.
-
-The valid names for regulators are::
-BUCK:
-  buck_vdram1, buck_vcore, buck_vpa, buck_vproc11, buck_vproc12, buck_vgpu,
-  buck_vs2, buck_vmodem, buck_vs1
-LDO:
-  ldo_vdram2, ldo_vsim1, ldo_vibr, ldo_vrf12, ldo_vio18, ldo_vusb, ldo_vcamio,
-  ldo_vcamd, ldo_vcn18, ldo_vfe28, ldo_vsram_proc11, ldo_vcn28, ldo_vsram_others,
-  ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18, ldo_vmch, ldo_vbif28,
-  ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12, ldo_vrf18,
-  ldo_vcn33, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28, ldo_vsim2
-
-Example:
-
-	pmic {
-		compatible = "mediatek,mt6358";
-
-		mt6358regulator: mt6358regulator {
-			compatible = "mediatek,mt6358-regulator";
-
-			mt6358_vdram1_reg: buck_vdram1 {
-				regulator-compatible = "buck_vdram1";
-				regulator-name = "vdram1";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2087500>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <0>;
-				regulator-always-on;
-			};
-
-			mt6358_vcore_reg: buck_vcore {
-				regulator-name = "vcore";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <200>;
-				regulator-always-on;
-			};
-
-			mt6358_vpa_reg: buck_vpa {
-				regulator-name = "vpa";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3650000>;
-				regulator-ramp-delay = <50000>;
-				regulator-enable-ramp-delay = <250>;
-			};
-
-			mt6358_vproc11_reg: buck_vproc11 {
-				regulator-name = "vproc11";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <200>;
-				regulator-always-on;
-			};
-
-			mt6358_vproc12_reg: buck_vproc12 {
-				regulator-name = "vproc12";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <200>;
-				regulator-always-on;
-			};
-
-			mt6358_vgpu_reg: buck_vgpu {
-				regulator-name = "vgpu";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <200>;
-			};
-
-			mt6358_vs2_reg: buck_vs2 {
-				regulator-name = "vs2";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <2087500>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <0>;
-				regulator-always-on;
-			};
-
-			mt6358_vmodem_reg: buck_vmodem {
-				regulator-name = "vmodem";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <900>;
-				regulator-always-on;
-			};
-
-			mt6358_vs1_reg: buck_vs1 {
-				regulator-name = "vs1";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <2587500>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <0>;
-				regulator-always-on;
-			};
-
-			mt6358_vdram2_reg: ldo_vdram2 {
-				regulator-name = "vdram2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <3300>;
-			};
-
-			mt6358_vsim1_reg: ldo_vsim1 {
-				regulator-name = "vsim1";
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <540>;
-			};
-
-			mt6358_vibr_reg: ldo_vibr {
-				regulator-name = "vibr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <60>;
-			};
-
-			mt6358_vrf12_reg: ldo_vrf12 {
-				compatible = "regulator-fixed";
-				regulator-name = "vrf12";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-enable-ramp-delay = <120>;
-			};
-
-			mt6358_vio18_reg: ldo_vio18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vio18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <2700>;
-				regulator-always-on;
-			};
-
-			mt6358_vusb_reg: ldo_vusb {
-				regulator-name = "vusb";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <270>;
-				regulator-always-on;
-			};
-
-			mt6358_vcamio_reg: ldo_vcamio {
-				compatible = "regulator-fixed";
-				regulator-name = "vcamio";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcamd_reg: ldo_vcamd {
-				regulator-name = "vcamd";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcn18_reg: ldo_vcn18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vcn18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vfe28_reg: ldo_vfe28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vfe28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vsram_proc11_reg: ldo_vsram_proc11 {
-				regulator-name = "vsram_proc11";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <240>;
-				regulator-always-on;
-			};
-
-			mt6358_vcn28_reg: ldo_vcn28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vcn28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vsram_others_reg: ldo_vsram_others {
-				regulator-name = "vsram_others";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <240>;
-				regulator-always-on;
-			};
-
-			mt6358_vsram_gpu_reg: ldo_vsram_gpu {
-				regulator-name = "vsram_gpu";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <240>;
-			};
-
-			mt6358_vxo22_reg: ldo_vxo22 {
-				compatible = "regulator-fixed";
-				regulator-name = "vxo22";
-				regulator-min-microvolt = <2200000>;
-				regulator-max-microvolt = <2200000>;
-				regulator-enable-ramp-delay = <120>;
-				regulator-always-on;
-			};
-
-			mt6358_vefuse_reg: ldo_vefuse {
-				regulator-name = "vefuse";
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vaux18_reg: ldo_vaux18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vaux18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vmch_reg: ldo_vmch {
-				regulator-name = "vmch";
-				regulator-min-microvolt = <2900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <60>;
-			};
-
-			mt6358_vbif28_reg: ldo_vbif28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vbif28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vsram_proc12_reg: ldo_vsram_proc12 {
-				regulator-name = "vsram_proc12";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1293750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <240>;
-				regulator-always-on;
-			};
-
-			mt6358_vcama1_reg: ldo_vcama1 {
-				regulator-name = "vcama1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vemc_reg: ldo_vemc {
-				regulator-name = "vemc";
-				regulator-min-microvolt = <2900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <60>;
-				regulator-always-on;
-			};
-
-			mt6358_vio28_reg: ldo_vio28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vio28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_va12_reg: ldo_va12 {
-				compatible = "regulator-fixed";
-				regulator-name = "va12";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-enable-ramp-delay = <270>;
-				regulator-always-on;
-			};
-
-			mt6358_vrf18_reg: ldo_vrf18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vrf18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <120>;
-			};
-
-			mt6358_vcn33_reg: ldo_vcn33 {
-				regulator-name = "vcn33";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vcama2_reg: ldo_vcama2 {
-				regulator-name = "vcama2";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vmc_reg: ldo_vmc {
-				regulator-name = "vmc";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <60>;
-			};
-
-			mt6358_vldo28_reg: ldo_vldo28 {
-				regulator-name = "vldo28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vaud28_reg: ldo_vaud28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vaud28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <270>;
-			};
-
-			mt6358_vsim2_reg: ldo_vsim2 {
-				regulator-name = "vsim2";
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <540>;
-			};
-		};
-	};
-- 
2.42.0.rc1.204.g551eb34607-goog

