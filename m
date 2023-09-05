Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5679266C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjIEQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354144AbjIEJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:56:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A8518C;
        Tue,  5 Sep 2023 02:56:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3859kEnh026724;
        Tue, 5 Sep 2023 09:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=1oM7Ddcdw6DruVYNY/4l4p419ghX/VdyhNSoQ2uzhMo=;
 b=IbngKgM+G5qgci3yo1duX5OXIyO8DKCXl5MOcIK3qZ7o7Rs9ZcQMsJ6eHEiJBqIaA1Du
 yQcEiqmP32qP0RaV4BuTq7r53fB7MAIbNKTynXGiBRKbaAAK35+H36hrimJET5D/J781
 RV7AQJxCPs/QD9NwRC1zxOVBMmh9Wte2ZaaVT48YJ7lSWD4tGOhPqUIknqVHIW3sqV1C
 S03DbblP72AdWgMU42526q1eXLk8QTdEuA3j5Bcwx/pdtXl6wX4S0IiTAKQjjZ4C/hzi
 QisZsYOo8cHNrY6hiTs4eOvaz8UCVi0KS1nr9vxeO9CBXYcpjfBL3W9jzDa2754+odqW tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtevgs9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 09:56:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3859uZeG027254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 09:56:35 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 5 Sep 2023 02:56:30 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size
Date:   Tue, 5 Sep 2023 15:25:34 +0530
Message-ID: <20230905095535.1263113-2-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
References: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fxw4TspHekJzqnBJEBoJI0y2ajonVuzX
X-Proofpoint-ORIG-GUID: Fxw4TspHekJzqnBJEBoJI0y2ajonVuzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=832
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018's TCSR Mutex HW lock register has 32 locks of size 4KB each.
Total size of the TCSR Mutex registers is 128KB.

Fix size of the tcsr_mutex hwlock register to 0x20000.

Changes in v2:
 - Drop change to remove qcom,ipq6018-tcsr-mutex compatible string
 - Added Fixes and stable tags

Cc: stable@vger.kernel.org
Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 47b8b1d6730a..9793279e2ced 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -393,7 +393,7 @@ gcc: gcc@1800000 {
 
 		tcsr_mutex: hwlock@1905000 {
 			compatible = "qcom,ipq6018-tcsr-mutex", "qcom,tcsr-mutex";
-			reg = <0x0 0x01905000 0x0 0x1000>;
+			reg = <0x0 0x01905000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
-- 
2.41.0

