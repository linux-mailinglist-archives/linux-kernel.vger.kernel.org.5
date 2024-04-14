Return-Path: <linux-kernel+bounces-144112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69F8A41FA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD551F2133D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7836124;
	Sun, 14 Apr 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I3nvVw3r"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEF224CC;
	Sun, 14 Apr 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092346; cv=none; b=i+L78489C2WcF3c2xCQUFccWiHXqcjtg9st7QYhsB+jx8ldire+c8kXgZgZtXGcLWF6nec1veMiqt0t190p68bN6uJeYR0jMckJRJEOsWC3ZBBw5k7fqoxKTQY63BjQ4xFkP/cB8fZ6FomuBUsku7gYIa7IT8wa5dMcfQd5QDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092346; c=relaxed/simple;
	bh=AqEKj8cemJAO4VLBzjmYB8dB2knOKRrFC9TFKmRruCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjH7m4Azb6KUuGG71KZcXA/Wzy/fRt2FxIkHQiz1OTngHDOQa4i27kLf99I6GEybW4fRiaTwCA2aogmFldUvJXVdB048/9DSTuXxHvqbO4d3Fgm9TSdJ6uc6d7vWdwhlRkg2OBBAaGiK4QB4e+VkkZYyZ0Df4M0CCzFCRnixH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I3nvVw3r; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43E9UFkq013207;
	Sun, 14 Apr 2024 03:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=4CCF6s30
	hNlzm9bBSTcbcv/IHf5CtDFM68cQ3CHdIY0=; b=I3nvVw3rSQv2LdIZs90HPHrI
	OB/uDFS0BkHgDJHqph5Nx1lkvu9fcY85gGvAamqi5HiBZ2+I/9jM5pg5ipItl0RE
	0Es/0XQvle7+Q2xrPZ2ntNtx7Xe5yyQCJmVzqIZZ6On8Kca+H79q0spg4FcJK/zg
	Pkv/Gz70ygKinyTQ26fP5q/JpZmqE721AH1YgSKfDVkW+uvkCTE8SxEtSocmLgSk
	bF2rfJQTxb38f+KQepVEz0J/Xvfv0eCOZmw1ew9grE1DQ6yT5jiv9r10m6gRhiiD
	8Ly9ElUe8EzxUoZ2MelUzIcXKBUS6snAH3c22zQpWt2ezoA+12RSlnKxx5puLA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xfqdkhyx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 03:58:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 14 Apr 2024 03:58:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 14 Apr 2024 03:58:45 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id 87EFE3F7073;
	Sun, 14 Apr 2024 03:58:41 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add ucast filter count configurability via devlink.
Date: Sun, 14 Apr 2024 16:28:30 +0530
Message-ID: <20240414105830.678293-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kOhb-KUhW5Qtd3AWNsJekmTjzris8g5J
X-Proofpoint-GUID: kOhb-KUhW5Qtd3AWNsJekmTjzris8g5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_01,2024-04-09_01,2023-05-22_02

Added a devlink param to set/modify unicast filter count. Currently
it's hardcoded with a macro.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  7 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      | 68 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_flows.c        | 20 +++---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 4 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index c5de3ba33e2f..e20b898eae97 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -346,12 +346,9 @@ struct otx2_flow_config {
 	u16			*def_ent;
 	u16			nr_flows;
 #define OTX2_DEFAULT_FLOWCOUNT		16
-#define OTX2_MAX_UNICAST_FLOWS		8
+#define OTX2_DEFAULT_UNICAST_FLOWS	4
 #define OTX2_MAX_VLAN_FLOWS		1
 #define OTX2_MAX_TC_FLOWS	OTX2_DEFAULT_FLOWCOUNT
-#define OTX2_MCAM_COUNT		(OTX2_DEFAULT_FLOWCOUNT + \
-				 OTX2_MAX_UNICAST_FLOWS + \
-				 OTX2_MAX_VLAN_FLOWS)
 	u16			unicast_offset;
 	u16			rx_vlan_offset;
 	u16			vf_vlan_offset;
@@ -364,6 +361,7 @@ struct otx2_flow_config {
 	u32			dmacflt_max_flows;
 	u16                     max_flows;
 	struct list_head	flow_list_tc;
+	u8			ucast_flt_cnt;
 	bool			ntuple;
 };
 
@@ -1065,6 +1063,7 @@ int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 int otx2_smq_flush(struct otx2_nic *pfvf, int smq);
 void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
 		    u64 iova, int size);
+int otx2_mcam_entry_init(struct otx2_nic *pfvf);
 
 /* tc support */
 int otx2_init_tc(struct otx2_nic *nic);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4e1130496573..ed9cd06aace9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -63,9 +63,72 @@ static int otx2_dl_mcam_count_get(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int otx2_dl_ucast_flt_cnt_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	int err;
+
+	pfvf->flow_cfg->ucast_flt_cnt = ctx->val.vu8;
+
+	otx2_mcam_flow_del(pfvf);
+	err = otx2_mcam_entry_init(pfvf);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	if (!pfvf->flow_cfg) {
+		ctx->val.vu8 = 0;
+		return 0;
+	}
+
+	ctx->val.vu8 = pfvf->flow_cfg->ucast_flt_cnt;
+
+	return 0;
+}
+
+static int otx2_dl_ucast_flt_cnt_validate(struct devlink *devlink, u32 id,
+					  union devlink_param_value val,
+					  struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	/* Check for UNICAST filter support*/
+	if (!(pfvf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unicast filter not enabled");
+		return -EINVAL;
+	}
+
+	if (!pfvf->flow_cfg) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "pfvf->flow_cfg not initialized");
+		return -EINVAL;
+	}
+
+	if (pfvf->flow_cfg->nr_flows) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot modify count when there are active rules");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 enum otx2_dl_param_id {
 	OTX2_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_DEVLINK_PARAM_ID_MCAM_COUNT,
