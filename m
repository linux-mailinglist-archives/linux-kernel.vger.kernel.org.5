Return-Path: <linux-kernel+bounces-120770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C188DCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2CB1F2A0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8212B16C;
	Wed, 27 Mar 2024 11:48:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187412AAC1;
	Wed, 27 Mar 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540137; cv=none; b=skW+21PWoe0/h1md1m5DLno6YZgpwEJMKNxBDV5krai48M4jMMwDbf24mKVQ++yeTSMe4bIo7pJX8Y825wFB8daGvNJh2kA8aaEjAftltR7nQGvzbCk1EpE4vD1wbTQya+eX11/MlGRD27TKXLOvmoyBy7PXyLYUk6zlNk6buEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540137; c=relaxed/simple;
	bh=qIg/SavVQ9snJHICZKTgi/Tpsb6/gA/Z6LSZVsCSnbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik6ovM+asHU7jmxQnDhPG6+ukmh9mBOGS1xEv2KXxjcDXxbshVJMEfT+qxcfKqFPQ6frZ2vLFGzv8pS5EtRXuVdEUouVRWBUueTInT2uILSY8PcYxZGSlcuCQVEJYI1T8q5YhhX//d8XA0uJrRuaSOiVmD4GqyncLs9WcIk+in8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V4PyC0qk5z29lHQ;
	Wed, 27 Mar 2024 19:46:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A71F31402CA;
	Wed, 27 Mar 2024 19:48:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 19:48:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V6 net-next 2/4] net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c
Date: Wed, 27 Mar 2024 19:43:28 +0800
Message-ID: <20240327114330.1826631-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240327114330.1826631-1-shaojijie@huawei.com>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

