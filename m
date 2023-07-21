Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD75975C431
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGUKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGUKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:13:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CB10A;
        Fri, 21 Jul 2023 03:13:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L7cgk2022418;
        Fri, 21 Jul 2023 10:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CX8kp45L2DeL3x3Sj62BxM5jyllf8z4QmQnkk3xmJYE=;
 b=mFK8P9pZDFH5NGVkr2lWS72gRobWovJVV4k1WMIRg2negCRLZcbWS/dMANIYfjFm95ce
 ReehF24wODvOY8j0p17N2Rtb3/DoIV5mKE92rLgNnDDNA6xfF72Be1Xkxqt31US4c0lY
 Ws7Sx5LQuI/RIDMPuCgZ1cuE3AuWKNuQhbIGXrV0MMp/lSUVj1AMl5n8UiUZw+agTfi0
 N7VZ1Sox38WeLBamhIm4l/a6uw4lZRnhbDMNLk8TjvIkI03f9erj7Sg852zUvNUn5LeP
 A6tgc+lh4bA313hJ7lx2ECReaDGJrUTWUWNeNJzzUkk8GQr+p23ZC0OuwPdRrbMW0Yt6 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxxvbahw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:12:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36LACtwa025346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:12:55 GMT
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 03:12:51 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>
Subject: [PATCH] pinctrl: qcom: Remove the unused _groups variable build warning
Date:   Fri, 21 Jul 2023 15:42:41 +0530
Message-ID: <1689934361-32642-1-git-send-email-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dlolM2-h74gM_y1BSRZ-Tu4ZDz2F9l0S
X-Proofpoint-ORIG-GUID: dlolM2-h74gM_y1BSRZ-Tu4ZDz2F9l0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=779 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang toolchain and arm64-randconfig-r015-20230712
kernel test robot reports the below warning.

 drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: unused variable '_groups' [-Wunused-const-variable]
   static const char * const _groups[] = {
                             ^
   1 warning generated.

     static const char * const _groups[] = {
             "gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
             "gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
             "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
             "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
             "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
             "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
             "gpio43", "gpio44", "gpio45", "gpio46",
   };

Fixing it by removing the variable.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307120814.vWPY6URk-lkp@intel.com/
Fixes: 725d1c891658 ("pinctrl: qcom: Add IPQ5018 pinctrl driver")
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-ipq5018.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5018.c b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
index ed58f75..e2951f8 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq5018.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
@@ -241,16 +241,6 @@ static const char * const atest_char_groups[] = {
 	"gpio0", "gpio1", "gpio2", "gpio3", "gpio37",
 };
 
-static const char * const _groups[] = {
-	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
-	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
-	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
-	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
-	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
-	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
-	"gpio43", "gpio44", "gpio45", "gpio46",
-};
-
 static const char * const wci_txd_groups[] = {
 	"gpio0", "gpio1", "gpio2", "gpio3",
 	"gpio42", "gpio43", "gpio44", "gpio45",
-- 
2.7.4

