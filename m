Return-Path: <linux-kernel+bounces-144005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DC8A40A7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280DF1C20FE5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260B1C6A3;
	Sun, 14 Apr 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JR8F1cBR"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F483639;
	Sun, 14 Apr 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713076228; cv=none; b=PzfmbK39EX/02QZfSVOfto0QKi3SAQzzNF2BfvAhiD5soLIs9SDLBy1x9M6j9bYJVpk4hm++b2ZHLe6nzV11dLTLLskDr/0kraUp3/MlIvCqiJGVPG/BvxTa19Av5CW60xELDgJI2T5VjkFTON091flAAvfLKpKO3PHriwYYFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713076228; c=relaxed/simple;
	bh=vJlAHAr8EDHloD569oT6R33Y1PVo6WKeEkP43cSE750=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNaWdsV2O2Qw162LEU7ac6fS2hWK1+7dP3VV5K9OGc+gz3Z/Z7pitgj83MM1vP1OWrfEv2lY5SaWBaxVqhATA1PEkxyBWbbvP+Zan/i5nLuUiscx+MM4LADdmyBXTLgjKcVx0shRD7QO30Y3uE/mK2rgX/Rlz8TB6M77gTuE2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JR8F1cBR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43E6OK2Y024534;
	Sat, 13 Apr 2024 23:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=CIqU5TiCfMaZXHhfl+W0CMBdCoRp48kVEberT8v3VO0=; b=JR8
	F1cBRPS9GwBLOWGj1ElMdmamvffMKDXQ95EWH+yZ6W3VKo2PAybWFmoCGchXxSMU
	m/somL74yr+S8weDUlKM+6ng/IKxuGL3Y3i8DUMXDsyTgQDE+p0xZipe3BgcaEo5
	Up8UaBS6B9qCvxbbs8aNHn9U2NylQ2zUnoGltrMWZkSJyoeLB8Rsgee8Qbzz0/LI
	TzE2dJ7vXO6pzVhmzwbuU4gEM+UjO1KolIZmKG8th3Nmni5ji+qUR4Mgcx/DcQFv
	2FIlN1alQlO1fKPP9sX/+5HZb78mHarI2+Y8w2q6yBx1yHmbS8V7Uaimca8BRucy
	NKno0lrez50TIku1hig==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg1fu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 23:30:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 13 Apr 2024 23:30:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 13 Apr 2024 23:30:07 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 435CC3F706B;
	Sat, 13 Apr 2024 23:29:57 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2] octeontx2-pf: Add support for offload tc with skbedit mark action
Date: Sun, 14 Apr 2024 11:59:57 +0530
Message-ID: <20240414062957.18840-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ajxVZ__12J04ky97IpCwwpIU_w-E4OU0
X-Proofpoint-ORIG-GUID: ajxVZ__12J04ky97IpCwwpIU_w-E4OU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02

Support offloading of skbedit mark action.

For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
interface:

 # tc qdisc add dev eth2 ingress
 # tc filter add dev eth2 ingress protocol ip flower \
      dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
v1-v2: 
  -Changed mark_flows data type to refcount_t 

 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c  |  2 ++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  2 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c |  1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  |  3 +++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h  |  3 +++
 6 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c181e7aa9eb6..150635de2bd5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1187,6 +1187,8 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			action.pf_func = target;
 			action.op = NIX_RX_ACTIONOP_UCAST;
 		}
+		if (req->match_id)
+			action.match_id = req->match_id;
 	}
 
 	entry->action = *(u64 *)&action;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index c5de3ba33e2f..24fbbef265a6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -363,6 +363,7 @@ struct otx2_flow_config {
 	struct list_head	flow_list;
 	u32			dmacflt_max_flows;
 	u16                     max_flows;
+	refcount_t		mark_flows;
 	struct list_head	flow_list_tc;
 	bool			ntuple;
 };
@@ -465,6 +466,7 @@ struct otx2_nic {
 #define OTX2_FLAG_DMACFLTR_SUPPORT		BIT_ULL(14)
 #define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
 #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
+#define OTX2_FLAG_TC_MARK_ENABLED		BIT_ULL(17)
 	u64			flags;
 	u64			*cq_op_addr;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 97a71e9b8563..bc5819237ed7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -252,6 +252,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 
 	pfvf->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
 
+	refcount_set(&flow_cfg->mark_flows, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 87bdb93cb066..8b8ac179f3c3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -511,7 +511,15 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 			nr_police++;
 			break;
 		case FLOW_ACTION_MARK:
+			if (act->mark & ~OTX2_RX_MATCH_ID_MASK) {
+				NL_SET_ERR_MSG_MOD(extack, "Bad flow mark, only 16 bit supported");
+				return -EOPNOTSUPP;
+			}
 			mark = act->mark;
+			req->match_id = mark & 0xFFFFULL;
+			req->op = NIX_RX_ACTION_DEFAULT;
+			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
+			refcount_inc(&nic->flow_cfg->mark_flows);
 			break;
 
 		case FLOW_ACTION_RX_QUEUE_MAPPING:
@@ -1184,6 +1192,11 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		return -EINVAL;
 	}
 
+	/* Disable TC MARK flag if they are no rules with skbedit mark action */
+	if (flow_node->req.match_id)
+		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
+			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
+
 	if (flow_node->is_act_police) {
 		__clear_bit(flow_node->rq, &nic->rq_bmap);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index f828d32737af..a16e9f244117 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -380,6 +380,9 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	if (pfvf->netdev->features & NETIF_F_RXCSUM)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
+		skb->mark = parse->match_id;
+
 	skb_mark_for_recycle(skb);
 
 	napi_gro_frags(napi);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index a82ffca8ce1b..3f1d2655ff77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -62,6 +62,9 @@
 #define CQ_OP_STAT_OP_ERR       63
 #define CQ_OP_STAT_CQ_ERR       46
 
+/* Packet mark mask */
+#define OTX2_RX_MATCH_ID_MASK 0x0000ffff
+
 struct queue_stats {
 	u64	bytes;
 	u64	pkts;
-- 
2.25.1


