Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05775180D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjGMF2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMF2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:28:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3766172C;
        Wed, 12 Jul 2023 22:28:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4nFdU022118;
        Thu, 13 Jul 2023 05:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=7W5ZMLI5H62QewZy844Y3sbpJSkFJKvuwQNQcimB56o=;
 b=APc1R5Vyctx0aGLaLPOVki2aKCBi7cQZt6hvRVUJCKM/pLmf2GfKRjFArllrhu+iZa2o
 YoRkZOdJwwr9RD4j6vRxNsp/PxdTXdlnoTKnsRj1Salz9MHTEKVSc4yX9NF1opfkKylq
 bG7RmN0MhdoQ9MoqVyeibH/eEWhHVCW/HLcVElyY2zwrrRzsuRCQvWVcAtBM1CsEVT58
 YMQ5g8XZ4NyPOymg0sTWXa29pAPIC/jkB1EPuHS/akjGBekt5zIL/IiU1rPRDerc4vzS
 iECIO7ckrLNeYUXoOZQN7wu8UTJpQqHtCSJiQ5HDo+TgzprQVU68Q9C29+DflqdmldJ+ Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3f00qb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 05:27:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D5RvaL027388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 05:27:57 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 22:27:52 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v3 0/5] Add IPQ5332 TSENS support
Date:   Thu, 13 Jul 2023 10:57:27 +0530
Message-ID: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iPzxVr0PERWuPMuekty-BC-OZkMbzGbh
X-Proofpoint-ORIG-GUID: iPzxVr0PERWuPMuekty-BC-OZkMbzGbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=779 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.
This patch series adds the sensor enablement and calibration
support. On top, adds IPQ5332 TSENS support.

[v3]:
	Renamed init function in [v2 1/5] and reordered device nodes
	according to the address in [v2 3/5]
[v2]:
	Dropped [v1 1/6] dt-bindings change and added nvmem-cell-names
	as part of [v2 2/5] ipq5332 dt-bindings


Praveenkumar I (5):
  thermal/drivers/tsens: Add TSENS enable and calibration support for V2
  dt-bindings: thermal: tsens: Add ipq5332 compatible
  arm64: dts: qcom: ipq5332: Add tsens node
  arm64: dts: qcom: ipq5332: Add thermal zone nodes
  thermal/drivers/tsens: Add IPQ5332 support

 .../bindings/thermal/qcom-tsens.yaml          |  12 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 144 +++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 166 ++++++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 5 files changed, 330 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

