Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC637C0147
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjJJQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjJJQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:10:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B345F0;
        Tue, 10 Oct 2023 09:09:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AE1cuE032120;
        Tue, 10 Oct 2023 16:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2ze266JGjp+RrczXYbwmfmlkmkR+sLP6XJ1bb4KK/Js=;
 b=GGqpwktmEZao0L8N68Fet8ik4QbrP4Eod+YpF5yRJjoyXd0DFORvb3BWkZQgDzT7quGh
 inpP3anom0dSx+9j4U4AchtxWECzjwC0w6v19H2PK1Dl5hTqOBfpa3i5GrNQfOuXlEsJ
 uMDAmJ5foF8UyyCZ1sv+VhgoSAeMlU9aVORm6u+AgRax9D4CT+w5xb6SzvJQmXRH9gSi
 th5utd7RAacsrVe29RoVGEMNnvxVIdVyu4NftQlYB8L0xPPu1EcYh6l1m+l569elHnZm
 9h+sZ8fAGtcw6Ep0PtYY3IlNBxsJHmlAnq5JFpPkHLxJ2rgq8//PYjg0o/WUIwxPpC7P lg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn492rvn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 16:09:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AG9oxA029503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 16:09:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 09:09:47 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8{2|3}50: Add TCSR halt register space
Date:   Tue, 10 Oct 2023 21:39:16 +0530
Message-ID: <1696954157-16327-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
References: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ESKQ0YorWMPsQWOpPrTFOzIssbvu60m
X-Proofpoint-ORIG-GUID: 9ESKQ0YorWMPsQWOpPrTFOzIssbvu60m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_12,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=727
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR register space and refer it from scm node, so that
it can be used by SCM driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index be970472f6c4..76f470a78608 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -671,6 +671,7 @@
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8250", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x13000>;
 			#reset-cells = <1>;
 		};
 	};
@@ -2543,6 +2544,11 @@
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,sm8250-tcsr", "syscon";
+			reg = <0x0 0x1fc0000 0x0 0x30000>;
+		};
+
 		wsamacro: codec@3240000 {
 			compatible = "qcom,sm8250-lpass-wsa-macro";
 			reg = <0 0x03240000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b46236235b7f..0a0d47d7dab1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -289,6 +289,7 @@
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8350", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x13000>;
 			#reset-cells = <1>;
 		};
 	};
@@ -1818,6 +1819,11 @@
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,sm8350-tcsr", "syscon";
+			reg = <0x0 0x1fc0000 0x0 0x30000>;
+		};
+
 		lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sm8350-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0 0x20000>,
-- 
2.7.4

