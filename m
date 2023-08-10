Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C2777510
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjHJJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHJJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F457213F;
        Thu, 10 Aug 2023 02:57:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A9nC9M018489;
        Thu, 10 Aug 2023 09:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=P3mfiVOWQA2fBdEjUhjCQ7cZSWURZE9yDZZmYFLaL7g=;
 b=aAJA/DF7rlfK7XPeD32PwVRSMZ8eIJdkCBurwGJb9J96nuAuvFsjkKBXg3Wni9IZ8mvy
 1lGUz3m0YHzv3iXx6pCYixuZxU0Dkh6g9ZIVjneDpzNp2PptdhZOOO9gCJgmQ4NINaj/
 BBPvzuo1G8cywyh7QCqzHTHQHb4XojlLFe0hJ4OSet1H70Cqyof2+1PqIILurvQaYJb5
 JWP8k4xXLMtLYuOgOELZVwK0Ip79OxpQDyOHisDBbQyY4L9TU+B13bsU+oy5UMf43o10
 22Pgk/k150swOz/F1CtYLtKnhAuXsBbfFZLECbFSrDC5pItkhItsXiT/WbKdwhj/6p8L qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scw2ur2q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A9uhvd019111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:43 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:56:36 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/5] arm64: dts: qcom: ipq5332: Add USB related nodes
Date:   Thu, 10 Aug 2023 15:26:06 +0530
Message-ID: <066299506138ffcf1a3135b6f1a4609eee46ddf9.1691660905.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1691660905.git.quic_varada@quicinc.com>
References: <cover.1691660905.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2FZZdGLbRI8C0Pw7hxskLdtzc0yW9MR7
X-Proofpoint-ORIG-GUID: 2FZZdGLbRI8C0Pw7hxskLdtzc0yW9MR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_09,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=845 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB phy and controller nodes.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6:
	Remove clock names
	Move the nodes to address sorted location
v5:
	Use generic phy instead of usb-phy
	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check' passed
	'DT_CHECKER_FLAGS='-v -m' DT_SCHEMA_FILES=qcom dt_binding_check' passed
v4:
	Change node name
	Remove blank line
	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
v1:
	Rename phy node
	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
	Remove 'qscratch' from phy node
	Fix alignment and upper-case hex no.s
	Add clock definition for the phy
	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
	in dwc3/core.c takes the frequency from ref clock and calculates fladj
	as appropriate.
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 8bfc2db..c45d9d4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -145,6 +145,19 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		usbphy0: phy@7b000 {
+			compatible = "qcom,ipq5332-usb-hsphy";
+			reg = <0x0007b000 0x12c>;
+
+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+
+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		qfprom: efuse@a4000 {
 			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x721>;
@@ -290,6 +303,48 @@
 			status = "disabled";
 		};
 
+		usb: usb2@8a00000 {
+			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
+			reg = <0x08af8800 0x400>;
+
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
+			clocks = <&gcc GCC_USB0_MASTER_CLK>,
+				 <&gcc GCC_SNOC_USB_CLK>,
+				 <&gcc GCC_USB0_SLEEP_CLK>,
+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			resets = <&gcc GCC_USB_BCR>;
+
+			qcom,select-utmi-as-pipe-clk;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			usb2_0_dwc: usb@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x08a00000 0xe000>;
+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+				clock-names = "ref";
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				phy-names = "usb2-phy";
+				phys = <&usbphy0>;
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,	/* GICD */
-- 
2.7.4

