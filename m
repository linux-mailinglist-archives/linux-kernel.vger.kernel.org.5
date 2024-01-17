Return-Path: <linux-kernel+bounces-29283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EC830C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7837D28464F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5724205;
	Wed, 17 Jan 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="laJT2/89"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC5249E5;
	Wed, 17 Jan 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512956; cv=none; b=fPRfuHohMFSuYzHWjmx8jQ7nDEEecem3tjAve1iwN/ML0e5k/gUgDzAfJe6AmZYnj/uS71pZ+gn5FCkLqUGTw5uUGr9DtOi5d+gaKxLUojXL/sMNUOf/Po/9FtjMTawjOZY2fAKYmLSQx6HC3YDJnF9OdRRPHV9yZRExaNtthWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512956; c=relaxed/simple;
	bh=Bl7cpZvHNCeRQRxJV5HheXrtoP53ATyOHPpBzKB+qsk=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Bv7cOF3WVtbYquxoYnHzKMTD1b8QFVsTFEuK1nO+/DW4VmXKiAhG8FrbRskrT4FoOJR3Slw7dRmNK6tfCEsVuTn4npCvaSmlNxIDe2PGNPntBJOfh3gQ4Z69/fCrG4ukYo7yoNWE/lykiEHQAPGld4YWk7Hl/UNQ4kIouWc6rkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=laJT2/89; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HGRXTj013249;
	Wed, 17 Jan 2024 17:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=wbGU6dH2vL5yDWtcqhS5irxCmsYg1kzr7kU0fvyzb44=; b=la
	JT2/89FGhtJ/LepBu7pT0OxDFfTlqjPI4QhYpfIak+5JBzRhk9k2lIXsEqJOIgos
	JQ29D37ybdFxb0CQzvQo6s79Ls44tyqefQYUTisk1kz2HoAYIWxERWnZdaKAvHog
	iXSTFLlDjSu+0FZCBnAJ2F1BanZpWYbgKHThiwT0xAEca8eGW6Fyy+VpJBCS/qHp
	5J4kRjUCLD2OkODgEUoTdetMBqgNPmMU5XoSkVSo3OoMyHv9/djg7taMMsOxfhU6
	4Vh2fZ9Qa+1Rfb8NjZVMc07b/sHmoQ7AUYtmu+2H3ZGGLhxMFQGwprM9fIt2sv5F
	zyp4jQY2FxGtTlqLtWJA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpbav176q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HHZm7O011829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 17:35:48 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 09:35:43 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>
Subject: [RFC 6/7] arm64: dts: qcom: x1e80100: Enable cpufreq
Date: Wed, 17 Jan 2024 23:04:57 +0530
Message-ID: <20240117173458.2312669-7-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117173458.2312669-1-quic_sibis@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: uLVX98U71X0zeirJLc-tFa1_gANsn1YQ
X-Proofpoint-ORIG-GUID: uLVX98U71X0zeirJLc-tFa1_gANsn1YQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 mlxlogscore=758 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170127

Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index afdbd27f8346..6856a206f7fc 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -62,6 +62,7 @@ CPU0: cpu@0 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -79,6 +80,7 @@ CPU1: cpu@100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -90,6 +92,7 @@ CPU2: cpu@200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -101,6 +104,7 @@ CPU3: cpu@300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 0>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
@@ -112,6 +116,7 @@ CPU4: cpu@10000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
@@ -129,6 +134,7 @@ CPU5: cpu@10100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
@@ -140,6 +146,7 @@ CPU6: cpu@10200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
@@ -151,6 +158,7 @@ CPU7: cpu@10300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 1>;
 			next-level-cache = <&L2_1>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
@@ -162,6 +170,7 @@ CPU8: cpu@20000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD8>;
 			power-domain-names = "psci";
@@ -179,6 +188,7 @@ CPU9: cpu@20100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD9>;
 			power-domain-names = "psci";
@@ -190,6 +200,7 @@ CPU10: cpu@20200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD10>;
 			power-domain-names = "psci";
@@ -201,6 +212,7 @@ CPU11: cpu@20300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
+			clocks = <&scmi_dvfs 2>;
 			next-level-cache = <&L2_2>;
 			power-domains = <&CPU_PD11>;
 			power-domain-names = "psci";
@@ -303,6 +315,21 @@ scm: scm {
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


