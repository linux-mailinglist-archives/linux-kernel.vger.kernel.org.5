Return-Path: <linux-kernel+bounces-162676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4307A8B5ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EEB1C216DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4988563C;
	Mon, 29 Apr 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WkY1JcKa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC58527B;
	Mon, 29 Apr 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407677; cv=none; b=lPmjKWcuHbyF6iAKtIgQKgn3RNdZVOQR504G8oSiy2jrUkRoAZa0o8O6qmuJQKPlmurVlEG6AiJdLZEzctFGthvFph0pTqZD+8NsM2n3tumYi/pWNYJdxlgiGD26rTzVujEQQIENtRC2roU6KlOwGO+MAGdhEuBv9PUnUzu3dDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407677; c=relaxed/simple;
	bh=BJnIv1DpUlOAm3uUdON/hwBbK3NHx46WC+YwG2mcP3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGIWpstWLgcCOZRM0it3QyaGHMsRdX3Me9hfGHcXKMid0HcA/GVgqge5fSOZJapppAhCdCHbtvxLO5K6/THXPYSj2beZeqIfKJkkt5DZbLVoOZvUAsjZKvfaN91Lqxd94hIr8SmOQbIe5gyzU7mevdiQeE9htFGW232aAVZPbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WkY1JcKa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TCmd7q012911;
	Mon, 29 Apr 2024 16:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UWwlQqoDNh8WALwZk4WVoviquNS6upXFaFzaQztjFHQ=; b=Wk
	Y1JcKa3Xg9LPU5MNXIVC3GImaTuCvoR1LutFHEoQxyB49sJpZxSv86aNtY/IlzcZ
	RlDmUGAqhdflpnvyEIG5mPupLI81kzAspEHhHljHF1hXNY+/ph3pQhBC1+9J0/vn
	KQYIV8OPtDdstpYW0/pvNrcvWVE8Io7Sl5YKWbQFJeGEYzdqzp5BxyIvrR0FX2q1
	7GMpiIYzO9XAfb/+1jImIlAz+fPCflpauda+bO8N71fIQ0XuOXy/BS1F+j/EWJqq
	SXfIRGNCKcg6sdm9T7emjg4ukJ1KK7Ajez5aGL65jClSpyaCaQmeIY7fZv5Lai4a
	8c8IRHi1vL9raRiqDazg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtbv89b1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TGL6K3021974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:06 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 09:21:02 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Johan Hovold
	<johan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v16 1/2] arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller
Date: Mon, 29 Apr 2024 21:50:47 +0530
Message-ID: <20240429162048.2133512-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6AntANpSWqIoJttieZaiwQfhYCXi-8kl
X-Proofpoint-GUID: 6AntANpSWqIoJttieZaiwQfhYCXi-8kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290104

Add USB and DWC3 node for tertiary port of SC8280 along with
Multiport interrupts and PHYs.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a5b194813079..dca8dc695f9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3337,6 +3337,88 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usb_2: usb@a4f8800 {
+			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
+			reg = <0 0x0a4f8800 0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
+				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
+
+			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MP_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 859 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 127 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 126 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 129 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 128 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 131 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 130 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 133 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 132 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "pwr_event_1", "pwr_event_2",
+					  "pwr_event_3", "pwr_event_4",
+					  "hs_phy_1",	 "hs_phy_2",
+					  "hs_phy_3",	 "hs_phy_4",
+					  "dp_hs_phy_1", "dm_hs_phy_1",
+					  "dp_hs_phy_2", "dm_hs_phy_2",
+					  "dp_hs_phy_3", "dm_hs_phy_3",
+					  "dp_hs_phy_4", "dm_hs_phy_4",
+					  "ss_phy_1",	 "ss_phy_2";
+
+			power-domains = <&gcc USB30_MP_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_MP_BCR>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			wakeup-source;
+
+			status = "disabled";
+
+			usb_2_dwc3: usb@a400000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a400000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x800 0x0>;
+				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+				       <&usb_2_hsphy2>,
+				       <&usb_2_hsphy3>;
+				phy-names = "usb2-0", "usb3-0",
+					    "usb2-1", "usb3-1",
+					    "usb2-2",
+					    "usb2-3";
+				dr_mode = "host";
+			};
+		};
+
 		usb_0: usb@a6f8800 {
 			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
-- 
2.34.1


