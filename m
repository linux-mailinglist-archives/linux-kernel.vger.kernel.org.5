Return-Path: <linux-kernel+bounces-121599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE6A88EAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486B11F2F9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3F130E3F;
	Wed, 27 Mar 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IaGEHI4s"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31592130AD4;
	Wed, 27 Mar 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555449; cv=none; b=FbW8wmOa43QkNnwqcjKPlvrtBZ0GWZNseasOV5ENao5//CvebW+wy/pLOLe7QbEkmS0T1GSjfiwfHmkAQ+yMEfgoql3TKC7UEzK4S9HyZCbnhh/YV643G3Cg8FniKsd+om2fR0te96LFW7OQTmNfAdmrEVQz3tgYQi2gBf30LPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555449; c=relaxed/simple;
	bh=EAl8P8Qu7HPovX2acDv9ASr+MGLmIaZBZzWZbWqy+fM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaPixLc3R4cOMMIAYg1IkZfDX9WACiaB6dJa6m7+sz9PFInxGmzBfUBTLbXwaH1u21TkN4onTqoUxNO19mbWx+PXDugXWHS+Rjov7Im77oVeFkQMkZ47QvyhjtuWA50GOotu0ox1OdfdexIwtat2iKCLEvY7iPQBzcKrylVlnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IaGEHI4s; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RBDJFw011638;
	Wed, 27 Mar 2024 09:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=l2wIJJIu1OyJZqHPUqPbUVIbvJ+2femMu87XHi1/E0U=; b=IaG
	EHI4sx5+pmerEXAa/7gBfAlYIK5pg1+gQthJylZesQkCo9nohAReWbO71RjsB6m8
	5ioEnoyOqTCaN4WU53iqRrX2sQJ8coppYJEt1A7tBz4Gu4mij0i+i8qR00Vc1Bbx
	AbezqWYL3ILfRDmDoINs1jEbb5G9WtZB5xR3MHB9QI1MG8CWTFRqUhVy2B/cJpev
	dknZJ2Hz1XnDCV4n/bJ7sDyJmFYGAZq7D0PJMbRTWXP3j9/wbalzkM3FltjJ+h9L
	Fw4GgN51LR3YjVJAc4Qjn6/OjPzRvQ2saOcCQ3y0JPJqB/kM3f46bhOYfsDfYl43
	3Q6uNAHWpyap80O7+Og==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x4jd1h6jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 09:03:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 27 Mar 2024 09:03:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 27 Mar 2024 09:03:53 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 09BC33F70BF;
	Wed, 27 Mar 2024 09:03:49 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch] octeontx2-af: map management port always to first PF
Date: Wed, 27 Mar 2024 21:33:48 +0530
Message-ID: <20240327160348.3023-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: OMJzMb6F2IwpDI-GKlpAh1G8C7BNSkGG
X-Proofpoint-ORIG-GUID: OMJzMb6F2IwpDI-GKlpAh1G8C7BNSkGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02

The user can enable or disable any MAC block or a few ports of the
block. The management port's interface name varies depending on the
setup of the user if its not mapped to the first pf.

The management port mapping is now configured to always connect to the
first PF. This patch implements this change.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 60 +++++++++++++++----
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eb2a20b5a0d0..105d2e8f25df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -638,7 +638,10 @@ struct cgx_lmac_fwdata_s {
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1021
+	u32 lmac_type;
+	u32 portm_idx;
+	u64 mgmt_port:1;
+#define LMAC_FWDATA_RESERVED_MEM 1019
 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 72e060cf6b61..446344801576 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -118,15 +118,40 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
 		pfvf->nix_blkaddr = BLKADDR_NIX1;
 }
 
-static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
+static bool rvu_cgx_is_mgmt_port(struct rvu *rvu, int cgx_id, int lmac_id)
+{
+	struct cgx_lmac_fwdata_s *fwdata;
+
+	fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
+	if (fwdata->mgmt_port)
+		return true;
+
+	return false;
+}
+
+static void __rvu_map_cgx_lmac_pf(struct rvu *rvu, int pf, int cgx, int lmac)
 {
 	struct npc_pkind *pkind = &rvu->hw->pkind;
+	int numvfs, hwvfs;
+	int free_pkind;
+
+	rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
+	rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
+	free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
+	pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;
+	rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
+	rvu->cgx_mapped_pfs++;
+	rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
+	rvu->cgx_mapped_vfs += numvfs;
+}
+
+static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
+{
 	int cgx_cnt_max = rvu->cgx_cnt_max;
 	int pf = PF_CGXMAP_BASE;
 	unsigned long lmac_bmap;
-	int size, free_pkind;
 	int cgx, lmac, iter;
-	int numvfs, hwvfs;
+	int size;
 
 	if (!cgx_cnt_max)
 		return 0;
@@ -155,6 +180,24 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 		return -ENOMEM;
 
 	rvu->cgx_mapped_pfs = 0;
+
+	/* Map mgmt port always to first PF */
+	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
+		if (!rvu_cgx_pdata(cgx, rvu))
+			continue;
+		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
+		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu), iter);
+			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac)) {
+				__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
+				pf++;
+				goto non_mgmtport_mapping;
+			}
+		}
+	}
+
+non_mgmtport_mapping:
+
 	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
 		if (!rvu_cgx_pdata(cgx, rvu))
 			continue;
@@ -162,14 +205,9 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
 			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
 					      iter);
-			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
-			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
-			free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
-			pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;
-			rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
-			rvu->cgx_mapped_pfs++;
-			rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
-			rvu->cgx_mapped_vfs += numvfs;
+			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac))
+				continue;
+			__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
 			pf++;
 		}
 	}
-- 
2.17.1


