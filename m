Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67578771F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbjHXRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbjHXRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:34:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423519B7;
        Thu, 24 Aug 2023 10:34:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEZTt6002284;
        Thu, 24 Aug 2023 17:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=19x/YS7ofBvdsImdZrMv6o0tQe5FWEu3TCJlkwu/aeo=;
 b=VfKDuGqrE4k4vtI6dWUC4BrIhIA7d3NMy5SuyDnvlLr8KF8EsvLSp01ZeUL8lxt5xOwA
 wN3WA7gCeuIOHwl8xiVqBrgaK6JddAkMsHnqZc0x/r19QxnYvnC7mth3rjuCG9dt/MOs
 TtJzjbkufyAHrS063GXew3YhCIZxqVdYBB13PhnGiHw1jhxrgi+mtmE4nAZampnAD35G
 ttkeMGrqVxKswnjA0WGUMVWApkTkn/acZo1mqvQW4i6RkTVGzIps4SBzIakJTlL8BHer
 wj7HESjwbLSKZ7UbT2EBJcG53PotgjbCAyRKDkic4wtwtn7i1wig80qQ7eCocuvYOlz0 WA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumuaf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:34:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OHYiT6014000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:34:44 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 24 Aug 2023 10:34:39 -0700
From:   Ajit Pandey <quic_ajipan@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC:     Ajit Pandey <quic_ajipan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] clk: qcom: Add support for GCC and RPMHCC on SM4450
Date:   Thu, 24 Aug 2023 23:04:06 +0530
Message-ID: <20230824173410.550126-1-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UPWaIaREEvTArPIvGgdUySmfq2drxBvV
X-Proofpoint-ORIG-GUID: UPWaIaREEvTArPIvGgdUySmfq2drxBvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_13,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=811
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add dt-bindings and driver support for GCC and RPMHCC on
SM4450 platform.

Ajit Pandey (4):
  dt-bindings: clock: qcom: Add RPMHCC for SM4450
  clk: qcom: rpmh: Add RPMH clocks support for SM4450
  dt-bindings: clock: qcom: Add GCC clocks for SM4450
  clk: qcom: Add GCC driver support for SM4450

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm4450-gcc.yaml       |   54 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   21 +
 drivers/clk/qcom/gcc-sm4450.c                 | 2898 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm4450-gcc.h   |  197 ++
 7 files changed, 3181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm4450.c
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h

-- 
2.25.1

