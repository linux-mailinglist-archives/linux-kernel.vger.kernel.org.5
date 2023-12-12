Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82D480EF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjLLOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbjLLOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:50:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D162D5;
        Tue, 12 Dec 2023 06:50:38 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCE0CZC011528;
        Tue, 12 Dec 2023 14:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id; s=qcppdkim1; bh=kuGSrclxLs/R
        fD+R4Gphj3d9E+Ib0FPGIH/RFehqR9U=; b=cd6a9YqGyvd+VLC0cZeRpgskozvT
        q5tOp+MnNGug4JM/J86s+8A1w00PqmgDuGEJNBqd8KtnrbSGZWPIgetCW9rDrhB8
        Ph6ZgBj5ndf05a80tm5dZAa+z1lXYw09R0FNWj0pGwlAXH7tRS7Xm+yhjfCSjn/a
        gOKVYx2+ebYhIgF049dAZ3rrB4s/rDxFJWQ2Kz65V2oE1ABkWKX/8kMuS2k56lPu
        YxCUUUC/DHFZK+hkUuHiwhW+phhl6BHvY5pN8KxNV8mOAKcOjIChY/1GBjNo6UzF
        aly8ad2K9rOSRrCvb0yphMsGQSi8EwxKsEUvf6nWcoa33UFfXn8FODxb1w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxru2g4da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 14:50:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BCEoVpr027241;
        Tue, 12 Dec 2023 14:50:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3uvhakjjpm-1;
        Tue, 12 Dec 2023 14:50:31 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCEoVo0027236;
        Tue, 12 Dec 2023 14:50:31 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3BCEoV80027235;
        Tue, 12 Dec 2023 14:50:31 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
        id D63175001C6; Tue, 12 Dec 2023 20:20:29 +0530 (+0530)
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-sm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_vnivarth@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_cchiluve@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
Date:   Tue, 12 Dec 2023 20:20:26 +0530
Message-Id: <20231212145026.20828-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jnJCdadaVPyuPpQJPng8rJ0JLxUgBKbL
X-Proofpoint-ORIG-GUID: jnJCdadaVPyuPpQJPng8rJ0JLxUgBKbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=394 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120113
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate the DTSI node for slimbus instance to be
used by BT FM client.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:
- change 0x0 -> 0 to reg property.
- reorder the DT property.
- change node tag slim_msm to slim.
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..9fec8743e19a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2528,6 +2528,31 @@
 			status = "disabled";
 		};
 
+		slimbam: dma-controller@3a84000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x03a84000 0 0x20000>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,controlled-remotely;
+			num-channels  = <31>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1826 0x0>;
+			status = "disabled";
+		};
+
+		slim: slim-ngd@3ac0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0 0x03ac0000 0 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x1826 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		lpass_hm: clock-controller@3c00000 {
 			compatible = "qcom,sc7280-lpasshm";
 			reg = <0 0x03c00000 0 0x28>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

