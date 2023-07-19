Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6EA759255
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGSKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGSKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:02:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1A1FCE;
        Wed, 19 Jul 2023 03:02:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J6Lwo1021938;
        Wed, 19 Jul 2023 10:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TlpYzcniGhpcmz/VqmcLbzPKTjyMDNq1IIloW/lsPRQ=;
 b=CCrsNK5KlKFKtns9jVBUAGo1kLFtZp2Uu/2+I8pOQGSfl7JGyYhn3Obj+7nakJ3Vc0ud
 wWvvZbO55LJh5vMWSYGhrPU1lkH3Bui+KDtE2/ITyjJ+CjVdUdbATWdnNdKaamtysouZ
 UQ1adLy5pIctJPGK0AdAA1GBRbwI5RGKgRcmsOntcp7We9O7pe38dO0pnclY1J/Tks+0
 QYVjHpoa3/PP0WGqF7lPHifKymvDAy7k08e8HnqHOIjmeVu9mfuIXIseJqx1JrxV09zG
 Y5kp1KRBv587TLLHhNdnMVFhV6E3+htSq/ZqM3wULZTZ3H8BszYU54zWjJQ6/A/WIldP JQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx7rngp80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:02:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JA243M030093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:02:04 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 03:02:00 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/5] soc: qcom: Add support for SM4450
Date:   Wed, 19 Jul 2023 18:01:30 +0800
Message-ID: <20230719100135.21325-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u1tKKOVLvkxZ4AtUSQ_pWyo3CIYm86Rz
X-Proofpoint-ORIG-GUID: u1tKKOVLvkxZ4AtUSQ_pWyo3CIYm86Rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 suspectscore=0 mlxlogscore=486
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CPU, SoC and board compatible support for SM4450.

Tengfei Fan (5):
  arm64: dts: qcom: Add base SM4450 DTSI
  arm64: dts: qcom: Add base SM4450 QRD DTS
  dt-bindings: firmware: scm: Add SM4450
  dt-bindings: arm: qcom: Document SM4450 SoC and boards
  soc: qcom: socinfo: add SM4450 ID

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 .../bindings/firmware/qcom,scm.yaml           |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm4450-qrd.dts       |  18 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi          | 435 ++++++++++++++++++
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   2 +
 7 files changed, 464 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm4450.dtsi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