+	OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
 };
 
 static const struct devlink_param otx2_dl_params[] = {
@@ -74,6 +137,11 @@ static const struct devlink_param otx2_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     otx2_dl_mcam_count_get, otx2_dl_mcam_count_set,
 			     otx2_dl_mcam_count_validate),
+	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
+			     "unicast_filter_count", DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_dl_ucast_flt_cnt_get, otx2_dl_ucast_flt_cnt_set,
+			     otx2_dl_ucast_flt_cnt_validate),
 };
 
 static const struct devlink_ops otx2_devlink_ops = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 97a71e9b8563..78c2f31d153b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -12,8 +12,6 @@
 
 #define OTX2_DEFAULT_ACTION	0x1
 
-static int otx2_mcam_entry_init(struct otx2_nic *pfvf);
-
 struct otx2_flow {
 	struct ethtool_rx_flow_spec flow_spec;
 	struct list_head list;
@@ -161,7 +159,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 }
 EXPORT_SYMBOL(otx2_alloc_mcam_entries);
 
-static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
+int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
 	struct npc_get_field_status_req *freq;
@@ -172,7 +170,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	int ent, count;
 
 	vf_vlan_max_flows = pfvf->total_vfs * OTX2_PER_VF_VLAN_FLOWS;
-	count = OTX2_MAX_UNICAST_FLOWS +
+	count = flow_cfg->ucast_flt_cnt +
 			OTX2_MAX_VLAN_FLOWS + vf_vlan_max_flows;
 
 	flow_cfg->def_ent = devm_kmalloc_array(pfvf->dev, count,
@@ -214,7 +212,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	flow_cfg->vf_vlan_offset = 0;
 	flow_cfg->unicast_offset = vf_vlan_max_flows;
 	flow_cfg->rx_vlan_offset = flow_cfg->unicast_offset +
-					OTX2_MAX_UNICAST_FLOWS;
+					flow_cfg->ucast_flt_cnt;
 	pfvf->flags |= OTX2_FLAG_UCAST_FLTR_SUPPORT;
 
 	/* Check if NPC_DMAC field is supported
@@ -254,6 +252,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_mcam_entry_init);
 
 /* TODO : revisit on size */
 #define OTX2_DMAC_FLTR_BITMAP_SZ (4 * 2048 + 32)
@@ -301,6 +300,8 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list);
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
 
+	pf->flow_cfg->ucast_flt_cnt = OTX2_DEFAULT_UNICAST_FLOWS;
+
 	/* Allocate bare minimum number of MCAM entries needed for
 	 * unicast and ntuple filters.
 	 */
@@ -313,7 +314,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 		return 0;
 
 	pf->mac_table = devm_kzalloc(pf->dev, sizeof(struct otx2_mac_table)
-					* OTX2_MAX_UNICAST_FLOWS, GFP_KERNEL);
+					* pf->flow_cfg->ucast_flt_cnt, GFP_KERNEL);
 	if (!pf->mac_table)
 		return -ENOMEM;
 
@@ -355,7 +356,7 @@ static int otx2_do_add_macfilter(struct otx2_nic *pf, const u8 *mac)
 		return -ENOMEM;
 
 	/* dont have free mcam entries or uc list is greater than alloted */
-	if (netdev_uc_count(pf->netdev) > OTX2_MAX_UNICAST_FLOWS)
+	if (netdev_uc_count(pf->netdev) > pf->flow_cfg->ucast_flt_cnt)
 		return -ENOMEM;
 
 	mutex_lock(&pf->mbox.lock);
@@ -366,7 +367,7 @@ static int otx2_do_add_macfilter(struct otx2_nic *pf, const u8 *mac)
 	}
 
 	/* unicast offset starts with 32 0..31 for ntuple */
-	for (i = 0; i <  OTX2_MAX_UNICAST_FLOWS; i++) {
+	for (i = 0; i <  pf->flow_cfg->ucast_flt_cnt; i++) {
 		if (pf->mac_table[i].inuse)
 			continue;
 		ether_addr_copy(pf->mac_table[i].addr, mac);
@@ -409,7 +410,7 @@ static bool otx2_get_mcamentry_for_mac(struct otx2_nic *pf, const u8 *mac,
 {
 	int i;
 
-	for (i = 0; i < OTX2_MAX_UNICAST_FLOWS; i++) {
+	for (i = 0; i < pf->flow_cfg->ucast_flt_cnt; i++) {
 		if (!pf->mac_table[i].inuse)
 			continue;
 
@@ -1393,6 +1394,7 @@ int otx2_destroy_mcam_flows(struct otx2_nic *pfvf)
 	}
 
 	pfvf->flags &= ~OTX2_FLAG_MCAM_ENTRIES_ALLOC;
+	flow_cfg->max_flows = 0;
 	mutex_unlock(&pfvf->mbox.lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6a44dacff508..78c4b3114a82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1714,7 +1714,7 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 		return;
 
 	if ((netdev->flags & IFF_PROMISC) ||
-	    (netdev_uc_count(netdev) > OTX2_MAX_UNICAST_FLOWS)) {
+	    (netdev_uc_count(netdev) > pf->flow_cfg->ucast_flt_cnt)) {
 		promisc = true;
 	}
 
-- 
2.25.1


