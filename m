Return-Path: <linux-kernel+bounces-99459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFC8788AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1B5281F70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643E54FB7;
	Mon, 11 Mar 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qm73SFl6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E856B88;
	Mon, 11 Mar 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184646; cv=none; b=EIup4LS5u/jfBePZeyS8HSMaXa34Iip7yowQYy/dPNjhimPGUGuH31d4zdXbegJt9uT5pcex+x1N2q8FOSWY9SoUxGSpkE0dxyI3eoWHsI+zeuyI3K9yQcJjiQndJsEMupnvT/pMhTRVveMdXw9sZajF5m5kIB/qqTdtWz2EBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184646; c=relaxed/simple;
	bh=TxWLwkB4gvmuLm/zh1uc/fWqUekLVi1IEPHf59K2B/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czSSp8Mx4LjhO26L0LoKbQjPADvGwAKVvrhwYYIytXeDkR3IqHdiNQy4RHcfuyzY2/bNM2MsjAQnqRbpFCnY6v+Jj6iyED/IS1l5ge8UGgF2CLWy/5ebpcj+ATIGnbBb8KOLlgoFr3ucMJJ+p2hlX6meBhZVFvGKGiJUi2FOV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qm73SFl6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BIWuPa005645;
	Mon, 11 Mar 2024 12:17:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=hr8TBhXdFMWvioMrBmsoi
	Zu/svWrwLz4UUWs3XLCpiU=; b=Qm73SFl6sF521BvoBHTWefua8D8rf++wxPxJx
	zOGCUcJCPZdtkvFId7grEX46WcDmfmNrm/NX6OIvDTfwSzz8jYHj7LXphW/nSjFW
	HjDhJarkHFMCjemAV12TBcZTYwfML1d+DZt3RdojJ9Roxby3GnVTN29A6+H/RZmz
	XgdvO4kg8VTHl3ceAwg3n5dRNRTVBtrxykUbXJvh30a/NjK3LaCF7S83QcthVJHq
	3zOX80bgiNnDauPe+bEBDwl+sKuwC12vbEdmo+knoegWDCkSoJi1lx2QkYsKSFGO
	Z825dHwNyp8P3HO/9lAtbIeEQD7EaVfyIWv9lTGy2Pw8UjZww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n0j3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:17:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 12:17:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 12:17:17 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 33A803F704C;
	Mon, 11 Mar 2024 12:17:12 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 4/5] octeontx2-pf: Send UP messages to VF only when VF is up.
Date: Tue, 12 Mar 2024 00:46:51 +0530
Message-ID: <1710184612-29027-5-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-ORIG-GUID: DOGUIPOzM209wCA2rtBFQ7pp6z_VxcED
X-Proofpoint-GUID: DOGUIPOzM209wCA2rtBFQ7pp6z_VxcED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

When PF sending link status messages to VF, it is possible
that by the time link_event_task work function is executed
VF might have brought down. Hence before sending VF link
status message check whether VF is up to receive it.

Fixes: ad513ed938c9 ("octeontx2-vf: Link event notification support")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f85d38fab321..b40bd0e46751 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3122,6 +3122,9 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	vf_idx = config - config->pf->vf_configs;
 	pf = config->pf;
 
+	if (config->intf_down)
+		return;
+
 	mutex_lock(&pf->mbox.lock);
 
 	dwork = &config->link_event_work;
-- 
2.17.1


