Return-Path: <linux-kernel+bounces-35473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81958391AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4141F265F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D345FEF3;
	Tue, 23 Jan 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HSGl/nMu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD550A81;
	Tue, 23 Jan 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021216; cv=none; b=hFuygLxzqffUcIB/ap+5GUggkXMrPn+ZaobAxFSP9OxgTuL0lASUdAPrT2dRmihZMBjehywR/ShnuOWDn5AS0GNcpf5Sr//iPoV713KUFrcie7OKisTI2+NSvdP8jaTKooDrjYIp4symQuiCWv8P7/b9mGTYnnxES8J6WVMQPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021216; c=relaxed/simple;
	bh=+G3O6kfSQtA+QRjcG71bT6PbE57P7+ZftsMGJSbbTMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7nYjBwawv/DfvwBHUq0NN/38CejMQV09snUTVPhShbcoz61PcxZAOGyZn9UmB3Cq2c2AlRC9H744FLPX2cGAzhbioimWTo/9lruc7Oikn/OGMpH12B6u17gIT73xQfhIFx1EHG4oc5ymKcBHBaE6tmjJ2n7NeNrpyP/42z6g4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HSGl/nMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6AGbG029598;
	Tue, 23 Jan 2024 14:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=8z65duRRADaKSSXTYf1n
	Os1n6nc8WpvGwO/hJCwKDzM=; b=HSGl/nMui9YdLWAWovOJ+m1gioVp7GMX1gHo
	W6/ocCC2xnxd/N8hxndmoMcKtX3TTB63tcU75Hops2VliBzppAhi9wyriFlKl8YN
	fusyD7uxScv/CWBYRzhmKFhQmnZHWHL5up+1y6zxXjKCN6Tn59PibZNDKRxu9M11
	JgiuZzOljUSrOrC+sH76gIyTWXJB0+YTp8/4iy2Kb6Qx91xZyFjlFHXAKGSaIUEU
	kI03CFtcbElSszg/+u4sGEUqP9IU+kPh8g0EDk5OnphUhLqI2Lp2YAyTSs79QC8w
	nhr0TkrMtS0Fm4KSycLlzPH3lOBm0WaDvWDmtCwYO60ngWk0Zw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt73m19eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NEkYBU006877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:46:34 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 06:46:28 -0800
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
Subject: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for SM8550
Date: Tue, 23 Jan 2024 20:15:42 +0530
Message-ID: <20240123144543.9405-5-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: f7z1dmzcc3E5lK3jbGlQ7ZC5l_v8fAZ_
X-Proofpoint-ORIG-GUID: f7z1dmzcc3E5lK3jbGlQ7ZC5l_v8fAZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_08,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230108

Add ACTLR data table for SM8550 along with support for
same including SM8550 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6004c6d9a7b2..db15b1eade97 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -23,6 +23,86 @@

 #define CPRE			(1 << 1)
 #define CMTLB			(1 << 0)
+#define PREFETCH_SHIFT		8
+#define PREFETCH_DEFAULT	0
+#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
+#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
+#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
+#define PREFETCH_SWITCH_GFX	(5 << 3)
+
+static const struct actlr_config sm8550_apps_actlr_cfg[] = {
+	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+};
+
+static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x03ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_variant sm8550_actlr[] = {
+	{
+		.io_start = 0x15000000,
+		.actlrcfg = sm8550_apps_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sm8550_apps_actlr_cfg)
+	}, {
+		.io_start = 0x03da0000,
+		.actlrcfg = sm8550_gfx_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sm8550_gfx_actlr_cfg)
+	},
+};

 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
@@ -595,6 +675,15 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+
+static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrvar = sm8550_actlr,
+	.num_smmu = ARRAY_SIZE(sm8550_actlr),
+};
+
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
@@ -629,6 +718,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
--
2.17.1


