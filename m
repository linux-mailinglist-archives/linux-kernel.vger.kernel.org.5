Return-Path: <linux-kernel+bounces-125814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123E892C82
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E551C216A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE584F890;
	Sat, 30 Mar 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I/HDJOg3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8740847;
	Sat, 30 Mar 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823382; cv=none; b=GB+mvnLnQ+h+HDjTUNIZtcd4F0Wl/0H3aRYlc08pxBUpg6/qIyc/5VpzN+QuWlOJA5AN1R8nuP7sW0hl7gP2gLpPMHdBSMiGxsSdhNgIniyZx1xXI12gr7XvWvTgn6kI8ZD4Ig462aaRjdiSnkEec7LoSLdMxLqxCnvcdiYCbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823382; c=relaxed/simple;
	bh=F8v2vtlbTvSNqGvoR6scD2LACKgLnywLP7mU+N22YR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu4K5hJ86IfOxi/lYkpAXd9E1hosOv/+LcaSNpfCSWyPSVsLqqyegzzOzm1M/y6J3rC+pp4ovsLbOxVxImufHoTaZUpnCiCVNUMNUJXO/7dAfrka1NY3paal4WrjxHsDc2F1sns4g06Oi8+ofrQ5Detm9U0yLcI22WzQmZLT4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I/HDJOg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UINQcL030121;
	Sat, 30 Mar 2024 18:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+y4Q/hxpqc61oD6uf/OlOFttuYeJlGatLs/WJHTm9Tg=; b=I/
	HDJOg3D4aD/Mey2KM+LQYDKJxVlfw5SsBjrNJFgMqbkh0zV5kzm2jraHNmpnYc0q
	sH3N8N0uspeKoNlYx5G+3+wm002bX9i/6Hz47oxNVapu/XSjJfDKnNMyCFODOQCQ
	GEfE4ziFMz2QW/06kkyVJVKk8jYleT5Pg7q17rx3F1GmAUtX2A8rH9SA+WCOWTB1
	FSSd1pDbj5017R24GTniEcT71sYMz7uuUBc1rGJKJrjXdn0yHmb3ohRE/nsWgP62
	qMkRH4FEAZ3lGmT5atfirTalLjPiSjYlP1GVuf2XGRttT9yRhCDOji/th0HL8oj7
	wZNhChSaCk5DdF0uuQgQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x683s1fx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UITZ7C024415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 18:29:35 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 11:29:30 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 6/7] dt-bindings: clock: qcom: Add GPUCC clocks for SM4450
Date: Sat, 30 Mar 2024 23:58:16 +0530
Message-ID: <20240330182817.3272224-7-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IZiOof0H4Ha1RgPeuRz5fpR3CVlQJTiO
X-Proofpoint-ORIG-GUID: IZiOof0H4Ha1RgPeuRz5fpR3CVlQJTiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300151

Add support for qcom display clock controller bindings
for SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 .../bindings/clock/qcom,sm8450-gpucc.yaml     |  2 +
 include/dt-bindings/clock/qcom,sm4450-gpucc.h | 62 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
index 36974309cf69..8ea4ccf6eb1c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -14,6 +14,7 @@ description: |
   domains on Qualcomm SoCs.
 
   See also::
+    include/dt-bindings/clock/qcom,sm4450-gpucc.h
     include/dt-bindings/clock/qcom,sm8450-gpucc.h
     include/dt-bindings/clock/qcom,sm8550-gpucc.h
     include/dt-bindings/reset/qcom,sm8450-gpucc.h
@@ -23,6 +24,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sm4450-gpucc
       - qcom,sm8450-gpucc
       - qcom,sm8550-gpucc
       - qcom,sm8650-gpucc
diff --git a/include/dt-bindings/clock/qcom,sm4450-gpucc.h b/include/dt-bindings/clock/qcom,sm4450-gpucc.h
new file mode 100644
index 000000000000..304f83e5f645
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm4450-gpucc.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM4450_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM4450_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK						0
+#define GPU_CC_CB_CLK						1
+#define GPU_CC_CRC_AHB_CLK					2
+#define GPU_CC_CX_FF_CLK					3
+#define GPU_CC_CX_GFX3D_CLK					4
+#define GPU_CC_CX_GFX3D_SLV_CLK					5
+#define GPU_CC_CX_GMU_CLK					6
+#define GPU_CC_CX_SNOC_DVM_CLK					7
+#define GPU_CC_CXO_AON_CLK					8
+#define GPU_CC_CXO_CLK						9
+#define GPU_CC_DEMET_CLK					10
+#define GPU_CC_DEMET_DIV_CLK_SRC				11
+#define GPU_CC_FF_CLK_SRC					12
+#define GPU_CC_FREQ_MEASURE_CLK					13
+#define GPU_CC_GMU_CLK_SRC					14
+#define GPU_CC_GX_CXO_CLK					15
+#define GPU_CC_GX_FF_CLK					16
+#define GPU_CC_GX_GFX3D_CLK					17
+#define GPU_CC_GX_GFX3D_CLK_SRC					18
+#define GPU_CC_GX_GFX3D_RDVM_CLK				19
+#define GPU_CC_GX_GMU_CLK					20
+#define GPU_CC_GX_VSENSE_CLK					21
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC				22
+#define GPU_CC_HUB_AON_CLK					23
+#define GPU_CC_HUB_CLK_SRC					24
+#define GPU_CC_HUB_CX_INT_CLK					25
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC				26
+#define GPU_CC_MEMNOC_GFX_CLK					27
+#define GPU_CC_MND1X_0_GFX3D_CLK				28
+#define GPU_CC_PLL0						29
+#define GPU_CC_PLL1						30
+#define GPU_CC_SLEEP_CLK					31
+#define GPU_CC_XO_CLK_SRC					32
+#define GPU_CC_XO_DIV_CLK_SRC					33
+
+/* GPU_CC power domains */
+#define GPU_CC_CX_GDSC						0
+#define GPU_CC_GX_GDSC						1
+
+/* GPU_CC resets */
+#define GPU_CC_ACD_BCR						0
+#define GPU_CC_CB_BCR						1
+#define GPU_CC_CX_BCR						2
+#define GPU_CC_FAST_HUB_BCR					3
+#define GPU_CC_FF_BCR						4
+#define GPU_CC_GFX3D_AON_BCR					5
+#define GPU_CC_GMU_BCR						6
+#define GPU_CC_GX_BCR						7
+#define GPU_CC_XO_BCR						8
+#define GPU_CC_GX_ACD_IROOT_BCR					9
+#define GPU_CC_RBCPR_BCR					10
+
+#endif
-- 
2.25.1


