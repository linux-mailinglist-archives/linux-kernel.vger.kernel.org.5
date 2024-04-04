Return-Path: <linux-kernel+bounces-131309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01572898603
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B7FB23360
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D182D7A;
	Thu,  4 Apr 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fg5I+J8/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAF8061C;
	Thu,  4 Apr 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229894; cv=none; b=nhUctO8Jnemkhqu+l4istF2bdp/XYkw3ZKzFfeus4qj62UIP1yvCCfh7mPG8bH8Kqwb542Rc4pnOS9bGz2ly3aXm+9oxqUgJLaOya/zowxe+n5zpoN5BbDxoxNr3irIuMIhOu32Y+lwrnARFF4GxSOTpwe+6iiONsMkfSioNTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229894; c=relaxed/simple;
	bh=q2nfKh6ApwW052OGkdGyVop2L2by0nfP7ronTq9Kwao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D23jAA7j9F2XvZ7JLQTkljtTLbM2SOwR3fShNoTURkii7CKQEBcjvV5qRwKWxQOzLcgBCyNP5h5dfnnjRWQuN8hEcpqUoRuw3BPKcErvEQj+zjStnp9KI/ihlGqMen23xmYNA//EAzSyvg2OMncCIovmP7pEQP9NV1Han+5WTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fg5I+J8/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434A6eUa001682;
	Thu, 4 Apr 2024 04:24:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=xJvKlkUF7eE8As79gdR5lqoyi4bsuHX51wblXwpON6s=; b=fg5
	I+J8/B0+zc3A8kaOV+jbURgsKtqzmVW+8WKiHhOhtMJZPyb8wfZk/rPf4jkuSXl8
	blRMpvN9MJFLNiNsylLB1vHnGJAesBQwIvFd2zGr7P0lNcKNuFltZKALRfto43GY
	JL+34Rcnn07l5A7biJ4LmyMBJZ7QyNc0XlNFL1iafqPMDuZk46nUHtJ1sFN1Uo/q
	ztV3YmaChZVlMFeu/xGZzkx3RTqNZTUu74uLDRT6cpQypjaG4OUeVfaSEyAgDCnG
	NNiTfVbcr+hDtm9rfscXGNnWi/pdQ4mJ2gtZIKP17JdOX5iicZvDpzOJQ5o9YAO8
	TxIbp6aKMxCkiWGdzxQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em6j46g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:24:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 04:24:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Apr 2024 04:24:32 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 10D773F7070;
	Thu,  4 Apr 2024 04:24:28 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>, <naveenm@marvell.com>
Subject: [net Patch] octeontx2-pf: Fix transmit scheduler resource leak
Date: Thu, 4 Apr 2024 16:54:27 +0530
Message-ID: <20240404112427.16805-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DSYpJLdrJPsGpP9aWzgDXLPX68pskJO1
X-Proofpoint-GUID: DSYpJLdrJPsGpP9aWzgDXLPX68pskJO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02

Inorder to support shaping and scheduling, Upon class creation
Netdev driver allocates trasmit schedulers.

The previous patch which added support for Round robin scheduling has
a bug due to which driver is not freeing transmit schedulers post
class deletion.

This patch fixes the same.

Fixes: 47a9656f168a ("octeontx2-pf: htb offload support for Round Robin scheduling")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 1e77bbf5d22a..1723e9912ae0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -382,6 +382,7 @@ static void otx2_qos_read_txschq_cfg_tl(struct otx2_qos_node *parent,
 		otx2_qos_read_txschq_cfg_tl(node, cfg);
 		cnt = cfg->static_node_pos[node->level];
 		cfg->schq_contig_list[node->level][cnt] = node->schq;
+		cfg->schq_index_used[node->level][cnt] = true;
 		cfg->schq_contig[node->level]++;
 		cfg->static_node_pos[node->level]++;
 		otx2_qos_read_txschq_cfg_schq(node, cfg);
-- 
2.17.1


