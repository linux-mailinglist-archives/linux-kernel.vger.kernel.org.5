Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2177239F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjHGMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjHGMSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:18:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B54106;
        Mon,  7 Aug 2023 05:18:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3779SuPN016378;
        Mon, 7 Aug 2023 12:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gItqIJAhTAd77ZUSt2tHmbzWAUrLfL72TDdLDPaW35I=;
 b=d5Lx/y2UDSI+aZyoFZwgqnyQaJTzhGY4wKSkF1A5zh+5ijKE9jYeJuURMmOzhgNOK8o/
 knQNBL0LxiSejQHkshHZBl2mJ/4bymt5gdf6q0mCPHzDwCVfDNhq0Xas9sPu29avmwYU
 LXzp9kkt89HgRPRfw0hFWUoZndOpc69ULVo3KQXmbkgHeiA0c1Lq6qZXTTVUAGUNIJ5W
 BIrQ3adbmla4kjbTeadAwp4pFNos+JG1QtqGV4lAQDAKhfPlXaJ7XCuxfXowvSXouaqj
 +nO6vpcd8F8YtqDNgTUouCO9YKZY9uIgdua+qsPAYzogUZGdAfcpTi9Z8tol6aEakUwM YA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbg8gy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 12:18:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 377CISNT028010;
        Mon, 7 Aug 2023 12:18:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s9fgk7kkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 07 Aug 2023 12:18:28 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377CISjE027996;
        Mon, 7 Aug 2023 12:18:28 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 377CIS31027992;
        Mon, 07 Aug 2023 12:18:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 751BF1BA1; Mon,  7 Aug 2023 17:48:27 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_pkondeti@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 6/9] ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
Date:   Mon,  7 Aug 2023 17:48:15 +0530
Message-Id: <1691410698-25180-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691410698-25180-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1691410698-25180-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Le2aEdNkPDKhq4-asdAeWRGwexftGSyC
X-Proofpoint-GUID: Le2aEdNkPDKhq4-asdAeWRGwexftGSyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=675
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070112
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pmic used in sdx65 platform to pm7250b.

Fixes: 26380f298b2b (ARM: dts: qcom: sdx65-mtp: Add pmk8350b and pm8150b pmic)
Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
index 02d8d6e..fcf1c51 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
@@ -7,7 +7,7 @@
 #include "qcom-sdx65.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>
-#include <arm64/qcom/pm8150b.dtsi>
+#include <arm64/qcom/pm7250b.dtsi>
 #include "qcom-pmx65.dtsi"
 
 / {
-- 
2.7.4

