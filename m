Return-Path: <linux-kernel+bounces-96064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E478756B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EE02812C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64B13B29D;
	Thu,  7 Mar 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AwkdKYxI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F013AA37;
	Thu,  7 Mar 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838370; cv=none; b=nEHc5MxSAlz4eeX4wh2SPViLCEWHhuRrTPFN2yC3d5Mrmrn8GxgH5I5s//QzHq/Q7QPcRpHmWHsGM3dvN9UmFwV+aRFLrM0pi9pVQSOc624Ql1AlUujLhPg3nAPMDIdtBbU0R7NPcna7v5GtY+Vnyn6QWrc78+XqI+X+mYIYVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838370; c=relaxed/simple;
	bh=/zkTE/zzvzqe6XiR3mOeQqTOotqx4uagmm3Drc1iXSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti0TYGaqhMh7F8H1SJSFIIszJR1TVLgK3e1oIB8YH4xHyJbXX4JJB8ImVi77QwgHeoAxPax3KTDoSYc2pJEj7iw8fGm3l1/nogAGLWSRqwFQoma6Z8JxPO+1hQdnsYj3kkObrwo1lIZr+d/iI5/pq1pciwE9wFjQV6d1NSKFMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AwkdKYxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427FxeUt020087;
	Thu, 7 Mar 2024 19:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+bUzszJsY1F6wSWzpC0p4NQTeDs9k/xPSLileOx9bz4=; b=Aw
	kdKYxI7hpsWWekcmp5ETixTHrAVrqJOcFLicYN6fun34HF69LO2rkjGrxvmio/kX
	t8igIk9/HMiRj3f4ni6T46H+IETdwjGJpc7cq6aAGlQ2xsX4pK8INTV25GUbhwC6
	6VFV6p9Lm2uw83XIfbBK9WZ3e/EXt7AyRn1FlmlpuO+YFdUrnRdOZfzN8NCXzFwZ
	J2DIHB0WraaO5QgUJrNMGNSwIHEJKWWB+sBv0aMWEM+8zcrZbPaBDhGXb1ukOSU7
	FQ9Hjo8aIOzChZDh2l6GY7XaFaiLtCuwCTyC1O/K68AOu+Avi9ejLEn6ij5Yj2Ru
	y+GXun/DWiGS7zSwxxdw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq7husfgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:05:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427J5mu9004609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 19:05:48 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 11:05:47 -0800
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
Subject: [PATCH v6 7/7] arm64: dts: qcom: sc7280: Add DT nodes for the TBUs
Date: Thu, 7 Mar 2024 11:05:25 -0800
Message-ID: <20240307190525.395291-8-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-GUID: JIDtZ9KZKJF01MwaKIUmdoPrheqNUEny
X-Proofpoint-ORIG-GUID: JIDtZ9KZKJF01MwaKIUmdoPrheqNUEny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=938 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070133

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sc7280 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 89 ++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7e7f0f0fb41b..5d8aa182e3a9 100644
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
+		compute_dsp_0_tbu: tbu@151ed000 {
+			compatible = "qcom,sc7280-tbu";
+			reg = <0x0 0x151ed000 0x0 0x1000>;
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
+		};
+
+		compute_dsp_1_tbu: tbu@151f1000 {
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

