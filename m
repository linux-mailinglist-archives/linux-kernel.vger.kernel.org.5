Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E679E7EEF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345804AbjKQJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjKQJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:56:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E8EA;
        Fri, 17 Nov 2023 01:56:43 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9K4Of001917;
        Fri, 17 Nov 2023 09:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PebG66nNXdJqRLMDAouFU9NILNjxdAS5y+T4OOtpBN0=;
 b=cxQv3SB1V37Xoc6s+qQBBmOpECxrFcVBm5X7O1P+7SKAeIWgziMZFXn60ouOKnwZ8EZJ
 3oDf50tfaJtU2KfdsGccPLO4E+8Mm4rJaHtWimv9SyBjS3SFlbSQnYeSMFSqv1M7PQvQ
 4Wzv5AWVarDjGRRAF0lx6mKE1Oo1KV5uqkAJKcBfFIRT0usMTXWphA3daKEIEYnpfbQf
 8ObdLfkEDmS/G8PJlTdRIBh3C76jGPkKe/rhlw1vMT+LDNYVuTblejGTXyF1Brez0kqm
 XXNj3IHbQt5RsouvmbcOLJUXGeCUvB4x22Fn7+zPS+bXkjYkePsB8BCpt177QMIAd52X 6Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue5exr2by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9udli024196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:39 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 01:56:33 -0800
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
        <netdev@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V4 4/4] arm64: dts: qcom: qdu1000: Add ECPRI clock controller
Date:   Fri, 17 Nov 2023 15:25:58 +0530
Message-ID: <20231117095558.3313877-5-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117095558.3313877-1-quic_imrashai@quicinc.com>
References: <20231117095558.3313877-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mon6nSlSkLio6haKRrdrTmDK6AZEJH4D
X-Proofpoint-ORIG-GUID: mon6nSlSkLio6haKRrdrTmDK6AZEJH4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxlogscore=843 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for ECPRI clock controller on qcom QDU1000
and QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

