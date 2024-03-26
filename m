Return-Path: <linux-kernel+bounces-118965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B688C202
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7A22C20B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A57F7E0;
	Tue, 26 Mar 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dmr45xrb"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE171B24;
	Tue, 26 Mar 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455729; cv=none; b=qLR2KAgqWokqkuulK11vtqaR1TM9VwimFON6pYTF3j5z43lbPDZMsSRgbDU0AoOu/Xug4zeFjSF5HLqybZIlB7NZryZ8rF5TEBXbY3nZ6cll/ObjOIOHbGkPJ0Dn9JeKfB/OCiSE6M89wBgSzs7GnIanjdhxrqj/YZufkoZhkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455729; c=relaxed/simple;
	bh=deFxA3Wuj8SlRNBvbVPEKsNDOYmV5l4G649FOt1wOrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qI11m4rvSz5ENhqDEaknuQPXaSzGrcd1xwtvd6KkSs/08DSWj27gS9nih+8ARnnPgutesE89t2gbJ9Rw697g4Q55BVUOQ7+3xyStW9dsvL2HKSOolNTh3R2ZfSKZ6pEcy6Xe+RvNqSabe62A0aJ5BOpky7KW7R/LVbCYtbgHp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dmr45xrb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QB9sYD015440;
	Tue, 26 Mar 2024 05:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=c4Jux4wLKHVwolXHnHDW2QYhlDWWrBk745gJOqZmmLY=; b=Dmr
	45xrb0p2MR1BqGdosh9N53NdZZIYK9Q55ckUkw/wDw+vUsyn2zMbsOctNxt/4lDc
	lR5lAlztPziHHhQQtWKZZbf8D0WHK7o5ncfyDl1W6PDTwL3woygcIUiXNeGhXXkJ
	J2FLpXmtWOU+B4TULk+5Sw6fTVF+Gxcs688inDlJKweeS2oZbkhJocyqBSfgxCfk
	+kEBQ6GIsDGo54OcsyXFTvYdjU14se6OpcC727MQh/A4pcG8NMVuCzI5ymQmGReH
	1mtGh7TTxCYyCli5RfHLqJ+qrqOFxQpOTbMU7p8qOQROneZ8GImCUyxCkd6EhOpG
	LVXETxEsGtloOJlDGZg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x3twtgqma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 05:21:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 26 Mar 2024 05:21:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 26 Mar 2024 05:21:54 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B07863F706D;
	Tue, 26 Mar 2024 05:21:50 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net Patch] octeontx2-af: Fix issue with loading coalesced KPU profiles
Date: Tue, 26 Mar 2024 17:51:49 +0530
Message-ID: <20240326122149.4377-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GNGMqGgfdrzuNBFSYnn2bGr-vpVeevsZ
X-Proofpoint-ORIG-GUID: GNGMqGgfdrzuNBFSYnn2bGr-vpVeevsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02

The current implementation for loading coalesced KPU profiles has
a limitation.  The "offset" field, which is used to locate profiles
within the profile is restricted to a u16.

This restricts the number of profiles that can be loaded. This patch
addresses this limitation by increasing the size of the "offset" field.

Fixes: 11c730bfbf5b ("octeontx2-af: support for coalescing KPU profiles")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index e350242bbafb..be709f83f331 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1657,7 +1657,7 @@ static int npc_fwdb_detect_load_prfl_img(struct rvu *rvu, uint64_t prfl_sz,
 	struct npc_coalesced_kpu_prfl *img_data = NULL;
 	int i = 0, rc = -EINVAL;
 	void __iomem *kpu_prfl_addr;
-	u16 offset;
+	u32 offset;
 
 	img_data = (struct npc_coalesced_kpu_prfl __force *)rvu->kpu_prfl_addr;
 	if (le64_to_cpu(img_data->signature) == KPU_SIGN &&
-- 
2.17.1


