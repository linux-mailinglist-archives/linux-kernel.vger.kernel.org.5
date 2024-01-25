Return-Path: <linux-kernel+bounces-38043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08983BA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ED11C25058
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA112B80;
	Thu, 25 Jan 2024 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dqBc5CC8"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF891946B;
	Thu, 25 Jan 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164486; cv=none; b=fllyMu640RPUga4ftecCbMbmObtgbJlY8fogRAj/mBnwEhbpjQBi0YFtZVB6M6Yn0K28mjELojkAlRF/jKi+Y5Aa4JC2moDQLYF/orb9l+W+whao3WRdm5m3v1NLi7mCxmfl/CopkAIUST1IUKAndPF5WmFRTYvldC9B6RJ0WJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164486; c=relaxed/simple;
	bh=FnfkkqccHSe0lKQ47tUgp/K/MjJqKcuMOvpOHtx7vHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWJZpu4sD5GNWTtZMqdlsaFekFosaN/oDPKP4SKjdeAhfMxOF34qQfNkQ+Ot95+IQpj/I4zCSPeLHdeRKqdXE/+8gTQtW2ReoefRx0Nk7twn+bDdbPSlnAkrKxN4pPkciiaAzX7PON3RkDTXMrRl9HsbRbFkSQkNxVoTngzUldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dqBc5CC8; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5MPQ1001531;
	Wed, 24 Jan 2024 22:34:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ssg5R7IX
	Q2HBVRLi5pUL1ySvNdQLzs4POVDyrzaTEhY=; b=dqBc5CC89YRo++f/711tBC3e
	ZaUFIXb/14lwr+xc/nXUhnPoOF7sKOg2uoJ+vvMMl6mAKnMqm2GB8Hm4zbDiY7N7
	s/u8+d7ZfxEWMOGEHJTHayIgPAY7qNHkz/Yl7qyn6X4dADBiozpXCelGHQmyJPhB
	6SpVNeiYCozupjmRJtq8X4qLdWwmTYCq25AhmWDJ0mRI91cPtiwUqnlWxvyLEswD
	ShJRSzf/YaO5TP0qSrXOzgCDniXPK3mzI5bhodhjVEGCwQeeLPeI33uYSycHQNil
	08icxJWubQv6lLjNJY0kYWVqLSPCWhb4OdtNrI9i81gegXiT+fJSMq6smirfgA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vuhehr68y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 22:34:23 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jan
 2024 22:34:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 24 Jan 2024 22:34:21 -0800
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A46B63F7084;
	Wed, 24 Jan 2024 22:34:17 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sbhatta@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <bcreeley@amd.com>,
        <sumang@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net v1] octeontx2-af: Initialize bitmap arrays.
Date: Thu, 25 Jan 2024 12:04:14 +0530
Message-ID: <20240125063414.3930526-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VCY6_cWjsCGYtF3_szK6QmATNm1RkP99
X-Proofpoint-GUID: VCY6_cWjsCGYtF3_szK6QmATNm1RkP99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02

kmalloc_array() without __GFP_ZERO flag does not initializes
memory to zero.  This causes issues with bitmap. Use __GFP_ZERO
to fix the issue.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

ChangeLogs:
v0 -> v1: Removed devm_kcalloc()._
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 167145bdcb75..b56def17a2ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1905,12 +1905,13 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 
 	/* Allocate bitmaps for managing MCAM entries */
 	mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-				   sizeof(long), GFP_KERNEL);
+				   sizeof(long), GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->bmap)
 		return -ENOMEM;
 
 	mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
-					   sizeof(long), GFP_KERNEL);
+					   sizeof(long),
+					   GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->bmap_reverse)
 		goto free_bmap;
 
@@ -1918,7 +1919,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 
 	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
 	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
-					     sizeof(u16), GFP_KERNEL);
+					     sizeof(u16),
+					     GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->entry2pfvf_map)
 		goto free_bmap_reverse;
 
@@ -1942,7 +1944,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 		goto free_entry_map;
 
 	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
-					    sizeof(u16), GFP_KERNEL);
+					    sizeof(u16),
+					    GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->cntr2pfvf_map)
 		goto free_cntr_bmap;
 
@@ -1950,18 +1953,21 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
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
 
 	/* Alloc memory for saving target device of mcam rule */
 	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
-						  sizeof(u16), GFP_KERNEL);
+						  sizeof(u16),
+						  GFP_KERNEL | __GFP_ZERO);
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;
 
-- 
2.25.1


