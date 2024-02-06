Return-Path: <linux-kernel+bounces-54210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D948284AC46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF171F24FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396346EB41;
	Tue,  6 Feb 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gECEq9Bn"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6A6E2A8;
	Tue,  6 Feb 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187230; cv=none; b=n9XSe3WqGhx5gK2GyZEbZNCc9iw3419PC1U7iuPpKmtFVR3gJ7eKL+5guXayM18pZwASOWh/fg4F7ckvt7jvN2TlrNrYKzg84v3clFvvE5oz2IFWikyu0nquFMQ+HmCd0D3Ik1p0CxK4PHQOPTn2JDHg519ZphSzy6pXtwoSh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187230; c=relaxed/simple;
	bh=554/SMyrxITigOVehx3nyTUdAXmq86rzKbc8ZsI5Dpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnNA6R6p3+gV2i3cjSawuLiNGt7o66wTOcg1mRbrHeq/3L/PewEhBcgjz/czGQQoGmw174eTQLkTyqGGX3iyKkZ9D0M5zt8uaHtK+O5a2sRIFj9OYRMrLOtFkFL1BsCKCM3vms3NVzX5cm4Xq9QDFH75IKWXpy/tIEs+FJZin9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gECEq9Bn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Mxdb4024639;
	Mon, 5 Feb 2024 18:40:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=Xnfjto22
	NaZBakIjy0kZNG1xU7eVaZSmtkgjvrHY/Ec=; b=gECEq9Bnk4Ft5wSEdn26AigP
	ZGcZdgT9zqLxBE+FW4icUPeddAf52CY13BBl5gT4QDipDyG6twmfMaVg46hv8og1
	wDsy9DxhKX9FnnLm4ceaxe4pzYDulrNsDpFhN4wJ9L2ZUQAgvokACw0Wrhj4jf38
	PWmchr7bQpildET00Ph20jS3a1gPTN4/MNExB1jvsZpJPu36DX8mfTGFN53a5BkK
	DNITet7TOT5M/ditRggehBDMC+GakpV76VQevmHEUEMNmXluc2+tohWh3PV5aIUL
	VlpYcDrP5PyneU1qF336XsebLwXKwMRZkvZKJdSz9RqvBmjQzg3JJd5XbKRHIg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w38y4gmqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:40:08 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 5 Feb
 2024 18:40:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 5 Feb 2024 18:40:06 -0800
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BDF2D3F70B3;
	Mon,  5 Feb 2024 18:40:02 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <bcreeley@amd.com>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sumang@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net v4] octeontx2-af: Initialize maps.
Date: Tue, 6 Feb 2024 08:10:00 +0530
Message-ID: <20240206024000.1070260-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HKkFmmPIHyiAJKcqDH49cUZHRlm6p-ny
X-Proofpoint-GUID: HKkFmmPIHyiAJKcqDH49cUZHRlm6p-ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02

kmalloc_array() without __GFP_ZERO flag does not initialize
memory to zero. This causes issues. Use kcalloc() for maps and
bitmap_zalloc() for bitmaps.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Brett Creeley <bcreeley@amd.com>
---

ChangeLogs:
v3 -> v4: Used kcalloc() for normal maps
v2 -> v3: Used GFP_ZERO for normal map arrays
v1 -> v2: Used bitmap_zalloc() API.
v0 -> v1: Removed devm_kcalloc()._
---
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..8cfd74ad991c 100644
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
@@ -1904,21 +1904,20 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
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
+	mcam->entry2pfvf_map = kcalloc(mcam->bmap_entries, sizeof(u16),
+				       GFP_KERNEL);
+
 	if (!mcam->entry2pfvf_map)
 		goto free_bmap_reverse;
 
@@ -1941,21 +1940,21 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	if (err)
 		goto free_entry_map;
 
-	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
-					    sizeof(u16), GFP_KERNEL);
+	mcam->cntr2pfvf_map = kcalloc(mcam->counters.max, sizeof(u16),
+				      GFP_KERNEL);
 	if (!mcam->cntr2pfvf_map)
 		goto free_cntr_bmap;
 
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+	mcam->entry2cntr_map = kcalloc(mcam->bmap_entries, sizeof(u16),
+				       GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;
 
-	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
-					  sizeof(u16), GFP_KERNEL);
+	mcam->cntr_refcnt = kcalloc(mcam->counters.max, sizeof(u16),
+				    GFP_KERNEL);
 	if (!mcam->cntr_refcnt)
 		goto free_entry_cntr_map;
 
@@ -1988,9 +1987,9 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
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


