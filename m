Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DE798300
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjIHHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjIHHB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:01:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42D2117;
        Fri,  8 Sep 2023 00:00:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885LXFM014143;
        Fri, 8 Sep 2023 06:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=97vZYVrEOgqh5ew4jdku7r9laGmUtDSWasLgoSlvodc=;
 b=P3tOfw30PuO3WLYUpOPYfd2T6sj0VM1c6o4CFwQL0qeFcjT/UFde0cniShUzspjwdu1M
 gxeM74wtbt4V70LNQlXLT2Zo8GVj9SFX9/iSsWHi30I34doNScmVIwL3KutW27n+A7dG
 oFhvfeFkzk4Tr8u3UbEmKOnyz02Gr7GHcBnU7T8FgxRJUQkI5iAMkypRPIH9V9Crkx6a
 kZ3/VtBbepaeXt0Sv++/VjDpY5ydOVQyMW6l0oQlUOlXQGTTzDmMNdnUJbLmh4jLqCct
 wRrifNBpyFXrOSOVshJUgJcKVxis1npaTcyQInLnqWq/GbR4RuSQANMFd9GVBwz/yl9r oQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy951jv3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:59:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886xlhG017900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:59:47 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:59:38 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock controller
Date:   Fri, 8 Sep 2023 14:58:46 +0800
Message-ID: <20230908065847.28382-6-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908065847.28382-1-quic_tengfan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RYwOAcUcYWNtwKFmaorP6NRphFWaOc_5
X-Proofpoint-ORIG-GUID: RYwOAcUcYWNtwKFmaorP6NRphFWaOc_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=964 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <quic_ajipan@quicinc.com>

Add device node for RPMH and Global clock controller on Qualcomm
SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index eb544d875806..2395b1d655a2 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm4450-gcc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -367,6 +369,22 @@
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sm4450-rpmh-clk";
+				#clock-cells = <1>;
+				clock-names = "xo";
+				clocks = <&xo_board>;
+			};
+		};
+
+		gcc: clock-controller@100000 {
+			compatible = "qcom,sm4450-gcc";
+			reg = <0x0 0x00100000 0x0 0x1f4200>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
 		};
 
 		tcsr_mutex: hwlock@1f40000 {
-- 
2.17.1

