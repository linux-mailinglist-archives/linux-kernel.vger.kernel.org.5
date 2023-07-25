Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6F760FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjGYJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGYJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:57:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D5410D8;
        Tue, 25 Jul 2023 02:57:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P88VrY015729;
        Tue, 25 Jul 2023 09:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=fWUkQlxsXRS7iV+aexyELVn7s+veqyHJs+3ritNx2GY=;
 b=mKq3ZUbVtm2X36bQAi8WtmemL7sXY4ncMRxkqqXyFiY9Nj0yh0SzOPRF7344JNrFk0aP
 CfhIQt2Xnt45PuQtzQBxf3ov1yMDAuDBAFX/T0mPfvL4r1BCKLC53oIqFLWHq4Rb4jTl
 BpxsTjkO0JdRLYmvkZSmMQuvZMr/iv817Thn0jLeUwTpiMOI//pwvQK+MFTfSCKUCC7y
 XEb2YRylVVJ2D5e+xPTs356+qh5fZUZ9xyOtMLbakIis69FyXA5Jwg8n2d+CCwIy+z8z
 0birO5DajiwV0/11FJYxOW7jm2rYs2xheQK0PuecYwV+ARGb8LOkmFP/uz/gZpQiuxTU JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29j5gbuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P9vcs0014384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:38 GMT
Received: from fenglinw2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 02:57:36 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
Date:   Tue, 25 Jul 2023 17:57:19 +0800
Subject: [PATCH v2 1/3] leds: flash: leds-qcom-flash: declare the driver as
 a module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-1-0f5cbce5fed0@quicinc.com>
References: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
In-Reply-To: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690279054; l=753;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=AzMDDoRZO0HzUZhV0OYLAbxShCC7XGts2sqsVW9hIHg=;
 b=AyIMOQCkg4b0M1085n2J4GBf+lXi4UxWtVrdM9nhchqnBhqM4hrHWwz+e2FQd1iVaCU5gE+Mv
 ktu+PhsTYKNCfjKEg0XXXNP3sI3BqQV+8HbU/r5P1wp0COtm9UQsroI
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FwnjDFXtjOsS2Ysk_TRItwi95LCCjr0u
X-Proofpoint-GUID: FwnjDFXtjOsS2Ysk_TRItwi95LCCjr0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=544 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain in Kconfig that the driver can be compiled as a module.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/leds/flash/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 4ed2efc65434..4e08dbc05709 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -89,6 +89,8 @@ config LEDS_QCOM_FLASH
 	  the total LED current will be split symmetrically on each channel and
 	  they will be enabled/disabled at the same time.
 
+	  This driver can be built as a module, it will be called "leds-qcom-flash".
+
 config LEDS_RT4505
 	tristate "LED support for RT4505 flashlight controller"
 	depends on I2C && OF

-- 
2.25.1

