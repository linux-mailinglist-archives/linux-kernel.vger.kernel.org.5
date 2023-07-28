Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71500766866
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjG1JMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjG1JLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:11:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB44EE8;
        Fri, 28 Jul 2023 02:09:29 -0700 (PDT)
X-UUID: 6108eb302d2611ee9cb5633481061a41-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4P+kdE5Y44rxZSSGFIHLm6nTvWUiqXPyDDzEu2FyU3s=;
        b=stfEs9yrEh//jDOwa6luXEjfRkurprv7uRMWf7EgAC37h4BqlG6f3HOhDmu7jXZgnlOZ1dNt7Z2E1g3gaJUtHEhjey7q9WQW97NhSsZsqoPZPlc3UuHHjU26AzbZpnU9eOny6o3GZDaC481xyfIEIBIDFhNGzk+UDVg1gNhoZB0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:695f1b12-d6a9-49d2-bf51-e77e243033a8,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:fb39a2a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6108eb302d2611ee9cb5633481061a41-20230728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1142433702; Fri, 28 Jul 2023 17:08:55 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 17:08:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 17:08:54 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add mt7986-wm8960 document
Date:   Fri, 28 Jul 2023 17:08:18 +0800
Message-ID: <20230728090819.18038-6-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230728090819.18038-1-maso.huang@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document for mt7986 board with wm8960.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 .../sound/mediatek,mt7986-wm8960.yaml         | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
new file mode 100644
index 000000000000..76394f7e5502
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7986 sound card with WM8960 codec
+
+maintainers:
+  - Maso Huang <maso.huang@mediatek.com>
+
+properties:
+  compatible:
+    const: mediatek,mt7986-wm8960-machine
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT7986 platform.
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      sink/source pair of strings. Valid names could be the input or output
+      widgets of audio components, power supplies, MicBias of codec and the
+      software switch.
+
+  mediatek,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of wm8960 codec.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,platform
+  - audio-routing
+  - mediatek,audio-codec
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt7986-wm8960-machine";
+        mediatek,platform = <&afe>;
+        audio-routing =
+            "Headphone", "HP_L",
+            "Headphone", "HP_R",
+            "LINPUT1", "AMIC",
+            "RINPUT1", "AMIC";
+        mediatek,audio-codec = <&wm8960>;
+    };
+
+...
-- 
2.18.0

