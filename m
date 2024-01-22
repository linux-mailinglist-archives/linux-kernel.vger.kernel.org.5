Return-Path: <linux-kernel+bounces-32369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAF835ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705BFB23A22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB11B268;
	Mon, 22 Jan 2024 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ONNWt63M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6C1864C;
	Mon, 22 Jan 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903081; cv=none; b=BNeIDvj3ks2F7jhN0fsDfENWHNEf1DO7puZGmrmC3rMdlK3dEf3+htQYIvvGI+yNHKQYHQ+pP4LoXbvDt7najJzWnVXsWW7zNERLzn4zuVBsD57nn4vIYuHPBIUyc6L4CFA7xX2wcsXVYZh7fF6+OeZ20QeJEwCvv/cjlmDhki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903081; c=relaxed/simple;
	bh=drTQjk5SXvzlpRgATUWn6h+fGxohCviAW7muDn3SxwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bpRKOcdEkgkdxB823mMa62WCE40tXe3z3gV0hMctX4u0MQkzbX0/oqP6Tpv31Afdvd28F5L783XT9xr+8xuOnZECZAdPf4oYMjewUHTjrt9MClFpaYdkr+PkJwJKOoljahSH1isisaDTIc5jk168Zlhc0HYWc10pTePrCliwkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ONNWt63M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M4s3Cl010816;
	Mon, 22 Jan 2024 05:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=s2+sDJ8ohsiHrSML3SgdYuCkn53uK9uIY1xBtbf1JY4
	=; b=ONNWt63MzKK7j6HrvbY8tv0hmHyUjBRWkv5BSptqvjorXUocIi4Be1RvkXf
	tlWmb9C/98Z6TS92HcxsnKywVWdm8gFZb6/AygL2CJUH2FH3x2tBx3YTCMuRPAbp
	0Mm6HKNuMWOw7aVM353V4iv9a0QZ9i0gRIatOm6lh/FRDnFuwrQ3xeAfPe7Ahzvx
	igQQGDU1Ra3oqByuBTVVQGfJXdB5LoQs+CyjnLH2Vn+ho6G0pHGjTxa1MqQfkZ1H
	aeVPvc68ALFiN6N7dafM55rvNDDMOcT/yB4oeoX84ubDiOusjpsG2jSslORf/yGj
	TRtqoCKW+t5+Zj2uhhzCKvHen8g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr54wu36b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vlJs015094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:47 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:41 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:27:03 +0530
Subject: [PATCH v4 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-7-19fa30019770@quicinc.com>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
In-Reply-To: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=1424;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=drTQjk5SXvzlpRgATUWn6h+fGxohCviAW7muDn3SxwM=;
 b=XouM/TTUB4b2VyYbJJA5qqL1zV1HbGXSGw6ETpOkHVzlNOHwkOBM7AnncuPFqru+JQaDqSMPy
 d2mI8aS+Qq+ArMn8dBxHhc6efcQzq5A6FV0148Bi7d070cbP8R+vSw8
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RUkdNsqFyVTlbk4BwgxG1fLAqPHrY7R6
X-Proofpoint-GUID: RUkdNsqFyVTlbk4BwgxG1fLAqPHrY7R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=751 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

Describe the NSS clock controller node and it's relevant external
clocks.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 42e2e48b2bc3..1e280e045b00 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -15,6 +15,18 @@ / {
 	#size-cells = <2>;
 
 	clocks {
+		cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			#clock-cells = <0>;
+		};
+
+		cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <300000000>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -473,6 +485,22 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq5332-nsscc";
+			reg = <0x39b00000 0x80000>;
+			clocks = <&cmn_pll_nss_200m_clk>,
+				 <&cmn_pll_nss_300m_clk>,
+				 <&gcc GPLL0_OUT_AUX>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&xo_board>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.34.1


