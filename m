Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8857A13B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjIOCR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjIOCRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:17:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E094C26B8;
        Thu, 14 Sep 2023 19:17:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1vjdc031638;
        Fri, 15 Sep 2023 02:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G2owF4cMlBufM6OV83WRjyuY3R4ojPseOICAGg3Men0=;
 b=feaMa+7mxnoiyQDq6nlHaFjjB2cFi1pCD1mg0MexDEA3rnZwPOQIbHOXADZ02KmcJekX
 5P2GN/15gzEbJljTuCxJD1jnV4/yVmUW5Ge5H33JpCCShyVGHLOkdo1DaRoFRNso8CyQ
 bN5oWr33sj/HNbpqPgofbOo09IsftO2Jwck9IvHpQydUZ4rfaL5D65tZtOZJ6gDzlq+l
 Ck5mUgE99u52G+mRt2fNfiljYmcVD44+b9rwkmgZCv3gsLHa+AN1vXJV2nwEk+qqXZZL
 HqYoOk33QupH4OKxMRFf9PniWISwRiNbEMMJiGWJb1MJmpoJ7WMSav8y60jJn3AQYrMy IQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4e2b01j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:16:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F2GiD8023021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:16:44 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 19:16:35 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl for SM4450
Date:   Fri, 15 Sep 2023 10:15:09 +0800
Message-ID: <20230915021509.25773-10-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915021509.25773-1-quic_tengfan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SyGtYii0HEDsvF4fu6m0C4IbRSjNnO_h
X-Proofpoint-ORIG-GUID: SyGtYii0HEDsvF4fu6m0C4IbRSjNnO_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=633 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SM4450 interconnect and pinctrl drivers as built-in for
support the Qualcomm SM4450 platform to boot to uart shell.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ec59174b14db..e91993de865e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
 CONFIG_PINCTRL_SDM660=y
 CONFIG_PINCTRL_SDM670=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_PINCTRL_SM4450=y
 CONFIG_PINCTRL_SM6115=y
 CONFIG_PINCTRL_SM6125=y
 CONFIG_PINCTRL_SM6350=y
@@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
+CONFIG_INTERCONNECT_QCOM_SM4450=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
-- 
2.17.1

