Return-Path: <linux-kernel+bounces-99458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D106F8788AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6614D283129
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271D56B99;
	Mon, 11 Mar 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EFAu+GCg"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296D56B74;
	Mon, 11 Mar 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184641; cv=none; b=owrXQSDDy5ukCMG9U7x3iWEqdzhlDAEY4o3rtoyGRh1r9itTccpRkGBqg7Azly6C0sAMsFenDav+i3YK6YSc0nYg1LlEnkgzu1K34dqcwzVOigFGS9rb7x9jhH1WP0mYjd2UQQN6gPHsKBuQPBIf47p7zSP2G6A/HCIofg5Reg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184641; c=relaxed/simple;
	bh=SgjRtagFD+hyPA6BgHZ7iXvZLG63maw3ojyMlS/a0h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8T8RWCmLKgsatLzohQMgOF2GxE4/+HR4iNA0QaW+yPK1OUUOupJRp2eq0d45hg56zzLp+ekjMC7AWWJOdVG5S9YvRRXM1QaJG7pbDjDud0EY9QRLRAbsvDPoCCH1z9XcMfQwtBpoxMOZwp5B6jlB/8Tih1Fgq0Lul8E4Ixutk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EFAu+GCg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BEm4iR028604;
	Mon, 11 Mar 2024 12:17:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=JMsZkbh2cLYQnMij1T+XO
	wLpOLB3Ya4HSoMTNkt5OHk=; b=EFAu+GCgMupV2zQ0SpGv3HuXt/iifRKHr+3Gn
	TXvOBv2eGmnRbmiP1156/wUtHomrTp6A6MXvrfiEk7FcjsLi3dGjx/GxhX1/Mftm
	XKmdsri/rsm4L37QWw0nN+04SCPZWAPxE/Q8gJKZ2oxEhrGoSK8TuwV5fOuc7g+U
	ZJ9nPrRIoT/+gzZdA5ucdyQYfdPbVoyqdrOLjnJaIcqdjPajewcSAi/1qNY0UxSI
	O4AhlzjI4ERdnzBWBfPLh8uF5m9ncDuinDrB4nNv1opFDlwekePen+aIQe12dlsr
	yReKcHRrVbzx27ewr0jD1huaycXQcHotV9Yj9QGzm6sqM6CMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdctem5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:17:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 12:17:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 12:17:12 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D6B9F3F704C;
	Mon, 11 Mar 2024 12:17:08 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 3/5] octeontx2-pf: Use default max_active works instead of one
Date: Tue, 12 Mar 2024 00:46:50 +0530
Message-ID: <1710184612-29027-4-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-ORIG-GUID: wc44OszCFg14faecc15fyi0w-LR_km6C
X-Proofpoint-GUID: wc44OszCFg14faecc15fyi0w-LR_km6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

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
index 3c8841b35d0f..f85d38fab321 100644
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
2.17.1

