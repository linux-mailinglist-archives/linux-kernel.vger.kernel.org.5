Return-Path: <linux-kernel+bounces-6406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F78819879
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC83281F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C01DDFC;
	Wed, 20 Dec 2023 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A0gZ6rjf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622F16417;
	Wed, 20 Dec 2023 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK613KM018933;
	Wed, 20 Dec 2023 06:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=n0la2x7LbhvyThNRjNey
	+wkh3IECTBOJl2ug/ch+15E=; b=A0gZ6rjfAA2Hijl6c0zEaqvxi+OG5sNAMRjL
	S0uEyuTwL01y9ykPXtS6J8/t7lThSiNTrk1nwYQWTyxiy0YRdVM7eqBiT7Bv0KtB
	Y9OhSOSfLvNXwJ773AKRAGOIHGJrQcvk4Q/gtWeu+azya1evGqOB3uQYIQP1ENik
	/HApK3kFVbb1iNrU4zBH1ZBYRyQv1wufYwSZO0V3qGhYqc0Y01iVDrH6ZO8Xoyfn
	Xgvb3ckjsGLnD0v4DT0vFooKD2ZeskgK0Mf5KOyGySM/iiruZR/f84qvyT48gCXv
	WGb7ESYboFINpC2ataWHWnUTdUT/aL92906Ah3uVN7/WkA26+A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm0046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK62owl023333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:50 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 22:02:49 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v3 9/9] arm64: dts: qcom: sc7280: Add DT nodes for the TBUs
Date: Tue, 19 Dec 2023 22:02:36 -0800
Message-ID: <20231220060236.18600-10-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
References: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-GUID: 5Wj37_wpjWbs4qCRRhV4IYiy52Y9xJ9z
X-Proofpoint-ORIG-GUID: 5Wj37_wpjWbs4qCRRhV4IYiy52Y9xJ9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=839 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200038

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sc7280 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ff1e07171dc4..d2cf171aa0e0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2870,6 +2870,7 @@
 			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu",
 				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
 			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
@@ -2902,6 +2903,21 @@
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			gfx_0_tbu: tbu@3dd9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x3dd9000 0x0 0x1000>;
+				stream-id-range = <0x0 0x400>;
+			};
+
+			gfx_1_tbu: tbu@3ddd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x3ddd000 0x0 0x1000>;
+				stream-id-range = <0x400 0x400>;
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
@@ -5605,6 +5621,7 @@
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc7280-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			dma-coherent;
@@ -5689,6 +5706,86 @@
 				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			anoc_1_tbu: tbu@151dd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151dd000 0x0 0x1000>;
+				interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x0 0x400>;
+			};
+
+			anoc_2_tbu: tbu@151e1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151e1000 0x0 0x1000>;
+				interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x400 0x400>;
+			};
+
+			mnoc_hf_0_tbu: tbu@151e5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151e5000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
+				stream-id-range = <0x800 0x400>;
+			};
+
+			mnoc_hf_1_tbu: tbu@151e9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151e9000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
+				stream-id-range = <0xc00 0x400>;
+			};
+
+			compute_dsp_0_tbu: tbu@151ed000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151ed000 0x0 0x1000>;
+				interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU1_GDSC>;
+				stream-id-range = <0x1000 0x400>;
+			};
+
+			compute_dsp_1_tbu: tbu@151f1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151f1000 0x0 0x1000>;
+				interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU0_GDSC>;
+				stream-id-range = <0x1400 0x400>;
+			};
+
+			adsp_tbu: tbu@151f5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151f5000 0x0 0x1000>;
+				interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &lpass_ag_noc SLAVE_LPASS_CORE_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x1800 0x400>;
+			};
+
+			anoc_1_pcie_tbu: tbu@151f9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151f9000 0x0 0x1000>;
+				interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &cnoc3 SLAVE_TCU QCOM_ICC_TAG_ACTIVE_ONLY>;
+				stream-id-range = <0x1c00 0x400>;
+			};
+
+			mnoc_sf_0_tbu: tbu@151fd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x151fd000 0x0 0x1000>;
+				interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC>;
+				stream-id-range = <0x2000 0x400>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {

