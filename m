Return-Path: <linux-kernel+bounces-153133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B78AC9F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08582835FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473913FD8C;
	Mon, 22 Apr 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A5a/ctqK"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5412FB18;
	Mon, 22 Apr 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779672; cv=none; b=CPIhkwaDmXu4ybjAHH9sEGaLIAVMN4q2wT2OXnjZ1pPhizfwm59W/4gfsKZJD88XFGZTJvb3w0TryzYBk2s64KpMGjjWZ0F4h6zR1NIiIc5qLfmQL5jwxpv9DSi3XI0VYOKPx/g2Y1n1OpwwuucLF6ByG2LLhhCu+j8BmoYOQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779672; c=relaxed/simple;
	bh=P0Fw6HNcKUNsGT7IYpRRkglH+LNP/hrdpwx6qK6uzHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmkMRFKJCK04MRk9w0ur2qzuwK/+G2z4NYVqZCldEOCxJhgO0boPBy4gAJKgqjvMu7yNwCjIG3nnBefe6jbN99f4+4C+wS6jTFkq8JULeTXYnhbNsv9FHF4oDfMcasmBTKPcOi2kFkMVsjlfjj402vZFZJIiiqlv/UCZoQe0sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A5a/ctqK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9gh7L011793;
	Mon, 22 Apr 2024 02:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=b1DqZ02nEvg5gtRhKqy9R
	xcY5Pj34jlWAY1BOYTbQ9E=; b=A5a/ctqKA41dvbfnzhFPBFkCDwCcAH201JWqP
	EM/eH3Lb/oufupkYp5FP8ksxFNcinDRpsNi8mtCifAoqc0QymPlRe8+NYxLeUdwz
	SMp6wAM6tfCSo4zdS20u68EcAN1x4NCzRyJJp7IDyY05oek14OAmpEgcPgXOc9I/
	5CX/MNdaFkBJvhjSTuKrmiM5FVg6XXm8eg1KVx+BUZGX9qZ3yQxw8hMCtEUYxpsJ
	huIEsGbQyC2At5/rP2Kq/pzBBH7r9qRLdELeTN2PF+TPohwK3up18sL2Oq5BNtZs
	NGXbLIP6hhsLlNmo1rPnO74BxkfHDYyZmAsW/CwNtgzDmzTVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xnngcr170-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 02:54:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 22 Apr 2024 02:54:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 22 Apr 2024 02:54:16 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B5E203F7075;
	Mon, 22 Apr 2024 02:54:13 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 3/9] octeontx2-pf: Create representor netdev
Date: Mon, 22 Apr 2024 15:23:55 +0530
Message-ID: <20240422095401.14245-4-gakula@marvell.com>
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
X-Proofpoint-GUID: 8ZjLynyXAd4pZoVaBLWM4BT5-piJG-sU
X-Proofpoint-ORIG-GUID: 8ZjLynyXAd4pZoVaBLWM4BT5-piJG-sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02

Adds initial devlink support to set/get the switchdev mode.
Representor netdevs are created for each rvu devices when
the switch mode is set to 'switchdev'. These netdevs are
be used to control and configure VFs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 154 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   2 +
 3 files changed, 203 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4e1130496573..60156c7ebe45 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -76,7 +76,52 @@ static const struct devlink_param otx2_dl_params[] = {
 			     otx2_dl_mcam_count_validate),
 };
 
+#ifdef CONFIG_RVU_ESWITCH
+static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	if (!is_rep_dev(pfvf->pdev))
+		return -EOPNOTSUPP;
+
+	*mode = pfvf->esw_mode;
+
+	return 0;
+}
+
+static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
+					 struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	if (!is_rep_dev(pfvf->pdev))
+		return -EOPNOTSUPP;
+
+	if (pfvf->esw_mode == mode)
+		return 0;
+
+	switch (mode) {
+	case DEVLINK_ESWITCH_MODE_LEGACY:
+		rvu_rep_destroy(pfvf);
+		break;
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+		rvu_rep_create(pfvf);
+		break;
+	default:
+		return -EINVAL;
+	}
+	pfvf->esw_mode = mode;
+	return 0;
+}
+#endif
+
 static const struct devlink_ops otx2_devlink_ops = {
+#ifdef CONFIG_RVU_ESWITCH
+	.eswitch_mode_get = otx2_devlink_eswitch_mode_get,
+	.eswitch_mode_set = otx2_devlink_eswitch_mode_set,
+#endif
 };
 
 int otx2_register_dl(struct otx2_nic *pfvf)
@@ -112,6 +157,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 	devlink_free(dl);
 	return err;
 }
+EXPORT_SYMBOL(otx2_register_dl);
 
 void otx2_unregister_dl(struct otx2_nic *pfvf)
 {
@@ -123,3 +169,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
 				  ARRAY_SIZE(otx2_dl_params));
 	devlink_free(dl);
 }
