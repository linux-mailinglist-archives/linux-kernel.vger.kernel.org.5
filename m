Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6D7D50D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbjJXNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjJXNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:01:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2610EB;
        Tue, 24 Oct 2023 06:01:01 -0700 (PDT)
X-UUID: 5d57e018726d11eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wz5OALFXPakgkY/6zI5st3VnAGofoaR/7iQ2aldCR5g=;
        b=kNempwyH/txmUM/+HPymeY02CvPmzu4HF/b7rceWSgJxQQWOvZEknZFjiDqH4ykGUyY1O0gjycOW8Oz0Yna6BAHOt332mnTabu/cIRmOrkKVtifHZaZzchUo2E+RrEyeoLdSMpGlPDb7v6uxjh2S9EjKeR9IWKk8A5v6KQ/F1/8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ba737c91-cf19-4077-90c4-78dccc852948,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:7c809394-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 5d57e018726d11eea33bb35ae8d461a2-20231024
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 65593200; Tue, 24 Oct 2023 21:00:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 21:00:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 21:00:52 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 04/23] dt-bindings: display: mediatek: padding: Add MT8188
Date:   Tue, 24 Oct 2023 21:00:29 +0800
Message-ID: <20231024130048.14749-5-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231024130048.14749-1-shawn.sung@mediatek.com>
References: <20231024130048.14749-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padding is a new hardware module on MediaTek MT8188,
add dt-bindings for it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../display/mediatek/mediatek,padding.yaml    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
new file mode 100644
index 000000000000..6bad7dc2d69f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,padding.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Padding
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description:
+  Padding provides ability to add pixels to width and height of a layer with
+  specified colors. Due to hardware design, Mixer in VDOSYS1 requires
+  width of a layer to be 2-pixel-align, or 4-pixel-align when ETHDR is enabled,
+  we need Padding to deal with odd width.
+  Please notice that even if the Padding is in bypass mode, settings in
+  register must be cleared to 0, or undefined behaviors could happen.
+
+properties:
+  compatible:
+    const: mediatek,mt8188-disp-padding
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Padding's clocks
+
+  mediatek,gce-client-reg:
+    description:
+      GCE (Global Command Engine) is a multi-core micro processor that helps
+      its clients to execute commands without interrupting CPU. This property
+      describes GCE client's information that is composed by 4 fields.
+      1. Phandle of the GCE (there may be several GCE processors)
+      2. Sub-system ID defined in the dt-binding like a user ID
+         (Please refer to include/dt-bindings/gce/<chip>-gce.h)
+      3. Offset from base address of the subsys you are at
+      4. Size of the register the client needs
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: Phandle of the GCE
+        - description: Subsys ID defined in the dt-binding
+        - description: Offset from base address of the subsys
+        - description: Size of register
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - mediatek,gce-client-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mediatek,mt8188-clk.h>
+    #include <dt-bindings/power/mediatek,mt8188-power.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        padding0: padding@1c11d000 {
+            compatible = "mediatek,mt8188-disp-padding";
+            reg = <0 0x1c11d000 0 0x1000>;
+            clocks = <&vdosys1 CLK_VDO1_PADDING0>;
+            power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+            mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0xd000 0x1000>;
+        };
+    };
-- 
2.18.0

