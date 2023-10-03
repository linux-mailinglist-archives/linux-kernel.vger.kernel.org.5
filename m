Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50D7B6094
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjJCF5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjJCF5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:57:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49645B7;
        Mon,  2 Oct 2023 22:57:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3935vOrx010103;
        Tue, 3 Oct 2023 05:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=65lNO2xipthuSI9gqYy2bjtb3vn9FOveyb5eLRthTpU=;
 b=PvyMAi3m+B7ChrbxXXbD/Qp+ahHHzKUrqztKCyQKPMFxMSsqBNJSKdwovnv8LkVHmAGQ
 rcmSR3yowSJ0J8StXIpL6V7QoTjdP2jqprqxxWCtknCT/yICWpU49UsgGiNzt7gP0HUR
 2dFQ/uSn/WJENOIXHGGUzLytoDXGIv5YmNa1Nnaq4mxjOtxPz8zb3I0RpQGF0AT17MTO
 W5LT8TzWZKH2pvXse05rN8lK5L7QWA8x+u6E9KUJGWTAI89ViSvnko8kfYbwAqcjjMrD
 5ljQv4DJtDRZqRfWKMuu1ruwcq1ELspY2FwAHaLtStJ77edxPLuIfinE3qOUOrfMCq1F Lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgaw5g7t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 05:57:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3935vNgZ002596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 05:57:23 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 2 Oct 2023 22:57:19 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luca.weiss@fairphone.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v2 0/2] Initial support for the QCM6490 IDP
Date:   Tue, 3 Oct 2023 11:26:53 +0530
Message-ID: <20231003055655.30994-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J_AKpSvRlNOyAj0cHyCv2Pz4dyUu9COt
X-Proofpoint-GUID: J_AKpSvRlNOyAj0cHyCv2Pz4dyUu9COt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=751 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding and devicetree files for QCM6490 IDP.

This patch depends-on:
https://lore.kernel.org/lkml/20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com/

----
Changes from v1:
* Dropped suffix platform from model name
* Removed few nodes as they were identical to ones in sc7280
* Specified regulator-initial-mode property to vregs
* Dropped deletion of lpass and swr nodes
* Link to v1: https://lore.kernel.org/lkml/20230928133312.11371-1-quic_kbajaj@quicinc.com/

---
Komal Bajaj (2):
  dt-bindings: arm: qcom: Add QCM6490 IDP board
  arm64: dts: qcom: qcm6490: Add qcm6490 dts file

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      | 335 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490.dtsi         |  94 +++++
 4 files changed, 431 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490.dtsi

--
2.42.0

