Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF58475BC15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGUCDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGUCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:03:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A672D4D;
        Thu, 20 Jul 2023 19:03:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1opis020331;
        Fri, 21 Jul 2023 02:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NLTLbZAJWWbgCyh5mvmoLr5Retyg3rB1dikaXJK5r9w=;
 b=mt7xbcanl1DuQ6ajJuRR8P8JVfDpv2TfEsFo16HzCb7iv6tUkAUxHv5dBjO81JYF6mcW
 KiSdqYJwkkI9moGfhWHIElcibDy9U0sqe76IFlkEJ9bMnf0r+kpp1tP9EOtegkiDrTKI
 eI0/qcvVRpu7EIKcuu2AFq1o1Gk7mAC7QU8LxWH930gZqNvrmoRWwtkHAXa+C0eu7Mis
 g/55m7Tbvgg3zfl1V0a390FPaSkC401Xqmw1p4YwbYNhCyXcVXmnqniGfMGaKRpvf0eM
 BDKJn10cm39A744CfQ3H8A+89zAKUpZ5omcqVq3J4sYNJdyY8wODkXQBOw0kAZDGlVpF KA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryfyf03dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:03:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L23UFm010063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:03:30 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:03:27 -0700
Message-ID: <f181b6e1-bedd-68fe-be53-93cf10960d9d@quicinc.com>
Date:   Fri, 21 Jul 2023 10:03:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: Add base SM4450 DTSI
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-2-quic_tengfan@quicinc.com>
 <a590f1c3-dc8b-ca12-9323-df195244a87f@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <a590f1c3-dc8b-ca12-9323-df195244a87f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qP8iqfmLBQKIufLusNeXEOXrWssOhO2T
X-Proofpoint-ORIG-GUID: qP8iqfmLBQKIufLusNeXEOXrWssOhO2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=550 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/20/2023 3:54 PM, Konrad Dybcio 写道:
> On 19.07.2023 12:01, Tengfei Fan wrote:
>> This add based DTSI for SM4450 SoC and includes base description of
>> CPUs and interrupt-controller which helps to boot to shell with
>> console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> [...]
> 
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
> Please sort them alphabetically
V2 patch will resort them.
> 
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
> [...]
> 
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo";
> Please post dmesg | grep '\[', this is probably a standard ARM core.
sure, will do and update this compatible.
> 
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>> +			#cooling-cells = <2>;
>> +			L2_0: l2-cache {
> Missing a newline before subnodes
V2 patch will add newline.
> 
>> +				compatible = "cache";
>> +				cache-level = <2>;
>> +				cache-unified;
>> +				next-level-cache = <&L3_0>;
>> +				L3_0: l3-cache {
> Ditto
V2 patch will add newline.
> 
>> +					compatible = "cache";
>> +					cache-level = <3>;
>> +					cache-unified;
>> +				};
>> +			};
>> +		};
> [...]
> 
>> +
>> +		intc: interrupt-controller@17200000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
>> +				<0x0 0x17260000 0x0 0x100000>;    /* GICR * 8 */
> Misasligned
V2 patch will align.
> 
> also, please move reg and interrupts after compatible
V2 patch will resort.
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
>> +			clock-frequency = <19200000>;
> Drop clock-frequency
V2 patch will Drop this clock-frequency node.
> 
> [...]
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> Misaligned
V2 patch will align.
> 
>> +		clock-frequency = <19200000>;
> Drop
V2 patch will drop.
> 
> Konrad
>> +	};
>> +};

-- 
Thx and BRs,
Tengfei Fan
