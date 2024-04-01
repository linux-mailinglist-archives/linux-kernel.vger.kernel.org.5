Return-Path: <linux-kernel+bounces-126564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE075893983
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192CF1F221F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0B17998;
	Mon,  1 Apr 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7E2AIle"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB01756F;
	Mon,  1 Apr 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964371; cv=none; b=b28wUKnOQmukoVyVhEBe2tFM9ebfHt4rXKCfcn390S0V7UFhMlZ7CTpxqztJQhHzaWBhHSdNY14ZRH4Cz1L0wLDJ3CErCJOn+HBec5Ir4HjtvXUhUQQh9e0fFfRNk2DJF2HrfAEn8d1rRyrVzGdiThfGHX8mj5CgFUPf4UsBhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964371; c=relaxed/simple;
	bh=ML5YxYXPHff1UumknHXnooE2oeK6nfYWlBGXQBXshNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4ksJTse+Vjvrhi3z1DfgJua/yJnmf+S/+F2zud0H76PDpMrdlVuoCD2kGVqpSTP9D378dVTVKyFb8AXoLb1CyAF9RZS+NByxPU5OFiZUdR4F30Vbu9bgP61llhE8gzYG2ZyOgVSvB0gpyNysit81U9oYVq9LfcbHzvCksYRFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M7E2AIle; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4316AOuT028497;
	Mon, 1 Apr 2024 09:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SAeVAavthNNggLoWOEpge87neMubWboMAtMmvluqOQA=; b=M7
	E2AIle9aWJIeRxHb3ShlXkRym3qyGyHdCa8PRdDMKBo09BwD62GY3+rOeirDKvi4
	I8RImDKZsfTmVBbJarYL8Cmb2mwdUVAu3QkYhaPFiqRn9exZxsGz/7CsnHcpfJPx
	lgCCG/tH2zhEiScsNp9n4O7MPIFlOYyND35Se8ATIlwI1cj0XYxIS/Uo9ur3f0qZ
	t2vrZNJOCEV8Uz8ynHUjdLeNpxXoye1ZghJRF67QgRxZyK5kE4ote3dKUii1XcOj
	5GsXmFfFqMgyfaabA1IxaRiuqTiFfaHjCWP+ZVBMkdd1FEjtf1Z8tcrrbGznJWK2
	U7WJS1F2r+LVv54uSSow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7qcvgcm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 09:39:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4319dFjm019474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 09:39:15 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 02:39:08 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>,
        Fenglin Wu
	<quic_fenglinw@quicinc.com>
Subject: [PATCH v6 RESEND 3/4] arm64: dts: qcom: add base AIM300 dtsi
Date: Mon, 1 Apr 2024 17:38:42 +0800
Message-ID: <20240401093843.2591147-4-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: x2z26rovLepL_-9b6GGej6U7ZLrHbyM_
X-Proofpoint-GUID: x2z26rovLepL_-9b6GGej6U7ZLrHbyM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010068

AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
chip etc.
Here is a diagram of AIM300 SoM:
          +----------------------------------------+
          |AIM300 SoM                              |
          |                                        |
          |                           +-----+      |
          |                      |--->| UFS |      |
          |                      |    +-----+      |
          |                      |                 |
          |                      |                 |
     3.7v |  +-----------------+ |    +---------+  |
  ---------->|       PMIC      |----->| QCS8550 |  |
          |  +-----------------+      +---------+  |
          |                      |                 |
          |                      |                 |
          |                      |    +-----+      |
          |                      |--->| ... |      |
          |                           +-----+      |
          |                                        |
          +----------------------------------------+

Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 345 +++++++++++++++++++
 1 file changed, 345 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
