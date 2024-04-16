Return-Path: <linux-kernel+bounces-146256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7168A62CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA291F22AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C433A1AC;
	Tue, 16 Apr 2024 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hkOB8+fq"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A965B697;
	Tue, 16 Apr 2024 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244012; cv=none; b=Ue40bmbQguR/QkVTQ03OLsHjLRDYyJwy1JiemBh3MLoTLkeamWW2wPAUO/XArYUO6SykHR1jBh1//BWBUDA/NzWNx5wzSwNp6S4Bc86ER9uF4BpRrpz13BGgwwi8QVIiTc+z5UUh1zAdTYleWZHEEC1OgXqcTFqj24u+itiY9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244012; c=relaxed/simple;
	bh=O7z96G+ejjOxmIsDt0YZ+weomNselbStgiCv6VxLqz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR4802Y/uZs6DpG8V+rKSKw6NULk6BeHStkU3Js73GIRWBwVOPG4MppeOrry1Gefuf5psL7AsSPonnwK6Hxcj/ix37paB/4bOzAIpsag95USyVnooK8LENeBGOI1AL82nz6mcVD5Zs77Ujjg8uaOXsOAATleU1BL0eW+ks4HzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hkOB8+fq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G19ETd029786;
	Mon, 15 Apr 2024 22:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=yk8iYLXm7JdvhWZfH5g2T
	PuWWX135Kr6PREy0N0deIE=; b=hkOB8+fqvy+MKLbw5hDoUgBIqjcv6CeV9hSYT
	WhHg4PcmudH+7zp6SLTcIJmb/E6LQPm0/FZREa3OPNJXQf2pUajquDt6+bBR8kUe
	Kk2XsYyk0PywMIqvfe8miE+UUnMl4OVBCxqvmf6YwB0S9Mogt40mCsqERqbJufdZ
	VJx2MicNclGIgC1E4SFG2SepbO4j5Y2wRuAqiQom4lpJydaFWderXP8a/xCA5UGx
	ZNyK2WlhAQr4aiPw1ZwG/LRmKcxfBnTdTrh8IODPJ1qkYXI2D7ugIzoTDWsbCtad
	69NtSmzWZsGl2fECHarBT435ASLixxc9mGmHnCyro5IEHc1EQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn0j80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 22:06:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Apr 2024 22:06:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 15 Apr 2024 22:06:42 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7C0E73F7084;
	Mon, 15 Apr 2024 22:06:39 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 6/9] octeontx2-pf: Get VF stats via representor
Date: Tue, 16 Apr 2024 10:36:13 +0530
Message-ID: <20240416050616.6056-7-gakula@marvell.com>
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
X-Proofpoint-GUID: bo1olwhtWzLc_vJpMi-1dZupdAmVNfho
X-Proofpoint-ORIG-GUID: bo1olwhtWzLc_vJpMi-1dZupdAmVNfho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02

This patch add support to export VF port statistics via representor
netdev. Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 32 ++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 43 +++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 64 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  | 14 ++++
 4 files changed, 153 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 3b36da28a8f4..b7f250d218d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -320,6 +320,7 @@ M(NIX_MCAST_GRP_DESTROY, 0x802c, nix_mcast_grp_destroy, nix_mcast_grp_destroy_re
 M(NIX_MCAST_GRP_UPDATE, 0x802d, nix_mcast_grp_update,				\
 				nix_mcast_grp_update_req,			\
 				nix_mcast_grp_update_rsp)			\
+M(NIX_LF_STATS, 0x802e, nix_lf_stats, nix_stats_req, nix_stats_rsp)	\
 /* MCS mbox IDs (range 0xA000 - 0xBFFF) */					\
 M(MCS_ALLOC_RESOURCES,	0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,	\
 				mcs_alloc_rsrc_rsp)				\
@@ -1365,6 +1366,37 @@ struct nix_bandprof_get_hwinfo_rsp {
 	u32 policer_timeunit;
 };
 
+struct nix_stats_req {
+	struct mbox_msghdr hdr;
+	u8 reset;
+	u16 pcifunc;
+	u64 rsvd;
+};
+
+struct nix_stats_rsp {
+	struct mbox_msghdr hdr;
+	u16 pcifunc;
+	struct {
+		u64 octs;
+		u64 ucast;
+		u64 bcast;
+		u64 mcast;
+		u64 drop;
+		u64 drop_octs;
+		u64 drop_mcast;
+		u64 drop_bcast;
+		u64 err;
+		u64 rsvd[5];
+	} rx;
+	struct {
+		u64 ucast;
+		u64 bcast;
+		u64 mcast;
+		u64 drop;
+		u64 octs;
+	} tx;
+};
+
 /* NPC mbox message structs */
 
 #define NPC_MCAM_ENTRY_INVALID	0xFFFF
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 5c015e8dfbbe..103d1d451411 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -13,6 +13,49 @@
 #include "rvu.h"
 #include "rvu_reg.h"
 
+#define RVU_LF_RX_STATS(reg) \
+		rvu_read64(rvu, blkaddr, NIX_AF_LFX_RX_STATX(nixlf, reg))
+
+#define RVU_LF_TX_STATS(reg) \
+		rvu_read64(rvu, blkaddr, NIX_AF_LFX_TX_STATX(nixlf, reg))
+
+int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
+				  struct nix_stats_req *req,
+				  struct nix_stats_rsp *rsp)
+{
+	u16 pcifunc = req->pcifunc;
+	int nixlf, blkaddr, err;
+	struct msg_req rst_req;
+	struct msg_rsp rst_rsp;
+
+	err = nix_get_nixlf(rvu, pcifunc, &nixlf, &blkaddr);
+	if (err)
+		return 0;
+
+	if (req->reset) {
+		rst_req.hdr.pcifunc = pcifunc;
+		return rvu_mbox_handler_nix_stats_rst(rvu, &rst_req, &rst_rsp);
+	}
+	rsp->rx.octs = RVU_LF_RX_STATS(RX_OCTS);
+	rsp->rx.ucast = RVU_LF_RX_STATS(RX_UCAST);
+	rsp->rx.bcast = RVU_LF_RX_STATS(RX_BCAST);
+	rsp->rx.mcast = RVU_LF_RX_STATS(RX_MCAST);
+	rsp->rx.drop = RVU_LF_RX_STATS(RX_DROP);
+	rsp->rx.err = RVU_LF_RX_STATS(RX_ERR);
+	rsp->rx.drop_octs = RVU_LF_RX_STATS(RX_DROP_OCTS);
+	rsp->rx.drop_mcast = RVU_LF_RX_STATS(RX_DRP_MCAST);
+	rsp->rx.drop_bcast = RVU_LF_RX_STATS(RX_DRP_BCAST);
+
+	rsp->tx.octs = RVU_LF_TX_STATS(TX_OCTS);
+	rsp->tx.ucast = RVU_LF_TX_STATS(TX_UCAST);
+	rsp->tx.bcast = RVU_LF_TX_STATS(TX_BCAST);
+	rsp->tx.mcast = RVU_LF_TX_STATS(TX_MCAST);
+	rsp->tx.drop = RVU_LF_TX_STATS(TX_DROP);
+
+	rsp->pcifunc = req->pcifunc;
+	return 0;
+}
+
 static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 1329617f8d6f..3a6a85ae47e5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,67 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static void rvu_rep_get_stats(struct work_struct *work)
