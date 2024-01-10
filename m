Return-Path: <linux-kernel+bounces-22076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88B8298D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06A0B25E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50430482D4;
	Wed, 10 Jan 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jfam3VOJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C6E481A8;
	Wed, 10 Jan 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8dDi5017759;
	Wed, 10 Jan 2024 11:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bmQiLXUcCWU40vR9w0CrqCW70poyqve4mvQVXRCvLns=; b=Jf
	am3VOJDV6C1KF8Wk4qlUHsoCCGPF2W3JWP36F/586UyLb4pjZStPwfgssIWNJbWk
	IiVG66ZBy7YB42wc6AD+tZ60dKEEn7TbIACPqlV4kf9I3WXdACJhEcZvQP7cj92V
	pYWx9CvcaJA0m6pu5Wx589XKLo8WeqabZwtMIqMlVJyeVaXH2dVGNzUiD+N2m3+h
	mw1y+ZfYt7rx3ZLVrSNgHVzXxqFO9/yjBji2YF8fhT3tJK0zvoS+LcziTsDtJb5B
	LJVnQnXOSlZBhE2oUoJ2qE6Kv/uPJ9qu5EDkGJXkJVLmPWcRb/QkrohwkDxdhrIe
	dNEPZRbExQU5VwdbRenA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem0ve6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABLPhF026852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:21:25 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:21:21 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH 2/6] arm64: dts: qcom: ipq5332: Add PPE device tree node
Date: Wed, 10 Jan 2024 19:20:55 +0800
Message-ID: <20240110112059.2498-3-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IWYwjtTgFyNSeAEuggMRF5OFQzY7Sed4
X-Proofpoint-GUID: IWYwjtTgFyNSeAEuggMRF5OFQzY7Sed4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=921 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

The PPE device tree node includes the PPE initialization configurations
and the UNIPHY(PCS) instance configurations.

There are two UNIPHYs in ipq5332 platform, which provide the root clock
to the PPE port to work on the different link speed.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 370 +++++++++++++++++++++++++-
 1 file changed, 366 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index a1504f6c40c1..bc89480820cb 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+#include <dt-bindings/clock/qcom,ipq5332-nsscc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -492,15 +493,376 @@ nsscc: clock-controller@39b00000{
 			clocks = <&cmn_pll_nss_200m_clk>,
 				 <&cmn_pll_nss_300m_clk>,
 				 <&gcc GPLL0_OUT_AUX>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&uniphys 0>,
+				 <&uniphys 1>,
+				 <&uniphys 2>,
+				 <&uniphys 3>,
 				 <&xo_board>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 		};
