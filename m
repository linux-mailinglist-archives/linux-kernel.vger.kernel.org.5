Return-Path: <linux-kernel+bounces-95369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4B874CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F3BB20E73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53571126F3E;
	Thu,  7 Mar 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Tr7xuXde"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357B125DC;
	Thu,  7 Mar 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809027; cv=none; b=X9ml+BxO846GxEtp0sZIIx1KTDOF0JeIKoiaToopa7dLFO4L1h6/IeKXNR+pbJij1c+aQjHeLSGsSdNRz7k5vDAVhgt9A/30fnl7RX+CkMGHSyGGd3b5dThqB5jUKZ7Be2HcA2UR3JuDVbHT3Vzf8BvNeOtn8yKLg2ClpIECqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809027; c=relaxed/simple;
	bh=WM12WLtYAz2cxFua0kfokyW2yT1caSiNtxTO/r91NvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4t35sYIxy9oaMX4cDsMoHSO4SLPYaZOHDzRHvOTKOW+7Djoz33edfHKtMwA/2JDdZj7+wjL4h7p6i2sCjsitehlmhdhG1X6aKGtcYCqEmE/WuWAPQc33UGQzO85sKT0STxNz2D10Ra7ZQjJhm4OWmYH0jdt1J45m2nTA+3m83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Tr7xuXde; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275jbOD008239;
	Thu, 7 Mar 2024 02:56:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=3BqF1EAT
	OqrJt33ZWiXXxcwocmc1ljkbIFVDyslFIyU=; b=Tr7xuXdeg+rnUJzwKY9nMzXp
	L4l3o8YQV7IG2E264x6uPkPy4RlOTaInL8BKtFxlwj3B+dzfRrHoymwjwryKFe8H
	V9QesUG63+yYbRaYZCVaoxsWDuHRvKEvhw+nWu7j3YrXgGbtC3ecSKUXYfxOGafv
	wPlic/edeUr+sDsjRSxGOknSERvbXdQLNfpETmCv9vi3Qq+ar8xGjCflCKvIdeDs
	/UY3TR0kKpjV5hhZjUrBZXbhPeo8OAbSqUi3zS/bkCSSwooXpJsqKimtAFyFs7Lv
	xiSmT/53srabsgrc7FTNJN2fhhTInhQVrue6XHyy/hIyHYeZAdUgHt1VqKtCBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wq7q8ruux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 02:56:58 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 02:56:57 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 7 Mar 2024 02:56:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 7 Mar 2024 02:56:36 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id B17A03F7055;
	Thu,  7 Mar 2024 02:56:32 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix devlink params
Date: Thu, 7 Mar 2024 16:26:23 +0530
Message-ID: <20240307105623.474757-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ygj9CeR1aXefL178zpeNV2lhtwcXiihr
X-Proofpoint-GUID: ygj9CeR1aXefL178zpeNV2lhtwcXiihr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02

From: Sunil Goutham <sgoutham@marvell.com>

Devlink param for adjusting NPC MCAM high zone
area is in wrong param list and is not getting
activated on CN10KA silicon.
That patch fixes this issue.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 1e6fbd98423d..96c04f7d93f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1235,8 +1235,8 @@ static int rvu_af_dl_dwrr_mtu_get(struct devlink *devlink, u32 id,
 enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
-	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
@@ -1434,15 +1434,6 @@ static const struct devlink_param rvu_af_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     rvu_af_dl_dwrr_mtu_get, rvu_af_dl_dwrr_mtu_set,
 			     rvu_af_dl_dwrr_mtu_validate),
-};
-
-static const struct devlink_param rvu_af_dl_param_exact_match[] = {
-	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
-			     "npc_exact_feature_disable", DEVLINK_PARAM_TYPE_STRING,
-			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
-			     rvu_af_npc_exact_feature_get,
-			     rvu_af_npc_exact_feature_disable,
-			     rvu_af_npc_exact_feature_validate),
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
 			     "npc_mcam_high_zone_percent", DEVLINK_PARAM_TYPE_U8,
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
@@ -1457,6 +1448,15 @@ static const struct devlink_param rvu_af_dl_param_exact_match[] = {
 			     rvu_af_dl_nix_maxlf_validate),
 };
 
+static const struct devlink_param rvu_af_dl_param_exact_match[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
+			     "npc_exact_feature_disable", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_npc_exact_feature_get,
+			     rvu_af_npc_exact_feature_disable,
+			     rvu_af_npc_exact_feature_validate),
+};
+
 /* Devlink switch mode */
 static int rvu_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
-- 
2.25.1


