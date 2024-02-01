Return-Path: <linux-kernel+bounces-48852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF95846266
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94EBB26CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04845C12;
	Thu,  1 Feb 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFeYPdEz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35753EA93;
	Thu,  1 Feb 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821563; cv=none; b=h7oin1B/CWfLgG6/5qHQEDP+ccL2yr/HEix/aLcbMLyTuleIVlVLk2m6WfJgmcDVvCLTfazD0fWGV18IJCsASB4C41Q8zqdMZ5Lxm84rMdAY2hrFJ2BvwisH1Gl70mE8IK3GzVc9WDutXF/K2weCbot16rFPzyaLhV30CkXGjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821563; c=relaxed/simple;
	bh=N3qv8qQihK9XeBurICAJo2543mo59ew0ahLmAFuGQQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAkEQtfkq6IwIxzAVwTsVziCRO4KjEVomiUXUWzseSsdYZ0VNk8IozNQXOZI2qXnt2eaNC+yglG8SPT25AT/zM7wYtFPVErwN+rkeoVFZqaqcFGcn2YIv4D0nhE0HzdfuibMIJGokGoZsTr1p/oRHK2r95RMdJqaQW5Pi21RwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFeYPdEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KrTvZ025114;
	Thu, 1 Feb 2024 21:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=yof2ikqWikHAEeIAPtgs
	vCQ9MOKQ4pmllyI61xTqvhQ=; b=dFeYPdEzPIo8TpF+h1FRQ791AULAG+uGzvkU
	j9V09XTKpKw3URNYjEgxcIQWGt7GvbYFgACdqCBFnMQrf+HX/6150JEzN2hdgHqH
	FYUAmCLyCHU1gZY+HYvZ9NtwnzfonqGaoEbyaOPF5U0BSaykiyq6SXGI+EMVp29i
	l+/eEFjMGIVqHQlOimapdqxnHvZMlv4SGZO1Ka7nHzbMK1VnInmCNNB04RAl8x7x
	/BZw7S1JVI1ix47GRcKGJfTPmCmfpWHSYbU02p4ySvLGS/omjx0O3SVDR0cvFbPW
	ZgqAk0GXTf+x6Z9pLyb5akFOE3Q1r8Q3G1hicAqOz2m4vJDPvA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0deg8xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5i9w008995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:44 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:43 -0800
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
Subject: [PATCH v4 09/10] iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
Date: Thu, 1 Feb 2024 13:05:28 -0800
Message-ID: <20240201210529.7728-10-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
References: <20240201210529.7728-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PUWC35VGrdDpVoHqJgsS7DwiqlGxS8CB
X-Proofpoint-GUID: PUWC35VGrdDpVoHqJgsS7DwiqlGxS8CB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=963 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

The TBU support is now available, so let's allow it to be used on other
platforms that have the Qualcomm SMMU-500 implementation with TBUs. This
will allow the context fault handler to query the TBUs when a context
fault occurs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 2635f5b31455..0e587bd1cae8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -414,6 +414,10 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.reset = arm_mmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+	.context_fault = qcom_smmu_context_fault,
+	.context_fault_needs_threaded_irq = true,
+#endif
 };
 
 static const struct arm_smmu_impl sdm845_smmu_500_impl = {

