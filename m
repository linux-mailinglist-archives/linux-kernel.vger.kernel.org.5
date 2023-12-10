Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430980B9AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjLJH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjLJH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:26:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB217B7;
        Sat,  9 Dec 2023 23:26:51 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BA7FlpX006873;
        Sun, 10 Dec 2023 07:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=epupJxbLnE3q/89ZQF8hZ0X0NAXOB0INxckkyrikmMQ=; b=Rs
        p3b/cR0iQDAbdRLPYPIhSo72xeEjvNiaOWnbnusidEFUa2/0hiEZaH/J+rVuiOf4
        4YaSGteEENu7NjEFmT9cKj4uhGNBnP4BRWcY5BJAIYSanNNDdVOISvViByrEUHOU
        kH3LMpqq8Wl4I2nfZjL0tf1akdGH8Fl0hun31ryM5bLbfofoFM99Nx7+RsbwbKX6
        3zQ5lFowNk9z3OUFw2xQscMQHbRgsqcszSnCG2Y4lLOg9Zsc0uIyzZxc+4ZoB1IR
        0cHKCd6ATqqRibcB9jT6G4SFKjMLEqQWQvy2pqlgbxIsKHpVqzIpd57tVE6J3Thy
        ZIHy+X+W0Ply0pLqUYNw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvney13k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 07:26:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BA7QkLJ005586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 07:26:46 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 23:26:45 -0800
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
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/4] arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports
Date:   Sat, 9 Dec 2023 23:26:31 -0800
Message-ID: <20231210072633.4243-5-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
References: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6gzPLLVnvpMt_Buzv5zayHgUCoo32ffr
X-Proofpoint-ORIG-GUID: 6gzPLLVnvpMt_Buzv5zayHgUCoo32ffr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=729 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312100063
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

