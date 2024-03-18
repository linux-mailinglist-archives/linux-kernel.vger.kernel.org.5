Return-Path: <linux-kernel+bounces-105876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAEE87E5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CE0B21948
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13172E651;
	Mon, 18 Mar 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZSnTwtTd"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD892E405;
	Mon, 18 Mar 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754228; cv=none; b=X4R+aKtmfxwjA+gTnB9H8D5tZX9k+HyrwE+c/9iUiwZBvV0ZfGA3p8owHg/W8k0Mcw0Ccx88NvY9wdA91BO9AUM7i07jFXvV6xBiudEbnigom/Ed5OuCZBDg42ig22Os1AVTNdWPcTHmEgL1AzncbaQtLo/5fjIVjArnbF9pyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754228; c=relaxed/simple;
	bh=U8JiL8afvCB6i3kzCmYNNkO3gk54tRAyqw4vocROO7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVpaNyoQDIQa4cWgcGLPHVlojIyvCRwL1u4eWt7ILVRz45urAojLOpkHeNsrNGt03kknnnXzk2QqWQhUD4LKARrD3TCUFDw+sJR4alz0s2KrGSSyHjoygRoSGSxQOdxro6PHq0T0YMzagJDU1zwYgEXGQQUmVJ00Ua4t1UrKXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZSnTwtTd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HN06TJ014431;
	Mon, 18 Mar 2024 02:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=CNk5v6vv9ZKOVYw6IoYzS
	uSg+AAWijUCl68zYqIgAqM=; b=ZSnTwtTdyuJq4NgUbGV9lZ7DvlPO7EDwtZbz2
	CCysYi0yifi72gVIm+Py5YZAusSUDw5bIt5srGPQ61lw/fJfK8tVn2Msv23mI3FY
	iWKcAulTfp+9nZp466aaL/rtbq0XRf64v0Lqc/sOU0tgvEtOaO2uQi+E8p38I4rO
	N1bppQJbOr8KF45g6iTFs7BWAt76WcXVmFRL6JPjS5FHFyS7b9tp5O42j6gmV5nF
	T+HyJDFiH4ofocALhStI39XnoSm5+EDXJIu6DOqFzhav9i7vo2jyz3o0x/n7sSbL
	+60BCR2TOeHktmvVaaSZTIRyurJmpV0+J5156iasjZjXD/L6g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc6qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:30:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 18 Mar 2024 02:30:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Mar 2024 02:30:18 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id A97413F7067;
	Mon, 18 Mar 2024 02:30:14 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v2 net PATCH 3/5] octeontx2-pf: Use default max_active works instead of one
Date: Mon, 18 Mar 2024 14:59:56 +0530
Message-ID: <1710754198-18632-4-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
References: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: mZi77XD6wWzdtyH5Wu8dQWTpApEamGCJ
X-Proofpoint-ORIG-GUID: mZi77XD6wWzdtyH5Wu8dQWTpApEamGCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

Only one execution context for the workqueue used for PF and
VFs mailbox communication is incorrect since multiple works are
queued simultaneously by all the VFs and PF link UP messages.
Hence use default number of execution contexts by passing zero
as max_active to alloc_workqueue function. With this fix in place,
modify UP messages also to wait until completion.

Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 3c8841b..f85d38f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -584,8 +584,9 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf)
 		return -ENOMEM;
 
-	pf->mbox_pfvf_wq = alloc_ordered_workqueue("otx2_pfvf_mailbox",
-						   WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
+					   WQ_UNBOUND | WQ_HIGHPRI |
+					   WQ_MEM_RECLAIM, 0);
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
@@ -3146,7 +3147,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 
 	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
 
-	otx2_mbox_msg_send_up(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
 
 	mutex_unlock(&pf->mbox.lock);
 }
-- 
2.7.4


