Return-Path: <linux-kernel+bounces-110215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F34885B94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ED11C203BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AB8624E;
	Thu, 21 Mar 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VsOwj03M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BD8625B;
	Thu, 21 Mar 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034665; cv=none; b=O3uuuPxVc95E7GhK6L68znazT7hvUb5VFitjTP4T6LRILZbBKNEW4v016M3aCJzm4TDeRz39I3ZwUmfR43O2zmgSXLDeOjpldaZb8W0IkCQKzgPVeh124IdsA6UGQMoS97/6d3AMaUqNgliuomGwqBjNVsLGzu1nA1QprGWrzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034665; c=relaxed/simple;
	bh=CYl0v5YsJ+8QCIXpKj3ol8u13gnpNlAw/ulUwFFvIxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LigmWSCJQemdZdzcmnSjHws0oMQupMPGf4SH83s2l76A2jUbpja5qEvwLO5y8jax0BVU4Ma0NeLOetwhisxfOW6xUs8KLWm9YDJfHGaT64jUo9eLXwfankfOxm+SwPbFHDEi/M3LoRsT3TTaRRIX7VtO2eXNbBmcpFY/dybyLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VsOwj03M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LATfDW004545;
	Thu, 21 Mar 2024 15:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=c3ZKW+Z255xD6L+f9pHM
	L6CqPQnpb6vhYSin5j6UXWM=; b=VsOwj03MSyq1K+d0Wk247rLOP89VucpUDF5t
	E3kFGxiLIkCOoqHawmU+da2j6GIgggCzzwTS8o7tBIwdsLDivXJ52YBs0vWZXopU
	bLsCgxR/awSSM489ZZQGaCkkZdwuVeGx2rouJX+PANSVl+CeEgR70nhhJm906EaH
	CZC3BixfWk/MMY2QDjdaWTstKLNHr5C7M66Hgp0yg7hsKWJl+Oyv/yNCZ/9rnQ6B
	2qRoID/SoQATN0dPwcKKU2+cL4BuEOhNyR1qV5DbKK12HGWCr/eNYySKxq2FT7tl
	zBTju0ju94NmCRijAll0uRtjgmBiGUdT14QwlRkB0WHcA1uCsA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0aah1tpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LFOJ2S013274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:19 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 08:24:17 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 2/4] firmware: scm: Remove redundant scm argument from qcom_scm_waitq_wakeup()
Date: Thu, 21 Mar 2024 20:54:00 +0530
Message-ID: <1711034642-22860-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yTf6Kvr--_GRfaPwQfl_QorN6sgBfsY5
X-Proofpoint-ORIG-GUID: yTf6Kvr--_GRfaPwQfl_QorN6sgBfsY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210110

Remove redundant scm argument from qcom_scm_waitq_wakeup().

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2: https://lore.kernel.org/lkml/20240227155308.18395-10-quic_mojha@quicinc.com/
 - Fixed incorrect word in the commit text.  

 drivers/firmware/qcom/qcom_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index a11fb063cc67..d9153204cba3 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1771,7 +1771,7 @@ int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
 	return 0;
 }
 
-static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
+static int qcom_scm_waitq_wakeup(unsigned int wq_ctx)
 {
 	int ret;
 
@@ -1803,7 +1803,7 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 			goto out;
 		}
 
-		ret = qcom_scm_waitq_wakeup(scm, wq_ctx);
+		ret = qcom_scm_waitq_wakeup(wq_ctx);
 		if (ret)
 			goto out;
 	} while (more_pending);
-- 
2.7.4


