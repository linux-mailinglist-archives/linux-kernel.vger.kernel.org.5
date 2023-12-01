Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A7800785
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378132AbjLAJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbjLAJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:50:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C7170C;
        Fri,  1 Dec 2023 01:50:49 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B199rrx026999;
        Fri, 1 Dec 2023 09:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=SPIqBKwQT+rj6hCXFCxATcboWXlESbduF5xNeOJ+FsY=;
 b=RrmSIr8rGybIvxxDzyGt3OzBcV6nLkwEyyxG3PfaY8LRJDazBfPfJ3l/t01qEtT35lwg
 l7Iv59dem2wi2VenLNlwDOwdC6j3naLRiwunxsXsL8RYy3hTb0itdTnCNoYnI02yGB4A
 yzHLTJbcyX6KTf2y1HEC6zjBXxsY9ZSiIeeXZzzMwZFNC5uRm4UpEYnLSYDj772Oblns
 VXa1m4WCbePevPQCKQF5q5CcHXoCZPlSnXhg+zA5N28Mza273rCxy1ldyoWE8w+CPfFB
 wEV9KaG84o2M07+Vmf/8j4Fl7BIvdhc20kCUPeCcRhvbdWoGqE8cJj2FxgXqv/43ESsd PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqcm683nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 09:50:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B19oieZ006718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 09:50:44 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 01:50:39 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date:   Fri, 1 Dec 2023 15:20:25 +0530
Subject: [PATCH v3 2/4] clk: qcom: videocc-sm8150: Update the videocc
 resets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231201-videocc-8150-v3-2-56bec3a5e443@quicinc.com>
References: <20231201-videocc-8150-v3-0-56bec3a5e443@quicinc.com>
In-Reply-To: <20231201-videocc-8150-v3-0-56bec3a5e443@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V9fIb9wk_rsJfttPRK-Pql_zU1FVe3Hb
X-Proofpoint-ORIG-GUID: V9fIb9wk_rsJfttPRK-Pql_zU1FVe3Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the available resets for the video clock controller
on sm8150.

Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/videocc-sm8150.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 1afdbe4a249d..6a5f89f53da8 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -214,6 +214,10 @@ static const struct regmap_config video_cc_sm8150_regmap_config = {
 
 static const struct qcom_reset_map video_cc_sm8150_resets[] = {
 	[VIDEO_CC_MVSC_CORE_CLK_BCR] = { 0x850, 2 },
+	[VIDEO_CC_INTERFACE_BCR] = { 0x8f0 },
+	[VIDEO_CC_MVS0_BCR] = { 0x870 },
+	[VIDEO_CC_MVS1_BCR] = { 0x8b0 },
+	[VIDEO_CC_MVSC_BCR] = { 0x810 },
 };
 
 static const struct qcom_cc_desc video_cc_sm8150_desc = {

-- 
2.25.1

