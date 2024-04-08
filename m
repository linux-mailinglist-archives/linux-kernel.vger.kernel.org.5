Return-Path: <linux-kernel+bounces-134840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC989B7B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33379281E76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C51802E;
	Mon,  8 Apr 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BAFpQRgR"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3010976;
	Mon,  8 Apr 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558222; cv=none; b=ISDYA7W6LgzusHi3PWG/qz4fkfoWvXiUAtW9plgj5+HkaeBl9KPgNq6XC/iuE4lpOf8p6FJQAkFzeYXpqHdF6wl5+gnkUyvykY9PjRh1XqPUyURq3cwlky1owtI6lhoSWgBEpDDilBkwv2451yW0dgoANJvVX8XacxdEmiGoA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558222; c=relaxed/simple;
	bh=tBs/YJ2fLDfrIVtxpGytKjKUVc/9/3IKnSLB8drjLUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbjtPECDNWAQtlhUVz5Enblm2kEs01Db9DcIGNSO0gK6rztgMA4VYSx3uoGTQGg0v0trL+IXREFV9E9RG7CWFM3I9RBmWFet5zap2wgL2XS+gmdJ1/HfsgDrNsbArPuv5XHHR+5zBUnwHk4XolpxJdqUBbVpl63uXl0EAgIHylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BAFpQRgR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437MmxNx020481;
	Sun, 7 Apr 2024 23:36:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=j/ahPDX2/GgpboNxFpPN/xXlJANbz5Sc0e/KSoo81V4=; b=BAF
	pQRgRG+tEooBaHX01dRwo2mFRCFsbGKRxx9TibWa+hgVHw/1NYV+f/oHKWy2kWhw
	IGASlCahmeMdP6IYHfwDr3rqR1nifgjxhWMVBcwI+bxPZqd21y/G64YApFwyGnpo
	oklZHOGEKxF3VgRDqIMnIRG+n49ZeoWtYOdovYTHS1K5NC9TGNNXcnYMPhgD1PHA
	q5zoipkjgV+OByhGUYiCq17bKgwMpoeGZz7rYZyZIF6EBsxUybGny6bAeqdLgDcN
	dTsrVmRB+UFsx9s1hSQCD/FJ4f7gin6Tcq3Xqj3/fvmbCsc6uAa128K4txM184zo
	E2nV2MwhhtAkvSeaTvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xbdd4b15d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 23:36:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 23:36:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 7 Apr 2024 23:36:47 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 4397C3F70AE;
	Sun,  7 Apr 2024 23:36:44 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix NIX SQ mode and BP config
Date: Mon, 8 Apr 2024 12:06:43 +0530
Message-ID: <20240408063643.26288-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8kyiDbbuHG5iSCnc8S6gEGh5qqReZe-U
X-Proofpoint-GUID: 8kyiDbbuHG5iSCnc8S6gEGh5qqReZe-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_05,2024-04-05_02,2023-05-22_02

NIX SQ mode and link backpressure configuration is required for
all platforms. But in current driver this code is wrongly placed
under specific platform check. This patch fixes the issue by 
moving the code out of platform check.

Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d39001cdc707..00af8888e329 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4819,18 +4819,18 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 		 */
 		rvu_write64(rvu, blkaddr, NIX_AF_CFG,
 			    rvu_read64(rvu, blkaddr, NIX_AF_CFG) | 0x40ULL);
+	}
 
-		/* Set chan/link to backpressure TL3 instead of TL2 */
-		rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
+	/* Set chan/link to backpressure TL3 instead of TL2 */
+	rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
 
-		/* Disable SQ manager's sticky mode operation (set TM6 = 0)
-		 * This sticky mode is known to cause SQ stalls when multiple
-		 * SQs are mapped to same SMQ and transmitting pkts at a time.
-		 */
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
-		cfg &= ~BIT_ULL(15);
-		rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
-	}
+	/* Disable SQ manager's sticky mode operation (set TM6 = 0)
+	 * This sticky mode is known to cause SQ stalls when multiple
+	 * SQs are mapped to same SMQ and transmitting pkts at a time.
+	 */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
+	cfg &= ~BIT_ULL(15);
+	rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
 
 	ltdefs = rvu->kpu.lt_def;
 	/* Calibrate X2P bus to check if CGX/LBK links are fine */
-- 
2.25.1


