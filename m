Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0175AA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGTI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGTIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:47:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E6FD;
        Thu, 20 Jul 2023 01:47:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7sBii003042;
        Thu, 20 Jul 2023 08:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EZZdbL7psQNqi1v0+ScsZG0RZwuweG3/uXhRNUg96jQ=;
 b=gOhiPt+HwI0RpspX83Qc90HKTh3erzwbjF+2l7lHUXhF/Kmq9GytzSF7qgg856JOjZwc
 g0Z2Xq6pWzUnf9vjRaAmW1E/wgTZym8tBLTN+ZiCCem64H+diDygIgQdO05YOLl9U5Ij
 ySBBVLLC12YKs4DxSxV8QPwMI37L4HPyPVws3Ii+WX9H5MKDlYpxcfRsjPlf55AIP8tA
 yYWU2/6M5fxkOixu8JcNvIpe4dVLsKJh1xq1jmaUHwkIeJLBolhWfWjlxqyZtdDPsBgP
 CggYo3XUJULVpVeUFHCn7kTTBvGcj1enG3+DHoYtWzxwd3U49Ome7LRbOoRfQXE1/h2I rA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4gp8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K8l0Ae009040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:47:00 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 01:46:56 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 0/2] Add initial support for various RDPs of IPQ9574 family 
Date:   Thu, 20 Jul 2023 14:15:32 +0530
Message-ID: <20230720084534.6461-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DWRUmzHnQW_35f_FVb33Dyw9_xidFunY
X-Proofpoint-ORIG-GUID: DWRUmzHnQW_35f_FVb33Dyw9_xidFunY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=728 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDPs) 433-mht-phy,433-mht-switch,437,455,456,457,458,459
461,467,469 based on IPQ9574 family of SoC.

This series depends on below patchset:
https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/

Sridharan S N (2):
  dt-bindings: arm: qcom: document AL02-Cx and AL03-C2 boards based on
    IPQ9574 family
  arm64: dts: qcom: ipq9574: add support for various RDPs

 .../devicetree/bindings/arm/qcom.yaml         | 20 ++++++
 arch/arm64/boot/dts/qcom/Makefile             | 11 ++++
 .../boot/dts/qcom/ipq9574-rdp433-mht-phy.dts  | 62 +++++++++++++++++++
 .../dts/qcom/ipq9574-rdp433-mht-switch.dts    | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts   | 62 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts   | 15 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts   | 16 +++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts   | 16 +++++
 13 files changed, 298 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-phy.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433-mht-switch.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp437.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp455.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp456.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp457.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp458.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp459.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp461.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp467.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp469.dts

-- 
2.17.1

