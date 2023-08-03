Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFF76E5FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHCK6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjHCK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:58:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708230E4;
        Thu,  3 Aug 2023 03:58:23 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373ASJ6l001878;
        Thu, 3 Aug 2023 10:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XzLUvkAz8qwD4XnFIccvceRCsJ6MDLtK6pIhVjI0oqQ=;
 b=Aonkotw0GAUOOW1qb9D2rd7sbFdieZSRbglqjJnkrLR2oWFdNk6iW1y3a00WsNmywNkr
 LB3zh240SjKMTCiuXLtgwbylmgodtpJytjumZUvuEBBf9Jkwrs03HpvVBNv9nW7fP1bj
 bUy+WprtrVN5H4QjPlwmtg8/X4rgC6D+Q1YiZgVb2pGXOoQjrWhLhIaWznjQtd4IOFSf
 wiPFiIPcJh12RsLksV/5OUz8Ey+kaQ3lpm+aCjhxjCIc6n/2Y4rAJOV7uXlfpJ5LRBDw
 ci1uhc2iYxi1QYNyhk5CpplIpL3wm+E120Q6OK0geeNgGRy+2K5NzlAHzNypd/1w/iPh WA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s85fxrmyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 10:58:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373AwJpo026588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:58:19 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:58:13 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/8] dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Thu, 3 Aug 2023 16:27:34 +0530
Message-ID: <20230803105741.2292309-2-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
References: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sd9HzNe-OcHz5q2gnJ_lt-Hj1M69yg98
X-Proofpoint-ORIG-GUID: Sd9HzNe-OcHz5q2gnJ_lt-Hj1M69yg98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for GCC_GPLL1_OUT_EVEN and GCC_DDRSS_ECPRI_GSI_CLK clock
bindings for QDU1000 and QRU1000 SoCs. While at it, update the
maintainers list.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4:
 - Updated the commit text
Changes since v3:
 - None
Changes since v2:
 - None
Changes since v1:
 - Removed the v2 variant compatible string changes
 - Updated the maintainers list

 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
 include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
index 767a9d03aa32..d712b1a87e25 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
 
 maintainers:
-  - Melody Olvera <quic_molvera@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Imran Shaik <quic_imrashai@quicinc.com>
 
 description: |
   Qualcomm global clock control module which supports the clocks, resets and
diff --git a/include/dt-bindings/clock/qcom,qdu1000-gcc.h b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
index ddbc6b825e80..2fd36cbfddbb 100644
--- a/include/dt-bindings/clock/qcom,qdu1000-gcc.h
+++ b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
 /*
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
@@ -138,6 +138,8 @@
 #define GCC_AGGRE_NOC_ECPRI_GSI_CLK			128
 #define GCC_PCIE_0_PIPE_CLK_SRC				129
 #define GCC_PCIE_0_PHY_AUX_CLK_SRC			130
+#define GCC_GPLL1_OUT_EVEN				131
+#define GCC_DDRSS_ECPRI_GSI_CLK				132
 
 /* GCC resets */
 #define GCC_ECPRI_CC_BCR				0
-- 
2.25.1

