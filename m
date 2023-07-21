Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A875BC04
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGUByH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUByG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:54:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE03270B;
        Thu, 20 Jul 2023 18:54:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1UUsC026957;
        Fri, 21 Jul 2023 01:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w2/EA3gR0F1AJ4FvWg3BFVqSZc9yJxPAm53RfZb2aaY=;
 b=CExlAb9IcIkUrQ+YKytBIRmqGUBO2xqwrV74swWVj01TrbNVUAqxSC/lLhtNB5HGhRjk
 oofPagKH6MGE52GtugtyFIeBh/NgpEOocr+O9dwW3FxY8yONg+sR97pQnwG1rC+QCANf
 ktO1MCdYLCERlH94+I6GogiePCm8k3Fc9Rva8T2rXOY6PUYxeFi2tjJpZ4SqU6FFjwXX
 zcmHhK/rELhF85HOKAiibZ3MUje9ovePSC2s/zBDXr+7WyaqzxaZmG+BU9Gccoa6PVXB
 XjB7UvITuvtg2/br9UwvFCCCtkh7mqsbTKRShZklQZ3d/NpPLhhpf92W3pIW1tbTvLQ7 Vg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxt18ayy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 01:53:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L1rvij032248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 01:53:57 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 18:53:54 -0700
Message-ID: <34c2ba43-df3d-3a48-69cb-67dc733abe05@quicinc.com>
Date:   Fri, 21 Jul 2023 09:53:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: Add base SM4450 DTSI
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <7b9bdd6c-6c76-06a9-ccce-f120c80c5860@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <7b9bdd6c-6c76-06a9-ccce-f120c80c5860@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SDjYAPgRpaejftXSaobpKFRtKLDOKUJ9
X-Proofpoint-GUID: SDjYAPgRpaejftXSaobpKFRtKLDOKUJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=628 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:14 PM, Dmitry Baryshkov 写道:
> On 19/07/2023 13:01, Tengfei Fan wrote:
>> This add based DTSI for SM4450 SoC and includes base description of
>> CPUs and interrupt-controller which helps to boot to shell with
>> console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 435 +++++++++++++++++++++++++++
>>   1 file changed, 435 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> new file mode 100644
>> index 000000000000..ab14aecbdcea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -0,0 +1,435 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +    interrupt-parent = <&intc>;
>> +
>> +    #address-cells = <2>;
>> +    #size-cells = <2>;
>> +
>> +    chosen { };
>> +
>> +    clocks{
>> +        xo_board: xo_board {
> 
> no underscores in node names.
V2 patch will update "xo_board: xo_board" to "xo_board: xo-board", also 
"sleep_clk: sleep_clk" to "sleep_clk: sleep-clk".
> 
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <76800000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        sleep_clk: sleep_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <32000>;
>> +            #clock-cells = <0>;
>> +        };
>> +    };
>> +
>> +    cpus {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +
>> +        CPU0: cpu@0 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x0>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_0>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
> 
> empty lines before child nodes, please (here and further in the patch).
sure, V2 patch will add empty lines before child nodes(this and other 
child nodes).
> 
>> +            L2_0: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +                L3_0: l3-cache {
>> +                    compatible = "cache";
>> +                    cache-level = <3>;
>> +                    cache-unified;
>> +                };
>> +            };
>> +        };
>> +
>> +        CPU1: cpu@100 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x100>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_100>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_100: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU2: cpu@200 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x200>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_200>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_200: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU3: cpu@300 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x300>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_300>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_300: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU4: cpu@400 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x400>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_400>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_400: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU5: cpu@500 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x500>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_500>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_500: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU6: cpu@600 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x600>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_600>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_600: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        CPU7: cpu@700 {
>> +            device_type = "cpu";
>> +            compatible = "qcom,kryo";
>> +            reg = <0x0 0x700>;
>> +            enable-method = "psci";
>> +            next-level-cache = <&L2_700>;
>> +            power-domains = <&CPU_PD0>;
>> +            power-domain-names = "psci";
>> +            #cooling-cells = <2>;
>> +            L2_700: l2-cache {
>> +                compatible = "cache";
>> +                cache-level = <2>;
>> +                cache-unified;
>> +                next-level-cache = <&L3_0>;
>> +            };
>> +        };
>> +
>> +        cpu-map {
>> +            cluster0 {
>> +                core0 {
>> +                    cpu = <&CPU0>;
>> +                };
>> +
>> +                core1 {
>> +                    cpu = <&CPU1>;
>> +                };
>> +
>> +                core2 {
>> +                    cpu = <&CPU2>;
>> +                };
>> +
>> +                core3 {
>> +                    cpu = <&CPU3>;
>> +                };
>> +
>> +                core4 {
>> +                    cpu = <&CPU4>;
>> +                };
>> +
>> +                core5 {
>> +                    cpu = <&CPU5>;
>> +                };
>> +            };
>> +
>> +            cluster1 {
> 
> If this SoC implements Dynamiq architecture, you don't need separate 
> clusters.
V2 patch will not separate clusters.
> 
>> +                core6 {
>> +                    cpu = <&CPU6>;
>> +                };
>> +
>> +                core7 {
>> +                    cpu = <&CPU7>;
>> +                };
>> +            };
>> +        };
>> +
>> +        idle-states {
>> +            entry-method = "psci";
>> +
>> +            LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>> +                compatible = "arm,idle-state";
>> +                idle-state-name = "silver-rail-power-collapse";
>> +                arm,psci-suspend-param = <0x40000004>;
>> +                entry-latency-us = <800>;
>> +                exit-latency-us = <750>;
>> +                min-residency-us = <4090>;
>> +                local-timer-stop;
>> +            };
>> +
>> +            BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>> +                compatible = "arm,idle-state";
>> +                idle-state-name = "gold-rail-power-collapse";
>> +                arm,psci-suspend-param = <0x40000004>;
>> +                entry-latency-us = <600>;
>> +                exit-latency-us = <1550>;
>> +                min-residency-us = <4791>;
>> +                local-timer-stop;
>> +            };
>> +        };
>> +
>> +        domain-idle-states {
>> +            CLUSTER_SLEEP_0: cluster-sleep-0 {
>> +                compatible = "domain-idle-state";
>> +                arm,psci-suspend-param = <0x41000044>;
>> +                entry-latency-us = <1050>;
>> +                exit-latency-us = <2500>;
>> +                min-residency-us = <5309>;
>> +            };
>> +
>> +            CLUSTER_SLEEP_1: cluster-sleep-1 {
>> +                compatible = "domain-idle-state";
>> +                idle-state-name = "cluster-power-collapse";
>> +                arm,psci-suspend-param = <0x41003344>;
>> +                entry-latency-us = <1561>;
>> +                exit-latency-us = <2801>;
>> +                min-residency-us = <8550>;
>> +            };
>> +        };
>> +    };
>> +
>> +    firmware {
>> +        scm: scm {
>> +            compatible = "qcom,scm-sm4450", "qcom,scm";
>> +            #reset-cells = <1>;
> 
> Does the SCM need the core clock?
V2 patch will remove this SCM node due to it haven't useful currently.
> 
>> +        };
>> +    };
>> +
>> +    memory@a0000000 {
>> +        device_type = "memory";
>> +        /* We expect the bootloader to fill in the size */
>> +        reg = <0x0 0xa0000000 0x0 0x0>;
>> +    };
>> +
>> +    pmu {
>> +        compatible = "arm,armv8-pmuv3";
>> +        interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> +
>> +    psci {
>> +        compatible = "arm,psci-1.0";
>> +        method = "smc";
>> +
>> +        CPU_PD0: power-domain-cpu0 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD1: power-domain-cpu1 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD2: power-domain-cpu2 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD3: power-domain-cpu3 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD4: power-domain-cpu4 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD5: power-domain-cpu5 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD6: power-domain-cpu6 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CPU_PD7: power-domain-cpu7 {
>> +            #power-domain-cells = <0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +            domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +        };
>> +
>> +        CLUSTER_PD: power-domain-cpu-cluster0 {
>> +            #power-domain-cells = <0>;
>> +            domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>> +        };
>> +    };
>> +
>> +    soc: soc@0 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0 0 0 0 0x10 0>;
>> +        dma-ranges = <0 0 0 0 0x10 0>;
>> +        compatible = "simple-bus";
>> +
>> +        tcsr_mutex: hwlock@1f40000 {
>> +            compatible = "qcom,tcsr-mutex";
>> +            reg = <0x0 0x01f40000 0x0 0x40000>;
>> +            #hwlock-cells = <1>;
>> +        };
>> +
>> +        pdc: interrupt-controller@b220000 {
>> +            compatible = "qcom,sm4450-pdc", "qcom,pdc";
> 
> Missing binding update
V2 patch will update binding.
> 
>> +            reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
>> +            qcom,pdc-ranges = <0 480 94>, <94 494 31>, <125 63 1>;
>> +            #interrupt-cells = <2>;
>> +            interrupt-parent = <&intc>;
>> +            interrupt-controller;
>> +        };
>> +
>> +        intc: interrupt-controller@17200000 {
>> +            compatible = "arm,gic-v3";
>> +            #interrupt-cells = <3>;
>> +            interrupt-controller;
>> +            #redistributor-regions = <1>;
>> +            redistributor-stride = <0x0 0x20000>;
>> +            reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
>> +                <0x0 0x17260000 0x0 0x100000>;    /* GICR * 8 */
> 
> Please align vertically.
V2 patch will align.
> 
>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>> +        };
>> +
>> +        timer@17420000 {
>> +            compatible = "arm,armv7-timer-mem";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges = <0 0 0 0x20000000>;
>> +            reg = <0x0 0x17420000 0x0 0x1000>;
>> +            clock-frequency = <19200000>;
>> +
>> +            frame@17421000 {
>> +                frame-number = <0>;
>> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> 
> Please align vertically.
V2 patch will align.
> 
>> +                reg = <0x17421000 0x1000>,
>> +                    <0x17422000 0x1000>;
>> +            };
>> +
>> +            frame@17423000 {
>> +                frame-number = <1>;
>> +                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x17423000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +
>> +            frame@17425000 {
>> +                frame-number = <2>;
>> +                interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x17425000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +
>> +            frame@17427000 {
>> +                frame-number = <3>;
>> +                interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x17427000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +
>> +            frame@17429000 {
>> +                frame-number = <4>;
>> +                interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x17429000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +
>> +            frame@1742b000 {
>> +                frame-number = <5>;
>> +                interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x1742b000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +
>> +            frame@1742d000 {
>> +                frame-number = <6>;
>> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +                reg = <0x1742d000 0x1000>;
>> +                status = "disabled";
>> +            };
>> +        };
>> +    };
>> +
>> +    timer {
>> +        compatible = "arm,armv8-timer";
>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | 
>> IRQ_TYPE_LEVEL_LOW)>,
> 
> Please align vertically.
V2 patch will align.
> 
>> +                <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +                <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | 
>> IRQ_TYPE_LEVEL_LOW)>;
>> +        clock-frequency = <19200000>;
>> +    };
>> +};
> 

-- 
Thx and BRs,
Tengfei Fan