some constants are defined in hclge_debugfs.h,
but only used in hclge_debugfs.c.
so move them from hclge_debugfs.h to hclge_debugfs.c.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 640 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     | 640 ------------------
 2 files changed, 640 insertions(+), 640 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 9ec471ced3d6..243be19a7557 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -18,6 +18,646 @@ static const char * const hclge_mac_state_str[] = {
 
 static const char * const tc_map_mode_str[] = { "PRIO", "DSCP" };
 
+static const struct hclge_dbg_dfx_message hclge_dbg_bios_common_reg[] = {
+	{false, "Reserved"},
+	{true,	"BP_CPU_STATE"},
+	{true,	"DFX_MSIX_INFO_NIC_0"},
+	{true,	"DFX_MSIX_INFO_NIC_1"},
+	{true,	"DFX_MSIX_INFO_NIC_2"},
+	{true,	"DFX_MSIX_INFO_NIC_3"},
+
+	{true,	"DFX_MSIX_INFO_ROC_0"},
+	{true,	"DFX_MSIX_INFO_ROC_1"},
+	{true,	"DFX_MSIX_INFO_ROC_2"},
+	{true,	"DFX_MSIX_INFO_ROC_3"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_0[] = {
+	{false, "Reserved"},
+	{true,	"SSU_ETS_PORT_STATUS"},
+	{true,	"SSU_ETS_TCG_STATUS"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{true,	"SSU_BP_STATUS_0"},
+
+	{true,	"SSU_BP_STATUS_1"},
+	{true,	"SSU_BP_STATUS_2"},
+	{true,	"SSU_BP_STATUS_3"},
+	{true,	"SSU_BP_STATUS_4"},
+	{true,	"SSU_BP_STATUS_5"},
+	{true,	"SSU_MAC_TX_PFC_IND"},
+
+	{true,	"MAC_SSU_RX_PFC_IND"},
+	{true,	"BTMP_AGEING_ST_B0"},
+	{true,	"BTMP_AGEING_ST_B1"},
+	{true,	"BTMP_AGEING_ST_B2"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+
+	{true,	"FULL_DROP_NUM"},
+	{true,	"PART_DROP_NUM"},
+	{true,	"PPP_KEY_DROP_NUM"},
+	{true,	"PPP_RLT_DROP_NUM"},
+	{true,	"LO_PRI_UNICAST_RLT_DROP_NUM"},
+	{true,	"HI_PRI_MULTICAST_RLT_DROP_NUM"},
+
+	{true,	"LO_PRI_MULTICAST_RLT_DROP_NUM"},
+	{true,	"NCSI_PACKET_CURR_BUFFER_CNT"},
+	{true,	"BTMP_AGEING_RLS_CNT_BANK0"},
+	{true,	"BTMP_AGEING_RLS_CNT_BANK1"},
+	{true,	"BTMP_AGEING_RLS_CNT_BANK2"},
+	{true,	"SSU_MB_RD_RLT_DROP_CNT"},
+
+	{true,	"SSU_PPP_MAC_KEY_NUM_L"},
+	{true,	"SSU_PPP_MAC_KEY_NUM_H"},
+	{true,	"SSU_PPP_HOST_KEY_NUM_L"},
+	{true,	"SSU_PPP_HOST_KEY_NUM_H"},
+	{true,	"PPP_SSU_MAC_RLT_NUM_L"},
+	{true,	"PPP_SSU_MAC_RLT_NUM_H"},
+
+	{true,	"PPP_SSU_HOST_RLT_NUM_L"},
+	{true,	"PPP_SSU_HOST_RLT_NUM_H"},
+	{true,	"NCSI_RX_PACKET_IN_CNT_L"},
+	{true,	"NCSI_RX_PACKET_IN_CNT_H"},
+	{true,	"NCSI_TX_PACKET_OUT_CNT_L"},
+	{true,	"NCSI_TX_PACKET_OUT_CNT_H"},
+
+	{true,	"SSU_KEY_DROP_NUM"},
+	{true,	"MB_UNCOPY_NUM"},
+	{true,	"RX_OQ_DROP_PKT_CNT"},
+	{true,	"TX_OQ_DROP_PKT_CNT"},
+	{true,	"BANK_UNBALANCE_DROP_CNT"},
+	{true,	"BANK_UNBALANCE_RX_DROP_CNT"},
+
+	{true,	"NIC_L2_ERR_DROP_PKT_CNT"},
+	{true,	"ROC_L2_ERR_DROP_PKT_CNT"},
+	{true,	"NIC_L2_ERR_DROP_PKT_CNT_RX"},
+	{true,	"ROC_L2_ERR_DROP_PKT_CNT_RX"},
+	{true,	"RX_OQ_GLB_DROP_PKT_CNT"},
+	{false, "Reserved"},
+
+	{true,	"LO_PRI_UNICAST_CUR_CNT"},
+	{true,	"HI_PRI_MULTICAST_CUR_CNT"},
+	{true,	"LO_PRI_MULTICAST_CUR_CNT"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_1[] = {
+	{true,	"prt_id"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_0"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_1"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_2"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_3"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_4"},
+
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_5"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_6"},
+	{true,	"PACKET_TC_CURR_BUFFER_CNT_7"},
+	{true,	"PACKET_CURR_BUFFER_CNT"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+
+	{true,	"RX_PACKET_IN_CNT_L"},
+	{true,	"RX_PACKET_IN_CNT_H"},
+	{true,	"RX_PACKET_OUT_CNT_L"},
+	{true,	"RX_PACKET_OUT_CNT_H"},
+	{true,	"TX_PACKET_IN_CNT_L"},
+	{true,	"TX_PACKET_IN_CNT_H"},
+
+	{true,	"TX_PACKET_OUT_CNT_L"},
+	{true,	"TX_PACKET_OUT_CNT_H"},
+	{true,	"ROC_RX_PACKET_IN_CNT_L"},
+	{true,	"ROC_RX_PACKET_IN_CNT_H"},
+	{true,	"ROC_TX_PACKET_OUT_CNT_L"},
+	{true,	"ROC_TX_PACKET_OUT_CNT_H"},
+
+	{true,	"RX_PACKET_TC_IN_CNT_0_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_0_H"},
+	{true,	"RX_PACKET_TC_IN_CNT_1_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_1_H"},
+	{true,	"RX_PACKET_TC_IN_CNT_2_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_2_H"},
+
+	{true,	"RX_PACKET_TC_IN_CNT_3_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_3_H"},
+	{true,	"RX_PACKET_TC_IN_CNT_4_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_4_H"},
+	{true,	"RX_PACKET_TC_IN_CNT_5_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_5_H"},
+
+	{true,	"RX_PACKET_TC_IN_CNT_6_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_6_H"},
+	{true,	"RX_PACKET_TC_IN_CNT_7_L"},
+	{true,	"RX_PACKET_TC_IN_CNT_7_H"},
+	{true,	"RX_PACKET_TC_OUT_CNT_0_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_0_H"},
+
+	{true,	"RX_PACKET_TC_OUT_CNT_1_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_1_H"},
+	{true,	"RX_PACKET_TC_OUT_CNT_2_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_2_H"},
+	{true,	"RX_PACKET_TC_OUT_CNT_3_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_3_H"},
+
+	{true,	"RX_PACKET_TC_OUT_CNT_4_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_4_H"},
+	{true,	"RX_PACKET_TC_OUT_CNT_5_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_5_H"},
+	{true,	"RX_PACKET_TC_OUT_CNT_6_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_6_H"},
+
+	{true,	"RX_PACKET_TC_OUT_CNT_7_L"},
+	{true,	"RX_PACKET_TC_OUT_CNT_7_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_0_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_0_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_1_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_1_H"},
+
+	{true,	"TX_PACKET_TC_IN_CNT_2_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_2_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_3_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_3_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_4_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_4_H"},
+
+	{true,	"TX_PACKET_TC_IN_CNT_5_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_5_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_6_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_6_H"},
+	{true,	"TX_PACKET_TC_IN_CNT_7_L"},
+	{true,	"TX_PACKET_TC_IN_CNT_7_H"},
+
+	{true,	"TX_PACKET_TC_OUT_CNT_0_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_0_H"},
+	{true,	"TX_PACKET_TC_OUT_CNT_1_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_1_H"},
+	{true,	"TX_PACKET_TC_OUT_CNT_2_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_2_H"},
+
+	{true,	"TX_PACKET_TC_OUT_CNT_3_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_3_H"},
+	{true,	"TX_PACKET_TC_OUT_CNT_4_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_4_H"},
+	{true,	"TX_PACKET_TC_OUT_CNT_5_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_5_H"},
+
+	{true,	"TX_PACKET_TC_OUT_CNT_6_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_6_H"},
+	{true,	"TX_PACKET_TC_OUT_CNT_7_L"},
+	{true,	"TX_PACKET_TC_OUT_CNT_7_H"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_2[] = {
+	{true,	"OQ_INDEX"},
+	{true,	"QUEUE_CNT"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_igu_egu_reg[] = {
+	{true,	"prt_id"},
+	{true,	"IGU_RX_ERR_PKT"},
+	{true,	"IGU_RX_NO_SOF_PKT"},
+	{true,	"EGU_TX_1588_SHORT_PKT"},
+	{true,	"EGU_TX_1588_PKT"},
+	{true,	"EGU_TX_ERR_PKT"},
+
+	{true,	"IGU_RX_OUT_L2_PKT"},
+	{true,	"IGU_RX_OUT_L3_PKT"},
+	{true,	"IGU_RX_OUT_L4_PKT"},
+	{true,	"IGU_RX_IN_L2_PKT"},
+	{true,	"IGU_RX_IN_L3_PKT"},
+	{true,	"IGU_RX_IN_L4_PKT"},
+
+	{true,	"IGU_RX_EL3E_PKT"},
+	{true,	"IGU_RX_EL4E_PKT"},
+	{true,	"IGU_RX_L3E_PKT"},
+	{true,	"IGU_RX_L4E_PKT"},
+	{true,	"IGU_RX_ROCEE_PKT"},
+	{true,	"IGU_RX_OUT_UDP0_PKT"},
+
+	{true,	"IGU_RX_IN_UDP0_PKT"},
+	{true,	"IGU_MC_CAR_DROP_PKT_L"},
+	{true,	"IGU_MC_CAR_DROP_PKT_H"},
+	{true,	"IGU_BC_CAR_DROP_PKT_L"},
+	{true,	"IGU_BC_CAR_DROP_PKT_H"},
+	{false, "Reserved"},
+
+	{true,	"IGU_RX_OVERSIZE_PKT_L"},
+	{true,	"IGU_RX_OVERSIZE_PKT_H"},
+	{true,	"IGU_RX_UNDERSIZE_PKT_L"},
+	{true,	"IGU_RX_UNDERSIZE_PKT_H"},
+	{true,	"IGU_RX_OUT_ALL_PKT_L"},
+	{true,	"IGU_RX_OUT_ALL_PKT_H"},
+
+	{true,	"IGU_TX_OUT_ALL_PKT_L"},
+	{true,	"IGU_TX_OUT_ALL_PKT_H"},
+	{true,	"IGU_RX_UNI_PKT_L"},
+	{true,	"IGU_RX_UNI_PKT_H"},
+	{true,	"IGU_RX_MULTI_PKT_L"},
+	{true,	"IGU_RX_MULTI_PKT_H"},
+
+	{true,	"IGU_RX_BROAD_PKT_L"},
+	{true,	"IGU_RX_BROAD_PKT_H"},
+	{true,	"EGU_TX_OUT_ALL_PKT_L"},
+	{true,	"EGU_TX_OUT_ALL_PKT_H"},
+	{true,	"EGU_TX_UNI_PKT_L"},
+	{true,	"EGU_TX_UNI_PKT_H"},
+
+	{true,	"EGU_TX_MULTI_PKT_L"},
+	{true,	"EGU_TX_MULTI_PKT_H"},
+	{true,	"EGU_TX_BROAD_PKT_L"},
+	{true,	"EGU_TX_BROAD_PKT_H"},
+	{true,	"IGU_TX_KEY_NUM_L"},
+	{true,	"IGU_TX_KEY_NUM_H"},
+
+	{true,	"IGU_RX_NON_TUN_PKT_L"},
+	{true,	"IGU_RX_NON_TUN_PKT_H"},
+	{true,	"IGU_RX_TUN_PKT_L"},
+	{true,	"IGU_RX_TUN_PKT_H"},
+	{false,	"Reserved"},
+	{false,	"Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_rpu_reg_0[] = {
+	{true, "tc_queue_num"},
+	{true, "FSM_DFX_ST0"},
+	{true, "FSM_DFX_ST1"},
+	{true, "RPU_RX_PKT_DROP_CNT"},
+	{true, "BUF_WAIT_TIMEOUT"},
+	{true, "BUF_WAIT_TIMEOUT_QID"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_rpu_reg_1[] = {
+	{false, "Reserved"},
+	{true,	"FIFO_DFX_ST0"},
+	{true,	"FIFO_DFX_ST1"},
+	{true,	"FIFO_DFX_ST2"},
+	{true,	"FIFO_DFX_ST3"},
+	{true,	"FIFO_DFX_ST4"},
+
+	{true,	"FIFO_DFX_ST5"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_ncsi_reg[] = {
+	{false, "Reserved"},
+	{true,	"NCSI_EGU_TX_FIFO_STS"},
+	{true,	"NCSI_PAUSE_STATUS"},
+	{true,	"NCSI_RX_CTRL_DMAC_ERR_CNT"},
+	{true,	"NCSI_RX_CTRL_SMAC_ERR_CNT"},
+	{true,	"NCSI_RX_CTRL_CKS_ERR_CNT"},
+
+	{true,	"NCSI_RX_CTRL_PKT_CNT"},
+	{true,	"NCSI_RX_PT_DMAC_ERR_CNT"},
+	{true,	"NCSI_RX_PT_SMAC_ERR_CNT"},
+	{true,	"NCSI_RX_PT_PKT_CNT"},
+	{true,	"NCSI_RX_FCS_ERR_CNT"},
+	{true,	"NCSI_TX_CTRL_DMAC_ERR_CNT"},
+
+	{true,	"NCSI_TX_CTRL_SMAC_ERR_CNT"},
+	{true,	"NCSI_TX_CTRL_PKT_CNT"},
+	{true,	"NCSI_TX_PT_DMAC_ERR_CNT"},
+	{true,	"NCSI_TX_PT_SMAC_ERR_CNT"},
+	{true,	"NCSI_TX_PT_PKT_CNT"},
+	{true,	"NCSI_TX_PT_PKT_TRUNC_CNT"},
+
+	{true,	"NCSI_TX_PT_PKT_ERR_CNT"},
+	{true,	"NCSI_TX_CTRL_PKT_ERR_CNT"},
+	{true,	"NCSI_RX_CTRL_PKT_TRUNC_CNT"},
+	{true,	"NCSI_RX_CTRL_PKT_CFLIT_CNT"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+
+	{true,	"NCSI_MAC_RX_OCTETS_OK"},
+	{true,	"NCSI_MAC_RX_OCTETS_BAD"},
+	{true,	"NCSI_MAC_RX_UC_PKTS"},
+	{true,	"NCSI_MAC_RX_MC_PKTS"},
+	{true,	"NCSI_MAC_RX_BC_PKTS"},
+	{true,	"NCSI_MAC_RX_PKTS_64OCTETS"},
+
+	{true,	"NCSI_MAC_RX_PKTS_65TO127OCTETS"},
+	{true,	"NCSI_MAC_RX_PKTS_128TO255OCTETS"},
+	{true,	"NCSI_MAC_RX_PKTS_255TO511OCTETS"},
+	{true,	"NCSI_MAC_RX_PKTS_512TO1023OCTETS"},
+	{true,	"NCSI_MAC_RX_PKTS_1024TO1518OCTETS"},
+	{true,	"NCSI_MAC_RX_PKTS_1519TOMAXOCTETS"},
+
+	{true,	"NCSI_MAC_RX_FCS_ERRORS"},
+	{true,	"NCSI_MAC_RX_LONG_ERRORS"},
+	{true,	"NCSI_MAC_RX_JABBER_ERRORS"},
+	{true,	"NCSI_MAC_RX_RUNT_ERR_CNT"},
+	{true,	"NCSI_MAC_RX_SHORT_ERR_CNT"},
+	{true,	"NCSI_MAC_RX_FILT_PKT_CNT"},
+
+	{true,	"NCSI_MAC_RX_OCTETS_TOTAL_FILT"},
+	{true,	"NCSI_MAC_TX_OCTETS_OK"},
+	{true,	"NCSI_MAC_TX_OCTETS_BAD"},
+	{true,	"NCSI_MAC_TX_UC_PKTS"},
+	{true,	"NCSI_MAC_TX_MC_PKTS"},
+	{true,	"NCSI_MAC_TX_BC_PKTS"},
+
+	{true,	"NCSI_MAC_TX_PKTS_64OCTETS"},
+	{true,	"NCSI_MAC_TX_PKTS_65TO127OCTETS"},
+	{true,	"NCSI_MAC_TX_PKTS_128TO255OCTETS"},
+	{true,	"NCSI_MAC_TX_PKTS_256TO511OCTETS"},
+	{true,	"NCSI_MAC_TX_PKTS_512TO1023OCTETS"},
+	{true,	"NCSI_MAC_TX_PKTS_1024TO1518OCTETS"},
+
+	{true,	"NCSI_MAC_TX_PKTS_1519TOMAXOCTETS"},
+	{true,	"NCSI_MAC_TX_UNDERRUN"},
+	{true,	"NCSI_MAC_TX_CRC_ERROR"},
+	{true,	"NCSI_MAC_TX_PAUSE_FRAMES"},
+	{true,	"NCSI_MAC_RX_PAD_PKTS"},
+	{true,	"NCSI_MAC_RX_PAUSE_FRAMES"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_rtc_reg[] = {
+	{false, "Reserved"},
+	{true,	"LGE_IGU_AFIFO_DFX_0"},
+	{true,	"LGE_IGU_AFIFO_DFX_1"},
+	{true,	"LGE_IGU_AFIFO_DFX_2"},
+	{true,	"LGE_IGU_AFIFO_DFX_3"},
+	{true,	"LGE_IGU_AFIFO_DFX_4"},
+
+	{true,	"LGE_IGU_AFIFO_DFX_5"},
+	{true,	"LGE_IGU_AFIFO_DFX_6"},
+	{true,	"LGE_IGU_AFIFO_DFX_7"},
+	{true,	"LGE_EGU_AFIFO_DFX_0"},
+	{true,	"LGE_EGU_AFIFO_DFX_1"},
+	{true,	"LGE_EGU_AFIFO_DFX_2"},
+
+	{true,	"LGE_EGU_AFIFO_DFX_3"},
+	{true,	"LGE_EGU_AFIFO_DFX_4"},
+	{true,	"LGE_EGU_AFIFO_DFX_5"},
+	{true,	"LGE_EGU_AFIFO_DFX_6"},
+	{true,	"LGE_EGU_AFIFO_DFX_7"},
+	{true,	"CGE_IGU_AFIFO_DFX_0"},
+
+	{true,	"CGE_IGU_AFIFO_DFX_1"},
+	{true,	"CGE_EGU_AFIFO_DFX_0"},
+	{true,	"CGE_EGU_AFIFO_DFX_1"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_ppp_reg[] = {
+	{false, "Reserved"},
+	{true,	"DROP_FROM_PRT_PKT_CNT"},
+	{true,	"DROP_FROM_HOST_PKT_CNT"},
+	{true,	"DROP_TX_VLAN_PROC_CNT"},
+	{true,	"DROP_MNG_CNT"},
+	{true,	"DROP_FD_CNT"},
+
+	{true,	"DROP_NO_DST_CNT"},
+	{true,	"DROP_MC_MBID_FULL_CNT"},
+	{true,	"DROP_SC_FILTERED"},
+	{true,	"PPP_MC_DROP_PKT_CNT"},
+	{true,	"DROP_PT_CNT"},
+	{true,	"DROP_MAC_ANTI_SPOOF_CNT"},
+
+	{true,	"DROP_IG_VFV_CNT"},
+	{true,	"DROP_IG_PRTV_CNT"},
+	{true,	"DROP_CNM_PFC_PAUSE_CNT"},
+	{true,	"DROP_TORUS_TC_CNT"},
+	{true,	"DROP_TORUS_LPBK_CNT"},
+	{true,	"PPP_HFS_STS"},
+
+	{true,	"PPP_MC_RSLT_STS"},
+	{true,	"PPP_P3U_STS"},
+	{true,	"PPP_RSLT_DESCR_STS"},
+	{true,	"PPP_UMV_STS_0"},
+	{true,	"PPP_UMV_STS_1"},
+	{true,	"PPP_VFV_STS"},
+
+	{true,	"PPP_GRO_KEY_CNT"},
+	{true,	"PPP_GRO_INFO_CNT"},
+	{true,	"PPP_GRO_DROP_CNT"},
+	{true,	"PPP_GRO_OUT_CNT"},
+	{true,	"PPP_GRO_KEY_MATCH_DATA_CNT"},
+	{true,	"PPP_GRO_KEY_MATCH_TCAM_CNT"},
+
+	{true,	"PPP_GRO_INFO_MATCH_CNT"},
+	{true,	"PPP_GRO_FREE_ENTRY_CNT"},
+	{true,	"PPP_GRO_INNER_DFX_SIGNAL"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+
+	{true,	"GET_RX_PKT_CNT_L"},
+	{true,	"GET_RX_PKT_CNT_H"},
+	{true,	"GET_TX_PKT_CNT_L"},
+	{true,	"GET_TX_PKT_CNT_H"},
+	{true,	"SEND_UC_PRT2HOST_PKT_CNT_L"},
+	{true,	"SEND_UC_PRT2HOST_PKT_CNT_H"},
+
+	{true,	"SEND_UC_PRT2PRT_PKT_CNT_L"},
+	{true,	"SEND_UC_PRT2PRT_PKT_CNT_H"},
+	{true,	"SEND_UC_HOST2HOST_PKT_CNT_L"},
+	{true,	"SEND_UC_HOST2HOST_PKT_CNT_H"},
+	{true,	"SEND_UC_HOST2PRT_PKT_CNT_L"},
+	{true,	"SEND_UC_HOST2PRT_PKT_CNT_H"},
+
+	{true,	"SEND_MC_FROM_PRT_CNT_L"},
+	{true,	"SEND_MC_FROM_PRT_CNT_H"},
+	{true,	"SEND_MC_FROM_HOST_CNT_L"},
+	{true,	"SEND_MC_FROM_HOST_CNT_H"},
+	{true,	"SSU_MC_RD_CNT_L"},
+	{true,	"SSU_MC_RD_CNT_H"},
+
+	{true,	"SSU_MC_DROP_CNT_L"},
+	{true,	"SSU_MC_DROP_CNT_H"},
+	{true,	"SSU_MC_RD_PKT_CNT_L"},
+	{true,	"SSU_MC_RD_PKT_CNT_H"},
+	{true,	"PPP_MC_2HOST_PKT_CNT_L"},
+	{true,	"PPP_MC_2HOST_PKT_CNT_H"},
+
+	{true,	"PPP_MC_2PRT_PKT_CNT_L"},
+	{true,	"PPP_MC_2PRT_PKT_CNT_H"},
+	{true,	"NTSNOS_PKT_CNT_L"},
+	{true,	"NTSNOS_PKT_CNT_H"},
+	{true,	"NTUP_PKT_CNT_L"},
+	{true,	"NTUP_PKT_CNT_H"},
+
+	{true,	"NTLCL_PKT_CNT_L"},
+	{true,	"NTLCL_PKT_CNT_H"},
+	{true,	"NTTGT_PKT_CNT_L"},
+	{true,	"NTTGT_PKT_CNT_H"},
+	{true,	"RTNS_PKT_CNT_L"},
+	{true,	"RTNS_PKT_CNT_H"},
+
+	{true,	"RTLPBK_PKT_CNT_L"},
+	{true,	"RTLPBK_PKT_CNT_H"},
+	{true,	"NR_PKT_CNT_L"},
+	{true,	"NR_PKT_CNT_H"},
+	{true,	"RR_PKT_CNT_L"},
+	{true,	"RR_PKT_CNT_H"},
+
+	{true,	"MNG_TBL_HIT_CNT_L"},
+	{true,	"MNG_TBL_HIT_CNT_H"},
+	{true,	"FD_TBL_HIT_CNT_L"},
+	{true,	"FD_TBL_HIT_CNT_H"},
+	{true,	"FD_LKUP_CNT_L"},
+	{true,	"FD_LKUP_CNT_H"},
+
+	{true,	"BC_HIT_CNT_L"},
+	{true,	"BC_HIT_CNT_H"},
+	{true,	"UM_TBL_UC_HIT_CNT_L"},
+	{true,	"UM_TBL_UC_HIT_CNT_H"},
+	{true,	"UM_TBL_MC_HIT_CNT_L"},
+	{true,	"UM_TBL_MC_HIT_CNT_H"},
+
+	{true,	"UM_TBL_VMDQ1_HIT_CNT_L"},
+	{true,	"UM_TBL_VMDQ1_HIT_CNT_H"},
+	{true,	"MTA_TBL_HIT_CNT_L"},
+	{true,	"MTA_TBL_HIT_CNT_H"},
+	{true,	"FWD_BONDING_HIT_CNT_L"},
+	{true,	"FWD_BONDING_HIT_CNT_H"},
+
+	{true,	"PROMIS_TBL_HIT_CNT_L"},
+	{true,	"PROMIS_TBL_HIT_CNT_H"},
+	{true,	"GET_TUNL_PKT_CNT_L"},
+	{true,	"GET_TUNL_PKT_CNT_H"},
+	{true,	"GET_BMC_PKT_CNT_L"},
+	{true,	"GET_BMC_PKT_CNT_H"},
+
+	{true,	"SEND_UC_PRT2BMC_PKT_CNT_L"},
+	{true,	"SEND_UC_PRT2BMC_PKT_CNT_H"},
+	{true,	"SEND_UC_HOST2BMC_PKT_CNT_L"},
+	{true,	"SEND_UC_HOST2BMC_PKT_CNT_H"},
+	{true,	"SEND_UC_BMC2HOST_PKT_CNT_L"},
+	{true,	"SEND_UC_BMC2HOST_PKT_CNT_H"},
+
+	{true,	"SEND_UC_BMC2PRT_PKT_CNT_L"},
+	{true,	"SEND_UC_BMC2PRT_PKT_CNT_H"},
+	{true,	"PPP_MC_2BMC_PKT_CNT_L"},
+	{true,	"PPP_MC_2BMC_PKT_CNT_H"},
+	{true,	"VLAN_MIRR_CNT_L"},
+	{true,	"VLAN_MIRR_CNT_H"},
+
+	{true,	"IG_MIRR_CNT_L"},
+	{true,	"IG_MIRR_CNT_H"},
+	{true,	"EG_MIRR_CNT_L"},
+	{true,	"EG_MIRR_CNT_H"},
+	{true,	"RX_DEFAULT_HOST_HIT_CNT_L"},
+	{true,	"RX_DEFAULT_HOST_HIT_CNT_H"},
+
+	{true,	"LAN_PAIR_CNT_L"},
+	{true,	"LAN_PAIR_CNT_H"},
+	{true,	"UM_TBL_MC_HIT_PKT_CNT_L"},
+	{true,	"UM_TBL_MC_HIT_PKT_CNT_H"},
+	{true,	"MTA_TBL_HIT_PKT_CNT_L"},
+	{true,	"MTA_TBL_HIT_PKT_CNT_H"},
+
+	{true,	"PROMIS_TBL_HIT_PKT_CNT_L"},
+	{true,	"PROMIS_TBL_HIT_PKT_CNT_H"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_rcb_reg[] = {
+	{false, "Reserved"},
+	{true,	"FSM_DFX_ST0"},
+	{true,	"FSM_DFX_ST1"},
+	{true,	"FSM_DFX_ST2"},
+	{true,	"FIFO_DFX_ST0"},
+	{true,	"FIFO_DFX_ST1"},
+
+	{true,	"FIFO_DFX_ST2"},
+	{true,	"FIFO_DFX_ST3"},
+	{true,	"FIFO_DFX_ST4"},
+	{true,	"FIFO_DFX_ST5"},
+	{true,	"FIFO_DFX_ST6"},
+	{true,	"FIFO_DFX_ST7"},
+
+	{true,	"FIFO_DFX_ST8"},
+	{true,	"FIFO_DFX_ST9"},
+	{true,	"FIFO_DFX_ST10"},
+	{true,	"FIFO_DFX_ST11"},
+	{true,	"Q_CREDIT_VLD_0"},
+	{true,	"Q_CREDIT_VLD_1"},
+
+	{true,	"Q_CREDIT_VLD_2"},
+	{true,	"Q_CREDIT_VLD_3"},
+	{true,	"Q_CREDIT_VLD_4"},
+	{true,	"Q_CREDIT_VLD_5"},
+	{true,	"Q_CREDIT_VLD_6"},
+	{true,	"Q_CREDIT_VLD_7"},
+
+	{true,	"Q_CREDIT_VLD_8"},
+	{true,	"Q_CREDIT_VLD_9"},
+	{true,	"Q_CREDIT_VLD_10"},
+	{true,	"Q_CREDIT_VLD_11"},
+	{true,	"Q_CREDIT_VLD_12"},
+	{true,	"Q_CREDIT_VLD_13"},
+
+	{true,	"Q_CREDIT_VLD_14"},
+	{true,	"Q_CREDIT_VLD_15"},
+	{true,	"Q_CREDIT_VLD_16"},
+	{true,	"Q_CREDIT_VLD_17"},
+	{true,	"Q_CREDIT_VLD_18"},
+	{true,	"Q_CREDIT_VLD_19"},
+
+	{true,	"Q_CREDIT_VLD_20"},
+	{true,	"Q_CREDIT_VLD_21"},
+	{true,	"Q_CREDIT_VLD_22"},
+	{true,	"Q_CREDIT_VLD_23"},
+	{true,	"Q_CREDIT_VLD_24"},
+	{true,	"Q_CREDIT_VLD_25"},
+
+	{true,	"Q_CREDIT_VLD_26"},
+	{true,	"Q_CREDIT_VLD_27"},
+	{true,	"Q_CREDIT_VLD_28"},
+	{true,	"Q_CREDIT_VLD_29"},
+	{true,	"Q_CREDIT_VLD_30"},
+	{true,	"Q_CREDIT_VLD_31"},
+
+	{true,	"GRO_BD_SERR_CNT"},
+	{true,	"GRO_CONTEXT_SERR_CNT"},
+	{true,	"RX_STASH_CFG_SERR_CNT"},
+	{true,	"AXI_RD_FBD_SERR_CNT"},
+	{true,	"GRO_BD_MERR_CNT"},
+	{true,	"GRO_CONTEXT_MERR_CNT"},
+
+	{true,	"RX_STASH_CFG_MERR_CNT"},
+	{true,	"AXI_RD_FBD_MERR_CNT"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+	{false, "Reserved"},
+};
+
+static const struct hclge_dbg_dfx_message hclge_dbg_tqp_reg[] = {
+	{true, "q_num"},
+	{true, "RCB_CFG_RX_RING_TAIL"},
+	{true, "RCB_CFG_RX_RING_HEAD"},
+	{true, "RCB_CFG_RX_RING_FBDNUM"},
+	{true, "RCB_CFG_RX_RING_OFFSET"},
+	{true, "RCB_CFG_RX_RING_FBDOFFSET"},
+
+	{true, "RCB_CFG_RX_RING_PKTNUM_RECORD"},
+	{true, "RCB_CFG_TX_RING_TAIL"},
+	{true, "RCB_CFG_TX_RING_HEAD"},
+	{true, "RCB_CFG_TX_RING_FBDNUM"},
+	{true, "RCB_CFG_TX_RING_OFFSET"},
+	{true, "RCB_CFG_TX_RING_EBDNUM"},
+};
+
 static const struct hclge_dbg_reg_type_info hclge_dbg_reg_info[] = {
 	{ .cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
 	  .dfx_msg = &hclge_dbg_bios_common_reg[0],
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 724052928b88..31a775fb032b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -99,646 +99,6 @@ struct hclge_dbg_status_dfx_info {
 	char message[HCLGE_DBG_MAX_DFX_MSG_LEN];
 };
 
-static const struct hclge_dbg_dfx_message hclge_dbg_bios_common_reg[] = {
-	{false, "Reserved"},
-	{true,	"BP_CPU_STATE"},
-	{true,	"DFX_MSIX_INFO_NIC_0"},
-	{true,	"DFX_MSIX_INFO_NIC_1"},
-	{true,	"DFX_MSIX_INFO_NIC_2"},
-	{true,	"DFX_MSIX_INFO_NIC_3"},
-
-	{true,	"DFX_MSIX_INFO_ROC_0"},
-	{true,	"DFX_MSIX_INFO_ROC_1"},
-	{true,	"DFX_MSIX_INFO_ROC_2"},
-	{true,	"DFX_MSIX_INFO_ROC_3"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_0[] = {
-	{false, "Reserved"},
-	{true,	"SSU_ETS_PORT_STATUS"},
-	{true,	"SSU_ETS_TCG_STATUS"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{true,	"SSU_BP_STATUS_0"},
-
-	{true,	"SSU_BP_STATUS_1"},
-	{true,	"SSU_BP_STATUS_2"},
-	{true,	"SSU_BP_STATUS_3"},
-	{true,	"SSU_BP_STATUS_4"},
-	{true,	"SSU_BP_STATUS_5"},
-	{true,	"SSU_MAC_TX_PFC_IND"},
-
-	{true,	"MAC_SSU_RX_PFC_IND"},
-	{true,	"BTMP_AGEING_ST_B0"},
-	{true,	"BTMP_AGEING_ST_B1"},
-	{true,	"BTMP_AGEING_ST_B2"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-
-	{true,	"FULL_DROP_NUM"},
-	{true,	"PART_DROP_NUM"},
-	{true,	"PPP_KEY_DROP_NUM"},
-	{true,	"PPP_RLT_DROP_NUM"},
-	{true,	"LO_PRI_UNICAST_RLT_DROP_NUM"},
-	{true,	"HI_PRI_MULTICAST_RLT_DROP_NUM"},
-
-	{true,	"LO_PRI_MULTICAST_RLT_DROP_NUM"},
-	{true,	"NCSI_PACKET_CURR_BUFFER_CNT"},
-	{true,	"BTMP_AGEING_RLS_CNT_BANK0"},
-	{true,	"BTMP_AGEING_RLS_CNT_BANK1"},
-	{true,	"BTMP_AGEING_RLS_CNT_BANK2"},
-	{true,	"SSU_MB_RD_RLT_DROP_CNT"},
-
-	{true,	"SSU_PPP_MAC_KEY_NUM_L"},
-	{true,	"SSU_PPP_MAC_KEY_NUM_H"},
-	{true,	"SSU_PPP_HOST_KEY_NUM_L"},
-	{true,	"SSU_PPP_HOST_KEY_NUM_H"},
-	{true,	"PPP_SSU_MAC_RLT_NUM_L"},
-	{true,	"PPP_SSU_MAC_RLT_NUM_H"},
-
-	{true,	"PPP_SSU_HOST_RLT_NUM_L"},
-	{true,	"PPP_SSU_HOST_RLT_NUM_H"},
-	{true,	"NCSI_RX_PACKET_IN_CNT_L"},
-	{true,	"NCSI_RX_PACKET_IN_CNT_H"},
-	{true,	"NCSI_TX_PACKET_OUT_CNT_L"},
-	{true,	"NCSI_TX_PACKET_OUT_CNT_H"},
-
-	{true,	"SSU_KEY_DROP_NUM"},
-	{true,	"MB_UNCOPY_NUM"},
-	{true,	"RX_OQ_DROP_PKT_CNT"},
-	{true,	"TX_OQ_DROP_PKT_CNT"},
-	{true,	"BANK_UNBALANCE_DROP_CNT"},
-	{true,	"BANK_UNBALANCE_RX_DROP_CNT"},
-
-	{true,	"NIC_L2_ERR_DROP_PKT_CNT"},
-	{true,	"ROC_L2_ERR_DROP_PKT_CNT"},
-	{true,	"NIC_L2_ERR_DROP_PKT_CNT_RX"},
-	{true,	"ROC_L2_ERR_DROP_PKT_CNT_RX"},
-	{true,	"RX_OQ_GLB_DROP_PKT_CNT"},
-	{false, "Reserved"},
-
-	{true,	"LO_PRI_UNICAST_CUR_CNT"},
-	{true,	"HI_PRI_MULTICAST_CUR_CNT"},
-	{true,	"LO_PRI_MULTICAST_CUR_CNT"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_1[] = {
-	{true,	"prt_id"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_0"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_1"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_2"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_3"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_4"},
-
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_5"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_6"},
-	{true,	"PACKET_TC_CURR_BUFFER_CNT_7"},
-	{true,	"PACKET_CURR_BUFFER_CNT"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-
-	{true,	"RX_PACKET_IN_CNT_L"},
-	{true,	"RX_PACKET_IN_CNT_H"},
-	{true,	"RX_PACKET_OUT_CNT_L"},
-	{true,	"RX_PACKET_OUT_CNT_H"},
-	{true,	"TX_PACKET_IN_CNT_L"},
-	{true,	"TX_PACKET_IN_CNT_H"},
-
-	{true,	"TX_PACKET_OUT_CNT_L"},
-	{true,	"TX_PACKET_OUT_CNT_H"},
-	{true,	"ROC_RX_PACKET_IN_CNT_L"},
-	{true,	"ROC_RX_PACKET_IN_CNT_H"},
-	{true,	"ROC_TX_PACKET_OUT_CNT_L"},
-	{true,	"ROC_TX_PACKET_OUT_CNT_H"},
-
-	{true,	"RX_PACKET_TC_IN_CNT_0_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_0_H"},
-	{true,	"RX_PACKET_TC_IN_CNT_1_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_1_H"},
-	{true,	"RX_PACKET_TC_IN_CNT_2_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_2_H"},
-
-	{true,	"RX_PACKET_TC_IN_CNT_3_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_3_H"},
-	{true,	"RX_PACKET_TC_IN_CNT_4_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_4_H"},
-	{true,	"RX_PACKET_TC_IN_CNT_5_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_5_H"},
-
-	{true,	"RX_PACKET_TC_IN_CNT_6_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_6_H"},
-	{true,	"RX_PACKET_TC_IN_CNT_7_L"},
-	{true,	"RX_PACKET_TC_IN_CNT_7_H"},
-	{true,	"RX_PACKET_TC_OUT_CNT_0_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_0_H"},
-
-	{true,	"RX_PACKET_TC_OUT_CNT_1_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_1_H"},
-	{true,	"RX_PACKET_TC_OUT_CNT_2_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_2_H"},
-	{true,	"RX_PACKET_TC_OUT_CNT_3_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_3_H"},
-
-	{true,	"RX_PACKET_TC_OUT_CNT_4_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_4_H"},
-	{true,	"RX_PACKET_TC_OUT_CNT_5_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_5_H"},
-	{true,	"RX_PACKET_TC_OUT_CNT_6_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_6_H"},
-
-	{true,	"RX_PACKET_TC_OUT_CNT_7_L"},
-	{true,	"RX_PACKET_TC_OUT_CNT_7_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_0_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_0_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_1_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_1_H"},
-
-	{true,	"TX_PACKET_TC_IN_CNT_2_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_2_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_3_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_3_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_4_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_4_H"},
-
-	{true,	"TX_PACKET_TC_IN_CNT_5_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_5_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_6_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_6_H"},
-	{true,	"TX_PACKET_TC_IN_CNT_7_L"},
-	{true,	"TX_PACKET_TC_IN_CNT_7_H"},
-
-	{true,	"TX_PACKET_TC_OUT_CNT_0_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_0_H"},
-	{true,	"TX_PACKET_TC_OUT_CNT_1_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_1_H"},
-	{true,	"TX_PACKET_TC_OUT_CNT_2_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_2_H"},
-
-	{true,	"TX_PACKET_TC_OUT_CNT_3_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_3_H"},
-	{true,	"TX_PACKET_TC_OUT_CNT_4_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_4_H"},
-	{true,	"TX_PACKET_TC_OUT_CNT_5_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_5_H"},
-
-	{true,	"TX_PACKET_TC_OUT_CNT_6_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_6_H"},
-	{true,	"TX_PACKET_TC_OUT_CNT_7_L"},
-	{true,	"TX_PACKET_TC_OUT_CNT_7_H"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_ssu_reg_2[] = {
-	{true,	"OQ_INDEX"},
-	{true,	"QUEUE_CNT"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_igu_egu_reg[] = {
-	{true,	"prt_id"},
-	{true,	"IGU_RX_ERR_PKT"},
-	{true,	"IGU_RX_NO_SOF_PKT"},
-	{true,	"EGU_TX_1588_SHORT_PKT"},
-	{true,	"EGU_TX_1588_PKT"},
-	{true,	"EGU_TX_ERR_PKT"},
-
-	{true,	"IGU_RX_OUT_L2_PKT"},
-	{true,	"IGU_RX_OUT_L3_PKT"},
-	{true,	"IGU_RX_OUT_L4_PKT"},
-	{true,	"IGU_RX_IN_L2_PKT"},
-	{true,	"IGU_RX_IN_L3_PKT"},
-	{true,	"IGU_RX_IN_L4_PKT"},
-
-	{true,	"IGU_RX_EL3E_PKT"},
-	{true,	"IGU_RX_EL4E_PKT"},
-	{true,	"IGU_RX_L3E_PKT"},
-	{true,	"IGU_RX_L4E_PKT"},
-	{true,	"IGU_RX_ROCEE_PKT"},
-	{true,	"IGU_RX_OUT_UDP0_PKT"},
-
-	{true,	"IGU_RX_IN_UDP0_PKT"},
-	{true,	"IGU_MC_CAR_DROP_PKT_L"},
-	{true,	"IGU_MC_CAR_DROP_PKT_H"},
-	{true,	"IGU_BC_CAR_DROP_PKT_L"},
-	{true,	"IGU_BC_CAR_DROP_PKT_H"},
-	{false, "Reserved"},
-
-	{true,	"IGU_RX_OVERSIZE_PKT_L"},
-	{true,	"IGU_RX_OVERSIZE_PKT_H"},
-	{true,	"IGU_RX_UNDERSIZE_PKT_L"},
-	{true,	"IGU_RX_UNDERSIZE_PKT_H"},
-	{true,	"IGU_RX_OUT_ALL_PKT_L"},
-	{true,	"IGU_RX_OUT_ALL_PKT_H"},
-
-	{true,	"IGU_TX_OUT_ALL_PKT_L"},
-	{true,	"IGU_TX_OUT_ALL_PKT_H"},
-	{true,	"IGU_RX_UNI_PKT_L"},
-	{true,	"IGU_RX_UNI_PKT_H"},
-	{true,	"IGU_RX_MULTI_PKT_L"},
-	{true,	"IGU_RX_MULTI_PKT_H"},
-
-	{true,	"IGU_RX_BROAD_PKT_L"},
-	{true,	"IGU_RX_BROAD_PKT_H"},
-	{true,	"EGU_TX_OUT_ALL_PKT_L"},
-	{true,	"EGU_TX_OUT_ALL_PKT_H"},
-	{true,	"EGU_TX_UNI_PKT_L"},
-	{true,	"EGU_TX_UNI_PKT_H"},
-
-	{true,	"EGU_TX_MULTI_PKT_L"},
-	{true,	"EGU_TX_MULTI_PKT_H"},
-	{true,	"EGU_TX_BROAD_PKT_L"},
-	{true,	"EGU_TX_BROAD_PKT_H"},
-	{true,	"IGU_TX_KEY_NUM_L"},
-	{true,	"IGU_TX_KEY_NUM_H"},
-
-	{true,	"IGU_RX_NON_TUN_PKT_L"},
-	{true,	"IGU_RX_NON_TUN_PKT_H"},
-	{true,	"IGU_RX_TUN_PKT_L"},
-	{true,	"IGU_RX_TUN_PKT_H"},
-	{false,	"Reserved"},
-	{false,	"Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_rpu_reg_0[] = {
-	{true, "tc_queue_num"},
-	{true, "FSM_DFX_ST0"},
-	{true, "FSM_DFX_ST1"},
-	{true, "RPU_RX_PKT_DROP_CNT"},
-	{true, "BUF_WAIT_TIMEOUT"},
-	{true, "BUF_WAIT_TIMEOUT_QID"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_rpu_reg_1[] = {
-	{false, "Reserved"},
-	{true,	"FIFO_DFX_ST0"},
-	{true,	"FIFO_DFX_ST1"},
-	{true,	"FIFO_DFX_ST2"},
-	{true,	"FIFO_DFX_ST3"},
-	{true,	"FIFO_DFX_ST4"},
-
-	{true,	"FIFO_DFX_ST5"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_ncsi_reg[] = {
-	{false, "Reserved"},
-	{true,	"NCSI_EGU_TX_FIFO_STS"},
-	{true,	"NCSI_PAUSE_STATUS"},
-	{true,	"NCSI_RX_CTRL_DMAC_ERR_CNT"},
-	{true,	"NCSI_RX_CTRL_SMAC_ERR_CNT"},
-	{true,	"NCSI_RX_CTRL_CKS_ERR_CNT"},
-
-	{true,	"NCSI_RX_CTRL_PKT_CNT"},
-	{true,	"NCSI_RX_PT_DMAC_ERR_CNT"},
-	{true,	"NCSI_RX_PT_SMAC_ERR_CNT"},
-	{true,	"NCSI_RX_PT_PKT_CNT"},
-	{true,	"NCSI_RX_FCS_ERR_CNT"},
-	{true,	"NCSI_TX_CTRL_DMAC_ERR_CNT"},
-
-	{true,	"NCSI_TX_CTRL_SMAC_ERR_CNT"},
-	{true,	"NCSI_TX_CTRL_PKT_CNT"},
-	{true,	"NCSI_TX_PT_DMAC_ERR_CNT"},
-	{true,	"NCSI_TX_PT_SMAC_ERR_CNT"},
-	{true,	"NCSI_TX_PT_PKT_CNT"},
-	{true,	"NCSI_TX_PT_PKT_TRUNC_CNT"},
-
-	{true,	"NCSI_TX_PT_PKT_ERR_CNT"},
-	{true,	"NCSI_TX_CTRL_PKT_ERR_CNT"},
-	{true,	"NCSI_RX_CTRL_PKT_TRUNC_CNT"},
-	{true,	"NCSI_RX_CTRL_PKT_CFLIT_CNT"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-
-	{true,	"NCSI_MAC_RX_OCTETS_OK"},
-	{true,	"NCSI_MAC_RX_OCTETS_BAD"},
-	{true,	"NCSI_MAC_RX_UC_PKTS"},
-	{true,	"NCSI_MAC_RX_MC_PKTS"},
-	{true,	"NCSI_MAC_RX_BC_PKTS"},
-	{true,	"NCSI_MAC_RX_PKTS_64OCTETS"},
-
-	{true,	"NCSI_MAC_RX_PKTS_65TO127OCTETS"},
-	{true,	"NCSI_MAC_RX_PKTS_128TO255OCTETS"},
-	{true,	"NCSI_MAC_RX_PKTS_255TO511OCTETS"},
-	{true,	"NCSI_MAC_RX_PKTS_512TO1023OCTETS"},
-	{true,	"NCSI_MAC_RX_PKTS_1024TO1518OCTETS"},
-	{true,	"NCSI_MAC_RX_PKTS_1519TOMAXOCTETS"},
-
-	{true,	"NCSI_MAC_RX_FCS_ERRORS"},
-	{true,	"NCSI_MAC_RX_LONG_ERRORS"},
-	{true,	"NCSI_MAC_RX_JABBER_ERRORS"},
-	{true,	"NCSI_MAC_RX_RUNT_ERR_CNT"},
-	{true,	"NCSI_MAC_RX_SHORT_ERR_CNT"},
-	{true,	"NCSI_MAC_RX_FILT_PKT_CNT"},
-
-	{true,	"NCSI_MAC_RX_OCTETS_TOTAL_FILT"},
-	{true,	"NCSI_MAC_TX_OCTETS_OK"},
-	{true,	"NCSI_MAC_TX_OCTETS_BAD"},
-	{true,	"NCSI_MAC_TX_UC_PKTS"},
-	{true,	"NCSI_MAC_TX_MC_PKTS"},
-	{true,	"NCSI_MAC_TX_BC_PKTS"},
-
-	{true,	"NCSI_MAC_TX_PKTS_64OCTETS"},
-	{true,	"NCSI_MAC_TX_PKTS_65TO127OCTETS"},
-	{true,	"NCSI_MAC_TX_PKTS_128TO255OCTETS"},
-	{true,	"NCSI_MAC_TX_PKTS_256TO511OCTETS"},
-	{true,	"NCSI_MAC_TX_PKTS_512TO1023OCTETS"},
-	{true,	"NCSI_MAC_TX_PKTS_1024TO1518OCTETS"},
-
-	{true,	"NCSI_MAC_TX_PKTS_1519TOMAXOCTETS"},
-	{true,	"NCSI_MAC_TX_UNDERRUN"},
-	{true,	"NCSI_MAC_TX_CRC_ERROR"},
-	{true,	"NCSI_MAC_TX_PAUSE_FRAMES"},
-	{true,	"NCSI_MAC_RX_PAD_PKTS"},
-	{true,	"NCSI_MAC_RX_PAUSE_FRAMES"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_rtc_reg[] = {
-	{false, "Reserved"},
-	{true,	"LGE_IGU_AFIFO_DFX_0"},
-	{true,	"LGE_IGU_AFIFO_DFX_1"},
-	{true,	"LGE_IGU_AFIFO_DFX_2"},
-	{true,	"LGE_IGU_AFIFO_DFX_3"},
-	{true,	"LGE_IGU_AFIFO_DFX_4"},
-
-	{true,	"LGE_IGU_AFIFO_DFX_5"},
-	{true,	"LGE_IGU_AFIFO_DFX_6"},
-	{true,	"LGE_IGU_AFIFO_DFX_7"},
-	{true,	"LGE_EGU_AFIFO_DFX_0"},
-	{true,	"LGE_EGU_AFIFO_DFX_1"},
-	{true,	"LGE_EGU_AFIFO_DFX_2"},
-
-	{true,	"LGE_EGU_AFIFO_DFX_3"},
-	{true,	"LGE_EGU_AFIFO_DFX_4"},
-	{true,	"LGE_EGU_AFIFO_DFX_5"},
-	{true,	"LGE_EGU_AFIFO_DFX_6"},
-	{true,	"LGE_EGU_AFIFO_DFX_7"},
-	{true,	"CGE_IGU_AFIFO_DFX_0"},
-
-	{true,	"CGE_IGU_AFIFO_DFX_1"},
-	{true,	"CGE_EGU_AFIFO_DFX_0"},
-	{true,	"CGE_EGU_AFIFO_DFX_1"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_ppp_reg[] = {
-	{false, "Reserved"},
-	{true,	"DROP_FROM_PRT_PKT_CNT"},
-	{true,	"DROP_FROM_HOST_PKT_CNT"},
-	{true,	"DROP_TX_VLAN_PROC_CNT"},
-	{true,	"DROP_MNG_CNT"},
-	{true,	"DROP_FD_CNT"},
-
-	{true,	"DROP_NO_DST_CNT"},
-	{true,	"DROP_MC_MBID_FULL_CNT"},
-	{true,	"DROP_SC_FILTERED"},
-	{true,	"PPP_MC_DROP_PKT_CNT"},
-	{true,	"DROP_PT_CNT"},
-	{true,	"DROP_MAC_ANTI_SPOOF_CNT"},
-
-	{true,	"DROP_IG_VFV_CNT"},
-	{true,	"DROP_IG_PRTV_CNT"},
-	{true,	"DROP_CNM_PFC_PAUSE_CNT"},
-	{true,	"DROP_TORUS_TC_CNT"},
-	{true,	"DROP_TORUS_LPBK_CNT"},
-	{true,	"PPP_HFS_STS"},
-
-	{true,	"PPP_MC_RSLT_STS"},
-	{true,	"PPP_P3U_STS"},
-	{true,	"PPP_RSLT_DESCR_STS"},
-	{true,	"PPP_UMV_STS_0"},
-	{true,	"PPP_UMV_STS_1"},
-	{true,	"PPP_VFV_STS"},
-
-	{true,	"PPP_GRO_KEY_CNT"},
-	{true,	"PPP_GRO_INFO_CNT"},
-	{true,	"PPP_GRO_DROP_CNT"},
-	{true,	"PPP_GRO_OUT_CNT"},
-	{true,	"PPP_GRO_KEY_MATCH_DATA_CNT"},
-	{true,	"PPP_GRO_KEY_MATCH_TCAM_CNT"},
-
-	{true,	"PPP_GRO_INFO_MATCH_CNT"},
-	{true,	"PPP_GRO_FREE_ENTRY_CNT"},
-	{true,	"PPP_GRO_INNER_DFX_SIGNAL"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-
-	{true,	"GET_RX_PKT_CNT_L"},
-	{true,	"GET_RX_PKT_CNT_H"},
-	{true,	"GET_TX_PKT_CNT_L"},
-	{true,	"GET_TX_PKT_CNT_H"},
-	{true,	"SEND_UC_PRT2HOST_PKT_CNT_L"},
-	{true,	"SEND_UC_PRT2HOST_PKT_CNT_H"},
-
-	{true,	"SEND_UC_PRT2PRT_PKT_CNT_L"},
-	{true,	"SEND_UC_PRT2PRT_PKT_CNT_H"},
-	{true,	"SEND_UC_HOST2HOST_PKT_CNT_L"},
-	{true,	"SEND_UC_HOST2HOST_PKT_CNT_H"},
-	{true,	"SEND_UC_HOST2PRT_PKT_CNT_L"},
-	{true,	"SEND_UC_HOST2PRT_PKT_CNT_H"},
-
-	{true,	"SEND_MC_FROM_PRT_CNT_L"},
-	{true,	"SEND_MC_FROM_PRT_CNT_H"},
-	{true,	"SEND_MC_FROM_HOST_CNT_L"},
-	{true,	"SEND_MC_FROM_HOST_CNT_H"},
-	{true,	"SSU_MC_RD_CNT_L"},
-	{true,	"SSU_MC_RD_CNT_H"},
-
-	{true,	"SSU_MC_DROP_CNT_L"},
-	{true,	"SSU_MC_DROP_CNT_H"},
-	{true,	"SSU_MC_RD_PKT_CNT_L"},
-	{true,	"SSU_MC_RD_PKT_CNT_H"},
-	{true,	"PPP_MC_2HOST_PKT_CNT_L"},
-	{true,	"PPP_MC_2HOST_PKT_CNT_H"},
-
-	{true,	"PPP_MC_2PRT_PKT_CNT_L"},
-	{true,	"PPP_MC_2PRT_PKT_CNT_H"},
-	{true,	"NTSNOS_PKT_CNT_L"},
-	{true,	"NTSNOS_PKT_CNT_H"},
-	{true,	"NTUP_PKT_CNT_L"},
-	{true,	"NTUP_PKT_CNT_H"},
-
-	{true,	"NTLCL_PKT_CNT_L"},
-	{true,	"NTLCL_PKT_CNT_H"},
-	{true,	"NTTGT_PKT_CNT_L"},
-	{true,	"NTTGT_PKT_CNT_H"},
-	{true,	"RTNS_PKT_CNT_L"},
-	{true,	"RTNS_PKT_CNT_H"},
-
-	{true,	"RTLPBK_PKT_CNT_L"},
-	{true,	"RTLPBK_PKT_CNT_H"},
-	{true,	"NR_PKT_CNT_L"},
-	{true,	"NR_PKT_CNT_H"},
-	{true,	"RR_PKT_CNT_L"},
-	{true,	"RR_PKT_CNT_H"},
-
-	{true,	"MNG_TBL_HIT_CNT_L"},
-	{true,	"MNG_TBL_HIT_CNT_H"},
-	{true,	"FD_TBL_HIT_CNT_L"},
-	{true,	"FD_TBL_HIT_CNT_H"},
-	{true,	"FD_LKUP_CNT_L"},
-	{true,	"FD_LKUP_CNT_H"},
-
-	{true,	"BC_HIT_CNT_L"},
-	{true,	"BC_HIT_CNT_H"},
-	{true,	"UM_TBL_UC_HIT_CNT_L"},
-	{true,	"UM_TBL_UC_HIT_CNT_H"},
-	{true,	"UM_TBL_MC_HIT_CNT_L"},
-	{true,	"UM_TBL_MC_HIT_CNT_H"},
-
-	{true,	"UM_TBL_VMDQ1_HIT_CNT_L"},
-	{true,	"UM_TBL_VMDQ1_HIT_CNT_H"},
-	{true,	"MTA_TBL_HIT_CNT_L"},
-	{true,	"MTA_TBL_HIT_CNT_H"},
-	{true,	"FWD_BONDING_HIT_CNT_L"},
-	{true,	"FWD_BONDING_HIT_CNT_H"},
-
-	{true,	"PROMIS_TBL_HIT_CNT_L"},
-	{true,	"PROMIS_TBL_HIT_CNT_H"},
-	{true,	"GET_TUNL_PKT_CNT_L"},
-	{true,	"GET_TUNL_PKT_CNT_H"},
-	{true,	"GET_BMC_PKT_CNT_L"},
-	{true,	"GET_BMC_PKT_CNT_H"},
-
-	{true,	"SEND_UC_PRT2BMC_PKT_CNT_L"},
-	{true,	"SEND_UC_PRT2BMC_PKT_CNT_H"},
-	{true,	"SEND_UC_HOST2BMC_PKT_CNT_L"},
-	{true,	"SEND_UC_HOST2BMC_PKT_CNT_H"},
-	{true,	"SEND_UC_BMC2HOST_PKT_CNT_L"},
-	{true,	"SEND_UC_BMC2HOST_PKT_CNT_H"},
-
-	{true,	"SEND_UC_BMC2PRT_PKT_CNT_L"},
-	{true,	"SEND_UC_BMC2PRT_PKT_CNT_H"},
-	{true,	"PPP_MC_2BMC_PKT_CNT_L"},
-	{true,	"PPP_MC_2BMC_PKT_CNT_H"},
-	{true,	"VLAN_MIRR_CNT_L"},
-	{true,	"VLAN_MIRR_CNT_H"},
-
-	{true,	"IG_MIRR_CNT_L"},
-	{true,	"IG_MIRR_CNT_H"},
-	{true,	"EG_MIRR_CNT_L"},
-	{true,	"EG_MIRR_CNT_H"},
-	{true,	"RX_DEFAULT_HOST_HIT_CNT_L"},
-	{true,	"RX_DEFAULT_HOST_HIT_CNT_H"},
-
-	{true,	"LAN_PAIR_CNT_L"},
-	{true,	"LAN_PAIR_CNT_H"},
-	{true,	"UM_TBL_MC_HIT_PKT_CNT_L"},
-	{true,	"UM_TBL_MC_HIT_PKT_CNT_H"},
-	{true,	"MTA_TBL_HIT_PKT_CNT_L"},
-	{true,	"MTA_TBL_HIT_PKT_CNT_H"},
-
-	{true,	"PROMIS_TBL_HIT_PKT_CNT_L"},
-	{true,	"PROMIS_TBL_HIT_PKT_CNT_H"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_rcb_reg[] = {
-	{false, "Reserved"},
-	{true,	"FSM_DFX_ST0"},
-	{true,	"FSM_DFX_ST1"},
-	{true,	"FSM_DFX_ST2"},
-	{true,	"FIFO_DFX_ST0"},
-	{true,	"FIFO_DFX_ST1"},
-
-	{true,	"FIFO_DFX_ST2"},
-	{true,	"FIFO_DFX_ST3"},
-	{true,	"FIFO_DFX_ST4"},
-	{true,	"FIFO_DFX_ST5"},
-	{true,	"FIFO_DFX_ST6"},
-	{true,	"FIFO_DFX_ST7"},
-
-	{true,	"FIFO_DFX_ST8"},
-	{true,	"FIFO_DFX_ST9"},
-	{true,	"FIFO_DFX_ST10"},
-	{true,	"FIFO_DFX_ST11"},
-	{true,	"Q_CREDIT_VLD_0"},
-	{true,	"Q_CREDIT_VLD_1"},
-
-	{true,	"Q_CREDIT_VLD_2"},
-	{true,	"Q_CREDIT_VLD_3"},
-	{true,	"Q_CREDIT_VLD_4"},
-	{true,	"Q_CREDIT_VLD_5"},
-	{true,	"Q_CREDIT_VLD_6"},
-	{true,	"Q_CREDIT_VLD_7"},
-
-	{true,	"Q_CREDIT_VLD_8"},
-	{true,	"Q_CREDIT_VLD_9"},
-	{true,	"Q_CREDIT_VLD_10"},
-	{true,	"Q_CREDIT_VLD_11"},
-	{true,	"Q_CREDIT_VLD_12"},
-	{true,	"Q_CREDIT_VLD_13"},
-
-	{true,	"Q_CREDIT_VLD_14"},
-	{true,	"Q_CREDIT_VLD_15"},
-	{true,	"Q_CREDIT_VLD_16"},
-	{true,	"Q_CREDIT_VLD_17"},
-	{true,	"Q_CREDIT_VLD_18"},
-	{true,	"Q_CREDIT_VLD_19"},
-
-	{true,	"Q_CREDIT_VLD_20"},
-	{true,	"Q_CREDIT_VLD_21"},
-	{true,	"Q_CREDIT_VLD_22"},
-	{true,	"Q_CREDIT_VLD_23"},
-	{true,	"Q_CREDIT_VLD_24"},
-	{true,	"Q_CREDIT_VLD_25"},
-
-	{true,	"Q_CREDIT_VLD_26"},
-	{true,	"Q_CREDIT_VLD_27"},
-	{true,	"Q_CREDIT_VLD_28"},
-	{true,	"Q_CREDIT_VLD_29"},
-	{true,	"Q_CREDIT_VLD_30"},
-	{true,	"Q_CREDIT_VLD_31"},
-
-	{true,	"GRO_BD_SERR_CNT"},
-	{true,	"GRO_CONTEXT_SERR_CNT"},
-	{true,	"RX_STASH_CFG_SERR_CNT"},
-	{true,	"AXI_RD_FBD_SERR_CNT"},
-	{true,	"GRO_BD_MERR_CNT"},
-	{true,	"GRO_CONTEXT_MERR_CNT"},
-
-	{true,	"RX_STASH_CFG_MERR_CNT"},
-	{true,	"AXI_RD_FBD_MERR_CNT"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-	{false, "Reserved"},
-};
-
-static const struct hclge_dbg_dfx_message hclge_dbg_tqp_reg[] = {
-	{true, "q_num"},
-	{true, "RCB_CFG_RX_RING_TAIL"},
-	{true, "RCB_CFG_RX_RING_HEAD"},
-	{true, "RCB_CFG_RX_RING_FBDNUM"},
-	{true, "RCB_CFG_RX_RING_OFFSET"},
-	{true, "RCB_CFG_RX_RING_FBDOFFSET"},
-
-	{true, "RCB_CFG_RX_RING_PKTNUM_RECORD"},
-	{true, "RCB_CFG_TX_RING_TAIL"},
-	{true, "RCB_CFG_TX_RING_HEAD"},
-	{true, "RCB_CFG_TX_RING_FBDNUM"},
-	{true, "RCB_CFG_TX_RING_OFFSET"},
-	{true, "RCB_CFG_TX_RING_EBDNUM"},
-};
-
 #define HCLGE_DBG_INFO_LEN			256
 #define HCLGE_DBG_VLAN_FLTR_INFO_LEN		256
 #define HCLGE_DBG_VLAN_OFFLOAD_INFO_LEN		512
-- 
2.30.0


