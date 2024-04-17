Return-Path: <linux-kernel+bounces-148600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00C8A84F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A81C209FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EC142658;
	Wed, 17 Apr 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mGaQ7kf8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938E140E34;
	Wed, 17 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361088; cv=none; b=DlKdUsBNsJiGGch0aXEostNXVZLlGlbxz89aHXmyJOryXY/iLWhti0B83ljlSrIex4CEUU6GgjY3BuDG40gp4Fyw2sjCpMK/bNuNgA+d5JHBdhPMYjWsWA3MVXGRUQTlBZU8pAQRRGV+vLLb5kZq8po3I2xspltTTTuwP/DHmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361088; c=relaxed/simple;
	bh=5Vky7K0DZqrss0qsnGFii3GbU/Sth0eeuCqa5KB3w1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jv/wZonsXzmiVompkujb5z+GAkEaLcxM3Xf1GU/AMplCHqkqsxdanGglQCExjCjegGaT1gNV0wfUpyeit8S/EV7jJDV6kMg3P/ccQixFouSQIgObHzxnyT6Oso9Gnl9IKQE4XlgarQcfmlotjuKpXKpntxCAvnPg8H0CYqdSXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mGaQ7kf8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H5UFMb001500;
	Wed, 17 Apr 2024 13:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XJMeKNFBI/rKVus76WRLPBnMVckkBMsqVE6D4xXLPNU=; b=mG
	aQ7kf8sp8DcIXn6Rsvmfr0rqgEPyHMIFiMKmkAeMHVgPgoY0iM9XXzlRek14ndge
	nG9/CMd9e+jw12J4ju4/f5byftgSEKIdw0yVDKuNsSOJ+l4KHEI5X2PWqk+XkPmL
	XIyo1BMctq/iWE7pZ2tu7cvpCTuYdsYExkAcEkDK5eXHWzFNnQjMPP6G/eAsqeOK
	rG66oOzvKTdK/5MGmK9K+b8PQaYR8A0odoLjYxtU+c0DqrBwAVfj4wS4QDW/ECeg
	eJCckkSoJehVwv5zWtYhvqyANO6eAxCXx02U+EsKhFUMvrcUmP2l/Df8luGQNWLK
	nKEjXkf2lY3Im+Z5Nkew==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8aus327-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDbk7O008641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:37:46 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:37:46 -0700
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
Subject: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
Date: Wed, 17 Apr 2024 06:37:29 -0700
Message-ID: <20240417133731.2055383-6-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ryoMqsVe4SHkz5H4tmE1y-luaCoZt6WP
X-Proofpoint-GUID: ryoMqsVe4SHkz5H4tmE1y-luaCoZt6WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170094

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sdm845 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f20be99ee7e..fa9403aad96f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -5085,6 +5086,78 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		anoc_1_tbu: tbu@150c5000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150c5000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x0 0x400>;
+		};
+
+		anoc_2_tbu: tbu@150c9000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150c9000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x400 0x400>;
+		};
+
+		mnoc_hf_0_tbu: tbu@150cd000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150cd000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
+		};
+
+		mnoc_hf_1_tbu: tbu@150d1000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d1000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
+		};
+
+		mnoc_sf_0_tbu: tbu@150d5000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d5000 0x0 0x1000>;
+			interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
+		};
+
+		compute_dsp_tbu: tbu@150d9000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150d9000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
+		};
+
+		adsp_tbu: tbu@150dd000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150dd000 0x0 0x1000>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1800 0x400>;
+		};
+
+		anoc_1_pcie_tbu: tbu@150e1000 {
+			compatible = "qcom,sdm845-tbu";
+			reg = <0x0 0x150e1000 0x0 0x1000>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+			qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
+		};
+
 		lpasscc: clock-controller@17014000 {
 			compatible = "qcom,sdm845-lpasscc";
 			reg = <0 0x17014000 0 0x1f004>, <0 0x17300000 0 0x200>;

