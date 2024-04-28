Return-Path: <linux-kernel+bounces-161389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E588B4B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08861F21932
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1575657D2;
	Sun, 28 Apr 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bj0gNQJa"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D758129;
	Sun, 28 Apr 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301638; cv=none; b=uGcar21z5vPmfhNlabPSL80O4GYlGybFjcuGA9mkYSgFtytDZHtlKDuK8RQdUISla3t5G3LILzIzQzs1nFD4V4M1rxib0kU9tNyxXstHWyFF43Hyg4AVj8cAa0ds0ciHqiwOVOGrzTNoD8r3Z4WlfUkC9LRnZ4yUjEU8maU9XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301638; c=relaxed/simple;
	bh=oNFcKezmIEU3QHhDD5oM0O0YDe9cWZmihhvKSdKKbG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOORhZEJy8+YWSy3iPC5vPnwPv5z9nofeyc5arK5pBXhCg3Zfv2YMcBKbBik1ECT1szFSWygC/KJ9W/+WTqzdIlUbEIxUeRrLNRwXBsYCBwIBgDxHyTQeYRbnxPPF5bAwjJgE8xHS/NEfATOjgSpN6yikcMqEPzrKMyYjwuk1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bj0gNQJa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43SAlKn3006758;
	Sun, 28 Apr 2024 03:53:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=un0a8PfYbfYYolPP/4LUg
	JUqL0Sr2+8r9ADsxx5w0I8=; b=bj0gNQJaYF9yakVXDHbsDb+vTPLOk/1R2FyVa
	+Anpt2QCxMrCDSHF9GhVT4gAiSn1jkyni5zzH7wtjd/2X/hVvZFhNZxreq5QqQCl
	ZGXuk6or9ORU7m2l4zuwezm+v8BZvYsefkXgw6Hth0Ynl4b8BRQWCt+IpT4WAteT
	jcdySMMIzkgbVpmQMQgU1b6OeH09skqJROruM+PgNUZXcO0Dp4Ofw2T88fzC8THH
	RbgLu/JFI0h5JPUgtui8/Kb9vAoOEry67DUsy3DSDVS31Xdckb/cK1++xGRqz6nN
	TOd7Egzs8aNWQjiMACXS2vShPKubOeqAMbXfcn2Ccg2yFeQPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xrxqnhv01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:53:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 28 Apr 2024 03:53:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Apr 2024 03:53:48 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 6CC8F5B6949;
	Sun, 28 Apr 2024 03:53:45 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 9/9] octeontx2-pf: Add representors for sdp MAC
Date: Sun, 28 Apr 2024 16:23:12 +0530
Message-ID: <20240428105312.9731-10-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240428105312.9731-1-gakula@marvell.com>
References: <20240428105312.9731-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: TV3CkO4VeHMZQ1loaRdk68qOQhPO3MQ4
X-Proofpoint-ORIG-GUID: TV3CkO4VeHMZQ1loaRdk68qOQhPO3MQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_07,2024-04-26_02,2023-05-22_02

