Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DC7C9B20
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjJOTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjJOTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 15:39:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ACFC5;
        Sun, 15 Oct 2023 12:39:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39FJdYM2007422;
        Sun, 15 Oct 2023 19:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Cw2r5P7rc2AHmW/slXv62ryxM+XUyaOYY7+QA/UPbew=;
 b=gEKkXZL90BtTRgTOhn3miB34trw//E6+sPGlw66pChToX5hHSu0VCZOobCP8wtjK0hXd
 05+dqrQ7QTewf04P3mFxt8CCLL0TRIdctIW37C0M3lIoRGzqqwfzPqogMOAFdXv1IyVG
 1382y1FZoiP1QRx+HMrMffpyg0Glm5M0XZgDyYIL4kicKYZLRavh9AfmJPFzQNlEltU8
 yAHPoJIYVYToI2j/fMaNQMW8TEL3LwiFjlx/eM90/7OaMb2nXgAT6NIvPxNHohATII4Y
 Pkf9mKaXfWAhDvCvn86HmThU1l3sE9JdolfnwfLZrtrz02fAYc0F7hivqcswAaHY5GOG BA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqkcejj59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Oct 2023 19:39:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39FJddus003968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Oct 2023 19:39:39 GMT
Received: from hu-omprsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 15 Oct 2023 12:39:35 -0700
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
To:     <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: [PATCH V1 3/4] arm64: dts: qcom: sa8775p: add TRNG node
Date:   Mon, 16 Oct 2023 01:09:00 +0530
Message-ID: <20231015193901.2344590-4-quic_omprsing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231015193901.2344590-1-quic_omprsing@quicinc.com>
References: <20231015193901.2344590-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GwqWpBvgFhVs-C6akX_B-SaMCyZeCaKF
X-Proofpoint-ORIG-GUID: GwqWpBvgFhVs-C6akX_B-SaMCyZeCaKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxlogscore=635 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310150178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sa8775p SoC has a True Random Number Generator, add the node with
the correct compatible set.

Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9f4f58e831a4..874780b42a68 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2391,6 +2391,11 @@ ethernet0: ethernet@23040000 {
 
 			status = "disabled";
 		};
+
+		rng: rng@10d2000 {
+			compatible = "qcom,sa8775p-trng", "qcom,trng";
+			reg = <0 0x10d2000 0 0x1000>;
+		};
 	};
 
 	arch_timer: timer {
-- 
2.25.1