+EXPORT_SYMBOL(otx2_unregister_dl);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0e19b938d197..e2571728cb0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,154 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_napi_init(struct otx2_nic *priv)
+{
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &priv->qset;
+	struct otx2_hw *hw = &priv->hw;
+	int err = 0, qidx, vec;
+	char *irq_name;
+
+	qset->napi = kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
+	if (!qset->napi)
+		return -ENOMEM;
+
+	/* Register NAPI handler */
+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
+		cq_poll = &qset->napi[qidx];
+		cq_poll->cint_idx = qidx;
+		cq_poll->cq_ids[CQ_RX] =
+			(qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_TX] = (qidx < hw->tx_queues) ?
+					  qidx + hw->rx_queues : CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_XDP] = CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_QOS] = CINT_INVALID_CQ;
+
+		cq_poll->dev = (void *)priv;
+		netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
+			       otx2_napi_handler);
+		napi_enable(&cq_poll->napi);
+	}
+	/* Register CQ IRQ handlers */
+	vec = hw->nix_msixoff + NIX_LF_CINT_VEC_START;
+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
+		irq_name = &hw->irq_name[vec * NAME_SIZE];
+
+		snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx);
+
+		err = request_irq(pci_irq_vector(priv->pdev, vec),
+				  otx2_cq_intr_handler, 0, irq_name,
+				  &qset->napi[qidx]);
+		if (err) {
+			dev_err(priv->dev,
+				"RVU REP IRQ registration failed for CQ%d\n", qidx);
+			goto err_free_cints;
+		}
+		vec++;
+
+		/* Enable CQ IRQ */
+		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0));
+	}
+	priv->flags &= ~OTX2_FLAG_INTF_DOWN;
+	return 0;
+
+err_free_cints:
+	otx2_free_cints(priv, qidx);
+	otx2_disable_napi(priv);
+	return err;
+}
+
+static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv)
+{
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &priv->qset;
+	int qidx, vec;
+
+	/* Cleanup CQ NAPI and IRQ */
+	vec = priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
+	for (qidx = 0; qidx < priv->hw.cint_cnt; qidx++) {
+		/* Disable interrupt */
+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx), BIT_ULL(0));
+
+		synchronize_irq(pci_irq_vector(priv->pdev, vec));
+
+		cq_poll = &qset->napi[qidx];
+		napi_synchronize(&cq_poll->napi);
+		vec++;
+	}
+	otx2_free_cints(priv, priv->hw.cint_cnt);
+	otx2_disable_napi(priv);
+}
+
+void rvu_rep_destroy(struct otx2_nic *priv)
+{
+	struct rep_dev *rep;
+	int rep_id;
+
+	rvu_rep_free_cq_rsrc(priv);
+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
+		rep = priv->reps[rep_id];
+		unregister_netdev(rep->netdev);
+		free_netdev(rep->netdev);
+	}
+}
+
+int rvu_rep_create(struct otx2_nic *priv)
+{
+	int rep_cnt = priv->rep_cnt;
+	struct net_device *ndev;
+	struct rep_dev *rep;
+	int rep_id, err;
+	u16 pcifunc;
+
+	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev), GFP_KERNEL);
+	if (!priv->reps)
+		return -ENOMEM;
+
+	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
+		ndev = alloc_etherdev(sizeof(*rep));
+		if (!ndev) {
+			dev_err(priv->dev, "PFVF representor:%d creation failed\n", rep_id);
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		rep = netdev_priv(ndev);
+		priv->reps[rep_id] = rep;
+		rep->mdev = priv;
+		rep->netdev = ndev;
+		rep->rep_id = rep_id;
+
+		ndev->min_mtu = OTX2_MIN_MTU;
+		ndev->max_mtu = priv->hw.max_mtu;
+		pcifunc = priv->rep_pf_map[rep_id];
+		rep->pcifunc = pcifunc;
+
+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
+			 rvu_get_pf(pcifunc));
+
+		eth_hw_addr_random(ndev);
+		err = register_netdev(ndev);
+		if (err) {
+			dev_err(priv->dev, "PFVF reprentator registration failed\n");
+			goto exit;
+		}
+	}
+	err = rvu_rep_napi_init(priv);
+	if (err)
+		goto exit;
+
+	return 0;
+exit:
+	while (--rep_id >= 0) {
+		rep = priv->reps[rep_id];
+		unregister_netdev(rep->netdev);
+		free_netdev(rep->netdev);
+	}
+	return err;
+}
+
 static int rvu_rep_rsrc_free(struct otx2_nic *priv)
 {
 	struct otx2_qset *qset = &priv->qset;
@@ -163,6 +311,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_detach_rsrc;
 
+	err = otx2_register_dl(priv);
+	if (err)
+		goto err_detach_rsrc;
+
 	return 0;
 
 err_detach_rsrc:
@@ -184,6 +336,8 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 {
 	struct otx2_nic *priv = pci_get_drvdata(pdev);
 
+	otx2_unregister_dl(priv);
+	rvu_rep_destroy(priv);
 	rvu_rep_rsrc_free(priv);
 	otx2_detach_resources(&priv->mbox);
 	if (priv->hw.lmt_info)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 30cce17eb48b..be6c939e5cba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -29,4 +29,6 @@ static inline bool is_rep_dev(struct pci_dev *pdev)
 	return pdev->device == PCI_DEVID_RVU_REP;
 }
 
+int rvu_rep_create(struct otx2_nic *priv);
+void rvu_rep_destroy(struct otx2_nic *priv);
 #endif /* REP_H */
-- 
2.25.1


