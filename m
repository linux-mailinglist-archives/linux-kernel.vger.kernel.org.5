Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B157DC86A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjJaIe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJaIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:34:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491EEA;
        Tue, 31 Oct 2023 01:34:08 -0700 (PDT)
X-UUID: 3d23231077c811ee8051498923ad61e6-20231031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jo1hObxFgl0F8f5AcHw6jWjMvrguUHZ7O2Ic6a912lU=;
        b=qLwVo7VMASxlI5PHR0Y8/pTU8Gg7hytmfFO1QMSyPWQkVD8AyWPLqOegRqDzUbunGslZZlMPRhIg0sUZuoT0mykZid+IqizyTuQB9HlUxQc4Khs1JJyDBSRnUI2AXhVEZA2LxrGbBZlGTsB/VXoA3FM8sWHV0fkuHtrh2ftC6o8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:53118c40-31a8-44ef-b96f-d2da3fda4661,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:3490d694-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3d23231077c811ee8051498923ad61e6-20231031
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2056321715; Tue, 31 Oct 2023 16:33:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 31 Oct 2023 16:33:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 31 Oct 2023 16:33:58 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v9 01/16] dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node with generic names
Date:   Tue, 31 Oct 2023 16:33:42 +0800
Message-ID: <20231031083357.13775-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231031083357.13775-1-moudy.ho@mediatek.com>
References: <20231031083357.13775-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA-related nodes RDMA/WROT in MDP3 should be changed to generic names.
In addition, fix improper space indent in example.

Fixes: 4ad7b39623ab ("media: dt-binding: mediatek: add bindings for MediaTek MDP3 components")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 29 +++++++++++--------
 .../bindings/media/mediatek,mdp3-wrot.yaml    | 23 +++++++++------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 7032c7e15039..3e128733ef53 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -61,6 +61,9 @@ properties:
       - description: used for 1st data pipe from RDMA
       - description: used for 2nd data pipe from RDMA
 
+  '#dma-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -70,6 +73,7 @@ required:
   - clocks
   - iommus
   - mboxes
+  - '#dma-cells'
 
 additionalProperties: false
 
@@ -80,16 +84,17 @@ examples:
     #include <dt-bindings/power/mt8183-power.h>
     #include <dt-bindings/memory/mt8183-larb-port.h>
 
-    mdp3_rdma0: mdp3-rdma0@14001000 {
-      compatible = "mediatek,mt8183-mdp3-rdma";
-      reg = <0x14001000 0x1000>;
-      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
-      mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
-                            <CMDQ_EVENT_MDP_RDMA0_EOF>;
-      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
-      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
-               <&mmsys CLK_MM_MDP_RSZ1>;
-      iommus = <&iommu>;
-      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
-               <&gce 21 CMDQ_THR_PRIO_LOWEST>;
+    dma-controller@14001000 {
+        compatible = "mediatek,mt8183-mdp3-rdma";
+        reg = <0x14001000 0x1000>;
+        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
+        mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
+                              <CMDQ_EVENT_MDP_RDMA0_EOF>;
+        power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+        clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+                 <&mmsys CLK_MM_MDP_RSZ1>;
+        iommus = <&iommu>;
+        mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
+                 <&gce 21 CMDQ_THR_PRIO_LOWEST>;
+        #dma-cells = <1>;
     };
diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
index 0baa77198fa2..64ea98aa0592 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
@@ -50,6 +50,9 @@ properties:
   iommus:
     maxItems: 1
 
+  '#dma-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -58,6 +61,7 @@ required:
   - power-domains
   - clocks
   - iommus
+  - '#dma-cells'
 
 additionalProperties: false
 
@@ -68,13 +72,14 @@ examples:
     #include <dt-bindings/power/mt8183-power.h>
     #include <dt-bindings/memory/mt8183-larb-port.h>
 
-    mdp3_wrot0: mdp3-wrot0@14005000 {
-      compatible = "mediatek,mt8183-mdp3-wrot";
-      reg = <0x14005000 0x1000>;
-      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
-      mediatek,gce-events = <CMDQ_EVENT_MDP_WROT0_SOF>,
-                            <CMDQ_EVENT_MDP_WROT0_EOF>;
-      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
-      clocks = <&mmsys CLK_MM_MDP_WROT0>;
-      iommus = <&iommu>;
+    dma-controller@14005000 {
+        compatible = "mediatek,mt8183-mdp3-wrot";
+        reg = <0x14005000 0x1000>;
+        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+        mediatek,gce-events = <CMDQ_EVENT_MDP_WROT0_SOF>,
+                              <CMDQ_EVENT_MDP_WROT0_EOF>;
+        power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+        clocks = <&mmsys CLK_MM_MDP_WROT0>;
+        iommus = <&iommu>;
+        #dma-cells = <1>;
     };
-- 
2.18.0

