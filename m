Return-Path: <linux-kernel+bounces-11398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F481E5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EC9282E41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE34C62B;
	Tue, 26 Dec 2023 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kV+p3VQ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C344C601;
	Tue, 26 Dec 2023 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQ50jvd026787;
	Tue, 26 Dec 2023 07:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eoPyq4LZ/oSwSIXXIlTDWF4UrykOrzzTYxAodt+j/fg=; b=kV
	+p3VQ0oGjDwaWZEcT5Jo3nE74DfXcQTvQLPP5+VPZ7DagVsqNpf2MwiDRdJVVZKf
	7NzKeq9PrbjWmq6qI54a77woLvbCYysPlBikn/s5I5dD3hlw22WZQzaaTYIvOBQS
	4pClkDPVWGpwaEXtREEpIhuZ8MQxyZlaK/fwNkV7yb5ief9v40SoMCoDkSbLKF5H
	dfLjwdgkiOKOcxSZ4HAAVg+XZAZCQbil8Z61XJgJedZ6jCReT/enqyGt43rKwbXS
	i0QwtKrPsTx3lzfVO/p+ILrfVlGuJ2k+UjqxPGh6C0mWQ1LNeOhRYYtX6TBIXCmM
	ImJhWSQ8ojrDSw/2UCEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7gd98x94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 07:25:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQ7PqNF020407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 07:25:52 GMT
