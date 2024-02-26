Return-Path: <linux-kernel+bounces-82051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B227867E51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977EC1F2701F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43512CDAE;
	Mon, 26 Feb 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPNI8yIc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865B130AC9;
	Mon, 26 Feb 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968175; cv=none; b=Ac8M0yygYJ9xqHPFG11Y61eCFEiO5k6Jcggvt9twj673Zc30V2Ewc9d5moY17oJnEllPejs+6YFy/itz2yIy0pP/GI1mtWsju2+cX/D5+YSQDMo6N3uBvXoOmR7GXpGWuldH9Gntr4esagqzpTOLP2Cw6gVkMZBhiFncHNG9Rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968175; c=relaxed/simple;
	bh=gwVYaDxijOcW/4jp1wu9USoY8f0zlVqXFt/4vyp5rww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCZCOnUUyOTBMueDUo9dt7ZkYIiA+dyNqOvtj3C3AmlVxL56rG0GtjGTp57H2y4WOdSPAP88acg4ErzN2/6X43jelDq0i9UNcvctiXeUSBIZZfvvCGTgecxInGoTrZ2nWIL8GTORVLEuU5TLQK5Gs0BS7KA6CGJMA7tln91YYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPNI8yIc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QFvJqU008860;
	Mon, 26 Feb 2024 17:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BIBlZ6vO4Zn0Fl9g4ldcuLnPEatGDOFkMzp/ukbPqrk=; b=ZP
	NI8yIcmrMYaLqNXJqTBI6WZOTOHus4f7f275tltAfdP+XRUoRPIzcpArMc8N+92+
	sK6SvWcjE6Q7uheVh2lowkTSe28uzgsuFPSY1Qe7kPN6J+B1bScbVMYrnpeJiE/d
	JsPB7UcKSNh7E3JWf4eUEzEszUDz0CN0DL8SAubY4kuXeJh3xpQGzJTWHVSRbRBy
	saQnjYndNwe2WtWN3aoC4IN1Q0fL5icb7ngAGM4C6roqwQEDnJgy3VT7BFRTFkmd
	WHRa4gKXMQ6q8xkMTFz0jK2Y/uOcpx87UacC1hzxoTHGfMiV8Mf62Q8CP0pP+4iD
	2AnSiR+RsC/+NiVuDCiA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq9h5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QHMag8001143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:22:36 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 09:22:36 -0800
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
Subject: [PATCH v5 7/7] arm64: dts: qcom: sc7280: Add DT nodes for the TBUs
Date: Mon, 26 Feb 2024 09:22:18 -0800
Message-ID: <20240226172218.69486-8-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BBWx4euG2_zHS3VXKfFROkLoyeykOhK0
X-Proofpoint-GUID: BBWx4euG2_zHS3VXKfFROkLoyeykOhK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=943
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260132

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
index 83b5b76ba179..cc42560f63ad 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2905,6 +2905,18 @@ adreno_smmu: iommu@3da0000 {
 			dma-coherent;
 		};
 
+		gfx_0_tbu: tbu@3dd9000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x3dd9000 0x0 0x1000>;
+			qcom,stream-id-range = <&adreno_smmu 0x0 0x400>;
+		};
+
+		gfx_1_tbu: tbu@3ddd000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x3ddd000 0x0 0x1000>;
+			qcom,stream-id-range = <&adreno_smmu 0x400 0x400>;
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sc7280-mpss-pas";
 			reg = <0 0x04080000 0 0x10000>;
@@ -5693,6 +5705,83 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		anoc_1_tbu: tbu@151dd000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151dd000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x0 0x400>;
+		};
+
+		anoc_2_tbu: tbu@151e1000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151e1000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x400 0x400>;
+		};
+
+		mnoc_hf_0_tbu: tbu@151e5000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151e5000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
+		};
+
+		mnoc_hf_1_tbu: tbu@151e9000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151e9000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
+		};
+
+		compute_dsp_0_tbu: tbu@151ed000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151ed000 0x0 0x1000>;
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
+		};
+
+		compute_dsp_1_tbu: tbu@151f1000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151f1000 0x0 0x1000>;
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
+		};
+
+		adsp_tbu: tbu@151f5000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151f5000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &lpass_ag_noc SLAVE_LPASS_CORE_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1800 0x400>;
+		};
+
+		anoc_1_pcie_tbu: tbu@151f9000 {
+			compatible = "qcom,qsmmuv500-tbu";
+			reg = <0x0 0x151f9000 0x0 0x1000>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+		};
+
+		mnoc_sf_0_tbu: tbu@151fd000 {
+			compatible = "qcom,qsmmuv500-tbu";
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

