Return-Path: <linux-kernel+bounces-153135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EB8AC9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D196A1C2145F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E651422D4;
	Mon, 22 Apr 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c1kizEi+"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D8140396;
	Mon, 22 Apr 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779675; cv=none; b=gIyhijbw41QYwXVieTKQJMLqoDqiw6/7wLz4/CBfhySsa6YZ+uA4VYZuKp+1XDZ7kPQcLWJyhf+mEXUDMv66UAdix6ccYeFDYvXuwV/IiUdCLSgL2EUdSVl7KuVj0T8SneQ4pGNpalkvPt3jt8R5lGhsFS4HmU26zZoS3summAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779675; c=relaxed/simple;
	bh=fm5lIby7PBWQO+YRu+itqRs81zyAglPI0Hg5I8KWP1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGxhbZ1lRj7n1pvzutLLroO+Ffdv7qtY+Xj/eUpQi1FyH/Uk51T1/yi9ZpmKEYYN1+vS2CrGGgO3ivIJL1g6seBOzc6mQ16pTMF7apXhnNWnQllVSkZu98x06ZLs+RzVKJo3mwBf2sK1bm30uqSdrKFreHwAcdUuSDOmPWmeUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c1kizEi+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43LLmBUO019070;
	Mon, 22 Apr 2024 02:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=NepFVd3TfhRvlguPKlnYn
	YH2mp3S/KT3nhfKwr20tY0=; b=c1kizEi+5cjdXqGHooP6TtZNbkfbrPR00R6DL
	FmnU4PQi/Cg6Mjs2dAAqJH+gfik76Tya1r8+j5aNlvm8YpIQYWz+Jlza6MtMx8Dz
	RQEt4gz9OWfeUvf0In3clU/D2zMl3LqX1uHICdYHMjXDw7pcvao848wKbyRy0ijO
	qolkCued7i7w70BUMpXSUzg9zexkNEVfq+b+OQaVHsqDvPVDtH1HGsvelq5vFS/c
	miDZ6ngk+Njpq4rsRXX72/+N20Wb/csKPd7psbVZSlUpUzwDa9ZDD4oRJGP5Pjeu
	W9bnChDabSHskNmXhu71f89MsQ028/i5EqBEWlh2MJ3vgK80A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7gcfda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 02:54:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 22 Apr 2024 02:54:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 22 Apr 2024 02:54:13 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 357283F705C;
	Mon, 22 Apr 2024 02:54:09 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 2/9] octeontx2-pf: RVU representor driver
Date: Mon, 22 Apr 2024 15:23:54 +0530
Message-ID: <20240422095401.14245-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240422095401.14245-1-gakula@marvell.com>
References: <20240422095401.14245-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Jrxzu-k1Pb6T0ik7yeU9WL8CNYnm47_Q
X-Proofpoint-GUID: Jrxzu-k1Pb6T0ik7yeU9WL8CNYnm47_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02

This patch adds basic driver for the RVU representor.
Driver on probe does pci specific initialization and does hw
resources configuration.
Introduces RVU_ESWITCH kernel config to enable/disable
this driver. Representor and NIC shares the code but represenotrs
netdev support subset of NIC functionality. Hence "is_rep_dev"
api helps to skip the features initialization that are not supported
by the representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  11 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  19 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  48 ++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../marvell/octeontx2/nic/otx2_common.h       |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |  21 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 222 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  32 +++
 12 files changed, 386 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index a32d85d6f599..72f57d6f8a87 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -46,3 +46,11 @@ config OCTEONTX2_VF
 	depends on OCTEONTX2_PF
 	help
 	  This driver supports Marvell's OcteonTX2 NIC virtual function.
+
+config RVU_ESWITCH
+	tristate "Marvell RVU E-Switch support"
+	depends on OCTEONTX2_PF && NET_SWITCHDEV
+	default m
+	help
+	  This driver supports Marvell's RVU E-Switch that
+	  provides internal SRIOV packet steering and switching for the
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 3cf4c8285c90..ccea37847df8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -11,4 +11,5 @@ rvu_mbox-y := mbox.o rvu_trace.o
 rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
