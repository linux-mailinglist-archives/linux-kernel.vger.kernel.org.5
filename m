Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302487D691D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJYKlE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343665AbjJYKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:40:21 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682F10EB;
        Wed, 25 Oct 2023 03:40:14 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D01D324E295;
        Wed, 25 Oct 2023 18:39:58 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 18:39:58 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 18:39:58 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Keith Zhao <keith.zhao@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/6] dt-bindings: display: Add yamls for JH7110 display system
Date:   Wed, 25 Oct 2023 18:39:52 +0800
Message-ID: <20231025103957.3776-2-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025103957.3776-1-keith.zhao@starfivetech.com>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

StarFive SoCs JH7110 display system:
lcd-controller bases verisilicon dc8200 IP,
and hdmi bases Innosilicon IP. Add bindings for them.

also update MAINTAINERS for dt-bindings

about this patch, I tested the dtbs_check and dt_binding_check
with the result pass.
Based on the feedback of the previous version, the corresponding arrangement is made

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 .../starfive/starfive,display-subsystem.yaml  |  41 +++++++
 .../starfive/starfive,jh7110-dc8200.yaml      | 109 ++++++++++++++++++
 .../starfive/starfive,jh7110-inno-hdmi.yaml   |  85 ++++++++++++++
 MAINTAINERS                                   |   7 ++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml b/Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml
new file mode 100644
index 000000000..f45b97b08
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/starfive/starfive,display-subsystem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Starfive DRM master device
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+  - ShengYang Chen <shengyang.chen@starfivetech.com>
+
+description:
+  The Starfive DRM master device is a virtual device needed to list all
+  display controller or other display interface nodes that comprise the
+  graphics subsystem.
+
+properties:
+  compatible:
+    const: starfive,display-subsystem
+
+  ports:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should contain a list of phandles pointing to display interface ports
+      of display controller devices. Display controller definitions as defined
+      in Documentation/devicetree/bindings/display/starfive/
+      starfive,jh7110-dc8200.yaml
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "starfive,display-subsystem";
+        ports = <&dc_out>;
+    };
diff --git a/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
new file mode 100644
index 000000000..87051cddf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/starfive/starfive,jh7110-dc8200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive display controller
+
+description:
+  The StarFive SoC uses the display controller based on Verisilicon IP
+  to transfer the image data from a video memory buffer to an external
+  LCD interface.
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-dc8200
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          host interface
+      - description:
+          display physical base address and length.
+
+  interrupts:
+    items:
+      - description: The interrupt will be generated when DC finish one frame
+
+  clocks:
+    items:
+      - description: Clock for display system noc bus.
+      - description: Pixel clock for display channel 0.
+      - description: Pixel clock for display channel 1.
+      - description: Core clock for display controller.
+      - description: Clock for axi bus to access ddr.
+      - description: Clock for ahb bus to R/W the phy regs.
+      - description: External HDMI pixel clock.
+      - description: Parent clock for pixel clock
+
+  clock-names:
+    items:
+      - const: noc_bus
+      - const: channel0
+      - const: channel1
+      - const: dc_core
+      - const: axi_core
+      - const: ahb
+      - const: hdmi_tx
+      - const: dc_parent
+
+  resets:
+    items:
+      - description: Reset for axi bus.
+      - description: Reset for ahb bus.
+      - description: Core reset of display controller.
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: core
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dc8200: lcd-controller@29400000 {
+        compatible = "starfive,jh7110-dc8200";
+        reg = <0x29400000 0x100>, <0x29400800 0x2000>;
+        interrupts = <95>;
+        clocks = <&syscrg 60>,
+               <&voutcrg 7>,
+               <&voutcrg 8>,
+               <&voutcrg 4>,
+               <&voutcrg 5>,
+               <&voutcrg 6>,
+               <&hdmitx0_pixelclk>,
+               <&voutcrg 1>;
+        clock-names = "noc_bus", "channel0", "channel1",
+                      "dc_core", "axi_core", "ahb",
+                      "hdmi_tx","dc_parent";
+        resets = <&voutcrg 0>, <&voutcrg 1>, <&voutcrg 2>;
+        reset-names = "axi", "ahb", "core";
+        dc_out: port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            dc_out_hdmi: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&hdmi_in_dc>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
new file mode 100644
index 000000000..f6c473a10
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/starfive/starfive,jh7110-inno-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Starfive JH7110 HDMI controller
+
+description:
+  The StarFive JH7110 SoC uses the HDMI signal transmiter based on innosilicon IP
+  to generate HDMI signal from its input and transmit the signal to the screen.
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+
+properties:
+  compatible:
+    const: "starfive,jh7110-inno-hdmi"
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    items:
+      - description: The HDMI hot plug detection interrupt.
+
+  clocks:
+    items:
+      - description: System clock of HDMI module.
+      - description: Mclk clock of HDMI audio.
+      - description: Bclk clock of HDMI audio.
+      - description: Pixel clock generated by HDMI module.
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: mclk
+      - const: bclk
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Should contain a remote endpoint phandle of display controller device.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - '#sound-dai-cells'
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi: hdmi@29590000 {
+        compatible = "starfive,jh7110-inno-hdmi";
+        reg = <0x29590000 0x4000>;
+        interrupts = <99>;
+        clocks = <&voutcrg 17>,
+               <&voutcrg 15>,
+               <&voutcrg 16>,
+               <&hdmitx0_pixelclk>;
+        clock-names = "sysclk", "mclk","bclk","pclk";
+        resets = <&voutcrg 9>;
+        #sound-dai-cells = <0>;
+        hdmi_in: port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            hdmi_in_dc: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dc_out_hdmi>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8..46e51bca5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6751,6 +6751,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
 F:	drivers/gpu/drm/panel/panel-tpo-tpg110.c
 
+DRM DRIVERS FOR STARFIVE
+M:	Keith Zhao <keith.zhao@starfivetech.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/starfive/
+
 DRM DRIVER FOR USB DISPLAYLINK VIDEO ADAPTERS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Sean Paul <sean@poorly.run>
-- 
2.34.1

