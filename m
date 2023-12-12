Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3A80F34A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbjLLQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjLLQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:41:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF7B7;
        Tue, 12 Dec 2023 08:41:07 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFqepq001905;
        Tue, 12 Dec 2023 16:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5NFTZSuEGPBcubZ5Abb73rcOmNGdyTtBIsE67aQIRwo=;
 b=Et9UEsUqfDf7sAdBhdcmpK26AxdH0mGU2L7MJJ00c8d4aaBAnZdrwOchu8N1RDdpfHYl
 Nco6teDxuedNN//BDMd8Egf0UXNdZ16aaIbvkason7oH+deNW5R49OEFGw+JmnrB0uXc
 pQXC5PZzCudq4FCJmA3zsqDI8v8RhJJvK1raqm+Sc85lfb2AYGOj01G1pQMBafDJo5yO
 98aPeEanr654KQqairlwcTvZyFdWyR5QYJ94S+yEPObU5uWCsPkq88qVjFuIovgdRKtc
 XZtPtQKqxXqLuJYVfP4Hk2TzUUlkFTkhCaQ0nNuB1IEPuhTb8KRFvA92cnrmNSNo4LSp uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:27 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCFnF1N010634;
        Tue, 12 Dec 2023 16:40:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCCZP89014824;
        Tue, 12 Dec 2023 16:40:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kcxc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCGeNkG50791066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 16:40:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4229958043;
        Tue, 12 Dec 2023 16:40:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9918158053;
        Tue, 12 Dec 2023 16:40:21 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 16:40:21 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        ninad@linux.ibm.com, johannes.holland@infineon.com,
        linux@roeck-us.net, broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: [PATCH v1 5/8] ARM: dts: aspeed: System1: Voltage regulators
Date:   Tue, 12 Dec 2023 10:40:01 -0600
Message-Id: <20231212164004.1683589-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KW5Am6bDWmTQPERE-nFDpANy6U22aXcE
X-Proofpoint-ORIG-GUID: 3e0KMpvWNpIdPmZSIrlwmOsgmErxw9b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds different voltage regulators.

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 266 ++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 0557bff9f36a..b8e7e52d4600 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -114,10 +114,127 @@ vga_memory: region@bf000000 {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
+			<&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
+			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>,
+			<&adc1 4>, <&adc0 2>, <&adc1 0>,
+			<&p2V5_aux_vd 0>, <&adc1 7>;
+	};
+
+	p12v_vd: voltage_divider1 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 3>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1127/127 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <15>;
+		full-ohms = <133>;
+	};
+
+	p5v_aux_vd: voltage_divider2 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 5>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p5v_bmc_aux_vd: voltage_divider3 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 3>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p3v3_aux_vd: voltage_divider4 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 2>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p3v3_bmc_aux_vd: voltage_divider5 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 7>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p1v8_bmc_aux_vd: voltage_divider6 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 6>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 4000/3000 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <3>;
+		full-ohms = <4>;
+	};
+
+	p2V5_aux_vd: voltage_divider7 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 1>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 2100/1100 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <11>;
+		full-ohms = <21>;
+	};
+
+	p1v8_bmc_aux: fixedregulator-p1v8_bmc_aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&adc0 {
+	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default>;
 };
 
 &adc1 {
 	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+	aspeed,battery-sensing;
 
 	aspeed,int-vref-microvolt = <2500000>;
 	pinctrl-names = "default";
@@ -250,10 +367,32 @@ &kcs3 {
 
 &i2c0 {
 	status = "okay";
+
+	regulator@60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_1.0V";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
 	status = "okay";
+
+	regulator@42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
 };
 
 &i2c2 {
@@ -327,6 +466,21 @@ &i2c4 {
 
 &i2c5 {
 	status = "okay";
+
+	regulator@3a {
+		compatible = "maxim,max5970";
+		reg = <0x3a>;
+	};
+
+	regulator@42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
+
+	regulator@43 {
+		compatible = "infineon,ir38060";
+		reg = <0x43>;
+	};
 };
 
 &i2c6 {
@@ -423,6 +577,11 @@ i2c7mux0chn3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			regulator@58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
 		};
 
 		i2c7mux0chn4: i2c@4 {
@@ -435,6 +594,11 @@ i2c7mux0chn5: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
 		};
 
 		i2c7mux0chn6: i2c@6 {
@@ -466,12 +630,37 @@ i2c8mux0chn0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
 		};
 
 		i2c8mux0chn1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator@41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator@5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
 		};
 
 		i2c8mux0chn2: i2c@2 {
@@ -565,12 +754,44 @@ i2c8mux0chn7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
+
+			regulator@40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
 		};
 	};
 };
 
 &i2c9 {
 	status = "okay";
+
+	regulator@40 {
+		compatible = "infineon,ir38263";
+		reg = <0x40>;
+	};
+
+	regulator@41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
+
+	regulator@60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_1.2V";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c11 {
@@ -583,6 +804,11 @@ &i2c12 {
 
 &i2c13 {
 	status = "okay";
+
+	regulator@41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
 };
 
 &i2c14 {
@@ -618,6 +844,11 @@ i2c14mux0chn3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			regulator@58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
 		};
 
 		i2c14mux0chn4: i2c@4 {
@@ -630,6 +861,11 @@ i2c14mux0chn5: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
 		};
 
 		i2c14mux0chn6: i2c@6 {
@@ -661,12 +897,37 @@ i2c15mux0chn0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
 		};
 
 		i2c15mux0chn1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			regulator@40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator@41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator@58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator@5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
 		};
 
 		i2c15mux0chn2: i2c@2 {
@@ -760,6 +1021,11 @@ i2c15mux0chn7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
+
+			regulator@40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
 		};
 	};
 };
-- 
2.39.2

