Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E007AAC31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjIVINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjIVIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:12:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86AD1F1B;
        Fri, 22 Sep 2023 01:12:17 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M61PLc011177;
        Fri, 22 Sep 2023 08:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xBUDgiQc8/Wh7DXN0iZA8+ruE3hMW0PoKPidKMB6Hz4=;
 b=XTCikkBg+2JRgIzA5H6imqFwGs80uMwfZtcj3hO64VZTyv68e3Ol1/h2xk5SaE2OpN26
 mRY/T5yFu1g3TnO44ZDBeA1uEZUQ3xil7d3nGyNYRPpQg6U0YYlT9BdU+19FgyQcxYDS
 wNuWHSejEyEAW5ILKrfb6S+SvR7anQU9lJEs5IN2dYyVg5oKZrS4Jm2PxO3qn7TkpR6Z
 nN1WOSwuY6HWI0cTEllfMjNihax4IaxLa1rAf3+CtiekdHSx8T0xomBcZlL2Wm7lJzPg
 AYPIfpKUBPOnh8tgJ3zPeRz0So/pFOK9BycWppsrpSMzU1HlEfVaALzQhH2K2JKRvhvs uA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0s1c45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:11:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M8Bld1001245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:11:47 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 22 Sep 2023 01:11:35 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v4 6/6] arm64: defconfig: enable clock controller and pinctrl
Date:   Fri, 22 Sep 2023 16:10:26 +0800
Message-ID: <20230922081026.2799-7-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230922081026.2799-1-quic_tengfan@quicinc.com>
References: <20230922081026.2799-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EHu08eMSdCSnlItab7TQe9WHFztt4NMz
X-Proofpoint-ORIG-GUID: EHu08eMSdCSnlItab7TQe9WHFztt4NMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_06,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=666 spamscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable global clock controller and pinctrl for support the Qualcomm
SM4450 platform to boot to UART console.

The serial engine depends on some global clock controller and pinctrl, but
as the serial console driver is only available as built-in, so the global
clock controller and pinctrl also needs be built-in for the UART device to
probe and register the console.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5f77f5d1fe94..c645ad738c72 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
 CONFIG_PINCTRL_SDM660=y
 CONFIG_PINCTRL_SDM670=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_PINCTRL_SM4450=y
 CONFIG_PINCTRL_SM6115=y
 CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM6125=y
@@ -1244,6 +1245,7 @@ CONFIG_SM_DISPCC_6115=m
 CONFIG_SM_DISPCC_8250=y
 CONFIG_SM_DISPCC_8450=m
 CONFIG_SM_DISPCC_8550=m
+CONFIG_SM_GCC_4450=y
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y
-- 
2.17.1

