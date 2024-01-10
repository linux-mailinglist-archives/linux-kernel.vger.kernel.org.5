Return-Path: <linux-kernel+bounces-22075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301998298CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6B2286307
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B5481AA;
	Wed, 10 Jan 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ereBSzNk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F84776F;
	Wed, 10 Jan 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8oMxM005978;
	Wed, 10 Jan 2024 11:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0tgyZq56LbgeyLFmlrLBCFlUmFvbEsQ/fInNhqR0U8w=; b=er
	eBSzNkf7G8o3TkYX5F+4IcxujDmcvxlVE9sFKhD1o/WbAOC7IvZgUZH2LDcnL8En
	RqnPSCvRDwuOAp5oouv52Nwathf3JBCmTQ3twHX5nl6OCvy7n4uui5idTEDVzqsE
	dGxsdK5bcZSSmx0zp3TYbsFeFkjhQC0zQIVyHf6iWw18i2IX+v6GmBn/v7+EX3jZ
	+qB0IBYT+aze+eFWOpF4M8G5jbmhYi9oCVIaNJIHKdFiarxVm7JulzyId3XRuY98
	y6i+K93lrGp1iFWSYCbA8c2MsJV/6ho2DxTTITS+OMOmz+mVhga+BNcGidRvzyGe
	13MwKPAa1tj+sJmv8TlQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t2cqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLLxs026578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:21 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:16 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
Date: Wed, 10 Jan 2024 19:20:54 +0800
Message-ID: <20240110112059.2498-2-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _Wp0J2wSiZfHeZTx6zxGf0qmZxNgMmhN
X-Proofpoint-GUID: _Wp0J2wSiZfHeZTx6zxGf0qmZxNgMmhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

The PPE device tree node includes the PPE initialization configurations
and UNIPHY instance configuration.