new file mode 100644
index 000000000000..43dde67df136
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "qcs8550.dtsi"
+#include "pm8550.dtsi"
+#include "pm8550b.dtsi"
+#define PMK8550VE_SID 5
+#include "pm8550ve.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmk8550.dtsi"
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
+		vdd-l2-l13-l14-supply = <&vreg_bob1>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
+		vdd-l6-l7-supply = <&vreg_bob1>;
+		vdd-l8-l9-supply = <&vreg_bob1>;
+		vdd-l11-supply = <&vreg_s4g_1p25>;
+		vdd-l12-supply = <&vreg_s6g_1p86>;
+		vdd-l15-supply = <&vreg_s6g_1p86>;
+		vdd-l17-supply = <&vreg_bob2>;
+
+		vreg_bob1: bob1 {
+			regulator-name = "vreg_bob1";
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob2: bob2 {
+			regulator-name = "vreg_bob2";
+			regulator-min-microvolt = <2720000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1b_1p8: ldo1 {
+			regulator-name = "vreg_l1b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-name = "vreg_l2b_3p0";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b_3p1: ldo5 {
+			regulator-name = "vreg_l5b_3p1";
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p8: ldo6 {
+			regulator-name = "vreg_l6b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_1p8: ldo7 {
+			regulator-name = "vreg_l7b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_1p8: ldo8 {
+			regulator-name = "vreg_l8b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_2p9: ldo9 {
+			regulator-name = "vreg_l9b_2p9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b_1p2: ldo11 {
+			regulator-name = "vreg_l11b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_1p8: ldo12 {
+			regulator-name = "vreg_l12b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b_3p0: ldo13 {
+			regulator-name = "vreg_l13b_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b_3p2: ldo14 {
+			regulator-name = "vreg_l14b_3p2";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_1p8: ldo15 {
+			regulator-name = "vreg_l15b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b_2p8: ldo16 {
+			regulator-name = "vreg_l16b_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_2p5: ldo17 {
+			regulator-name = "vreg_l17b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-l1-supply = <&vreg_s4g_1p25>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+
+		vreg_l3c_0p9: ldo3 {
+			regulator-name = "vreg_l3c_0p9";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+
+		vreg_l1d_0p88: ldo1 {
+			regulator-name = "vreg_l1d_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+
+		vreg_s4e_0p95: smps4 {
+			regulator-name = "vreg_s4e_0p95";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5e_1p08: smps5 {
+			regulator-name = "vreg_s5e_1p08";
+			regulator-min-microvolt = <1010000>;
+			regulator-max-microvolt = <1120000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1e_0p88: ldo1 {
+			regulator-name = "vreg_l1e_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2e_0p9: ldo2 {
+			regulator-name = "vreg_l2e_0p9";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3e_1p2: ldo3 {
+			regulator-name = "vreg_l3e_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		vdd-l1-supply = <&vreg_s4e_0p95>;
+		vdd-l2-supply = <&vreg_s4e_0p95>;
+		vdd-l3-supply = <&vreg_s4e_0p95>;
+
+		vreg_s4f_0p5: smps4 {
+			regulator-name = "vreg_s4f_0p5";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1f_0p9: ldo1 {
+			regulator-name = "vreg_l1f_0p9";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_0p88: ldo2 {
+			regulator-name = "vreg_l2f_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_0p88: ldo3 {
+			regulator-name = "vreg_l3f_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-5 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "g";
+		vdd-l1-supply = <&vreg_s4g_1p25>;
+		vdd-l2-supply = <&vreg_s4g_1p25>;
+		vdd-l3-supply = <&vreg_s4g_1p25>;
+
+		vreg_s1g_1p25: smps1 {
+			regulator-name = "vreg_s1g_1p25";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2g_0p85: smps2 {
+			regulator-name = "vreg_s2g_0p85";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1036000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s3g_0p8: smps3 {
+			regulator-name = "vreg_s3g_0p8";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s4g_1p25: smps4 {
+			regulator-name = "vreg_s4g_1p25";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1408000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5g_0p85: smps5 {
+			regulator-name = "vreg_s5g_0p85";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s6g_1p86: smps6 {
+			regulator-name = "vreg_s6g_1p86";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1g_1p2: ldo1 {
+			regulator-name = "vreg_l1g_1p2";
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1272000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2g_1p2: ldo2 {
+			regulator-name = "vreg_l2g_1p2";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3g_1p2: ldo3 {
+			regulator-name = "vreg_l3g_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l17b_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l1g_1p2>;
+	vccq-max-microamp = <1200000>;
+	vdd-hba-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l1d_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
-- 
2.25.1


