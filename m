Return-Path: <linux-kernel+bounces-99460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C958788AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71AB1C20C11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893465820D;
	Mon, 11 Mar 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JgintHO0"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248157888;
	Mon, 11 Mar 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184649; cv=none; b=MeVdGkW40wvDENG+2PmTtpevNgGmccZGRQT0AN58/YK4iLC2W6txHmITalkpYEhsuBjVdWW4qzpm5K+SvEaJPd/XYUWrbPcEdEDtNMLJ5IaS6gVQWc7r+g76HGaPG9/WqIf2+1k9zN9OzIMO+RfvV9tyvuXXRS65kjesLIRKamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184649; c=relaxed/simple;
	bh=CutsK3h2uj49bjhP6MVd2pyC08vtQVjrsmsnHsVO0Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrcAxevvetQa1QX1L25eFLSQSI/sUo8sZt8w+5n5HnsBAsdGjLefBvw8wEqkNrVRSgj1WSRqwT6shI13qj/HozdyPvMIcPLmHwGNaqRwsc0243vwwp/lUSDVE2EVuFboKB8HXf84SbD35htcb738CMxPij6Dye5dbgDbQh2K93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JgintHO0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BEmD6p028762;
	Mon, 11 Mar 2024 12:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=f5zui8r5j6375qDXVQr11
	BbrqfSYEBbeTJbSetAFsFM=; b=JgintHO0dIBT7vc6OXwYdhcogyzvP/5SUGwu5
	UL9AFVTJuf559/c68juQN/ofKmyfQOHIBxDE6YjCUb+jnlAa3B5kull2gl68S0JY
	Se1BlURdqlKJJnYbRW1u8o4jf4pIpgaHozrJraBqFH0RzjN0w2u5ds5BcrGOEYrO
	oFY4b0fJT5USAq/Kwf673HpEUBIY6Gi1Cv/I4CXsQ3QNl2zsdSxuc6SdgGD2Hsh+
	foSRkgjlftY/xAiJuLAgZ/qaKm2TxU3UnXf7FgKf5vNaA8zfHzd0JEgBl1oV2+N9
	iuIFazY5k9aGtOikK1DuyNGc5zYfnLrxuS+ZiDRZfVFdUH4Sg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdcten3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:17:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 12:17:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 12:17:21 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 8B5C03F704C;
	Mon, 11 Mar 2024 12:17:17 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 5/5] octeontx2-af: Use separate handlers for interrupts
Date: Tue, 12 Mar 2024 00:46:52 +0530
Message-ID: <1710184612-29027-6-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
References: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tdNSbr-lxBt7jBOe7X_nTVP9HXPl8Bwz
X-Proofpoint-GUID: tdNSbr-lxBt7jBOe7X_nTVP9HXPl8Bwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

For PF to AF interrupt vector and VF to AF vector same
interrupt handler is registered which is causing race condition.
When two interrupts are raised to two CPUs at same time
then two cores serve same event corrupting the data.

Fixes: 7304ac4567bc ("octeontx2-af: Add mailbox IRQ and msg handlers")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index d2a575a645d8..6a911ea0cff9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2531,10 +2531,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }

-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;

 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -2548,6 +2547,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)

 	rvu_queue_work(&rvu->afpf_wq_info, 0, rvu->hw->total_pfs, intr);

+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int vfs = rvu->vfs;
+	u64 intr;
+
+	/* Sync with mbox memory region */
+	rmb();
+
 	/* Handle VF interrupts */
 	if (vfs > 64) {
 		intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(1));
@@ -2889,7 +2900,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
 	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_intr_handler, 0,
+			  rvu_mbox_pf_intr_handler, 0,
 			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
--
2.17.1

