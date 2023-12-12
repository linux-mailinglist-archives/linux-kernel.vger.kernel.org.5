Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608DB80EB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjLLL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346377AbjLLL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:59:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD124F3;
        Tue, 12 Dec 2023 03:59:41 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC7gRwX028744;
        Tue, 12 Dec 2023 11:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=eGw0cQhVrtcmurS3n/ixC3C1je1QddxvzESq1C6/PT8=; b=I/
        8KUQAaqcUdeBzl/iO3A+Mgm9tL20Fe6rpDxjI2g7R48aTag3tMCIowhaiN5jga7n
        sN0UYGlnmG92JATG/KXbznAaWWevI3HimD9iRgWFvSkHcHG5gbZwCKdTQ6CRW8uv
        FTsIBs9rXIx2Nfd4eXSUmOFVNd3FVbXAyR1q/Vm7a7xqDgeWYDAyk2L2u7F2Rsou
        nBM7Ev1cbDGRGBtxTF4DCoWPweA0PPmLeElnPlijE6iV6bJv+qS9PxIkmpbCM7Z+
        P/jz3i2RFAUZhFNCYyJd4ju6Ikg9nyjYaLzRiSm9oWkXZXmBbemzbaje/w09f3v2
        j3LYRiUW8xholTYg9YRg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxkc80jkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBxPl3009396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:25 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:59:15 -0800
From:   Suraj Jaiswal <quic_jsuraj@quicinc.com>
To:     <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v6 2/3] arm64: dts: qcom: sa8775p: enable safety IRQ
Date:   Tue, 12 Dec 2023 17:28:40 +0530
Message-ID: <20231212115841.3800241-3-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
References: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3pL_bZvDRVXc3uadJ_iiduOUHTkc5u7k
X-Proofpoint-ORIG-GUID: 3pL_bZvDRVXc3uadJ_iiduOUHTkc5u7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=700 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to support safety IRQ handling
support for ethernet.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 2da567a6f64e..36380a4d2b0e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2394,8 +2394,9 @@ ethernet1: ethernet@23000000 {
 			      <0x0 0x23016000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";
 
-			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "sfty";
 
 			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
 				 <&gcc GCC_EMAC1_SLV_AHB_CLK>,
@@ -2427,8 +2428,9 @@ ethernet0: ethernet@23040000 {
 			      <0x0 0x23056000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";
 
-			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "sfty";
 
 			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
 				 <&gcc GCC_EMAC0_SLV_AHB_CLK>,
-- 
2.25.1

