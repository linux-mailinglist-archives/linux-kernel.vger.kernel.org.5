Return-Path: <linux-kernel+bounces-42192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040083FDB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A70283E57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C845008;
	Mon, 29 Jan 2024 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="buZQcte2"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA6433D0;
	Mon, 29 Jan 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505818; cv=none; b=VRVCBzocEdz21UETe22SrIgdzLaVBktGHy8lHu/3OZgewHDi8PYZEAUaI+hfPkKH+2GfyM7eoUkaBS25TBsp1VCleu6x6fuxcpBwjQ5LR8ZtJ2Il8wJNdwwDgSzXWm6Cb6me5BgBQ6kVJMKes+Chv+v1C4GnGtX+a6ZtovTNZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505818; c=relaxed/simple;
	bh=WuGXrGunI7ZDPJMpuvINTAUYckE1gSj0UUksCGgPmws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVvh2hixGBwJx4RQ3lt768JF0JTaZNbT8OF0YcfBpkj47OgVNjQgmaJRWD7OA8b3k+Z47r0RTjJgjV+ETNy6u7Vk7Hsr8dD6RRtas804gyMZzwbLZ8a2hFv5Hj7EN1mBUFjuL3HiRO39augnEMdNXhoz4T+oHR/m78X35KVp/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=buZQcte2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40SMwEpN003458;
	Sun, 28 Jan 2024 21:23:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=Qa9HhoVz
	n4zP1E253GRsSQ1puLdjOdNbtpymgd+miZE=; b=buZQcte2JG+XSx+hiEXfr2Uv
	BIPzNoutgIumc21+C987ecYG28fkzPbPO7rTkIWhMZvV6Oxp/t4UyXHLyFW3NGEw
	9y2RAwLYNw/g6pJjJrVZy762f9+7jePWI5BpIXDZU77oT1hvEpjVyb65WUX3lrAN
	qU9e42yEbcX1XXat2nayjfefrGPlMzdDfxyKKVCO3UvZyCMLE4Bwr4mGy4fex2Dg
	cj5ho/UDGdVdEPjJ9pqPClenfGsd7hNumKDObT5WcvlO3uctn7zmwjosIQMWy9tN
	Gtv3ieaK7a/QaE6k/bra6cOD7lpIXpL+kXRKSLSX0Anzy3QcOLaAfEPdzWIAow==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vw27nbkm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:23:27 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 21:23:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 28 Jan 2024 21:23:25 -0800
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BA1A83F703F;
	Sun, 28 Jan 2024 21:23:21 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <bcreeley@amd.com>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sumang@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net v2] octeontx2-af: Initialize bitmap arrays.
Date: Mon, 29 Jan 2024 10:53:19 +0530
Message-ID: <20240129052319.4093083-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tFf9j0uh9YRSlsGmlA8JdK7GPsqtvsfc
X-Proofpoint-GUID: tFf9j0uh9YRSlsGmlA8JdK7GPsqtvsfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02

kmalloc_array() without __GFP_ZERO flag does not initialize
memory to zero. This causes issues with bitmap.
Use bitmap_zalloc() API to fix this issue.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

ChangeLogs:
v1 -> v2: Used bitmap_zalloc() API.
v0 -> v1: Removed devm_kcalloc()._
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 10 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 48 ++++++++-----------
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 43be37dd1f32..679bd6e87066 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -184,11 +184,11 @@ struct npc_mcam {
 	unsigned long	*bmap_reverse;	/* Reverse bitmap, bmap_entries => 0 */
 	u16	bmap_entries;	/* Number of unreserved MCAM entries */
 	u16	bmap_fcnt;	/* MCAM entries free count */
-	u16	*entry2pfvf_map;
-	u16	*entry2cntr_map;
-	u16	*cntr2pfvf_map;
-	u16	*cntr_refcnt;
-	u16	*entry2target_pffunc;
+	unsigned long	*entry2pfvf_map;
+	unsigned long	*entry2cntr_map;
+	unsigned long	*cntr2pfvf_map;
+	unsigned long	*cntr_refcnt;
+	unsigned long	*entry2target_pffunc;
 	u8	keysize;	/* MCAM keysize 112/224/448 bits */
 	u8	banks;		/* Number of MCAM banks */
 	u8	banks_per_entry;/* Number of keywords in key */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..367f842e365d 100644
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
+	bitmap_free(mcam->bmap);
+	bitmap_free(mcam->bmap_reverse);
+	bitmap_free(mcam->entry2pfvf_map);
+	bitmap_free(mcam->cntr2pfvf_map);
+	bitmap_free(mcam->entry2cntr_map);
+	bitmap_free(mcam->cntr_refcnt);
+	bitmap_free(mcam->entry2target_pffunc);
 	kfree(mcam->counters.bmap);
 }
 
@@ -1904,21 +1904,18 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
 
 	/* Allocate bitmaps for managing MCAM entries */
-	mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-				   sizeof(long), GFP_KERNEL);
+	mcam->bmap = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
 	if (!mcam->bmap)
 		return -ENOMEM;
 
-	mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-					   sizeof(long), GFP_KERNEL);
+	mcam->bmap_reverse = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
 	if (!mcam->bmap_reverse)
 		goto free_bmap;
 
 	mcam->bmap_fcnt = mcam->bmap_entries;
 
 	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
-	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+	mcam->entry2pfvf_map = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
 	if (!mcam->entry2pfvf_map)
 		goto free_bmap_reverse;
 
@@ -1941,27 +1938,24 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	if (err)
 		goto free_entry_map;
 
-	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
-					    sizeof(u16), GFP_KERNEL);
+	mcam->cntr2pfvf_map = bitmap_zalloc(mcam->counters.max, GFP_KERNEL);
 	if (!mcam->cntr2pfvf_map)
 		goto free_cntr_bmap;
 
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+	mcam->entry2cntr_map = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;
 
-	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
-					  sizeof(u16), GFP_KERNEL);
+	mcam->cntr_refcnt = bitmap_zalloc(mcam->counters.max, GFP_KERNEL);
 	if (!mcam->cntr_refcnt)
 		goto free_entry_cntr_map;
 
 	/* Alloc memory for saving target device of mcam rule */
-	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
-						  sizeof(u16), GFP_KERNEL);
+	mcam->entry2target_pffunc = bitmap_zalloc(mcam->total_entries,
+						  GFP_KERNEL);
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
@@ -1978,19 +1972,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	return 0;
 
 free_cntr_refcnt:
-	kfree(mcam->cntr_refcnt);
+	bitmap_free(mcam->cntr_refcnt);
 free_entry_cntr_map:
-	kfree(mcam->entry2cntr_map);
+	bitmap_free(mcam->entry2cntr_map);
 free_cntr_map:
-	kfree(mcam->cntr2pfvf_map);
+	bitmap_free(mcam->cntr2pfvf_map);
 free_cntr_bmap:
 	kfree(mcam->counters.bmap);
 free_entry_map:
-	kfree(mcam->entry2pfvf_map);
+	bitmap_free(mcam->entry2pfvf_map);
 free_bmap_reverse:
-	kfree(mcam->bmap_reverse);
+	bitmap_free(mcam->bmap_reverse);
 free_bmap:
-	kfree(mcam->bmap);
+	bitmap_free(mcam->bmap);
 
 	return -ENOMEM;
 }
-- 
2.25.1


