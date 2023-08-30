Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA86578DF00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbjH3TMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjH3Gfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:35:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBB107;
        Tue, 29 Aug 2023 23:35:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U4ia24002441;
        Wed, 30 Aug 2023 06:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JwFIxzI2vXWfXOrxQgmwxLc0t+CtOeyqIOpES/sxJVw=;
 b=ggn4lncbkmzVF1ALWKOZqVocsJGWaBpnWC/OXCtEkCAScofHdg5zZl6LVAO0FBGHFDdE
 1NH+WwMHjdU+zQ1kPi5o4Hq0YajzHplZtc6QXXZcuhp4yxXt+w2hLRePt2edk2VNA78U
 VjsSYWbMK15MWyR1pE7mSJO0xAxn/fAXUZ86I8sJhiHNbeLCWjUVCaTs9RI+YAs2Xoel
 5l7I1a3OmXv3jiEGSLrXBZq3Fb9FK36nHdtAfSG92m3lZEvU3gfvMqDfQqOVMvhn6sK+
 GtEgrU8Wo7vKZfNqV4YP3Yj9RdD8uEjU6aS94vzsuRG9nQXSnIC9N503/3VV9DU9Zk8X sg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss2xbbug9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:35:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U6ZRWo007667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:35:27 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 23:35:24 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH] clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
Date:   Wed, 30 Aug 2023 12:05:10 +0530
Message-ID: <1693377310-8540-1-git-send-email-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dfhj6oJtMB0NBxcjDvy0RAYe2iKrVdXz
X-Proofpoint-GUID: dfhj6oJtMB0NBxcjDvy0RAYe2iKrVdXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=935 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
This must not be scaled based on the requirement of
dependent clocks. Hence remove the CLK_SET_RATE_PARENT
flag.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index b02026f..b836159 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -71,7 +71,6 @@ static struct clk_fixed_factor gpll0_div2 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -85,7 +84,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.7.4

