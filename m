Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907A788351
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbjHYJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjHYJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:14:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA01FF0;
        Fri, 25 Aug 2023 02:14:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P8Y2m3014030;
        Fri, 25 Aug 2023 09:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NwCcoTD76E94tkR8enxNhKSpT+Ogmny4bI7pJPKtSLs=;
 b=Ro/QgupoLlip0GJ1k4Niq7G955DaqW59myzbs7UEI2ePMEO3yYXwPMGpZZBHPCsImr0V
 9S1GCbU5TM6ipiH+EcwwCol0Lpyh8MVTNSFffkq0DvCSR2WBJtk25OueGQzTAjjdN8E8
 06CT2E6jV4X2wMcnj3ijFprgF7Ye9bpiZLsZXlfvtaInwTEfA0lJH0yKQ3O6kINWBX4A
 Iyc+azEv5vQONCKJgyGdb/kDXGC2P8La2zM0k0GXLypaQ2e9LWDkUKDJlGnAw0HkRCaj
 eifWsjF8c+A7ec4pO/LoNEK6HI562eLkO61uNRcZ7AVsie+NioxYfMpB1sJGfqRw2CvP Cg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmny0j15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:13:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37P9DerK031469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:13:40 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 25 Aug 2023 02:13:33 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_devipriy@quicinc.com>, <quic_saahtoma@quicinc.com>
Subject: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc node
Date:   Fri, 25 Aug 2023 14:42:33 +0530
Message-ID: <20230825091234.32713-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825091234.32713-1-quic_devipriy@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gsR0PcU9OgOVy8cLJsBOWw5MI6cwZ_AJ
X-Proofpoint-GUID: gsR0PcU9OgOVy8cLJsBOWw5MI6cwZ_AJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the nss clock controller found on ipq9574 based devices.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Dropped the fixed clock node gcc_gpll0_out_aux and added
	  support for the same in gcc driver
	- Updated the node name to clock-controller@39b00000
	- Added clock-names to retrieve the nssnoc clocks and add them
	  to the list of pm clocks in nss driver

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 51aba071c1eb..903311547e96 100644
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
@@ -722,6 +742,34 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq9574-nsscc";
+			reg = <0x39b00000 0x80000>;
+			clocks = <&gcc GCC_NSSNOC_NSSCC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_CLK>,
+				 <&gcc GCC_NSSNOC_SNOC_1_CLK>,
+				 <&bias_pll_cc_clk>,
+				 <&bias_pll_nss_noc_clk>,
+				 <&bias_pll_ubi_nc_clk>,
+				 <&gcc GPLL0_OUT_AUX>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&xo_board_clk>;
+			clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
+				      "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
+				      "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
+				      "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
+				      "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
+				      "uniphy2_nss_tx_clk", "xo_board_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
 	};
 
 	thermal-zones {
-- 
2.34.1

