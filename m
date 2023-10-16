Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB47CB4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJPUj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjJPUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:39:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F01F95;
        Mon, 16 Oct 2023 13:39:23 -0700 (PDT)
Received: from eugen-station.. (unknown [82.79.223.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 050AE660708F;
        Mon, 16 Oct 2023 21:39:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697488762;
        bh=/nG1LCr+BLQDI9UQsCcxkapd4Q2MOKs1nN2UqO2IwNo=;
        h=From:To:Cc:Subject:Date:From;
        b=NltOnq4Gv3FQyhf1noQActckgIB3mUKsOUhXdmHJMDOD4I2Cdf3Nkqy5zqVPKiI2P
         A3Vaz5Vyo1fj3aoW6I8kiRCo+o08lr3a/WwiNCk+Tebaeu/mSGLOZG/MfwINLNq6vT
         LM3x+HLqGStDUjIAqwlcLM9gzAWcBA7iavEXbPvH+rg5WAt/s59mPpzVdmCnv4rtZM
         +EZmnh1hMCl3sPcFdJBa9MPVJtJ5FKBK6QpqeVFmj0xchhciDPvuFYf1la05kFWNJv
         iMyczuEmVjTAxyZOfowfxrE/PM7k6ulOFLh6virrTsMgXMZS//dLDlPEvIkGXaq0YT
         IPxNydgkaoj6w==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7] dt-bindings: arm: mediatek: convert audsys and mt2701-afe-pcm to yaml
Date:   Mon, 16 Oct 2023 23:39:15 +0300
Message-Id: <20231016203915.9793-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mediatek,audsys binding to YAML, together with the associated
binding bindings/sound/mt2701-afe-pcm.yaml .

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- correctly renamed mt2701-audio.yaml to mediatek,mt2701-audio.yaml

Changes in v6:
- renamed mt2701-audio.yaml to mediatek,mt2701-audio.yaml
- add Rb Rob Herring

Changes in v5:
- removed example for mt2701-audio
- renamed mt2701-afe-pcm to mt2701-audio
- added clock cells as required, removed reg from required, in audsys binding
- removed reference comment in mt2701-audio
- removed assigned clocks from mt2701-audio

Changes in v4:
- fix error reported by Rob's bot : 
./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml:11:4: [error] missing starting space in comment (comments)

Changes in v3:
- not added Rb Conor Dooley since the patch was changed in a big essence
- As per review by Krzysztof, also convert the mt2701-afe-pcm and reference
the correct schema in the audsys binding.

Changes in v2:
- remove comment reference to inexistent binding



 .../bindings/arm/mediatek/mediatek,audsys.txt |  39 -----
 .../arm/mediatek/mediatek,audsys.yaml         | 153 ++++++++++++++++++
 .../bindings/sound/mediatek,mt2701-audio.yaml | 117 ++++++++++++++
 .../bindings/sound/mt2701-afe-pcm.txt         | 146 -----------------
 4 files changed, 270 insertions(+), 185 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
deleted file mode 100644
index 699776be1dd3..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-MediaTek AUDSYS controller
-============================
-
-The MediaTek AUDSYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-audsys", "syscon"
-	- "mediatek,mt6765-audsys", "syscon"
-	- "mediatek,mt6779-audio", "syscon"
-	- "mediatek,mt7622-audsys", "syscon"
-	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
-	- "mediatek,mt8167-audiosys", "syscon"
-	- "mediatek,mt8183-audiosys", "syscon"
-	- "mediatek,mt8192-audsys", "syscon"
-	- "mediatek,mt8516-audsys", "syscon"
-- #clock-cells: Must be 1
-
-The AUDSYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Required sub-nodes:
--------
-For common binding part and usage, refer to
-../sonud/mt2701-afe-pcm.txt.
-
-Example:
-
-	audsys: clock-controller@11220000 {
-		compatible = "mediatek,mt7622-audsys", "syscon";
-		reg = <0 0x11220000 0 0x2000>;
-		#clock-cells = <1>;
-
-		afe: audio-controller {
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
new file mode 100644
index 000000000000..45d4a6620041
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,audsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek AUDSYS controller
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@collabora.com>
+
+description:
+  The MediaTek AUDSYS controller provides various clocks to the system.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-audsys
+              - mediatek,mt6765-audsys
+              - mediatek,mt6779-audsys
+              - mediatek,mt7622-audsys
+              - mediatek,mt8167-audsys
+              - mediatek,mt8173-audsys
+              - mediatek,mt8183-audsys
+              - mediatek,mt8186-audsys
+              - mediatek,mt8192-audsys
+              - mediatek,mt8516-audsys
+          - const: syscon
+      - items:
+          # Special case for mt7623 for backward compatibility
+          - const: mediatek,mt7623-audsys
+          - const: mediatek,mt2701-audsys
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  audio-controller:
+    $ref: /schemas/sound/mediatek,mt2701-audio.yaml#
+    type: object
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt2701-power.h>
+    #include <dt-bindings/clock/mt2701-clk.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        audsys: clock-controller@11220000 {
+            compatible = "mediatek,mt7622-audsys", "syscon";
+            reg = <0 0x11220000 0 0x2000>;
+            #clock-cells = <1>;
+
+            afe: audio-controller {
+                compatible = "mediatek,mt2701-audio";
+                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+                             <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+                interrupt-names = "afe", "asys";
+                power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+
+                clocks = <&infracfg CLK_INFRA_AUDIO>,
+                         <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+                         <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+                         <&topckgen CLK_TOP_AUD_48K_TIMING>,
+                         <&topckgen CLK_TOP_AUD_44K_TIMING>,
+                         <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
+                         <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
+                         <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
+                         <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
+                         <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
+                         <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
+                         <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
+                         <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
+                         <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
+                         <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
+                         <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
+                         <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
+                         <&audsys CLK_AUD_I2SO1>,
+                         <&audsys CLK_AUD_I2SO2>,
+                         <&audsys CLK_AUD_I2SO3>,
+                         <&audsys CLK_AUD_I2SO4>,
+                         <&audsys CLK_AUD_I2SIN1>,
+                         <&audsys CLK_AUD_I2SIN2>,
+                         <&audsys CLK_AUD_I2SIN3>,
+                         <&audsys CLK_AUD_I2SIN4>,
+                         <&audsys CLK_AUD_ASRCO1>,
+                         <&audsys CLK_AUD_ASRCO2>,
+                         <&audsys CLK_AUD_ASRCO3>,
+                         <&audsys CLK_AUD_ASRCO4>,
+                         <&audsys CLK_AUD_AFE>,
+                         <&audsys CLK_AUD_AFE_CONN>,
+                         <&audsys CLK_AUD_A1SYS>,
+                         <&audsys CLK_AUD_A2SYS>,
+                         <&audsys CLK_AUD_AFE_MRGIF>;
+
+                clock-names = "infra_sys_audio_clk",
+                              "top_audio_mux1_sel",
+                              "top_audio_mux2_sel",
+                              "top_audio_a1sys_hp",
+                              "top_audio_a2sys_hp",
+                              "i2s0_src_sel",
+                              "i2s1_src_sel",
+                              "i2s2_src_sel",
+                              "i2s3_src_sel",
+                              "i2s0_src_div",
+                              "i2s1_src_div",
+                              "i2s2_src_div",
+                              "i2s3_src_div",
+                              "i2s0_mclk_en",
+                              "i2s1_mclk_en",
+                              "i2s2_mclk_en",
+                              "i2s3_mclk_en",
+                              "i2so0_hop_ck",
+                              "i2so1_hop_ck",
+                              "i2so2_hop_ck",
+                              "i2so3_hop_ck",
+                              "i2si0_hop_ck",
+                              "i2si1_hop_ck",
+                              "i2si2_hop_ck",
+                              "i2si3_hop_ck",
+                              "asrc0_out_ck",
+                              "asrc1_out_ck",
+                              "asrc2_out_ck",
+                              "asrc3_out_ck",
+                              "audio_afe_pd",
+                              "audio_afe_conn_pd",
+                              "audio_a1sys_pd",
+                              "audio_a2sys_pd",
+                              "audio_mrgif_pd";
+
+                assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
+                                  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
+                                  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
+                                  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
+                assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
+                                         <&topckgen CLK_TOP_AUD2PLL_90M>;
+                assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml
new file mode 100644
index 000000000000..83fd7bb9cadb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt2701-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Audio Front End (AFE) PCM controller for mt2701
+
+description:
+  The AFE PCM node must be a subnode of the MediaTek audsys device tree node.
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-audio
+      - mediatek,mt7622-audio
+
+  interrupts:
+    items:
+      - description: AFE interrupt
+      - description: ASYS interrupt
+
+  interrupt-names:
+    items:
+      - const: afe
+      - const: asys
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: audio infra sys clock
+      - description: top audio mux 1
+      - description: top audio mux 2
+      - description: top audio sys a1 clock
+      - description: top audio sys a2 clock
+      - description: i2s0 source selection
+      - description: i2s1 source selection
+      - description: i2s2 source selection
+      - description: i2s3 source selection
+      - description: i2s0 source divider
+      - description: i2s1 source divider
+      - description: i2s2 source divider
+      - description: i2s3 source divider
+      - description: i2s0 master clock
+      - description: i2s1 master clock
+      - description: i2s2 master clock
+      - description: i2s3 master clock
+      - description: i2so0 hopping clock
+      - description: i2so1 hopping clock
+      - description: i2so2 hopping clock
+      - description: i2so3 hopping clock
+      - description: i2si0 hopping clock
+      - description: i2si1 hopping clock
+      - description: i2si2 hopping clock
+      - description: i2si3 hopping clock
+      - description: asrc0 output clock
+      - description: asrc1 output clock
+      - description: asrc2 output clock
+      - description: asrc3 output clock
+      - description: audio front end pd clock
+      - description: audio front end conn pd clock
+      - description: top audio a1 sys pd
+      - description: top audio a2 sys pd
+      - description: audio merge interface pd
+
+  clock-names:
+    items:
+      - const: infra_sys_audio_clk
+      - const: top_audio_mux1_sel
+      - const: top_audio_mux2_sel
+      - const: top_audio_a1sys_hp
+      - const: top_audio_a2sys_hp
+      - const: i2s0_src_sel
+      - const: i2s1_src_sel
+      - const: i2s2_src_sel
+      - const: i2s3_src_sel
+      - const: i2s0_src_div
+      - const: i2s1_src_div
+      - const: i2s2_src_div
+      - const: i2s3_src_div
+      - const: i2s0_mclk_en
+      - const: i2s1_mclk_en
+      - const: i2s2_mclk_en
+      - const: i2s3_mclk_en
+      - const: i2so0_hop_ck
+      - const: i2so1_hop_ck
+      - const: i2so2_hop_ck
+      - const: i2so3_hop_ck
+      - const: i2si0_hop_ck
+      - const: i2si1_hop_ck
+      - const: i2si2_hop_ck
+      - const: i2si3_hop_ck
+      - const: asrc0_out_ck
+      - const: asrc1_out_ck
+      - const: asrc2_out_ck
+      - const: asrc3_out_ck
+      - const: audio_afe_pd
+      - const: audio_afe_conn_pd
+      - const: audio_a1sys_pd
+      - const: audio_a2sys_pd
+      - const: audio_mrgif_pd
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - power-domains
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
deleted file mode 100644
index f548e6a58240..000000000000
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ /dev/null
@@ -1,146 +0,0 @@
-Mediatek AFE PCM controller for mt2701
-
-Required properties:
-- compatible: should be one of the following.
-	      - "mediatek,mt2701-audio"
-	      - "mediatek,mt7622-audio"
-- interrupts: should contain AFE and ASYS interrupts
-- interrupt-names: should be "afe" and "asys"
-- power-domains: should define the power domain
-- clocks: Must contain an entry for each entry in clock-names
-  See ../clocks/clock-bindings.txt for details
-- clock-names: should have these clock names:
-		"infra_sys_audio_clk",
-		"top_audio_mux1_sel",
-		"top_audio_mux2_sel",
-		"top_audio_a1sys_hp",
-		"top_audio_a2sys_hp",
-		"i2s0_src_sel",
-		"i2s1_src_sel",
-		"i2s2_src_sel",
-		"i2s3_src_sel",
-		"i2s0_src_div",
-		"i2s1_src_div",
-		"i2s2_src_div",
-		"i2s3_src_div",
-		"i2s0_mclk_en",
-		"i2s1_mclk_en",
-		"i2s2_mclk_en",
-		"i2s3_mclk_en",
-		"i2so0_hop_ck",
-		"i2so1_hop_ck",
-		"i2so2_hop_ck",
-		"i2so3_hop_ck",
-		"i2si0_hop_ck",
-		"i2si1_hop_ck",
-		"i2si2_hop_ck",
-		"i2si3_hop_ck",
-		"asrc0_out_ck",
-		"asrc1_out_ck",
-		"asrc2_out_ck",
-		"asrc3_out_ck",
-		"audio_afe_pd",
-		"audio_afe_conn_pd",
-		"audio_a1sys_pd",
-		"audio_a2sys_pd",
-		"audio_mrgif_pd";
-- assigned-clocks: list of input clocks and dividers for the audio system.
-		   See ../clocks/clock-bindings.txt for details.
-- assigned-clocks-parents: parent of input clocks of assigned clocks.
-- assigned-clock-rates: list of clock frequencies of assigned clocks.
-
-Must be a subnode of MediaTek audsys device tree node.
-See ../arm/mediatek/mediatek,audsys.txt for details about the parent node.
-
-Example:
-
-	audsys: audio-subsystem@11220000 {
-		compatible = "mediatek,mt2701-audsys", "syscon";
-		...
-
-		afe: audio-controller {
-			compatible = "mediatek,mt2701-audio";
-			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-			interrupt-names	= "afe", "asys";
-			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
-
-			clocks = <&infracfg CLK_INFRA_AUDIO>,
-				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
-				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
-				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
-				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
-				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
-				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
-				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
-				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
-				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
-				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
-				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
-				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
-				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
-				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
-				 <&audsys CLK_AUD_I2SO1>,
-				 <&audsys CLK_AUD_I2SO2>,
-				 <&audsys CLK_AUD_I2SO3>,
-				 <&audsys CLK_AUD_I2SO4>,
-				 <&audsys CLK_AUD_I2SIN1>,
-				 <&audsys CLK_AUD_I2SIN2>,
-				 <&audsys CLK_AUD_I2SIN3>,
-				 <&audsys CLK_AUD_I2SIN4>,
-				 <&audsys CLK_AUD_ASRCO1>,
-				 <&audsys CLK_AUD_ASRCO2>,
-				 <&audsys CLK_AUD_ASRCO3>,
-				 <&audsys CLK_AUD_ASRCO4>,
-				 <&audsys CLK_AUD_AFE>,
-				 <&audsys CLK_AUD_AFE_CONN>,
-				 <&audsys CLK_AUD_A1SYS>,
-				 <&audsys CLK_AUD_A2SYS>,
-				 <&audsys CLK_AUD_AFE_MRGIF>;
-
-			clock-names = "infra_sys_audio_clk",
-				      "top_audio_mux1_sel",
-				      "top_audio_mux2_sel",
-				      "top_audio_a1sys_hp",
-				      "top_audio_a2sys_hp",
-				      "i2s0_src_sel",
-				      "i2s1_src_sel",
-				      "i2s2_src_sel",
-				      "i2s3_src_sel",
-				      "i2s0_src_div",
-				      "i2s1_src_div",
-				      "i2s2_src_div",
-				      "i2s3_src_div",
-				      "i2s0_mclk_en",
-				      "i2s1_mclk_en",
-				      "i2s2_mclk_en",
-				      "i2s3_mclk_en",
-				      "i2so0_hop_ck",
-				      "i2so1_hop_ck",
-				      "i2so2_hop_ck",
-				      "i2so3_hop_ck",
-				      "i2si0_hop_ck",
-				      "i2si1_hop_ck",
-				      "i2si2_hop_ck",
-				      "i2si3_hop_ck",
-				      "asrc0_out_ck",
-				      "asrc1_out_ck",
-				      "asrc2_out_ck",
-				      "asrc3_out_ck",
-				      "audio_afe_pd",
-				      "audio_afe_conn_pd",
-				      "audio_a1sys_pd",
-				      "audio_a2sys_pd",
-				      "audio_mrgif_pd";
-
-			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
-					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
-			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
-						 <&topckgen CLK_TOP_AUD2PLL_90M>;
-			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
-		};
-	};
-- 
2.34.1

