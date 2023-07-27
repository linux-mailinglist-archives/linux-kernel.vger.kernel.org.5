Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7DE7643CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjG0Cfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Cft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:35:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A6FD;
        Wed, 26 Jul 2023 19:35:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R2IdXo000426;
        Thu, 27 Jul 2023 02:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=i87gFLh6jtUVzjKzxFQQ5hSqW40grobjzv4Yuowx2YQ=;
 b=Dv4Cvs7ExKzZW2DBzJvlyjJhITjl5b153qoGuHtdyxXAzzOS53xIl4tHGmOplc2OIy7e
 TBa9vJpz03qooAo3M3C33TAudx8NS47gN2zY2fyP2uyrqcDH3pDm1FlsLTVBiBHglkbo
 ELm/7zaEg+Q7mZ6vErEm6QRrULH/QmhEKi1NYbkaMZgcNG5BvilTeu958s2omskbiz7i
 Vy0DkOHRyWJljjI6iEkg4QDYOLPJvBCChRWlzmhR6qMmFDDeFF2bx+IHcHbabqh8j3pb
 Do0ZRF+IwpRZzgbA35J3PIpXPFUDEmG0wlI92GlK7iK9byajBXsBRP50y8ligOpQGA73 mA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3f5802dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 02:35:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R2ZfZU030443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 02:35:41 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:35:37 -0700
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
Subject: [PATCH v2 0/6] soc: qcom: Add support for SM4450
Date:   Thu, 27 Jul 2023 10:35:02 +0800
Message-ID: <20230727023508.18002-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1nIG9fKtwlHfValSWBndbOqI0POFZtfR
X-Proofpoint-ORIG-GUID: 1nIG9fKtwlHfValSWBndbOqI0POFZtfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=307 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270022
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
[1] https://lore.kernel.org/linux-arm-msm/20230719100135.21325-1-quic_tengfan@quicinc.com/

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


base-commit: ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf
-- 
2.17.1

