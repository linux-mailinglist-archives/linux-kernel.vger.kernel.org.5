Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5750755E68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGQI3E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGQI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:29:03 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE3136;
        Mon, 17 Jul 2023 01:29:00 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 31F6724E1A6;
        Mon, 17 Jul 2023 16:28:58 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:28:58 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:28:56 +0800
Message-ID: <6ed58545-c10a-d789-04d5-4eb715f4906d@starfivetech.com>
Date:   Mon, 17 Jul 2023 16:28:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-2-samin.guo@starfivetech.com>
 <4efd8643-455e-4f7f-b031-a0a02dd65210@lunn.ch>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <4efd8643-455e-4f7f-b031-a0a02dd65210@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-------- 原始信息 --------
主题: Re: [PATCH v4 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
From: Andrew Lunn <andrew@lunn.ch>
收件人: Samin Guo <samin.guo@starfivetech.com>
日期: 2023/7/15

>> +  motorcomm,rx-clk-driver-strength:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
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
> 
> The DS(3b) value is not relevant to the binding. It is a driver
> detail. So i would not bother listing it.
> 
ok， will remove it.

> Please add a comment explaining what wol is. 
> 
>        Andrew

Sorry，it should be vol (voltage), not wol.

 
Best regards,
Samin
