Return-Path: <linux-kernel+bounces-147374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6638A731D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425FE1F21A85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82FE13775A;
	Tue, 16 Apr 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xang8gGQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA14137747;
	Tue, 16 Apr 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291743; cv=none; b=XZVI/fQwhRYZSUFK5rOq4T3qJyYy9CVQvYLgoA20GGEYjyS5yCxLQxj+lnzD4L6ZXlu6lCrWM2YcFio6o8IQ9IGovsZ+7cEjGOZsTN2zUPSFVzPbDoLKiycs3vZ8M7TJ648cRf3BYoQygHMwZ68L9PYgT8NzfhoST2o3bKZaZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291743; c=relaxed/simple;
	bh=QSvNBWTJru/Q90w0dOVfpCdve8ZjcMeY/CEStFZwKEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlsYmpMJaGL40krpugzeAHZiVokQ3Q8ENAh0Ve4MnrIa3SXRmMBbJ32TsuCALL186BXUi5hoT4VUHkkb72Ahb72QL1wUqXyWQnJgp1I4odfKwCg1Zcn5w6R8yOkcHtEiaeuQo/YTzysO0+cq8+Mk858dBaWxF36G1CQZ7HBZNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xang8gGQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GAsd9Y018175;
	Tue, 16 Apr 2024 18:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jT8VpHu86OjzBv2gLX7/FOebC2mEOQQTr4wGW2nRQ+U=; b=Xa
	ng8gGQl/mS1j8rRgSfsiAHaoUo1SF0UVMG8b5F9Is12v+jC6SqTlfJrRfK4tgG6I
	S5DTwx7HUrYl8x3qMTN5w+/dvqLsyLpEjEBH/J2aD1V54JafKmrFi/ZvhxlQOpkw
	x8udaPVYfnE+BTu6ikh1gFjPISuEqWAlLSh7J3t6XjHpUsEWCqhgF21uovqpltVl
	jU+w5K+rPKCReH0PanpwJveym3F2HP8Z+jwkIpRsnJK0U7HepSc6vU8pG+dQEKYQ
	7XhCqJsaRDuKCe8C5Y2tM0H9aLYovL+tf3UeChEuN1cJrlCVx+rbzfQQ5wgpfUAz
	XHNnNaYh/HbifjqTRobg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhqyysc5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:22:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GIMGof029874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:22:16 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 11:22:11 -0700
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 6/8] dt-bindings: clock: qcom: add bindings for gpucc on SM4450
Date: Tue, 16 Apr 2024 23:50:03 +0530
Message-ID: <20240416182005.75422-7-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416182005.75422-1-quic_ajipan@quicinc.com>
References: <20240416182005.75422-1-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3lVU2ZAFy_m3Ho1kHaxF0QauOp0AFces
X-Proofpoint-ORIG-GUID: 3lVU2ZAFy_m3Ho1kHaxF0QauOp0AFces
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160115

Add device tree bindings for the graphics clock controller on
Qualcomm SM4450 platform.

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


