Return-Path: <linux-kernel+bounces-164013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1E8B7720
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEC81C22CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D63172BD5;
	Tue, 30 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HHbJU2x/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEA171E71;
	Tue, 30 Apr 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483843; cv=none; b=LcneuFrNz9acDhMzsoN1TiB2bYGTp8SnbGY3/ud9ZqKGt5fnEMDGM/jficwvB/JOAxbHIh7a7V3I7m4LorBfZFl2hX889opqfR4pF52uu1gUpBCZ/kl2hAsPw9XgJD4AmlzyPSxymnEgdwLXItC+fq9hva2fPWMLM7902gYH2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483843; c=relaxed/simple;
	bh=borJX4t19zR6/d5a/i0cmTDNpYwXouDfXF+UgpH+p0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eu2mQ+p8Azia4/m2qoDAjCa8wO8iX/nBr72dUESqR1wxECMvz72psKR7j5MnSYhnH+KT9oTy+4PxhIp8INc8a/GIFnnxjoQUfoJCKRUOlPoogy6znNBvx/57q8cchWar7uL72yasdE5Q8Bu1+WiVpSJfyDi3fNIQyRlikMOddv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HHbJU2x/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U9CJsr021247;
	Tue, 30 Apr 2024 13:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2PVzTHHVAjkyFPDFVLKR/oC7LQ6dDML+tHqJ0mDUlP8
	=; b=HHbJU2x/U6KYK8nWsvhFS0n2VN028ZMaPVQ1ZpXqz3I6hFN52n2uO9UF2Uo
	8YBW69wASn0FCZnaOjs/oXkC9pwxAhkqa9um6TyYz/Bl9a7mnPsp5LwubqnlD6vw
	75gFzoNmPlIsZh+ylqdxfhJsOGRWiFPNwD0IA4rqYxWhAVuuWGGaDeLa0tt+FAMw
	esB4stYrnvDvs8+IXobQTx0HpV4Q7Mz6Pby33X+Ncj+YXemCbjU8UgKeyrF0efcT
	krxin5rd6Xqs+5IqEHntlWOrMDNcshhR5uMCuWjmgkhDNjUu+D+8sduGN9HzeOOe
	x1BHRY0QGuL6/9vkH4aHEe0595w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvu18b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:30:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UDURxP015173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:30:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 06:30:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Apr 2024 06:30:21 -0700
Subject: [PATCH 2/2] wifi: ath11k: unmap the CE in ath11k_ahb_probe() error
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240430-ce-unmap-v1-2-e468328f95d9@quicinc.com>
References: <20240430-ce-unmap-v1-0-e468328f95d9@quicinc.com>
In-Reply-To: <20240430-ce-unmap-v1-0-e468328f95d9@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oTS4Gx5qsPdXtT4Dxe896P3OVQjQXNR7
X-Proofpoint-GUID: oTS4Gx5qsPdXtT4Dxe896P3OVQjQXNR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_07,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=957 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300095

Currently, in ath11k_ahb_probe(), if a failure occurs after
ath11k_ahb_ce_remap() is called, and if hw_params->ce_remap is
enabled, the CE register memory is not unmapped. So add a call to
ath11k_ahb_ce_unmap() in the error path.

This issue was identified by smatch/smatch_scripts/kchecker:

drivers/net/wireless/ath/ath11k/ahb.c:1218 ath11k_ahb_probe() warn: 'ab->mem_ce' from ioremap() not released on lines: 1218.

Since this is a rare error path with no simple way to test, and since
the change is trivial to review, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index aa62ed710090..ef0ede16aac8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1177,7 +1177,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 
 	ret = ath11k_ahb_fw_resources_init(ab);
 	if (ret)
-		goto err_core_free;
+		goto err_ce_unmap;
 
 	ret = ath11k_ahb_setup_smp2p_handle(ab);
 	if (ret)
@@ -1229,6 +1229,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_fw_deinit:
 	ath11k_ahb_fw_resource_deinit(ab);
 
+err_ce_unmap:
+	ath11k_ahb_ce_unmap(ab);
+
 err_core_free:
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);

-- 
2.42.0


