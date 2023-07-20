Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E8275A55D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGTFKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGTFKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:10:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70005EC;
        Wed, 19 Jul 2023 22:10:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3lMPT032502;
        Thu, 20 Jul 2023 05:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mf1zKhHwrRsaeegpLZNytRKQo0loCluldkLPQC3NHqs=;
 b=jles9r46wR0ZDtQCxMK7LDmBsiHqWCA1iABxa8FyuoBSpKDPK5rpPUlt/jRZU63TLvcF
 dTVN7rAXDX401eWdLxkE7NPLvHGIZ2QXgweq8GLyp84/XdxxBbgK+1BNJazRRMQ/JHxI
 kEALG4vpZyfySthogrdAexD4MHepuuD8d8ITbWD+hzekzoLvmc7yu/v0tZh7gcn3MQCQ
 HjYPCV8fl+tHqavlmucXvTrMxUpHs93kBPSOBMhuw33p6l48zJeW0gJOmn50vqOaHzGR
 sFbN6PXrfsn4geUR0XEChlA88/6o0h/R+mBN2/IGJZyn0hWCjhiVR3Je0WtQVd3u/AVg BA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3v9p74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 05:10:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K5AYfF017630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 05:10:34 GMT
Received: from [10.216.4.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 22:10:30 -0700
Message-ID: <fbb13c2d-6d60-0e51-c980-3e79a68a1931@quicinc.com>
Date:   Thu, 20 Jul 2023 10:40:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi
 file
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230713105909.14209-1-quic_anusha@quicinc.com>
 <20230713105909.14209-2-quic_anusha@quicinc.com>
 <2bf7ac6e-eeba-a082-2b0e-4fc302bef70a@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <2bf7ac6e-eeba-a082-2b0e-4fc302bef70a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _H7aTQ_TUUu7vFOpbTG404qqGGw4BPly
X-Proofpoint-ORIG-GUID: _H7aTQ_TUUu7vFOpbTG404qqGGw4BPly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200041
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2023 7:28 PM, Konrad Dybcio wrote:
> On 13.07.2023 12:59, Anusha Rao wrote:
>> Add a dtsi file to include interfaces that are common
>> across RDPs.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
> [...]
>
>>   		data-pins {
>>   			pins = "gpio0", "gpio1", "gpio2",
>> -			       "gpio3", "gpio6", "gpio7",
>> -			       "gpio8", "gpio9";
>> +				"gpio3", "gpio6", "gpio7",
>> +				"gpio8", "gpio9";
> This (and a similar one in the other file) change looks unrelated
> and I think it makes the indentation worse :/
Thanks, will fix this in next spin.

Thanks,
Anusha
> Konrad
>>   			function = "sdc_data";
>>   			drive-strength = <8>;
>>   			bias-pull-up;
>> @@ -110,15 +60,4 @@
>>   			bias-pull-down;
>>   		};
>>   	};
>> -
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 877026ccc6e2..7685176f90ef 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -8,69 +8,11 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>>   	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>> -
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -
>> -	regulator_fixed_3p3: s3300 {
>> -		compatible = "regulator-fixed";
>> -		regulator-min-microvolt = <3300000>;
>> -		regulator-max-microvolt = <3300000>;
>> -		regulator-boot-on;
>> -		regulator-always-on;
>> -		regulator-name = "fixed_3p3";
>> -	};
>> -
>> -	regulator_fixed_0p925: s0925 {
>> -		compatible = "regulator-fixed";
>> -		regulator-min-microvolt = <925000>;
>> -		regulator-max-microvolt = <925000>;
>> -		regulator-boot-on;
>> -		regulator-always-on;
>> -		regulator-name = "fixed_0p925";
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -
>> -		mp5496_l2: l2 {
>> -			regulator-min-microvolt = <1800000>;
>> -			regulator-max-microvolt = <1800000>;
>> -			regulator-always-on;
>> -			regulator-boot-on;
>> -		};
>> -	};
>>   };
>>   
>>   &sdhc_1 {
>> @@ -85,10 +27,6 @@
>>   	status = "okay";
>>   };
>>   
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>>   &tlmm {
>>   	sdc_default_state: sdc-default-state {
>>   		clk-pins {
>> @@ -107,8 +45,8 @@
>>   
>>   		data-pins {
>>   			pins = "gpio0", "gpio1", "gpio2",
>> -			       "gpio3", "gpio6", "gpio7",
>> -			       "gpio8", "gpio9";
>> +				"gpio3", "gpio6", "gpio7",
>> +				"gpio8", "gpio9";
>>   			function = "sdc_data";
>>   			drive-strength = <8>;
>>   			bias-pull-up;
>> @@ -122,30 +60,3 @@
>>   		};
>>   	};
>>   };
>> -
>> -&usb_0_dwc3 {
>> -	dr_mode = "host";
>> -};
>> -
>> -&usb_0_qmpphy {
>> -	vdda-pll-supply = <&mp5496_l2>;
>> -	vdda-phy-supply = <&regulator_fixed_0p925>;
>> -
>> -	status = "okay";
>> -};
>> -
>> -&usb_0_qusbphy {
>> -	vdd-supply = <&regulator_fixed_0p925>;
>> -	vdda-pll-supply = <&mp5496_l2>;
>> -	vdda-phy-dpdm-supply = <&regulator_fixed_3p3>;
>> -
>> -	status = "okay";
>> -};
>> -
>> -&usb3 {
>> -	status = "okay";
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>> -};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> index c8fa54e1a62c..d36d1078763e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> @@ -8,73 +8,10 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
>>   	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> index f01de6628c3b..c30c9fbedf26 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> @@ -8,73 +8,10 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
>>   	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>> index 6efae3426cb8..0dc382f5d5ec 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>> @@ -8,73 +8,9 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9";
>>   	compatible = "qcom,ipq9574-ap-al02-c9", "qcom,ipq9574";
>> -
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };

