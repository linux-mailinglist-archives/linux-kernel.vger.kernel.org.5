Return-Path: <linux-kernel+bounces-45686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED816843419
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850E41F25027
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526FE544;
	Wed, 31 Jan 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DmspMxIU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE9DF4F;
	Wed, 31 Jan 2024 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668898; cv=none; b=g/B7YmGc5J9WAiNQ6yYJHXfwiIHNz7GQRugguTrvB1krw4+c7QT/qp/j+sGCK3hAE0+4/8O+Gzk32h8KqfO3xMnzrr2PtuWqPl6LOuNTpNabdQgdpeToZqT7HlezlrqCvTTMpm/+9KVRRP+WMAfbqQkPrtXq+qQ0Fd3zU1ZSsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668898; c=relaxed/simple;
	bh=SpP0n7qUbRbx0Z/5WUWqTEu1Bwjbet1DG+VdV9GFzU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YSA8jzSdPFg5Ctue3qDVQTVhPhLFEHXB/8Tyly9+RvFO00/GsoIfYLv0GVgaIZTyujSlhTWjqdhW9c4dlGLpj8Occ4kbt+PFeCrND7w9T6dcG8HuiYvKqKwYbJoBcTCDc8Dd/TuUZYFcUyHO+yqKh8Z7sYVEKaD31mztht6sXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DmspMxIU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UHmG0W011647;
	Tue, 30 Jan 2024 18:41:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=T/f72Ewe
	AdptrK0eSwQ0fHYQUvbfFrB/+zpPieRXY40=; b=DmspMxIUbwYJQswKDCnQjXzZ
	qPPRn7iMgmHQ5MXtXfnPLfGvt0onKQ7uCsQaAlAuefojc5Wg63vQolevkhmQfzvU
	6LH6cieEHqCIwv30Fg2T64IUaLKiRcRqf+7uBmDOoY5G1/FOrQrGQCDilXz8d/Su
	6rXOyRGBqecx9Ns8O31Mrs+o+VGjKGNOSk6cIq3yH4UASgGdc4bsyLc6Xl9spKl2
	0mrzEIE+w+/SFcORmDqLNPFDpHpuLL4LuohEM6zjF/aAJg8tNDFWeCnebNbMY44j
	UR/paCrGpRxJYyGvl4uoBMwAB08IN35+9WejXI/Khzz1mlpWU9xCTh09VucuZw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vw27nmvbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 18:41:26 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jan
 2024 18:41:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 30 Jan 2024 18:41:24 -0800
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 92B963F707A;
	Tue, 30 Jan 2024 18:41:20 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <bcreeley@amd.com>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sumang@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net v3] octeontx2-af: Initialize maps.
Date: Wed, 31 Jan 2024 08:11:18 +0530
Message-ID: <20240131024118.254758-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _yekNxsZxU1Br4UnRXM_74qZkIY35-l2
X-Proofpoint-GUID: _yekNxsZxU1Br4UnRXM_74qZkIY35-l2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02

kmalloc_array() without __GFP_ZERO flag does not initialize
memory to zero. This causes issues. Use __GFP_ZERO flag for maps and
bitmap_zalloc() for bimaps.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---

ChangeLogs:
v2 -> v3: Used GFP_ZERO for normal map arrays
v1 -> v2: Used bitmap_zalloc() API.
v0 -> v1: Removed devm_kcalloc()._
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..6a8f0efd96a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1850,8 +1850,8 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;

-	kfree(mcam->bmap);
-	kfree(mcam->bmap_reverse);
+	bitmap_free(mcam->bmap);
+	bitmap_free(mcam->bmap_reverse);
 	kfree(mcam->entry2pfvf_map);
 	kfree(mcam->cntr2pfvf_map);
 	kfree(mcam->entry2cntr_map);
@@ -1904,13 +1904,11 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
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

@@ -1918,7 +1916,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)

 	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
 	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+					     sizeof(u16),
+					     GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->entry2pfvf_map)
 		goto free_bmap_reverse;

@@ -1942,7 +1941,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 		goto free_entry_map;

 	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
-					    sizeof(u16), GFP_KERNEL);
+					    sizeof(u16),
+					    GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->cntr2pfvf_map)
 		goto free_cntr_bmap;

@@ -1950,12 +1950,14 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	 * counter's reference count.
 	 */
 	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+					     sizeof(u16),
+					     GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;

 	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
-					  sizeof(u16), GFP_KERNEL);
+					  sizeof(u16),
+					  GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->cntr_refcnt)
 		goto free_entry_cntr_map;

@@ -1988,9 +1990,9 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 free_entry_map:
 	kfree(mcam->entry2pfvf_map);
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

