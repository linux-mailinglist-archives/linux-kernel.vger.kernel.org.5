Return-Path: <linux-kernel+bounces-164148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B98B79DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D5B25B78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79222176FB4;
	Tue, 30 Apr 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NGi2Dk7E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5B152782;
	Tue, 30 Apr 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487438; cv=none; b=mX01H2hjOcVfpdo6HilXCJt/rowl6BUpoCwrZnHyuu9RsOAWRL1reRveiM5njvZ9YOQPFe63VHI6mT16YBlPFvdOkLqNvR5lebTbOK3cRfU0eDd2NcUpfcknGmOPcPqgijBIP0Tpv+LlVb7jmAJWvbPCrR1FxmEaDI6pjKW3/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487438; c=relaxed/simple;
	bh=OqQSiVxO3HHYjrY+m/uSpBgsc4eDZkKVD/Wh+0XPBlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBD8YoJtBxS1lI9V3JTGEfA3S01xvnpbxkJdgktC2p5I4qf0KEAYkfx3cEp3JiE/Wt8CnfnXcRaNs8++G+Pj6d7XUtzOeIaRqTEOcbh+LjF3P5Ns8Fqw1MHpELaW/i1+g/FsUA+eAujAhZ113cjFkL8Aiqx51MCqvmHcw+c/Bzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NGi2Dk7E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U37fLm013470;
	Tue, 30 Apr 2024 14:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0oUE2xkR1suGk9gLtMS1UZqz6bXTRiFytMT+ynxDOy8=; b=NG
	i2Dk7ECPkXOx/BY6ZbJ+Migbo3PIH+0zaSKpEA9lTbsz2W8sHHPcpQ7rXF2lJrh1
	n7L7YQFIE+KGt/zoqfelYE6CRJTBSrowsQLJ7pMC3tMwd80DsaOBqKb7tmFpRl1v
	4y+GBam7o4LRHWTDXS+d6AVC0CHjgcCluPSdm84he/yil/pEEXpf9u6JVFpav/qJ
	sx3oSjvrN4ezWDZ2VLdf0EyQ8GiSRGOO6veFzLy1nKpzJA9nuzv8N07qvfUHAXEb
	9H97DR5Kg9QqbefAdPFqKlj7xJBG9B8ggTJoxFCcu1lZNuLe7olVpCAKRJKgfaRX
	ZBAwp0ogFWyiJ89THzjw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep1n2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUSHH030862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:28 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:22 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH V3 2/8] dt-bindings: clock: qcom: Add SM8650 video clock controller
Date: Tue, 30 Apr 2024 19:57:51 +0530
Message-ID: <20240430142757.16872-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dMChtsJJ-zWpN3yAjY4I-2Ng8OUfUVj9
X-Proofpoint-ORIG-GUID: dMChtsJJ-zWpN3yAjY4I-2Ng8OUfUVj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300103

SM8650 video clock controller has most clocks same as SM8450,
but it also has few additional clocks and resets. Add device tree
bindings for the video clock controller on Qualcomm SM8650 platform
by defining these additional clocks and resets on top of SM8450.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 .../bindings/clock/qcom,sm8450-videocc.yaml   |  6 ++++-
 .../dt-bindings/clock/qcom,sm8650-videocc.h   | 23 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-videocc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index 78a1bb5be878..922e95c61778 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -8,18 +8,22 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
 
 maintainers:
   - Taniya Das <quic_tdas@quicinc.com>
+  - Jagadeesh Kona <quic_jkona@quicinc.com>
 
 description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on SM8450.
 
-  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
+  See also::
+    include/dt-bindings/clock/qcom,sm8450-videocc.h
+    include/dt-bindings/clock/qcom,sm8650-videocc.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8450-videocc
       - qcom,sm8550-videocc
+      - qcom,sm8650-videocc
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/clock/qcom,sm8650-videocc.h b/include/dt-bindings/clock/qcom,sm8650-videocc.h
new file mode 100644
index 000000000000..4e3c2d87280f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-videocc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8650_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8650_H
+
+#include "qcom,sm8450-videocc.h"
+
+/* SM8650 introduces below new clocks and resets compared to SM8450 */
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_MVS0_SHIFT_CLK					12
+#define VIDEO_CC_MVS0C_SHIFT_CLK				13
+#define VIDEO_CC_MVS1_SHIFT_CLK					14
+#define VIDEO_CC_MVS1C_SHIFT_CLK				15
+#define VIDEO_CC_XO_CLK_SRC					16
+
+/* VIDEO_CC resets */
+#define VIDEO_CC_XO_CLK_ARES					7
+
+#endif
-- 
2.43.0


