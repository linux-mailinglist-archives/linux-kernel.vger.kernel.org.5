Return-Path: <linux-kernel+bounces-148598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C08A84EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2A91F2185B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FD1422A2;
	Wed, 17 Apr 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RO5ghTht"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA514039E;
	Wed, 17 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361087; cv=none; b=p+dZ8W5inXk/ZjTLIKWUJ4k83a/0njw6DBVElDp3yfBRQFjMreraxIJfXfwv7EAO44n8mhWciW9svWRHieGQBiuPpu/6+Rs08jlFhjxDjpp7BWhBnjRucfF0zwklmvY53UtCH9Yd2vPQIYZODMsceylfU2gOvJ03r6wpHdYUBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361087; c=relaxed/simple;
	bh=UEEdj1JKNkabLBUs0ptodqONc1/I28wvSO19u3QYtEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhtuIUg1Lxe/EDA/wFpf69BGkUgvNoDtwM3mVqNjpHZMngA2NWpu8wXQo9Pb+lsrTzJDfVkCKd7NIXhvCl/G+lZLaixGNc1OymjK+mP2bxDPooMnAHsZeCrkriydg2zNERMJP41Ii2fNdqJk2byZoOLAOhoqm99SXgywy05IxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RO5ghTht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H9MxBu010177;
	Wed, 17 Apr 2024 13:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TTeye1iDsNWRa0CauBrZZxJVgWkii2SQSK57XEP5y/E=; b=RO
	5ghThtNKppXuDBm1UmJb9f2AvQUzzFp587Jks8KsYKdsXT9tPXJdeMQDnJMyOESR
	8yWoCuz7HVyjFrjABlCSj0typlK1tqNqB48Yqaw8dugNNUqn4aRZtCDpQc/xJQPx
	6hAOj/UUVaEAIArzfTFauwja9jMkknjbenaQdvsYZqrW8tM80niZ1TZwaC3j+DUZ
	GPgwM6pKLag//pd9PWdjAAf96FI8xxjhJDj0vWHm8w/7pg89pVqJS/Beg7UBWMt2
	FX7sgAu8oZfyc6XspqEMq0ynpXALko5D6pfc2HAqjwHcVyPtJoL2kvW8EKYDgINj
	akIu40D3F7rj7NgQOlzA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr13uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDbl3u022880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:47 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:37:47 -0700
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
Subject: [PATCH v8 7/7] arm64: dts: qcom: sc7280: Add DT nodes for the TBUs
Date: Wed, 17 Apr 2024 06:37:31 -0700
Message-ID: <20240417133731.2055383-8-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ef8dgOFj3UWSyvWEgHBkGAc2goWEDoPK
X-Proofpoint-GUID: Ef8dgOFj3UWSyvWEgHBkGAc2goWEDoPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=955
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170094

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sc7280 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe all the registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 89 ++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7e7f0f0fb41b..1842f78260c1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2970,6 +2970,18 @@ adreno_smmu: iommu@3da0000 {
 			dma-coherent;
 		};
 
+		gfx_0_tbu: tbu@3dd9000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x3dd9000 0x0 0x1000>;
+			qcom,stream-id-range = <&adreno_smmu 0x0 0x400>;
+		};
+
+		gfx_1_tbu: tbu@3ddd000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x3ddd000 0x0 0x1000>;
+			qcom,stream-id-range = <&adreno_smmu 0x400 0x400>;
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sc7280-mpss-pas";
 			reg = <0 0x04080000 0 0x10000>;
@@ -5778,6 +5790,83 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		anoc_1_tbu: tbu@151dd000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151dd000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x0 0x400>;
+		};
+
+		anoc_2_tbu: tbu@151e1000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151e1000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x400 0x400>;
+		};
+
+		mnoc_hf_0_tbu: tbu@151e5000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151e5000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
+		};
+
+		mnoc_hf_1_tbu: tbu@151e9000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151e9000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
+		};
+
+		compute_dsp_1_tbu: tbu@151ed000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151ed000 0x0 0x1000>;
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
+		};
+
+		compute_dsp_0_tbu: tbu@151f1000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151f1000 0x0 0x1000>;
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
+		};
+
+		adsp_tbu: tbu@151f5000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151f5000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &lpass_ag_noc SLAVE_LPASS_CORE_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1800 0x400>;
+		};
+
+		anoc_1_pcie_tbu: tbu@151f9000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151f9000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+		};
+
+		mnoc_sf_0_tbu: tbu@151fd000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151fd000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x2000 0x400>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0x17a00000 0 0x10000>,     /* GICD */

