Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C57E00D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbjKCJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347474AbjKCJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:54:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5838D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:54:52 -0700 (PDT)
X-UUID: 031945507a2f11ee8051498923ad61e6-20231103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SSxEHER9rgZJO6xVEezgZza82f7zlYSaeP4HD1Wipa4=;
        b=XhoycgLrsLIkL/p2GmDL7fcAKoFNp6bjCG/pe1I4D5iyUPDodFEcg6c6UW45Nk2jLjp18n2wZHxvtiwB3dypAvodZuVyMkohCj1DmydrzMW/IMn+911n1gUcj8+JhCNEZxZB8rMlsk680tAnFUhp7UGECUpLlWR/SvbL1hcJHt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1725c5ad-4693-4078-9213-0098455aa642,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:9b5ea55f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 031945507a2f11ee8051498923ad61e6-20231103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1655944468; Fri, 03 Nov 2023 17:54:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Nov 2023 17:54:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Nov 2023 17:54:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <yc.hung@mediatek.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: SOF: mediatek: remove unused variables
Date:   Fri, 3 Nov 2023 17:54:32 +0800
Message-ID: <20231103095433.10475-4-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231103095433.10475-1-trevor.wu@mediatek.com>
References: <20231103095433.10475-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.994200-8.000000
X-TMASE-MatchedRID: tbBnGR+nfu7HO8eAxCOj9uEbUg4xvs+wYKeVO7aMEHPfUZT83lbkEGOr
        KvsUT0pAXTvgb5xI7gVpnryVaiXugB8TzIzimOwPC24oEZ6SpSmcfuxsiY4QFDraVU6lwonzkc5
        WVJ1GXnkS2VhzX+fgmBqqw4SleYJWMr1nDozz1oXRaxPVfNDWN0QrY6+5fQPAwAu7lS0AxFfi54
        NN52oAEEma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6x5U/HriPpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.994200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 073E768117C1B0B82F8444E44C9CD65E3774C4004192C4ABD2DE76B85F9A1C532000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent confusion on the follow-up platform, it is necessary to
remove any unused variables within the struct mtk_adsp_chip_info.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
---
 sound/soc/sof/mediatek/adsp_helper.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sof/mediatek/adsp_helper.h b/sound/soc/sof/mediatek/adsp_helper.h
index d41e904e6614..35527567962e 100644
--- a/sound/soc/sof/mediatek/adsp_helper.h
+++ b/sound/soc/sof/mediatek/adsp_helper.h
@@ -15,17 +15,13 @@
 struct mtk_adsp_chip_info {
 	phys_addr_t pa_sram;
 	phys_addr_t pa_dram; /* adsp dram physical base */
-	phys_addr_t pa_shared_dram; /* adsp dram physical base */
 	phys_addr_t pa_cfgreg;
 	u32 sramsize;
 	u32 dramsize;
 	u32 cfgregsize;
-	u32 shared_size;
 	void __iomem *va_sram; /* corresponding to pa_sram */
 	void __iomem *va_dram; /* corresponding to pa_dram */
 	void __iomem *va_cfgreg;
-	void __iomem *shared_sram; /* part of  va_sram */
-	void __iomem *shared_dram; /* part of  va_dram */
 	phys_addr_t adsp_bootup_addr;
 	int dram_offset; /*dram offset between system and dsp view*/
 
-- 
2.18.0

