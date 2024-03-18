Return-Path: <linux-kernel+bounces-105874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B587E5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E79E1C21756
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D72D047;
	Mon, 18 Mar 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="No3XKDdN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253A2C859;
	Mon, 18 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754223; cv=none; b=ADVyFkMwTRoP9B8EK1xBfi7M+eqsLno/jtCcKXdMYoEO2+T9vVL7DBLF9JWFeVPHFWPWcME9TYY5GOh7VLNc4FvFA3bLWDJE0qrrpTQBa5o4YD5RsA/25s3stn8LrIGEa0jwH7rsMqBEnfRkRayiB68lNpdOsbsJX4QCmI536mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754223; c=relaxed/simple;
	bh=/UbEcxGWeE3zr6xYF5ficRQ58jY41xoSob+YGPdK7I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTQTjXxK5Y7CtXIKZWGsSSz4LpIg0aT1ZDj0VlnUrLEOCRZi4b+TD9+UIKXOeF6yh9HtWTfiM/ZFxquw96Kp+QHMCbAKgSOoz89aNN7TIf/ZtepCUcGOFgeGg/Jc6RgMTmVNhoMWzAwG4u2ZGzNjCNKVfcNGUiwxaww3yVIw0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=No3XKDdN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMuwwK008089;
	Mon, 18 Mar 2024 02:30:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=BCKFMrTKCsgCOFqVW6Edj
	K9ECpW1o8Nyf15Dr7FKDjw=; b=No3XKDdNLqgwmRz9ERN1QK36byTLQAxgmyhoy
	AseD0TFx8rb+SYnD8Vn8egqDHrsLgB7k/ScD1tc2i4NFMQmcpVGriyy4pGhyJScU
	t3DEEfDxR/QTt1gU0r2Tz+f1ruY30W19EjfEwqr+uLLXwX3p1IaMVKtL4Tsx9a2k
	hQdzmA5X5klqnDyB4mqiYt7z/5HmEjDdjLMdcwM6fUkHiB9hMtaPcL9SH1f1nCiB
	sTTOk9Ws6R8tcrk1dA0aIx6PeyxfA8L12Zs1Gnq7Cel3LEqRzvWt56ZxYqvrum7H
	Ja40PVSJtxOXCg4wwWa9AXzZuWdR0WA4FCLGV11oP+Ofy34OA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc6qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:30:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 18 Mar 2024 02:30:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Mar 2024 02:30:14 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 55E4B3F7082;
	Mon, 18 Mar 2024 02:30:10 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v2 net PATCH 2/5] octeontx2-pf: Wait till detach_resources msg is complete
Date: Mon, 18 Mar 2024 14:59:55 +0530
Message-ID: <1710754198-18632-3-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-GUID: jO4-8epfLSU12qg0TGoKehQ8xqD-1ih4
X-Proofpoint-ORIG-GUID: jO4-8epfLSU12qg0TGoKehQ8xqD-1ih4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

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
index 02d0b70..a85ac03 100644
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
index ced456c..cf0aa16 100644
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
2.7.4


