Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73F178C1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjH2JzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjH2Jyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:54:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE00AE9;
        Tue, 29 Aug 2023 02:54:47 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T95ixH005593;
        Tue, 29 Aug 2023 09:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lAz09KpZY/lx+wtK8foSJmZPubo+ZJCG4JHpeYIQ8Gs=;
 b=jXsaiOaKB4MtiC8eKE7GdF5qwzl4Sn0mY6PL6yz4xgh9T2x4PD6JQ/OYxwfObPiIFseX
 nS2Gg390dYPlj/+eptybrgVAvlCXW6JGaSRQvQlzo2SFK3WK0E5v485ubQTI/km/FrHF
 G7Uj7s5WeMM3p+hRd81XmTDdu5YPX7UMc4WNmHAXqB1c1NBJMVZWYZM1E9p8VaMgTAex
 Q3z7w8ytKEpYZn/6EwMNJmIHXHpYreaWqQLuwTt9FbU4C3e0SUShgc5QVqK2sYEa3SEC
 a0XNl0tHs0+jnkflK3sTMlLLg2cALQFuUuvp3WosxbaXQ18kWoqkMAKZTWWqMjelSNPn lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhntb35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:43 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T9sgoI017788
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:42 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 02:54:37 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH 0/3] Add APSS clock driver support for IPQ5018
Date:   Tue, 29 Aug 2023 15:24:20 +0530
Message-ID: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z4khfkdYFy8NughIapQVf56rW2_-4GfE
X-Proofpoint-ORIG-GUID: z4khfkdYFy8NughIapQVf56rW2_-4GfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=939 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the APSS clock to bump the CPU frequency
above 800MHz. APSS PLL found in the IPQ5018 is of type Stromer. 

- The first patch in the series adds the required a53pll compatible.

- The second patch adds Stormer PLL offsets, its configuration values and
regmap and modify probe to reuse clk_stromer_pll_configure() for Stormer
which was added for Stormer Plus.

- The third patch adds dts nodes to enable the pll along with the cpu
operating frequency table.

Gokul Sriram Palanisamy (3):
  dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
  clk: qcom: apss-ipq-pll: add support for IPQ5018
  arm64: dts: qcom: ipq5018: enable the CPUFreq support

 .../bindings/clock/qcom,a53pll.yaml           |  1 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 34 ++++++++++++
 drivers/clk/qcom/apss-ipq-pll.c               | 52 ++++++++++++++++++-
 3 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.34.1

