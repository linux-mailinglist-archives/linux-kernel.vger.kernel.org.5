Return-Path: <linux-kernel+bounces-22078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A672C8298D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5489C282C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E34878D;
	Wed, 10 Jan 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nyC2y8k0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F74482DD;
	Wed, 10 Jan 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAqgW5031101;
	Wed, 10 Jan 2024 11:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TjRBMNfswm524izutJw5ZI9gGCBe++NtHluaKvSBbm0=; b=ny
	C2y8k09TadAO+aU8GP1CzxZjxil6YWb6Q0OmIL4vgDn4G46sAzNOtwGF2SRnkBT9
	s1+PBPMC5XVy0eHSuhDvOgrOAl/b2mZkW0pr9zBSDHu6mOtBmWuomGqiYupiAdey
	gbwXZ6J7Bp9Lf/d7UHauIryYu2eC/pTunjMqbFK1E9yfw/UyzG+jPKl3c/43oznF
	+heY5Eyv51aMVMZ9zWY0ATpRDuOUvycysVzawFfN8RcW0TQgCZ4vLbwuJE9MJZAJ
	TGYSncesUQGYbvMCvnROspNPVvZfSdLveNgjR2AiMCMUUk7iDFGy2sNnu75HO7o/
	lmWzkxH2hOmx0pdFVQIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqyr32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLTSt023743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:29 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:25 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Date: Wed, 10 Jan 2024 19:20:56 +0800
Message-ID: <20240110112059.2498-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110112059.2498-1-quic_luoj@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d6Y5r1QnF0CWmCTLZzbPZh83KTm23Mv8
X-Proofpoint-ORIG-GUID: d6Y5r1QnF0CWmCTLZzbPZh83KTm23Mv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=798 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

Add the MDIO device tree of ipq5332.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index bc89480820cb..e6c780e69d6e 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -214,6 +214,38 @@ serial_0_pins: serial0-state {
 				drive-strength = <8>;
 				bias-pull-up;
 			};
+
+			mdio0_pins: mdio0-state {
+				mux_0 {
+					pins = "gpio25";
+					function = "mdc0";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				mux_1 {
+					pins = "gpio26";
+					function = "mdio0";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
+			};
+
+			mdio1_pins: mdio1-state {
+				mux_0 {
+					pins = "gpio27";
+					function = "mdc1";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				mux_1 {
+					pins = "gpio28";
+					function = "mdio1";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -863,6 +895,18 @@ group0 {
 				};
 			};
 		};
+
+		mdio: mdio@90000 {
+			compatible = "qcom,ipq4019-mdio";
+			reg = <0x90000 0x64>;
+			pinctrl-0 = <&mdio1_pins &mdio0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_MDIO_AHB_CLK>;
+			clock-names = "gcc_mdio_ahb_clk";
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.42.0


