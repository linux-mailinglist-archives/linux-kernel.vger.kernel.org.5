Return-Path: <linux-kernel+bounces-620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CC8143A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD771C2272A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7A15488;
	Fri, 15 Dec 2023 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iqycjsbN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFD17737;
	Fri, 15 Dec 2023 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4LZ3s008727;
	Fri, 15 Dec 2023 08:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZvFvm2RMVDk1gOvLljHKDP3vNZgohfYhNfcqEPvL5PE=; b=iq
	ycjsbNSbc8gVeEAxjH6GfgD5fstN5LqWs5ZpQgdcv/Opi9lMAEutKDjw4OSOMXTo
	/SYz0Hy7ifBFpeQP4S4TKcMJy1vcR03/dqp8jcgZfAvQfiPaqdC4HiWYEHVf8uSO
	gIdqobO9CfA4urpl2/gXAPZee3LNyhkAJonVNG2pXnUI44GMJV7i9DxlNyvXk+oR
	X5CaMtX49B1+mNmvCjamEz/BWNh+yzsUz2tcMHfHMsF1hONF6p+b21tFbFnQ4OB9
	QS/dp5CDu6+8DpyQ+v0WLplyuA24Zs6yJ6/7Ol46l9aFtOqVySc/YAioyHW6EQb8
	vwq4yGU3CruWY9VhONPA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v07c62dga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 08:28:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF8SufU019021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 08:28:56 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 00:28:51 -0800
Message-ID: <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
Date: Fri, 15 Dec 2023 16:28:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
 <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7pkE3Y91s6H1h_kW-7JTAlQtPyxRanGc
X-Proofpoint-ORIG-GUID: 7pkE3Y91s6H1h_kW-7JTAlQtPyxRanGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150055



On 12/15/2023 3:27 PM, Krzysztof Kozlowski wrote:
> On 14/12/2023 10:03, Luo Jie wrote:
>> Update the yaml file for the new DTS properties.
>>
>> 1. cmn-reference-clock for the CMN PLL source clock select.
>> 2. clock-frequency for MDIO clock frequency config.
>> 3. add uniphy AHB & SYS GCC clocks.
>> 4. add reset-gpios for MDIO bus level reset.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 +++++++++++++++++-
>>   1 file changed, 139 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> index 3407e909e8a7..79f8513739e7 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> @@ -20,6 +20,8 @@ properties:
>>             - enum:
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq9574-mdio
>> +              - qcom,ipq5332-mdio
>>             - const: qcom,ipq4019-mdio
>>   
>>     "#address-cells":
>> @@ -30,19 +32,77 @@ properties:
>>   
>>     reg:
>>       minItems: 1
>> -    maxItems: 2
>> +    maxItems: 5
>>       description:
>> -      the first Address and length of the register set for the MDIO controller.
>> -      the second Address and length of the register for ethernet LDO, this second
>> -      address range is only required by the platform IPQ50xx.
>> +      the first Address and length of the register set for the MDIO controller,
>> +      the optional second, third and fourth address and length of the register
>> +      for ethernet LDO, these three address range are required by the platform
>> +      IPQ50xx/IPQ5332, the last address and length is for the CMN clock to
>> +      select the reference clock.
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    maxItems: 5
>>   
>>     clocks:
>> +    minItems: 1
>>       items:
>>         - description: MDIO clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>   
>>     clock-names:
>> +    minItems: 1
>>       items:
>>         - const: gcc_mdio_ahb_clk
>> +      - const: uniphy0_ahb
>> +      - const: uniphy1_ahb
>> +      - const: uniphy0_sys
>> +      - const: uniphy1_sys
>> +
>> +  cmn-reference-clock:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Nothing improved here

With this change, the warning is not reported when i run
dt_binding_check, looks the new added property needs
the type ref to avoid the warning reported.

> 
>> +    oneOf:
>> +      - items:
> 
> So it is enum or not?

it's enum, i will remove the "oneOf: - items:" in the next patch set.

> 
>> +          - enum:
>> +              - 0   # CMN PLL reference internal 48MHZ
>> +              - 1   # CMN PLL reference external 25MHZ
>> +              - 2   # CMN PLL reference external 31250KHZ
>> +              - 3   # CMN PLL reference external 40MHZ
>> +              - 4   # CMN PLL reference external 48MHZ
>> +              - 5   # CMN PLL reference external 50MHZ
>> +              - 6   # CMN PLL reference internal 96MHZ
>> +
>> +  clock-frequency:
>> +    oneOf:
>> +      - items:
> 
> Same questions

it's enum.

> 
>> +          - enum:
>> +              - 12500000
>> +              - 6250000
>> +              - 3125000
>> +              - 1562500
>> +              - 781250
>> +              - 390625
>> +    description:
>> +      The MDIO bus clock that must be output by the MDIO bus hardware,
>> +      only the listed frequencies above can be supported, other frequency
>> +      will cause malfunction. If absent, the default hardware value 0xff
>> +      is used, which means the default MDIO clock frequency 390625HZ, The
>> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
>> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
>> +      register, there is higher clock frequency requirement on the normal
>> +      working case where the MDIO slave devices support high clock frequency.
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  reset-assert-us:
>> +    maxItems: 1
> 
> This does not look related to ipq5332.

The reset gpio properties are needed on ipq5332, since qca8084 phy is
connected, which uses the MDIO bus level gpio reset.

Without declaring these gpio properties, the warning will be reported
by dt_binding_check.

> 
>> +
>> +  reset-deassert-us:
>> +    maxItems: 1
> 
> Neither this.

same as above.

> 
>>   
>>   required:
>>     - compatible
>> @@ -61,6 +121,8 @@ allOf:
>>                 - qcom,ipq5018-mdio
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq5332-mdio
>> +              - qcom,ipq9574-mdio
>>       then:
>>         required:
>>           - clocks
>> @@ -70,6 +132,20 @@ allOf:
>>           clocks: false
>>           clock-names: false
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq5332-mdio
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 5
>> +          maxItems: 5
>> +        reg-names:
>> +          minItems: 4
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>> @@ -100,3 +176,62 @@ examples:
>>           reg = <4>;
>>         };
>>       };
>> +
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    mdio@90000 {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      compatible = "qcom,ipq5332-mdio",
>> +                   "qcom,ipq4019-mdio";
>> +      cmn-reference-clock = <0>;
>> +      clock-frequency = <6250000>;
>> +
>> +      reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
>> +      reset-assert-us = <100000>;
>> +      reset-deassert-us = <100000>;
>> +
>> +      reg = <0x90000 0x64>,
>> +            <0x9B000 0x800>,
>> +            <0x7A00610 0x4>,
>> +            <0x7A10610 0x4>;
> 
> Lowercase hex, wrong order of properties. Align it with coding style.

will correct it in the next patch set, thanks.

> 
> 
> 
> Best regards,
> Krzysztof
> 

