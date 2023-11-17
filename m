Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D307EF305
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjKQMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbjKQMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:51:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C31D6E;
        Fri, 17 Nov 2023 04:51:53 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCPtOq005682;
        Fri, 17 Nov 2023 12:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4X40THbSuoHgcgmxsolw6hmOHFdnyhOqdQm4KEkSOBA=;
 b=hZ5eMel93PI00bF2CCB02ZBkVR3LO/hfZ0OsfH6LM3ky7vdshebmhpmmcHYykCURFdVv
 rK5LsBTe6mkaM8r3WhPtEGxQWowQ2H31Mrf9rHG5+vbBeMLTmq6r//qX9NHr+vkNNTY5
 16NzS4iPE64JLFzjVK4F8k6e804IbDk6HhG2REqKvkw4jXMmTAXrL1JXl8oBJ18jtvpd
 LGAPVYpVz+M4Pkzqwp1CdorHeKcAF2i6R62MftkzAWghSP+zxR7ue6UfrVSJgEq3+ZKl
 uw3a05oeRGRxsOXIYdsj3KnWBmsxwlarZUDhY4aCUlO050/TYz48IMVi7gDWKtG5DNZa qw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue5exrcs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:51:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHCpGgj007309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 12:51:16 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 04:51:11 -0800
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v4 0/3] Add support for qcm6490 idp and qcs6490 rb3gen2 board
Date:   Fri, 17 Nov 2023 18:20:53 +0530
Message-ID: <20231117125056.32503-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u-uffMJ5F_kauWWv0mxb4I_LqmYAkilz
X-Proofpoint-ORIG-GUID: u-uffMJ5F_kauWWv0mxb4I_LqmYAkilz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_11,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the dt-binding and base devicetree files for
QCM6490 IDP based off QCM6490 SoC derived from SC7280 meant for
various form factor including IoT and QCS6490 RB3Gen2 based
off QCS6490 SoC derivative of QCM6490 without internal modem.
See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qcs-qcm6490-soc-product-brief_87-28733-1-b.pdf

----

Changes from v3:
* Removed qcm6490.dtsi file and moved all the contents to board file instead
* Introducing QCS6490-RB3Gen2 board
* Link to v3: https://lore.kernel.org/linux-arm-msm/20231003175456.14774-1-quic_kbajaj@quicinc.com/

Changes from v2:
* Sorted nodes alphabetically
* Link to v2: https://lore.kernel.org/all/20231003055655.30994-1-quic_kbajaj@quicinc.com/

Changes from v1:
* Dropped suffix platform from model name
* Removed few nodes as they were identical to ones in sc7280
* Specified regulator-initial-mode property to vregs
* Dropped deletion of lpass and swr nodes
* Link to v1: https://lore.kernel.org/lkml/20230928133312.11371-1-quic_kbajaj@quicinc.com/

Komal Bajaj (3):
  dt-bindings: arm: qcom: Add QCM6490 IDP and QCS6490 RB3Gen2 board
  arm64: dts: qcom: qcm6490: Add qcm6490 idp board
  arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      | 329 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 324 +++++++++++++++++
 4 files changed, 657 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts

--
2.42.0

