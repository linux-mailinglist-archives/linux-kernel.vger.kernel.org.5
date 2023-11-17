Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED177EEFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjKQKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjKQKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:19:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE8D5;
        Fri, 17 Nov 2023 02:19:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH6nfW2019833;
        Fri, 17 Nov 2023 10:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ScKa8OkaWQHBAz5xwEBOy3PWOQEBULpQuQYVukF9KYI=;
 b=os/7SviBO2j3cI5Wxd5NQUSNJ7PsmS+cUxkngbHoQ7xwhHXTkvjThnmY6fdPdbT+u6Ic
 0ajaZT0nukY3kBYXXMD13talO9agpGjCixR50uxrZDdIOOg7e5hRevIWJ3t3OK6BUvGp
 DNWECtzvCgAfjFgFvZ6XPFBcs1EcledlciAc68/KtQS5aJwhOC7w9RgMxGiEuLF150hp
 gXvKEb2l405MOjYczLBZY3B6/S6nfPakY7q84no/je2W4VfgpXZ7VA82RlfdZptkKY08
 oXftu/9/8V6GyBlmVO4gzT4NdqlMu8GRSBHhKWt9cbWvEXJ/2TcxbGPeD3M+F0TZdO58 hA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udpqq21ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:18:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAIjPX011953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:18:45 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 02:18:41 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 00/16] arm64: qcom: add sm8550-aim300 board support
Date:   Fri, 17 Nov 2023 18:18:01 +0800
Message-ID: <20231117101817.4401-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kCMfd2s4jGYYNTbqjW8DWlm2fkIkWYMT
X-Proofpoint-ORIG-GUID: kCMfd2s4jGYYNTbqjW8DWlm2fkIkWYMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=442 impostorscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8550-aim300 board support, and enable serial, UFS, USB, PCIe,
audio, LEDs, PMIC Volume, Power buttons, sound card and bluetooth
functions support on this board.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

Tengfei Fan (16):
  dt-bindings: arm: qcom: add SM8550 AIM300
  dt-bindings: interrupt-controller: qcom,pdc: document qcom,sm8550-pdc
  arm64: dts: qcom: sm8550: update Soundwire node name
  arm64: dts: qcom: sm8550: remove address/size-cells from pwm
  arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
  arm64: dts: qcom: sm8550-aim300: add SM8550 AIM300
  arm64: dts: qcom: sm8550-aim300: add PCIe0
  arm64: dts: qcom: sm8550-aim300: add WCD9385 audio-codec
  arm64: dts: qcom: sm8550-aim300: add flash LEDs
  arm64: dts: qcom: sm8550-aim300: add display and panel
  arm64: dts: qcom: sm8550-aim300: add notification RGB LED
  arm64: dts: qcom: sm8550-aim300: enable PMIC Volume and Power buttons
  arm64: dts: qcom: sm8550-aim300: add WSA8845 speakers
  arm64: dts: qcom: sm8550-aim300: add sound card
  arm64: dts: qcom: sm8550-aim300: add pmic glink port/endpoints
  arm64: dts: qcom: sm8550-aim300: add bluetooth support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm8550.dtsi          |   2 -
 arch/arm64/boot/dts/qcom/sm8550-aim300.dts    | 995 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  11 +-
 6 files changed, 1002 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-aim300.dts


base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
-- 
2.17.1

