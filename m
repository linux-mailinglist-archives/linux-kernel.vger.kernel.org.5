Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AC7803A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357178AbjHRCHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357164AbjHRCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:06:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9130E9;
        Thu, 17 Aug 2023 19:06:28 -0700 (PDT)
X-UUID: d240c3cc3d6b11ee9cb5633481061a41-20230818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=y9wESq3yLX5gwIyFrtLmnOhsV7s06v0xZ8e8yqmasio=;
        b=k/TeQ7U4fWg0Nb/079F/2v9r8CZNSvkKqvvG5LJwzY9036+E4dUMLaRrHwbEO7y4veztTWW/ksfs5jsZth762hErcIPn0+D0XX15y3TOoAVEZ7ciQ6JVqsJM+MKdsun044ThqxYK256XNi3QoW1lmtHKnuGGnd92JCBTsBZj/Y0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fe7f9e6b-35e5-4dbb-bd2c-551fdd9076bc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.31,REQID:fe7f9e6b-35e5-4dbb-bd2c-551fdd9076bc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:0ad78a4,CLOUDID:ce8be612-4929-4845-9571-38c601e9c3c9,B
        ulkID:23081810062252NX6IJA,BulkQuantity:1,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS
X-UUID: d240c3cc3d6b11ee9cb5633481061a41-20230818
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 731415993; Fri, 18 Aug 2023 10:06:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 18 Aug 2023 10:06:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 18 Aug 2023 10:06:18 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <sumitg@nvidia.com>,
        <sanjayc@nvidia.com>
CC:     <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Date:   Fri, 18 Aug 2023 10:06:16 +0800
Message-ID: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MT8186, it has policy0 and policy6 by different governor thread,so
it may be call cpufreq->set_target_index() by different core. In general
case, it must check BCPU, LCPU and CCI together then take about 10ms.

Atfer 44295af5019f this patch, it may call cpufreq_out_of_sync() by
cpufreq_verify_current_freq() because current frequency is bigger
than clk_get_rate() ouver 1Mh. By the same time, it may call
cpufreq->set_target_index() again. So, the CCI freq may be too lower for
BCPU cause BCPU kernel panic.

So, it should change the default transition delay 1ms to 10ms. It can
promise the next freq setting then governor trigger new freq change.

Fixes: 44295af5019f ("cpufreq: use correct unit when verify cur freq")
Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index a0a61919bc4c..5633a5357e8f 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -23,6 +23,7 @@ struct mtk_cpufreq_platform_data {
 	int sram_min_volt;
 	int sram_max_volt;
 	bool ccifreq_supported;
+	unsigned int transition_delay_us;
 };
 
 /*
@@ -595,6 +596,7 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table;
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
+	policy->transition_delay_us = info->soc_data->transition_delay_us;
 
 	return 0;
 }
@@ -689,6 +691,7 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
 	.sram_min_volt = 0,
 	.sram_max_volt = 1150000,
 	.ccifreq_supported = false,
+	.transition_delay_us = 1000,
 };
 
 static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
@@ -698,6 +701,7 @@ static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
 	.sram_min_volt = 0,
 	.sram_max_volt = 1350000,
 	.ccifreq_supported = false,
+	.transition_delay_us = 1000,
 };
 
 static const struct mtk_cpufreq_platform_data mt7623_platform_data = {
@@ -705,6 +709,7 @@ static const struct mtk_cpufreq_platform_data mt7623_platform_data = {
 	.max_volt_shift = 200000,
 	.proc_max_volt = 1300000,
 	.ccifreq_supported = false,
+	.transition_delay_us = 1000,
 };
 
 static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
@@ -714,6 +719,7 @@ static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
 	.sram_min_volt = 0,
 	.sram_max_volt = 1150000,
 	.ccifreq_supported = true,
+	.transition_delay_us = 1000,
 };
 
 static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
@@ -723,6 +729,7 @@ static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
 	.sram_min_volt = 850000,
 	.sram_max_volt = 1118750,
 	.ccifreq_supported = true,
+	.transition_delay_us = 10000,
 };
 
 static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
@@ -732,6 +739,7 @@ static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
 	.sram_min_volt = 0,
 	.sram_max_volt = 1310000,
 	.ccifreq_supported = false,
+	.transition_delay_us = 1000,
 };
 
 /* List of machines supported by this driver */
-- 
2.18.0

