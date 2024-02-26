Return-Path: <linux-kernel+bounces-82049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF63867E46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECE328F174
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC912FF67;
	Mon, 26 Feb 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="omPRSKDF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5A12CD9C;
	Mon, 26 Feb 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968171; cv=none; b=NisJC/XnhdjiXZhmp9Hl4LagckjsqdiFmBfszJwv7tLOJvTewyv3apxgU8cLs1D/kT7uXIse6Y8jHk394EWvnxrQZsRvN9BODpDy2ntuw3O13Lg4AiCGrAPwIoN3tYiL4z+Tw7sIqem8zu2rhPucV/4p/CRm+D2w/hWnrTz5ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968171; c=relaxed/simple;
	bh=7rZ4bLnEZoK2AKdsiFJgy5QItLaIu0cdIrWRLQNnX1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdu0V8ed4JTMNTFlzO0D6utSYsr/lDra+D4bxfxJ7pXyB7OYpjW19Caahz12zm8wzMpMgFDYSU2KIEKpmygOB4x3SZQFz26/v81Q5yjmfaFxpn7eJM6TPE9TzTSIaxuugWCGNUi+5npF1Lz3uFm2Bb+pfATDwIZDu4H3a61bYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=omPRSKDF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF9ElA026943;
	Mon, 26 Feb 2024 17:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DqCD5vo/ZHTCtloKxZg3X6uBZkMSvMAdRgwVxNCc+ws=; b=om
	PRSKDFIOX5KYkHmFKmjcAAJbCq8HD4GCAnEjWE6qIkDoghbTUrF7ahVZ+RKEtdKu
	7gbGO2u+wiFVnTPXQWihUXHlpV8L2tm5UlyWW9/D7nHgAuprxPxrwQP2pkdo70kb
	vXA1Buuy1wuZ+Q3cUTaIzmE3qYY5yExAxhaxTuJL9rntuOkPE9T9r/k0v9aWePUX
	0WQjXWFNLRrhhRiStKvpTtUmnpcR0+NCP5XK41o3eVR8zFg++5wF+OCt/cbE2CKj
	Qx2FOKKo3pZCRjGvM/+uFX6F2lLkbzk8wkOQlSNTilNVLfU/N09tkl+fGw9p4Ljc
	WsQspXOwl7Vne5Tkyo9g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxnhja2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QHMYNv006891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:34 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 09:22:33 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robdclark@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v5 3/7] iommu/arm-smmu: Allow using a threaded handler for context interrupts
Date: Mon, 26 Feb 2024 09:22:14 -0800
Message-ID: <20240226172218.69486-4-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ITPRnSXrRhcdbPTLuIR9FExw8adZIqcN
X-Proofpoint-GUID: ITPRnSXrRhcdbPTLuIR9FExw8adZIqcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260132

Threaded IRQ handlers run in a less critical context compared to normal
IRQs, so they can perform more complex and time-consuming operations
without causing significant delays in other parts of the kernel.
During a context fault, it might be needed to do more processing and
gather debug information from TBUs in the handler. These operations may
sleep, so add an option to use a threaded IRQ handler in these cases.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6317aaf7b3ab..faf3241e4808 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -806,8 +806,16 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	else
 		context_fault = arm_smmu_context_fault;
 
-	ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
-			       "arm-smmu-context-fault", smmu_domain);
+	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
+		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
+						context_fault,
+						IRQF_ONESHOT | IRQF_SHARED,
+						"arm-smmu-context-fault",
+						smmu_domain);
+	else
+		ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
+				       "arm-smmu-context-fault", smmu_domain);
+
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 1670e95c4637..4765c6945c34 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -438,6 +438,7 @@ struct arm_smmu_impl {
 	int (*def_domain_type)(struct device *dev);
 	irqreturn_t (*global_fault)(int irq, void *dev);
 	irqreturn_t (*context_fault)(int irq, void *dev);
+	bool context_fault_needs_threaded_irq;
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);

