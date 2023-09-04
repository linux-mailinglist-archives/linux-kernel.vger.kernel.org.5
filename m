Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A5791C05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjIDR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353361AbjIDR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:26:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064F173F;
        Mon,  4 Sep 2023 10:26:00 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384GvLDc007055;
        Mon, 4 Sep 2023 17:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rHR17i34maR8MoM9D8VghM9Ml7jDe5VxjJcIip/f/SQ=;
 b=psLVvELwmLDHpWD7VMoW9DU/pinKK+72d4Sv4Qp0xhC7Jtw7IKc+YzYXeGTVifwm4M7r
 ECbjVBp8nStjk6iW4ALoZmdYkmMrN9k8QJ2aAlu9NJtU7hc0jHMTU23fxNNcGLIDiM0/
 p5ImDK/WYYsc7qp3xHUAyG4pcsgtbkbcOzIuoAu2ST2tiVp8IqqI6l6q7wn+M7Fa3PHW
 xrs9s/lr9xstEiJKL0rF0UdQcnn/OmxIcfnR/YFST+C14Blue8RxQ9Ns+ACJc+GgxZMD
 zOyft5yZSvKVOnslAovn1cUcxLNIz8RCdIz/0Z09ASV6QwIsk5529XYCgSFeOJGS5bZM wA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sux7tv7fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 17:25:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384HPsDd008864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 17:25:54 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 4 Sep 2023 10:25:49 -0700
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: ipq9574: Fix hwlock index for SMEM
Date:   Mon, 4 Sep 2023 22:55:15 +0530
Message-ID: <20230904172516.479866-5-quic_viswanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CGRI8mjzcpW295a2MW3-vW8cKm3WziPI
X-Proofpoint-GUID: CGRI8mjzcpW295a2MW3-vW8cKm3WziPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=641 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040156
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

Fix the SMEM hwlock index to 3 for IPQ9574.

Cc: stable@vger.kernel.org
Fixes: 46384ac7a618 ("arm64: dts: qcom: ipq9574: Add SMEM support")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index f22f7e78850d..cc0e4a2b67d2 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -195,7 +195,7 @@ tz_region: tz@4a600000 {
 		smem@4aa00000 {
 			compatible = "qcom,smem";
 			reg = <0x0 0x4aa00000 0x0 0x100000>;
-			hwlocks = <&tcsr_mutex 0>;
+			hwlocks = <&tcsr_mutex 3>;
 			no-map;
 		};
 
-- 
2.41.0

