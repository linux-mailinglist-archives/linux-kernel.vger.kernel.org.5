Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34787C4DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbjJKJB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345992AbjJKJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588EFD;
        Wed, 11 Oct 2023 02:01:15 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7eRcw007655;
        Wed, 11 Oct 2023 09:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=twDtchG+/R75fbDoRiyiuTcAio91V8MdtWGBxzqo184=;
 b=WBae53SuOVghA/+RdxEjb06Lt+n63qrj579Jezt4jB9qkW9otCSPgkzyyLSHPeBYcZN2
 J6Y8x7UixZmQStUszA7e5otFNhgRh6c1oKz6AQ7xIOfJqtuVnzyaCLRAeH4ZNPkoh+R+
 PLMGJjLCXtG4sLcC4ftaC4YQ1qfvXd7+OqZ8WxUrM5CVHyBN0HtSxww7AUVvu3rsESnk
 YAzgkI4R21AuiF8vMu0nsYYEJKJblrtF3ZCRcCA9bXN0el9hUdpAi94p85FmK0TOrgxB
 +5E5rlPiVYV5YLkJgj+LHJtQZzIDRFPIiG3rbsOhJvXK0Sc+A0nCs/r3eviZ83TXFKmw uA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnqh1g5e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 09:01:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B916ix020759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 09:01:06 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 02:01:01 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V2 4/4] arm64: dts: qcom: qdu1000: Add ECPRI clock controller
Date:   Wed, 11 Oct 2023 14:30:28 +0530
Message-ID: <20231011090028.1706653-5-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pmcnEh9TIUO2K5qlXHQBhYVcAIiE_In_
X-Proofpoint-ORIG-GUID: pmcnEh9TIUO2K5qlXHQBhYVcAIiE_In_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=812
 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for ECPRI clock controller on qcom QDU1000
and QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 1c0e5d271e91..1552b5c119bb 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -381,6 +381,20 @@ gcc: clock-controller@80000 {
 			#power-domain-cells = <1>;
 		};
 
+		ecpricc: clock-controller@280000 {
+			compatible = "qcom,qdu1000-ecpricc";
+			reg = <0x0 0x00280000 0x0 0x31c00>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_ECPRI_CC_GPLL0_CLK_SRC>,
+				 <&gcc GCC_ECPRI_CC_GPLL1_EVEN_CLK_SRC>,
+				 <&gcc GCC_ECPRI_CC_GPLL2_EVEN_CLK_SRC>,
+				 <&gcc GCC_ECPRI_CC_GPLL3_CLK_SRC>,
+				 <&gcc GCC_ECPRI_CC_GPLL4_CLK_SRC>,
+				 <&gcc GCC_ECPRI_CC_GPLL5_EVEN_CLK_SRC>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		gpi_dma0: dma-controller@900000  {
 			compatible = "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x900000 0x0 0x60000>;
-- 
2.25.1