Hardware supports different types of MACs eg RPM, SDP, LBK.
LBK is for internal Tx->Rx HW loopback path. RPM and SDP MACs support
ingress/egress pkt IO on interfaces with different set of capabilities
like interface modes. At the time of netdev driver registration PF will
seek MAC related information from Admin function driver
'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
queues etc such that pkt IO on the channels of these different MACs is
possible. This patch add representors for SDP MAC.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 47 ++++++++++++++-----
 .../marvell/octeontx2/nic/otx2_common.h       | 26 +++++++---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 13 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 11 ++++-
 7 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index c1c99d7054f8..777e123e69c7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -72,7 +72,7 @@ int cn10k_lmtst_init(struct otx2_nic *pfvf)
 }
 EXPORT_SYMBOL(cn10k_lmtst_init);
 
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
 {
 	struct nix_cn10k_aq_enq_req *aq;
 	struct otx2_nic *pfvf = dev;
@@ -88,7 +88,7 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 	aq->sq.ena = 1;
 	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
 	aq->sq.smq_rr_weight = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
-	aq->sq.default_chan = pfvf->hw.tx_chan_base;
+	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
 	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
 	aq->sq.sqb_aura = sqb_aura;
 	aq->sq.sq_int_ena = NIX_SQINT_BITS;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
index c1861f7de254..e3f0bce9908f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
@@ -26,7 +26,7 @@ static inline int mtu_to_dwrr_weight(struct otx2_nic *pfvf, int mtu)
 
 int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx);
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
 int cn10k_lmtst_init(struct otx2_nic *pfvf);
 int cn10k_free_all_ipolicers(struct otx2_nic *pfvf);
 int cn10k_alloc_matchall_ipolicer(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 4b53af087cb4..f0f0d18ab302 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -253,7 +253,7 @@ int otx2_config_pause_frm(struct otx2_nic *pfvf)
 	struct cgx_pause_frm_cfg *req;
 	int err;
 
-	if (is_otx2_lbkvf(pfvf->pdev))
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev))
 		return 0;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -647,12 +647,21 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->reg[2] = NIX_AF_MDQX_SCHEDULE(schq);
 		req->regval[2] =  dwrr_val;
 	} else if (lvl == NIX_TXSCH_LVL_TL4) {
+		int sdp_chan =  hw->tx_chan_base + prio;
+
+		if (is_otx2_sdp_rep(pfvf->pdev))
+			prio = 0;
 		parent = schq_list[NIX_TXSCH_LVL_TL3][prio];
 		req->reg[0] = NIX_AF_TL4X_PARENT(schq);
 		req->regval[0] = parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL4X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
+		if (is_otx2_sdp_rep(pfvf->pdev)) {
+			req->num_regs++;
+			req->reg[2] = NIX_AF_TL4X_SDP_LINK_CFG(schq);
+			req->regval[2] = BIT_ULL(12) | BIT_ULL(13) | (sdp_chan & 0xff);
+		}
 	} else if (lvl == NIX_TXSCH_LVL_TL3) {
 		parent = schq_list[NIX_TXSCH_LVL_TL2][prio];
 		req->reg[0] = NIX_AF_TL3X_PARENT(schq);
@@ -660,7 +669,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL3X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
-		if (lvl == hw->txschq_link_cfg_lvl) {
+		if (lvl == hw->txschq_link_cfg_lvl && !is_otx2_sdp_rep(pfvf->pdev)) {
 			req->num_regs++;
 			req->reg[2] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, hw->tx_link);
 			/* Enable this queue and backpressure
@@ -677,7 +686,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
 		req->regval[1] = TXSCH_TL1_DFLT_RR_PRIO << 24 | dwrr_val;
 
-		if (lvl == hw->txschq_link_cfg_lvl) {
+		if (lvl == hw->txschq_link_cfg_lvl && !is_otx2_sdp_rep(pfvf->pdev)) {
 			req->num_regs++;
 			req->reg[2] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, hw->tx_link);
 			/* Enable this queue and backpressure
@@ -736,6 +745,7 @@ EXPORT_SYMBOL(otx2_smq_flush);
 
 int otx2_txsch_alloc(struct otx2_nic *pfvf)
 {
+	int chan_cnt = pfvf->hw.tx_chan_cnt;
 	struct nix_txsch_alloc_req *req;
 	struct nix_txsch_alloc_rsp *rsp;
 	int lvl, schq, rc;
@@ -748,6 +758,12 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 	/* Request one schq per level */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
 		req->schq[lvl] = 1;
+
+	if (is_otx2_sdp_rep(pfvf->pdev) && chan_cnt > 1) {
+		req->schq[NIX_TXSCH_LVL_SMQ] = chan_cnt;
+		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
+	}
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
@@ -758,10 +774,12 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		return PTR_ERR(rsp);
 
 	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		pfvf->hw.txschq_cnt[lvl] = rsp->schq[lvl];
 		for (schq = 0; schq < rsp->schq[lvl]; schq++)
 			pfvf->hw.txschq_list[lvl][schq] =
 				rsp->schq_list[lvl][schq];
+	}
 
 	pfvf->hw.txschq_link_cfg_lvl = rsp->link_cfg_lvl;
 	pfvf->hw.txschq_aggr_lvl_rr_prio = rsp->aggr_lvl_rr_prio;
@@ -799,12 +817,15 @@ EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
-	int lvl, schq;
+	int lvl, schq, idx;
 
 	/* free non QOS TLx nodes */
-	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
-		otx2_txschq_free_one(pfvf, lvl,
-				     pfvf->hw.txschq_list[lvl][0]);
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		for (idx = 0; idx < pfvf->hw.txschq_cnt[lvl]; idx++) {
+			otx2_txschq_free_one(pfvf, lvl,
+					     pfvf->hw.txschq_list[lvl][idx]);
+		}
+	}
 
 	/* Clear the txschq list */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
@@ -884,7 +905,7 @@ static int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
 
-int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
+int otx2_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
 {
 	struct otx2_nic *pfvf = dev;
 	struct otx2_snd_queue *sq;
@@ -903,7 +924,7 @@ int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 	aq->sq.ena = 1;
 	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
 	aq->sq.smq_rr_quantum = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
-	aq->sq.default_chan = pfvf->hw.tx_chan_base;
+	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
 	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
 	aq->sq.sqb_aura = sqb_aura;
 	aq->sq.sq_int_ena = NIX_SQINT_BITS;
@@ -926,6 +947,7 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	struct otx2_qset *qset = &pfvf->qset;
 	struct otx2_snd_queue *sq;
 	struct otx2_pool *pool;
+	u8 chan_offset;
 	int err;
 
 	pool = &pfvf->qset.pool[sqb_aura];
@@ -972,7 +994,8 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	sq->stats.bytes = 0;
 	sq->stats.pkts = 0;
 
-	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	chan_offset = qidx % pfvf->hw.tx_chan_cnt;
+	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, chan_offset, sqb_aura);
 	if (err) {
 		kfree(sq->sg);
 		sq->sg = NULL;
@@ -1739,6 +1762,8 @@ void mbox_handler_nix_lf_alloc(struct otx2_nic *pfvf,
 	pfvf->hw.sqb_size = rsp->sqb_size;
 	pfvf->hw.rx_chan_base = rsp->rx_chan_base;
 	pfvf->hw.tx_chan_base = rsp->tx_chan_base;
+	pfvf->hw.rx_chan_cnt = rsp->rx_chan_cnt;
+	pfvf->hw.tx_chan_cnt = rsp->tx_chan_cnt;
 	pfvf->hw.lso_tsov4_idx = rsp->lso_tsov4_idx;
 	pfvf->hw.lso_tsov6_idx = rsp->lso_tsov6_idx;
 	pfvf->hw.cgx_links = rsp->cgx_links;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index d3d56ca6d3a2..910144fbf244 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -42,6 +42,8 @@
 #define PCI_SUBSYS_DEVID_96XX_RVU_PFVF		0xB200
 #define PCI_SUBSYS_DEVID_CN10K_B_RVU_PFVF	0xBD00
 
+#define PCI_DEVID_OCTEONTX2_SDP_REP		0xA0F7
+
 /* PCI BAR nos */
 #define PCI_CFG_REG_BAR_NUM                     2
 #define PCI_MBOX_BAR_NUM                        4
@@ -198,6 +200,7 @@ struct otx2_hw {
 
 	/* NIX */
 	u8			txschq_link_cfg_lvl;
+	u8			txschq_cnt[NIX_TXSCH_LVL_CNT];
 	u8			txschq_aggr_lvl_rr_prio;
 	u16			txschq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16			matchall_ipolicer;
@@ -208,6 +211,8 @@ struct otx2_hw {
 	/* HW settings, coalescing etc */
 	u16			rx_chan_base;
 	u16			tx_chan_base;
+	u8			rx_chan_cnt;
+	u8			tx_chan_cnt;
 	u16			cq_qcount_wait;
 	u16			cq_ecount_wait;
 	u16			rq_skid;
@@ -344,7 +349,7 @@ struct otx2_flow_config {
 };
 
 struct dev_hw_ops {
-	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
+	int	(*sq_aq_init)(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
 	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
@@ -538,6 +543,11 @@ static inline bool is_96xx_B0(struct pci_dev *pdev)
 		(pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX_RVU_PFVF);
 }
 
+static inline bool is_otx2_sdp_rep(struct pci_dev *pdev)
+{
+	return pdev->device == PCI_DEVID_OCTEONTX2_SDP_REP;
+}
+
 /* REVID for PCIe devices.
  * Bits 0..1: minor pass, bit 3..2: major pass
  * bits 7..4: midr id
@@ -900,15 +910,19 @@ static inline void otx2_dma_unmap_page(struct otx2_nic *pfvf,
 static inline u16 otx2_get_smq_idx(struct otx2_nic *pfvf, u16 qidx)
 {
 	u16 smq;
+	int idx;
+
 #ifdef CONFIG_DCB
 	if (qidx < NIX_PF_PFC_PRIO_MAX && pfvf->pfc_alloc_status[qidx])
 		return pfvf->pfc_schq_list[NIX_TXSCH_LVL_SMQ][qidx];
 #endif
 	/* check if qidx falls under QOS queues */
-	if (qidx >= pfvf->hw.non_qos_queues)
+	if (qidx >= pfvf->hw.non_qos_queues) {
 		smq = pfvf->qos.qid_to_sqmap[qidx - pfvf->hw.non_qos_queues];
-	else
-		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][0];
+	} else {
+		idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
+		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
+	}
 
 	return smq;
 }
@@ -975,8 +989,8 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
 void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int qidx);
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq);
 int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura);
