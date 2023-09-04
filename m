Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C2791BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbjIDRZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353282AbjIDRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:25:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6371E5D;
        Mon,  4 Sep 2023 10:25:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384HII86002121;
        Mon, 4 Sep 2023 17:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iXlzgV1RLiHmPjlxFYcdDCIVinWYZfrvMbiWVRhYLc8=;
 b=lq9w8+BWe3AAC5/TDsKkurMNooOckTMUcbq94cV9IVDvjTndbOr1dJl9C8Do/hwk0EHH
 FR5jy/N4kJK98iQZa3xaV/rKjKX+ISaSlkUh/fwFGB4+FA6haq9D1Nk1wd/aNPXwAnMI
 n/NNQh8DascllEpB1OPcFbXiJIf1eErCGJ9aGEUELkr8mTSf6Dt8bbJ7R+4RzrHrUaV2
 9OLVqqu5ABd1pewNZEYyX8FCIRalRvfB6+5t/GuxelQ89xDKcUQ3Lga0ukeh/A2G0wc1
 ywxqk8OIExv684fS/66rbC109eN/A5F/BkzBmQLwFN0tHGS1w+7OpuMqFwD8OIO1fXKA IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw99ce51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 17:25:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384HPdUB010120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 17:25:39 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 4 Sep 2023 10:25:35 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: ipq5332: Fix hwlock index for SMEM
Date:   Mon, 4 Sep 2023 22:55:12 +0530
Message-ID: <20230904172516.479866-2-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904172516.479866-1-quic_viswanat@quicinc.com>
References: <20230904172516.479866-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: svDIgTLdYA1vlOtciwtJjuceQIabCoRR
X-Proofpoint-ORIG-GUID: svDIgTLdYA1vlOtciwtJjuceQIabCoRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=592 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040156
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
in SMEM region shared by the Host and FW.

Fix the SMEM hwlock index to 3 for IPQ5332.

Cc: stable@vger.kernel.org
Fixes: d56dd7f935e1 ("arm64: dts: qcom: ipq5332: add SMEM support")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 1abc992ede31..a47c79c3d5f0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -135,7 +135,7 @@ smem@4a800000 {
 			reg = <0x0 0x4a800000 0x0 0x100000>;
 			no-map;
 
-			hwlocks = <&tcsr_mutex 0>;
+			hwlocks = <&tcsr_mutex 3>;
 		};
 
 		q6_region: wcnss@4a900000 {
-- 
2.41.0

