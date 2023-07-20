Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6D75A7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGTHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjGTHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:30:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A332690;
        Thu, 20 Jul 2023 00:30:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K4s4IK013732;
        Thu, 20 Jul 2023 07:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=KEaE+4/eOq7glk/KsqipPr77qc4pl5hUgEF1k2vKie4=;
 b=ZxdxKer+mkoo0Tht08K561+QmYACYMzugQNk1lI+2JDaVcdb2ZmG8tJ61ssQyROHHMfO
 Y9Ai7xAyS4doaMJcs57KtanYaZMm1CIFf6Zr7Hg1Mugm5QFkDY8UPJ4dD3b7Qrr0bEGl
 0YeF5jjpe60j+skgUHVozlbyHTALluQmB1rSYnbY/iet3HHnyrnh9NYGccdQUdxKF6Vr
 SxTzt+OEYvldDgG/5j70iyywB9IYJmfX8N8bWGcQ9tQCn+6nz+EocEvDzUSfpijG2Yf8
 NisCjcQv5Dpqyul7fhAIzcMjc9wVh1I5Aoujm96OOdA0cVABEOmrWYiQ93+EeqRSt2P7 RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx728u408-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:30:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K7Txjf002822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:30:00 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:29:55 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 0/2] Add common RDP dtsi file for ipq5018
Date:   Thu, 20 Jul 2023 12:59:36 +0530
Message-ID: <20230720072938.31546-1-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uNrE66v2I9xcFd2uWXqVx3HqnZj-BMtm
X-Proofpoint-ORIG-GUID: uNrE66v2I9xcFd2uWXqVx3HqnZj-BMtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=420 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interfaces are common across RDPs. Move the common
nodes to ipq5018-rdp-common.dtsi.
Also update the compatible in device tree binding
to use model names instead of rdp numbers.

This series is based on the below series,
https://lore.kernel.org/lkml/20230616101749.2083
974-1-quic_srichara@quicinc.com/

Hariharan K (2):
  dt-bindings: arm: qcom: Update the compatible
  arm64: dts: qcom: ipq5018: Add common RDP dtsi file

 .../devicetree/bindings/arm/qcom.yaml         |  4 +--
 .../boot/dts/qcom/ipq5018-rdp-common.dtsi     | 35 +++++++++++++++++++
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 30 +++-------------
 3 files changed, 41 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp-common.dtsi

-- 
2.17.1