Ther are 3 UNIPHYs(PCS) on the platform ipq9574, which register the
clock provider to output the clock for PPE port to work on the different
link speed.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 730 +++++++++++++++++++++++++-
 1 file changed, 724 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 810cda4a850f..5fa241e27c8b 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -775,16 +775,734 @@ nsscc: nsscc@39b00000 {
 				 <&bias_pll_nss_noc_clk>,
 				 <&bias_pll_ubi_nc_clk>,
 				 <&gcc_gpll0_out_aux>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&uniphys 0>,
+				 <&uniphys 1>,
+				 <&uniphys 2>,
+				 <&uniphys 3>,
+				 <&uniphys 4>,
+				 <&uniphys 5>,
 				 <&xo_board_clk>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		qcom_ppe: qcom-ppe@3a000000 {
+			compatible = "qcom,ipq9574-ppe";
+			reg = <0x3a000000 0xb00000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "okay";
+
+			clocks = <&gcc GCC_CMN_12GPLL_AHB_CLK>,
+				 <&gcc GCC_CMN_12GPLL_SYS_CLK>,
+				 <&gcc GCC_UNIPHY0_SYS_CLK>,
+				 <&gcc GCC_UNIPHY1_SYS_CLK>,
+				 <&gcc GCC_UNIPHY2_SYS_CLK>,
+				 <&gcc GCC_UNIPHY0_AHB_CLK>,
+				 <&gcc GCC_UNIPHY1_AHB_CLK>,
+				 <&gcc GCC_UNIPHY2_AHB_CLK>,
+				 <&gcc GCC_NSSCC_CLK>,
+				 <&gcc GCC_NSSNOC_NSSCC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_1_CLK>,
+				 <&nsscc NSS_CC_PPE_SWITCH_CLK>,
+				 <&nsscc NSS_CC_PPE_SWITCH_CFG_CLK>,
+				 <&nsscc NSS_CC_NSSNOC_PPE_CLK>,
+				 <&nsscc NSS_CC_NSSNOC_PPE_CFG_CLK>,
+				 <&nsscc NSS_CC_PPE_EDMA_CLK>,
+				 <&nsscc NSS_CC_PPE_EDMA_CFG_CLK>,
+				 <&nsscc NSS_CC_PPE_SWITCH_IPE_CLK>,
+				 <&nsscc NSS_CC_PPE_SWITCH_BTQ_CLK>,
+				 <&nsscc NSS_CC_PORT1_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT2_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT3_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT4_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT5_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT6_MAC_CLK>,
+				 <&nsscc NSS_CC_PORT1_RX_CLK>,
+				 <&nsscc NSS_CC_PORT1_TX_CLK>,
+				 <&nsscc NSS_CC_PORT2_RX_CLK>,
+				 <&nsscc NSS_CC_PORT2_TX_CLK>,
+				 <&nsscc NSS_CC_PORT3_RX_CLK>,
+				 <&nsscc NSS_CC_PORT3_TX_CLK>,
+				 <&nsscc NSS_CC_PORT4_RX_CLK>,
+				 <&nsscc NSS_CC_PORT4_TX_CLK>,
+				 <&nsscc NSS_CC_PORT5_RX_CLK>,
+				 <&nsscc NSS_CC_PORT5_TX_CLK>,
+				 <&nsscc NSS_CC_PORT6_RX_CLK>,
+				 <&nsscc NSS_CC_PORT6_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT3_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT3_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT4_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT4_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT5_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT5_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT6_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT6_TX_CLK>,
+				 <&nsscc NSS_CC_PORT5_RX_CLK_SRC>,
+				 <&nsscc NSS_CC_PORT5_TX_CLK_SRC>;
+			clock-names = "cmn_ahb",
+				      "cmn_sys",
+				      "uniphy0_sys",
+				      "uniphy1_sys",
+				      "uniphy2_sys",
+				      "uniphy0_ahb",
+				      "uniphy1_ahb",
+				      "uniphy2_ahb",
+				      "gcc_nsscc",
+				      "gcc_nssnoc_nsscc",
+				      "gcc_nssnoc_snoc",
+				      "gcc_nssnoc_snoc_1",
+				      "nss_ppe",
+				      "nss_ppe_cfg",
+				      "nssnoc_ppe",
+				      "nssnoc_ppe_cfg",
+				      "nss_edma",
+				      "nss_edma_cfg",
+				      "nss_ppe_ipe",
+				      "nss_ppe_btq",
+				      "port1_mac",
+				      "port2_mac",
+				      "port3_mac",
+				      "port4_mac",
+				      "port5_mac",
+				      "port6_mac",
+				      "nss_port1_rx",
+				      "nss_port1_tx",
+				      "nss_port2_rx",
+				      "nss_port2_tx",
+				      "nss_port3_rx",
+				      "nss_port3_tx",
+				      "nss_port4_rx",
+				      "nss_port4_tx",
+				      "nss_port5_rx",
+				      "nss_port5_tx",
+				      "nss_port6_rx",
+				      "nss_port6_tx",
+				      "uniphy_port1_rx",
+				      "uniphy_port1_tx",
+				      "uniphy_port2_rx",
+				      "uniphy_port2_tx",
+				      "uniphy_port3_rx",
+				      "uniphy_port3_tx",
+				      "uniphy_port4_rx",
+				      "uniphy_port4_tx",
+				      "uniphy_port5_rx",
+				      "uniphy_port5_tx",
+				      "uniphy_port6_rx",
+				      "uniphy_port6_tx",
+				      "nss_port5_rx_clk_src",
+				      "nss_port5_tx_clk_src";
+
+			resets = <&nsscc PPE_FULL_RESET>,
+				 <&gcc GCC_UNIPHY0_SYS_RESET>,
+				 <&gcc GCC_UNIPHY1_SYS_RESET>,
+				 <&gcc GCC_UNIPHY2_SYS_RESET>,
+				 <&gcc GCC_UNIPHY0_AHB_RESET>,
+				 <&gcc GCC_UNIPHY1_AHB_RESET>,
+				 <&gcc GCC_UNIPHY2_AHB_RESET>,
+				 <&gcc GCC_UNIPHY0_XPCS_RESET>,
+				 <&gcc GCC_UNIPHY1_XPCS_RESET>,
+				 <&gcc GCC_UNIPHY2_XPCS_RESET>,
+				 <&nsscc UNIPHY0_SOFT_RESET>,
+				 <&nsscc UNIPHY_PORT5_ARES>,
+				 <&nsscc UNIPHY_PORT6_ARES>,
+				 <&nsscc UNIPHY_PORT1_ARES>,
+				 <&nsscc UNIPHY_PORT2_ARES>,
+				 <&nsscc UNIPHY_PORT3_ARES>,
+				 <&nsscc UNIPHY_PORT4_ARES>,
+				 <&nsscc NSSPORT1_RESET>,
+				 <&nsscc NSSPORT2_RESET>,
+				 <&nsscc NSSPORT3_RESET>,
+				 <&nsscc NSSPORT4_RESET>,
+				 <&nsscc NSSPORT5_RESET>,
+				 <&nsscc NSSPORT6_RESET>,
+				 <&nsscc PORT1_MAC_ARES>,
+				 <&nsscc PORT2_MAC_ARES>,
+				 <&nsscc PORT3_MAC_ARES>,
+				 <&nsscc PORT4_MAC_ARES>,
+				 <&nsscc PORT5_MAC_ARES>,
+				 <&nsscc PORT6_MAC_ARES>;
+			reset-names = "ppe",
+				      "uniphy0_sys",
+				      "uniphy1_sys",
+				      "uniphy2_sys",
+				      "uniphy0_ahb",
+				      "uniphy1_ahb",
+				      "uniphy2_ahb",
+				      "uniphy0_xpcs",
+				      "uniphy1_xpcs",
+				      "uniphy2_xpcs",
+				      "uniphy0_soft",
+				      "uniphy1_soft",
+				      "uniphy2_soft",
+				      "uniphy0_port1_dis",
+				      "uniphy0_port2_dis",
+				      "uniphy0_port3_dis",
+				      "uniphy0_port4_dis",
+				      "nss_port1",
+				      "nss_port2",
+				      "nss_port3",
+				      "nss_port4",
+				      "nss_port5",
+				      "nss_port6",
+				      "nss_port1_mac",
+				      "nss_port2_mac",
+				      "nss_port3_mac",
+				      "nss_port4_mac",
+				      "nss_port5_mac",
+				      "nss_port6_mac";
+
+			uniphys: qcom-uniphy@7a00000 {
+				reg = <0x7a00000 0x10000>,
+				      <0x7a10000 0x10000>,
+				      <0x7a20000 0x10000>;
+				#clock-cells = <0x1>;
+				clock-output-names = "uniphy0_gcc_rx_clk",
+						     "uniphy0_gcc_tx_clk",
+						     "uniphy1_gcc_rx_clk",
+						     "uniphy1_gcc_tx_clk",
+						     "uniphy2_gcc_rx_clk",
+						     "uniphy2_gcc_tx_clk";
+			};
+
+			tdm-config {
+				/*
+				 * qcom,tdm-bm-config = <valid egress port
+				 * second_valid second_port>;
+				 */
+				qcom,tdm-bm-config = <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 7 0 0>,
+						     <1 1 7 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 3 0 0>,
+						     <1 1 3 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 7 0 0>,
+						     <1 1 7 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 4 0 0>,
+						     <1 1 4 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 7 0 0>,
+						     <1 1 7 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 3 0 0>,
+						     <1 1 3 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 5 0 0>,
+						     <1 1 5 0 0>,
+						     <1 0 6 0 0>,
+						     <1 1 6 0 0>,
+						     <1 0 4 0 0>,
+						     <1 1 4 0 0>,
+						     <1 0 7 0 0>,
+						     <1 1 7 0 0>;
+
+			/*
+			 * qcom,tdm-port-scheduler-config = <ensch_bmp ensch_port
+			 * desch_port desch_second_valid desch_second_port>;
+			 */
+			qcom,tdm-port-scheduler-config = <0x98 6 0 1 1>,
+							 <0x94 5 6 1 3>,
+							 <0x86 0 5 1 4>,
+							 <0x8C 1 6 1 0>,
+							 <0x1C 7 5 1 1>,
+							 <0x98 2 6 1 0>,
+							 <0x1C 5 7 1 1>,
+							 <0x34 3 6 1 0>,
+							 <0x8C 4 5 1 1>,
+							 <0x98 2 6 1 0>,
+							 <0x8C 5 4 1 1>,
+							 <0xA8 0 6 1 2>,
+							 <0x98 5 1 1 0>,
+							 <0x98 6 5 1 2>,
+							 <0x89 1 6 1 4>,
+							 <0xA4 3 0 1 1>,
+							 <0x8C 5 6 1 4>,
+							 <0xA8 0 2 1 1>,
+							 <0x98 6 5 1 0>,
+							 <0xC4 4 3 1 1>,
+							 <0x94 6 5 1 0>,
+							 <0x1C 7 6 1 1>,
+							 <0x98 2 5 1 0>,
+							 <0x1C 6 7 1 1>,
+							 <0x1C 5 6 1 0>,
+							 <0x94 3 5 1 1>,
+							 <0x8C 4 6 1 0>,
+							 <0x94 1 5 1 3>,
+							 <0x94 6 1 1 0>,
+							 <0xD0 3 5 1 2>,
+							 <0x98 6 0 1 1>,
+							 <0x94 5 6 1 3>,
+							 <0x94 1 5 1 0>,
+							 <0x98 2 6 1 1>,
+							 <0x8C 4 5 1 0>,
+							 <0x1C 7 6 1 1>,
+							 <0x8C 0 5 1 4>,
+							 <0x89 1 6 1 2>,
+							 <0x98 5 0 1 1>,
+							 <0x94 6 5 1 3>,
+							 <0x92 0 6 1 2>,
+							 <0x98 1 5 1 0>,
+							 <0x98 6 2 1 1>,
+							 <0xD0 0 5 1 3>,
+							 <0x94 6 0 1 1>,
+							 <0x8C 5 6 1 4>,
+							 <0x8C 1 5 1 0>,
+							 <0x1C 6 7 1 1>,
+							 <0x1C 5 6 1 0>,
+							 <0xB0 2 3 1 1>,
+							 <0xC4 4 5 1 0>,
+							 <0x8C 6 4 1 1>,
+							 <0xA4 3 6 1 0>,
+							 <0x1C 5 7 1 1>,
+							 <0x4C 0 5 1 4>,
+							 <0x8C 6 0 1 1>,
+							 <0x34 7 6 1 3>,
+							 <0x94 5 0 1 1>,
+							 <0x98 6 5 1 2>;
+			};
+
+			buffer-management-config {
+				/* qcom,group-config = <group group_buf>; */
+				qcom,group-config = <0 1550>;
+				/*
+				 * qcom,port-config = <group port prealloc react
+				 * ceil weight res_off res_ceil dynamic>;
+				 */
+				qcom,port-config = <0 0 0 100 1146 7 8 0 1>,
+						   <0 1 0 100 250 4 36 0 1>,
+						   <0 2 0 100 250 4 36 0 1>,
+						   <0 3 0 100 250 4 36 0 1>,
+						   <0 4 0 100 250 4 36 0 1>,
+						   <0 5 0 100 250 4 36 0 1>,
+						   <0 6 0 100 250 4 36 0 1>,
+						   <0 7 0 100 250 4 36 0 1>,
+						   <0 8 0 128 250 4 36 0 1>,
+						   <0 9 0 128 250 4 36 0 1>,
+						   <0 10 0 128 250 4 36 0 1>,
+						   <0 11 0 128 250 4 36 0 1>,
+						   <0 12 0 128 250 4 36 0 1>,
+						   <0 13 0 128 250 4 36 0 1>,
+						   <0 14 0 40 250 4 36 0 1>;
+			};
+
+			queue-management-config {
+				/*
+				 * qcom,group-config = <group total prealloc
+				 * ceil resume_off>;
+				 */
+				qcom,group-config = <0 2000 0 0 0>;
+				/*
+				 * qcom,queue-config = <queue_base queue_num
+				 * group prealloc ceil weight resume_off dynamic>;
+				 */
+				qcom,queue-config = <0 256 0 0 400 4 36 1>,
+						    <256 44 0 0 250 0 36 0>;
+			};
+
+			port-scheduler-resource {
+				port0 {
+					port-id = <0>;
+					qcom,ucast-queue = <0 63>;
+					qcom,mcast-queue = <256 263>;
+					qcom,l0sp = <0 0>;
+					qcom,l0cdrr = <0 7>;
+					qcom,l0edrr = <0 7>;
+					qcom,l1cdrr = <0 0>;
+					qcom,l1edrr = <0 0>;
+				};
+
+				port1 {
+					port-id = <1>;
+					qcom,ucast-queue = <204 211>;
+					qcom,mcast-queue = <272 275>;
+					qcom,l0sp = <51 52>;
+					qcom,l0cdrr = <108 115>;
+					qcom,l0edrr = <108 115>;
+					qcom,l1cdrr = <23 24>;
+					qcom,l1edrr = <23 24>;
+				};
+
+				port2 {
+					port-id = <2>;
+					qcom,ucast-queue = <212 219>;
+					qcom,mcast-queue = <276 279>;
+					qcom,l0sp = <53 54>;
+					qcom,l0cdrr = <116 123>;
+					qcom,l0edrr = <116 123>;
+					qcom,l1cdrr = <25 26>;
+					qcom,l1edrr = <25 26>;
+				};
+
+				port3 {
+					port-id = <3>;
+					qcom,ucast-queue = <220 227>;
+					qcom,mcast-queue = <280 283>;
+					qcom,l0sp = <55 56>;
+					qcom,l0cdrr = <124 131>;
+					qcom,l0edrr = <124 131>;
+					qcom,l1cdrr = <27 28>;
+					qcom,l1edrr = <27 28>;
+				};
+
+				port4 {
+					port-id = <4>;
+					qcom,ucast-queue = <228 235>;
+					qcom,mcast-queue = <284 287>;
+					qcom,l0sp = <57 58>;
+					qcom,l0cdrr = <132 139>;
+					qcom,l0edrr = <132 139>;
+					qcom,l1cdrr = <29 30>;
+					qcom,l1edrr = <29 30>;
+				};
+
+				port5 {
+					port-id = <5>;
+					qcom,ucast-queue = <236 243>;
+					qcom,mcast-queue = <288 291>;
+					qcom,l0sp = <59 60>;
+					qcom,l0cdrr = <140 147>;
+					qcom,l0edrr = <140 147>;
+					qcom,l1cdrr = <31 32>;
+					qcom,l1edrr = <31 32>;
+				};
+
+				port6 {
+					port-id = <6>;
+					qcom,ucast-queue = <244 251>;
+					qcom,mcast-queue = <292 295>;
+					qcom,l0sp = <61 62>;
+					qcom,l0cdrr = <148 155>;
+					qcom,l0edrr = <148 155>;
+					qcom,l1cdrr = <33 34>;
+					qcom,l1edrr = <33 34>;
+				};
+
+				port7 {
+					port-id = <7>;
+					qcom,ucast-queue = <252 255>;
+					qcom,mcast-queue = <296 299>;
+					qcom,l0sp = <63 63>;
+					qcom,l0cdrr = <156 159>;
+					qcom,l0edrr = <156 159>;
+					qcom,l1cdrr = <35 35>;
+					qcom,l1edrr = <35 35>;
+				};
+			};
+
+			port-scheduler-config {
+				port0 {
+					port-id = <0>;
+					l1scheduler {
+						group0 {
+							/* flow ID from L0 SP */
+							qcom,flow = <0>;
+							/* sp cpri cdrr epri edrr */
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							/* unicast queue */
+							qcom,ucast-queue = <0>;
+							qcom,ucast-loop-priority = <8>;
+							/* multicast queue */
+							qcom,mcast-queue = <256>;
+							/* sp cpri cdrr epri edrr */
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group1 {
+							qcom,ucast-queue = <8>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <257>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group2 {
+							qcom,ucast-queue = <16>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <258>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group3 {
+							qcom,ucast-queue = <24>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <259>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group4 {
+							qcom,ucast-queue = <32>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <260>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group5 {
+							qcom,ucast-queue = <40>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <261>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group6 {
+							qcom,ucast-queue = <48>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <262>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+
+						group7 {
+							qcom,ucast-queue = <56>;
+							qcom,ucast-loop-priority = <8>;
+							qcom,mcast-queue = <263>;
+							qcom,scheduler-config = <0 0 0 0 0>;
+						};
+					};
+				};
+
+				port1 {
+					port-id = <1>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <51>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <1 0 23 0 23>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <204>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <272>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <51 0 108 0 108>;
+						};
+					};
+				};
+
+				port2 {
+					port-id = <2>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <53>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <2 0 25 0 25>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <212>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <276>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <53 0 116 0 116>;
+						};
+					};
+				};
+
+				port3 {
+					port-id = <3>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <55>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <3 0 27 0 27>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <220>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <280>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <55 0 124 0 124>;
+						};
+					};
+				};
+
+				port4 {
+					port-id = <4>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <57>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <4 0 29 0 29>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <228>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <284>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <57 0 132 0 132>;
+						};
+					};
+				};
+
+				port5 {
+					port-id = <5>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <59>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <5 0 31 0 31>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <236>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <288>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <59 0 140 0 140>;
+						};
+					};
+				};
+
+				port6 {
+					port-id = <6>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <61>;
+							qcom,flow-loop-priority = <2>;
+							qcom,scheduler-config = <6 0 33 0 33>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <244>;
+							qcom,ucast-loop-priority = <8>;
+							/* max priority per SP */
+							qcom,drr-max-priority = <4>;
+							qcom,mcast-queue = <292>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <61 0 148 0 148>;
+						};
+					};
+				};
+
+				port7 {
+					port-id = <7>;
+					l1scheduler {
+						group0 {
+							qcom,flow = <63>;
+							qcom,scheduler-config = <7 0 35 0 35>;
+						};
+					};
+
+					l0scheduler {
+						group0 {
+							qcom,ucast-queue = <252>;
+							qcom,ucast-loop-priority = <4>;
+							qcom,mcast-queue = <296>;
+							qcom,mcast-loop-priority = <4>;
+							qcom,scheduler-config = <63 0 156 0 156>;
+						};
+					};
+				};
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.42.0


