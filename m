Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD976AB67
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHAIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjHAIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:54:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9211996;
        Tue,  1 Aug 2023 01:54:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37189QSu031114;
        Tue, 1 Aug 2023 08:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=QqdKrxgNGpegtHoX42r1rcywXkR9SeUM/aybOYqB+wk=;
 b=lpJcXKt2LYwWvNLnG5+Uj/RwQFGyjt7v6Rgr3V9s+iBYmRSajhZgo5Sn2qe4S5WHPYRW
 7TFfgGMPaB8gY+xUCxLLAjFOaDjZTQnaKzf2PTzAh66mXSoZAxr86tmVU1kRVDzvghMk
 MySKXDdoFZP079WCpsDsBbqT/SAI/9pniUHhci45/GmGjQO5+HUrk4ojFJGmc7hnRQTO
 kugWgJp7BjPcikRVTTf3KGcifUqlhMm1Csk7JlCKMR46CB5vnzWkLnl/HB1zhI13aIaZ
 jEgDZTy11X9v6US+tJZVZghKe022OM868w1JUM+Z024kocz8407up1thr/2IG/z00ahd Ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gthbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:54:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3718sC8D016612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 08:54:12 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 01:54:08 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Jie Luo <quic_luoj@quicinc.com>
Subject: [PATCH 0/3] add clock controller of qca8386/qca8084
Date:   Tue, 1 Aug 2023 16:53:49 +0800
Message-ID: <20230801085352.22873-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lO4lk7Ly_MYHmIRXpFMgJbK47cAhbfeB
X-Proofpoint-GUID: lO4lk7Ly_MYHmIRXpFMgJbK47cAhbfeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=785
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Luo <quic_luoj@quicinc.com>

qca8xxx is 4 * 2.5GBaseT ports chip, working as switch mode
named by qca8386, working as PHY mode named by qca8084,
clock hardware reigster is accessed by MDIO bus.

This patch series add the clock controller of qca8363/qca8084,
and add the clock flag CLK_ENABLE_MUTEX_LOCK to avoid spin lock
used during the clock operation of qca8k clock controller where
the sleep happens when accessing clock control register by MDIO
bus.

Luo Jie (3):
  clk: Add the flag CLK_ENABLE_MUTEX_LOCK of enabling clock
  dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
  clk: qcom: add clock controller driver for qca8386/qca8084

 .../bindings/clock/qcom,nsscc-qca8k.yaml      |   59 +
 drivers/clk/clk.c                             |   78 +-
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/nsscc-qca8k.c                | 2205 +++++++++++++++++
 include/dt-bindings/clock/qcom,nsscc-qca8k.h  |  102 +
 include/dt-bindings/reset/qcom,nsscc-qca8k.h  |   76 +
 include/linux/clk-provider.h                  |    4 +
 8 files changed, 2519 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
 create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
 create mode 100644 include/dt-bindings/clock/qcom,nsscc-qca8k.h
 create mode 100644 include/dt-bindings/reset/qcom,nsscc-qca8k.h


base-commit: ec89391563792edd11d138a853901bce76d11f44
-- 
2.34.1

