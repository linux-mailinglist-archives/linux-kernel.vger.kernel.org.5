Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B079A1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjIKDRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjIKDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:16:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA38114
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:16:49 -0700 (PDT)
X-UUID: a0172ec4505111ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=e3ahd3M0XcppL08N+KpDhIH1BYr1qRQbibyyNReplTw=;
        b=o6iNGRasa5+u72hwf7ktnynf3mh/pkKFLFNOSUakcw6dAk89zRDitxoXCF8ksWT38VGBf3kHRzPAxBA1+ncWLIN8IXj8xljZBHEE4YTrJtlnxrGjVGGq0ENFl0+5XzUbbPWskJRsC9oApoA8YCZqvEMYWKyNqMzbjH/6M5hQHTk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:ef7fae58-caa2-41b3-8648-64cfd3049ba0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:4aa7dec2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a0172ec4505111ee8051498923ad61e6-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2007224458; Mon, 11 Sep 2023 11:16:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 11:16:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 11:16:39 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v6 06/20] dt-bindings: reset: mt8188: Add VDOSYS reset control bits
Date:   Mon, 11 Sep 2023 11:16:16 +0800
Message-ID: <20230911031630.12613-7-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911031630.12613-1-shawn.sung@mediatek.com>
References: <20230911031630.12613-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.230700-8.000000
X-TMASE-MatchedRID: tiRXYRqWr+upk9YSiEd5ImNW0DAjL5p+Wot5Z16+u74IgSDinsA6bCzy
        bVqWyY2NTAa7ihKVJtWAMuqetGVetocnrwAbVlNi3QfwsVk0UbsIoUKaF27lxW/EmO7579ImPdv
        WDxcnsv62jQK4x7A0yTmv3WIKQz/Ji4gt2mJW428iCqrEag5df9amHb2LHHT+uE6Jn2QVH0KYe5
        xoFcRssRdGg+ZY7eN6THB2Q+oKru8MTI34nyF36MJL1aANdU8Knqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.230700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: EE1B98C348D69B96984F80B884E25F39A483F0824BC4A02DF26A5BD0599ADFEA2000:8
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

Add MT8188 VDOSYS0 and VDOSYS1 reset control bits.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 include/dt-bindings/reset/mt8188-resets.h | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
index ba9a5e9b8899..5a58c54e7d20 100644
--- a/include/dt-bindings/reset/mt8188-resets.h
+++ b/include/dt-bindings/reset/mt8188-resets.h
@@ -38,4 +38,79 @@
 #define MT8188_INFRA_RST1_THERMAL_CTRL_RST         1
 #define MT8188_INFRA_RST3_PTP_CTRL_RST             2
 
