Return-Path: <linux-kernel+bounces-109845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CC885669
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A67C2822E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F853E1E;
	Thu, 21 Mar 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fglxiHLM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A11383B5;
	Thu, 21 Mar 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013172; cv=none; b=um+3Uhc6OqPa+hS7neVv7n0N5r0sD0v/LiUoCa84Lj8dkXlpEEHAWctarFQwTScbFuXAe1Fmmyi9DJifXu0RRXLm7OgKbh3K8OiZOJQTufdj4wA5hpjKb4ZD94UMRp5DeeMYYUuskrcLk5eyBW+wSx2gvHP80qalXUPYXS8K01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013172; c=relaxed/simple;
	bh=bRkOGC92iQQ86hHzU0XJ2izpjWDcLsQofM91o3QmN9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbwSTJ7Hm4pOmB1Hjd2xcgc8wjYy3UPyNeZ1wHJoT7F23IYMXt2FKdYvfpbFAzknUlNuz4WRiUGRtLIkW+xVAMsQEGypNPk3pjv5n5+cYh2McxeousW3iMWglSuYOBAi86pfzNW+RYfLE0+TNZKHQaY9M3O3b6/S6msR9s5a/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fglxiHLM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6Wgeb021570;
	Thu, 21 Mar 2024 09:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vuWUqibAXMzg7Su/NLJzChlhs1BEgYOJX0/+2EM60aE=; b=fg
	lxiHLMMAYptpHN6VqYsM5+C3mzaAszmxNGfHg8Fizgp7sOwcLmLkvlDItPmYsu90
	lGHJfRTxjIpjKPOm+CELSb1AglbFImUh3JCqbNVJJ7OizO9l8G41dYifj7Uwt0iP
	LcWgpklkhKxshCE9OU4qNjWcukkoT9QHiZvTbyjX+zp+hsYfQJBAd4pEYueeLlSO
	GP/poZlgHWzUsH8IuhkboSNeDRI2pPXi4N1MG7OPVRibDbQHrA82XPmGO63JfR8b
	0AmTKuX8uSp5TrZT+5FucM3wm4FCk7M2qSfdI3r2jl+SA4DxtY9zcx7n+HKSPeVf
	Y3JtsM0HUMack39qh7hQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0c67gqg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L9Q6O2021727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:06 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 02:26:00 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video clock controller
Date: Thu, 21 Mar 2024 14:55:24 +0530
Message-ID: <20240321092529.13362-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321092529.13362-1-quic_jkona@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: _C2uz-RvRJ93jrZ0wNardMJrQz-ZHQd_
X-Proofpoint-ORIG-GUID: _C2uz-RvRJ93jrZ0wNardMJrQz-ZHQd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210064

Extend device tree bindings of SM8450 videocc to add support
for SM8650 videocc. While it at, fix the incorrect header
include in sm8450 videocc yaml documentation.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


