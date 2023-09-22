Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E347AACF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjIVInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjIVInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:43:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5826D99;
        Fri, 22 Sep 2023 01:43:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M3qLeJ030587;
        Fri, 22 Sep 2023 08:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=LoC6PTKmgMdLULhc3/Q520gaCqFqCt7TKdwZ++zzZgA=;
 b=btHO8ZgtJVtwfpb6fF8qcUN1EbzRK9CoqaT9zIhnn/QqpemTZFwfd9aYx9SLJhlNzzTa
 drsIy4ekcs1Dr4wgRXtWQYvGuxt7+6ewKpBJqzDx1djualZ0uo6b/kKwqNKEGLz6D2Vi
 Rf8Q/W4CpPgAJwu0AJieslf5XQQpZopNjMYDaW2OtoezmpqPomgaF14dScyrARw87JW0
 hltuTQAedwm5rN+FUunJ1cqyfAQqGqAEqXOMzc8Xp4+X3CLYYBazrkWZhqdstNHUXImZ
 52g8Dh3sXsW+1sbRhHdbUYOxeR351unUu8FJLL9Ji+Eo1lOkSmKdpjVMsoYCRU/R2EyO 2Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txg9dkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:43:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M8hNnA007601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:43:23 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 22 Sep 2023 01:43:18 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH v2 0/3] Add APSS clock driver support for IPQ5018
Date:   Fri, 22 Sep 2023 14:13:00 +0530
Message-ID: <20230922084303.4164046-1-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pdN9XAlvq1GDkQaOYeaeNhdRGeEraifJ
X-Proofpoint-GUID: pdN9XAlvq1GDkQaOYeaeNhdRGeEraifJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_06,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=647 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the APSS clock to bump the CPU frequency
above 800MHz. APSS PLL found in the IPQ5018 is of type Stromer. 

- The first patch in the series adds the required a53pll compatible.

- The second patch reuses Stormer Plus PLL offsets, adds configuration values
  for Stromer.

- The third patch adds dts nodes to enable the pll along with the cpu
  operating frequency table.

This series depends on below series
https://patchwork.kernel.org/project/linux-arm-msm/cover/20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com/

Changes in v2:
- Addressed review comments
- Adds dependency on above mentioned patch series for dropping
  CLK_SET_RATE_PARENT flag from GPLL clocks, GPLL0 clock provider for
  mailbox
- Add CPU operating point at 800MHz based on the review comments.

Gokul Sriram Palanisamy (3):
  dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
  clk: qcom: apss-ipq-pll: add support for IPQ5018
  arm64: dts: qcom: ipq5018: enable the CPUFreq support

 .../bindings/clock/qcom,a53pll.yaml           |  1 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 40 +++++++++++++++++++
 drivers/clk/qcom/apss-ipq-pll.c               | 21 ++++++++++
 3 files changed, 62 insertions(+)

-- 
2.34.1

