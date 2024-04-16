Return-Path: <linux-kernel+bounces-146258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1058A62CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EE21C2110C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09E6CDD0;
	Tue, 16 Apr 2024 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RFmPOXHn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0467C53;
	Tue, 16 Apr 2024 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244015; cv=none; b=q4ECnlrlLGi4UqSthUYADSZXsDZ5Nj4MCCXZlZPw1GRvOhHGmFffOkZ83ZnuOdcIsHVZm8fAY7KNZ+/S6yq7j5dnxARVC0OgPbaa1wOeUK+uBK5fqO19XBCKe1xHNPFnOgaiVsE8cKn8BOZJbecf1xDtyrXQ5FO0ugCWVxivLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244015; c=relaxed/simple;
	bh=x0gdXgfqKD/d0jTy6H28zb5Ygh8KnsXG/I6OrNvykN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVZrHX8eKFXdYyMvngszF7d+8MG4GhG9dfwEpvDlyfB3bJ+N0YNQdoYUkr2+JbWk4B0sP0grX9TK9hdiQLhKRdfpSMHzkNEubB3ng1DmxJUBjk/icIvrO5S+rRad8V9mLbwZJLpYIlzIJnpB7elcktpJYrbskMiDn5nxtBhVKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RFmPOXHn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G2S8hc007506;
	Mon, 15 Apr 2024 22:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=lhYfkdlUgtWG8LPq3WcsK
	OyUAQY24a/k0G+t20DmRtE=; b=RFmPOXHny7uphjrOC+6jjwcDzo2CxJsmXutpy
	ESGCxlcoSWRQTJHtSo32wmjUP1m7YAyq2bC+hcFH5KqjwumrA1OvDvDZlYFkSRkV
	1rOlTb2u8XGrGHmrqLZco/07oxlgHng0l6QPz0ucP4V21afTlDcWXRpF1ppLJRh7
	k47E2YHgHv0pG9HgezUunMlBh7rK0Y0agWBYZmLWA90XpVO00qRxxu1t/KISVM4x
	t6yZdxfNmQdhWIf0neu+/+Q37vqL3T4t42t5n/omY+3mpBCFSRzGebFNHXXPBbIT
	jn9mEbjV1fOVxuvBCEWr3hC6TQdYn35vdaOl/yR0SCdaOU+qA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn0j7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 22:06:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Apr 2024 22:06:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 15 Apr 2024 22:06:38 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id D1EC33F7083;
	Mon, 15 Apr 2024 22:06:35 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 5/9] octeontx2-af: Add packet path between representor and VF
Date: Tue, 16 Apr 2024 10:36:12 +0530
Message-ID: <20240416050616.6056-6-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240416050616.6056-1-gakula@marvell.com>
References: <20240416050616.6056-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Zj0gejig06BF4bJbTR55HVUPSBXZYqB8
X-Proofpoint-ORIG-GUID: Zj0gejig06BF4bJbTR55HVUPSBXZYqB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02

This patch installs tcam rules to stree traffic representors
and VF when swicthdev mode is set. To support this a HW loopback
channel is reserved. Through this channel packet are routed
between representor and VFs. "ESW_CFG" mbox is defined to
notify AF for installing rules.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   7 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   7 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 241 +++++++++++++++++-
 .../marvell/octeontx2/af/rvu_switch.c         |  18 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  19 ++
 7 files changed, 297 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index c77c02730cf9..3b36da28a8f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -144,6 +144,7 @@ M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
 M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
 M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
+M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1532,6 +1533,12 @@ struct get_rep_cnt_rsp {
 	u64 rsvd;
 };
 
+struct esw_cfg_req {
+	struct mbox_msghdr hdr;
+	u8 ena;
+	u64 rsvd;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 1d76d52d7a5d..c8572d79a968 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -596,6 +596,7 @@ struct rvu {
 	u16			rep_pcifunc;
 	int			rep_cnt;
 	u16			*rep2pfvf_map;
+	u8			rep_mode;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -1025,7 +1026,7 @@ int rvu_ndc_fix_locked_cacheline(struct rvu *rvu, int blkaddr);
 /* RVU Switch */
 void rvu_switch_enable(struct rvu *rvu);
 void rvu_switch_disable(struct rvu *rvu);
-void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc);
+void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool ena);
 
 int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
@@ -1039,4 +1040,8 @@ int rvu_mcs_flr_handler(struct rvu *rvu, u16 pcifunc);
 void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
 void rvu_mcs_exit(struct rvu *rvu);
 
