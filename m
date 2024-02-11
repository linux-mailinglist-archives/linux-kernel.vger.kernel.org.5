Return-Path: <linux-kernel+bounces-60916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4B850AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89551C2145D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218A5D487;
	Sun, 11 Feb 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BkD+fH+r"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3824FC19;
	Sun, 11 Feb 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678073; cv=none; b=lXvQodI1VC6BdQvUvpwuK2BpO5Eik4BB02cjt4CL00NfpzK304RW85/lMzDiP1d/ivh4Ws/lzaYlBtY4YIkugJKSvZoW+bandY32ogqyE9JGiGqUva9T/O7rBS8OoJwWu+6hk9lhVA+5i20Avp20eZSH5oGw58Yp/EGoXefMCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678073; c=relaxed/simple;
	bh=iXqgltiNWMeREVG2IgdwnDtKL7c9qYrYyK47aZwyx/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj0h2WmDdPkvQB4aLGZLcuI0cTtp8PnDfYdg8bZoXzT3KgnWtsh5OUd0wsOtqTgZNK3/2jyarqmGMvIp1Gz9lsg9VL337fm5abzczCuK74kSVSTcHGi/zim9xT3CBdZLZ1ydSo8HOxQbubjg66jRT5SeJmJOhMR/gw7plZrKWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BkD+fH+r; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41BHHFW8001164;
	Sun, 11 Feb 2024 11:00:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=VvbYldxYnXsS96SYiXwHOhAk8nowSqwq/5cF6ZdNFVE=; b=BkD
	+fH+riPTEveS5/MIPUfCTGyoLaQVqanKSqongD6EK2RcyCvUHNh4G0Gt5prabwvG
	5WfpvZY9hFyMaeQ5B0N5FDKFFWx6DagLvg0BZJ1x3+QH5CJj/Y6rmzxXN1Y7Bgx8
	33g+A3KyNYUqIC5xLQNgCQbTGnjHq8jMO2isks36jLY0Ekta2PPo1wSYcbxQNy6L
	unE8hfGx6rv9wPCdwQT6yQ7SGH9w4T9IE9tatb1L2vwwWZ/MQONGk8vld1RN2eZl
	Xqr/GcIxIhXnfywetPECmg7Ra8CfiHebMHqAYqj1n3qHd5fkAhT9eelMP7x7s2v8
	8ABQiTG4cq2tj3kD/Lw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkaf5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 11 Feb 2024 11:00:50 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 11 Feb
 2024 11:00:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 11 Feb 2024 11:00:44 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 27F9B3F7040;
	Sun, 11 Feb 2024 11:00:40 -0800 (PST)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: Remove the PF_FUNC validation for NPC transmit rules
Date: Mon, 12 Feb 2024 00:30:38 +0530
Message-ID: <1707678038-13062-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lOadyMm9hJ2FjQXRiqGWZMf2HnLd85ui
X-Proofpoint-GUID: lOadyMm9hJ2FjQXRiqGWZMf2HnLd85ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-11_17,2024-02-08_01,2023-05-22_02

NPC transmit side mcam rules can use the pcifunc (in packet metadata
added by hardware) of transmitting device for mcam lookup similar to
the channel of receiving device at receive side.
The commit 18603683d766 ("octeontx2-af: Remove channel verification
while installing MCAM rules") removed the receive side channel
verification to save hardware MCAM filters while switching packets
across interfaces but missed removing transmit side checks.
This patch removes transmit side rules validation.

Fixes: 18603683d766 ("octeontx2-af: Remove channel verification while installing MCAM rules")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    | 32 ----------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8cfd74a..e5d6156 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -61,28 +61,6 @@ int rvu_npc_get_tx_nibble_cfg(struct rvu *rvu, u64 nibble_ena)
 	return 0;
 }
 
-static int npc_mcam_verify_pf_func(struct rvu *rvu,
-				   struct mcam_entry *entry_data, u8 intf,
-				   u16 pcifunc)
-{
-	u16 pf_func, pf_func_mask;
-
-	if (is_npc_intf_rx(intf))
-		return 0;
-
-	pf_func_mask = (entry_data->kw_mask[0] >> 32) &
-		NPC_KEX_PF_FUNC_MASK;
-	pf_func = (entry_data->kw[0] >> 32) & NPC_KEX_PF_FUNC_MASK;
-
-	pf_func = be16_to_cpu((__force __be16)pf_func);
-	if (pf_func_mask != NPC_KEX_PF_FUNC_MASK ||
-	    ((pf_func & ~RVU_PFVF_FUNC_MASK) !=
-	     (pcifunc & ~RVU_PFVF_FUNC_MASK)))
-		return -EINVAL;
-
-	return 0;
-}
-
 void rvu_npc_set_pkind(struct rvu *rvu, int pkind, struct rvu_pfvf *pfvf)
 {
 	int blkaddr;
@@ -2851,12 +2829,6 @@ int rvu_mbox_handler_npc_mcam_write_entry(struct rvu *rvu,
 	else
 		nix_intf = pfvf->nix_rx_intf;
 
-	if (!is_pffunc_af(pcifunc) &&
-	    npc_mcam_verify_pf_func(rvu, &req->entry_data, req->intf, pcifunc)) {
-		rc = NPC_MCAM_INVALID_REQ;
-		goto exit;
-	}
-
 	/* For AF installed rules, the nix_intf should be set to target NIX */
 	if (is_pffunc_af(req->hdr.pcifunc))
 		nix_intf = req->intf;
@@ -3208,10 +3180,6 @@ int rvu_mbox_handler_npc_mcam_alloc_and_write_entry(struct rvu *rvu,
 	if (!is_npc_interface_valid(rvu, req->intf))
 		return NPC_MCAM_INVALID_REQ;
 
-	if (npc_mcam_verify_pf_func(rvu, &req->entry_data, req->intf,
-				    req->hdr.pcifunc))
-		return NPC_MCAM_INVALID_REQ;
-
 	/* Try to allocate a MCAM entry */
 	entry_req.hdr.pcifunc = req->hdr.pcifunc;
 	entry_req.contig = true;
-- 
2.7.4


