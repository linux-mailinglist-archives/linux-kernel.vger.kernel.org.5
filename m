Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F1755E91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGQIfh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGQIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:35:35 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1E3D8;
        Mon, 17 Jul 2023 01:35:33 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ABF2D24E295;
        Mon, 17 Jul 2023 16:35:30 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:35:30 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:35:29 +0800
Message-ID: <c0f533a4-d196-649b-957e-eea6cd9e227c@starfivetech.com>
Date:   Mon, 17 Jul 2023 16:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-2-samin.guo@starfivetech.com>
 <20230715024711.GB872287-robh@kernel.org>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230715024711.GB872287-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-------- 原始信息 --------
主题: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
From: Rob Herring <robh@kernel.org>
收件人: Samin Guo <samin.guo@starfivetech.com>
日期: 2023/7/15

> On Fri, Jul 14, 2023 at 06:14:05PM +0800, Samin Guo wrote:
>> The motorcomm phy (YT8531) supports the ability to adjust the drive
>> strength of the rx_clk/rx_data.
>>
>> The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the
>> LDO voltage can be configured with hardware pull-up resistors to match
>> the SOC voltage (usually 1.8V). The software can read the registers
>> 0xA001 obtain the current LDO voltage value.
>>
>> When we configure the drive strength, we need to read the current LDO
>> voltage value to ensure that it is a legal value at that LDO voltage.
>>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> ---
>>  .../bindings/net/motorcomm,yt8xxx.yaml        | 46 +++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> index 157e3bbcaf6f..097bf143af35 100644
>> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> @@ -52,6 +52,52 @@ properties:
>>        for a timer.
>>      type: boolean
>>  
>> +  motorcomm,rx-clk-driver-strength:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> As the units are uA, drop the type and add '-microamp' suffix. 
> 'motorcomm,rx-clk-drv-microamp' is probably sufficient.
>
Thanks for the guidance, will be improved in the next version.
 
>> +    description: |
>> +      drive strength of rx_clk rgmii pad.
>> +      |----------------------------------|
>> +      |        rx_clk ds map table       |
>> +      |----------------------------------|
>> +      | DS(3b) |  wol@1.8v  |  wol@3.3v  |
>> +      |________|_________________________|
>> +      |        | current(uA)| current(uA)|
>> +      |   000  |     1200   |    3070    |
>> +      |   001  |     2100   |    4080    |
>> +      |   010  |     2700   |    4370    |
>> +      |   011  |     2910   |    4680    |
>> +      |   100  |     3110   |    5020    |
>> +      |   101  |     3600   |    5450    |
>> +      |   110  |     3970   |    5740    |
>> +      |   111  |     4350   |    6140    |
>> +      |--------|------------|------------|
>> +    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
>> +            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
>> +    default: 2910
>> +
>> +  motorcomm,rx-data-driver-strength:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      drive strength of rx_data/rx_ctl rgmii pad.
>> +      |----------------------------------|
>> +      |        rx_data ds map table      |
>> +      |----------------------------------|
>> +      | DS(3b) |  wol@1.8v  |  wol@3.3v  |
>> +      |________|_________________________|
>> +      |        | current(uA)| current(uA)|
>> +      |   000  |     1200   |    3070    |
>> +      |   001  |     2100   |    4080    |
>> +      |   010  |     2700   |    4370    |
>> +      |   011  |     2910   |    4680    |
>> +      |   100  |     3110   |    5020    |
>> +      |   101  |     3600   |    5450    |
>> +      |   110  |     3970   |    5740    |
>> +      |   111  |     4350   |    6140    |
>> +      |--------|------------|------------|
>> +    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
>> +            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
>> +    default: 2910
>> +
>>    motorcomm,tx-clk-adj-enabled:
>>      description: |
>>        This configuration is mainly to adapt to VF2 with JH7110 SoC.
>> -- 
>> 2.17.1
>>

Best regards,
Samin
