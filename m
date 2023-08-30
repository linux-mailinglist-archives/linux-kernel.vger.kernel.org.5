Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023FC78DE80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjH3TED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbjH3K5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18E1A4;
        Wed, 30 Aug 2023 03:57:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UARpI0017642;
        Wed, 30 Aug 2023 10:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2+Tg2jjmTOt225lFxMzRvDU069JJmdLc3mInsQZQR4A=;
 b=XZXsghl/oWlCnWTFhnegMvLsoNMkXaHWajb4nZGiO7oLEOAqmJ0T70WliCYhEjsB/akN
 VLfWwrDuGTOEr7Mk9bdP3hQtcOoOBfYca9UTcSUTDfbeLPHW4Qv1puJoLSnrRzT8vrVz
 PMuWv14NFIg300VHTC4iBiIt1BEEvKScERBp6GXibL7W5nP8v/G+7qXbE5YESX2XCwHS
 x3CD7jIpp4tdXUaseZ0iAiQC2cA/psqV4vcdBwRcLasuDMIrlznANclQacqWEqQhRKK9
 kOY9Pz8leq/FIK1CqUSRIvXvmb6+fL4N4THYL/mF2wPz/7kAkwn8CxuGbs35OO1xcGUK JA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0tard3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UAviP5015119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:44 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 03:57:40 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v8 5/6] soc: qcom: llcc: Updating the macro name
Date:   Wed, 30 Aug 2023 16:26:53 +0530
Message-ID: <20230830105654.28057-6-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZkbZuGPbvbgXXZSEKM8AoJ06gk6AoqED
X-Proofpoint-ORIG-GUID: ZkbZuGPbvbgXXZSEKM8AoJ06gk6AoqED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update macro name for LLCC_DRE to LLCC_ECC as per the latest specification.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c       | 2 +-
 include/linux/soc/qcom/llcc-qcom.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index c31d9e39e864..3bd841e67eba 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -191,7 +191,7 @@ static const struct llcc_slice_config sc8280xp_data[] = {
 	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
 	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
-	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_ECC,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
 	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 93417ba1ead4..1a886666bbb6 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -30,7 +30,7 @@
 #define LLCC_NPU         23
 #define LLCC_WLHW        24
 #define LLCC_PIMEM       25
-#define LLCC_DRE         26
+#define LLCC_ECC         26
 #define LLCC_CVP         28
 #define LLCC_MODPE       29
 #define LLCC_APTCM       30
--
2.41.0

