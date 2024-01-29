Return-Path: <linux-kernel+bounces-42183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E88D83FD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F5F286127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD24EB54;
	Mon, 29 Jan 2024 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M9hPXb4l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9A43AB0;
	Mon, 29 Jan 2024 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505155; cv=none; b=rRiRUzVQ8nWctoJWM5764eMKny1dylFfh7EE+j0WQybIYqTWZiwlkqEh2z8Fp+2vSz/2NJxwptxejJdYiqdE1eaFaTdWh76v+W6qOTepHre/DbuCyac2PLWB+lsaN7EowTPsMek4ykmOn5CkV5xrXaeJY+XX18nvUPlsZyoSpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505155; c=relaxed/simple;
	bh=XFD1v+vcuwhVBXsT+MlEk4yQ5dlg3NlF8LNz+C9EYi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udtC+M+LALAgfsED0Ky+F6WbMRh6FoXtAxpA83z9B+xK4x/iNlkLXcJso+Z8La8C03VAa2WqCvl9gpdj/yJs8vhahxICj/nkuR3Fq5Qvtduz/qgegjZaxynKaytbnQrhaaFU9PvFUCF7Mn+VPTevab8R35w0OlkPjavKevsfTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M9hPXb4l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4tDNS009155;
	Mon, 29 Jan 2024 05:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=25NA5/eXk9TozDWwYZa/Sx7E/aSbmZkQk6b9eoS9sR8=; b=M9
	hPXb4lYCBQVbWXbkvrpM7gy+4uNV1/KPDo/SHuAkZcVy5T/8/iRkkux/A9NSUNbQ
	MgAc0ABwwLTxMZywxcmTY3kqBKSQ6+PZsOSNtrwuPcBW+GtXo07e8mpEFnGAImVL
	EGEmehZIe6y12HssecaiS1WTlxal+Z4m+buERv7wF8YPSGe9n0+EOCmoHCkOjDgd
	1bGrEXWNFA/PPWRvaiRReQoZk9S6Xr1o7sjEZlj5/JiRChYGgdTtZVWHGalAaE7F
	TYfxKEoCdtGfc5FbcuIOcEj5SyDql2z2sZJyiODLl4qrUYfjhRU0iw9puJXdjDSr
	HwkLcm6KNtbQTIARDGOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt272t9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:12:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5C6mY007353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:12:06 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:11:59 -0800
From: Devi Priya <quic_devipriy@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc node
Date: Mon, 29 Jan 2024 10:41:03 +0530
Message-ID: <20240129051104.1855487-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
References: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
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
X-Proofpoint-GUID: lWktXtu9V153fefPayEyhwX5DiNyEEl9
X-Proofpoint-ORIG-GUID: lWktXtu9V153fefPayEyhwX5DiNyEEl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=909
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290035

Add a node for the nss clock controller found on ipq9574 based devices.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Dropped clock-names & moved xo clock to the start of the list

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 5f83ee42a719..20e51a5c7a87 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -10,6 +10,8 @@
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
+#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -18,6 +20,24 @@ / {
 	#size-cells = <2>;
 
 	clocks {
+		bias_pll_cc_clk: bias-pll-cc-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <1200000000>;
+			#clock-cells = <0>;
+		};
+
+		bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <461500000>;
+			#clock-cells = <0>;
+		};
+
+		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <353000000>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -741,6 +761,25 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq9574-nsscc";
+			reg = <0x39b00000 0x80000>;
+			clocks = <&xo_board_clk>,
+				 <&bias_pll_cc_clk>,
+				 <&bias_pll_nss_noc_clk>,
+				 <&bias_pll_ubi_nc_clk>,
+				 <&gcc GPLL0_OUT_AUX>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
 	};
 
 	thermal-zones {
-- 
2.34.1


