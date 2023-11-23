Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51887F5E41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbjKWLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbjKWLw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:52:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969271A5;
        Thu, 23 Nov 2023 03:52:33 -0800 (PST)
X-UUID: c783552689f611eea33bb35ae8d461a2-20231123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=npo17YZ27fotVhhzuQeyCvo86ZlC56RHG3gTlq+INPQ=;
        b=RdNpGN3cVjL19hw91ecR3MEo7Lv99kDeLl4fIKLsU/3UL+CetE2fSTLrMJ3uqPRmWHxjBoCz2+hZj3riAqRztt9pVBqeLrBD3ri+Gh5kdXNx03MsvHUZ/Didk1etFTE3fe7wqiW+Kwrg41Wr6XerWnLYYKVo5porJAhT197qCiY=;
X-CID-CACHE: Type:Local,Time:202311231905+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6d5b5887-137d-4edf-a6d0-887086b99519,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:a29dfd72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c783552689f611eea33bb35ae8d461a2-20231123
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <zhi.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1556815132; Thu, 23 Nov 2023 19:52:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 Nov 2023 19:52:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 23 Nov 2023 19:52:27 +0800
From:   Zhi Mao <zhi.mao@mediatek.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <shengnan.wang@mediatek.com>, <yaya.chang@mediatek.com>,
        <10572168@qq.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <yunkec@chromium.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jacopo.mondi@ideasonboard.com>, <sakari.ailus@linux.intel.com>,
        <zhi.mao@mediatek.com>, <hverkuil-cisco@xs4all.nl>,
        <heiko@sntech.de>, <jernej.skrabec@gmail.com>,
        <macromorgan@hotmail.com>, <linus.walleij@linaro.org>,
        <laurent.pinchart@ideasonboard.com>, <hdegoede@redhat.com>,
        <tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
        <andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
        <dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] media: dt-bindings: media: i2c: Document GC08A3 bindings
Date:   Thu, 23 Nov 2023 19:51:03 +0800
Message-ID: <20231123115104.32094-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123115104.32094-1-zhi.mao@mediatek.com>
References: <20231123115104.32094-1-zhi.mao@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML device tree binding for GC08A3 CMOS image sensor, 
and the relevant MAINTAINERS entries.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../bindings/media/i2c/galaxycore,gc08a3.yaml | 128 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
new file mode 100644
index 000000000000..089ea321da91
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
+
+maintainers:
+  - Zhi Mao <zhi.mao@mediatek.com>
+
+description: |-
+  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
+  interface and CCI (I2C compatible) control bus. The output format
+  is raw Bayer.
+
+properties:
+  compatible:
+    const: GalaxyCore,gc08a3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the mclk clock.
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  enable-gpios:
+    description: Reference to the GPIO connected to the RESETB pin. Active low.
+    maxItems: 1
+
+  vddio-supply:
+    description: Definition of the regulator used for the VDDIO power supply.
+
+  vdda-supply:
+    description: Definition of the regulator used for the VDDA power supply.
+
+  vddd-supply:
+    description: Definition of the regulator used for the VDDD power supply.
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+              - items:
+                  - const: 1
+                  - const: 2
+
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - assigned-clocks
+  - assigned-clock-rates
+  - vddio-supply
+  - vdda-supply
+  - vddd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor0@2 {
+            status = "okay";
+            compatible = "GalaxyCore,gc08a3";
+            reg = <0x31>;
+
+            clocks = <&topckgen CLK_TOP_CAMTG>,
+                <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
+            clock-names = "xvclk", "freq_mux";
+            clock-frequency = <24000000>;
+
+            assigned-clocks = <&topckgen CLK_TOP_CAMTG>,
+                    <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
+            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
+            assigned-clock-rates = <0>, <24000000>;
+
+            enable-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&camera_pins_cam0>;
+
+            avdd-supply = <&mt6359_vfe28_ldo_reg>;
+
+            port {
+                sensor0_out_2: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <336000000 207000000>;
+                    remote-endpoint = <&seninf_csi_port_0_in_2>;
+                };
+            };
+        };
+
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..a0bbec0bfee2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -502,6 +502,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^GalaxyCore,.*":
+    description: GalaxyCore Inc.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateway,.*":
-- 
2.25.1

