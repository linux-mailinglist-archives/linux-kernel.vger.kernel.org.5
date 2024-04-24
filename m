Return-Path: <linux-kernel+bounces-156705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5748B0715
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B96B25D12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018C15AAB6;
	Wed, 24 Apr 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SiO436Eg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3C15A489;
	Wed, 24 Apr 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953775; cv=none; b=jWJwiZ3C7sicB7E3ZxuwhEvpaPfcYWMrI37fRnq0iQXsdNXMIRfBebRxMvhhj+UQDdgwDmdiDdjz28/IrnMoqLnDCZWIXp/7jffnEA3IhmkJtCfhjhdbV0JYD/+1Z0FOwTI7VKt7qE4XEmXBvZXYGYqLxMUWaezmRuriB0uUJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953775; c=relaxed/simple;
	bh=nCwO0FPcctgEwR/kASD6yruAySW0u2UROcCYLqegD6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE7vN5RswKw877Q+BdrMR//cdMRLG+fLUfcecl4hEkhFJb+bqIR2X+/ImYo+q9A7sYTkfQfpzlTS7hO5+Zv61mf4nhDarNbndHjTrj6xkZcbK5xKX2v8ZS0T37CHq8oWHQTRJ7hi8diu148u3uQqXqxcvSinwwamEoaEbC0B3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SiO436Eg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O7fsk1019872;
	Wed, 24 Apr 2024 10:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ZmFRAVNzWh+mA1k4zIBq21it4dHyx5doGjk6CM4mhWQ=; b=Si
	O436EgecEA0pEAFHUvBsEPKYZT5/K+mWnNegfAkpUEhchbK9IvPzpyu9l2V9WAmn
	OywKNb6JuYwh5KF5Ww32y2GPk3xq+sGRrKflWRRTMwB5ebFy/3BYWSWy2MRmcXQL
	6D+8qes34habSy0DvUDg57VnFHLVDer6Ie7qznS4GwF/DMjGG/y17Bdc0LPc6EwB
	8IUsTyAJIW1ukco72wNSO2s/xL0d58U+q2S5fYs038F2L5apDKz9NdhK4pLwJLac
	lcDxbWS6N/TSJ6oaGygkbgdba71ILRp3be+3NUKCK7YSg0lmuoiHkUzADA2i/WCK
	tLy9l8LrhIQbBxdmtWRQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fggsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OAG7o0007349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 10:16:07 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 03:16:04 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <manivannan.sadhasivam@linaro.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sm4450: Supply clock from cpufreq node to CPUs
Date: Wed, 24 Apr 2024 18:15:03 +0800
Message-ID: <20240424101503.635364-4-quic_tengfan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mrDe4N4t4uplIYZMDcMQjb4ekoGdzmty
X-Proofpoint-GUID: mrDe4N4t4uplIYZMDcMQjb4ekoGdzmty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=989
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240042

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
clocks to the CPU cores. But this relationship is not represented in DTS
so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 92badfd5b0e1..8d75c4f9731c 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -47,6 +47,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
@@ -72,6 +73,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD0>;
@@ -91,6 +93,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD0>;
@@ -110,6 +113,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD0>;
@@ -129,6 +133,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD0>;
@@ -148,6 +153,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD0>;
@@ -167,6 +173,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a78";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD0>;
@@ -186,6 +193,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a78";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD0>;
-- 
2.25.1