Received: from [10.253.14.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 23:25:46 -0800
Message-ID: <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
Date: Tue, 26 Dec 2023 15:25:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
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
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qWlTf5MDu4R-ZyHjBbhLLDK-5w0Xc40v
X-Proofpoint-GUID: qWlTf5MDu4R-ZyHjBbhLLDK-5w0Xc40v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312260053



On 12/25/2023 6:29 PM, Krzysztof Kozlowski wrote:
> On 25/12/2023 09:44, Luo Jie wrote:
>> Update the yaml file for the new DTS properties.
>>
>> 1. qcom,cmn-ref-clock-frequency for the CMN PLL source clock select.
>> 2. clock-frequency for MDIO clock frequency config.
>> 3. add uniphy AHB & SYS GCC clocks.
> 
> I see two new compatibles, so your list is missing main point.

will add the compatibles into the list, thanks.

> 
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 +++++++++++++++++-
>>   1 file changed, 136 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> index 3407e909e8a7..205500cb1fd1 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> @@ -18,8 +18,10 @@ properties:
>>   
>>         - items:
>>             - enum:
>> +              - qcom,ipq5332-mdio
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq9574-mdio
>>             - const: qcom,ipq4019-mdio
>>   
>>     "#address-cells":
>> @@ -30,19 +32,76 @@ properties:
>>   
>>     reg:
>>       minItems: 1
>> -    maxItems: 2
>> -    description:
>> -      the first Address and length of the register set for the MDIO controller.
>> -      the second Address and length of the register for ethernet LDO, this second
>> -      address range is only required by the platform IPQ50xx.
>> +    maxItems: 5
>> +    description: |
>> +      The first address and length of the register set for the MDIO controller,
>> +      the optional second address and length of the register is for CMN block,
>> +      the optional third, fourth and fifth address and length of the register
>> +      for Ethernet LDO, the optional Ethernet LDO address range is required by
> 
> Wait, required? You said in in response to Rob these are not required!

As for the response to Rob, i was saying the uniphy ahb and sys clocks
are not needed on ipq9574.
The LDO are needed on ipq5332 and ipq5018 currently.

> 
>> +      the platform IPQ50xx/IPQ5332.
> 
> So these are valid for all platforms or not? Looks not, but nothing
> narrows the list for other boards.

i add the limitation on the reg usage for the ipq5332 platform on the
following part "if condition" of this patch, i will update the patch
to narrow down for the other compatibles.

> 
> Anyway, why do you add entries in the middle? LDO was the second, so it
> cannot be now fifth.

As Rob's suggestion, i move the cmn_blk to second location for
simplifying the limitation description, i checked the upstream dts code,
the LDO is not used currently, so we can move cmn_blk to the second
location here.

> 
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    items:
>> +      - const: mdio
>> +      - const: cmn_blk
>> +      - const: eth_ldo1
>> +      - const: eth_ldo2
>> +      - const: eth_ldo3
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
>> +  qcom,cmn-ref-clock-frequency:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum:
>> +      - 25000000
>> +      - 31250000
>> +      - 40000000
>> +      - 48000000
>> +      - 50000000
>> +      - 96000000
>> +    default: 48000000
>> +    description: |
>> +      The reference clock source of CMN PLL block is selectable, the
>> +      reference clock source can be from wifi module or the external
>> +      xtal, the reference clock frequency 48MHZ can be from internal
>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
> 
> This does not resolve mine and Conor's concerns from previous version.
> External clocks are defined as clock inputs.

No matter the external or internal reference clock, they are the clock
source selection for CMN, there are only 48MHZ can be external or 
internal, other clocks have the different clock rate, so the internal
48MHZ reference clock can be implied when the 
"qcom,cmn-ref-clock-frequency" is not defined, which is suggested by 
Conor in the previous
comments.

> 
>> +
>> +  clock-frequency:
>> +    enum:
>> +      - 390625
>> +      - 781250
>> +      - 1562500
>> +      - 3125000
>> +      - 6250000
>> +      - 12500000
>> +    default: 390625
>> +    description: |
>> +      The MDIO bus clock that must be output by the MDIO bus hardware,
>> +      only the listed frequencies above can be supported, other frequency
>> +      will cause malfunction. If absent, the default hardware value 0xff
>> +      is used, which means the default MDIO clock frequency 390625HZ, The
>> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
>> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
>> +      register, there is higher clock frequency requirement on the normal
>> +      working case where the MDIO slave devices support high clock frequency.
>>   
>>   required:
>>     - compatible
>> @@ -59,8 +118,10 @@ allOf:
>>             contains:
>>               enum:
>>                 - qcom,ipq5018-mdio
>> +              - qcom,ipq5332-mdio
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq9574-mdio
>>       then:
>>         required:
>>           - clocks
>> @@ -70,6 +131,20 @@ allOf:
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
> 
> Why all other variants now have 5 clocks and 5 reg entries? Nothing of
> it is explained in the commit msg.

 From the condition above, only "qcom,ipq5332-mdio" has 5 clocks (mdio +
4 uniphy clocks) and 4 regs (mdio + cmn_blk + 2 LDOs) as the cmn_blk is
moved to the second location.

how it can gives the 5 clocks and 5 regs for other variants here?


> 
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>> @@ -100,3 +175,59 @@ examples:
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
> 
> That's not the order of properties. compatible is always the first, reg
> and reg-names follow. See DTS coding style.

will correct this, thanks.

> 
>> +      compatible = "qcom,ipq5332-mdio",
>> +                   "qcom,ipq4019-mdio";
>> +
>> +      reg = <0x90000 0x64>,
>> +            <0x9b000 0x800>,
>> +            <0x7a00610 0x4>,
>> +            <0x7a10610 0x4>;
>> +
> 
> Drop blank line.
Ok.

> 
>> +      reg-names = "mdio",
>> +                  "cmn_blk",
>> +                  "eth_ldo1",
>> +                  "eth_ldo2";
>> +
>> +      clocks = <&gcc GCC_MDIO_AHB_CLK>,
>> +               <&gcc GCC_UNIPHY0_AHB_CLK>,
>> +               <&gcc GCC_UNIPHY1_AHB_CLK>,
>> +               <&gcc GCC_UNIPHY0_SYS_CLK>,
>> +               <&gcc GCC_UNIPHY1_SYS_CLK>;
>> +
> 
> Drop blank line
Ok.

> 
>> +      clock-names = "gcc_mdio_ahb_clk",
>> +                    "uniphy0_ahb",
>> +                    "uniphy1_ahb",
>> +                    "uniphy0_sys",
>> +                    "uniphy1_sys";
>> +
>> +      clock-frequency = <6250000>;
>> +      reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
>> +
> 
> Best regards,
> Krzysztof
> 

