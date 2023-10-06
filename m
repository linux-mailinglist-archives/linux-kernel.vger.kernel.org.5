Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033937BB109
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjJFEy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJFEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:54:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB58100;
        Thu,  5 Oct 2023 21:54:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3963dqlg000939;
        Fri, 6 Oct 2023 04:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Y57dG8ltw7MucdbZ+M3Satn38fEJHaAh5pACALJTxQA=;
 b=CmsrXYNNMKkiryQRDSG9KT9oDcJNZRqIpNgFWhXLOSV5B7Zg4j6C5XOwzYHFbhLXax/D
 RBn5sf1T9eYRWsM7nhRO9BNkgzvl6gWV8kAxA20Es9uPYIhqWwJKHM5LqLNzYLZLDr/M
 s+iwZSiDk79SoB1oVG/Ui6mFI/drozRiqzBdXq4b61EiDUXPIDomhVuePp2Y7q2rfsV4
 gcq8ZHNnITpXDG04OtlU7a4ojIKXcEyintKCArf+iPm4xr+pGJosIBjVtw10Tou/OO4s
 lvx3isVkInEfEDkDeMmflfKORNDHrmZ/e9QoEm8fkOO56sMOwFHuFBrurLmAL1ocuI5a bA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thnfaajjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 04:53:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3964ruLF005160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 04:53:56 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 21:53:51 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 4/4] arm64: dts: qcom: ipq5332: Add pwm support
Date:   Fri, 6 Oct 2023 10:23:17 +0530
Message-ID: <20231006045317.1056625-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DgdSN-ND56AvD-Zj2k5_JEHKD7l0FYxu
X-Proofpoint-ORIG-GUID: DgdSN-ND56AvD-Zj2k5_JEHKD7l0FYxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_01,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=783 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM support in ipq5332. The PWM is in the TCSR area. Make tcsr
"simple-mfd" compatible, and add pwm as a child of &tcsr.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d3fef2f80a81..7620f1ccd324 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -210,8 +210,21 @@ tcsr_mutex: hwlock@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "qcom,tcsr-ipq5332", "syscon";
+			compatible = "qcom,tcsr-ipq5332", "syscon", "simple-mfd";
 			reg = <0x01937000 0x21000>;
+			ranges = <0x0 0x01937000 0x21000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pwm: pwm@a010 {
+				compatible = "qcom,ipq5332-pwm", "qcom,ipq6018-pwm";
+				reg = <0xa010 0x20>;
+				clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clock-rates = <100000000>;
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		sdhc: mmc@7804000 {
-- 
2.34.1

