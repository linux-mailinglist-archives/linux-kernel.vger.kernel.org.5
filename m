Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AF758D08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGSFXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGSFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:22:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33782186;
        Tue, 18 Jul 2023 22:22:51 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4OsYX009535;
        Wed, 19 Jul 2023 05:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=BS1w76bhiCtzSb7vSuzrvwjS71N6mSbl35av44vz3Ys=;
 b=bxchdLySLwV+d/iuafyfZOVPQmmwidqcv9+peoQss26yNc3q2+R4rM7u8kUY0GpKMgmx
 sS/JRuUiN1M66r3IfeRlGex0hnaAJqUXs94LDot2pQLWOJlR+sTr3+sXZBxTiThEJuT6
 fh1mc5Ej8BxS/vWrVx5bq2GlMn+H6URWgOTSNR5R7mq/hcqJPhi19GTIHLcKB91yrmVS
 /3DO72iqhtDQHl2Hna0RHT4OAMHcSyKR11sExA/gQXjfR9//LZTwpV+ZQrkpILosWmJd
 a1Ww7E2iOghg0dlX6nzTuhDnuhocLlv16fsBxaWkIcc70VQLTGMk0AjG8M7dl9Nzi8vJ 1w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx8sk02dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 05:22:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J5MiVA004735;
        Wed, 19 Jul 2023 05:22:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1bc5-1;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J5Mim9004724;
        Wed, 19 Jul 2023 05:22:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J5MiA6004721;
        Wed, 19 Jul 2023 05:22:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9E6AFE00; Wed, 19 Jul 2023 10:52:43 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD indexes
Date:   Wed, 19 Jul 2023 10:52:41 +0530
Message-Id: <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GNEtlS90GF0ja1ZETw0-cXCLX_yeG4Wd
X-Proofpoint-ORIG-GUID: GNEtlS90GF0ja1ZETw0-cXCLX_yeG4Wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=666 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190049
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Generic RPMh Power Domain indexes that can be used
for all the Qualcomm SoC henceforth.
The power domain indexes of these bindings are based on compatibility
with current targets like SM8[2345]50 targets.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/power/qcom,rpmhpd.h

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
new file mode 100644
index 0000000..7c201a6
--- /dev/null
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
+
+/* Generic RPMH Power Domain Indexes */
+#define RPMHPD_CX               0
+#define RPMHPD_CX_AO		1
+#define RPMHPD_EBI		2
+#define RPMHPD_GFX		3
+#define RPMHPD_LCX		4
+#define RPMHPD_LMX		5
+#define RPMHPD_MMCX		6
+#define RPMHPD_MMCX_AO		7
+#define RPMHPD_MX		8
+#define RPMHPD_MX_AO		9
+#define RPMHPD_MXC		10
+#define RPMHPD_MXC_AO		11
+#define RPMHPD_MSS              12
+#define RPMHPD_NSP		13
+#define RPMHPD_NSP0             14
+#define RPMHPD_NSP1             15
+#define RPMHPD_QPHY             16
+#define RPMHPD_DDR              17
+#define RPMHPD_XO               18
+
+#endif
-- 
2.7.4

