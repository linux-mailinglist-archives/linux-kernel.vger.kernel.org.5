Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E57526DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjGMP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjGMP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:26:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2A2D75;
        Thu, 13 Jul 2023 08:26:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDu3Ff013708;
        Thu, 13 Jul 2023 15:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lhnL0nYaUy4E209WvnIwLh692n8VbgyF9GkbTz9X0K0=;
 b=Fl1cJyIkCil8Z8IkAIR4uhFOYY8eIpG9lo1auXG8reO+ZmTOHDAynJLl3R88X7KXzojV
 kvCai5Jx2R1qNK57vX50IebTuGbq/XS8kM8cNkEBFqXvWRPBtBsyoVWFG93Vj7tpZLMu
 3Cb/+bn7IU/ko+WhYCd9hpEIvc4gegX0DH/sy4IKQYmnAVa9LHYmbV3k3zWHTaluRePC
 bpXOa00+5LGAujLH0cHNjD0T+78HU03N2EnDCFAWAZGTv3IsyoyE9qQzVHTcj+Qr5+U5
 gRXnrmriy87uWo9G2gbh8QWSxm+PlCAk9nGRj5hLkLn3KeLluFflTKU0hJOg8p+QJMLQ Ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt57mspcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DFQ8o8029160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:08 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 08:26:04 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH v2 0/2] Add initial support for RDP417 of IPQ9574 family 
Date:   Thu, 13 Jul 2023 20:55:20 +0530
Message-ID: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oUYhafzUmtf6svQQQmZ-scxpsxLBXqtA
X-Proofpoint-GUID: oUYhafzUmtf6svQQQmZ-scxpsxLBXqtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=609 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130135
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

