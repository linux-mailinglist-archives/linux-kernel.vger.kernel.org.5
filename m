Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712BE76E225
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjHCHyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjHCHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:53:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED58A69
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686efa1804eso433275b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048588; x=1691653388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVtXI1HZxhBYq/0/uTELsRw0u0pAzWKlEP1Rn/MZ4jk=;
        b=PKwk4GEk3yopaHuENojxSNYlbNJmh6+WGq90OHBeQqMuCf/L03VfIqLe6JOtcSeJ2n
         2cxjXwsxhbh5alr8Uz9LKnOIPqOSUMrBCQmXJ9m98Li81fZgf/f+GjqyTiMEcsW3R7LK
         jPJez4gRDjDFj7HtyUX/mJ4++B3sv8bJDHcSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048588; x=1691653388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVtXI1HZxhBYq/0/uTELsRw0u0pAzWKlEP1Rn/MZ4jk=;
        b=dy+PUpoKEaHNeKxvp1t6/ZQRZHbiERukHEUeR+AHJ0mbQWlmo1a3EkSFCVlHIOyNZl
         SADAeybhpngdKP67gkStcGDjv9mrVWOWBcJSUFWpeVRmnaG7p+HjxbFOTrWN88Nrn61D
         8vaRtTuCW3JPocCOx3zyHe70B/3lgu69Uku9XbK8FQri7fyz371+GKuNkb2yodhZSdm9
         njAW+OhDp88ZooxLaAWQ4WnzJ9lPKOydypBMvggBfxJJEtaSUV2NLvbmMxJPkfsCbm0B
         9NzwEJdntya0EH+lavHcsp0hFMQboeTjcFklsNWR3V3eJx8MrqbZpuc1zVVVZRwh8UXj
         QFTw==
X-Gm-Message-State: ABy/qLZDif95I+21bXKUVBDYShDsi1DHp1mzUcqqvOOieBEvmYteBzhq
        +AS5Njrr/3buIBSe3g4108i6Yw==
X-Google-Smtp-Source: APBJJlGwLafzFcT24plp42o/OZcYOgz8zEtjUf/9xsYA2D+hxTl0/0NE4IzHmiKxo9RnR9Rc36P5xg==
X-Received: by 2002:a17:90b:8d2:b0:267:75ce:f6d9 with SMTP id ds18-20020a17090b08d200b0026775cef6d9mr14285008pjb.3.1691048588039;
        Thu, 03 Aug 2023 00:43:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:07 -0700 (PDT)
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
Subject: [PATCH 4/9] regulator: dt-bindings: mediatek: Add MT6366 PMIC
Date:   Thu,  3 Aug 2023 15:42:42 +0800
Message-ID: <20230803074249.3065586-5-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803074249.3065586-1-wenst@chromium.org>
References: <20230803074249.3065586-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since Zhiyong's last version (v4) [1]:
- simplified regulator names
- added descriptions to regulators
- removed bogus regulators (*_sshub)
- merged vcn33-wifi and vcn33-bt as vcn33
- added missing regulators (vm18, vmddr, vsram-core)
- cut down examples to a handful of cases and made them complete
- expanded commit message a lot

[1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/

 .../regulator/mediatek,mt6366-regulator.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
new file mode 100644
index 000000000000..715c6ffcb3ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6366 Regulator from MediaTek Integrated
+
+maintainers:
+  - Zhiyong Tao <zhiyong.tao@mediatek.com>
+
+description: |
+  Regulator part of the MT6366 PMIC. This node should be under the PMIC's
+  device node.
+
+properties:
+  compatible:
+    const: mediatek,mt6366-regulator
+
+  vsys_ldo1-supply:
+    description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
+  vsys_ldo2-supply:
+    description: Supply for LDOs vio28, vmc, vmch, vsim2
+  vsys_ldo3-supply:
+    description: Supply for LDOs vcn33, vemc, vibr
+  vsys_vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys_vdram1-supply:
+    description: Supply for buck regulator vdram1
+  vsys_vgpu-supply:
+    description: Supply for buck regulator vgpu
+  vsys_vmodem-supply:
+    description: Supply for buck regulator vmodem
+  vsys_vpa-supply:
+    description: Supply for buck regulator vpa
+  vsys_vproc11-supply:
+    description: Supply for buck regulator vproc11
+  vsys_vproc12-supply:
+    description: Supply for buck regulator vproc12
+  vsys_vs1-supply:
+    description: Supply for buck regulator vs1
+  vsys_vs2-supply:
+    description: Supply for buck regulator vs2
+  vs1_ldo1-supply:
+    description: Supply for LDOs vrf18, vefuse, vcn18, vio18, vm18
+  vs2_ldo1-supply:
+    description: Supply for LDOs vmddr, vdram2
+  vs2_ldo2-supply:
+    description: Supply for LDOs vrf12, va12
+  vs2_ldo3-supply:
+    description: Supply for LDOs vsram-core, vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
+
+patternProperties:
+  "^v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(a|rf)12":
+    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(aux|io|rf)18":
+    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vxo22":
+    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(aud|bif|cn|fe|io)28":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vusb":
+    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vsram-(core|gpu|others|proc1[12])$":
+    description: LDOs with variable output
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(cn18|cn33|dram2|efuse|emc|ibr|m18|mc|mch|mddr|sim[12])$":
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
+        compatible = "mediatek,mt6366-regulator";
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
+
+...
-- 
2.41.0.585.gd2178a4bd4-goog

