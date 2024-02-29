Return-Path: <linux-kernel+bounces-86141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1786C052
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E3FB24CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2D3E489;
	Thu, 29 Feb 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A4qeC7c3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9F3C463;
	Thu, 29 Feb 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185199; cv=none; b=QDsQ8I050oeG3sGKQTAowhuJDYa4QnZu3HCIgQFBOAQQawasfsxQgzN4o0a/gieUzCK5ah4+XESmh2TO5Vh2ElvmuWUfaHMtxy6yRPmCKq05ujcKZO72XhE4EO/tDdyDGgGBt5ofFq8dur0wNS0z2OPRQcGyrdPfPKTTlndX4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185199; c=relaxed/simple;
	bh=XwJlLhKCVPB+QstjURkEJK5/Z3gpcBgy45MrnkAjki8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jHjl+OMN0p+x+5LIzjKemo3wd3OASnQcsphMdDiviVI2/oA2CoFikRJ8+ivBE/HdykFTD8LUdSZknkknjWi6C1Xw7lbnC4bLMpri9BANJlsui0Te+Pqi6kfEfhvd5eykQl50XJVE2Lc3MHJ/1IrHUsx9ZIWyEBZyV/AuJcMTi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A4qeC7c3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T0tEPZ001535;
	Thu, 29 Feb 2024 05:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=asBzZ+KrqYp1FmQoIiXBhRCW2rzzK/Wus+q3IO48n20
	=; b=A4qeC7c3GLTtVrw47Vi1LUqvPkqvfQe7loAC8MRF+BEOfipDIiogbyWcrXu
	MAvh3X/c+T6F89n0EwES/oCIZ0Iw5TRDyjt1BM+Fur+mNIquC0ElfB3eSoKFXhZW
	87aVqDdkYcu+owiLTIfgXJNdq4kJCPFPYUPP18/2XB7WhVj2sT36iL9PD1ln00q6
	eXjzgsgaNOMZWTKWntzb6FWg5SQ+X+NWm2lnBXxodvnFdIjPBZ91jAz6TjzVgGvh
	rnBm/QDOfItvaCGdIV5LC6IAAXduHlKDXC4ZBZ8u+8dcGUK0IErFyApAzoff6r1D
	8xTzqTGcYuMyL/beZ2vuRVv/93Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj1r1tq38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T5dMW9024394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:39:22 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 21:39:17 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 29 Feb 2024 11:08:56 +0530
Subject: [PATCH 3/5] dt-bindings: clock: qcom: Add SM8150 camera clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-camcc-support-sm8150-v1-3-8c28c6c87990@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
In-Reply-To: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lio7YR1d18SfHoy0s_87PMkAoV1DXakr
X-Proofpoint-GUID: lio7YR1d18SfHoy0s_87PMkAoV1DXakr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290042

Add device tree bindings for the camera clock controller on
Qualcomm SM8150 platform.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../bindings/clock/qcom,sm8150-camcc.yaml          |  77 ++++++++++++
 include/dt-bindings/clock/qcom,sm8150-camcc.h      | 135 +++++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
