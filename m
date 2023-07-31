Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB38768F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGaIBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGaIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:01:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B01A7;
        Mon, 31 Jul 2023 01:01:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7SrQp028438;
        Mon, 31 Jul 2023 08:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=eCOpx4o7E5KpBIncjQqYQc7do9oGM45jgfsOnDjyE90=;
 b=NOOsj10Ea1CwD+mTYSQl2B3G7rFbjvaoiOGwAbYY6qD8nTgAPXidWs26sNInyuQ4ThJz
 YY7U1qH1ri5eRb+95oOV8vvv/UwMP/9cr1hGT6NYN1iX2/6bmKOhwkGGLvgS+5iFTXJv
 BYPjkTTH3LGrus8IsGGvoXUD5JNaftHhVyxz4m5OFbkds+4tvmkxRP5n0KE/FwsHeQjE
 R8QCZtMSO2C+D2aJYnFVtTkG4YeqWZFbh0lGo3P5DWMT3gdW+3cIUPrb6LuFnpMIMV/k
 Gh77eEYoxFCVuDjGsF7vNYd0oH1rm4koD6LB0iyHif2boBmTDUKYooR/inIPxOAJ8xPa Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uxsavyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:01:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V81EMR023707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 08:01:14 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 01:01:09 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v4 0/6] soc: qcom: Add support for SM4450
Date:   Mon, 31 Jul 2023 16:00:37 +0800
Message-ID: <20230731080043.38552-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P83LmSU7JZHH7tJ2b1ZU3ZYkqmfyPDAD
X-Proofpoint-GUID: P83LmSU7JZHH7tJ2b1ZU3ZYkqmfyPDAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_01,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=342
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CPU, SoC and board compatible support for SM4450.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
v3 -> v4:
  - drop adjust IPQ5019 related sequence patches

v2 -> v3:
  - remove some bootargs arguments from sm4450-qrd.dtsi
  - adjust IPQ5019 related sequence in bindings and socinfo file

v1 -> v2:
  - use hypens replace of underscores in node name
  - add empty lines before child nodes
  - drop SCM node
  - document qcom,sm4450-pdc compatible
  - drop clock-frequecny
  - align vertically
  - add reg after conmpatible, then ranges follow
  - update core compatible to standard ARM core name
  - add dcc related parameters in bootargs node
  - keep patch code have reasonable sort
  - drop unnecessary copyright
  - separate bindings to a single patch

previous discussion here:
[1] v3: https://lore.kernel.org/linux-arm-msm/20230731061325.26431-1-quic_tengfan@quicinc.com/ 
[2] v2: https://lore.kernel.org/linux-arm-msm/20230727023508.18002-1-quic_tengfan@quicinc.com/
[3] v1: https://lore.kernel.org/linux-arm-msm/20230719100135.21325-1-quic_tengfan@quicinc.com/

Tengfei Fan (6):
  dt-bindings: qcom,pdc: add qcom,sm4450-pdc compatible
  dt-bindings: arm: qcom: Document SM4450 SoC and boards
  arm64: dts: qcom: Adds base SM4450 DTSI
  arm64: dts: qcom: Add base SM4450 QRD DTS
  dt-bindings: arm: qcom,ids: add SoC ID for SM4450
  soc: qcom: socinfo: add SM4450 ID

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  18 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 431 ++++++++++++++++++
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 7 files changed, 459 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm4450.dtsi


base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
-- 
2.17.1

