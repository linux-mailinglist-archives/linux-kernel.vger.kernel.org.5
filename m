Return-Path: <linux-kernel+bounces-107287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E887FA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889091C21BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FC7D085;
	Tue, 19 Mar 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KIDGlXNs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9065190;
	Tue, 19 Mar 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839448; cv=none; b=nSo4zNoVHCw6IAovlLS3xNmFrewMhzS7MOTWlt4pBL3DdTGZ/CznEXJylv5Nvg1RfTV7UT0HLuzQRxU04i5kzgPl+sKM9ztMZ653XuonrAHKx6frEu1wuQ7g2ed3yPGJgaHRlzS1dvjFN3I+BQDVm7JTQR0B831B/az+3pUOC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839448; c=relaxed/simple;
	bh=lGvXObgBl86kRoguBVhCttmY90cgyYAJ9yZZaujStuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrfB89wm4Y5hglTpgM5mEec26sTAEsWpsg/YhaUgENmeQkBmu3dYp9DFJ5nVPVl+QoQlBhODZG+fhTTkoo80SN7GFva3BxUqrDq3jL6Lh+UnyBGkDGPqNG8nij8VtEwCYiwerjPlFFwNRl39dUbEOecCk3A1fCU+gZTfN6uzz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KIDGlXNs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J8p8jH006973;
	Tue, 19 Mar 2024 09:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=73OHWac7H1Kr+104Ex890zSmfv+QJdXJD0ui+snnqpo=; b=KI
	DGlXNsuHrmmcoqek4mT19dyLvAFrAVpv8YeFLA4jfV8CsThV7dKHbM6+5sUmYySF
	DOuTD9hYfYKxYOeqmU6ALUAVM/iSwwPOkB0u4QVdKbYr6TgMNCCITXbHSeVhEFD5
	/IRWcmMFEz7NzS53PZPkW5XZt4gJwl7lohq2OLgRaWLq2uvQr4VuQcybsB3XINQ6
	KmFNXAXmUG9bcpo0mc3GUHORRDR3LwKlDO/+g+2cALIpIh2Bek0K5OJ5gtVZvXmk
	KplzqP7piBThhGgSRaQ/Ly8sxl3Y+a+a+pRFKDCo+SNZcB+hVnmo2i1InfHu5KDy
	PACsWWJ8tBAvrkIP8wzA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy7hy01q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J9AhDQ003781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:43 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:10:39 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>,
        "Amrit
 Anand" <quic_amrianan@quicinc.com>
Subject: [PATCH 1/3] arm64: dts: qcom: qdu1000: Add USB3 and PHY support
Date: Tue, 19 Mar 2024 14:40:18 +0530
Message-ID: <20240319091020.15137-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5_LQI1hqOQ3iLehBv0PTglz4XQCsP2qy
X-Proofpoint-GUID: 5_LQI1hqOQ3iLehBv0PTglz4XQCsP2qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190070

Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
SNPS HS PHY on QDU1000/QRU1000 SoCs. Also add required pins for USB,
so that the interface can work reliably.

Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 133 ++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 832f472c4b7a..de1228d96fab 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -913,6 +915,124 @@ opp-384000000 {
 			};
 		};

+		usb_1_hsphy: phy@88e3000 {
+			compatible = "qcom,qdu1000-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg = <0x0 0x088e3000 0x0 0x120>;
+			#phy-cells = <0>;
+
+			clocks =<&gcc GCC_USB2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_qmpphy: phy@88e5000 {
+			compatible = "qcom,qdu1000-qmp-usb3-uni-phy";
+			reg = <0x0 0x088e5000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&gcc GCC_USB2_CLKREF_EN>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb3_uni_phy_pipe_clk_src";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,qdu1000-dwc3", "qcom,dwc3";
+			reg = <0 0x0a6f8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 8 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 9 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			interconnects = <&system_noc MASTER_USB3 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &system_noc SLAVE_USB3_0 QCOM_ICC_TAG_ALWAYS>;
+
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
+
+			status = "disabled";
+
+			usb_1_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a600000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+
+				iommus = <&apps_smmu 0xc0 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_1_hsphy>,
+				       <&usb_1_qmpphy>;
+				phy-names = "usb2-phy",
+					    "usb3-phy";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss: endpoint {
+						};
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
 			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
@@ -1221,6 +1341,19 @@ rclk-pins {
 					bias-pull-down;
 				};
 			};
+
+			usb_id_det_default: usb-id-det-default {
+				pins = "gpio42";
+				function = "gpio";
+				input-enable;
+				bias-pull-up;
+			};
+
+			usb_vbus_boost_default: usb-vbus-boost-default {
+				pins = "gpio43";
+				function = "gpio";
+				bias-pull-down;
+			};
 		};

 		sram@14680000 {
--
2.42.0


