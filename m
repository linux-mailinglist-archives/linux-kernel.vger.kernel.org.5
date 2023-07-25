Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C900760FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGYJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjGYJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:57:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575A10C9;
        Tue, 25 Jul 2023 02:57:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P89Glg018558;
        Tue, 25 Jul 2023 09:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=osDTE7UgyNBgqubIqWD5OIaR3gR/6tXXerT27SCD9+c=;
 b=VuruztrKO0wDW/xOV2+Avsppl4OiyuOqfYpmC0yz9I1sWe4nlamuYjFaASPPPRjXRhvW
 T8SS5tvXfIG6bsZLT08nZFiwJRhvppftYbb9kPr69GpmrIoG/Gw1psafFerHzMOGT4MQ
 xdj3hHf5RcCVZ6GlfJOVRRf+gaMoFitZFVdT36kF/buG0AF0uGLT1sVsmNbXE3eGPjAt
 AVnuInn7UlBnriaFKd86QaL8mfbyQcq+oi82PY2MDmLQ1jbL/JSsZ1iyFPDBVwCovdVf
 MFc2wXmigan9ljxrXE/OJes+5wXvIVzx8t9vcq332hXWTz0LzpGDOBrBR0SrSEO3+8Ad 0g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29j5gbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P9vaVB014370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:36 GMT
Received: from fenglinw2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 02:57:34 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
Subject: [PATCH v2 0/3] leds-qcom-flash: several tiny fixes
Date:   Tue, 25 Jul 2023 17:57:18 +0800
Message-ID: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6cv2QC/x3M0QqCQBBG4VeRuW5g2bSyV4kuzPk3B2ytmRBDf
 HeXLj8OnJUcpnC6VisZZnWdckE8VNQPXX6CVYophngM59jwCHH+9NOL09j5wGI6w/ir+cdJFzi
 nU5KLtAGPtqbyeRv+oWxu923bAZbzke5zAAAA
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690279054; l=1148;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=oDNGAX82BXAAcDfb+T8vTQuRvKb2ev7IHMl1ZRARkF8=;
 b=GQWyaA+G6J23KdUocoMQnklJpeOvdW4D7sDnvwvfCSpy7uqkUyuQaGTaH+2wuGSWekBIXDg4z
 +n1fMhaGfbWAVP+0kPIn95K4NJCkzmPx75wJJt9Dtp3HggxzvvMI89b
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7kyidJ5uybDT0cKWYvGlA77EYJ_nqbhF
X-Proofpoint-GUID: 7kyidJ5uybDT0cKWYvGlA77EYJ_nqbhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=356 phishscore=0 clxscore=1015
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

Add small changes to address the review comments from Paval which were
posted after the driver was applied:
  https://lore.kernel.org/linux-arm-msm/20230325170957.GA2904@bug/#t
  https://lore.kernel.org/linux-arm-msm/ZB8wbv93+Vmx3trt@duo.ucw.cz/

1) Add a sentence in Kconfig to explain the driver can be compiled as a
  module
2) Strobe off the LED channel before setting flash current
3) Put the child node while register flash LED device failed.

Changes in v2:
  Sperate the fixes into 3 independent changes.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Fenglin Wu (3):
      leds: flash: leds-qcom-flash: declare the driver as a module
      leds: flash: leds-qcom-flash: turn off LED before setting flash current
      leds: flash: leds-qcom-flash: put child node if registration failed

 drivers/leds/flash/Kconfig           | 2 ++
 drivers/leds/flash/leds-qcom-flash.c | 5 +++++
 2 files changed, 7 insertions(+)
---
base-commit: 7a2b85a76b05f16e8e788d035afcacdd4faa1d71
change-id: 20230725-leds-qcom-flash-driver-tiny-fixes-f6fd8d90eb94

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>