+/* Representor APIs */
+int rvu_rep_pf_init(struct rvu *rvu);
+int rvu_rep_install_mcam_rules(struct rvu *rvu);
+void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 96c04f7d93f8..8a3b7fb61883 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1464,6 +1464,9 @@ static int rvu_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 	struct rvu *rvu = rvu_dl->rvu;
 	struct rvu_switch *rswitch;
 
+	if (rvu->rep_mode)
+		return -EOPNOTSUPP;
+
 	rswitch = &rvu->rswitch;
 	*mode = rswitch->mode;
 
@@ -1477,6 +1480,9 @@ static int rvu_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	struct rvu *rvu = rvu_dl->rvu;
 	struct rvu_switch *rswitch;
 
+	if (rvu->rep_mode)
+		return -EOPNOTSUPP;
+
 	rswitch = &rvu->rswitch;
 	switch (mode) {
 	case DEVLINK_ESWITCH_MODE_LEGACY:
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 4ef5bb7b337f..75d5c1bc00e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2738,7 +2738,7 @@ void rvu_nix_tx_tl2_cfg(struct rvu *rvu, int blkaddr, u16 pcifunc,
 	int schq;
 	u64 cfg;
 
-	if (!is_pf_cgxmapped(rvu, pf))
+	if (!is_pf_cgxmapped(rvu, pf) && !is_rep_dev(rvu, pcifunc))
 		return;
 
 	cfg = enable ? (BIT_ULL(12) | RVU_SWITCH_LBK_CHAN) : 0;
@@ -4368,8 +4368,6 @@ int rvu_mbox_handler_nix_set_mac_addr(struct rvu *rvu,
 	if (test_bit(PF_SET_VF_TRUSTED, &pfvf->flags) && from_vf)
 		ether_addr_copy(pfvf->default_mac, req->mac_addr);
 
-	rvu_switch_update_rules(rvu, pcifunc);
-
 	return 0;
 }
 
@@ -5159,7 +5157,7 @@ int rvu_mbox_handler_nix_lf_start_rx(struct rvu *rvu, struct msg_req *req,
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
-	rvu_switch_update_rules(rvu, pcifunc);
+	rvu_switch_update_rules(rvu, pcifunc, true);
 
 	return rvu_cgx_start_stop_io(rvu, pcifunc, true);
 }
@@ -5187,6 +5185,7 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	if (err)
 		return err;
 
+	rvu_switch_update_rules(rvu, pcifunc, false);
 	rvu_cgx_tx_enable(rvu, pcifunc, true);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index d07cb356d3d6..5c015e8dfbbe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -13,6 +13,246 @@
 #include "rvu.h"
 #include "rvu_reg.h"
 
+static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+{
+	int id;
+
+	for (id = 0; id < rvu->rep_cnt; id++)
+		if (rvu->rep2pfvf_map[id] == pcifunc)
+			return id;
+	return -ENODEV;
+}
+
+static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
+			       u16 vlan_tci, int *vidx)
+{
+	struct nix_vtag_config req = {0};
+	struct nix_vtag_config_rsp rsp = {0};
+	u64 etype = ETH_P_8021Q;
+	int err;
+
+	/* Insert vlan tag */
+	req.hdr.pcifunc = pcifunc;
+	req.vtag_size = VTAGSIZE_T4;
+	req.cfg_type = 0; /* tx vlan cfg */
+	req.tx.cfg_vtag0 = true;
+	req.tx.vtag0 = etype << 48 | ntohs(vlan_tci);
+
+	err = rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
+	if (err) {
+		dev_err(rvu->dev, "Tx vlan config failed\n");
+		return err;
+	}
+	*vidx = rsp.vtag0_idx;
+	return 0;
+}
+
+static int rvu_rep_rx_vlan_cfg(struct rvu *rvu, u16 pcifunc)
+{
+	struct nix_vtag_config req = {0};
+	struct nix_vtag_config_rsp rsp;
+
+	/* config strip, capture and size */
+	req.hdr.pcifunc = pcifunc;
+	req.vtag_size = VTAGSIZE_T4;
+	req.cfg_type = 1; /* rx vlan cfg */
+	req.rx.vtag_type = NIX_AF_LFX_RX_VTAG_TYPE0;
+	req.rx.strip_vtag = true;
+	req.rx.capture_vtag = false;
+
+	return rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
+}
+
+static int rvu_rep_install_rx_rule(struct rvu *rvu, u16 pcifunc,
+				   u16 entry, bool rte)
+{
+	struct npc_install_flow_req req = { 0 };
+	struct npc_install_flow_rsp rsp = { 0 };
+	struct rvu_pfvf *pfvf;
+	u16 vlan_tci, rep_id;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	/* To stree the traffic from Representee to Representor */
+	rep_id = (u16)rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rte) {
+		vlan_tci = rep_id | 0x1ull << 8;
+		req.vf = rvu->rep_pcifunc;
+		req.op = NIX_RX_ACTIONOP_UCAST;
+		req.index = rep_id;
+	} else {
+		vlan_tci = rep_id;
+		req.vf = pcifunc;
+		req.op = NIX_RX_ACTION_DEFAULT;
+	}
+
+	rvu_rep_rx_vlan_cfg(rvu, req.vf);
+	req.entry = entry;
+	req.hdr.pcifunc = 0; /* AF is requester */
+	req.features = BIT_ULL(NPC_OUTER_VID) | BIT_ULL(NPC_VLAN_ETYPE_CTAG);
+	req.vtag0_valid = true;
+	req.vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE0;
+	req.packet.vlan_etype = ETH_P_8021Q;
+	req.mask.vlan_etype = ETH_P_8021Q;
+	req.packet.vlan_tci = vlan_tci;
+	req.mask.vlan_tci = 0xffff;
+
+	req.channel = RVU_SWITCH_LBK_CHAN;
+	req.chan_mask = 0xffff;
+	req.intf = pfvf->nix_rx_intf;
+
+	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
+}
+
+static int rvu_rep_install_tx_rule(struct rvu *rvu, u16 pcifunc, u16 entry,
+				   bool rte)
+{
+	struct npc_install_flow_req req = { 0 };
+	struct npc_install_flow_rsp rsp = { 0 };
+	struct rvu_pfvf *pfvf;
+	int vidx, err;
+	u16 vlan_tci;
+	u8 lbkid;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	vlan_tci = rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rte)
+		vlan_tci |= 0x1ull << 8;
+
+	err = rvu_rep_tx_vlan_cfg(rvu, pcifunc, vlan_tci, &vidx);
+	if (err)
+		return err;
+
+	lbkid = pfvf->nix_blkaddr == BLKADDR_NIX0 ? 0 : 1;
+	req.hdr.pcifunc = 0; /* AF is requester */
+	if (rte) {
+		req.vf = pcifunc;
+	} else {
+		req.vf = rvu->rep_pcifunc;
+		req.packet.sq_id = vlan_tci;
+		req.mask.sq_id = 0xffff;
+	}
+
+	req.entry = entry;
+	req.intf = pfvf->nix_tx_intf;
+	req.op = NIX_TX_ACTIONOP_UCAST_CHAN;
+	req.index = (lbkid << 8) | RVU_SWITCH_LBK_CHAN;
+	req.set_cntr = 1;
+	req.vtag0_def = vidx;
+	req.vtag0_op = 1;
+	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
+}
+
+int rvu_rep_install_mcam_rules(struct rvu *rvu)
+{
+	struct rvu_switch *rswitch = &rvu->rswitch;
+	u16 start = rswitch->start_entry;
+	struct rvu_hwinfo *hw = rvu->hw;
+	u16 pcifunc, entry = 0;
+	int pf, vf, numvfs;
+	int err, nixlf, i;
+	u8 rep;
+
+	for (pf = 1; pf < hw->total_pfs; pf++) {
+		if (!is_pf_cgxmapped(rvu, pf))
+			continue;
+
+		pcifunc = pf << RVU_PFVF_PF_SHIFT;
+		rvu_get_nix_blkaddr(rvu, pcifunc);
+		rep = true;
+		for (i = 0; i < 2; i++) {
+			err = rvu_rep_install_rx_rule(rvu, pcifunc, start + entry, rep);
+			if (err)
+				return err;
+			rswitch->entry2pcifunc[entry++] = pcifunc;
+
+			err = rvu_rep_install_tx_rule(rvu, pcifunc, start + entry, rep);
+			if (err)
+				return err;
+			rswitch->entry2pcifunc[entry++] = pcifunc;
+			rep = false;
+		}
+
+		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
+		for (vf = 0; vf < numvfs; vf++) {
+			pcifunc = pf << RVU_PFVF_PF_SHIFT |
+				  ((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rvu_get_nix_blkaddr(rvu, pcifunc);
+
+			/* Skip installimg rules if nixlf is not attached */
+			err = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
+			if (err)
+				continue;
+			rep = true;
+			for (i = 0; i < 2; i++) {
+				err = rvu_rep_install_rx_rule(rvu, pcifunc, start + entry, rep);
+				if (err)
+					return err;
+				rswitch->entry2pcifunc[entry++] = pcifunc;
+
+				err = rvu_rep_install_tx_rule(rvu, pcifunc, start + entry, rep);
+				if (err)
+					return err;
+				rswitch->entry2pcifunc[entry++] = pcifunc;
+				rep = false;
+			}
+		}
+	}
+	return 0;
+}
+
+void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
+{
+	struct rvu_switch *rswitch = &rvu->rswitch;
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u32 max = rswitch->used_entries;
+	int blkaddr;
+	u16 entry;
+
+	if (!rswitch->used_entries)
+		return;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+
+	if (blkaddr < 0)
+		return;
+
+	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
+	mutex_lock(&mcam->lock);
+	for (entry = 0; entry < max; entry++) {
+		if (rswitch->entry2pcifunc[entry] == pcifunc)
+			npc_enable_mcam_entry(rvu, mcam, blkaddr, entry, ena);
+	}
+	mutex_unlock(&mcam->lock);
+}
+
+int rvu_rep_pf_init(struct rvu *rvu)
+{
+	u16 pcifunc = rvu->rep_pcifunc;
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
+	rvu_switch_enable_lbk_link(rvu, pcifunc, true);
+	rvu_rep_rx_vlan_cfg(rvu, pcifunc);
+	return 0;
+}
+
+int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
+			     struct msg_rsp *rsp)
+{
+	if (req->hdr.pcifunc != rvu->rep_pcifunc)
+		return 0;
+
+	rvu->rep_mode = req->ena;
+
+	if (req->ena)
+		rvu_switch_enable(rvu);
+	else
+		rvu_switch_disable(rvu);
+
+	return 0;
+}
+
 int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
@@ -45,4 +285,3 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 	}
 	return 0;
 }
