Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132037B1E86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjI1NeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjI1NeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:34:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6719D;
        Thu, 28 Sep 2023 06:33:51 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCHg3g031957;
        Thu, 28 Sep 2023 13:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ouTjBymotHhhoP7Q5o/E4HhL0/AZbX5euLqbcLdXCxs=;
 b=W5MLAzLRm63CrEGJYkc4OOwE86PoPjyO8LKCsMsAirtdF2N0+nfpulSgcxXEPvIMbpVk
 bpNJ+oK94e4m8WXfQ42fOFQV1NauLDjID3xysU9Psve5YJ2Vw1oTMXm1n8M1KoruqALm
 Ri7Tk9rEZgxYlX2zFu5nsE5+gI96ySAtC8ZNQ77+ChQDSCFRVoUzQEIxHQvuEGWh3Wpr
 mgmUm4DbEIGAUgO66oNUBW2hxoBsxZYc41GisY8DjwLrBsy2jGlrzbGXv0UC6/1Vb5Ey
 Qz0rDypAFyan8y7gTKLRbJu/i3t7BZCSrFQBug0cTPm2yudMT15ORJOTEHz+XkK4MNXg vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td2vu0x2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:33:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SDXjHt025649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:33:45 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 28 Sep 2023 06:33:41 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        "Komal Bajaj" <quic_kbajaj@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Date:   Thu, 28 Sep 2023 19:03:12 +0530
Message-ID: <20230928133312.11371-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928133312.11371-1-quic_kbajaj@quicinc.com>
References: <20230928133312.11371-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1LcFjeEAf_81OaKK7ZAJbamhTEaHrmQu
X-Proofpoint-ORIG-GUID: 1LcFjeEAf_81OaKK7ZAJbamhTEaHrmQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_12,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
platform. QCM6490 is derived from SC7280 meant for various
form factor including IoT.

