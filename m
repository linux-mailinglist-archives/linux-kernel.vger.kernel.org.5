Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4675BC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGUB7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:59:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10E270B;
        Thu, 20 Jul 2023 18:59:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1Qsro002812;
        Fri, 21 Jul 2023 01:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2r1+kDqeCUg5/bQQnaha8bVR6ezO0wmP3FkcgxmSBL8=;
 b=UgW4ghH18rR+Ck1wmFUrDVNGD3IKE+F7TaWG1dc402kizgpKtomRvSPV+/4fcYIiWBOy
 v6IuCIOG3Tcmgn7NJTYIMN/IXIl/V6L6CFuKKorKNXdXJFjeQrpbUNEj+/SUtHzfT6jV
 Z79uwIUG+RtLVnjax9XP2vT+pS+4Voyn0PsrUA25jxb/5ejZuz2u0NinbAcdpPFAmtXP
 X4AHUQHutbOrMl5Alc4inGk5d32t1lYBmR5ymCjkpkiAFqqd9Pc0XFdIL0NWoUhROfEE
 LLTZ2WMVCW8LsuJbUSmR7GXWPqORwwacqrNtxTi5/o9XDswjzU9fSOPUsdOVkYT5NjRo Gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyquaey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 01:59:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L1xUVh005615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 01:59:30 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 18:59:27 -0700
Message-ID: <5c85f201-8659-7279-bdc1-f61bb2700678@quicinc.com>
Date:   Fri, 21 Jul 2023 09:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: Add base SM4450 DTSI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-2-quic_tengfan@quicinc.com>
 <18520c7a-2e12-cc29-3071-b5d98a20a42b@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <18520c7a-2e12-cc29-3071-b5d98a20a42b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KJrjJqPeWtG33JDJA_qyWVVp44Q-TkPC
X-Proofpoint-ORIG-GUID: KJrjJqPeWtG33JDJA_qyWVVp44Q-TkPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=705 malwarescore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:22 PM, Krzysztof Kozlowski 写道:
> On 19/07/2023 12:01, Tengfei Fan wrote:
>> This add based DTSI for SM4450 SoC and includes base description of
>> CPUs and interrupt-controller which helps to boot to shell with
>> console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 435 +++++++++++++++++++++++++++
>>   1 file changed, 435 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> new file mode 100644
>> index 000000000000..ab14aecbdcea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -0,0 +1,435 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	chosen { };
>> +
>> +	clocks{
>> +		xo_board: xo_board {
> 
> Please start your work from scratch from mainline SoC, so we won't have
> to point you all these obvious issues which we fixed long time ago. Just
> pick the most recent SoC, like SM8550.
sure will pick like SM8550 and reference it.
> 
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <76800000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sleep_clk: sleep_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +	};
> 
> ...
> 
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm: scm {
>> +			compatible = "qcom,scm-sm4450", "qcom,scm";
> 
> Undocumented compatible. If you plan to document it further, then please
> check if your patches are correctly ordered. Bindings are always before
> their users.
will remove this SCM node due to haven't use currently, and will check 
other undocumented compatible and document it.
> 
>> +			#reset-cells = <1>;
>> +		};
>> +	};
>> +
>> +	memory@a0000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the size */
>> +		reg = <0x0 0xa0000000 0x0 0x0>;
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +
>> +		CPU_PD0: power-domain-cpu0 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD1: power-domain-cpu1 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD2: power-domain-cpu2 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD3: power-domain-cpu3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD4: power-domain-cpu4 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD5: power-domain-cpu5 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD6: power-domain-cpu6 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD7: power-domain-cpu7 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cpu-cluster0 {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
>> +		dma-ranges = <0 0 0 0 0x10 0>;
>> +		compatible = "simple-bus";
>> +
>> +		tcsr_mutex: hwlock@1f40000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x0 0x01f40000 0x0 0x40000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		pdc: interrupt-controller@b220000 {
>> +			compatible = "qcom,sm4450-pdc", "qcom,pdc";
>> +			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
>> +			qcom,pdc-ranges = <0 480 94>, <94 494 31>, <125 63 1>;
>> +			#interrupt-cells = <2>;
>> +			interrupt-parent = <&intc>;
>> +			interrupt-controller;
>> +		};
>> +
>> +		intc: interrupt-controller@17200000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
>> +				<0x0 0x17260000 0x0 0x100000>;    /* GICR * 8 */
> 
> reg is always after compatible. Then ranges follow.
will update sequence.
> 
> Also, indentation looks not aligned here.
V2 patch will aligne.
> 
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>> +		};
>> +
>> +		timer@17420000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0 0 0x20000000>;
>> +			reg = <0x0 0x17420000 0x0 0x1000>;
> 
> Same problem... some weird ordering.
will update sequence.
> 
>> +			clock-frequency = <19200000>;
> 
> Are you sure this property is allowed in new designs?
will remove this property.
> 
>> +
>> +			frame@17421000 {
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +						<GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17421000 0x1000>,
>> +					<0x17422000 0x1000>;
>> +			};
>> +
>> +			frame@17423000 {
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17423000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17425000 {
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17425000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17427000 {
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17427000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17429000 {
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17429000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742b000 {
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x1742b000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742d000 {
>> +				frame-number = <6>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x1742d000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
> 
> Are you sure this property is allowed in new designs?
will remove this property.
> 
>> +	};
>> +};
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
