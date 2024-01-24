Return-Path: <linux-kernel+bounces-36485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F375883A18E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E642D1C21CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100D168AC;
	Wed, 24 Jan 2024 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M8SnBZqy"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1312E70;
	Wed, 24 Jan 2024 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075437; cv=none; b=rEhSvjxTbnHXdJEdemLvWtlj9ov8/3OXgv2E8WYTXLDG/9kqrzPh/zC2sXQ/zr1FddfbnsaNFHXReRdm82mKFEByeQ+86YYY8sXI+qYOs1aeCCivABckVYibtD/cN+a6CnVTfD2mqBtGCBovJiRw4U/wFiUO7b76VR+URb9UAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075437; c=relaxed/simple;
	bh=QzxVtSkeD27/YQ1X/opGqaginqKDfJ0ZpbuK7gj4QlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqvBwvt65xnE1I+wO8vj5McmMlpmsn5SsfW1nLpWA+VGiFKE6hh14rSfMPw+iZsp+7KBF0/+ePIUHeIhYEb/nWZlZIp1pv6/1mPkKYAoCcqjp6yXOYE3NlofCCnSrK8RCLUUiAABdPQyRkSaPJMAJbq//PmYLtMMCJfV6Z4HJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M8SnBZqy; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NKRYL7008065;
	Tue, 23 Jan 2024 21:50:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=/VzruZHTcYl/mbeKh+3Jx
	47BmX9tnpRjw7CK+jlfGco=; b=M8SnBZqyoaHWsNpttybIxOMWbSbHM8beNWCQ+
	9DDB1TZRETIuc+uaCo1kj0lW593R7G8OMeB9kFF6t6/0AfGDGJokUPOG2RyuZz51
	MIQg1tt118DuKDLMXwKgSXRob/ve146utM9yY4Qi9MMdz4U83NYC/JyWx4Yw/PGg
	G6ghQBt3WN4FbTtYANMCkFTjl4F/KoBhED2JN2z0kQIJm4O40n698S/73bhEt4SP
	R2kMgTLA8BqUF+wbNr7GjUKXsHxTM0THU//+Sk3XzgLgAhxnqu1EsPJJp/i3KTr7
	x1QgBo//jK3Yui0efM/wIc/rz1S4iw7GZsdb9IUW6AgdGlyCw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vtmgvhfjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 21:50:28 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 21:50:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 23 Jan 2024 21:50:25 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B8A023F7081;
	Tue, 23 Jan 2024 21:50:22 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 2/3] octeontx2-af: Add mbox to alloc/free BPIDs
Date: Wed, 24 Jan 2024 11:20:13 +0530
Message-ID: <20240124055014.32694-3-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: 3k4_yjJjM1kWEMDZis4bEwpXNR5rAws2
X-Proofpoint-GUID: 3k4_yjJjM1kWEMDZis4bEwpXNR5rAws2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

Adds mbox handlers to allocate/free BPIDs from the free BPIDs pool.
This can be used by the PF/VF to request up to 8 BPIds.
Also adds a mbox handler to configure NIXX_AF_RX_CHANX with multiple
Bpids.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/common.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  30 +++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 212 ++++++++++++++++--
 3 files changed, 228 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 2436c1ff9ba4..e4f9ae00f3b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -189,6 +189,7 @@ enum nix_scheduler {
 #define NIX_INTF_TYPE_CGX		0
 #define NIX_INTF_TYPE_LBK		1
 #define NIX_INTF_TYPE_SDP		2
+#define NIX_INTF_TYPE_CPT		3
 
 #define MAX_LMAC_PKIND			12
 #define NIX_LINK_CGX_LMAC(a, b)		(0 + 4 * (a) + (b))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a67187f3c79d..bf3e75e3ee71 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -302,8 +302,15 @@ M(NIX_BANDPROF_FREE,	0x801e, nix_bandprof_free, nix_bandprof_free_req,   \
 				msg_rsp)				    \
 M(NIX_BANDPROF_GET_HWINFO, 0x801f, nix_bandprof_get_hwinfo, msg_req,		\
 				nix_bandprof_get_hwinfo_rsp)		    \
