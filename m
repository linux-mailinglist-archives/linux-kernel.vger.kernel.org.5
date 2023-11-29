Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE187FD99D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjK2Oi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjK2OiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:38:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C19D50;
        Wed, 29 Nov 2023 06:38:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT9XluF015027;
        Wed, 29 Nov 2023 14:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=IJa6BP+PPWfrA9UFjtQkb844a8ab89zGjh6tjhBBWn0=;
 b=oTsxCfg6gpXbW1bIX16c9/6wNdpWWZXMzNIQs+52jOPPo1HtPr+/+hSeXuxKia/rWq6r
 ln+W2TrhwpjKB4gNOXGLC6DNPZm2ktE9UlumxNOdWZO+flymhzCM69y1Lw2vqAO+L3Zv
 FNFj1WIu0NMBIa3qNBV/qgDkXX64gN3WmLiykCPvDN+Vx4JUWZgklfDpaMM61G/hFp28
 SapHUB07f49+Yidv2NK6CglYQRH3pd11Qnc84M/tOCGzbbUN45F1jh6TYrjckoZYL0F7
 L4kS59NWkzFnC8+6KN306QTgL6n9IS0WSS5FAhcwqTPjX8M18kX4+ryO7YojtLHaTOeq GQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2s08p2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:38:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATEcRpi015109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:38:27 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 06:38:27 -0800
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
Subject: [PATCH v1 1/3] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
Date:   Wed, 29 Nov 2023 06:38:09 -0800
Message-ID: <20231129143815.7892-2-quic_jinlmao@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ovKuXZvDF6WvJS5CxjaDXg1ALlYap_vn
X-Proofpoint-GUID: ovKuXZvDF6WvJS5CxjaDXg1ALlYap_vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_12,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=581 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inport of funnel@3023000 connects to a source which is not supported
in current linux kernel. Remove the device tree node of funnel@3023000
to fix the warning. It will be added once the driver support to the
source is added to linux kernel.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6ba9da9e6a8b..e42c22b26adc 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2637,24 +2637,6 @@ funnel1_out: endpoint {
 			};
 		};
 
-		funnel@3023000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x3023000 0x1000>;
-
-			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-			clock-names = "apb_pclk", "atclk";
-
-
-			out-ports {
-				port {
-					funnel2_out: endpoint {
-						remote-endpoint =
-						  <&merge_funnel_in2>;
-					};
-				};
-			};
-		};
-
 		funnel@3025000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x3025000 0x1000>;
@@ -2681,14 +2663,6 @@ merge_funnel_in1: endpoint {
 						  <&funnel1_out>;
 					};
 				};
-
-				port@2 {
-					reg = <2>;
-					merge_funnel_in2: endpoint {
-						remote-endpoint =
-						  <&funnel2_out>;
-					};
-				};
 			};
 
 			out-ports {
-- 
2.41.0