-
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index ceb81eebf65e..268efb7c1c15 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -166,6 +166,8 @@ void rvu_switch_enable(struct rvu *rvu)
 
 	alloc_req.contig = true;
 	alloc_req.count = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
+	if (rvu->rep_mode)
+		alloc_req.count = alloc_req.count * 4;
 	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &alloc_req,
 						    &alloc_rsp);
 	if (ret) {
@@ -189,7 +191,12 @@ void rvu_switch_enable(struct rvu *rvu)
 	rswitch->used_entries = alloc_rsp.count;
 	rswitch->start_entry = alloc_rsp.entry;
 
-	ret = rvu_switch_install_rules(rvu);
+	if (rvu->rep_mode) {
+		rvu_rep_pf_init(rvu);
+		ret = rvu_rep_install_mcam_rules(rvu);
+	} else {
+		ret = rvu_switch_install_rules(rvu);
+	}
 	if (ret)
 		goto uninstall_rules;
 
@@ -222,6 +229,9 @@ void rvu_switch_disable(struct rvu *rvu)
 	if (!rswitch->used_entries)
 		return;
 
+	if (rvu->rep_mode)
+		goto free_ents;
+
 	for (pf = 1; pf < hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
@@ -249,6 +259,7 @@ void rvu_switch_disable(struct rvu *rvu)
 		}
 	}
 
