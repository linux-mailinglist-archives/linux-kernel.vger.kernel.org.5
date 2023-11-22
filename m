Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30E07F3CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKVE2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVE2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:28:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E810C;
        Tue, 21 Nov 2023 20:28:36 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM3cps9004449;
        Wed, 22 Nov 2023 04:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9VQYkMcaLMIVV28dv2nGc5Put+Zl5GtxaKJ+blbPTLQ=;
 b=g4Yj5GAairI5jb5qKCszpjROOyvtKWB/BV66+HYZ0eP4hMIXKtbVPWTeeoH6yQoMCT8Q
 JuxivqCQ3JvAL0nNztqrPUi0+sqyxs8Ebz1vB+17qpp7hd1YLkdDye/gmcHAefddo+h1
 6PVIKIJoDZ3YayuCs4UKkXvsLSGU+WdXXpAbQidFJnOCBaSanNe77IXdgdyPiZg+5/up
 G0d4oj+JiqD/6E8cRbyHXOWKAEzOK2XUmgT9j8J/itRwG8QjF1//UqU2KrQCjDg7q+3y
 TYltmrVFzs2+9j/NB1HtQ8HXuewDHhgz6YMToRBXU494H8J6pf6+STESHG11fbMUwwi/ KA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh477gphb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 04:28:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM4SWLU027721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 04:28:32 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 20:28:29 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>
Subject: [PATCH] clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
Date:   Wed, 22 Nov 2023 09:58:14 +0530
Message-ID: <20231122042814.4158076-1-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: if52tZBAd9uHOj5pC-qg4QhJ8BTTme_S
X-Proofpoint-GUID: if52tZBAd9uHOj5pC-qg4QhJ8BTTme_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_01,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=830 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the test_ctl_hi_val and test_ctl_hi1_val of gpu_cc_pll1
as per latest HW recommendation.

Fixes: 0cef71f2ccc8 ("clk: qcom: Add graphics clock controller driver for SM8150")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/gpucc-sm8150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm8150.c b/drivers/clk/qcom/gpucc-sm8150.c
index 8422fd047493..c89a5b59ddb7 100644
--- a/drivers/clk/qcom/gpucc-sm8150.c
+++ b/drivers/clk/qcom/gpucc-sm8150.c
@@ -37,8 +37,8 @@ static struct alpha_pll_config gpu_cc_pll1_config = {
 	.config_ctl_hi_val = 0x00002267,
 	.config_ctl_hi1_val = 0x00000024,
 	.test_ctl_val = 0x00000000,
-	.test_ctl_hi_val = 0x00000002,
-	.test_ctl_hi1_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x00000020,
 	.user_ctl_val = 0x00000000,
 	.user_ctl_hi_val = 0x00000805,
 	.user_ctl_hi1_val = 0x000000d0,
-- 
2.25.1

