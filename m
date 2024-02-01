Return-Path: <linux-kernel+bounces-48853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF1846267
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848A5B26CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2546425;
	Thu,  1 Feb 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nUGr4M6t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165E3EA8C;
	Thu,  1 Feb 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821564; cv=none; b=bz295Jv2Ioi5yVFTnZvDaEEXrbKaY1rXtxCyJYOYGEQlD4lsEJg1oS0bmOWvEyJfSUGLlFjiKgpiPtPM0nN4+gw3+tBvAWYaIiMmRk7GY1bQAl/DNWtsFKKGZIkxCFvbXtRksSL+E3JHOgDLgSbBnpF5/obE2q9PVhZ/qNKnf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821564; c=relaxed/simple;
	bh=U+CY3Apvfz9nzrP2lzWo5qzmtuQS79YTBMh9lu4Fq2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djV7GmCvmsXrv7+QfDRGilbDzltp3e6GHOIJvP0RPlu8ygEmEkRjbEE5G2pt9GsP34wANRA7jF1lgzYBZZB8hNyitwwLQV2bcOQmrrI+EHpp4ikSfxenEVwC4/gYzohPOa1KnSseka/6E1Y1YyjeDeXBdsRDXz+PSLLb/hKQdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nUGr4M6t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KaR21019457;
	Thu, 1 Feb 2024 21:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v4hTG7wbK+ifCjFA5viT
	HCjZnTpsBZRO2oIBoSXe1eE=; b=nUGr4M6tk0gb0vd18h6sZ0rRNEbSI/Gy+dg2
	vbqyp1G4uta18KsIiSkIFNxNvVu/SBwIZpOzO5PMDkc3+mBHkToKMYpq/Kvw33dh
	GRzhOPozvqJhg6fbKhs3XbpDu/u9OAH9Y6MEBznDMVo8jLimVOjSaNswwro+PjKW
	MJLdascgwd7nro1CV09qKJUDBBJ7rxVtpb+UK5VqwkbQPsu2Or1duQyHQW3+Bm4W
	PSWDdYmcBvOYpyygAZwg31Q+r/B01EAllK7YdcYoxCM2LOrR+GA4YJzIaU24GKnX
	imZVI+XkoDuZ1kTkNNerNHhgV+1fwUVezsPLNC0CXlqlY92YHw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0hdx068r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5fKU008955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:41 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:40 -0800
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
Subject: [PATCH v4 03/10] iommu/arm-smmu-qcom: Add support for TBUs
Date: Thu, 1 Feb 2024 13:05:22 -0800
Message-ID: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-GUID: wASA_ebGu8EfX3eIz4mBx_IuyWdHjoCl
X-Proofpoint-ORIG-GUID: wASA_ebGu8EfX3eIz4mBx_IuyWdHjoCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

The ARM MMU-500 implements a Translation Buffer Unit (TBU) for each
connected master besides a single TCU which controls and manages the
address translations.

Allow the Qualcomm SMMU driver to probe for any TBU devices that can
provide additional debug features like triggering transactions, logging
outstanding transactions, snapshot capture etc. The primary use-case
would be to get information from a TBU and print it during a context
fault.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 8b04ece00420..ca806644e6eb 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved
  */
 
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
 #include <linux/delay.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 
 #include "arm-smmu.h"
@@ -446,6 +448,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	const struct device_node *np = smmu->dev->of_node;
 	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
+	int ret;
 
 	if (!data)
 		return ERR_PTR(-EINVAL);
@@ -469,6 +472,12 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	qsmmu->smmu.impl = impl;
 	qsmmu->cfg = data->cfg;
 
+	INIT_LIST_HEAD(&qsmmu->tbu_list);
+	mutex_init(&qsmmu->tbu_list_lock);
+	ret = devm_of_platform_populate(smmu->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return &qsmmu->smmu;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 593910567b88..77e5becc2482 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ARM_SMMU_QCOM_H
@@ -12,6 +12,8 @@ struct qcom_smmu {
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
+	struct mutex tbu_list_lock;  /* protects tbu_list */
+	struct list_head tbu_list;
 };
 
 enum qcom_smmu_impl_reg_offset {

