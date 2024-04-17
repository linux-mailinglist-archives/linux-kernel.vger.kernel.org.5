Return-Path: <linux-kernel+bounces-148596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC18A84E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B851B25A93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3081411D3;
	Wed, 17 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AizfUCVP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD513F423;
	Wed, 17 Apr 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361086; cv=none; b=kmmI0uJo/eTc91YWEIha9ga6lQjid8mcRxuFOSi4rgRLhsrnRNACkt6oiDy4O1kTuJwfoVyE0RDXl8Le2QKQZX7RFB4bFMBnpprGASuabLz8uKab69Xxr8/y6QtVFpo9RzMuR5J1kNpLaAXZ3vEjZaKEJKZ+Fo6oljwvQZgm2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361086; c=relaxed/simple;
	bh=lbGG9EHWAA7ZoK4ZLhE6JVQnWYRZ4JZnoG++fcerdC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSw2KR3B2kgFNQ4KCVZE3GLGxTHQ5UUkNLdgnYi7ROm1E8QAqpP7fXT0RYiZVcC/9Iofj/7oo4JwQ0A8Un4MQ5AQkl3XjNXYM3BLmfD+Kr7Soa5VAx5qPEy3ft+EpkFQF6/fsNdmYdOWQovso7XgzzY3q96QD1J4hhdAoNqxVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AizfUCVP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H5UFMc001500;
	Wed, 17 Apr 2024 13:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RV0qy7WIPUfTrUCSHD9ms1u7EkMj1qyRdKfPviaE00o=; b=Ai
	zfUCVPUlqnzN1dNeGPbkFtlm+1yKHMJgsdKbUpjD7Qr1pI99bnODLUcNyNcvpadW
	9nK5bSh82dLIOpEBo5b5UZyuUg6Yph0AhcmJLdo7ZyPp61YjT+Tgna3lI06c7xOY
	kTlwe+TTmOAWwb3M9Q2vn37D9/Eu3Tu9kMNPB977FeV+mhgDQPj0TsY7OgGC8g3S
	5QUyGkRRyz5GnzKoZDpY3DtR0MHK4Sq5MiWO8WUINPkVXBDOWv6y0LD8f2blDW1B
	ivyOuqpbuXVCgnbsNusuC6SHEiTBJf1hVZLvfEFUZp/+1/IOkgu2B1DvsvQIbzz+
	41uegHJy1ZZDiUYn3Twg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8aus328-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDbl6B022506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:47 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:37:46 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux.dev>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robdclark@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <djakov@kernel.org>
Subject: [PATCH v8 6/7] iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
Date: Wed, 17 Apr 2024 06:37:30 -0700
Message-ID: <20240417133731.2055383-7-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-ORIG-GUID: M3taxFw9XFwy-834U0UKUCJkQqi7rzJW
X-Proofpoint-GUID: M3taxFw9XFwy-834U0UKUCJkQqi7rzJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170094

The TBU support is now available, so let's allow it to be used on other
platforms that have the Qualcomm SMMU-500 implementation with TBUs. This
will allow the context fault handler to query the TBUs when a context
fault occurs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index a901230dbabd..25f034677f56 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -413,6 +413,10 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.reset = arm_mmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+#ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
+	.context_fault = qcom_smmu_context_fault,
+	.context_fault_needs_threaded_irq = true,
+#endif
 };
 
 static const struct arm_smmu_impl sdm845_smmu_500_impl = {

