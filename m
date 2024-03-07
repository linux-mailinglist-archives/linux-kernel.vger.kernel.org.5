Return-Path: <linux-kernel+bounces-96066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25268756B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F8281D10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5813B795;
	Thu,  7 Mar 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uypve7XR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B213665A;
	Thu,  7 Mar 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838371; cv=none; b=EPJcp5/QohbQ5dwLjw6PT8ErMeVfncco6Etn7zJbQOK8zdsg+VmJpCcvAss27IK3BV1QDijh1FbZqvNlqAbqubFmcZVWehwt6AGk0R0M4HVrk6WEvk+zcMfnzVbEXulqQ3jumi1+H+KqzQPoKGOFX7qg7kx3P/tF6SEUXFk7pMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838371; c=relaxed/simple;
	bh=ndoVGcEPZTeW65Jpuo0QNLQhBOiAh4hrgmZGAAZ/Um0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXd/piphzM8SKw8mShsMF+acBRh3h8u4Pq6wIPtPxWPlM2QjuK3bXRxjXtqmkY+bi1vaOMFIaCl1ohNFdG7O33t1FjhCzDuPC4yObLF2KgMagvNz3Tu6RD6Qo2I5K2F4VWvdyYIDHpAU0A6sLNwOhjtB3vWdu4qFBX4cpWyJDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uypve7XR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427FxeUs020087;
	Thu, 7 Mar 2024 19:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jqzwN1vuCFLLJR0ky4qG5pZmihPpcc82QgRh0kKcLxI=; b=Uy
	pve7XRoyVqstRdYn8wkOgsoXCh1x4hD2YgWbwhCgCfIsSK1eCQp8KIxVtiX8KCfc
	hqKlltm5aPFl3X3yg0qMf4J/a1cTKjdZrmmgDz9+qez/8AMO8qeB2vvll171ajII
	GI2zbQI3sndMbr4aSQC+GBnl1gE2BXWlx0wDVQRWXaZBLv1SJeslYjEV4rhALVa+
	MMLaAYKSz1RUsCD2HveVRv0Xt/6LMN2ZUVSzl9QVGy9WUkT08DUpNGJOs6mPPAIQ
	pqmuWcH8olYZluWy5N5DG3Snn11i813xDBAlmBqyNmbBrTpPclFFfVIteSZrOs8q
	E07zNTgIEpo+bvpEr4jw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq7husfgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:05:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427J5lUL028098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 19:05:47 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 11:05:46 -0800
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
Subject: [PATCH v6 6/7] iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
Date: Thu, 7 Mar 2024 11:05:24 -0800
Message-ID: <20240307190525.395291-7-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
References: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8k0mZPwDEQVrlJ1exsBc7JoywBNsOFg_
X-Proofpoint-ORIG-GUID: 8k0mZPwDEQVrlJ1exsBc7JoywBNsOFg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070133

The TBU support is now available, so let's allow it to be used on other
platforms that have the Qualcomm SMMU-500 implementation with TBUs. This
will allow the context fault handler to query the TBUs when a context
fault occurs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7a58b1b96bca..08e0ad325bab 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -413,6 +413,10 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.reset = arm_mmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+	.context_fault = qcom_smmu_context_fault,
+	.context_fault_needs_threaded_irq = true,
+#endif
 };
 
 static const struct arm_smmu_impl sdm845_smmu_500_impl = {

