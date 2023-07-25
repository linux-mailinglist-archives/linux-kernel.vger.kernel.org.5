Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F28760FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjGYJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjGYJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:57:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531E19B0;
        Tue, 25 Jul 2023 02:57:47 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P8K6bc000957;
        Tue, 25 Jul 2023 09:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=ScsO8gFEUdeQmbh7UjCwmM/ydj1dSKOBKKvQp49SZyY=;
 b=pXNqJG7GJccCjA5gL2i7TqdEujtfB/u3VVg5X4UM89IoqkidjgR+wl2OutEGoHMnLj/P
 CYVM30MyKgfEZtFakjPsHM2fvc9ppGr/FS1h2utOiazIL5TFNI07gaWagb2ghZvyATJV
 kiCMGIE4y6BMEYMCpfjI7+utdLyxCaX9D4cHYGJSQL0eR0YHTPSp9bqMte9IOqCtcsvi
 V1CPnJc4qcRhVCa3EXD84+UZ7B/9tp5E0uxr2zh39m/RfcK93bNIDp+niQXo9MydrdAb
 7yRyxXRXj1vJ8F9O7Pdc1OnslDeCWREU1uCkcaJ6Fe4JwwvZiL8XluJGJ+qPC2t65bIW bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1v6u9xt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P9vfeI014998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:41 GMT
Received: from fenglinw2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 02:57:40 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
Date:   Tue, 25 Jul 2023 17:57:21 +0800
Subject: [PATCH v2 3/3] leds: flash: leds-qcom-flash: put child node if
 registration failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-3-0f5cbce5fed0@quicinc.com>
References: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
In-Reply-To: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690279054; l=744;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=vYKLErViyJpx6PQYnTAwpfzAwvI97fsyFd3BM/iAYkw=;
 b=Y88jIIdAoUUJ0ZlWpBM+lZjvUCEeJMwkPGcYzedHMJDyyDpqocRrp5MIk85ouM0+nhCBrtTxy
 pgJhKCuZzFHBxUgSBspI0AWJkn14DS2ZJ7n9gIOmiKO1EBHMBiTG8/v
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p9PX_iIs_jAeh6ofeuITWzg3dVKc4kpZ
X-Proofpoint-GUID: p9PX_iIs_jAeh6ofeuITWzg3dVKc4kpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=698 lowpriorityscore=0 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Put the child node if register flash LED device failed.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/leds/flash/leds-qcom-flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 29cf09479422..a73d3ea5c97a 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -749,6 +749,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	return 0;
 
 release:
+	fwnode_handle_put(child);
 	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
 		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
 	return rc;

-- 
2.25.1