Supported features are, as of now:
* Debug UART
* eMMC
* USB

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile        |   1 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 304 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490.dtsi    | 137 ++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 73c3be0f8872..3a2d9dbaacce 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -82,6 +82,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
new file mode 100644
index 000000000000..7cd7d9f556ae
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include "qcm6490.dtsi"
+#include "pm7325.dtsi"
+#include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCM6490 IDP platform";
+	compatible = "qcom,qcm6490-idp", "qcom,qcm6490";
+
+	aliases {
+		serial0 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7325-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vreg_s1b_1p8: smps1 {
+			regulator-min-microvolt = <1856000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7b_0p9: smps7 {
+			regulator-min-microvolt = <535000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		vreg_s8b_1p2: smps8 {
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1500000>;
+		};
+
+		vreg_l1b_0p8: ldo1 {
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <925000>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+		};
+
+		vreg_l7b_2p9: ldo7 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l8b_0p9: ldo8 {
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l11b_1p7: ldo11 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l12b_0p8: ldo12 {
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+		};
+
+		vreg_l13b_0p8: ldo13 {
+			regulator-min-microvolt = <530000>;
+			regulator-max-microvolt = <824000>;
+		};
+
+		vreg_l14b_1p2: ldo14 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l15b_0p8: ldo15 {
+			regulator-min-microvolt = <765000>;
+			regulator-max-microvolt = <1020000>;
+		};
+
+		vreg_l16b_1p2: ldo16 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		vreg_l17b_1p8: ldo17 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		vreg_l18b_1p8: ldo18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l19b_1p8: ldo19 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_s1c_2p2: smps1 {
+			regulator-min-microvolt = <2190000>;
+			regulator-max-microvolt = <2210000>;
+		};
+
+		vreg_s9c_1p0: smps9 {
+			regulator-min-microvolt = <1010000>;
+			regulator-max-microvolt = <1170000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		vreg_l2c_1p8: ldo2 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		vreg_l3c_3p0: ldo3 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3540000>;
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l10c_0p8: ldo10 {
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		vreg_l11c_2p8: ldo11 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l12c_1p8: ldo12 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l13c_3p0: ldo13 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+		};
+	};
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&sdhc_1 {
+	non-removable;
+	no-sd;
+	no-sdio;
+
+	vmmc-supply = <&vreg_l7b_2p9>;
+	vqmmc-supply = <&vreg_l19b_1p8>;
+
+	status = "okay";
+};
+
+&uart5 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p8>;
+	vdda33-supply = <&vreg_l2b_3p0>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	qcom,hs-rise-fall-time-bp = <0>;
+	qcom,squelch-detector-bp = <(-2090)>;
+	qcom,hs-disconnect-bp = <1743>;
+	qcom,hs-amplitude-bp = <1780>;
+	qcom,hs-crossover-voltage-microvolt = <(-31000)>;
+	qcom,hs-output-impedance-micro-ohms = <2600000>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p8>;
+
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in sc7280.dtsi */
+
+&pm8350c_pwm {
+	status = "okay";
+};
+
+&qup_uart5_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart5_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&sdc1_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc1_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_rclk {
+	bias-pull-down;
+};
diff --git a/arch/arm64/boot/dts/qcom/qcm6490.dtsi b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
new file mode 100644
index 000000000000..31f44fc87388
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "sc7280.dtsi"
+
+/*
+ * Delete sc7280 lpass related nodes as qcm6490 intends to move away from
+ * bypass configuration
+ */
+/delete-node/ &lpass_ag_noc;
+/delete-node/ &lpass_aon;
+/delete-node/ &lpass_audiocc;
+/delete-node/ &lpass_core;
+/delete-node/ &lpass_cpu;
+/delete-node/ &lpass_hm;
+/delete-node/ &lpass_rx_macro;
+/delete-node/ &lpass_tx_macro;
+/delete-node/ &lpass_va_macro;
+/delete-node/ &lpass_tlmm;
+/delete-node/ &lpasscc;
+/delete-node/ &swr0;
+/delete-node/ &swr1;
+
+/*
+ * Delete unused sc7280 memory nodes and define the memory regions
+ * required by qcm6490
+ */
+/delete-node/ &rmtfs_mem;
+/delete-node/ &wlan_ce_mem;
+
+/{
+	reserved-memory {
+		secdata_apss_mem: secdata-apss@808ff000 {
+			reg = <0x0 0x808ff000 0x0 0x1000>;
+			no-map;
+		};
+
+		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
+			reg = <0x0 0x81800000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		camera_mem: camera@84300000 {
+			reg = <0x0 0x84300000 0x0 0x500000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@86100000 {
+			reg = <0x0 0x86100000 0x0 0x2800000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@88900000 {
+			reg = <0x0 0x88900000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		cvp_mem: cvp@8ac00000 {
+			reg = <0x0 0x8ac00000 0x0 0x500000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi@8b110000 {
+			reg = <0x0 0x8b110000 0x0 0xa000>;
+			no-map;
+		};
+
+		gpu_microcode_mem: gpu-microcode@8b11a000 {
+			reg = <0x0 0x8b11a000 0x0 0x2000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@8b800000 {
+			reg = <0x0 0x8b800000 0x0 0xf600000>;
+			no-map;
+		};
+
+		wpss_mem: wpss@9ae00000 {
+			reg = <0x0 0x9ae00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x100000>;
+			no-map;
+		};
+
+		tags_mem: tags@c0100000 {
+			reg = <0x0 0xc0100000 0x0 0x1200000>;
+			no-map;
+		};
+
+		qtee_mem: qtee@c1300000 {
+			reg = <0x0 0xc1300000 0x0 0x500000>;
+			no-map;
+		};
+
+		trusted_apps_mem: trusted_apps@c1800000 {
+			reg = <0x0 0xc1800000 0x0 0x3900000>;
+			no-map;
+		};
+	};
+};
+
+&hyp_mem {
+	reg = <0x0 0x80000000 0x0 0x600000>;
+};
+
+&mpss_mem {
+	reg = <0x0 0x8b800000 0x0 0xf600000>;
+};
+
+&remoteproc_mpss {
+	memory-region = <&mpss_mem>;
+};
+
+&video_mem {
+	reg = <0x0 0x8a700000 0x0 0x500000>;
+};
+
+&wifi {
+	memory-region = <&wlan_fw_mem>;
+};
+
+&wlan_fw_mem {
+	reg = <0x0 0x80c00000 0x0 0xc00000>;
+};
+
+&wpss_mem {
+	reg = <0x0 0x84800000 0x0 0x1900000>;
+};
+
+&xbl_mem {
+	reg = <0x0 0x80700000 0x0 0x100000>;
+};
--
2.42.0

