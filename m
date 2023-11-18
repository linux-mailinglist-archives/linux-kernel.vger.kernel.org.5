Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42797EFFA2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjKRMko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKRMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:40:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D934B3;
        Sat, 18 Nov 2023 04:40:36 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AICWZMl002500;
        Sat, 18 Nov 2023 12:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=1ReBl32ch9YFe5D412NtiGQQlGBtKJQqWGTqait7D6M=;
 b=R5a0n4nYUGpVdt8Q1ID/08ymTEUSMXyK2p8ws51i1YW1NgOiq2T9f9vB62TrtN/OdUx6
 AVLmsAZ3IIspf4mKlk4jzwjk95A9LIteOXd7mOSD5ohMhd6niwIHCirn0q6GPLYm8HK6
 YMm60jcu/8mmuF0xQ+dOECe9NfgiXiKAF43phPalNU6qHzIcDtPcuVcpj5rg+YMglmnr
 HnDmZsj5NITnr6JKsOgX46Tui0LhtN76T0Ea5CCoFaED9FnyNsLob0VvDzo7fO17/jdz
 57nOhCpdDXR8vngGjonadVETsOBJlO7XXrCN4i/6lZPxgdZHjehupmAcMd70n9A5+vyz 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uepf2ge9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AICeWts005145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 12:40:32 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 Nov 2023 04:40:27 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>
Subject: [PATCH V2 2/4] clk: qcom: videocc-sm8150: Update the videocc resets
Date:   Sat, 18 Nov 2023 18:09:42 +0530
Message-ID: <20231118123944.2202630-3-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0kACsSGbu8YHSRJP9mjiHQYnPbO0YrKn
X-Proofpoint-GUID: 0kACsSGbu8YHSRJP9mjiHQYnPbO0YrKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_11,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes since v1:
- None.

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

