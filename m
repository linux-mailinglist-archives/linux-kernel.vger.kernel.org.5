Return-Path: <linux-kernel+bounces-63013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA048528EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3C528309D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027E14291;
	Tue, 13 Feb 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZB50NDyc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E513FED;
	Tue, 13 Feb 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805624; cv=none; b=JNmZpRB22buiVDTcxgECMO83WfVDfPWHLOjupPJsWJCwWvmGQqAiMWz1+apzzxQt7KxsZ88+C8jiGE1A//7kK33PLeC/hKOv/EUD4ngq44EOIM3MtKZ06naNxR0XmALVRGavOdgP18fKovFsuHZVREpaVeV+f/A9mhqQOh2mGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805624; c=relaxed/simple;
	bh=BahX13G9kMMAA6YZK/U4uW/le6CkdnwRbWqOB1LRYdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnIf3fyT0fJbCyFxRgsdRcITMy1zPsmd/pYmsMfdYg1282OMBmwiZ7BjQTsRXKeODFjsvbiWIZJwtMekmCZQCERxY8EVPuJXQuKnAfGC6lt0YZrrARtbC4h5jjoIOAufPfQ4mKUzLlv5X/ZSFbuzXl0kYzaIO6ME8pP3OLT73JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZB50NDyc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D5Th6m004424;
	Tue, 13 Feb 2024 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1HyR7N1uFxB3/NwkHjKq
	/EjyE4gxvWiOfwIKWk1/RFw=; b=ZB50NDycJnqQKbROyNFmFELZF62cZwslDc/G
	Rm4Y6cJm336AL2eKMLlO95RF6YZNX9o9Xrn0DvbJDYKZy92cJxQzzWjD+ydVLchy
	rRtjKq/DpJWkxpjnfS1ITK+Qj3TXGrUdjbLuxXAPHJNQUH/aXLkqq+vv5d9o+s3i
	XokDM/UYTUTdPaXkXTYsgxA7H3oWhd1CuKyXCTg+KwkbRKVU27iBuppWP+Fno5F8
	zVRZaWyfnGhQRcmKsKLqom877/OkF4sewkA41Binz0TNNYMlOmFEzS+lMOeSelLt
	117Dhnj7GfktYorYVvuShgOBu9jzv0NEnJz7ud0P44h/pV4O/g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gs1j9m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:26:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D6Qhim017018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:26:43 GMT
Received: from hu-pbrahma-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 22:26:37 -0800
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
To: <quic_c_gdjako@quicinc.com>
CC: <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <djakov@kernel.org>,
        <iommu@lists.linux.dev>, <joro@8bytes.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <quic_sukadev@quicinc.com>,
        <robdclark@gmail.com>, <robh+dt@kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in qcom_smmu_create()
Date: Tue, 13 Feb 2024 11:56:08 +0530
Message-ID: <20240213062608.13018-1-quic_pbrahma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DZwZkC2Dnn9CE46HDwYLMIDiZKGSws-x
X-Proofpoint-ORIG-GUID: DZwZkC2Dnn9CE46HDwYLMIDiZKGSws-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=959
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130047

Currently, during arm smmu probe, struct arm_smmu_device pointer
is allocated. The pointer is reallocated to a new struct qcom_smmu in
qcom_smmu_create() with devm_krealloc() which frees the smmu device
after copying the data into the new pointer.

The freed pointer is then passed again in devm_of_platform_populate()
inside qcom_smmu_create() which causes a use-after-free issue.

Fix the use-after-free issue by reassigning the old pointer to
the new pointer where the struct was copied by devm_krealloc().

Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ed5ed5da7740..49eaeed6a91c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -710,6 +710,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
 	if (!qsmmu)
 		return ERR_PTR(-ENOMEM);
+	smmu = &qsmmu->smmu;
 
 	qsmmu->smmu.impl = impl;
 	qsmmu->data = data;
@@ -719,7 +720,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	if (ret)
 		return ERR_PTR(ret);
 
-	return &qsmmu->smmu;
+	return smmu;
 }
 
 /* Implementation Defined Register Space 0 register offsets */
-- 
2.17.1