+M(NIX_CPT_BP_ENABLE,    0x8020, nix_cpt_bp_enable, nix_bp_cfg_req,	    \
+				nix_bp_cfg_rsp)				    \
+M(NIX_CPT_BP_DISABLE,   0x8021, nix_cpt_bp_disable, nix_bp_cfg_req,	    \
+				msg_rsp)				\
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
+M(NIX_ALLOC_BPIDS,	0x8028,	nix_alloc_bpids, nix_alloc_bpid_req, nix_bpids)	\
+M(NIX_FREE_BPIDS,	0x8029, nix_free_bpids, nix_bpids, msg_rsp)		\
+M(NIX_RX_CHAN_CFG,	0x802a, nix_rx_chan_cfg, nix_rx_chan_cfg, nix_rx_chan_cfg)	\
 M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
 				nix_mcast_grp_create_rsp)			\
 M(NIX_MCAST_GRP_DESTROY, 0x802c, nix_mcast_grp_destroy, nix_mcast_grp_destroy_req,	\
@@ -1216,6 +1223,29 @@ struct nix_bp_cfg_rsp {
 	u8	chan_cnt; /* Number of channel for which bpids are assigned */
 };
 
+struct nix_alloc_bpid_req {
+	struct mbox_msghdr hdr;
+	u8 bpid_cnt;
+	u8 type;
+	u64 rsvd;
+};
+
+struct nix_bpids {
+	struct mbox_msghdr hdr;
+	u8 bpid_cnt;
+	u16 bpids[8];
+	u64 rsvd;
+};
+
+struct nix_rx_chan_cfg {
+	struct mbox_msghdr hdr;
+	u8 type;	/* Interface type(CGX/CPT/LBK) */
+	u8 read;
+	u16 chan;	/* RX channel to be configured */
+	u64 val;	/* NIX_AF_RX_CHAN_CFG value */
+	u64 rsvd;
+};
+
 struct nix_mcast_grp_create_req {
 	struct mbox_msghdr hdr;
 #define NIX_MCAST_INGRESS	0
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index e1eae16b09b3..7b99fa272c6b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -567,16 +567,122 @@ void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
 	mutex_unlock(&rvu->rsrc_lock);
 }
 
-int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
-				    struct nix_bp_cfg_req *req,
+int rvu_mbox_handler_nix_rx_chan_cfg(struct rvu *rvu,
+				     struct nix_rx_chan_cfg *req,
+				     struct nix_rx_chan_cfg *rsp)
+{
+	struct rvu_pfvf *pfvf;
+	int blkaddr;
+	u16 chan;
+
+	pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, req->hdr.pcifunc);
+	chan = pfvf->rx_chan_base + req->chan;
+
+	if (req->type == NIX_INTF_TYPE_CPT)
+		chan = chan | BIT(11);
+
+	if (req->read) {
+		rsp->val = rvu_read64(rvu, blkaddr,
+				      NIX_AF_RX_CHANX_CFG(chan));
+		rsp->chan = req->chan;
+	} else {
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan), req->val);
+	}
+	return 0;
+}
+
+int rvu_mbox_handler_nix_alloc_bpids(struct rvu *rvu,
+				     struct nix_alloc_bpid_req *req,
+				     struct nix_bpids *rsp)
+{
+	u16 pcifunc = req->hdr.pcifunc;
+	struct nix_hw *nix_hw;
+	int blkaddr, cnt = 0;
+	struct nix_bp *bp;
+	int bpid, err;
+
+	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
+
+	bp = &nix_hw->bp;
+
+	/* For interface like sso uses same bpid across multiple
+	 * application. Find the bpid is it already allocate or
+	 * allocate a new one.
+	 */
+	mutex_lock(&rvu->rsrc_lock);
+	if (req->type > NIX_INTF_TYPE_CPT || req->type == NIX_INTF_TYPE_LBK) {
+		for (bpid = 0; bpid < bp->bpids.max; bpid++) {
+			if (bp->intf_map[bpid] == req->type) {
+				rsp->bpids[cnt] = bpid + bp->free_pool_base;
+				rsp->bpid_cnt++;
+				bp->ref_cnt[bpid]++;
+				cnt++;
+			}
+		}
+		if (rsp->bpid_cnt)
+			goto exit;
+	}
+
+	for (cnt = 0; cnt < req->bpid_cnt; cnt++) {
+		bpid = rvu_alloc_rsrc(&bp->bpids);
+		if (bpid < 0)
+			goto exit;
+		rsp->bpids[cnt] = bpid + bp->free_pool_base;
+		bp->intf_map[bpid] = req->type;
+		bp->fn_map[bpid] = pcifunc;
+		bp->ref_cnt[bpid]++;
+		rsp->bpid_cnt++;
+	}
+exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return 0;
+}
+
+int rvu_mbox_handler_nix_free_bpids(struct rvu *rvu,
+				    struct nix_bpids *req,
 				    struct msg_rsp *rsp)
+{
+	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, cnt, err, id;
+	struct nix_hw *nix_hw;
+	struct nix_bp *bp;
+	u16 bpid;
+
+	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
+
+	bp = &nix_hw->bp;
+	mutex_lock(&rvu->rsrc_lock);
+	for (cnt = 0; cnt < req->bpid_cnt; cnt++) {
+		bpid = req->bpids[cnt] - bp->free_pool_base;
+		bp->ref_cnt[bpid]--;
+		if (bp->ref_cnt[bpid])
+			continue;
+		rvu_free_rsrc(&bp->bpids, bpid);
+		for (id = 0; id < bp->bpids.max; id++) {
+			if (bp->fn_map[id] == pcifunc)
+				bp->fn_map[id] = 0;
+		}
+	}
+	mutex_unlock(&rvu->rsrc_lock);
+	return 0;
+}
+
+static int nix_bp_disable(struct rvu *rvu,
+			  struct nix_bp_cfg_req *req,
+			  struct msg_rsp *rsp, bool cpt_link)
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, pf, type, err;
-	u16 chan_base, chan, bpid;
 	struct rvu_pfvf *pfvf;
 	struct nix_hw *nix_hw;
