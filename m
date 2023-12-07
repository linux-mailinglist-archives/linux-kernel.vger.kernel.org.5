Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8808085F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378524AbjLGJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378690AbjLGJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:28:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9419A;
        Thu,  7 Dec 2023 01:28:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B78qPvX031155;
        Thu, 7 Dec 2023 09:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZCOMM8b42YZBXv0ElZNc+ODIadhSemWSE8b5ZWZXUQA=;
 b=QGHByUaj2UXI1UStdR7mN6iDnRjov0bAhZaziquyn0Al/sDGjw6e02Ycd2htMJPYh9Xm
 HrI/oLdvRHf5ByraReDrX+m5ORaxCqKyTtLFZO6BeGXj0gL6XH3/ry9hW9F4y8dxcm1Z
 IzUgmG3kKNkP9LvqEHZ5x2RiOsiki0O9O63NjWbbFSJBhadvbDnZioaxd0vJveQthXAv
 6w5qwQNDqCzCedHJcKny3aBhXVWk8MvwCeh822mB85vtgvzlBjd/8tAW6LHYSzEvJhaC
 ZQplCXiW1t0HGuIXr1Dvp/09YHLWx+Wxubq05Vu0dFsUI+UGrpDTGjg+MfUu2V0RrC0R TA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2p8912q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:28:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B79STsM019506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 09:28:29 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:28:24 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/7] arm64: qcom: add AIM300 AIoT board support
Date:   Thu, 7 Dec 2023 17:27:54 +0800
Message-ID: <20231207092801.7506-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4gPnMOnXxSEOMG2_iFh2jKZ9MC0sJXSt
X-Proofpoint-ORIG-GUID: 4gPnMOnXxSEOMG2_iFh2jKZ9MC0sJXSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_07,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=785 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
sound card and PMIC functions.
AIM300 Series is a highly optimized family of modules designed
to support AIoT applications. The module is mounted onto Qualcomm AIoT
carrier board to support verification, evaluation and development.
AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
This patch series depends on below patch series:
"[PATCH] arm64: dts: qcom: sm8550: fix soundwire controllers node name"
https://lore.kernel.org/linux-arm-msm/20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org/

v1 -> v2:
  - add qcs8550 soc id
  - introduce qcs8550-aim300.dtsi
  - move ufs, regulators and PMIC functions to qcs8550-aim300.dtsi
  - merge the splited dts patches into one patch
  - update dts file name from qcom8550-aim300.dts to
    qcs8550-aim300-aiot.dts
  - update display node name for drop sde characters
  - add pcie1 support
  - add more regulators support
  - drop pcie0, bluetooth, adsp, cdsp and mpss support

previous discussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20231031075004.3850-1-quic_tengfan@quicinc.com/

Tengfei Fan (7):
  dt-bindings: arm: qcom: Document qcs8550 SoC and board
  arm64: dts: qcom: sm8550: remove address/size-cells from pwm
  arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
  dt-bindings: arm: qcom,ids: add SoC ID for QCS8550
  soc: qcom: socinfo: add SoC Info support for the QCS8550 platform
  arm64: dts: qcom: add base AIM300 dtsi
  arm64: dts: qcom: aim300: add AIM300 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm8550.dtsi          |   2 -
 .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 579 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 370 +++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   3 -
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 8 files changed, 959 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi


base-commit: 8e00ce02066e8f6f1ad5eab49a2ede7bf7a5ef64
-- 
2.17.1

