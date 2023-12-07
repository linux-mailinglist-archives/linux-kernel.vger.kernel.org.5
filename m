Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EF80801A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjLGFVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjLGFVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:21:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C50D10E7;
        Wed,  6 Dec 2023 21:21:13 -0800 (PST)
X-UUID: 6d141b4694c011eea5db2bebc7c28f94-20231207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=utKiulZ4UeB0jjmnBABZ5jIy2pn3SDZWABNtpqnuktQ=;
        b=LCNdqvkkAPdH9gjJYCAvZM/nAYQLo0q4m9buV3fb7bhV0wzr79awWbRVbtz55Wji/13jlQRJ8CUtwpiJy+jQ1Tjx3KFpJ9drhvRzREc8CyCDO8mdiRqtRrFPwrnKKt/90wqbOZ87lfMKbiEWE5jH5G2njG4/N7mYgT7mS2AI2Ek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:62cdf3ca-9a7b-414c-b4c0-50526e7dad57,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:978662fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6d141b4694c011eea5db2bebc7c28f94-20231207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <zhi.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 576576200; Thu, 07 Dec 2023 13:21:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Dec 2023 13:21:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Dec 2023 13:21:04 +0800
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
Subject: [PATCH 2/2] media: dt-bindings: media: i2c: Document GC08A3 bindings
Date:   Thu, 7 Dec 2023 13:20:16 +0800
Message-ID: <20231207052016.25954-3-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207052016.25954-1-zhi.mao@mediatek.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.435300-8.000000
X-TMASE-MatchedRID: XAa2d/45j8SuhCBFl/b63gPZZctd3P4B9l9p8mNlkgk1LB46LFAAkkd0
        Rzx07LDV96TYN1fO8g6y9AsAxk+TJQAwGIAo3Shb71Wx2uUbPLdbAoaK+wS4jee+ZCR6qEmPGAg
        eo2y7APLoZcBNClQRIQGZLfTlpw3f9GlJz+74uGzr/EBmiNuXt/ZCh7IN8a4Ai093rJhkH8B0Ly
        3sNBQaM6F8BNmSAz+6Zd7aQCHVPPQfE8yM4pjsDxZ4ylU2GwzAxEHRux+uk8jHUU+U0ACZwA/YF
        L0mDf+MJZNBa6CeO+zb0JcacqI9akktgCd2BrHinqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.435300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 47693002D59BB255A4E63C0C116B38D62A591E8EDE2CB8672FDBAF65BCD97B702000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML device tree binding for GC08A3 CMOS image sensor,
and the relevant MAINTAINERS entries.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../bindings/media/i2c/galaxycore,gc08a3.yaml | 127 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
new file mode 100644
index 000000000000..1802ff1c8a12
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek Inc.
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
+description:
+  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
+  interface and CCI (I2C compatible) control bus. The output format
+  is raw Bayer.
+
+properties:
+  compatible:
+    const: galaxycore,gc08a3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      External clock for the sensor.
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Frequency of the clock in Hz.
+
+  dovdd-supply: true
+
+  avdd-supply: true
+
+  dvdd-supply: true
+
+  enable-gpios:
+    description: Reference to the GPIO connected to the RESETB pin. Active low.
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description:
+      Output port node, single endpoint describing the CSI-2 transmitter.
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
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - enable-gpios
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
+        sensor0@31 {
+            status = "okay";
+            compatible = "galaxycore,gc08a3";
+            reg = <0x31>;
+
+            clocks = <&gc08a3_clk>;
+            clock-names = "xvclk";
+            clock-frequency = <24000000>;
+
+            enable-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
+
+            avdd-supply = <&gc08a3_avdd>;
+            dovdd-supply = <&ogc08a3_dovdd>;
+            dvdd-supply = <&gc08a3_dvdd>;
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
index b752f8902367..1a16a94fb202 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -502,6 +502,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^galaxycore,.*":
+    description: GalaxyCore Inc.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateway,.*":
-- 
2.25.1

