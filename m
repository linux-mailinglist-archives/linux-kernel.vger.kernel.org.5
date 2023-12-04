Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33E803BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjLDRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjLDRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:39:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4012E1;
        Mon,  4 Dec 2023 09:39:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so189220166b.1;
        Mon, 04 Dec 2023 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701711545; x=1702316345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDbV8KEqo360AWt22zz09PqUE/cssUErxHrowGLoINk=;
        b=hSA/3hnuwexjtdAnqzY9VgmYJ15X7WehPSXeJnGgERxDw29GpS2/TkaL8FFkQVJx/R
         TyZHHI8gj2Xzw2f/deynAThNP4WB3adfwcuodv0ChQOX60YNhWaDvaFbt9pdvdfvnsWs
         FOYH79uyAzQyFCfcjM4rXZBSC1CA3SYjnzcm8fSbl7y7xBCpaNPHRe50BPGMFc/tp3d3
         kfTSBH733h8DLmZ7jLZNJ9jWYZHhUy6TD8/AnR7qbCT82sCtaWUW3gt3vvnSSDkwHi0N
         WegBaiKcfpJB5qM9Tlq27t0MBb+A/dvbRt70RkZkH/SwU9zLgw+fwIYXPZ+gdUMROT2P
         W0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711545; x=1702316345;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDbV8KEqo360AWt22zz09PqUE/cssUErxHrowGLoINk=;
        b=DX5bZZwKJH/MQYfdfQ2aQxz9GeGWUcWWA71nOStH/AwiGp7RPZKLxdSlyjX6/Tuwyd
         pk2+JdA8LIWIdScxm2OrQArlUn7MdQa8rl5DtOjQrZ+oR6gbSYWfQiPKSpraRxVG+JoC
         bYDjZEuKVtLTNOc59yPTUShuojWHGLMMbA+MHnPVmfHklnUHjAooFEf//oqH3MH1sNRM
         Jjh3WvERv1E5C/F+CVy4zrb7pAwDkM4YkgxBO8lCz5NC9qTQyqHYVUv5XrdBVC1NMer/
         ll2z3iyqfnqlvbDVBl5ys8QFhsdVvUMXMB4gm+NWFVvJnZnPtSwm8dNn9bBqXohFNjBe
         e34g==
X-Gm-Message-State: AOJu0YzNEPKZlBUCRe/6HDvR4jzCAr9HyicWDsZlVwOaufsyHTpFA6TR
        WbsxqXBrUZbJreE7xAM49srba0Gd+1E=
X-Google-Smtp-Source: AGHT+IFY1TkeVeRGWBrgWf2i0O9q9pzjrUYsznblS+VoCoNd0mGuLFzQmCXoRFFl4jZvbkNMocSkjA==
X-Received: by 2002:a17:906:1d4:b0:a1b:774f:df5c with SMTP id 20-20020a17090601d400b00a1b774fdf5cmr1686472ejj.14.1701711545198;
        Mon, 04 Dec 2023 09:39:05 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b00a1907e36244sm5128328ejb.118.2023.12.04.09.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:39:04 -0800 (PST)
Message-ID: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
Date:   Mon, 4 Dec 2023 18:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: drm: rockchip: convert
 inno_hdmi-rockchip.txt to yaml
To:     heiko@sntech.de, hjc@rock-chips.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert inno_hdmi-rockchip.txt to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Note for rob+dt:
  Used enum to "soon" be able to add "rockchip,rk3128-inno-hdmi"

Changed V1:
  Rename file to more common layout
  Add/fix hdmi_out port example
---
 .../display/rockchip/inno_hdmi-rockchip.txt   |  49 ---------
 .../display/rockchip/rockchip,inno-hdmi.yaml  | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
deleted file mode 100644
index cec21714f0e0..000000000000
--- a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Rockchip specific extensions to the Innosilicon HDMI
-================================
-
-Required properties:
-- compatible:
-	"rockchip,rk3036-inno-hdmi";
-- reg:
-	Physical base address and length of the controller's registers.
-- clocks, clock-names:
-	Phandle to hdmi controller clock, name should be "pclk"
-- interrupts:
-	HDMI interrupt number
-- ports:
-	Contain one port node with endpoint definitions as defined in
-	Documentation/devicetree/bindings/graph.txt.
-- pinctrl-0, pinctrl-name:
-	Switch the iomux of HPD/CEC pins to HDMI function.
-
-Example:
-hdmi: hdmi@20034000 {
-	compatible = "rockchip,rk3036-inno-hdmi";
-	reg = <0x20034000 0x4000>;
-	interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cru  PCLK_HDMI>;
-	clock-names = "pclk";
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_ctl>;
-
-	hdmi_in: port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		hdmi_in_lcdc: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&lcdc_out_hdmi>;
-		};
-	};
-};
-
-&pinctrl {
-	hdmi {
-		hdmi_ctl: hdmi-ctl {
-			rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
-					<1 9  RK_FUNC_1 &pcfg_pull_none>,
-					<1 10 RK_FUNC_1 &pcfg_pull_none>,
-					<1 11 RK_FUNC_1 &pcfg_pull_none>;
-		};
-	};
-
-};
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
new file mode 100644
index 000000000000..96889c86849a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,inno-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Innosilicon HDMI controller
+
+maintainers:
+  - Sandy Huang <hjc@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3036-inno-hdmi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port node with one endpoint connected to a vop node.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port node with one endpoint connected to a hdmi-connector node.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - pinctrl-0
+  - pinctrl-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3036-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+    hdmi: hdmi@20034000 {
+      compatible = "rockchip,rk3036-inno-hdmi";
+      reg = <0x20034000 0x4000>;
+      interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru  PCLK_HDMI>;
+      clock-names = "pclk";
+      pinctrl-names = "default";
+      pinctrl-0 = <&hdmi_ctl>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hdmi_in: port@0 {
+          reg = <0>;
+          hdmi_in_vop: endpoint {
+            remote-endpoint = <&vop_out_hdmi>;
+          };
+        };
+
+        hdmi_out: port@1 {
+          reg = <1>;
+          hdmi_out_con: endpoint {
+            remote-endpoint = <&hdmi_con_in>;
+          };
+        };
+      };
+    };
+
+    pinctrl {
+      hdmi {
+        hdmi_ctl: hdmi-ctl {
+          rockchip,pins = <1 RK_PB0 1 &pcfg_pull_none>,
+                          <1 RK_PB1 1 &pcfg_pull_none>,
+                          <1 RK_PB2 1 &pcfg_pull_none>,
+                          <1 RK_PB3 1 &pcfg_pull_none>;
+        };
+      };
+    };
--
2.39.2

