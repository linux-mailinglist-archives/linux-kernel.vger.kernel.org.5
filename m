Return-Path: <linux-kernel+bounces-36484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA983A18C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89996B25027
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33E13AD4;
	Wed, 24 Jan 2024 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UADe997R"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCCF9C6;
	Wed, 24 Jan 2024 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075434; cv=none; b=OZqDg+q6yynSe+mERtsrMADnUigZmH9KIWjzhSv72wlwPPLIOucWLivWt0ZkKoCpKYOrpwqmtOmbYIDYnUs38ja4WGMP//USNbx0MDa3Lo24dyVjZjusCSd40Lr3FLPMphxjZmHQsVzhaef3RsIhbtt+rxymxFViyVmv6xp4DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075434; c=relaxed/simple;
	bh=Xv16iTWK43f0i6buNki9Nsw1W+Qdc6OLxNda53h2Vpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9jIkeYJctxTIRIOzjg54PwjWCSoAX0feeV8Ca6/cTMq2DixgRXbnJ7L9KtkS5DTyQmM5BXjkfO2+SwNScMhI6CDM6uPoxNyUeuo2jBHzfT5Efbf5E3jBMqeBCQ1QrurqcIKz0UUeXagr4Qe2qM41Zxv0+QRzU7SWhYPpfLWkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UADe997R; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NKRYL6008065;
	Tue, 23 Jan 2024 21:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=QB6/j3i7ludgijL5bkwgN
	g9kGXBHJDeRwaO71m0rCs4=; b=UADe997RRSR1jyb6S/P/8li19trxj+7H9gqM+
	stW0Y0hpTBHcdGpakqpuPKYs6loGzsT6Q56vB7IdHxYe28+pvjThCHHL7FpEjn+x
	R1scBxD9rMXxj8/w6wZsGoFqqWMNdOPU1+4fmIQnPFwDi+Gtk2+qAT83+OrgOg73
	PZgjIjZaose3mqYz9nupijPaVb+60ZUxrPqV0jwQDy6FFFVMbvwZdPZJT2VjDfGq
	o7msUpxLPi7ZhbmUgkA9mi2r6ZZ2X0t50F0WUJ3DhB10lyue4M/jLZoSzUqfkqJ+
	n/nno90o9JzE+LnIC9kpGoLg+6wuAk/pA3pVJdWVbC3WRluKA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vtmgvhfj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 21:50:24 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 21:50:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 23 Jan 2024 21:50:22 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 326CF5B694D;
	Tue, 23 Jan 2024 21:50:18 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 1/3] octeontx2-af: Create BPIDs free pool
Date: Wed, 24 Jan 2024 11:20:12 +0530
Message-ID: <20240124055014.32694-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124055014.32694-1-gakula@marvell.com>
References: <20240124055014.32694-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SdsQyK8U4v7Q8SpDWJvFib8RUnorJyeX
X-Proofpoint-GUID: SdsQyK8U4v7Q8SpDWJvFib8RUnorJyeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

Current code reserves 64 bpids for 64 LBK channels. But in most
of the cases multiple LBK channels uses same bpid. This leads
to inefficient use of bpids. Latest HW support configured multiple
bpids per channel for other interface types (CGX). For better use
of these bpids, this patch creates pool of free bpids from reserved
LBK bpids. This free pool is used to allocate bpid on request for
another interface like sso etc.

This patch also reduces the number of bpids for cgx interfaces to 8
and adds proper error code

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 163 ++++++++++++++----
 4 files changed, 146 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index edeb0f737312..a67187f3c79d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -837,6 +837,8 @@ enum nix_af_status {
 	NIX_AF_ERR_CQ_CTX_WRITE_ERR  = -429,
 	NIX_AF_ERR_AQ_CTX_RETRY_WRITE  = -430,
 	NIX_AF_ERR_LINK_CREDITS  = -431,
+	NIX_AF_ERR_INVALID_BPID         = -434,
+	NIX_AF_ERR_INVALID_BPID_REQ     = -435,
 	NIX_AF_ERR_INVALID_MCAST_GRP	= -436,
 	NIX_AF_ERR_INVALID_MCAST_DEL_REQ = -437,
 	NIX_AF_ERR_NON_CONTIG_MCE_LIST = -438,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 5c1d04a3c559..7048167707d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2618,6 +2618,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	 * 3. Cleanup pools (NPA)
 	 */
 
+	/* Free allocated BPIDs */
+	rvu_nix_flr_free_bpids(rvu, pcifunc);
+
 	/* Free multicast/mirror node associated with the 'pcifunc' */
 	rvu_nix_mcast_flr_free_entries(rvu, pcifunc);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 43be37dd1f32..6971f441c22b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -288,6 +288,16 @@ enum rvu_pfvf_flags {
 
 #define RVU_CLEAR_VF_PERM  ~GENMASK(PF_SET_VF_TRUSTED, PF_SET_VF_MAC)
 
+struct nix_bp {
+	struct rsrc_bmap bpids; /* free bpids bitmap */
+	u16 cgx_bpid_cnt;
+	u16 sdp_bpid_cnt;
+	u16 free_pool_base;
+	u16 *fn_map; /* pcifunc mapping */
+	u8 *intf_map;  /* interface type map */
+	u8 *ref_cnt;
+};
+
 struct nix_txsch {
 	struct rsrc_bmap schq;
 	u8   lvl;
@@ -363,6 +373,7 @@ struct nix_hw {
 	struct nix_lso lso;
 	struct nix_txvlan txvlan;
 	struct nix_ipolicer *ipolicer;
+	struct nix_bp bp;
 	u64    *tx_credits;
 	u8	cc_mcs_cnt;
 };
@@ -873,6 +884,7 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
 				u32 mcast_grp_idx);
 int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 				    u32 mcast_grp_idx, u16 mcam_index);
+void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 66203a90f052..e1eae16b09b3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -499,14 +499,84 @@ static void nix_interface_deinit(struct rvu *rvu, u16 pcifunc, u8 nixlf)
 	rvu_cgx_disable_dmac_entries(rvu, pcifunc);
 }
 
