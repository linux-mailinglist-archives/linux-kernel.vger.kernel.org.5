Return-Path: <linux-kernel+bounces-45958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CF84385E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D2A1F22310
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0B58AA0;
	Wed, 31 Jan 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="T4GLnLyD"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167A5810E;
	Wed, 31 Jan 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687703; cv=none; b=RKpF5DyTw2X5hQYiDC+kKYEsmZnkpsZTdrzkL26onIAoy3TcWcJR6C3Dof/6+h44oS+LTFQsceKi8V3sLHdfZkS8eKRY9nGGec0UkvQ3H9Q6g5c/c3AyW1PUxtdTsxboMqpG2/1/WoREtVwejTCIyJ+VP+4AEYklUDTzFjwDHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687703; c=relaxed/simple;
	bh=XbGnrLSvFhRVND7eivPrCVq+zsLqJcEhz9H3564wXXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtZ857p6zGvN3wLaKMDja4ReuAad8onJpPR1SjlHxThbf6B13/XDv1dmj9FhsDfhtwsezpooOyOBrL8KBhdg0a0vKW/8/DxSP6bqgoFdyDLbH/Q9XpeqeegU2TQZUgUDU20hB8RIqxyeoHjNkx+tlXOay6fuZkslrLSZVbmCDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=T4GLnLyD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V7UejR014077;
	Tue, 30 Jan 2024 23:54:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=Qyw3BZZhX77tj4+I60F4N
	Gxtw3pMvS9GCv0TzhRBAUU=; b=T4GLnLyDM+AWqT5BRtEjyWvSL37tORfaO+nAK
	ya5GonTpm4wdwY3UmMCflNlVBx2Is3bh1SdFgRe+YzV5+fuaIcSatqOOyRgQ22ab
	+vq5dHePhbzoeB6JJgyvYD93GrzBNRCEn+J9Z5oEdTy/5t21gHAh02UtcpfZOYEt
	+WlEVs487v5SBN3LeKOIGS3fJ1CqSEjNehvdSq9Ynt3H3Bcs4TC5kMD4eq9FaQqo
	PFggfv3As1h6qYB8Jg49cqhi55XTxRlypzfPSkkfgvnWeOK79lTZWPaqqukp5dwB
	FzC2tr8n76hzsrBKY6lG9QOuYbkS9cBjxg9GkVX/6561duZEA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vyhvcr281-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 23:54:54 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jan
 2024 23:54:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 30 Jan 2024 23:54:52 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 4309E3F7052;
	Tue, 30 Jan 2024 23:54:49 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next v2 PATCH 2/2] octeontx2-af: Cleanup loopback device checks
Date: Wed, 31 Jan 2024 13:24:41 +0530
Message-ID: <20240131075441.17227-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131075441.17227-1-gakula@marvell.com>
References: <20240131075441.17227-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: rirhJ49N7_ZcaXHPXJLL8kYjxvqersPP
X-Proofpoint-ORIG-GUID: rirhJ49N7_ZcaXHPXJLL8kYjxvqersPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02

