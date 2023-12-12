Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD42380E24F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjLLCql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjLLCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:46:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB05BA;
        Mon, 11 Dec 2023 18:46:41 -0800 (PST)
X-UUID: aa51f970989811eea5db2bebc7c28f94-20231212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HYHZew6lf/mOP5U23ofsnX7zKCjL+zhlga53OrTPXp0=;
        b=bCsofGBPHdWhd4pb91y8U9CLi9zWC80773HK7n1jye/bfyTZjLtl/pl5oC+jjD7T2Lq21b4CDHJZJuuv4w0kmUCk8FafAGQeIKdwlffubpR4KpZoNKTiAAsfYIdl3X3mRGZmzp+13CPClmUh+OC9EfWslitTllzUeULPLR0ipF0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:15359fc6-cf38-4a33-95ca-b761993bbad5,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:1dd98efd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: aa51f970989811eea5db2bebc7c28f94-20231212
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 413819834; Tue, 12 Dec 2023 10:46:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Dec 2023 10:46:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Dec 2023 10:46:33 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, <tjmercier@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jianjiao.zeng@mediatek.com>,
        <kuohong.wang@mediatek.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: reserved-memory: Add mediatek,dynamic-secure-region
Date:   Tue, 12 Dec 2023 10:46:01 +0800
Message-ID: <20231212024607.3681-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212024607.3681-1-yong.wu@mediatek.com>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add a binding for describing the dynamic secure reserved memory range. The
memory range also will be defined in the TEE firmware. It means the TEE
will be configured with the same address/size that is being set in this
DT node. Regarding to the detail TEE command, Please search
MTK_TZCMD_SECMEM_ZALLOC and MTK_TZCMD_SECMEM_FREE.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../mediatek,dynamic-secure-region.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,dynamic-secure-region.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,dynamic-secure-region.yaml b/Documentation/devicetree/bindings/reserved-memory/mediatek,dynamic-secure-region.yaml
new file mode 100644
index 000000000000..4a735aeafc62
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,dynamic-secure-region.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/mediatek,dynamic-secure-region.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Dynamic Reserved Region
+
+description:
+  A memory region that can dynamically transition as a whole between
+  secure and non-secure states. This memory will be protected by OP-TEE
+  when allocations are active and unprotected otherwise.
+
+maintainers:
+  - Yong Wu <yong.wu@mediatek.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: mediatek,dynamic-secure-region
+
+required:
+  - compatible
+  - reg
+  - reusable
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        reserved-memory@80000000 {
+            compatible = "mediatek,dynamic-secure-region";
+            reg = <0x80000000 0x18000000>;
+            reusable;
+        };
+    };
-- 
2.25.1