+#define NIX_BPIDS_PER_LMAC	8
+#define NIX_BPIDS_PER_CPT	1
+static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int blkaddr)
+{
+	struct nix_bp *bp = &hw->bp;
+	int err, max_bpids;
+	u64 cfg;
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
+	max_bpids = (cfg >> 12) & 0xFFF;
+
+	/* Reserve the BPIds for CGX and SDP */
+	bp->cgx_bpid_cnt = rvu->hw->cgx_links * NIX_BPIDS_PER_LMAC;
+	bp->sdp_bpid_cnt = rvu->hw->sdp_links * (cfg & 0xFFF);
+	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
+			     NIX_BPIDS_PER_CPT;
+	bp->bpids.max = max_bpids - bp->free_pool_base;
+
+	err = rvu_alloc_bitmap(&bp->bpids);
+	if (err)
+		return err;
+
+	bp->fn_map = devm_kcalloc(rvu->dev, bp->bpids.max,
+				  sizeof(u16), GFP_KERNEL);
+	if (!bp->fn_map)
+		return -ENOMEM;
+
+	bp->intf_map = devm_kcalloc(rvu->dev, bp->bpids.max,
+				    sizeof(u8), GFP_KERNEL);
+	if (!bp->intf_map)
+		return -ENOMEM;
+
+	bp->ref_cnt = devm_kcalloc(rvu->dev, bp->bpids.max,
+				   sizeof(u8), GFP_KERNEL);
+	if (!bp->ref_cnt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
+{
+	int blkaddr, bpid, err;
+	struct nix_hw *nix_hw;
+	struct nix_bp *bp;
+
+	if (!is_afvf(pcifunc))
+		return;
+
+	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return;
+
+	bp = &nix_hw->bp;
+
+	mutex_lock(&rvu->rsrc_lock);
+	for (bpid = 0; bpid < bp->bpids.max; bpid++) {
+		if (bp->fn_map[bpid] == pcifunc) {
+			bp->ref_cnt[bpid]--;
+			if (bp->ref_cnt[bpid])
+				continue;
+			rvu_free_rsrc(&bp->bpids, bpid);
+			bp->fn_map[bpid] = 0;
+		}
+	}
+	mutex_unlock(&rvu->rsrc_lock);
+}
+
 int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 				    struct nix_bp_cfg_req *req,
 				    struct msg_rsp *rsp)
 {
 	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, pf, type, err;
+	u16 chan_base, chan, bpid;
 	struct rvu_pfvf *pfvf;
-	int blkaddr, pf, type;
-	u16 chan_base, chan;
+	struct nix_hw *nix_hw;
+	struct nix_bp *bp;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -515,13 +585,29 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 		return 0;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
-	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
 
+	bp = &nix_hw->bp;
 	chan_base = pfvf->rx_chan_base + req->chan_base;
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
 		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
 			    cfg & ~BIT_ULL(16));
+
+		if (type == NIX_INTF_TYPE_LBK) {
+			bpid = cfg & GENMASK(8, 0);
+			mutex_lock(&rvu->rsrc_lock);
+			rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
+			for (bpid = 0; bpid < bp->bpids.max; bpid++) {
+				if (bp->fn_map[bpid] == pcifunc) {
+					bp->fn_map[bpid] = 0;
+					bp->ref_cnt[bpid] = 0;
+				}
+			}
+			mutex_unlock(&rvu->rsrc_lock);
+		}
 	}
 	return 0;
 }
