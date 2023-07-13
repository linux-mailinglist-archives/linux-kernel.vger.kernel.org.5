Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1D751F60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGMK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGMK73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:59:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD21999;
        Thu, 13 Jul 2023 03:59:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D9e7hD013560;
        Thu, 13 Jul 2023 10:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0nGbzRJWkCYq6I33cFzKEOWeimag20CQ2GvUJRvf4Vg=;
 b=PvHtosqlBBdYhs5ODfpFxjWcMKXuuH42bZkGKdWgjazZJXHg1fhWw57zNMteHvqebhAl
 va/Ui6w8u+K/TIcPdHeZkWcExsRhtaVr0cEk411085BvRDMwjY0SX/po9U9iXJ+Ynr9b
 YIsjq8Vyi6IV0jXihnDuFdLrQwJiQG1SanUgh+UOedvyDYx9GomLMNw0gzTfDRhdQhb0
 6spdJPrEvQ2PbUVhu2LUmdeMHPGI02FxKlqALJY5ldxtoc4nfBzrosCDGs35xGDd/0oH
 Nxnz9U0AcxbfjhTQ8ErWi3k4NxVHfmbpQ4558vrZappKepdcqYSl7jp1Ehy+nEWuNIJD XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfh94d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:59:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DAxNsA021100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:59:23 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 03:59:20 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V2 0/2] Add common RDP dtsi file for ipq9574
Date:   Thu, 13 Jul 2023 16:29:07 +0530
Message-ID: <20230713105909.14209-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AW7QSpeGw9KlEn6iLDj0zewHNuAhYu5H
X-Proofpoint-GUID: AW7QSpeGw9KlEn6iLDj0zewHNuAhYu5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=389
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interfaces are common across RDPs.
Move the common nodes to ipq9574-rdp-common.dtsi.
Use rdp specific dts file to include interfaces that vary across RDPs.
Example, ipq9574 has 4 PCIE controllers.
RDP417 enables PCIE0 and PCIE1, RDP418 enables PCIE2 and PCIE3.
While at it, add support for WPS buttons.

Changes in V2:
	Detailed change logs are added to the respective patches.

V1 can be found at
https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com/

This series depends on below patchset for CHECK_DTBS issue
https://lore.kernel.org/linux-arm-msm/7ceba3df-bee8-9f1d-a27d-85e0b5f35d83@linaro.org/

Anusha Rao (2):
  arm64: dts: qcom: ipq9574: Add common RDP dtsi file
  arm64: dts: qcom: ipq9574: Enable WPS buttons

 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 147 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   |  67 +-------
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  95 +----------
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   |  65 +-------
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   |  65 +-------
 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts   |  66 +-------
 6 files changed, 156 insertions(+), 349 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi


base-commit: 40b055fe7f276cf2c1da47316c52f2ff9255a68a
-- 
2.17.1

