Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A038793495
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbjIFE5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjIFE5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:57:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3DE5D;
        Tue,  5 Sep 2023 21:57:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864eK4i016042;
        Wed, 6 Sep 2023 04:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=L9PFZHLRGpbdL30l/aX76KP6EZZeuwkpfQHC6sNNV3A=;
 b=GTG3zmrfuXRVfAXNMIofzHKRMh2KY8pwExriuSYMVcMcrOscGDqNqU1Tb0I5RV446mis
 767UlqVmbhPZvbJT1LUe2h0EuXjwBc/p33dzMcmOhSsoAMJR5ElcVROAz6LT95D+E0QH
 dwCfbA8W7pXBebQ7v4Ndbqk+uDxi7A2ODsqVC9mOzWd1Zb7sK71bXI3xRv4U03JC8aPx
 GJm29eYVwkozUe5oIO79HCPGNnj6QaLqMak0VZvailWJvk8YI0nPceV7SNqS4WGz6e7c
 zNlbs6S1dA126yjBkfOcoy1uatdIj/E3cj1lQA0kLYxR4d2OT/GkBaXDIhJP8ermkF2z IQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sx62wswwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:56:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864utn3013494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:56:55 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:56:50 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:23 +0530
Subject: [PATCH RESEND 4/7] clk: qcom: ipq5332: drop the
 CLK_SET_RATE_PARENT flag from GPLL clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230904-gpll_cleanup-v1-4-de2c448f1188@quicinc.com>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
In-Reply-To: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=1076;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=YbxX6vHjNJ40xakL/aus5TWr9lsta9IkZgi23u0SLPU=;
 b=ZydZpVD1A/pDV3V4Kp7uWwcvYVImUjRCdlHXEdpsiBkuWWn7cBd6x3Esw+HJ1zEi8sA98tbHG
 rjvXAGcz+4sDhSvTwMVVd14Eq57uljRVpiyUB4GXLKMoXOevr8tBsk/
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bbezTwSyDSfYqicHI9MwI3RiJyXzqtl0
X-Proofpoint-ORIG-GUID: bbezTwSyDSfYqicHI9MwI3RiJyXzqtl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=852 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL clock rates are fixed and shouldn't be scaled based on the
request from dependent clocks. Doing so will result in the unexpected
behaviour. So drop the CLK_SET_RATE_PARENT flag from the GPLL clocks.

Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index b02026f8549b..6c74a117ef0b 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -114,7 +114,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -154,7 +153,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 

-- 
2.34.1

