Return-Path: <linux-kernel+bounces-48856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126684626B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B567B1C243CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F947A4D;
	Thu,  1 Feb 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GBByIFzd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CB3F8DB;
	Thu,  1 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821564; cv=none; b=fnV7MLotjxsgNH4ou2zCe2XQJRkA8qDTXZNDSV7hPlIhnLl8ODFx0Ojn7NHLpUkTIKL189iiWsv7mkJvh9QnZ3jlS1SnjCkGKNrHf4H13Avl3DDG2QLcmTPKlvxTNbpYJSqDOmfh/VIS2CvEvoa+R6rufzyYk12YFcKXKveovy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821564; c=relaxed/simple;
	bh=ThANCJe0mMVwkQnwr/8+vtZab4d0TbCR55iUczgPlFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSSQ7pqTsRpSsuRdfXwMVR+BBVluupo6kgg0hkFiknqjwEwq1Hvqk9+H57C8uGN5pI5tLAF79yfCE3i0re3mdzLH9vBwloFVk7snDaPxIsyR6e9qQ9+AUAhcxTuv72sSfeSg9bCSyJS2XPnOyWfxjHdX7d1enQ/nKpFElgBbeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GBByIFzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KWHHu002985;
	Thu, 1 Feb 2024 21:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=UCkrEsb68g/CA/kH2pQX
	lOIqKcUt48/75BMpDZzHoLE=; b=GBByIFzdNK1N3jurJ4ptBb9xI3+n7OZZrNGV
	61Zex1OyNKVHdktDZeLSPSD9jXO7+z1zozy6PuePooHEUpeTEPZJQGQ82e2b389V
	llnI6DmCc+EngLsvp39mWSYY6/LFKZdFN3V8aRLrJkudyMilVHs5pTSORw3JLs55
	TFx1YIPvxPLYqXmtAep9yEw9kol/AoYS33gqKkzTaJ91s7T/nRV693c36FwqzlcU
	8XqJnZ43HWvdfFG2xrShUnyuB9In6g0IVTM8TK1aps+uBp3zO33ttpx73RHnnn2i
	3FGqRxL55mqw5aHRXIGDKUmtem5O2BHVqrd+FoQSctyLmFiR+A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyvb5kd9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:05:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411L5jXe014027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 21:05:45 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:05:44 -0800
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
Subject: [PATCH v4 10/10] arm64: dts: qcom: sc7280: Add DT nodes for the TBUs
Date: Thu, 1 Feb 2024 13:05:29 -0800
Message-ID: <20240201210529.7728-11-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-GUID: 5NzTFWJTp1RfHm1hEEpFDEHgNTt2J4uL
X-Proofpoint-ORIG-GUID: 5NzTFWJTp1RfHm1hEEpFDEHgNTt2J4uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=814 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010163

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
index c3a94c4c6490..9fbba9d7b090 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2881,6 +2881,7 @@ adreno_smmu: iommu@3da0000 {
 			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu",
 				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
 			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
@@ -2913,6 +2914,21 @@ adreno_smmu: iommu@3da0000 {
 
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
@@ -5637,6 +5653,7 @@ pil-reloc@594c {
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc7280-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			dma-coherent;
@@ -5721,6 +5738,86 @@ apps_smmu: iommu@15000000 {
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