-int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
+int otx2_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma);
 int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 301ecb2b6a24..f0de7dfbd288 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1593,10 +1593,15 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	}
 
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
-		err = otx2_txschq_config(pf, lvl, 0, false);
-		if (err) {
-			mutex_unlock(&mbox->lock);
-			goto err_free_nix_queues;
+		int idx;
+
+		for (idx = 0; idx < pf->hw.txschq_cnt[lvl]; idx++) {
+			err = otx2_txschq_config(pf, lvl, idx, false);
+			if (err) {
+				dev_err(pf->dev, "Failed to config TXSCH\n");
+				mutex_unlock(&mbox->lock);
+				goto err_free_nix_queues;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 45a32e4b49d1..defcb9ea21e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -140,6 +140,7 @@
 
 /* NIX AF transmit scheduler registers */
 #define NIX_AF_SMQX_CFG(a)		(0x700 | (a) << 16)
+#define NIX_AF_TL4X_SDP_LINK_CFG(a)	(0xB10 | (a) << 16)
 #define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (a) << 16)
 #define NIX_AF_TL1X_CIR(a)		(0xC20 | (a) << 16)
 #define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (a) << 16)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 048f9a744542..fd093c4c3289 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -21,6 +21,7 @@
 static const struct pci_device_id otx2_vf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_AFVF) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_VF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_SDP_REP) },
 	{ }
 };
 
@@ -371,7 +372,7 @@ static int otx2vf_open(struct net_device *netdev)
 
 	/* LBKs do not receive link events so tell everyone we are up here */
 	vf = netdev_priv(netdev);
-	if (is_otx2_lbkvf(vf->pdev)) {
+	if (is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev)) {
 		pr_info("%s NIC Link is UP\n", netdev->name);
 		netif_carrier_on(netdev);
 		netif_tx_start_all_queues(netdev);
@@ -683,6 +684,14 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
 	}
 
+	if (is_otx2_sdp_rep(vf->pdev)) {
+		int n;
+
+		n = (vf->pcifunc >> RVU_PFVF_FUNC_SHIFT) & RVU_PFVF_FUNC_MASK;
+		n -= 1;
+		snprintf(netdev->name, sizeof(netdev->name), "sdp%d-%d", pdev->bus->number, n);
+	}
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-- 
2.25.1


