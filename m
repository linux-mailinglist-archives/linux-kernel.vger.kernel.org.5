Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAA7DB7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjJ3KSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJ3KRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:17:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC168A54;
        Mon, 30 Oct 2023 03:06:38 -0700 (PDT)
X-UUID: fe53de3e770b11eea33bb35ae8d461a2-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gk45Rr9UgXQOqdUUWGKimwYPf+FI+lUGpIcH8+qcR5U=;
        b=lUmijAjBlbCQW7fvHyCTpbb49OHRxfriAG/iqKtw4itQH2rjFv4r6WVcxcxdLB3Pun/T8WoTslSuzMcFFUl6JwJp89fLL/RxN5kpsBf6cS7Uvv0Fzqtj2EdHfAIIU9MeVVNXZKS7AQyMxQtA9CNy1f/I9scri5PLbFLZvA08Fmc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:16332212-bace-4c7e-b1f4-5927dc58eac9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:d419effb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe53de3e770b11eea33bb35ae8d461a2-20231030
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1816377921; Mon, 30 Oct 2023 18:06:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 18:06:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 18:06:27 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v8 01/12] media: platform: mtk-mdp3: add support second sets of MMSYS
Date:   Mon, 30 Oct 2023 18:06:15 +0800
Message-ID: <20231030100626.12564-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.001300-8.000000
X-TMASE-MatchedRID: 6BIui0KJkwz6GJFh4XuzNQPZZctd3P4BK2i9pofGVSsKogmGusPLbw6B
        lGN0WKrNVYAhfitWUenIwrufi9pnN8ZR5zLxbV5qFYJUGv4DL3yscK/K2Dlvjsnc0Uc0m8WZZEh
        60BrOMi3UDF8JvTwtuo3/d0NuPcI1QkfxbJAyTm5VTfJWlqPdDCEdaywSZvzO2q19+Ow35ycG1W
        3alEv3RuLzNWBegCW2wgn7iDBesS0gBwKKRHe+r+Ly0W7jvQvYTx/q+HLkG45vjrhSXyr1yxH2y
        nkxWbJv51ZywOHJlns=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.001300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E7F5DEE89C2859D4767C1406458D1756884182456D7B72A24CCB82C50D5BF59F2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 chipset features two MMSYS subsets: VPPSYS0 and VPPSYS1.
