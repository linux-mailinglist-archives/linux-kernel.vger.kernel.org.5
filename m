Return-Path: <linux-kernel+bounces-99457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7535D8788A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1680AB21B72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322E56772;
	Mon, 11 Mar 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EIN041VV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52E55E4F;
	Mon, 11 Mar 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184638; cv=none; b=CZY8+/iwKimlS2AHBZRcvwa8raRp1y3UvUPqSwtGEQ6wBIHiEJq5MKdx/zf2bwoCZwBPFjS4v8/mAZJtlcQ2NFBeecktLErh5uyZ0aAP1sK53OZus6tlcYIPdcYt0Cv704dQK04bKvzH2b4ns5k2roKc1fx2GI/TE4WRS8LadUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184638; c=relaxed/simple;
	bh=vcsIZ+hG2f3IxnV3xuuSi8GFiiDOSumsWg+PacQYtG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCrfWBDkT1Rch37EuEhnhtPKfXDbQ79u7RXtsiMykf/JgAufPACtQGah73vTpRERDwKizEHppK57JPdMkMKc/vAKXHX16gs4t92PVFTz1EC66BHtfHdIFK1xFr4U35fS5xVy2I3JXJS3L1CyW4q7iPGn7pUEzbtgmosUnJMmakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EIN041VV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BEm4Nx028602;
	Mon, 11 Mar 2024 12:17:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=QJiPhH3X7OFSmOqhtzvu6
	k0wxWOeOR4GzzsMc8QbapE=; b=EIN041VVpoL0FifdNTcpx31A09msYSa5Mn0El
	0axwus7cND7e9MV1u/9yVNfbB2CR1ahHdlIxCKeVbf3muo3sbYCbhmkLwUFfwGJt
	JwzOPp53oHU7ynFlr+w2LK6tKsFO9pr1J5uiO/hDHbmIvL/B4qyJ/wZaMMMDXHeS
	wr/bEFbtLZdXZbPaqpS57UKBe2kGJlSO1/80s1q4UO7scbGamPtHucoxT7YlR2R5
	hop/6aGtARiq/e8q/LHvuvCDIivPeyGQy7nlkZ8rY6mNPKY23DG/iFROyjRlTMMu
	4MeW2YCHpzdbcZqHjoJEv+Y+0HYucia6a6uJfhMjxxJAqH2Uw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdctem0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:17:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 12:17:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 12:17:08 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 83BE23F704C;
	Mon, 11 Mar 2024 12:17:04 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 2/5] octeontx2-pf: Wait till detach_resources msg is complete
Date: Tue, 12 Mar 2024 00:46:49 +0530
Message-ID: <1710184612-29027-3-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-ORIG-GUID: mR7Z4rs2qrdxYamKG_M4H_0goxmTdt-j
X-Proofpoint-GUID: mR7Z4rs2qrdxYamKG_M4H_0goxmTdt-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

During VF driver remove, a message is sent to detach VF
resources to PF but VF is not waiting until message is
complete. Also mailbox interrupts need to be turned off
after the detach resource message is complete. This patch
fixes that problem.

Fixes: 05fcc9e08955 ("octeontx2-pf: Attach NIX and NPA block LFs")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 02d0b707aea5..a85ac039d779 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1592,7 +1592,7 @@ int otx2_detach_resources(struct mbox *mbox)
 	detach->partial = false;
 
 	/* Send detach request to AF */
-	otx2_mbox_msg_send(&mbox->mbox, 0);
+	otx2_sync_mbox_msg(mbox);
 	mutex_unlock(&mbox->lock);
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index ced456cec8ba..cf0aa16d7540 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -775,8 +775,8 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	otx2_mcam_flow_del(vf);
 	otx2_shutdown_tc(vf);
 	otx2_shutdown_qos(vf);
-	otx2vf_disable_mbox_intr(vf);
 	otx2_detach_resources(&vf->mbox);
+	otx2vf_disable_mbox_intr(vf);
 	free_percpu(vf->hw.lmt_info);
 	if (test_bit(CN10K_LMTST, &vf->hw.cap_flag))
 		qmem_free(vf->dev, vf->dync_lmt);
-- 
2.17.1


