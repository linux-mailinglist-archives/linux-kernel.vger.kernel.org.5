Return-Path: <linux-kernel+bounces-122728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E205688FC26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BFA1C28EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169747BB14;
	Thu, 28 Mar 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aj+N7An7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6C7D3E0;
	Thu, 28 Mar 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619506; cv=none; b=c1y+ZolgmtmkOeAOlhqbIuxLv5e0Pj5zJEl7TWf1j/JbOra7ybjuwQQ0is2ymrrxr09OqYv3At24x7REWAGfZtHMPCyQ2YW4W3n1BhDWPXt/nJyHmSD0GmBFMjgSl9APpEykVbkuJqeQzqPIUCfQ5jKxBWQLTA2N0IABZ/loQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619506; c=relaxed/simple;
	bh=mvX2TTWVzF+pn9gnFd8blKswbh+CVDtrnokKxlgnPYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arD3JEsQ4vPViMwNs7FSMS5kHExX/dp/PoAZjFN4Sg6xVvIB3/CLjWxjA3sAwHKiPjxDxg0J4hpkKs5t+GCNwOIswmT5HBgmAS011vNroKCU5Qqgm11hYbAIhHQkDUctoZnKSEKW8q9HZUpeuF5Umh5KpcKlHAPhItV5w9b6VFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aj+N7An7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9ocV4016446;
	Thu, 28 Mar 2024 09:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=YRRInQa+WEtcn8JTxODIQRzP+87mHRclTBBo66zccgw=; b=aj
	+N7An74AU5MbyMmv+vBOC3t8MWld75r9pbZ0Rv+3+nJHDZBSrhVG2uxf6SdXePBi
	N351O0pATw6tQkxmhWcH0u2T5MIGaS1ByxaMEBlpuoOXY3YZGH9h7bi/1dY9KmbA
	gSp0N2QHuzRSgypiMtJ1wtRYxaTKGu/aGhqLQolPP6RujIKWbKH4/Cp9awzz8DT4
	uTLghlxx20gDl6axOVWGtGklb/BAbt3QrbKkIU++r0k+uN9lLv/VGYpjkQ0oo7qq
	x4TUdsfq4q38xZDOEtTr/135e3ViQ+5hBGHuvnypszUdqy3fAK+3yOW/lw0cYuhT
	MSX25DVk5W2iWDP5dH3Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wju4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9paI8012602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:36 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 02:51:31 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
Date: Thu, 28 Mar 2024 15:20:44 +0530
Message-ID: <20240328095044.2926125-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328095044.2926125-1-quic_sibis@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: 7h2mzXqbqIKeuD9wafPB4pRANQuAQJP5
X-Proofpoint-ORIG-GUID: 7h2mzXqbqIKeuD9wafPB4pRANQuAQJP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=949 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280066

Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 4e0ec859ed61..d1d232cd1f25 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -68,6 +68,7 @@ CPU0: cpu@0 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -85,6 +86,7 @@ CPU1: cpu@100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -96,6 +98,7 @@ CPU2: cpu@200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -107,6 +110,7 @@ CPU3: cpu@300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
@@ -118,6 +122,7 @@ CPU4: cpu@10000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
@@ -135,6 +140,7 @@ CPU5: cpu@10100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
@@ -146,6 +152,7 @@ CPU6: cpu@10200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
@@ -157,6 +164,7 @@ CPU7: cpu@10300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
@@ -168,6 +176,7 @@ CPU8: cpu@20000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD8>;
 			power-domain-names = "psci";
@@ -185,6 +194,7 @@ CPU9: cpu@20100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD9>;
 			power-domain-names = "psci";
@@ -196,6 +206,7 @@ CPU10: cpu@20200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD10>;
 			power-domain-names = "psci";
@@ -207,6 +218,7 @@ CPU11: cpu@20300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD11>;
 			power-domain-names = "psci";
@@ -309,6 +321,21 @@ scm: scm {
 			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
+
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpu_scp_lpri0>, <&cpu_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_dvfs: protocol@13 {
+				reg = <0x13>;
+				#clock-cells = <1>;
+			};
+		};
 	};
 
 	clk_virt: interconnect-0 {
-- 
2.34.1


