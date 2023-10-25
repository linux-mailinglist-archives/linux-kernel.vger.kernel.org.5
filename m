Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31027D65F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjJYI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjJYI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:57:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD29B0;
        Wed, 25 Oct 2023 01:57:29 -0700 (PDT)
X-UUID: 83bd5ff6731411ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xb6J1Ir1c2KPXFeV1wmOSMhx5pvLnemEhGAfDHDeRdU=;
        b=GCMuvtB/+5cXn7g7pj5uIrLdpFqg/pkVs/h4IQuqfloAocFmWC6D/fCCNzboMEh4AE/q//TIAQZzbnGLqM+3FRpuuNvIQe+oDOw9YZuyFY2XuPmEtbMGnHgCXlrgnvaUHtcbu66/6DWNsbYlppRh69YRnwJQ4Ux4U2GLvkhKhWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9041b6de-e942-4de2-a613-c02181c117eb,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:57e1c0fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 83bd5ff6731411ee8051498923ad61e6-20231025
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1596833188; Wed, 25 Oct 2023 16:57:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 16:57:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 16:57:18 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
CC:     <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>,
        <peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <qilin.tan@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kernel-team@android.com>
Subject: [PATCH v1 1/1] ufs: core: Add host quirk QUIRK_MCQ_EXPAND_QUEUE_SLOT
Date:   Wed, 25 Oct 2023 16:56:54 +0800
Message-ID: <20231025085656.10848-2-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.746200-8.000000
X-TMASE-MatchedRID: qrLumZlmEv35vVrLXEcGcaOONuzwygtGK2i9pofGVStcU0dNErOD+iG+
        TaaivvuaVp8FEOw3oY/7jEpf1WfcwRMYdvBjd19wh2VzUlo4HVMK/ePvB1fEGJsoi2XrUn/J8m+
        hzBStansfRoCwBzgRYidET58jp62STbYwO+VGPGXSxt8yJqi5GIbcgu+rBwskDhTgbbUYqPA18S
        hyshWILoEhlo9tyDBHBixHQXpAWNhLrNYA/hws/qv13aNekZZCgITnGkK0NFNRskXKHhdfKpij9
        M86UwHhsKHfMTjCprwNQJGvyiKf6Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.746200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2923996887D26B6DC4A02F4BAA7ED582366F0C636F7B277759BD57095C80F5E62000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Chao <alice.chao@mediatek.com>

This quirk needs to be enabled if the host controller cannot
distinguish queue full or empty.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c |  5 ++++-
 include/ufs/ufshcd.h       | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2ba8ec254dce..9b8ed3f9a349 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -436,7 +436,10 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 
 	for (i = 0; i < hba->nr_hw_queues; i++) {
 		hwq = &hba->uhq[i];
-		hwq->max_entries = hba->nutrs;
+		if (ufshcd_is_mcq_expand_queue_slot(hba))
+			hwq->max_entries = hba->nutrs + 1;
+		else
+			hwq->max_entries = hba->nutrs;
 		spin_lock_init(&hwq->sq_lock);
 		spin_lock_init(&hwq->cq_lock);
 		mutex_init(&hwq->sq_mutex);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7d07b256e906..44de185501b5 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -643,6 +643,12 @@ enum ufshcd_quirks {
 	 * thus need this quirk to skip related flow.
 	 */
 	UFSHCD_QUIRK_MCQ_BROKEN_RTC			= 1 << 21,
+
+	/*
+	 * This quirk needs to be enabled if the host controller cannot
+	 * distinguish queue full or empty.
+	 */
+	UFSHCD_QUIRK_MCQ_EXPAND_QUEUE_SLOT              = 1 << 22,
 };
 
 enum ufshcd_caps {
@@ -1198,6 +1204,11 @@ static inline bool ufshcd_enable_wb_if_scaling_up(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_WITH_CLK_SCALING;
 }
 
+static inline bool ufshcd_is_mcq_expand_queue_slot(struct ufs_hba *hba)
+{
+	return hba->quirks & UFSHCD_QUIRK_MCQ_EXPAND_QUEUE_SLOT;
+}
+
 #define ufsmcq_writel(hba, val, reg)	\
 	writel((val), (hba)->mcq_base + (reg))
 #define ufsmcq_readl(hba, reg)	\
-- 
2.18.0