+
+		qcom_ppe: qcom-ppe@3a000000 {
+			compatible = "qcom,ipq5332-ppe";
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
+				 <&gcc GCC_UNIPHY0_AHB_CLK>,
+				 <&gcc GCC_UNIPHY1_AHB_CLK>,
+				 <&gcc GCC_NSSCC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_1_CLK>,
+				 <&gcc GCC_IM_SLEEP_CLK>,
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
+				 <&nsscc NSS_CC_PORT1_RX_CLK>,
+				 <&nsscc NSS_CC_PORT1_TX_CLK>,
+				 <&nsscc NSS_CC_PORT2_RX_CLK>,
+				 <&nsscc NSS_CC_PORT2_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_RX_CLK>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_TX_CLK>;
+			clock-names = "cmn_ahb",
+				      "cmn_sys",
+				      "uniphy0_sys",
+				      "uniphy1_sys",
+				      "uniphy0_ahb",
+				      "uniphy1_ahb",
+				      "gcc_nsscc",
+				      "gcc_nssnoc_snoc",
+				      "gcc_nssnoc_snoc_1",
+				      "gcc_im_sleep",
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
+				      "nss_port1_rx",
+				      "nss_port1_tx",
+				      "nss_port2_rx",
+				      "nss_port2_tx",
+				      "uniphy_port1_rx",
+				      "uniphy_port1_tx",
+				      "uniphy_port2_rx",
+				      "uniphy_port2_tx";
+
+			resets = <&nsscc NSS_CC_PPE_BCR>,
+				 <&gcc GCC_UNIPHY0_SYS_CLK_ARES>,
+				 <&gcc GCC_UNIPHY1_SYS_CLK_ARES>,
+				 <&gcc GCC_UNIPHY0_AHB_CLK_ARES>,
+				 <&gcc GCC_UNIPHY1_AHB_CLK_ARES>,
+				 <&gcc GCC_UNIPHY0_XPCS_ARES>,
+				 <&gcc GCC_UNIPHY1_XPCS_ARES>,
+				 <&gcc GCC_UNIPHY0_BCR>,
+				 <&gcc GCC_UNIPHY1_BCR>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_RX_CLK_ARES>,
+				 <&nsscc NSS_CC_UNIPHY_PORT1_TX_CLK_ARES>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_RX_CLK_ARES>,
+				 <&nsscc NSS_CC_UNIPHY_PORT2_TX_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT1_RX_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT1_TX_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT2_RX_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT2_TX_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT1_MAC_CLK_ARES>,
+				 <&nsscc NSS_CC_PORT2_MAC_CLK_ARES>;
+			reset-names = "ppe",
+				      "uniphy0_sys",
+				      "uniphy1_sys",
+				      "uniphy0_ahb",
+				      "uniphy1_ahb",
+				      "uniphy0_xpcs",
+				      "uniphy1_xpcs",
+				      "uniphy0_soft",
+				      "uniphy1_soft",
+				      "uniphy_port1_rx",
+				      "uniphy_port1_tx",
+				      "uniphy_port2_rx",
+				      "uniphy_port2_tx",
+				      "nss_port1_rx",
+				      "nss_port1_tx",
+				      "nss_port2_rx",
+				      "nss_port2_tx",
+				      "nss_port1_mac",
+				      "nss_port2_mac";
+
+			uniphys: qcom-uniphy@7a00000 {
+				reg = <0x7a00000 0x10000>,
+				      <0x7a10000 0x10000>;
+				#clock-cells = <0x1>;
+				clock-output-names = "uniphy0_gcc_rx_clk",
+						     "uniphy0_gcc_tx_clk",
+						     "uniphy1_gcc_rx_clk",
+						     "uniphy1_gcc_tx_clk";
+			};
+
+			tdm-config {
+				/*
+				 * qcom,tdm-bm-config =
+				 * <valid egress port second_valid second_port>;
+				 */
+				qcom,tdm-bm-config = <1 0 2 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 2 0 0>,
+						     <1 1 0 0 0>,
+						     <1 0 1 0 0>,
+						     <1 1 1 0 0>,
+						     <1 0 0 0 0>,
+						     <1 1 2 0 0>,
+						     <1 0 1 0 0>,
+						     <0 0 0 0 0>;
+
+				/*
+				 * qcom,tdm-port-scheduler-config =
+				 * <ensch_bmp ensch_port desch_port
+				 * desch_second_valid desch_second_port>;
+				 */
+				qcom,tdm-port-scheduler-config = <0x0 2 0 0 0>,
+								 <0x0 1 2 0 0>,
+								 <0x0 0 1 0 0>,
+								 <0x0 0 2 0 0>,
+								 <0x0 1 0 0 0>,
+								 <0x0 2 1 0 0>,
+								 <0x0 0 2 0 0>,
+								 <0x0 0 1 0 0>,
+								 <0x0 0 2 0 0>,
+								 <0x0 0 1 0 0>;
+			};
+
+			buffer-management-config {
+				/* qcom,group-config = <group group_buf>; */
+				qcom,group-config = <0 240>;
+				/*
+				 * qcom,port-config =
+				 * <group port prealloc react ceil weight
+				 * res_off res_ceil dynamic>;
+				 */
+				qcom,port-config = <0 0 12 40 30 7 5 20 1>,
+						   <0 1 12 40 30 7 5 20 1>,
+						   <0 2 12 40 30 7 5 20 1>,
+						   <0 3 12 40 30 7 5 20 1>,
+						   <0 4 12 40 30 7 5 20 1>,
+						   <0 5 12 40 30 7 5 20 1>,
+						   <0 6 12 40 30 7 5 20 1>,
+						   <0 7 12 40 30 7 5 20 1>,
+						   <0 8 12 128 48 7 5 20 1>,
+						   <0 9 12 128 48 7 5 20 1>;
+			};
+
+			queue-management-config {
+				/*
+				 * qcom,group-config =
+				 * <group total prealloc ceil resume_off>;
+				 */
+				qcom,group-config = <0 500 0 0 0>;
+				/*
+				 * qcom,queue-config =
+				 * <queue_base queue_num group prealloc ceil
+				 * weight resume_off dynamic>;
+				 */
+				qcom,queue-config = <0 256 0 0 50 5 18 1>,
+						    <256 44 0 0 50 0 18 0>;
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
+			};
+		};
 	};
 
 	timer {
-- 
2.42.0


