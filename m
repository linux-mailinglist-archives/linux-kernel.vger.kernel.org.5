Return-Path: <linux-kernel+bounces-156704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E18B0710
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DDB25381
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736C1591EE;
	Wed, 24 Apr 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MC9VT60B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856515958C;
	Wed, 24 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953770; cv=none; b=N4s94sQkXYdJx4YO95CVIaKo3ASk3gyM6BwxWAnguAkcR0IvgmniaY0qzibkORXicx4oUXUalOpK3U/wxby72u3z9xtVQVpcjl1Hrk/q2OO2SEjnHETchC+cNf/5FsSnbmJMf5oYXQR6gJ/GyNUL75ap9pzyQrc18TzwJbSDyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953770; c=relaxed/simple;
	bh=OVWgPrMMnPIiQU3u6VeXYQMeDlIrji18S8CArM+0uss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCdPL2cMk6MhYLTLvQztPKbUYbHqaILqUUUsjWlkNfD5Wuc6Vax/kZDOTSnrmacLJ92wa8OVLF070JjvcqlMLpINfoaZz2WnYDfY4IhJxkh0TeXnBdHDIgNyM3Dx33gc4dxbSOwuYvJtbtKKLRXPM6RnONkJsYTlLTkkIcPeMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MC9VT60B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OABiMa007193;
	Wed, 24 Apr 2024 10:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bVYLFNUdU+ZM+2J2LuHg+iZILtptZZzyt9dEeiXp2jM=; b=MC
	9VT60BGU068cbaQLxg993cl3tqEEf9I29/oPihj8SNnDh+mifDxnddXb2EnF4gM1
	LHkx3xpXNatmyirZIE5bCAViAlnr7KTRHNpOEy1TJFwQdzXx7HWlPvZHdikO62p1
	O9k5Tpffgg8LD1XYeZ1nkTapkJhXAbNjcYuOCKulK8MoLQ1p6B6eZ66QANtHN0X9
	hemO0VHWBe0tsLFffEV9hiYDhHVhW7NcdJCNYXTkj7BV1ukFURBNgnkLbo6texIU
	a/Q9UjnfUw9lyLJMW6L961dOXsV1L0eRE8psjll3FTRzk0Fi5zN6uz85/aAL+MyP
	wwRa5qRWeqp9HkhRHmRg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pgh0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OAG4Q1030726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:04 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 03:16:01 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sm4450: Add cpufreq support
Date: Wed, 24 Apr 2024 18:15:02 +0800
Message-ID: <20240424101503.635364-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424101503.635364-1-quic_tengfan@quicinc.com>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-GUID: g2dprFQeEQVGCgXLK4xfDurwbpaZmzk0
X-Proofpoint-ORIG-GUID: g2dprFQeEQVGCgXLK4xfDurwbpaZmzk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240042

Add a description of a SM4450 cpufreq-epss controller and references to
it from CPU nodes.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 603c962661cc..92badfd5b0e1 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -29,6 +29,14 @@ sleep_clk: sleep-clk {
 			clock-frequency = <32000>;
 			#clock-cells = <0>;
 		};
+
+		bi_tcxo_div2: bi-tcxo-div2-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-mult = <1>;
+			clock-div = <2>;
+		};
 	};
 
 	cpus {
@@ -43,6 +51,7 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_0: l2-cache {
@@ -67,6 +76,7 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_100: l2-cache {
@@ -85,6 +95,7 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_200: l2-cache {
@@ -103,6 +114,7 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_300: l2-cache {
@@ -121,6 +133,7 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_400: l2-cache {
@@ -139,6 +152,7 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 
 			L2_500: l2-cache {
@@ -157,6 +171,7 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 
 			L2_600: l2-cache {
@@ -175,6 +190,7 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 
 			L2_700: l2-cache {
@@ -526,6 +542,19 @@ rpmhcc: clock-controller {
 			};
 		};
 
+		cpufreq_hw: cpufreq@17d91000 {
+			compatible = "qcom,sm4450-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0 0x17d91000 0 0x1000>,
+			      <0 0x17d92000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1";
+			clocks = <&bi_tcxo_div2>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1";
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.25.1


