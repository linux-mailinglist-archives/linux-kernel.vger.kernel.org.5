Return-Path: <linux-kernel+bounces-147370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE928A730D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22C21C219D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0D136995;
	Tue, 16 Apr 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AwgPidU8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB612FF72;
	Tue, 16 Apr 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291705; cv=none; b=Id9GT5wVTLL0M7RbADU00xgRHi5poIcaha0qW/7Fm4QbU8jE2ri4x3Zn2T75VAX3nNw1pcNP49hmAP4K/4TyO1you+alv/UlcpEXvlh8u5gXU8CEwC6359kCQ33rXJY+0XbfQDk1WKxHhx18kJVLGKc1yBIH2z65U4BdTgU1lUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291705; c=relaxed/simple;
	bh=XoU2lFGtX1inJYtEwpPlKRKiu5JpMxsymzMVmp4wakU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhDhPEOFZeGOIaNi8bw04QClAqmUa6ZaTUqh+b81qL0x0e/gfgNvBTOrnj86j61G9BvmCQbC2Lk18lpqRpIojx+5pkylji4qsaH+giYH2ytrxB4t3wtk6GryU+tP6zMR3VbooQtzd9WCuwxr/eBhtl7s0zorURuS/Zzf2Ch1LLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AwgPidU8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GHpIsF001808;
	Tue, 16 Apr 2024 18:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GkrTVHJ1MbdfRvlawKI4mzmoPypgVOh2jU/egsI6inc=; b=Aw
	gPidU8vWdxSdxT0ZULrQYFei1W6zo7trIpnq2nz/onK52W1L1F0GHZJkZN2UNQBd
	xN3R85cWKhcMET7nm8kqzyM+3hVGhF/87KCDTfK3pSsE80PaqpWfgRI/MwdVhlyA
	6KFGWxtsuzBvibfJLgWZepwGh6G3kysdbjUJ3arTwLkZJzkIm15rdQNNTZnmYFEB
	ozleQVmOITqI/oqQP09C9z6GPaiJPujXLbh37u/FrHU+gOaFP0D7/QygjirH7U11
	COLi4T2jtQhquWcEM6y5scdHK3cSyiatgoiNDcW81SNG68/ihEaM1HcKZzQGPMqi
	T+YAnxKIMxltsPJLddLg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhx3205j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GILcqS002450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:21:38 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 11:21:33 -0700
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
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 2/8] dt-bindings: clock: qcom: add bindings for dispcc on SM4450
Date: Tue, 16 Apr 2024 23:49:59 +0530
Message-ID: <20240416182005.75422-3-quic_ajipan@quicinc.com>
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
X-Proofpoint-GUID: KpiULK8MqxiWg6sHX1CC983DW9_U2hfx
X-Proofpoint-ORIG-GUID: KpiULK8MqxiWg6sHX1CC983DW9_U2hfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160115

Add device tree bindings for the display clock controller on
Qualcomm SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm4450-dispcc.yaml    | 71 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm4450-dispcc.h    | 51 +++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
new file mode 100644
index 000000000000..2aa05353eff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm4450-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller on SM4450
+
+maintainers:
+  - Ajit Pandey <quic_ajipan@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM4450
+
+  See also:: include/dt-bindings/clock/qcom,sm4450-dispcc.h
+
+properties:
+  compatible:
+    const: qcom,sm4450-dispcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Display AHB clock source from GCC
+      - description: sleep clock source
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,sm4450-gcc.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm4450-dispcc";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&gcc GCC_DISP_AHB_CLK>,
+               <&sleep_clk>,
+               <&dsi0_phy_pll_out_byteclk>,
+               <&dsi0_phy_pll_out_dsiclk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm4450-dispcc.h b/include/dt-bindings/clock/qcom,sm4450-dispcc.h
new file mode 100644
index 000000000000..ca6f2ef90157
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm4450-dispcc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM4450_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM4450_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_AHB1_CLK					0
+#define DISP_CC_MDSS_AHB_CLK					1
+#define DISP_CC_MDSS_AHB_CLK_SRC				2
+#define DISP_CC_MDSS_BYTE0_CLK					3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				4
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				6
+#define DISP_CC_MDSS_ESC0_CLK					7
+#define DISP_CC_MDSS_ESC0_CLK_SRC				8
+#define DISP_CC_MDSS_MDP1_CLK					9
+#define DISP_CC_MDSS_MDP_CLK					10
+#define DISP_CC_MDSS_MDP_CLK_SRC				11
+#define DISP_CC_MDSS_MDP_LUT1_CLK				12
+#define DISP_CC_MDSS_MDP_LUT_CLK				13
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				14
+#define DISP_CC_MDSS_PCLK0_CLK					15
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				16
+#define DISP_CC_MDSS_ROT1_CLK					17
+#define DISP_CC_MDSS_ROT_CLK					18
+#define DISP_CC_MDSS_ROT_CLK_SRC				19
+#define DISP_CC_MDSS_RSCC_AHB_CLK				20
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				21
+#define DISP_CC_MDSS_VSYNC1_CLK					22
+#define DISP_CC_MDSS_VSYNC_CLK					23
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				24
+#define DISP_CC_PLL0						25
+#define DISP_CC_PLL1						26
+#define DISP_CC_SLEEP_CLK					27
+#define DISP_CC_SLEEP_CLK_SRC					28
+#define DISP_CC_XO_CLK						29
+#define DISP_CC_XO_CLK_SRC					30
+
+/* DISP_CC power domains */
+#define DISP_CC_MDSS_CORE_GDSC					0
+#define DISP_CC_MDSS_CORE_INT2_GDSC				1
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+#endif
-- 
2.25.1