@@ -529,25 +615,20 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 			    int type, int chan_id)
 {
-	int bpid, blkaddr, lmac_chan_cnt, sdp_chan_cnt;
-	u16 cgx_bpid_cnt, lbk_bpid_cnt, sdp_bpid_cnt;
+	int bpid, blkaddr, sdp_chan_base, err;
 	struct rvu_hwinfo *hw = rvu->hw;
 	struct rvu_pfvf *pfvf;
+	struct nix_hw *nix_hw;
 	u8 cgx_id, lmac_id;
-	u64 cfg;
+	struct nix_bp *bp;
 
-	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, req->hdr.pcifunc);
-	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST);
-	lmac_chan_cnt = cfg & 0xFF;
-
-	cgx_bpid_cnt = hw->cgx_links * lmac_chan_cnt;
-	lbk_bpid_cnt = hw->lbk_links * ((cfg >> 16) & 0xFF);
+	pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
 
-	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
-	sdp_chan_cnt = cfg & 0xFFF;
-	sdp_bpid_cnt = hw->sdp_links * sdp_chan_cnt;
+	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
 
-	pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	bp = &nix_hw->bp;
 
 	/* Backpressure IDs range division
 	 * CGX channles are mapped to (0 - 191) BPIDs
@@ -561,38 +642,48 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 	 */
 	switch (type) {
 	case NIX_INTF_TYPE_CGX:
-		if ((req->chan_base + req->chan_cnt) > 16)
-			return -EINVAL;
+		if ((req->chan_base + req->chan_cnt) > NIX_BPIDS_PER_LMAC)
+			return NIX_AF_ERR_INVALID_BPID_REQ;
 		rvu_get_cgx_lmac_id(pfvf->cgx_lmac, &cgx_id, &lmac_id);
 		/* Assign bpid based on cgx, lmac and chan id */
-		bpid = (cgx_id * hw->lmac_per_cgx * lmac_chan_cnt) +
-			(lmac_id * lmac_chan_cnt) + req->chan_base;
+		bpid = (cgx_id * hw->lmac_per_cgx * NIX_BPIDS_PER_LMAC) +
+			(lmac_id * NIX_BPIDS_PER_LMAC) + req->chan_base;
 
 		if (req->bpid_per_chan)
 			bpid += chan_id;
-		if (bpid > cgx_bpid_cnt)
-			return -EINVAL;
+		if (bpid > bp->cgx_bpid_cnt)
+			return NIX_AF_ERR_INVALID_BPID;
 		break;
 
 	case NIX_INTF_TYPE_LBK:
-		if ((req->chan_base + req->chan_cnt) > 63)
-			return -EINVAL;
-		bpid = cgx_bpid_cnt + req->chan_base;
-		if (req->bpid_per_chan)
-			bpid += chan_id;
-		if (bpid > (cgx_bpid_cnt + lbk_bpid_cnt))
-			return -EINVAL;
+		/* Alloc bpid from the free pool */
+		mutex_lock(&rvu->rsrc_lock);
+		bpid = rvu_alloc_rsrc(&bp->bpids);
+		if (bpid < 0) {
+			mutex_unlock(&rvu->rsrc_lock);
+			return NIX_AF_ERR_INVALID_BPID;
+		}
+		bp->fn_map[bpid] = req->hdr.pcifunc;
+		bp->ref_cnt[bpid]++;
+		bpid += bp->free_pool_base;
+		mutex_unlock(&rvu->rsrc_lock);
 		break;
 	case NIX_INTF_TYPE_SDP:
-		if ((req->chan_base + req->chan_cnt) > 255)
-			return -EINVAL;
+		if ((req->chan_base + req->chan_cnt) > bp->sdp_bpid_cnt)
+			return NIX_AF_ERR_INVALID_BPID_REQ;
+
+		/* Handle usecase of 2 SDP blocks */
+		if (!hw->cap.programmable_chans)
+			sdp_chan_base = pfvf->rx_chan_base - NIX_CHAN_SDP_CH_START;
+		else
+			sdp_chan_base = pfvf->rx_chan_base - hw->sdp_chan_base;
 
-		bpid = sdp_bpid_cnt + req->chan_base;
+		bpid = bp->cgx_bpid_cnt + req->chan_base + sdp_chan_base;
 		if (req->bpid_per_chan)
 			bpid += chan_id;
 
-		if (bpid > (cgx_bpid_cnt + lbk_bpid_cnt + sdp_bpid_cnt))
-			return -EINVAL;
+		if (bpid > (bp->cgx_bpid_cnt + bp->sdp_bpid_cnt))
+			return NIX_AF_ERR_INVALID_BPID;
 		break;
 	default:
 		return -EINVAL;
@@ -4784,6 +4875,10 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 		if (err)
 			return err;
 
+		err = nix_setup_bpids(rvu, nix_hw, blkaddr);
+		if (err)
+			return err;
+
 		/* Configure segmentation offload formats */
 		nix_setup_lso(rvu, nix_hw, blkaddr);
 
-- 
2.25.1


