Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186737D6D58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJYNeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjJYNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:34:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0CA138;
        Wed, 25 Oct 2023 06:34:21 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCoixf031789;
        Wed, 25 Oct 2023 13:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jwDPbpSVbcPqvdBlNUpUiQ+j5CT511wjOh2N2JAIA+8=;
 b=Ie8PN6HKcQJXI6XxPbplV58Nr+AFP1sBOA3PjQjTKlG1SudEL0PlAnjP/4UxVSHIIaF0
 Fdutt/58XP7dq0yi9I2cFRz58coKD00UjJc8UcOaxX6I27I4KkYsX1jyY4JfFcNk6GXx
 kBmXUjRDovdV6hEb1ZDx+9o0DuHb4WDWvLYLxkNGsqxmRnLE/KLMLBRmza2Vbsg4uaKh
 SSKqZ6w0Glu8kwN2dv2tyzbHXXT2HR+Kmw+GZvcMQ5wPp5zVpiQZBcpDVGItdP3XsUfG
 +W1Ug9V9ttiWvTvqd4I7gNcIrldDiP08vuDXi1s5DhhfIYP1gmMWb7pO49eOdPg0geTG zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txmhx9r90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:34:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDY4r6029801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:34:04 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:33:59 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <quic_tsoni@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 0/4] clk: qcom: Introduce clocks drivers for SC8380XP
Date:   Wed, 25 Oct 2023 19:03:16 +0530
Message-ID: <20231025133320.4720-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eu4pHySoNVB25NuPW-GIGigO-pxPe1w4
X-Proofpoint-GUID: eu4pHySoNVB25NuPW-GIGigO-pxPe1w4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=491 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial clock support for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.

Dependencies: None
Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat

Rajendra Nayak (4):
  dt-bindings: clock: qcom: Add SC8380XP GCC clocks
  clk: qcom: Add Global Clock controller (GCC) driver for SC8380XP
  dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for SC8380XP
  clk: qcom: rpmh: Add support for SC8380XP rpmh clocks

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sc8380xp-gcc.yaml     |   72 +
 drivers/clk/qcom/Kconfig                      |   10 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   26 +
 drivers/clk/qcom/gcc-sc8380xp.c               | 6812 +++++++++++++++++
 include/dt-bindings/clock/qcom,sc8380xp-gcc.h |  485 ++
 7 files changed, 7407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8380xp-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc8380xp.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8380xp-gcc.h

-- 
2.17.1

