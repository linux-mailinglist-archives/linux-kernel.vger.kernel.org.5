Return-Path: <linux-kernel+bounces-34718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03455838697
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713B01F233C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE003C29;
	Tue, 23 Jan 2024 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P41N03rK"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347632107;
	Tue, 23 Jan 2024 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986789; cv=none; b=HEWr9al35Zlt0F0samEKxmz2uThIhVjKqKFT6Cklk+dxZg6ctvjxgxxEq55btggg6je3LZhE3NMc/CabSLUJKVx3/egClQHlDS8QWJUvWp3GbZjaT0LbQ1yU/mhL2OaUIZeCLu7YPJdcPydVfoXx5laBahOdLgneN8gj2JAATmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986789; c=relaxed/simple;
	bh=a1TBqaaUsQPZKdtcmRl+G4jKCEl+jJJ1H8eSCwKaT78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpA7UuEdgjAx68eFgd4JPfHA9LHE8bjPNX8YhJbOln6zbXIGjcpDkoNxe27UtN0KCrktA5uyOdhkUA/hj6pbhULTzi2kbs0e05Kcny/pVFzwJv4jiLhBXD7Jz3wccN+EUxChZTiFjo0ocQlh8KM27IDxiZwKkZAlgqHtd6NNnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P41N03rK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N3s5Xt021322;
	Mon, 22 Jan 2024 21:13:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=qKtxjADE
	4ZUb6j3GQMrUdJpi8zccRiI9JMEvJ/dxOow=; b=P41N03rKS/4HSK4D0nfVV1oy
	hkoHmynDq1RMu5GNMZg/lGk3Sh6ZorEQbmDPoSli3M+gU27wRYVZK7g1N+/NS0Ml
	5mbFCIwvpx0fkh1Ibi2FVZaUk/rDmcWk6sTKmIK2sqHgc+WY94PGhJY4HQRG8HEr
	4+KR556voWyAmY83vq9aimkMFt7dxu3mTUoVqpxb9jQqd06DX+8orV5hlQQAMwTn
	JykbVroT/AepKREZjnXZxfWV8n/t0bhzDh40jHrsQ3dsNpcH1bJJYHUOCZluv1co
	nFnhZzvf4aVgeDJREmlgiLe/n1LfC54oX3r9bLRY9LizGy9S3aa+2YNNd9uVwQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vt5y2069s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 21:13:00 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 21:12:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 22 Jan 2024 21:12:58 -0800
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B983F3F7070;
	Mon, 22 Jan 2024 21:12:54 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sbhatta@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Date: Tue, 23 Jan 2024 10:42:45 +0530
Message-ID: <20240123051245.3801246-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Coa9FADqEpO7hOKVYBuhhotB-nd5lvzV
X-Proofpoint-ORIG-GUID: Coa9FADqEpO7hOKVYBuhhotB-nd5lvzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02

kmalloc_array() does not initializes memory to zero.
This causes issues with bitmap. Use devm_kcalloc()
to fix the issue.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 55 ++++++++++---------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..7539e6f0290a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1850,13 +1850,13 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 
-	kfree(mcam->bmap);
-	kfree(mcam->bmap_reverse);
-	kfree(mcam->entry2pfvf_map);
-	kfree(mcam->cntr2pfvf_map);
-	kfree(mcam->entry2cntr_map);
-	kfree(mcam->cntr_refcnt);
-	kfree(mcam->entry2target_pffunc);
+	devm_kfree(rvu->dev, mcam->bmap);
+	devm_kfree(rvu->dev, mcam->bmap_reverse);
+	devm_kfree(rvu->dev, mcam->entry2pfvf_map);
+	devm_kfree(rvu->dev, mcam->cntr2pfvf_map);
+	devm_kfree(rvu->dev, mcam->entry2cntr_map);
+	devm_kfree(rvu->dev, mcam->cntr_refcnt);
+	devm_kfree(rvu->dev, mcam->entry2target_pffunc);
 	kfree(mcam->counters.bmap);
 }
 
@@ -1904,21 +1904,22 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
 
 	/* Allocate bitmaps for managing MCAM entries */
-	mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-				   sizeof(long), GFP_KERNEL);
+	mcam->bmap = devm_kcalloc(rvu->dev, BITS_TO_LONGS(mcam->bmap_entries),
+				  sizeof(long), GFP_KERNEL);
 	if (!mcam->bmap)
 		return -ENOMEM;
 
-	mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-					   sizeof(long), GFP_KERNEL);
+	mcam->bmap_reverse = devm_kcalloc(rvu->dev,
+					  BITS_TO_LONGS(mcam->bmap_entries),
+					  sizeof(long), GFP_KERNEL);
 	if (!mcam->bmap_reverse)
 		goto free_bmap;
 
 	mcam->bmap_fcnt = mcam->bmap_entries;
 
 	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
-	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+	mcam->entry2pfvf_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
+					    sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2pfvf_map)
 		goto free_bmap_reverse;
 
@@ -1941,27 +1942,27 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	if (err)
 		goto free_entry_map;
 
-	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
-					    sizeof(u16), GFP_KERNEL);
+	mcam->cntr2pfvf_map = devm_kcalloc(rvu->dev, mcam->counters.max,
+					   sizeof(u16), GFP_KERNEL);
 	if (!mcam->cntr2pfvf_map)
 		goto free_cntr_bmap;
 
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+	mcam->entry2cntr_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
+					    sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;
 
-	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
-					  sizeof(u16), GFP_KERNEL);
+	mcam->cntr_refcnt = devm_kcalloc(rvu->dev, mcam->counters.max,
+					 sizeof(u16), GFP_KERNEL);
 	if (!mcam->cntr_refcnt)
 		goto free_entry_cntr_map;
 
 	/* Alloc memory for saving target device of mcam rule */
-	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
-						  sizeof(u16), GFP_KERNEL);
+	mcam->entry2target_pffunc = devm_kcalloc(rvu->dev, mcam->total_entries,
+						 sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
@@ -1978,19 +1979,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	return 0;
 
 free_cntr_refcnt:
-	kfree(mcam->cntr_refcnt);
+	devm_kfree(rvu->dev, mcam->cntr_refcnt);
 free_entry_cntr_map:
-	kfree(mcam->entry2cntr_map);
+	devm_kfree(rvu->dev, mcam->entry2cntr_map);
 free_cntr_map:
-	kfree(mcam->cntr2pfvf_map);
+	devm_kfree(rvu->dev, mcam->cntr2pfvf_map);
 free_cntr_bmap:
 	kfree(mcam->counters.bmap);
 free_entry_map:
-	kfree(mcam->entry2pfvf_map);
+	devm_kfree(rvu->dev, mcam->entry2pfvf_map);
 free_bmap_reverse:
-	kfree(mcam->bmap_reverse);
+	devm_kfree(rvu->dev, mcam->bmap_reverse);
 free_bmap:
-	kfree(mcam->bmap);
+	devm_kfree(rvu->dev, mcam->bmap);
 
 	return -ENOMEM;
 }
-- 
2.25.1