These subsets coordinate and control the clock, power, and
register settings required for the components of MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 44 ++++++-------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 61 ++++++++++++++++---
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    | 18 +++++-
 4 files changed, 92 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 502eeae0bfdc..fcc582292b77 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -73,75 +73,75 @@ static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 
 static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_WPEI] = {
-		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI},
+		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO] = {
-		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO},
+		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEI2] = {
-		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2},
+		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO2] = {
-		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2},
+		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_ISP_IMGI] = {
-		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI},
+		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI, MDP_MM_SUBSYS_0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMGO] = {
-		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO},
+		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO, MDP_MM_SUBSYS_0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMG2O] = {
-		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O},
+		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_CAMIN] = {
-		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN},
+		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN, MDP_MM_SUBSYS_0},
 		{2, 2, 1}
 	},
 	[MDP_COMP_CAMIN2] = {
-		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2},
+		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2, MDP_MM_SUBSYS_0},
 		{2, 4, 1}
 	},
 	[MDP_COMP_RDMA0] = {
-		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0},
+		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0, MDP_MM_SUBSYS_0},
 		{2, 0, 0}
 	},
 	[MDP_COMP_CCORR0] = {
-		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0},
+		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ0] = {
-		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0},
+		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ1] = {
-		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1},
+		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_TDSHP0] = {
-		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0},
+		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH0_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT},
+		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH1_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT},
+		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WROT0] = {
-		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0},
+		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_WDMA] = {
-		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA},
+		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 };
@@ -402,10 +402,10 @@ static const struct mdp_limit mt8183_mdp_def_limit = {
 };
 
 static const struct mdp_pipe_info mt8183_pipe_info[] = {
-	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, 0},
-	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, 1},
-	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, 2},
-	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, 3}
+	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, MDP_MM_SUBSYS_0, 0},
+	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, MDP_MM_SUBSYS_0, 1},
+	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, MDP_MM_SUBSYS_0, 2},
+	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, MDP_MM_SUBSYS_0, 3}
 };
 
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 20d2bcb77ef9..e89c51e1edb7 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -138,6 +138,7 @@ struct mdp_comp_match {
 	enum mdp_comp_type type;
 	u32 alias_id;
 	s32 inner_id;
+	s32 subsys_id;
 };
 
 /* Used to describe the item order in MDP property */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index cc44be10fdb7..fa59f8ab1b47 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -26,9 +26,10 @@ static const struct of_device_id mdp_of_ids[] = {
 MODULE_DEVICE_TABLE(of, mdp_of_ids);
 
 static struct platform_device *__get_pdev_by_id(struct platform_device *pdev,
+						struct platform_device *from,
 						enum mdp_infra_id id)
 {
-	struct device_node *node;
+	struct device_node *node, *f = NULL;
 	struct platform_device *mdp_pdev = NULL;
 	const struct mtk_mdp_driver_data *mdp_data;
 	const char *compat;
@@ -46,9 +47,14 @@ static struct platform_device *__get_pdev_by_id(struct platform_device *pdev,
 		dev_err(&pdev->dev, "have no driver data to find node\n");
 		return NULL;
 	}
+
 	compat = mdp_data->mdp_probe_infra[id].compatible;
+	if (strlen(compat) == 0)
+		return NULL;
 
-	node = of_find_compatible_node(NULL, NULL, compat);
+	if (from)
+		f = from->dev.of_node;
+	node = of_find_compatible_node(f, NULL, compat);
 	if (WARN_ON(!node)) {
 		dev_err(&pdev->dev, "find node from id %d failed\n", id);
 		return NULL;
@@ -148,6 +154,46 @@ void mdp_video_device_release(struct video_device *vdev)
 	kfree(mdp);
 }
 
+static int mdp_mm_subsys_deploy(struct mdp_dev *mdp, enum mdp_infra_id id)
+{
+	struct platform_device *mm_pdev = NULL;
+	struct device **dev;
+	int i;
+
+	if (!mdp)
+		return -EINVAL;
+
+	for (i = 0; i < MDP_MM_SUBSYS_MAX; i++) {
+		const char *compat;
+		enum mdp_infra_id sub_id = id + i;
+
+		switch (id) {
+		case MDP_INFRA_MMSYS:
+			dev = &mdp->mm_subsys[i].mmsys;
+			break;
+		default:
+			dev_err(&mdp->pdev->dev, "Unknown infra id %d", id);
+			return -EINVAL;
+		}
+
+		/*
+		 * Not every chip has multiple multimedia subsystems, so
+		 * the config may be null.
+		 */
+		compat = mdp->mdp_data->mdp_probe_infra[sub_id].compatible;
+		if (strlen(compat) == 0)
+			continue;
+
+		mm_pdev = __get_pdev_by_id(mdp->pdev, mm_pdev, sub_id);
+		if (WARN_ON(!mm_pdev))
+			return -ENODEV;
+
+		*dev = &mm_pdev->dev;
+	}
+
+	return 0;
+}
+
 static int mdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -164,14 +210,11 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp->pdev = pdev;
 	mdp->mdp_data = of_device_get_match_data(&pdev->dev);
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MMSYS);
-	if (!mm_pdev) {
-		ret = -ENODEV;
+	ret = mdp_mm_subsys_deploy(mdp, MDP_INFRA_MMSYS);
+	if (ret)
 		goto err_destroy_device;
-	}
-	mdp->mdp_mmsys = &mm_pdev->dev;
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MUTEX);
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_MUTEX);
 	if (WARN_ON(!mm_pdev)) {
 		ret = -ENODEV;
 		goto err_destroy_device;
@@ -208,7 +251,7 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_destroy_job_wq;
 	}
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_SCP);
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
 	if (WARN_ON(!mm_pdev)) {
 		dev_err(&pdev->dev, "Could not get scp device\n");
 		ret = -ENODEV;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 7e21d226ceb8..7a7cdd0ce968 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -19,12 +19,23 @@
 #define MDP_PHANDLE_NAME	"mediatek,mdp3"
 
 enum mdp_infra_id {
+	/*
+	 * Due to the sequential nature of function "mdp_mm_subsys_deploy",
+	 * adding new enum. necessitates careful consideration.
+	 */
 	MDP_INFRA_MMSYS,
+	MDP_INFRA_MMSYS2,
 	MDP_INFRA_MUTEX,
 	MDP_INFRA_SCP,
 	MDP_INFRA_MAX
 };
 
+enum mdp_mm_subsys_id {
+	MDP_MM_SUBSYS_0,
+	MDP_MM_SUBSYS_1,
+	MDP_MM_SUBSYS_MAX,
+};
+
 enum mdp_buffer_usage {
 	MDP_BUFFER_USAGE_HW_READ,
 	MDP_BUFFER_USAGE_MDP,
@@ -65,9 +76,13 @@ struct mtk_mdp_driver_data {
 	unsigned int pipe_info_len;
 };
 
+struct mdp_mm_subsys {
+	struct device *mmsys;
+};
+
 struct mdp_dev {
 	struct platform_device			*pdev;
-	struct device				*mdp_mmsys;
+	struct mdp_mm_subsys			mm_subsys[MDP_MM_SUBSYS_MAX];
 	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
@@ -96,6 +111,7 @@ struct mdp_dev {
 
 struct mdp_pipe_info {
 	enum mdp_pipe_id pipe_id;
+	enum mdp_mm_subsys_id sub_id;
 	u32 mutex_id;
 };
 
-- 
2.18.0

