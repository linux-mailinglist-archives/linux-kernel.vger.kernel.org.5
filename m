Return-Path: <linux-kernel+bounces-118374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C6C88B9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7382E2C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F5129A7A;
	Tue, 26 Mar 2024 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PhLlobJ6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82373514;
	Tue, 26 Mar 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711430869; cv=none; b=largFgmtDgvhY7KaaHgWOmFVfWTbquDFydzsYGR0DlLu8tXc/xlX/80IKAxRWNIyQqVYfZvm+RMo37LvpeOORTlISCYt5TwrOJqsxQjNsu5ypRQYOo8myXzppYZjX63Tqai2nRCU+jnjEtQUz4varuCgZEXfl9h7CkpsNHRiPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711430869; c=relaxed/simple;
	bh=06dXxBLiOrl6TdqrE6Pa27CkCxaUTmIdj95kLEwykrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyjxZJi4X01claG9nAn1wSdIPkoHrG93419CfU+s0FqppGO3rroVQLDdziB936zgZ0NXRVMDrEiKRYXfY65Frnjmbhffg8V3SYtGGHuhVZ8SbCRS5FLUuWm4U19DYLFGXIJdVWW+GSz2dspPhJZgiLFPCfIafgL9hG+hAZDup7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PhLlobJ6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PMJ07g009327;
	Mon, 25 Mar 2024 22:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=8MsNSdXuBp9bdUk2EdxRLOp5uCAw6leFBrEgp3+ZTcM=; b=PhL
	lobJ6GjzjXLRzijr1CCZegAxwusxR8Li/hr5ePp679lUtgmNS52A517XRLFkyRaj
	LfwOMIgYUbSodFMJpBhv6p68zo7v3/YLsGHV4V6U+RLEdFhnnve7UF6y/hokOs/w
	8xJTiiX8LLZH4K8qlV2bXpH1Cg0v/AUI3BXifspv4XlyQeuz7uaAmtlc144WLKaC
	uVrWm7pX6hi3gG+VHrnVoe0y/eaoPuL189SRGLRhGrovcQ3baJwLL+X4gRFDV1XG
	yWOXF2gyaYgYIKbfXBbh2aOcpiDdtuueZEzkhdL/atughPxdGOObTHKa/nycW/1s
	ADxuVR5bUD0JA8K3Mag==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x3hy1s73a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 22:27:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 25 Mar 2024 22:27:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:26 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0B31C3F703F;
	Mon, 25 Mar 2024 22:27:21 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net PATCH] Octeontx2-af: fix pause frame configuration in GMP mode
Date: Tue, 26 Mar 2024 10:57:20 +0530
Message-ID: <20240326052720.4441-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: wNMhb4OOreSLR_6kItPMSkXtgcJacLbA
X-Proofpoint-ORIG-GUID: wNMhb4OOreSLR_6kItPMSkXtgcJacLbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02

The Octeontx2 MAC block (CGX) has separate data paths (SMU and GMP) for
different speeds, allowing for efficient data transfer.

The previous patch which added pause frame configuration has a bug due
to which pause frame feature is not working in GMP mode.

This patch fixes the issue by configurating appropriate registers.

Fixes: f7e086e754fe ("octeontx2-af: Pause frame configuration at cgx")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 3c0f55b3e48e..b86f3224f0b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -808,6 +808,11 @@ static int cgx_lmac_enadis_pause_frm(void *cgxd, int lmac_id,
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 
+	cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
+	cfg &= ~CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
+	cfg |= rx_pause ? CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK : 0x0;
+	cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
+
 	cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
 	cfg &= ~CGX_SMUX_RX_FRM_CTL_CTL_BCK;
 	cfg |= rx_pause ? CGX_SMUX_RX_FRM_CTL_CTL_BCK : 0x0;
-- 
2.17.1


