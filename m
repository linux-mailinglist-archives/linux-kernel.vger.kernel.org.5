Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916EF7FD9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjK2Oic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjK2Oi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:38:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDD19A;
        Wed, 29 Nov 2023 06:38:32 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATBo1J3006806;
        Wed, 29 Nov 2023 14:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=oBkG1UN86YhS/pDNzo6G9xnrrPUcPrd5D/W/pIPrur4=;
 b=T3Bqa6rpG+9tYWlN+uhbGUD4k0G2JBX6ovd8p8mAqogb+zRMSlqLOWJW9R5KRDq/XQzj
 AHOIfL5+Pz0imfpO5V6iEdiqsatn5gKd+4Us11arwNn2lM6766cJGTheh95hTKKKVBed
 7GRRHobkdi7s2E/qMIwUjwL2JbuiTTnUV4LdtIdKGgO6nTa99VIxvmXwCTaz0PvlZ20b
 9i5Tz5wKwcwbYJUi4H/lC3gonTJxUK661hekckznSIvD4nd55TdUlt9uSusM8vJUSxGy
 TuIjZbshC68BxqUkDCvfCW1929cwmrKLUgumLsETgtl6t9Dwop0tr+TQEhVRlQIX/5di 1g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xs5ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:38:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATEcSEn014738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:38:28 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 06:38:28 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>
Subject: [PATCH v1 3/3] arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports
Date:   Wed, 29 Nov 2023 06:38:11 -0800
Message-ID: <20231129143815.7892-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129143815.7892-1-quic_jinlmao@quicinc.com>
References: <20231129143815.7892-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: boHENxzjG6ifYaVjeTpJhA53qRczPURK
X-Proofpoint-GUID: boHENxzjG6ifYaVjeTpJhA53qRczPURK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_12,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=714 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a node is only one in port or one out port, address-cells and
size-cells are not required in in-ports and out-ports. And the number
and reg of the port need to be removed.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi |  5 +----
 arch/arm64/boot/dts/qcom/sm8150.dtsi |  5 +----
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++--------------------
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bf5e6eb9d313..c4dbca4c15f2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3545,11 +3545,8 @@ etf_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@1 {
-					reg = <1>;
+				port {
 					etf_in: endpoint {
 						remote-endpoint =
 						  <&merge_funnel_out>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 97623af13464..7bae3bc6af06 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2957,11 +2957,8 @@ replicator1_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@1 {
-					reg = <1>;
+				port {
 					replicator1_in: endpoint {
 						remote-endpoint = <&replicator_out1>;
 					};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index be970472f6c4..fa4e8887d53b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3095,11 +3095,8 @@ tpda@6004000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@0 {
-					reg = <0>;
+				port {
 					tpda_out_funnel_qatb: endpoint {
 						remote-endpoint = <&funnel_qatb_in_tpda>;
 					};
@@ -3142,11 +3139,7 @@ funnel_qatb_out_funnel_in0: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					funnel_qatb_in_tpda: endpoint {
 						remote-endpoint = <&tpda_out_funnel_qatb>;
 					};
@@ -3355,11 +3348,8 @@ etf_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@0 {
-					reg = <0>;
+				port {
 					etf_in_funnel_swao_out: endpoint {
 						remote-endpoint = <&funnel_swao_out_etf>;
 					};
@@ -3443,8 +3433,6 @@ funnel@6c2d000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				port {
 					tpdm_mm_out_tpda9: endpoint {
 						remote-endpoint = <&tpda_9_in_tpdm_mm>;
@@ -3710,11 +3698,7 @@ funnel_apss_merg_out_funnel_in1: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					funnel_apss_merg_in_funnel_apss: endpoint {
 					remote-endpoint = <&funnel_apss_out_funnel_apss_merg>;
 					};
-- 
2.41.0