+{
+	struct delayed_work *del_work = to_delayed_work(work);
+	struct nix_stats_req *req;
+	struct nix_stats_rsp *rsp;
+	struct rep_stats *stats;
+	struct otx2_nic *priv;
+	struct rep_dev *rep;
+	int err;
+
+	rep = container_of(del_work, struct rep_dev, stats_wrk);
+	priv = rep->mdev;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_nix_lf_stats(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return;
+	}
+	req->pcifunc = rep->pcifunc;
+	err = otx2_sync_mbox_msg_busy_poll(&priv->mbox);
+	if (err)
+		goto exit;
+
+	rsp = (struct nix_stats_rsp *)
+	      otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto exit;
+	}
+
+	stats = &rep->stats;
+	stats->rx_bytes = rsp->rx.octs;
+	stats->rx_frames = rsp->rx.ucast + rsp->rx.bcast +
+			    rsp->rx.mcast;
+	stats->rx_drops = rsp->rx.drop;
+	stats->rx_mcast_frames = rsp->rx.mcast;
+	stats->tx_bytes = rsp->tx.octs;
+	stats->tx_frames = rsp->tx.ucast + rsp->tx.bcast + rsp->tx.mcast;
+	stats->tx_drops = rsp->tx.drop;
+exit:
+	mutex_unlock(&priv->mbox.lock);
+}
+
+static void rvu_rep_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+
+	stats->rx_packets = rep->stats.rx_frames;
+	stats->rx_bytes = rep->stats.rx_bytes;
+	stats->rx_dropped = rep->stats.rx_drops;
+	stats->multicast = rep->stats.rx_mcast_frames;
+
+	stats->tx_packets = rep->stats.tx_frames;
+	stats->tx_bytes = rep->stats.tx_bytes;
+	stats->tx_dropped = rep->stats.tx_drops;
+
+	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));
+}
+
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
 	struct esw_cfg_req *req;
@@ -87,6 +148,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_open		= rvu_rep_open,
 	.ndo_stop		= rvu_rep_stop,
 	.ndo_start_xmit		= rvu_rep_xmit,
+	.ndo_get_stats64	= rvu_rep_get_stats64,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv)
@@ -234,6 +296,8 @@ int rvu_rep_create(struct otx2_nic *priv)
 			ndev->netdev_ops = NULL;
 			goto exit;
 		}
+
+		INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats);
 	}
 	err = rvu_rep_napi_init(priv);
 	if (err)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index be6c939e5cba..9526b886b173 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -17,9 +17,23 @@
 #define PCI_DEVID_RVU_REP	0xA0E0
 
 #define RVU_MAX_REP	OTX2_MAX_CQ_CNT
+
+struct rep_stats {
+	u64 rx_bytes;
+	u64 rx_frames;
+	u64 rx_drops;
+	u64 rx_mcast_frames;
+
+	u64 tx_bytes;
+	u64 tx_frames;
+	u64 tx_drops;
+};
+
 struct rep_dev {
 	struct otx2_nic *mdev;
 	struct net_device *netdev;
+	struct rep_stats stats;
+	struct delayed_work stats_wrk;
 	u16 rep_id;
 	u16 pcifunc;
 };
-- 
2.25.1


