Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17A47FE73C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbjK3Cl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjK3Cli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:41:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB7C2106;
        Wed, 29 Nov 2023 18:41:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU1w0Lb032280;
        Thu, 30 Nov 2023 02:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NG9I1G0X8qGtV+iKDMIHc5ELgYmOY7NR8JvLyp7Bq/w=;
 b=OiklyyxDV5UqKB9xZvoTpsERKeqa6kzXnRrqF8+g4yKKYdGeGTJc7gJ8mElKyCp++Cp5
 q7mKrqtvpLFXY+fjQK32F+6du5xUGqy1U8YYyO+Rn4BB/sBQUJNx5Fdh5bhGRUO+2wIq
 YR7UVTB0ozmd7q75c5mijOQL0ylwo76COAht68yI952oal15yK1GhIMXxsnAV1Es5Hrc
 mQ5uG9r/P15farmypqS0LLVmdwkJSOPLY9Dcaa3z0qn6j0IBVadGlYzrHG7kOWUuSD1J
 xxcHq/wVaPFSOAw7oFQ5Uj5lztff03ckwaeQrHRYb0hYCvIWoug4K2jGhpYWSW8E6y8e Gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upbu58ptx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 02:41:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU2fNF7000739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 02:41:23 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 18:41:18 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v5 3/4] pinctrl: qcom: sm4450: Convert to platform remove callback returning void
Date:   Thu, 30 Nov 2023 10:40:45 +0800
Message-ID: <20231130024046.25938-4-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130024046.25938-1-quic_tengfan@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t9To6LIopDzTYokD0mVmdgTI-TbtOzC1
X-Proofpoint-GUID: t9To6LIopDzTYokD0mVmdgTI-TbtOzC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=930
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .remove_new() instead of .remove() for converting to platform remove
callback returning void.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-sm4450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm4450.c b/drivers/pinctrl/qcom/pinctrl-sm4450.c
index 20ad639087ed..49e2e3a7a9cb 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm4450.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm4450.c
@@ -993,7 +993,7 @@ static struct platform_driver sm4450_tlmm_driver = {
 		.of_match_table = sm4450_tlmm_of_match,
 	},
 	.probe = sm4450_tlmm_probe,
-	.remove = msm_pinctrl_remove,
+	.remove_new = msm_pinctrl_remove,
 };
 MODULE_DEVICE_TABLE(of, sm4450_tlmm_of_match);
 
-- 
2.17.1

