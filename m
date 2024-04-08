Return-Path: <linux-kernel+bounces-134899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E630A89B862
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123811C21F75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7825624;
	Mon,  8 Apr 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cZUQlKLt"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01525760;
	Mon,  8 Apr 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561216; cv=none; b=qLwsRWUzgSYmLJZcyA1r6fzauwHiCKCfoF6MfsTOyYc4c3in/45XgaeZuA7iTxykrt5EWN7ZSTbr8fS+KIkm2OCPE/3WEgn8W2LgZ8nIU2hV7vfapEUnFo/eY3930A5NepDuvnnIC30gQ7xDYb9sas5GytWpK+28RpQ/GuVVpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561216; c=relaxed/simple;
	bh=rXoFAdo1tTS0PjGUrKhn6mS1KcUdpcQU1e2XnCLLWNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+LNkOa68P0zKO3FLiIVCbt8zMWYD5QgbntP5nrGoFue7Lf6PUSJJno3dsPg8kPzqg/xrezJScAcqjpkFKZx9e5jw1ClUOCT0qyXdvcN8a/h+k5cckNSDNy2FKnZPmeWg7p6Argji3RkcY9Y2uOr0CauQiTHAlz3tjc9P6NP6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cZUQlKLt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437MmxQn020481;
	Mon, 8 Apr 2024 00:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=6sU5GxlK76ndUKi2361U/O6LtYlGS3aaQIWSH2fN1ig=; b=cZU
	QlKLtSznz32i401snNT/U8oPTFe0ZKXTsVFaVwTYpCNgYEAaRLg37AJKdkOvmwLL
	GjikeTZX7lb3bW9OeWT6DEeNI+vjXiaIZGw3ehg73MiNATxaTHGeFJlh3zb3uGHt
	0TwR50ISx3QOvoerYNhsOQWjGDUcrCkc5MlzlsV/+rMmzbhIHEubdnnPNooKPJyG
	z+FVU033hDFv2ZQ21B34fbFSU0hRbBTtxIdNxo6XEqs6iUdzuPLgUB4HG+HPjiE/
	7wLMDx5ipGWdthVAr1czDASc8A/tItF2VdQlh+f8Pa549vptZn+SDh5oqeGvDw6+
	g+Rk56CbZbcT/erpPtg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xbdd4b44a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 00:26:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Apr 2024 00:26:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Apr 2024 00:26:43 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 010203F70C8;
	Mon,  8 Apr 2024 00:26:39 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add support for offload tc with skbedit mark action
Date: Mon, 8 Apr 2024 12:56:38 +0530
Message-ID: <20240408072638.26674-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mmLFfOFjflRvFx5rlpVuQ519ACqI2HvK
X-Proofpoint-GUID: mmLFfOFjflRvFx5rlpVuQ519ACqI2HvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_05,2024-04-05_02,2023-05-22_02

Support offloading of skbedit mark action.

For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
interface:

 # tc qdisc add dev eth2 ingress
 # tc filter add dev eth2 ingress protocol ip flower \
      dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c  |  2 ++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  2 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  |  3 +++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h  |  3 +++
 5 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c75669c8fde7..6188921e9a20 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1183,6 +1183,8 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			action.pf_func = target;
 			action.op = NIX_RX_ACTIONOP_UCAST;
 		}
+		if (req->match_id)
+			action.match_id = req->match_id;
 	}
 
 	entry->action = *(u64 *)&action;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 06910307085e..815ae13c371c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -363,6 +363,7 @@ struct otx2_flow_config {
 	struct list_head	flow_list;
 	u32			dmacflt_max_flows;
 	u16                     max_flows;
+	u16			mark_flows;
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
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 4fd44b6eecea..fd1d78601811 100644
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
+			nic->flow_cfg->mark_flows++;
 			break;
 
 		case FLOW_ACTION_RX_QUEUE_MAPPING:
@@ -1173,6 +1181,11 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		return -EINVAL;
 	}
 
+	/* Disable TC MARK flag if they are no rules with skbedit mark action */
+	if (flow_node->req.match_id)
+		if (!(--flow_cfg->mark_flows))
+			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
+
 	if (flow_node->is_act_police) {
 		__clear_bit(flow_node->rq, &nic->rq_bmap);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 4d519ea833b2..d3c9759c9f06 100644
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