+free_ents:
 	uninstall_req.start = rswitch->start_entry;
 	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
 	free_req.all = 1;
@@ -258,12 +269,15 @@ void rvu_switch_disable(struct rvu *rvu)
 	kfree(rswitch->entry2pcifunc);
 }
 
-void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc)
+void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
 {
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	u32 max = rswitch->used_entries;
 	u16 entry;
 
+	if (rvu->rep_mode)
+		return rvu_rep_update_rules(rvu, pcifunc, ena);
+
 	if (!rswitch->used_entries)
 		return;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 187b00156bcd..1329617f8d6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,22 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
+{
+	struct esw_cfg_req *req;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return -ENOMEM;
+	}
+	req->ena = ena;
+	otx2_sync_mbox_msg(&priv->mbox);
+	mutex_unlock(&priv->mbox.lock);
+	return 0;
+}
+
 static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct rep_dev *rep = netdev_priv(dev);
@@ -170,6 +186,8 @@ static void rvu_rep_free_netdev(struct otx2_nic *priv)
 
 void rvu_rep_destroy(struct otx2_nic *priv)
 {
+	/* Remove mcam rules */
+	rvu_eswitch_config(priv, false);
 	rvu_rep_free_cq_rsrc(priv);
 	rvu_rep_free_netdev(priv);
 }
@@ -221,6 +239,7 @@ int rvu_rep_create(struct otx2_nic *priv)
 	if (err)
 		goto exit;
 
+	rvu_eswitch_config(priv, true);
 	return 0;
 exit:
 	rvu_rep_free_netdev(priv);
-- 
2.25.1


