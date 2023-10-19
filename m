Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1487CEDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjJSCUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjJSCUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:20:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193F115;
        Wed, 18 Oct 2023 19:20:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0cvQf010860;
        Thu, 19 Oct 2023 02:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hVpwWArKFOR7iz/8pIy9T+LqI/8KFcddg3fb+bntAOY=;
 b=aQe3C/EGNZ4GkEVikvxAPw7Z7j2D0Izrkq/GuNJStzy98l1UQxea4KqsvJG2FuHPBY7+
 skYhKgZUz8J2Bd/cdAINvH38p2PznN/l52l/W2NplT1kQp2Ua3gbpAO+7DrRNlM3LOft
 9cPGYTE6HXgZDSNpgdbzpTdGVmT5J7Gs6NVr9gJ+Q73Ykw89F+GBWaVHvxZllq8huYZX
 yXPvQL/xNItkgixarSo5XsjVM47vHLdIwvU/oZn+h5IlKrGT8vJ040vyWUkbPkcZa1vk
 3nbCMMrkLvKLRzbIIuxWhkLWFhC20nudHuJrLVDr5Qtj3+O962MxlTeBSmmrQrNn7q2O 8g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttg82shh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J2Jhse005334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:43 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 19:19:42 -0700
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
Subject: [PATCH 6/6] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
Date:   Wed, 18 Oct 2023 19:19:23 -0700
Message-ID: <20231019021923.13939-7-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LMf3AF4b5XfNVZ8yZNzvowV4dXUxx1u4
X-Proofpoint-ORIG-GUID: LMf3AF4b5XfNVZ8yZNzvowV4dXUxx1u4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=984 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 055ca80c0075..984770be5e08 100644
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
@@ -5030,6 +5031,7 @@ pil-reloc@94c {
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
+			ranges;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
@@ -5097,6 +5099,89 @@ apps_smmu: iommu@15000000 {
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
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
+				qcom,stream-id-range = <0x800 0x400>;
+			};
+
+			mnoc_hf_1_tbu: tbu@150d1000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d1000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
+				qcom,stream-id-range = <0xc00 0x400>;
+			};
+
+			mnoc_sf_0_tbu: tbu@150d5000 {
+				compatible = "qcom,qsmmuv500-tbu";
+				reg = <0x0 0x150d5000 0x0 0x1000>;
+				reg-names = "base";
+				interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
+						 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
+				power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC>;
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
