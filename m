Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244617C6859
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjJLIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjJLIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:40:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E15C4;
        Thu, 12 Oct 2023 01:40:49 -0700 (PDT)
X-UUID: 071ad4d068db11ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nto216znPzflD3lPPlNzRkRFAKgxDQ6cM/1N2xk9Liw=;
        b=AdCJ/3zttRRgK84QOlLpErMQMn48ygE0qc/epKcaugckSz86TV2+3GRieJLdmaQAdM6rLom3KeQHF6447Sq6epwF+2jvBCovNEwVKI4w/3yIxAzGLoh/9gWcb8qVoH0x43WCGxY39d2q/iMfwY/l0muCagQAb4Pqd42O6Nm9HyE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:99d73300-e949-49b5-b576-864d9654b7f2,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:00f009c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 071ad4d068db11ee8051498923ad61e6-20231012
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 732954632; Thu, 12 Oct 2023 16:40:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 16:40:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 16:40:40 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH v7 07/16] dt-bindings: media: mediatek: mdp3: add component HDR for MT8195
Date:   Thu, 12 Oct 2023 16:40:28 +0800
Message-ID: <20231012084037.19376-8-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231012084037.19376-1-moudy.ho@mediatek.com>
References: <20231012084037.19376-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the fundamental hardware configuration of component HDR,
which is controlled by MDP3 on MT8195.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/media/mediatek,mdp3-hdr.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
new file mode 100644
index 000000000000..98db6cb4d03a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mdp3-hdr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Media Data Path 3 HDR
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Moudy Ho <moudy.ho@mediatek.com>
+
+description:
+  One of Media Data Path 3 (MDP3) components used to perform HDR to SDR
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-mdp3-hdr
+
+  reg:
+    maxItems: 1
+
+  mediatek,gce-client-reg:
+    description:
+      The register of display function block to be set by gce. There are 4 arguments,
+      such as gce node, subsys id, offset and register size. The subsys id that is
+      mapping to the register of display function blocks is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h of each chips.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - mediatek,gce-client-reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/gce/mt8195-gce.h>
+
+    display@14004000 {
+        compatible = "mediatek,mt8195-mdp3-hdr";
+        reg = <0x14004000 0x1000>;
+        mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
+        clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
+    };
-- 
2.18.0

