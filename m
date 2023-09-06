Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2427793491
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjIFE5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjIFE5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:57:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8EE48;
        Tue,  5 Sep 2023 21:57:03 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864e11A011666;
        Wed, 6 Sep 2023 04:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=eaMp+g9tPVSuNq/T103we5dQP7EjpKVdAnmERjfBf60=;
 b=jZFfTdQiFbGneBpND5lcR6RE9l5/MNII0IZHR72yRn2t8C9LU3Sb70BCCKEF3KmCvNd4
 quitd+k4Gxr5fN6224SfsPy+Cy0oboLNxRG3pvKDLEPn7H/ws8pFtuav22KNRje3sRAx
 njmYXXSwnPXGi8i+k8KbVqN7+0fDguqNJ9TZOAfKw/iAfTNF1UmOP8xu6FGJR6RZ5tKv
 ftjQlyeQaUMWwtUF1iPSweoOHxMBHDFVH9oHBeMhvI7X1QvUjKjfILY4PgncWV0pLJ8/
 BNosFuaLd4nVSvXbtlrAnFydx7qujOpg4k2QZbCFs/EbDfdwJFZaYhenvA1KYx0rqmQG bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhg5bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:56:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864uo4k013456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:56:50 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:56:45 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:22 +0530
Subject: [PATCH RESEND 3/7] clk: qcom: ipq9574: drop the
 CLK_SET_RATE_PARENT flag from GPLL clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230904-gpll_cleanup-v1-3-de2c448f1188@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=1483;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=b42j23cvzaYQJVjmla5gdsmq0HAmSms0iFKcG3hVa8s=;
 b=BqXviAN68GZscSRPXRGshYEwAK2zzAe3J2O4IiGyY3o8rc3hK4Abu/TSPygT1pWJ2OEWEVazX
 Pj4o69QM3zjDSCtxpie5oxPYfLMKi7CQkPCnJxiTM4YuVJVDsqBdawo
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Br3yGuSyL6l8J4LfrOX3h8i0sqU6oukI
X-Proofpoint-ORIG-GUID: Br3yGuSyL6l8J4LfrOX3h8i0sqU6oukI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=823 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL clock rates are fixed and shouldn't be scaled based on the request
from dependent clocks. Doing so will result in the unexpected behaviour.
So drop the CLK_SET_RATE_PARENT flag from the GPLL clocks.

Fixes: d75b82cff488 ("clk: qcom: Add Global Clock Controller driver for IPQ9574")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 8f430367299e..e8190108e1ae 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -87,7 +87,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_fixed_factor_ops,
 	},
 };
@@ -102,7 +101,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -132,7 +130,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 			&gpll4_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -162,7 +159,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 			&gpll2_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };

-- 
2.34.1