PCI device IDs of RVU device IDs are configurable and
RVU PF0's (ie AF's) are currently assumed as VFs that
identify loopback functionality ie LBKVFs. But in some
cases these VFs can be setup for different functionality.
Hence remove assumptions that AF's VFs are always LBK VFs
by renaming 'is_afvf' as 'is_lbkvf' explicitly and also
identify LBK VF using PCI dev ID. Similar change is done
for other VF types.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c    | 11 +++++++++--
 .../net/ethernet/marvell/octeontx2/af/rvu.h    |  9 ++++++---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c    | 18 +++++++++---------
 .../ethernet/marvell/octeontx2/af/rvu_npc.c    |  8 ++++----
 .../ethernet/marvell/octeontx2/af/rvu_sdp.c    |  6 +++++-
 5 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 7048167707d1..edd12d09dc89 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1484,7 +1484,7 @@ int rvu_get_nix_blkaddr(struct rvu *rvu, u16 pcifunc)
 	/* All CGX mapped PFs are set with assigned NIX block during init */
 	if (is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc))) {
 		blkaddr = pf->nix_blkaddr;
-	} else if (is_afvf(pcifunc)) {
+	} else if (is_lbk_vf(rvu, pcifunc)) {
 		vf = pcifunc - 1;
 		/* Assign NIX based on VF number. All even numbered VFs get
 		 * NIX0 and odd numbered gets NIX1
@@ -2034,7 +2034,7 @@ int rvu_mbox_handler_set_vf_perm(struct rvu *rvu, struct set_vf_perm *req,
 	u16 target;
 
 	/* Only PF can add VF permissions */
-	if ((pcifunc & RVU_PFVF_FUNC_MASK) || is_afvf(pcifunc))
+	if ((pcifunc & RVU_PFVF_FUNC_MASK) || is_lbk_vf(rvu, pcifunc))
 		return -EOPNOTSUPP;
 
 	target = (pcifunc & ~RVU_PFVF_FUNC_MASK) | (req->vf + 1);
@@ -3154,6 +3154,7 @@ static int rvu_enable_sriov(struct rvu *rvu)
 {
 	struct pci_dev *pdev = rvu->pdev;
 	int err, chans, vfs;
+	int pos = 0;
 
 	if (!rvu_afvf_msix_vectors_num_ok(rvu)) {
 		dev_warn(&pdev->dev,
@@ -3161,6 +3162,12 @@ static int rvu_enable_sriov(struct rvu *rvu)
 		return 0;
 	}
 
+	/* Get RVU VFs device id */
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
+	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &rvu->vf_devid);
+
 	chans = rvu_get_num_lbk_chans();
 	if (chans < 0)
 		return chans;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 6971f441c22b..a1d5fc65b92d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -514,6 +514,7 @@ struct rvu {
 	struct mutex		rsrc_lock; /* Serialize resource alloc/free */
 	struct mutex		alias_lock; /* Serialize bar2 alias access */
 	int			vfs; /* Number of VFs attached to RVU */
+	u16			vf_devid; /* VF devices id */
 	int			nix_blkaddr[MAX_NIX_BLKS];
 
 	/* Mbox */
@@ -743,9 +744,11 @@ static inline bool is_rvu_supports_nix1(struct rvu *rvu)
 /* Function Prototypes
  * RVU
  */
-static inline bool is_afvf(u16 pcifunc)
+#define	RVU_LBK_VF_DEVID	0xA0F8
+static inline bool is_lbk_vf(struct rvu *rvu, u16 pcifunc)
 {
-	return !(pcifunc & ~RVU_PFVF_FUNC_MASK);
+	return (!(pcifunc & ~RVU_PFVF_FUNC_MASK) &&
+		(rvu->vf_devid == RVU_LBK_VF_DEVID));
 }
 
 static inline bool is_vf(u16 pcifunc)
@@ -805,7 +808,7 @@ void rvu_aq_free(struct rvu *rvu, struct admin_queue *aq);
 int rvu_sdp_init(struct rvu *rvu);
 bool is_sdp_pfvf(u16 pcifunc);
 bool is_sdp_pf(u16 pcifunc);
-bool is_sdp_vf(u16 pcifunc);
+bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
 
 /* CGX APIs */
 static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 09e7d84f8025..d39001cdc707 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -545,7 +545,7 @@ void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
 	struct nix_hw *nix_hw;
 	struct nix_bp *bp;
 
-	if (!is_afvf(pcifunc))
+	if (!is_lbk_vf(rvu, pcifunc))
 		return;
 
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
@@ -580,7 +580,7 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
-	type = is_afvf(pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
+	type = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
 	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
 		return 0;
 
@@ -703,7 +703,7 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
-	type = is_afvf(pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
+	type = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
 	if (is_sdp_pfvf(pcifunc))
 		type = NIX_INTF_TYPE_SDP;
 
@@ -1614,7 +1614,7 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	cfg = NPC_TX_DEF_PKIND;
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
 
-	intf = is_afvf(pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
+	intf = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
 	if (is_sdp_pfvf(pcifunc))
 		intf = NIX_INTF_TYPE_SDP;
 
@@ -1990,7 +1990,7 @@ static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
 	int pf = rvu_get_pf(pcifunc);
 	u8 cgx_id = 0, lmac_id = 0;
 
-	if (is_afvf(pcifunc)) {/* LBK links */
+	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
 		return hw->cgx_links;
 	} else if (is_pf_cgxmapped(rvu, pf)) {
 		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
@@ -2007,7 +2007,7 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(pcifunc);
 
-	if (is_afvf(pcifunc)) { /* LBK links */
+	if (is_lbk_vf(rvu, pcifunc)) { /* LBK links */
 		*start = hw->cap.nix_txsch_per_cgx_lmac * link;
 		*end = *start + hw->cap.nix_txsch_per_lbk_lmac;
 	} else if (is_pf_cgxmapped(rvu, pf)) { /* CGX links */
@@ -3447,7 +3447,7 @@ static int nix_update_mce_rule(struct rvu *rvu, u16 pcifunc,
 	int pf;
 
 	/* skip multicast pkt replication for AF's VFs & SDP links */
-	if (is_afvf(pcifunc) || is_sdp_pfvf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) || is_sdp_pfvf(pcifunc))
 		return 0;
 
 	if (!hw->cap.nix_rx_multicast)
@@ -3794,7 +3794,7 @@ int rvu_mbox_handler_nix_get_hw_info(struct rvu *rvu, struct msg_req *req,
 	if (blkaddr < 0)
 		return NIX_AF_ERR_AF_LF_INVALID;
 
-	if (is_afvf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc))
 		rvu_get_lbk_link_max_frs(rvu, &rsp->max_mtu);
 	else
 		rvu_get_lmac_link_max_frs(rvu, &rsp->max_mtu);
@@ -4518,7 +4518,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
-	if (is_afvf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc))
 		rvu_get_lbk_link_max_frs(rvu, &max_mtu);
 	else
 		rvu_get_lmac_link_max_frs(rvu, &max_mtu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..da3573b0dfc2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -417,7 +417,7 @@ static void npc_fixup_vf_rule(struct rvu *rvu, struct npc_mcam *mcam,
 	owner = mcam->entry2pfvf_map[index];
 	target_func = (entry->action >> 4) & 0xffff;
 	/* do nothing when target is LBK/PF or owner is not PF */
-	if (is_pffunc_af(owner) || is_afvf(target_func) ||
+	if (is_pffunc_af(owner) || is_lbk_vf(rvu, target_func) ||
 	    (owner & RVU_PFVF_FUNC_MASK) ||
 	    !(target_func & RVU_PFVF_FUNC_MASK))
 		return;
@@ -626,7 +626,7 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	int blkaddr, index;
 
 	/* AF's and SDP VFs work in promiscuous mode */
-	if (is_afvf(pcifunc) || is_sdp_vf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) || is_sdp_vf(rvu, pcifunc))
 		return;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
@@ -791,7 +791,7 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 		return;
 
 	/* Skip LBK VFs */
-	if (is_afvf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc))
 		return;
 
 	/* If pkt replication is not supported,
@@ -871,7 +871,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	u16 vf_func;
 
 	/* Only CGX PF/VF can add allmulticast entry */
-	if (is_afvf(pcifunc) && is_sdp_vf(pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) && is_sdp_vf(rvu, pcifunc))
 		return;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
index ae50d56258ec..1edfda0ae3e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
@@ -40,8 +40,12 @@ bool is_sdp_pf(u16 pcifunc)
 		!(pcifunc & RVU_PFVF_FUNC_MASK));
 }
 
-bool is_sdp_vf(u16 pcifunc)
+#define	RVU_SDP_VF_DEVID	0xA0F7
+bool is_sdp_vf(struct rvu *rvu, u16 pcifunc)
 {
+	if (!(pcifunc & ~RVU_PFVF_FUNC_MASK))
+		return (rvu->vf_devid == RVU_SDP_VF_DEVID);
+
 	return (is_sdp_pfvf(pcifunc) &&
 		!!(pcifunc & RVU_PFVF_FUNC_MASK));
 }
-- 
2.25.1


