Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898247EFDBC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjKRE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjKRE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:28:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC1D7E;
        Fri, 17 Nov 2023 20:28:04 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI4K7pO031048;
        Sat, 18 Nov 2023 04:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Jx7XpE4p1+yp472e6E8rOuie91cn+ZCzBIkBDICt56c=;
 b=jbtlV97JqKuVgtdayWyHjG8258pkiunQF4vdsf1eNFTcghxt/5T4y2EE83u3KrAtlX9Z
 UBmuopyFaNDu1+VePio3P+Oz0XWsdxSDqd2ZLdvsj/ytbFlS58aXpkvWuct3rbXFLXcy
 coqVOqAN8uEIWBDvps051r48tzZ3sGa+puG5k5a3WXn71wYYQ9u9TrpeX4yNeSqgJJfk
 li7aKmUUeWfcYF/Pqjz6Ea68iK/QxNTYHQD8jVcBbis6iPpGrX0TiUxVAqTwIxUMg8WX
 s7wQXSJcM65f6oMuqYmbG3bLy4xgO1U5AKw/NkVBZb7QjA/KMyTenlGxPQMKlWfPKIAh xg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uemks03pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI4RjeQ005937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:45 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 20:27:45 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC:     <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v2 6/6] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
Date:   Fri, 17 Nov 2023 20:27:30 -0800
Message-ID: <20231118042730.2799-7-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9JEs0RbV9wY5aJ2WFQgM00B4DHU9SYmY
X-Proofpoint-ORIG-GUID: 9JEs0RbV9wY5aJ2WFQgM00B4DHU9SYmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_02,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=975 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device-tree nodes for the TBUs (translation buffer units) that
are present on the sdm845 platforms. The TBUs can be used debug the
kernel and provide additional information when a context faults occur.

Describe the all registers, clocks, interconnects and power-domain
resources that are needed for each of the TBUs.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bf5e6eb9d313..5c7174415ae9 100644
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
@@ -5000,6 +5001,7 @@ pil-reloc@94c {
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
@@ -5067,6 +5069,86 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			anoc_1_tbu: tbu@150c5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150c5000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC>;
+				qcom,stream-id-range = <0x0 0x400>;
+			};
+
+			anoc_2_tbu: tbu@150c9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150c9000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC>;
+				qcom,stream-id-range = <0x400 0x400>;
+			};
+
+			mnoc_hf_0_tbu: tbu@150cd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150cd000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				qcom,stream-id-range = <0x800 0x400>;
+			};
+
+			mnoc_hf_1_tbu: tbu@150d1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d1000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				qcom,stream-id-range = <0xc00 0x400>;
+			};
+
+			mnoc_sf_0_tbu: tbu@150d5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d5000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				qcom,stream-id-range = <0x1000 0x400>;
+			};
+
+			compute_dsp_tbu: tbu@150d9000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d9000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				qcom,stream-id-range = <0x1400 0x400>;
+			};
+
+			adsp_tbu: tbu@150dd000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150dd000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC>;
+				qcom,stream-id-range = <0x1800 0x400>;
+			};
+
+			anoc_1_pcie_tbu: tbu@150e1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150e1000 0x0 0x1000>;
+				reg-names = "base";
+				clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
+						 &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
+				qcom,stream-id-range = <0x1c00 0x400>;
+			};
 		};
 
 		lpasscc: clock-controller@17014000 {
