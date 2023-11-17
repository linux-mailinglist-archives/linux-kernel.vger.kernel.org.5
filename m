Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E937EF0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbjKQKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbjKQKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:36:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961311D;
        Fri, 17 Nov 2023 02:36:39 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9rYHD022785;
        Fri, 17 Nov 2023 10:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BAG7U75sZFHWgMaBdi2lIci9jn6YMXwcGcSIrcouO5Y=;
 b=LHJ5vj0gTgDOITkf8xHEMa3uuF7TBzPlI96cVFczDuWpke2EzrOIGH1tda3zCk/P054w
 OypjMkLVjjfBdMTCwk8/CsbhAHOm37Ivv2ZELYUUeD4aWtetce4wqx0Iqclyt4CB0DKl
 sGmfFjKjs3elOp5dCK2kykDclQS9hmYVWVhBZyMA7By7kdcwuNo2tyaSs+bsMhkcCdMk
 g2fIdum07efr3PBXia9qrjAVTGw6zM1k/w87TUx6ri0N7iVo7D1FLTSOzsvMe6M4efq0
 weNLjRlzpIUgrpFETsDv0oyJylhWCt610Yj2UkyXfOsJLa/975C0QOznWxG8I845vExw FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udms92ew6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:36:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAaPQk003444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:36:25 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 02:36:20 -0800
Message-ID: <76e081ba-9d5a-41df-9c1b-d782e5656973@quicinc.com>
Date:   Fri, 17 Nov 2023 18:36:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-10-quic_luoj@quicinc.com>
 <834cbb58-3a88-4ba6-8db6-10440a4d0893@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <834cbb58-3a88-4ba6-8db6-10440a4d0893@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aZfoIlQEdSIEZFChRAqXkGWxHC_QtaPs
X-Proofpoint-ORIG-GUID: aZfoIlQEdSIEZFChRAqXkGWxHC_QtaPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 7:56 PM, Krzysztof Kozlowski wrote:
> On 15/11/2023 04:25, Luo Jie wrote:
>> On platform IPQ5332, the MDIO address of qca8084 can be programed
>> when the device tree property "fixup" defined, the clock sequence
>> needs to be completed before the PHY probeable.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 138 +++++++++++++++++-
>>   1 file changed, 130 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> index 3407e909e8a7..7ff92be14ee1 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> @@ -15,11 +15,13 @@ properties:
>>         - enum:
>>             - qcom,ipq4019-mdio
>>             - qcom,ipq5018-mdio
>> +          - qcom,ipq5332-mdio
>>   
>>         - items:
>>             - enum:
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq9574-mdio
>>             - const: qcom,ipq4019-mdio
>>   
>>     "#address-cells":
>> @@ -30,19 +32,47 @@ properties:
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
> 
> You must describe the items and constrain them per each variant.

Ok, will describe these items one by one in the next patch set.

> 
>>   
>>     clocks:
>> -    items:
>> -      - description: MDIO clock source frequency fixed to 100MHZ
>> +    minItems: 1
>> +    maxItems: 5
>> +    description:
> 
> Doesn't this make all other variants with incorrect constraints?

There are 5 clock items, the first one is the legacy MDIO clock, the
other clocks are new added for ipq5332 platform, will describe it more
clearly in the next patch set.

> 
>> +      MDIO system clock frequency fixed to 100MHZ, and the GCC uniphy
>> +      clocks enabled for resetting ethernet PHY.
>>   
>>     clock-names:
>> -    items:
>> -      - const: gcc_mdio_ahb_clk
>> +    minItems: 1
>> +    maxItems: 5
>> +
>> +  phy-reset-gpio:
> 
> No, for multiple reasons. It's gpios first of all. Where do you see such
> property? Where is the existing definition?

will remove this property, and update to use the exited PHY GPIO reset.

> 
> Then it is "reset-gpios" if this is MDIO. Why do you put phy properties
> in MDIO?
> 
>> +    minItems: 1
>> +    maxItems: 3
>> +    description:
>> +      GPIO used to reset the PHY, each GPIO is for resetting the connected
>> +      ethernet PHY device.
>> +
>> +  phyaddr-fixup:
>> +    description: Register address for programing MDIO address of PHY devices
> 
> You did not test code which you sent.

Hi Krzysztof,
This patch is passed with the following command in my workspace.
i will upgrade and install yamllint to make sure there is no
warning reported anymore.

make dt_bg_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml

> 
>> +
>> +  pcsaddr-fixup:
>> +    description: Register address for programing MDIO address of PCS devices
>> +
>> +  mdio-clk-fixup:
>> +    description: The initialization clocks to be configured
>> +
>> +  fixup:
>> +    description: The MDIO address of PHY/PCS device to be programed
> 
> Please do not send untested code.
> 

Ok, will complete the full test before uploading the patch.

> 
> ...
> 
>> +
>> +      qca8kphy2: ethernet-phy@3 {
>> +        reg = <3>;
>> +        fixup;
>> +      };
>> +
>> +      qca8kphy3: ethernet-phy@4 {
>> +        reg = <4>;
>> +        fixup;
>> +      };
>> +
>> +      qca8kpcs0: pcsphy0@5 {
>> +        compatible = "qcom,qca8k_pcs";
>> +        reg = <5>;
>> +        fixup;
>> +        };
> 
> Fix indentation.

Will Fix it in the next patch set, thanks.

> 
> Best regards,
> Krzysztof
> 
