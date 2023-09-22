Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1407AAA25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjIVHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjIVHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:21:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFEF1A7;
        Fri, 22 Sep 2023 00:21:27 -0700 (PDT)
X-UUID: 9f6beb7a591811eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mgqu+3SeI9OFO9OZPPwA7hmQJEpL8yMn7OK2IZ2ZnWI=;
        b=TvNEHDypiPmqwXHu73192a8AyM0DtueqtQ9Z2lSWsVk2AOwd9yT+hyZQPo/i+lawq5xfYIB8UybvKBHe+LPWhPTBe0z6DJpzaoXh/2DMa5KTm/Se7M7bnKpJDlGP1n3fJXSKD6xlRMaatKzKEK78+C36c8fj7gexdNvh+F47eOw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9f395d69-a2fd-4b9c-8b28-87412e553552,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:d88a00f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9f6beb7a591811eea33bb35ae8d461a2-20230922
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 294614742; Fri, 22 Sep 2023 15:21:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 15:21:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 15:21:17 +0800
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
Subject: [PATCH v6 03/16] dt-bindings: media: mediatek: mdp3: include common properties
Date:   Fri, 22 Sep 2023 15:21:03 +0800
Message-ID: <20230922072116.11009-4-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230922072116.11009-1-moudy.ho@mediatek.com>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To minimize duplication and standardize the document style,
include the common properties for MT8183 RDMA.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 43 ++-----------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
index 3e128733ef53..0539badc9821 100644
--- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek Read Direct Memory Access
+title: MediaTek MT8183 Read Direct Memory Access
 
 maintainers:
   - Matthias Brugger <matthias.bgg@gmail.com>
@@ -18,62 +18,27 @@ description: |
   Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
   for details.
 
+allOf:
+  - $ref: mediatek,mdp3-rdma-common.yaml#
+
 properties:
   compatible:
     items:
       - const: mediatek,mt8183-mdp3-rdma
 
-  reg:
-    maxItems: 1
-
-  mediatek,gce-client-reg:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      items:
-        - description: phandle of GCE
-        - description: GCE subsys id
-        - description: register offset
-        - description: register size
-    description: The register of client driver can be configured by gce with
-      4 arguments defined in this property. Each GCE subsys id is mapping to
-      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
-
-  mediatek,gce-events:
-    description:
-      The event id which is mapping to the specific hardware event signal
-      to gce. The event id is defined in the gce header
-      include/dt-bindings/gce/<chip>-gce.h of each chips.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
-  power-domains:
-    maxItems: 1
-
   clocks:
     items:
       - description: RDMA clock
       - description: RSZ clock
 
-  iommus:
-    maxItems: 1
-
   mboxes:
     items:
       - description: used for 1st data pipe from RDMA
       - description: used for 2nd data pipe from RDMA
 
-  '#dma-cells':
-    const: 1
-
 required:
   - compatible
-  - reg
-  - mediatek,gce-client-reg
-  - mediatek,gce-events
-  - power-domains
-  - clocks
-  - iommus
   - mboxes
-  - '#dma-cells'
 
 additionalProperties: false
 
-- 
2.18.0

