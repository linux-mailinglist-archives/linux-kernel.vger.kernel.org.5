Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08C76645C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjG1GiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjG1Ghx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:37:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35A30F9;
        Thu, 27 Jul 2023 23:37:29 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S4OL0T011069;
        Fri, 28 Jul 2023 06:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OYB4DN780sa0RziItOPQhhDvhWtGSM2KrBT0QWTFRpc=;
 b=Pi0PzfA4rhMmeFPp5va1GkS2Zg10mhviCXsyqFOy13hYFtqZDzKKDrvTHR0M04fxvRfp
 MmZPFgLRqQS/tztNkm8ZjZHKcxpjUiKzI85NbqUpeJ6Man2RZUeKlqfrbeZ3H6Vs51JD
 VWVwQrKVSdZLarEaRIwEjWEkfpl/iZ1R8rWdPTVDRwyz7OjWQqZ6seoqrUBEv7f/H8zy
 UWtIBJouypNE8fEejPLCiL+2THAPRq47vqTPaFaeM24/XDiq8Lchdwa8LpzpKNi2i1eJ
 zszA/D0lUMpfAVg6rNvr3LcBPSXnBM9hWfolBuRiXSPPARUyLamqeSBYJY6IBtIhEODy ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u2st4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:35:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S6Zf0O010938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:35:41 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 23:35:34 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v4 10/11] arm64: dts: qcom: ipq5332: Add nodes to bringup multipd
Date:   Fri, 28 Jul 2023 12:04:11 +0530
Message-ID: <20230728063412.1641856-11-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cVMbQFSRsIKiS52XGGE7A4QZbueuWYxU
X-Proofpoint-ORIG-GUID: cVMbQFSRsIKiS52XGGE7A4QZbueuWYxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=721
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable nodes required for multipd remoteproc bring up.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in v4:
	- Rebased on linux-next

 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 21 ++++++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 60 +++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index e89e2e948603..e0e2f9238b47 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -21,6 +21,27 @@ &blsp1_i2c1 {
 	status = "okay";
 };
 
+&q6v5_wcss {
+	pd-1 {
+		firmware-name = "ath11k/IPQ5332/hw1.0/q6_fw1.mdt";
+		interrupts-extended = <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
+				      <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
+				      <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
+				      <&wcss_smp2p_in 11 IRQ_TYPE_NONE>;
+		interrupt-names = "fatal",
+				  "ready",
+				  "spawn-ack",
+				  "stop-ack";
+
+		qcom,smem-states = <&wcss_smp2p_out 8>,
+				   <&wcss_smp2p_out 9>,
+				   <&wcss_smp2p_out 10>;
+		qcom,smem-state-names = "shutdown",
+					"stop",
+					"spawn";
+	};
+};
+
 &sdhc {
 	bus-width = <4>;
 	max-frequency = <192000000>;
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 8bfc2db44624..1abc992ede31 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -137,6 +137,11 @@ smem@4a800000 {
 
 			hwlocks = <&tcsr_mutex 0>;
 		};
+
+		q6_region: wcnss@4a900000 {
+			reg = <0x0 0x4a900000 0x0 0x2b00000>;
+			no-map;
+		};
 	};
 
 	soc@0 {
@@ -405,6 +410,37 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		q6v5_wcss: remoteproc@d100000 {
+			compatible = "qcom,ipq5332-q6-mpd";
+			reg = <0xd100000 0x4040>;
+			firmware-name = "ath11k/IPQ5332/hw1.0/q6_fw0.mdt",
+					"ath11k/IPQ5332/hw1.0/iu_fw.mdt";
+			interrupts-extended = <&intc GIC_SPI 421 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 0 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 1 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 2 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 3 IRQ_TYPE_NONE>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			qcom,smem-states = <&wcss_smp2p_out 0>,
+					   <&wcss_smp2p_out 1>;
+			qcom,smem-state-names = "shutdown",
+						"stop";
+
+			memory-region = <&q6_region>;
+
+			glink-edge {
+				interrupts = <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>;
+				label = "rtr";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 8>;
+			};
+		};
 	};
 
 	timer {
@@ -414,4 +450,28 @@ timer {
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	wcss: wcss-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 9>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		wcss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		wcss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
 };
-- 
2.34.1

