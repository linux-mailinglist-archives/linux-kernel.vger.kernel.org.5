Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B77F9F93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjK0Mbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjK0Mbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:31:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E8A8;
        Mon, 27 Nov 2023 04:31:52 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBrb9u022059;
        Mon, 27 Nov 2023 12:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=kuGSrclxLs/RfD+R4Gphj3d9E+Ib0FPGIH/RFehqR9U=;
 b=MSHagY5/yS8rx4kx4SGMopN+dkyouiOprwZqfKVlh0AqLOkDD7oH6ZXmkaQ7Emwrzxgc
 ZD/dfYWTTYBAo9F55bxBH7hBP+Zs1R5Nor4kdGvzEH8PiQkB6RV71cwbGlg65eRKvEe3
 1u1YYYbxsNHxWpEm69M/dmq0q6Oox8d7mYRTptutO0gWBAFsxQ9B8xuFckEp7HIU3UH4
 t8mGD0vPKp51zlquaW5ADr2cZKrXivDffmXkmHE2P8Vv+SDyN/r63eZJfwGEwJZaOHIm
 p8+dM9pmv9y5sC5ZESLqqIEdoz3kLgUGEe+IngBFniTKoISj9gPeUlaI+q1DCNEEpU0x rg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt63043y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:31:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3ARCQnCu028171;
        Mon, 27 Nov 2023 12:31:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3uka0krc58-1;
        Mon, 27 Nov 2023 12:31:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARCVjA7000338;
        Mon, 27 Nov 2023 12:31:45 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ARCVj05000334;
        Mon, 27 Nov 2023 12:31:45 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
        id BF9D25001CE; Mon, 27 Nov 2023 18:01:44 +0530 (+0530)
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-sm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_vnivarth@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_cchiluve@quicinc.com,
        quic_dkammath@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [V2] arm64: dts: qcom: sc7280: add slimbus DT node
Date:   Mon, 27 Nov 2023 18:01:33 +0530
Message-Id: <20231127123133.23165-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mT52Myn3py5neD3AMiDixvPdthD_QXML
X-Proofpoint-ORIG-GUID: mT52Myn3py5neD3AMiDixvPdthD_QXML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=405 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270085
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