new file mode 100644
index 000000000000..58c34134ad05
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8150-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on SM8150
+
+maintainers:
+  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and
+  power domains on SM8150.
+
+  See also:: include/dt-bindings/clock/qcom,sm8150-camcc.h
+
+properties:
+  compatible:
+    const: qcom,sm8150-camcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Camera AHB clock from GCC
+      - description: Board XO source
+
+  power-domains:
+    maxItems: 1
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+
+  required-opps:
+    maxItems: 1
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
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
+  - power-domains
+  - required-opps
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    clock-controller@ad00000 {
+      compatible = "qcom,sm8150-camcc";
+      reg = <0x0ad00000 0x10000>;
+      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>;
+      power-domains = <&rpmhpd SM8150_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8150-camcc.h b/include/dt-bindings/clock/qcom,sm8150-camcc.h
new file mode 100644
index 000000000000..5444035efa93
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8150-camcc.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8150_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SM8150_H
+
+/* CAM_CC clocks */
+#define CAM_CC_PLL0					0
+#define CAM_CC_PLL0_OUT_EVEN				1
+#define CAM_CC_PLL0_OUT_ODD				2
+#define CAM_CC_PLL1					3
+#define CAM_CC_PLL1_OUT_EVEN				4
+#define CAM_CC_PLL2					5
+#define CAM_CC_PLL2_OUT_MAIN				6
+#define CAM_CC_PLL3					7
+#define CAM_CC_PLL3_OUT_EVEN				8
+#define CAM_CC_PLL4					9
+#define CAM_CC_PLL4_OUT_EVEN				10
+#define CAM_CC_BPS_AHB_CLK				11
+#define CAM_CC_BPS_AREG_CLK				12
+#define CAM_CC_BPS_AXI_CLK				13
+#define CAM_CC_BPS_CLK					14
+#define CAM_CC_BPS_CLK_SRC				15
+#define CAM_CC_CAMNOC_AXI_CLK				16
+#define CAM_CC_CAMNOC_AXI_CLK_SRC			17
+#define CAM_CC_CAMNOC_DCD_XO_CLK			18
+#define CAM_CC_CCI_0_CLK				19
+#define CAM_CC_CCI_0_CLK_SRC				20
+#define CAM_CC_CCI_1_CLK				21
+#define CAM_CC_CCI_1_CLK_SRC				22
+#define CAM_CC_CORE_AHB_CLK				23
+#define CAM_CC_CPAS_AHB_CLK				24
+#define CAM_CC_CPHY_RX_CLK_SRC				25
+#define CAM_CC_CSI0PHYTIMER_CLK				26
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC			27
+#define CAM_CC_CSI1PHYTIMER_CLK				28
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC			29
+#define CAM_CC_CSI2PHYTIMER_CLK				30
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC			31
+#define CAM_CC_CSI3PHYTIMER_CLK				32
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC			33
+#define CAM_CC_CSIPHY0_CLK				34
+#define CAM_CC_CSIPHY1_CLK				35
+#define CAM_CC_CSIPHY2_CLK				36
+#define CAM_CC_CSIPHY3_CLK				37
+#define CAM_CC_FAST_AHB_CLK_SRC				38
+#define CAM_CC_FD_CORE_CLK				39
+#define CAM_CC_FD_CORE_CLK_SRC				40
+#define CAM_CC_FD_CORE_UAR_CLK				41
+#define CAM_CC_GDSC_CLK					42
+#define CAM_CC_ICP_AHB_CLK				43
+#define CAM_CC_ICP_CLK					44
+#define CAM_CC_ICP_CLK_SRC				45
+#define CAM_CC_IFE_0_AXI_CLK				46
+#define CAM_CC_IFE_0_CLK				47
+#define CAM_CC_IFE_0_CLK_SRC				48
+#define CAM_CC_IFE_0_CPHY_RX_CLK			49
+#define CAM_CC_IFE_0_CSID_CLK				50
+#define CAM_CC_IFE_0_CSID_CLK_SRC			51
+#define CAM_CC_IFE_0_DSP_CLK				52
+#define CAM_CC_IFE_1_AXI_CLK				53
+#define CAM_CC_IFE_1_CLK				54
+#define CAM_CC_IFE_1_CLK_SRC				55
+#define CAM_CC_IFE_1_CPHY_RX_CLK			56
+#define CAM_CC_IFE_1_CSID_CLK				57
+#define CAM_CC_IFE_1_CSID_CLK_SRC			58
+#define CAM_CC_IFE_1_DSP_CLK				59
+#define CAM_CC_IFE_LITE_0_CLK				60
+#define CAM_CC_IFE_LITE_0_CLK_SRC			61
+#define CAM_CC_IFE_LITE_0_CPHY_RX_CLK			62
+#define CAM_CC_IFE_LITE_0_CSID_CLK			63
+#define CAM_CC_IFE_LITE_0_CSID_CLK_SRC			64
+#define CAM_CC_IFE_LITE_1_CLK				65
+#define CAM_CC_IFE_LITE_1_CLK_SRC			66
+#define CAM_CC_IFE_LITE_1_CPHY_RX_CLK			67
+#define CAM_CC_IFE_LITE_1_CSID_CLK			68
+#define CAM_CC_IFE_LITE_1_CSID_CLK_SRC			69
+#define CAM_CC_IPE_0_AHB_CLK				70
+#define CAM_CC_IPE_0_AREG_CLK				71
+#define CAM_CC_IPE_0_AXI_CLK				72
+#define CAM_CC_IPE_0_CLK				73
+#define CAM_CC_IPE_0_CLK_SRC				74
+#define CAM_CC_IPE_1_AHB_CLK				75
+#define CAM_CC_IPE_1_AREG_CLK				76
+#define CAM_CC_IPE_1_AXI_CLK				77
+#define CAM_CC_IPE_1_CLK				78
+#define CAM_CC_JPEG_CLK					79
+#define CAM_CC_JPEG_CLK_SRC				80
+#define CAM_CC_LRME_CLK					81
+#define CAM_CC_LRME_CLK_SRC				82
+#define CAM_CC_MCLK0_CLK				83
+#define CAM_CC_MCLK0_CLK_SRC				84
+#define CAM_CC_MCLK1_CLK				85
+#define CAM_CC_MCLK1_CLK_SRC				86
+#define CAM_CC_MCLK2_CLK				87
+#define CAM_CC_MCLK2_CLK_SRC				88
+#define CAM_CC_MCLK3_CLK				89
+#define CAM_CC_MCLK3_CLK_SRC				90
+#define CAM_CC_SLOW_AHB_CLK_SRC				91
+
+/* CAM_CC power domains */
+#define TITAN_TOP_GDSC					0
+#define BPS_GDSC					1
+#define IFE_0_GDSC					2
+#define IFE_1_GDSC					3
+#define IPE_0_GDSC					4
+#define IPE_1_GDSC					5
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR					0
+#define CAM_CC_CAMNOC_BCR				1
+#define CAM_CC_CCI_BCR					2
+#define CAM_CC_CPAS_BCR					3
+#define CAM_CC_CSI0PHY_BCR				4
+#define CAM_CC_CSI1PHY_BCR				5
+#define CAM_CC_CSI2PHY_BCR				6
+#define CAM_CC_CSI3PHY_BCR				7
+#define CAM_CC_FD_BCR					8
+#define CAM_CC_ICP_BCR					9
+#define CAM_CC_IFE_0_BCR				10
+#define CAM_CC_IFE_1_BCR				11
+#define CAM_CC_IFE_LITE_0_BCR				12
+#define CAM_CC_IFE_LITE_1_BCR				13
+#define CAM_CC_IPE_0_BCR				14
+#define CAM_CC_IPE_1_BCR				15
+#define CAM_CC_JPEG_BCR					16
+#define CAM_CC_LRME_BCR					17
+#define CAM_CC_MCLK0_BCR				18
+#define CAM_CC_MCLK1_BCR				19
+#define CAM_CC_MCLK2_BCR				20
+#define CAM_CC_MCLK3_BCR				21
+
+#endif

-- 
2.25.1


