Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5547983F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjIHIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjIHIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:24:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9504173B;
        Fri,  8 Sep 2023 01:24:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885T77P028148;
        Fri, 8 Sep 2023 08:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6MXIs0llYrksAiV+346HggGDRxAaCXDPFpOUeyDxxu0=;
 b=MerQwxMiRwkx2dN4kVD30PS1khSX++2ByWcaJWrbMMtgypuJkomCSV9lqFny4AwLTB3Z
 hg7mj6RLNxCIaKMa6abQadzZE4US7I2RhVmDnVSxSYk3JW5zs3y8IwbNNGLTWaruXxMr
 r8AizhwY3AiGuPWHniKYrEJXR8jPTKsBZCa4OBuC7hgLEFT/Uek50b8wmxpAjqdcbYfM
 1TvyG6tanWLa0Y65GHHB5hDzq9tYw+6BmqjYZ4+/VduNJoV5JEXFt/fEkCDP573rF4aq
 Q6ovip5chzhl4p/4I3Xprmqcm40gC6Zt/kRj5wrYdlabBIPctkRjmMCgfmMkAGLX1qeV Gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syk9nsee3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:23:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3888Nq1C012630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 08:23:52 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 01:23:44 -0700
Message-ID: <ca6c570c-edd5-4c52-8d5f-f134ac47fb78@quicinc.com>
Date:   Fri, 8 Sep 2023 16:23:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: add uart console support for SM4450
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-7-quic_tengfan@quicinc.com>
 <9626f079-22f3-5327-5a45-23e5dfcda5c6@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <9626f079-22f3-5327-5a45-23e5dfcda5c6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GzIny7tbo-k1zYxrHVx5F2SNfoq2dduZ
X-Proofpoint-GUID: GzIny7tbo-k1zYxrHVx5F2SNfoq2dduZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 4:13 PM, Krzysztof Kozlowski 写道:
> On 08/09/2023 08:58, Tengfei Fan wrote:
>> Add base description of UART, TLMM, interconnect, TCSRCC and SMMU nodes
>> which helps SM4450 boot to shell with console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  14 +-
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi    | 258 ++++++++++++++++++++++++
>>   2 files changed, 270 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> index 00a1c81ca397..bb8c58fb4267 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -10,9 +10,19 @@
>>   	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>>   	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>>   
>> -	aliases { };
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>>   
>>   	chosen {
>> -		bootargs = "console=hvc0";
>> +		stdout-path = "serial0:115200n8";
> 
> Wait, what? You told me you cannot use serial and stdout-path!
> 
> https://lore.kernel.org/all/f0f94ea9-94b1-ccd1-0a43-3cb119fc5d94@quicinc.com/
maybe there is some misunderstand, there are two stages about SM4450 DT 
patches:
     frist stage only support DCC console( 
https://lore.kernel.org/all/f0f94ea9-94b1-ccd1-0a43-3cb119fc5d94@quicinc.com/ 
) due to related clock pathes hadn't ready.
     second stage(current review DT patches series), related clock 
patches already done, so add uart console support(use serial and 
stdout-path)
> 
>>   	};
>>   };
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index 2395b1d655a2..3af7255fca35 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -7,6 +7,8 @@
>>   #include <dt-bindings/clock/qcom,sm4450-gcc.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>> +#include <dt-bindings/interconnect/qcom,sm4450.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> @@ -262,6 +264,26 @@
>>   		};
>>   	};
>>   
>> +	firmware {
>> +		scm: scm {
>> +			compatible = "qcom,scm-sm4450", "qcom,scm";
>> +			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>> +			#reset-cells = <1>;
>> +		};
>> +	};
>> +
>> +	clk_virt: interconnect-0 {
>> +		compatible = "qcom,sm4450-clk-virt";
>> +		#interconnect-cells = <2>;
>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>> +	};
>> +
>> +	mc_virt: interconnect-1 {
>> +		compatible = "qcom,sm4450-mc-virt";
>> +		#interconnect-cells = <2>;
>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>> +	};
>> +
>>   	memory@a0000000 {
>>   		device_type = "memory";
>>   		/* We expect the bootloader to fill in the size */
>> @@ -387,12 +409,118 @@
>>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>>   		};
>>   
>> +		qupv3_id_0: geniqup@ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x00ac0000 0x0 0x2000>;
>> +			ranges;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			iommus = <&apps_smmu 0x163 0x0>;
>> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
>> +			interconnect-names = "qup-core";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			status = "disabled";
>> +
>> +			uart7: serial@a88000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0 0x00a88000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		aggre1_noc: interconnect@16e0000 {
>> +			tible = "qcom,sm4450-aggre1-noc";
>> +			reg = <0 0x016e0000 0 0x1c080>;
>> +			#interconnect-cells = <2>;
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +		};
>> +
>> +		aggre2_noc: interconnect@1700000 {
>> +			compatible = "qcom,sm4450-aggre2-noc";
>> +			reg = <0 0x01700000 0 0x31080>;
>> +			#interconnect-cells = <2>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +			clocks = <&rpmhcc RPMH_IPA_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
>> +		};
>> +
>> +		cnoc2: interconnect@1500000 {
> 
> Keep order by unit address.
will update.
> 
>> +			compatible = "qcom,sm4450-cnoc2";
>> +			reg = <0 0x1500000 0 0x6200>;
>> +			#interconnect-cells = <2>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +		};
>> +
> 
> ...
> 
>> +
>>   		intc: interrupt-controller@17200000 {
>>   			compatible = "arm,gic-v3";
>>   			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
>> @@ -480,4 +711,31 @@
>>   			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>   			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>>   	};
>> +
>> +	tlmm: pinctrl@f100000 {
> 
> You did not test it... This node cannot be here and tools will tell you
> this. No need for review from us - tools are doing this.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
I did related test before through "makeDT_CHECKER_FLAGS=-m dtbs_check", 
will do test again using "make dtbs_check W=1".
>> +		compatible = "qcom,sm4450-tlmm";
>> +		reg = <0 0x0f100000 0 0x300000>;
>> +		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		gpio-ranges = <&tlmm 0 0 137>;
>> +		wakeup-parent = <&pdc>;
>> +
>> +		qup_uart7_rx: qup-uart7-rx-state {
>> +			pins = "gpio22";
>> +			function = "qup1_se2_l2";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +
>> +		qup_uart7_tx: qup-uart7-tx-state {
>> +			pins = "gpio22";
>> +			function = "qup1_se2_l2";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
> 
> Stray blank line.
> 
>>   };
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
