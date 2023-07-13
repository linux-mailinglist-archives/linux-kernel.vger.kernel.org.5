Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE5752087
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGML42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjGML4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:56:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D5B4;
        Thu, 13 Jul 2023 04:56:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DAi9Br027274;
        Thu, 13 Jul 2023 11:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lhnL0nYaUy4E209WvnIwLh692n8VbgyF9GkbTz9X0K0=;
 b=PtDSjApkNkVY0oK4/DMuZEvSfQfOIx+fjQB8uuLODOvMbxAlJN/pkIsWEXlAy3dewZWl
 +E9UgTl0qOVivJRz6jmZPZ0i41uwaUk5X1CIUgrLJVbn2Q9C+fLKqMdI6p2SMeybC3sZ
 z5yG2a2lQTRpLN/ERFsO5vKTuGiTSVM9LKJm0Yz3+VGvTTYZtLi9jmMETZns5YjaJI15
 S4/DOIxmFi75w/2oxGFz7I6UOH7SkgjnokwuPrO+riZrEpL1yvTv6TmSPdYGYiI1/5mT
 2+B9dCVaOxnZStJGzDLuLGIC7yYJnPyOJFJstqp0key72LY8mOV5okUJvPcaTIZI3Bya rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtayj0nma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:56:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DBuBbM027616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:56:11 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 04:56:08 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP417 of IPQ9574 family 
Date:   Thu, 13 Jul 2023 17:25:42 +0530
Message-ID: <20230713115544.953998-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 12YZ4-gLVSHkNKsoayFVr6t42-BiWtqf
X-Proofpoint-ORIG-GUID: 12YZ4-gLVSHkNKsoayFVr6t42-BiWtqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 mlxlogscore=609 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 454 based on IPQ9574 family of SoCs.

This series depends on below patchset:
https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/

This series depends on below patchset for CHECK_DTBS issue
https://lore.kernel.org/linux-arm-msm/20230526161129.1454-4-quic_anusha@quicinc.com/
Sridharan S N (2):
  dt-bindings: arm: qcom: document AL01-C1 board based on IPQ9574 family
  arm64: dts: qcom: ipq9574: add support for the RDP417 variant

 Documentation/devicetree/bindings/arm/qcom.yaml |  2 ++
 arch/arm64/boot/dts/qcom/Makefile               |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts     | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts

-- 
2.34.1

