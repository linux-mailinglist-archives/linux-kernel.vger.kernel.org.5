Return-Path: <linux-kernel+bounces-160152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6478B39E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE9D1C240A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5A148FE6;
	Fri, 26 Apr 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q74JgYHr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF314882C;
	Fri, 26 Apr 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141554; cv=none; b=hDX8qw8/2PvufzRPdQGA4Zn3yDYwCcu4QpW7hflmS+tY+8ouUaECkVRRJogN9zGYvTHtiPg3F+4nEdRS80eaqpR9mmqu/1JtYYL4FaH/9GYKcDOHRyhLZMKenXfgeZdLAiFY8miUktJwfVuViv9zHKNQDX5An5uaSa9RO8mUVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141554; c=relaxed/simple;
	bh=Z3nDJG7fCTy82fuOYodtARk7oULs+TYdyLaAGmmNPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ji02G0n9h189e/5VuNV7RFPt/gmxwx65NYk3WrUL3uNw76wpk4Ta6dHIBkZMxs3pt1Yfbjr+3vOnaMWU7uBu8k09fA7ODqZ76bJfZG33WGCR28oluWDMaQ+L6Lxmh2N7FA4tdN5G6aS10HKzbj25LNYCAiRW2GfI24tdjDHLSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q74JgYHr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5XDuR015769;
	Fri, 26 Apr 2024 14:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=ViztMvZulvwYyO8OXf7VGJPZ1Sycqe7tc030Pgq8FT0=; b=Q7
	4JgYHr27GBkQvVTGTD8FiA9hxBfDR5IMQ5QoalXTVrTJ9of2Gm7NymYC79NUuezc
	9ZjB9Hwzp4OxJ2fFuckqe8m/WOuS6Vrl9rW10pLEGvDr20sMap/OHcecr9gcOkqU
	tq+fV2dYBgO9VzLUlZStQQDURxJhhX1HWQwND0XzO522Z1F6tzG1JJfCdbhtvUs4
	PSsi91IWNtAHt2OTvj/Zul+PoRBSGpds/ANHAR4GM3wgkTr3MBfPmOk1dq9weqi8
	i5YFmtxfbFblpu25Ywtz37oc4RS3QJbtJSbLytlhSsWA+hOpnpFRxTTX5S1suUi6
	cE94z99OAkKtcTAKLC4A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35et34d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:25:44 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43QEPeQp032340;
	Fri, 26 Apr 2024 14:25:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6smqeqs-1;
	Fri, 26 Apr 2024 14:25:40 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QEPdX4032335;
	Fri, 26 Apr 2024 14:25:39 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vvalluru-hyd.qualcomm.com [10.213.106.176])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43QEPdp2032334;
	Fri, 26 Apr 2024 14:25:39 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 482827)
	id C591D52D386; Fri, 26 Apr 2024 19:55:37 +0530 (+0530)
From: Prahlad Valluru <quic_vvalluru@quicinc.com>
To: robh@kernel.org
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_abhinavk@quicinc.com, quic_nankam@quicinc.com,
        quic_vvalluru@quicinc.com
Subject: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: enable hdmi bridge
Date: Fri, 26 Apr 2024 19:54:42 +0530
Message-Id: <20240426142442.7769-1-quic_vvalluru@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <171405653305.2527744.3813895380659072690.robh@kernel.org>
References: <171405653305.2527744.3813895380659072690.robh@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oN0ziM9wCBJC8ZbKXJj3ROKtdO0cggJh
X-Proofpoint-ORIG-GUID: oN0ziM9wCBJC8ZbKXJj3ROKtdO0cggJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=952
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Venkata Prahlad Valluru <quic_vvalluru@quicinc.com>

Enable lt9611uxc bridge for qcs6490 rb3 gen2 platform.

Signed-off-by: Prahlad Valluru <quic_vvalluru@quicinc.com>
---
v2: Addressed dtschema errors
	- Fixed lt9611-irq
	- vdd-supply error to be ignored, as it is connected to
	  input supply directly, on rb3gen2
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a085ff5b5fb2..c14d4a4bb3ce 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -51,6 +51,18 @@
 			};
 		};
 	};
+	
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
 
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
@@ -530,6 +542,45 @@
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+
+		interrupts-extended = <&tlmm 24 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
+
+		vcc-supply = <&vreg_l11c_2p8>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -602,6 +653,21 @@
 	status = "okay";
 };
 
+&mdss_dsi {
+        vdda-supply = <&vreg_l6b_1p2>;
+        status = "okay";
+};
+
+&mdss_dsi0_out {
+        remote-endpoint = <&lt9611_a>;
+        data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi_phy {
+        vdds-supply = <&vreg_l10c_0p88>;
+        status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -711,3 +777,23 @@
 	function = "gpio";
 	bias-disable;
 };
+
+&pm7250b_gpios {
+        lt9611_rst_pin: lt9611-rst-state {
+                pins = "gpio2";
+                function = "normal";
+
+                output-high;
+                input-disable;
+                power-source = <0>;
+        };
+};
+
+&tlmm {
+        lt9611_irq_pin: lt9611-irq-state {
+                pins = "gpio24";
+                function = "gpio";
+                drive-strength = <8>;
+                bias-disable;
+        };
+};
-- 
2.17.1