+#define MT8188_VDO0_RST_DISP_OVL0		0
+#define MT8188_VDO0_RST_FAKE_ENG0		1
+#define MT8188_VDO0_RST_DISP_CCORR0		2
+#define MT8188_VDO0_RST_DISP_MUTEX0		3
+#define MT8188_VDO0_RST_DISP_GAMMA0		4
+#define MT8188_VDO0_RST_DISP_DITHER0		5
+#define MT8188_VDO0_RST_DISP_WDMA0		6
+#define MT8188_VDO0_RST_DISP_RDMA0		7
+#define MT8188_VDO0_RST_DSI0			8
+#define MT8188_VDO0_RST_DSI1			9
+#define MT8188_VDO0_RST_DSC_WRAP0		10
+#define MT8188_VDO0_RST_VPP_MERGE0		11
+#define MT8188_VDO0_RST_DP_INTF0		12
+#define MT8188_VDO0_RST_DISP_AAL0		13
+#define MT8188_VDO0_RST_INLINEROT0		14
+#define MT8188_VDO0_RST_APB_BUS			15
+#define MT8188_VDO0_RST_DISP_COLOR0		16
+#define MT8188_VDO0_RST_MDP_WROT0		17
+#define MT8188_VDO0_RST_DISP_RSZ0		18
+
+#define MT8188_VDO1_RST_SMI_LARB2		0
+#define MT8188_VDO1_RST_SMI_LARB3		1
+#define MT8188_VDO1_RST_GALS			2
+#define MT8188_VDO1_RST_FAKE_ENG0		3
+#define MT8188_VDO1_RST_FAKE_ENG1		4
+#define MT8188_VDO1_RST_MDP_RDMA0		5
+#define MT8188_VDO1_RST_MDP_RDMA1		6
+#define MT8188_VDO1_RST_MDP_RDMA2		7
+#define MT8188_VDO1_RST_MDP_RDMA3		8
+#define MT8188_VDO1_RST_VPP_MERGE0		9
+#define MT8188_VDO1_RST_VPP_MERGE1		10
+#define MT8188_VDO1_RST_VPP_MERGE2		11
+#define MT8188_VDO1_RST_VPP_MERGE3		12
+#define MT8188_VDO1_RST_VPP_MERGE4		13
+#define MT8188_VDO1_RST_VPP2_TO_VDO1_DL_ASYNC	14
+#define MT8188_VDO1_RST_VPP3_TO_VDO1_DL_ASYNC	15
+#define MT8188_VDO1_RST_DISP_MUTEX		16
+#define MT8188_VDO1_RST_MDP_RDMA4		17
+#define MT8188_VDO1_RST_MDP_RDMA5		18
+#define MT8188_VDO1_RST_MDP_RDMA6		19
+#define MT8188_VDO1_RST_MDP_RDMA7		20
+#define MT8188_VDO1_RST_DP_INTF1_MMCK		21
+#define MT8188_VDO1_RST_DPI0_MM_CK		22
+#define MT8188_VDO1_RST_DPI1_MM_CK		23
+#define MT8188_VDO1_RST_MERGE0_DL_ASYNC		24
+#define MT8188_VDO1_RST_MERGE1_DL_ASYNC		25
+#define MT8188_VDO1_RST_MERGE2_DL_ASYNC		26
+#define MT8188_VDO1_RST_MERGE3_DL_ASYNC		27
+#define MT8188_VDO1_RST_MERGE4_DL_ASYNC		28
+#define MT8188_VDO1_RST_VDO0_DSC_TO_VDO1_DL_ASYNC	29
+#define MT8188_VDO1_RST_VDO0_MERGE_TO_VDO1_DL_ASYNC	30
+#define MT8188_VDO1_RST_PADDING0		31
+#define MT8188_VDO1_RST_PADDING1		32
+#define MT8188_VDO1_RST_PADDING2		33
+#define MT8188_VDO1_RST_PADDING3		34
+#define MT8188_VDO1_RST_PADDING4		35
+#define MT8188_VDO1_RST_PADDING5		36
+#define MT8188_VDO1_RST_PADDING6		37
+#define MT8188_VDO1_RST_PADDING7		38
+#define MT8188_VDO1_RST_DISP_RSZ0		39
+#define MT8188_VDO1_RST_DISP_RSZ1		40
+#define MT8188_VDO1_RST_DISP_RSZ2		41
+#define MT8188_VDO1_RST_DISP_RSZ3		42
+#define MT8188_VDO1_RST_HDR_VDO_FE0		43
+#define MT8188_VDO1_RST_HDR_GFX_FE0		44
+#define MT8188_VDO1_RST_HDR_VDO_BE		45
+#define MT8188_VDO1_RST_HDR_VDO_FE1		46
+#define MT8188_VDO1_RST_HDR_GFX_FE1		47
+#define MT8188_VDO1_RST_DISP_MIXER		48
+#define MT8188_VDO1_RST_HDR_VDO_FE0_DL_ASYNC	49
+#define MT8188_VDO1_RST_HDR_VDO_FE1_DL_ASYNC	50
+#define MT8188_VDO1_RST_HDR_GFX_FE0_DL_ASYNC	51
+#define MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC	52
+#define MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC	53
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */
-- 
2.18.0

