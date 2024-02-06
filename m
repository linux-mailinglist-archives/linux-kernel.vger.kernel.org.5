Return-Path: <linux-kernel+bounces-54782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF984B3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280DD2847D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7162132C08;
	Tue,  6 Feb 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eH+gaN91"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23513248C;
	Tue,  6 Feb 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219142; cv=none; b=AhebAM6uauDk6o2ef9OHurzb32ZJsh0SwFwIaOWbCF8a+oS5HQdYdACaxpMEHbh+Q+IwzkUj06xT6Ggrlv0KzFwPSWk+15/5vvSCeTCJYWbDnrl9dy6ChNAa2XX4gmaXwuxAeTmn9K4jgd5JXBcnw5rwclN5aXIQs4KcJHwp0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219142; c=relaxed/simple;
	bh=NcVpNj/VBK40QrakOfekf8DKXPab4xrGtNmiaN24A0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg7Vj6bUD0JZV9R/p03avOQPnfx5d/V8ru3LIeqxMPxe+pN9WWxgOY7EaqgE/eA6v/uVLWgu4EiH51sWbj77ZHLJyJftiYKkZaj6GenFaoCuZDn7mbyfZX3hNRlHUuHe5oGY7CXtmaM91FQsb6h9ZZB9Q52qqoK3booiDQe1ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eH+gaN91; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4161MNCj027640;
	Tue, 6 Feb 2024 11:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xhBth1kWKAn0TJwKGPZYpSvJ8afdory8vukHWmayxgI=; b=eH
	+gaN91pSsT0VA1UEcnZRUtiXNms04t6J0GGaIuAQunbTtmvinBByNksRDW7gU2hq
	81O361qCyktpzQK1jN2LTmMNzummTmtO7Gx5r1XLOi0znSuQEH8BvQkm/AGlTVLi
	IrGNBzSAofU2HuHm1juzfqUFzIEia6rjZvS0f3Ux1TBcaknujMpa6k/yCFCWrdU6
	Rx52fA76GF6ROJQA6U6yO+93ril5yRsboXZGxuhFf3VnQIW1ICZBwiqDvkwzglPA
	5SnsIKdN7fTui2xovVHgNKDybzsBgd3WIwLRow7Y9qjtAyLYbBr4kaeN31abjXdP
	BnsaE+PdyZoV03I/C2dA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3apjh3sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 11:32:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416BWFnU031736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 11:32:15 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 03:32:10 -0800
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Jagadeesh Kona
	<quic_jkona@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: clock: qcom: Add video clock bindings for SM8650
Date: Tue, 6 Feb 2024 17:01:41 +0530
Message-ID: <20240206113145.31096-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206113145.31096-1-quic_jkona@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _mGW42bQGsmSAfjwzYvHRiNCuVFTTErW
X-Proofpoint-GUID: _mGW42bQGsmSAfjwzYvHRiNCuVFTTErW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060081

Extend device tree bindings of SM8450 videocc to add support for SM8650
videocc. While it at, fix the incorrect header include in sm8450 videocc
yaml documentation.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
 include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index bad8f019a8d3..79f55620eb70 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
 
 maintainers:
   - Taniya Das <quic_tdas@quicinc.com>
+  - Jagadeesh Kona <quic_jkona@quicinc.com>
 
 description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on SM8450.
 
-  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
+  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8450-videocc
       - qcom,sm8550-videocc
+      - qcom,sm8650-videocc
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
index 9d795adfe4eb..ecfebe52e4bb 100644
--- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
+++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
@@ -19,6 +19,11 @@
 #define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC				9
 #define VIDEO_CC_PLL0						10
 #define VIDEO_CC_PLL1						11
+#define VIDEO_CC_MVS0_SHIFT_CLK					12
+#define VIDEO_CC_MVS0C_SHIFT_CLK				13
+#define VIDEO_CC_MVS1_SHIFT_CLK					14
+#define VIDEO_CC_MVS1C_SHIFT_CLK				15
+#define VIDEO_CC_XO_CLK_SRC					16
 
 /* VIDEO_CC power domains */
 #define VIDEO_CC_MVS0C_GDSC					0
@@ -34,5 +39,6 @@
 #define CVP_VIDEO_CC_MVS1C_BCR					4
 #define VIDEO_CC_MVS0C_CLK_ARES					5
 #define VIDEO_CC_MVS1C_CLK_ARES					6
+#define VIDEO_CC_XO_CLK_ARES					7
 
 #endif
-- 
2.43.0


