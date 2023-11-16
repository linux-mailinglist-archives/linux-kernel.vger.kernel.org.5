Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE67EE6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjKPSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjKPSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:39:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DEF1A7;
        Thu, 16 Nov 2023 10:39:45 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHtcZD014734;
        Thu, 16 Nov 2023 18:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=X6oPfkHxe/YCx9FsY+hafUep44il5oQO9yswemvtjj8=;
 b=amdREPg/jCilXxBeYfKMriql2xZTY4FgxT/myLNYPJcIvuV+jMdZ4SR7+pbH7d9JaMYW
 2EeFgb7/ygrg9lu44SBCoNAM6ZsPnF7xKQcoTk2Z0Tt0Uom73Mtxu2fnuTORNbZv/H1/
 Zj5dAl7AWa8eoV027sl/jDte2o3WfC2gMprXPuqIbwCxAH0U7R0NHnOUY3obvzL+evew
 HX8T7K3gLthTDzilAnzaTbT0CyryPxl7hIPq6Ns+VnyT6X/9CEZIiPAc57MWY0jaOu2o
 D0RXoolr8ku8MCPF8zU6FlVMfst18o8DNRyUlSyDmx4q2yCYXyXIGSRxHb2/bwJdqwtp MQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udeww9dna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 18:39:42 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AGIdcGu018671;
        Thu, 16 Nov 2023 18:39:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmjsx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Nov 2023 18:39:38 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGIdbZc018665;
        Thu, 16 Nov 2023 18:39:37 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3AGIdbqv018663;
        Thu, 16 Nov 2023 18:39:37 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
        id E98265001D9; Fri, 17 Nov 2023 00:09:36 +0530 (+0530)
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-sm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vnivarth@quicinc.com, msavaliy@quicinc.com, vtanuku@quicinc.com,
        cchiluve@quicinc.com, dkammath@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH 1/1] arm64: dts: qcom: sc7280: add slimbus DT node
Date:   Fri, 17 Nov 2023 00:09:09 +0530
Message-Id: <20231116183909.32179-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zr8Urot-si1W6OXq_rMpvCI1CdoPjccU
X-Proofpoint-GUID: Zr8Urot-si1W6OXq_rMpvCI1CdoPjccU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_19,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=476 phishscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160147
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slimbus DT node to enable slimbus usecase on Bluetooth
for audio streaming and playback.

Based on requirement, client team can enable slimbus node
on target specific dt file.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..fba352504f3f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2528,6 +2528,31 @@
 			status = "disabled";
 		};
 
+		slimbam: dma-controller@3a84000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x0 0x03a84000 0x0 0x20000>;
+			#dma-cells = <1>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,controlled-remotely;
+			num-channels  = <31>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1826 0x0>;
+			status = "disabled";
+		};
+
+		slim_msm: slim-ngd@3ac0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0x0 0x03ac0000 0x0 0x2c000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x1826 0x0>;
+			status = "disabled";
+		};
+
 		lpass_hm: clock-controller@3c00000 {
 			compatible = "qcom,sc7280-lpasshm";
 			reg = <0 0x03c00000 0 0x28>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

