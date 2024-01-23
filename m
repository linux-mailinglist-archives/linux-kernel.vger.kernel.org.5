Return-Path: <linux-kernel+bounces-35474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3398391B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A0828EB54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0325FF1B;
	Tue, 23 Jan 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h9DTEqP1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E955FF13;
	Tue, 23 Jan 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021221; cv=none; b=Hhb9nqBxIPXHoVl8d/XYMpHAbl69Xat1zzEz3lCdOKNwf3btSNNByMn83FOMTPXCGbcrDtDA927Svkk+mISaofS5d0oU6LDwXTPbi0itn0/rmptJOEDBvEBVCegJ69whBUtCXD4duCUQpW7Nd2iesdpxqx92axYwJ7i0z+Y9Fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021221; c=relaxed/simple;
	bh=yhiKoILiKglwk3i+5fnsJXdI2aMAxyOo4taFdOcTWgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peY3nNS6TlFJWLBEZKOq+2/Gu0QSNInm0MxqS2I1lNEQWExkHE2f8wVhIUzZzHES2fk8oaHjgsYwlmVZlmSxBVtG828/5VJoesnLEUyM3uKQJ5smdDkg5GfZUGGUIOPnreQFsAOLXgbfGqLPO4YaH53AHVuD2psttp21c+u+ZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h9DTEqP1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NAhMZd004729;
	Tue, 23 Jan 2024 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=oCZQgwZdxZL7hRAP7GPL
	n4kDTbRd6/G2f7LHazmI3VA=; b=h9DTEqP1Ul27QPWCmejbSZYLhG3yAt+I8ohA
	cXatrfpd5AYdgKXQ6M+Q7mhOCImUGmyGMZn09HK68MlripZVGJ/xrhopQhyOBnLF
	Ljd4G7LvVHWtCGlEYQi/4CsoRhC0LBEwigP7cqKwcgtyZUMjwg49wk13ANArxED9
	DzHQuvoidHlIQkjx0qQBbC05aoE2o1BMsGi2SzXWO6hjeOIRB8mYGf8Y2b0xnJ+1
	z+vUlV68X4cp+Gslxf4y96/aZmmcliFgsXbwEC3NjGtjPLdCncI3xi8Ef0a02jA3
	EURDMGGa4WVW82lSRvFSE49if3ACxtD7EbiHsUKz+H8DRDwXfA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vstd9axq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NEkeSB006927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:40 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 06:46:34 -0800
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bibek Kumar Patro
	<quic_bibekkum@quicinc.com>
Subject: [PATCH v9 5/5] iommu/arm-smmu: add ACTLR data and support for SC7280
Date: Tue, 23 Jan 2024 20:15:43 +0530
Message-ID: <20240123144543.9405-6-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rqo9KdjESiPEW_l_aVc5N0Lt6YimgyhC
X-Proofpoint-ORIG-GUID: rqo9KdjESiPEW_l_aVc5N0Lt6YimgyhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_08,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230108

Add ACTLR data table for SC7280 along with support for
same including SC7280 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index db15b1eade97..5474f242a96e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -30,6 +30,32 @@
 #define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
 #define PREFETCH_SWITCH_GFX	(5 << 3)

+static const struct actlr_config sc7280_apps_actlr_cfg[] = {
+	{ 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2000, 0x0163, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2080, 0x0461, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2100, 0x0161, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_config sc7280_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x07ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_variant sc7280_actlr[] = {
+	{
+		.io_start = 0x15000000,
+		.actlrcfg = sc7280_apps_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sc7280_apps_actlr_cfg)
+	}, {
+		.io_start = 0x03da0000,
+		.actlrcfg = sc7280_gfx_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sc7280_gfx_actlr_cfg)
+	},
+};
+
 static const struct actlr_config sm8550_apps_actlr_cfg[] = {
 	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
 	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
@@ -675,6 +701,13 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+static const struct qcom_smmu_match_data sc7280_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrvar = sc7280_actlr,
+	.num_smmu = ARRAY_SIZE(sc7280_actlr),
+};

 static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
@@ -701,7 +734,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
-	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7280-smmu-500", .data = &sc7280_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
--
2.17.1


