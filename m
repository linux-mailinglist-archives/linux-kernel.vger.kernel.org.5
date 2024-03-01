Return-Path: <linux-kernel+bounces-88294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24986DFC8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04D41F2348C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C346BFD4;
	Fri,  1 Mar 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JafJCWpQ"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0026AF86;
	Fri,  1 Mar 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291017; cv=none; b=Ew4XzU0ckHfYbDO5p7wole6/EekAL1JArQGUxypce/tIq+lGrXGIrMzMaoEODPuIH+VznvT+YOhC3FoIhiu3IslIIpB3AE3NuId1Hy1zFCwMCw64aegKvPamwAZQiCGLLZFj48NdZfHiDAU3Nf4LeU+K31l80S6fFF4CKIYpR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291017; c=relaxed/simple;
	bh=yiKp1zRHreL2bNW7ALQAcQFLBqkQH1Gdy5hcNVchko0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5zNa6t8HbfTOWf9fq/R185JkfuMB4ZhxfNeovDEh3MBZgLZMRO3KKiAYa8TGWkLMRZgFFsZcwWttvx3xZ+NsF3vVmILvxy2LQ/GJ+DSHjEU8gyLg3Njhyzv9qT5EVvyloHXMzxx/y91KlZsOd6OFVe94IHglrH1sf/Fx7/Zp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JafJCWpQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4219mhrk013735;
	Fri, 1 Mar 2024 03:03:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=69b8YalajgMm+7NNElTefL9mv/sranlkLmD27HQxiW4=; b=Jaf
	JCWpQHVEEUPkJCHYgcJ8+CIxgNgNl9a6Pvai0nD+SMmKiCDeiHen+l9s1HcEhgDY
	93kcbCDKQrSk413q2IVjDfNo88o4zJs0S4hG1ZHcunIu8fUPLRyj9GjTCOX00vao
	Udc9/eNMvEW6ZmyagN8slZuNwFB6Lih+Neefd5Ii2Gk6rJbdnAYb2eGXubJ7fYjz
	L1q6riZJW5uTXAmfFb2Qc/uBbALdZqyi/gyxSMwlgQ/Rk0hqYGcnwUHg+F9XmLpI
	R4HH4KpFt61URYzwH0d3xQMIxQms2z6Otn4rrq9S76zNVELimZOXrDrtYoK01/Ac
	U5WMLhqnn7c9kBPetlA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wkcq586jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 03:03:22 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 03:03:22 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 1 Mar 2024 03:03:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 1 Mar 2024 03:03:19 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A99D93F70BA;
	Fri,  1 Mar 2024 03:03:15 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next] Octeontx2-af: Fix an issue in firmware shared data reserved space
Date: Fri, 1 Mar 2024 16:33:14 +0530
Message-ID: <20240301110314.29800-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: A5x86uW0VDTqloCxKJOamJrdgwXO7Xmj
X-Proofpoint-ORIG-GUID: A5x86uW0VDTqloCxKJOamJrdgwXO7Xmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_08,2024-03-01_01,2023-05-22_02

The last patch which added support to extend the firmware shared
data to add channel data information has introduced a bug due to
the reserved space not adjusted accordingly.

This patch fixes the issue and also adds BUILD_BUG to avoid this
regression error.

Fixes: 997814491cee ("Octeontx2-af: Fetch MAC channel info from firmware")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index edd12d09dc89..07d4859de53a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -817,6 +817,8 @@ static int rvu_fwdata_init(struct rvu *rvu)
 	err = cgx_get_fwdata_base(&fwdbase);
 	if (err)
 		goto fail;
+
+	BUILD_BUG_ON(offsetof(struct rvu_fwdata, cgx_fw_data) > FWDATA_CGX_LMAC_OFFSET);
 	rvu->fwdata = ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
 	if (!rvu->fwdata)
 		goto fail;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index de8eba902276..f390525a6217 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -469,11 +469,12 @@ struct rvu_fwdata {
 	u32 ptp_ext_clk_rate;
 	u32 ptp_ext_tstamp;
 	struct channel_fwdata channel_data;
-#define FWDATA_RESERVED_MEM 1014
+#define FWDATA_RESERVED_MEM 958
 	u64 reserved[FWDATA_RESERVED_MEM];
 #define CGX_MAX         9
 #define CGX_LMACS_MAX   4
 #define CGX_LMACS_USX   8
+#define FWDATA_CGX_LMAC_OFFSET 10536
 	union {
 		struct cgx_lmac_fwdata_s
 			cgx_fw_data[CGX_MAX][CGX_LMACS_MAX];
-- 
2.17.1


