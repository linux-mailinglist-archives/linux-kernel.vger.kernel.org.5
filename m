Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01E7E00CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347400AbjKCJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKCJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:54:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575331BD;
        Fri,  3 Nov 2023 02:54:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A35hiAb015454;
        Fri, 3 Nov 2023 09:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=TVHU97YBjKswt+HJ1mW28PHpG50N4Z1IzTTZo/H9y/Q=;
 b=dEkzVOwIGNhGsLWpSPpsq35GX5C7LAQUcpNa7FI/usvTtj/hvNqL91HTiot9C5NM3lgp
 a3jxdQYN52PFCOKSTlD/ibZbFOJjwDthy3Sp/xh64yz8qVWqwSs30zaTcI7i37xxnsFc
 jLt3KXC96LoseKMDnZd37r6yhqSGwaDreuvoKHhc5QTjiYTLjivpE4iywlmHhL0bCUIp
 JnFqLF2AEGG0CqNvokg7JubgqLsntDROfGiFnCvyA3C6xpe+0Ns3HADz/oTqBaKckwB3
 boNvogr+E51iLHQwPZsEEomQlRBLzedT1IrHGiFnZ9c3N6UyDMBc58Dy8JhscvSquWjz Iw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u47d52tau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:54:05 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A39s2Tx005340;
        Fri, 3 Nov 2023 09:54:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3u0ucm1mc9-1;
        Fri, 03 Nov 2023 09:54:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A39oORc002783;
        Fri, 3 Nov 2023 09:54:02 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-anshar-hyd.qualcomm.com [10.213.110.5])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3A39s2bB005327;
        Fri, 03 Nov 2023 09:54:02 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4089000)
        id 90FDA52A387; Fri,  3 Nov 2023 15:24:01 +0530 (+0530)
From:   Ankit Sharma <quic_anshar@quicinc.com>
To:     cros-qcom-dts-watchers@chromium.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     Ankit Sharma <quic_anshar@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ashayj@quicinc.com,
        quic_atulpant@quicinc.com, quic_rgottimu@quicinc.com,
        quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
Subject: [PATCH v1] ARM: dts: msm: Add capacity and DPC properties for sc7280 soc
Date:   Fri,  3 Nov 2023 15:23:58 +0530
Message-Id: <20231103095358.29312-1-quic_anshar@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5MuaN2DxgyObrvDB3g-ZdCAnx3QylU94
X-Proofpoint-ORIG-GUID: 5MuaN2DxgyObrvDB3g-ZdCAnx3QylU94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=886 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030081
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
used to build Energy Model which in turn is used by EAS to take
placement decisions.

Change-Id: I57aa4b99734dc349034f84bd16b02609b4ac6e55
Signed-off-by: Ankit Sharma <quic_anshar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8601253aec70..b1890824188c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -176,6 +176,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -204,6 +206,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -227,6 +231,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -250,6 +256,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -273,6 +281,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_400>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			capacity-dmips-mhz = <1946>;
+			dynamic-power-coefficient = <520>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -296,6 +306,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_500>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			capacity-dmips-mhz = <1946>;
+			dynamic-power-coefficient = <520>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -319,6 +331,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_600>;
 			operating-points-v2 = <&cpu4_opp_table>;
+			capacity-dmips-mhz = <1946>;
+			dynamic-power-coefficient = <520>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -342,6 +356,8 @@
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_700>;
 			operating-points-v2 = <&cpu7_opp_table>;
+			capacity-dmips-mhz = <1985>;
+			dynamic-power-coefficient = <552>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
-- 
2.17.1

