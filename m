Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF87926B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjIEQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbjIEDpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:45:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73BCCB;
        Mon,  4 Sep 2023 20:45:24 -0700 (PDT)
X-UUID: a13ee47a4b9e11eea33bb35ae8d461a2-20230905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W4dyYXyL7RU5UnXE05o13Pbj4LUrckjq2hXc574i32Y=;
        b=E1ennS2vxLmzW9ikhXdckQCR08ks/om54edlauMWXT/Mc5m+r2HE+dNG3gLv9rPAB0k1M7itMYWEzWMP6ihbJj8xW1MR7c9kjvZHX7kl9cxeBcunXNtKaB43WPXOvWw5ObatrC4wu+O86PNyn/FPbF2nw0FZuOn4Zq/CFjIg558=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c0479ef9-12ba-4747-827e-f16e3a23e5fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:6c7a1e20-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a13ee47a4b9e11eea33bb35ae8d461a2-20230905
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 227556735; Tue, 05 Sep 2023 11:45:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Sep 2023 11:45:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Sep 2023 11:45:16 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions
Date:   Tue, 5 Sep 2023 11:45:11 +0800
Message-ID: <20230905034511.11232-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230905034511.11232-1-macpaul.lin@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230905034511.11232-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dts file of the MediaTek MT8195 demo board has been updated to include
new reserved memory regions.
These reserved memory regions are:
 - SCP
 - VPU,
 - Sound DMA
 - APU.

These regions are defined with the "shared-dma-pool" compatible property.
In addition, the existing reserved memory regions have been reordered by
their addresses to improve readability and maintainability of the DTS
file.

Cc: stable@vger.kernel.org      # 6.1, 6.4, 6.5
Fixes: e4a417520101 ("arm64: dts: mediatek: mt8195-demo: fix the memory size of node secmon")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 37 ++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

Changes for v2:
 - No change.

Changes for v3:
 - Fix vpu_mem and apu_mem node according to the result of "make dtbs_check W=1"
 - Fix comment style to Linux for optee node.

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index ff363ab925e9..5d635085fe3f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -56,13 +56,8 @@
 		#size-cells = <2>;
 		ranges;
 
-		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
-		bl31_secmon_reserved: secmon@54600000 {
-			no-map;
-			reg = <0 0x54600000 0x0 0x200000>;
-		};
-
-		/* 12 MiB reserved for OP-TEE (BL32)
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
 		 * +-----------------------+ 0x43e0_0000
 		 * |      SHMEM 2MiB       |
 		 * +-----------------------+ 0x43c0_0000
@@ -75,6 +70,34 @@
 			no-map;
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
+		vpu_mem: memory@53000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x53000000 0 0x1400000>; /* 20 MB */
+		};
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_mem: memory@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		snd_dma_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0x1100000>;
+			no-map;
+		};
+
+		apu_mem: memory@62000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x62000000 0 0x1400000>; /* 20 MB */
+		};
 	};
 };
 
-- 
2.18.0