-		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o
+		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
+		  rvu_rep.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 10efbd56abd1..c77c02730cf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -143,6 +143,7 @@ M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
 				msg_rsp)				\
 M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
 M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
+M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1524,6 +1525,13 @@ struct ptp_get_cap_rsp {
 	u64 cap;
 };
 
+struct get_rep_cnt_rsp {
+	struct mbox_msghdr hdr;
+	u16 rep_cnt;
+	u16 rep_pf_map[64];
+	u64 rsvd;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e7ff2f1b021f..1d76d52d7a5d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -593,6 +593,9 @@ struct rvu {
 	spinlock_t		cpt_intr_lock;
 
 	struct mutex		mbox_lock; /* Serialize mbox up and down msgs */
+	u16			rep_pcifunc;
+	int			rep_cnt;
+	u16			*rep2pfvf_map;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -821,6 +824,14 @@ bool is_sdp_pfvf(u16 pcifunc);
 bool is_sdp_pf(u16 pcifunc);
 bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
 
+static inline bool is_rep_dev(struct rvu *rvu, u16 pcifunc)
+{
+	if (rvu->rep_pcifunc && rvu->rep_pcifunc == pcifunc)
+		return true;
+
+	return false;
+}
+
 /* CGX APIs */
 static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index fd565edf9aa4..988c0920d6ca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -329,7 +329,8 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 
 	/* TLs aggegating traffic are shared across PF and VFs */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
-		if (rvu_get_pf(map_func) != rvu_get_pf(pcifunc))
+		if ((nix_get_tx_link(rvu, map_func) != nix_get_tx_link(rvu, pcifunc)) &&
+		    (rvu_get_pf(map_func) != rvu_get_pf(pcifunc)))
 			return false;
 		else
 			return true;
@@ -1634,6 +1635,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	cfg = NPC_TX_DEF_PKIND;
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
 
+	if (is_rep_dev(rvu, pcifunc)) {
+		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
+		pfvf->tx_chan_cnt = 1;
+		goto exit;
+	}
+
 	intf = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
 	if (is_sdp_pfvf(pcifunc))
 		intf = NIX_INTF_TYPE_SDP;
@@ -1704,6 +1711,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
 	if (nixlf < 0)
 		return NIX_AF_ERR_AF_LF_INVALID;
 
+	if (is_rep_dev(rvu, pcifunc))
+		goto free_lf;
+
 	if (req->flags & NIX_LF_DISABLE_FLOWS)
 		rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);
 	else
@@ -1715,6 +1725,7 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
 
 	nix_interface_deinit(rvu, pcifunc, nixlf);
 
+free_lf:
 	/* Reset this NIX LF */
 	err = rvu_lf_reset(rvu, block, nixlf);
 	if (err) {
@@ -2010,7 +2021,7 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(pcifunc);
 
-	if (is_lbk_vf(rvu, pcifunc)) { /* LBK links */
+	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc)) { /* LBK links */
 		*start = hw->cap.nix_txsch_per_cgx_lmac * link;
 		*end = *start + hw->cap.nix_txsch_per_lbk_lmac;
 	} else if (is_pf_cgxmapped(rvu, pf)) { /* CGX links */
@@ -4522,7 +4533,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
-	if (is_lbk_vf(rvu, pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc))
 		rvu_get_lbk_link_max_frs(rvu, &max_mtu);
 	else
 		rvu_get_lmac_link_max_frs(rvu, &max_mtu);
@@ -4550,6 +4561,8 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		/* For VFs of PF0 ingress is LBK port, so config LBK link */
 		pfvf = rvu_get_pfvf(rvu, pcifunc);
 		link = hw->cgx_links + pfvf->lbkid;
+	} else if (is_rep_dev(rvu, pcifunc)) {
+		link = hw->cgx_links + 0;
 	}
 
 	if (link < 0)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
new file mode 100644
index 000000000000..d07cb356d3d6
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "rvu.h"
+#include "rvu_reg.h"
+
+int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
+				 struct get_rep_cnt_rsp *rsp)
+{
+	int pf, vf, numvfs, hwvf, rep = 0;
+	u16 pcifunc;
+
+	rvu->rep_pcifunc = req->hdr.pcifunc;
+	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
+	rvu->rep_cnt = rsp->rep_cnt;
+
+	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
+					 sizeof(u16), GFP_KERNEL);
+	if (!rvu->rep2pfvf_map)
+		return -ENOMEM;
+
+	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
+		if (!is_pf_cgxmapped(rvu, pf))
+			continue;
+		pcifunc = pf << RVU_PFVF_PF_SHIFT;
+		rvu->rep2pfvf_map[rep] = pcifunc;
+		rsp->rep_pf_map[rep] = pcifunc;
+		rep++;
+		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
+		for (vf = 0; vf < numvfs; vf++) {
+			rvu->rep2pfvf_map[rep] = pcifunc |
+				((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+			rep++;
+		}
+	}
+	return 0;
+}
+
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 5664f768cb0c..69ee78dc8aad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -5,11 +5,13 @@
 
 obj-$(CONFIG_OCTEONTX2_PF) += rvu_nicpf.o otx2_ptp.o
 obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
+obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o
 rvu_nicvf-y := otx2_vf.o otx2_devlink.o
+rvu_rep-y := rep.o
 
 rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
 rvu_nicvf-$(CONFIG_DCB) += otx2_dcbnl.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e6d7b2487ed1..79ec86035c16 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -29,6 +29,7 @@
 #include "otx2_devlink.h"
 #include <rvu_trace.h>
 #include "qos.h"
+#include "rep.h"
 
 /* IPv4 flag more fragment bit */
 #define IPV4_FLAG_MORE				0x20
@@ -439,6 +440,7 @@ struct otx2_nic {
 #define OTX2_FLAG_DMACFLTR_SUPPORT		BIT_ULL(14)
 #define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
 #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
+#define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(17)
 	u64			flags;
 	u64			*cq_op_addr;
 
@@ -506,11 +508,19 @@ struct otx2_nic {
 #if IS_ENABLED(CONFIG_MACSEC)
 	struct cn10k_mcs_cfg	*macsec_cfg;
 #endif
+
+#if IS_ENABLED(CONFIG_RVU_ESWITCH)
+	struct rep_dev		**reps;
+	int			rep_cnt;
+	u16			rep_pf_map[RVU_MAX_REP];
+	u16			esw_mode;
+#endif
 };
 
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
 {
-	return pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF;
+	return (pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
+		(pdev->device == PCI_DEVID_RVU_REP);
 }
 
 static inline bool is_96xx_A0(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 88886ea864cc..119c99768a85 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1502,10 +1502,11 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	hw->sqpool_cnt = otx2_get_total_tx_queues(pf);
 	hw->pool_cnt = hw->rqpool_cnt + hw->sqpool_cnt;
 
-	/* Maximum hardware supported transmit length */
-	pf->tx_max_pktlen = pf->netdev->max_mtu + OTX2_ETH_HLEN;
-
-	pf->rbsize = otx2_get_rbuf_size(pf, pf->netdev->mtu);
+	if (!is_rep_dev(pf->pdev)) {
+		/* Maximum hardware supported transmit length */
+		pf->tx_max_pktlen = pf->netdev->max_mtu + OTX2_ETH_HLEN;
+		pf->rbsize = otx2_get_rbuf_size(pf, pf->netdev->mtu);
+	}
 
 	mutex_lock(&mbox->lock);
 	/* NPA init */
@@ -1634,11 +1635,12 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 		otx2_pfc_txschq_stop(pf);
 #endif
 
-	otx2_clean_qos_queues(pf);
+	if (!is_rep_dev(pf->pdev))
+		otx2_clean_qos_queues(pf);
 
 	mutex_lock(&mbox->lock);
 	/* Disable backpressure */
-	if (!(pf->pcifunc & RVU_PFVF_FUNC_MASK))
+	if (!is_otx2_lbkvf(pf->pdev))
 		otx2_nix_config_bp(pf, false);
 	mutex_unlock(&mbox->lock);
 
@@ -1670,7 +1672,8 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	otx2_free_cq_res(pf);
 
 	/* Free all ingress bandwidth profiles allocated */
-	cn10k_free_all_ipolicers(pf);
+	if (!is_rep_dev(pf->pdev))
+		cn10k_free_all_ipolicers(pf);
 
 	mutex_lock(&mbox->lock);
 	/* Reset NIX LF */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8223780fc269..498a7867a5f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -375,11 +375,13 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 		}
 		start += sizeof(*sg);
 	}
-	otx2_set_rxhash(pfvf, cqe, skb);
 
-	skb_record_rx_queue(skb, cq->cq_idx);
-	if (pfvf->netdev->features & NETIF_F_RXCSUM)
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
+		otx2_set_rxhash(pfvf, cqe, skb);
+		skb_record_rx_queue(skb, cq->cq_idx);
+		if (pfvf->netdev->features & NETIF_F_RXCSUM)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
 
 	skb_mark_for_recycle(skb);
 
@@ -463,7 +465,13 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 process_cqe:
 	qidx = cq->cq_idx - pfvf->hw.rx_queues;
 	sq = &pfvf->qset.sq[qidx];
-	ndev = pfvf->netdev;
+
+#if IS_ENABLED(CONFIG_RVU_ESWITCH)
+	if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+		ndev = pfvf->reps[qidx]->netdev;
+	else
+#endif
+		ndev = pfvf->netdev;
 
 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
 		cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
@@ -500,6 +508,9 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 		if (qidx >= pfvf->hw.tx_queues)
 			qidx -= pfvf->hw.xdp_queues;
+
+		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+			qidx = 0;
 		txq = netdev_get_tx_queue(pfvf->netdev, qidx);
 		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
 		/* Check if queue was stopped earlier due to ring full */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
new file mode 100644
index 000000000000..0e19b938d197
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU representor driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/net_tstamp.h>
+
+#include "otx2_common.h"
+#include "cn10k.h"
+#include "otx2_reg.h"
+#include "rep.h"
+
+#define DRV_NAME	"rvu_rep"
+#define DRV_STRING	"Marvell RVU Representor Driver"
+
+static const struct pci_device_id rvu_rep_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_RVU_REP) },
+	{ }
+};
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DRV_STRING);
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
+
+static int rvu_rep_rsrc_free(struct otx2_nic *priv)
+{
+	struct otx2_qset *qset = &priv->qset;
+	int wrk;
+
+	for (wrk = 0; wrk < priv->qset.cq_cnt; wrk++)
+		cancel_delayed_work_sync(&priv->refill_wrk[wrk].pool_refill_work);
+	devm_kfree(priv->dev, priv->refill_wrk);
+
+	otx2_free_hw_resources(priv);
+	otx2_free_queue_mem(qset);
+	return 0;
+}
+
+static int rvu_rep_rsrc_init(struct otx2_nic *priv)
+{
+	struct otx2_qset *qset = &priv->qset;
+	int err = 0;
+
+	err = otx2_alloc_queue_mem(priv);
+	if (err)
+		return err;
+
+	priv->hw.max_mtu = otx2_get_max_mtu(priv);
+	priv->tx_max_pktlen = priv->hw.max_mtu + OTX2_ETH_HLEN;
+	priv->rbsize = ALIGN(priv->hw.rbuf_len, OTX2_ALIGN) + OTX2_HEAD_ROOM;
+
+	err = otx2_init_hw_resources(priv);
+	if (err)
+		goto err_free_rsrc;
+
+	/* Set maximum frame size allowed in HW */
+	err = otx2_hw_set_mtu(priv, priv->hw.max_mtu);
+	if (err) {
+		dev_err(priv->dev, "Failed to set HW MTU\n");
+		goto err_free_rsrc;
+	}
+	return 0;
+
+err_free_rsrc:
+	otx2_free_hw_resources(priv);
+	otx2_free_queue_mem(qset);
+	return err;
+}
+
+static int rvu_get_rep_cnt(struct otx2_nic *priv)
+{
+	struct get_rep_cnt_rsp *rsp;
+	struct mbox_msghdr *msghdr;
+	struct msg_req *req;
+	int err, rep;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return -ENOMEM;
+	}
+	err = otx2_sync_mbox_msg(&priv->mbox);
+	if (err)
+		goto exit;
+
+	msghdr = otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(msghdr)) {
+		err = PTR_ERR(msghdr);
+		goto exit;
+	}
+
+	rsp = (struct get_rep_cnt_rsp *)msghdr;
+	priv->hw.tx_queues = rsp->rep_cnt;
+	priv->hw.rx_queues = rsp->rep_cnt;
+	priv->rep_cnt = rsp->rep_cnt;
+	for (rep = 0; rep < priv->rep_cnt; rep++)
+		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
+
+exit:
+	mutex_unlock(&priv->mbox.lock);
+	return err;
+}
+
+static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct otx2_nic *priv;
+	struct otx2_hw *hw;
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		return err;
+	}
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "DMA mask config failed, abort\n");
+		goto err_release_regions;
+	}
+
+	pci_set_master(pdev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto err_release_regions;
+
+	pci_set_drvdata(pdev, priv);
+	priv->pdev = pdev;
+	priv->dev = dev;
+	priv->flags |= OTX2_FLAG_INTF_DOWN;
+	priv->flags |= OTX2_FLAG_REP_MODE_ENABLED;
+
+	hw = &priv->hw;
+	hw->pdev = pdev;
+	hw->max_queues = OTX2_MAX_CQ_CNT;
+	hw->rbuf_len = OTX2_DEFAULT_RBUF_LEN;
+	hw->xqe_size = 128;
+
+	err = otx2_init_rsrc(pdev, priv);
+	if (err)
+		goto err_release_regions;
+
+	err = rvu_get_rep_cnt(priv);
+	if (err)
+		goto err_detach_rsrc;
+
+	err = rvu_rep_rsrc_init(priv);
+	if (err)
+		goto err_detach_rsrc;
+
+	return 0;
+
+err_detach_rsrc:
+	if (priv->hw.lmt_info)
+		free_percpu(priv->hw.lmt_info);
+	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
+		qmem_free(priv->dev, priv->dync_lmt);
+	otx2_detach_resources(&priv->mbox);
+	otx2_disable_mbox_intr(priv);
+	otx2_pfaf_mbox_destroy(priv);
+	pci_free_irq_vectors(pdev);
+err_release_regions:
+	pci_set_drvdata(pdev, NULL);
+	pci_release_regions(pdev);
+	return err;
+}
+
+static void rvu_rep_remove(struct pci_dev *pdev)
+{
+	struct otx2_nic *priv = pci_get_drvdata(pdev);
+
+	rvu_rep_rsrc_free(priv);
+	otx2_detach_resources(&priv->mbox);
+	if (priv->hw.lmt_info)
+		free_percpu(priv->hw.lmt_info);
+	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
+		qmem_free(priv->dev, priv->dync_lmt);
+	otx2_disable_mbox_intr(priv);
+	otx2_pfaf_mbox_destroy(priv);
+	pci_free_irq_vectors(priv->pdev);
+	pci_set_drvdata(pdev, NULL);
+	pci_release_regions(pdev);
+}
+
+static struct pci_driver rvu_rep_driver = {
+	.name = DRV_NAME,
+	.id_table = rvu_rep_id_table,
+	.probe = rvu_rep_probe,
+	.remove = rvu_rep_remove,
+	.shutdown = rvu_rep_remove,
+};
+
+static int __init rvu_rep_init_module(void)
+{
+	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
+
+	return pci_register_driver(&rvu_rep_driver);
+}
+
+static void __exit rvu_rep_cleanup_module(void)
+{
+	pci_unregister_driver(&rvu_rep_driver);
+}
+
+module_init(rvu_rep_init_module);
+module_exit(rvu_rep_cleanup_module);
+
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
new file mode 100644
index 000000000000..30cce17eb48b
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU REPRESENTOR driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef REP_H
+#define REP_H
+
+#include <linux/pci.h>
+
+#include "otx2_reg.h"
+#include "otx2_txrx.h"
+#include "otx2_common.h"
+
+#define PCI_DEVID_RVU_REP	0xA0E0
+
+#define RVU_MAX_REP	OTX2_MAX_CQ_CNT
+struct rep_dev {
+	struct otx2_nic *mdev;
+	struct net_device *netdev;
+	u16 rep_id;
+	u16 pcifunc;
+};
+
+static inline bool is_rep_dev(struct pci_dev *pdev)
+{
+	return pdev->device == PCI_DEVID_RVU_REP;
+}
+
+#endif /* REP_H */
-- 
2.25.1