+	u16 chan_base, chan;
 	struct nix_bp *bp;
+	u16 chan_v, bpid;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -584,6 +690,12 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
 		return 0;
 
+	if (is_sdp_pfvf(pcifunc))
+		type = NIX_INTF_TYPE_SDP;
+
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
 	if (err)
@@ -591,9 +703,27 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 
 	bp = &nix_hw->bp;
 	chan_base = pfvf->rx_chan_base + req->chan_base;
+
+	if (cpt_link) {
+		type = NIX_INTF_TYPE_CPT;
+		cfg = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(0));
+		/* MODE=0 or MODE=1 => CPT looks only channels starting from cpt chan base */
+		cfg = (cfg >> 20) & 0x3;
+		if (cfg != 2)
+			chan_base = rvu->hw->cpt_chan_base;
+	}
+
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
-		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
+		/* CPT channel for a given link channel is always
+		 * assumed to be BIT(11) set in link channel.
+		 */
+		if (cpt_link)
+			chan_v = chan | BIT(11);
+		else
+			chan_v = chan;
+
+		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg & ~BIT_ULL(16));
 
 		if (type == NIX_INTF_TYPE_LBK) {
@@ -612,6 +742,19 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
+				    struct nix_bp_cfg_req *req,
+				    struct msg_rsp *rsp)
+{
+	return nix_bp_disable(rvu, req, rsp, false);
+}
+
+int rvu_mbox_handler_nix_cpt_bp_disable(struct rvu *rvu,
+					struct nix_bp_cfg_req *req,
+					struct msg_rsp *rsp)
+{
+	return nix_bp_disable(rvu, req, rsp, true);
+}
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 			    int type, int chan_id)
 {
@@ -654,7 +797,9 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 		if (bpid > bp->cgx_bpid_cnt)
 			return NIX_AF_ERR_INVALID_BPID;
 		break;
-
+	case NIX_INTF_TYPE_CPT:
+		bpid = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt;
+		break;
 	case NIX_INTF_TYPE_LBK:
 		/* Alloc bpid from the free pool */
 		mutex_lock(&rvu->rsrc_lock);
@@ -691,15 +836,17 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 	return bpid;
 }
 
-int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
-				   struct nix_bp_cfg_req *req,
-				   struct nix_bp_cfg_rsp *rsp)
+static int nix_bp_enable(struct rvu *rvu,
+			 struct nix_bp_cfg_req *req,
+			 struct nix_bp_cfg_rsp *rsp,
+			 bool cpt_link)
 {
 	int blkaddr, pf, type, chan_id = 0;
 	u16 pcifunc = req->hdr.pcifunc;
+	s16 bpid, bpid_base = -1;
 	struct rvu_pfvf *pfvf;
 	u16 chan_base, chan;
-	s16 bpid, bpid_base;
+	u16 chan_v;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -712,25 +859,46 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	    type != NIX_INTF_TYPE_SDP)
 		return 0;
 
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 
-	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
 	chan_base = pfvf->rx_chan_base + req->chan_base;
-	bpid = bpid_base;
+
+	if (cpt_link) {
+		type = NIX_INTF_TYPE_CPT;
+		cfg = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(0));
+		/* MODE=0 or MODE=1 => CPT looks only channels starting from cpt chan base */
+		cfg = (cfg >> 20) & 0x3;
+		if (cfg != 2)
+			chan_base = rvu->hw->cpt_chan_base;
+	}
 
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
+		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 		if (bpid < 0) {
 			dev_warn(rvu->dev, "Fail to enable backpressure\n");
 			return -EINVAL;
 		}
+		if (bpid_base < 0)
+			bpid_base = bpid;
+
+		/* CPT channel for a given link channel is always
+		 * assumed to be BIT(11) set in link channel.
+		 */
+
+		if (cpt_link)
+			chan_v = chan | BIT(11);
+		else
+			chan_v = chan;
 
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
+		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
 		cfg &= ~GENMASK_ULL(8, 0);
-		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
 		chan_id++;
-		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 	}
 
 	for (chan = 0; chan < req->chan_cnt; chan++) {
@@ -745,6 +913,20 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
+				   struct nix_bp_cfg_req *req,
+				   struct nix_bp_cfg_rsp *rsp)
+{
+	return nix_bp_enable(rvu, req, rsp, false);
+}
+
+int rvu_mbox_handler_nix_cpt_bp_enable(struct rvu *rvu,
+				       struct nix_bp_cfg_req *req,
+				       struct nix_bp_cfg_rsp *rsp)
+{
+	return nix_bp_enable(rvu, req, rsp, true);
+}
+
 static void nix_setup_lso_tso_l3(struct rvu *rvu, int blkaddr,
 				 u64 format, bool v4, u64 *fidx)
 {
-- 
2.25.1


