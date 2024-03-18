Return-Path: <linux-kernel+bounces-105877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25387E5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC261F227D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807552EB10;
	Mon, 18 Mar 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J0COF1wn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5436114;
	Mon, 18 Mar 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754232; cv=none; b=i1R+Zabr9/SxHNC+dbq3w40BIYvHqXKov6ocFBqYQDcWl9tMxi7kCKgmCecCmrH8rvCQSHSH+vuRInKvGQgEUAG0DdPDOQeRsR0Uy03koY3vl+K1NZHN4yC7Guv2U2DjpaZ5MgepFDO5rZtOqA+rUzNoTR3UspiV+Baml1Zpk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754232; c=relaxed/simple;
	bh=eGX8AuC9fGnPiD6/cLbaJ97NwjoIjEYrlx7AqKTrmZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT6V7PEwO+p2fmEuJ6jPDJIh4mgrBQ7NRG4Hla92E+FS23AERI9OkcZ5iouUrdg1j2o3bqLHVaksg+MoCe5uzPQr1b6As0s8mk+stX649kV4IQJh9WCUNhdV9f78/Jb0L/UGbk/ESYb7I+JQaFUVj/sxel5avFlE+Futc60DSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J0COF1wn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMtiFw006033;
	Mon, 18 Mar 2024 02:30:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=IkA9ZHGxkot20JVU+9mvG
	/5JNeuXT12ON1kcaZkg0L0=; b=J0COF1wnzYCQxGySxpuQLAD1auIIsc1HGXZKC
	9EN5x1laNOUUelKYMcJlnqh29O103AvaIISRts+15c1ToySS0XiENuFr0aTWqS2p
	9HkzIdyLt+kBiPkpBx87iHK8hR1UYJm8JqpixOZ7vAfRBYatJxVzQuZIGijbiXnt
	BkxRyuZxVrZ7o8/Fltr1DcEy8kT2dC6q9HFrXcrDwuR9YKbh/JGI+0/d4Xvs06XI
	jSnk6X7sqdbHJRjvesaQ3QRYyNJXZEGe1ST2NBwnsICu8FiKGZfnzc8Z6m9Kgu6Z
	5ZoEC0eZ0jiTqRG+B/4zgmjQT16xV5E71CpQjKkUYbGv+/idg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc6r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:30:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 18 Mar 2024 02:30:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Mar 2024 02:30:22 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 115F63F7086;
	Mon, 18 Mar 2024 02:30:18 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v2 net PATCH 4/5] octeontx2-pf: Send UP messages to VF only when VF is up.
Date: Mon, 18 Mar 2024 14:59:57 +0530
Message-ID: <1710754198-18632-5-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-GUID: W4kBBVoeraMWqc2xbk1JYpXaV0lqZTiD
X-Proofpoint-ORIG-GUID: W4kBBVoeraMWqc2xbk1JYpXaV0lqZTiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

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
index f85d38f..b40bd0e 100644
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
2.7.4


