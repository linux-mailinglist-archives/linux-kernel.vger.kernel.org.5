Return-Path: <linux-kernel+bounces-164357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588708B7CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778521C23051
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C417B506;
	Tue, 30 Apr 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A9JkRkfd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E702176FB2;
	Tue, 30 Apr 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494107; cv=none; b=KMj2ty5eTo/6fgqK16x+LIZJkoMzETlSfyqzO4JISmhemoV7+lOzSIjmQWgr7VGn8BaTYO9Rkx/ra7zMJdhXZKsnrTZr8v9Dm6JDPkA0NhVf6dqFDBxfWcBQmFd6eEHJlVFQp6+psH6LbZDv9jnrf8mbo8U458dTzhNkZ+JE2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494107; c=relaxed/simple;
	bh=hIngM5arAdxtzM7eMImfX7FLzj4QvbprUenpghipeSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bKB0u4RW1VcKVSIvUiksiXOHM4mDCrUJWhDhjFmPuv89G0/ZW8tkUAlYzrte57h9ZQ1GQuODuSXwa5y+1qDmTbA6kNUAfVTEiKJCSloTSwaZ5jRtScI55e5y14cv/qJYFag2QGqT6fhQACDrE0PyhjSKvBBhabnh/+SYjrHfz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A9JkRkfd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7efZe001639;
	Tue, 30 Apr 2024 16:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=jWkcmgFnCm1dD7O8kH2sAAslgpBizCXEewtriQmtFoo=; b=A9
	JkRkfdZChdpmKuVlNMuNivdd1m+OK2RavV2R31kdMjNy0D5jnWCTL1dbQPyk/TVc
	M8YzuZ8mmGZyz/56EHmcNW7dvA5w/5CTNH+qANGAh5LoNL+IDJVN2SuPMzs4yxs/
	wJKb9JCOX+WanDZPXNfyz+dxrqXCKSsEcHXnXnsyCuyFskHdOqgqK2WjLR0JkcdK
	nEdZfccmQb39jSHJ0W34GhhtHn2IWxi0p9/PKY5I+cRVzF+U8lj/cjgEUoEBX6ke
	ZXVUrPayVxID8i2C0Q46u3Rdug34KyBKtocIFsPv572pcoqwD7BrcbLhiXpaXfpK
	jGhw9gsLeeomUB3FC8NA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7hamj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:21:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UGLa5O025530;
	Tue, 30 Apr 2024 16:21:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1dqs-1;
	Tue, 30 Apr 2024 16:21:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UGLarp025524;
	Tue, 30 Apr 2024 16:21:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UGLaY7025521;
	Tue, 30 Apr 2024 16:21:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 3A1432287; Tue, 30 Apr 2024 21:51:35 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, Can Guo <quic_cang@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 1/2] phy: qcom-qmp-pcie: add x4 lane EP support for sa8775p
Date: Tue, 30 Apr 2024 21:51:26 +0530
Message-Id: <1714494089-7917-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714494089-7917-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714494089-7917-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yv3jkpxSeHyKY5UsO2X88toy4k7WVV3O
X-Proofpoint-ORIG-GUID: Yv3jkpxSeHyKY5UsO2X88toy4k7WVV3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300116
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for x4 lane end point mode PHY found on sa8755p platform.
Reusing existing serdes and pcs_misc table for EP and moved
BIAS_EN_CLKBUFLR_EN register from RC serdes table to common serdes
table as this register is part of both RC and EP.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e3103bc..6c79672 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2248,6 +2248,7 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_pcs_alt_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_serdes_alt_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
@@ -2274,7 +2275,6 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[]
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0x97),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
-	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_ENABLE1, 0x90),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
@@ -3306,6 +3306,13 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x4_pciephy_cfg = {
 		.pcs_misc_num	= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
 	},
 
+	.tbls_ep = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl,
+		.serdes_num	= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl),
+		.pcs_misc	= sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl),
+	},
+
 	.reset_list		= sdm845_pciephy_reset_l,
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.7.4


