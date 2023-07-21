Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41675C31C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGUJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:35:30 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF62D7F;
        Fri, 21 Jul 2023 02:35:24 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 69B5980B2;
        Fri, 21 Jul 2023 17:35:18 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:35:18 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:35:16 +0800
Message-ID: <46663f3b-44b8-f2b6-df4b-9d639b3aff66@starfivetech.com>
Date:   Fri, 21 Jul 2023 17:35:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
References: <20230714104521.18751-1-samin.guo@starfivetech.com>
 <20230720-cardstock-annoying-27b3b19e980a@spud>
 <42beaf41-947e-f585-5ec1-f1710830e556@starfivetech.com>
 <A0012BE7-8947-49C8-8697-1F879EE7B0B7@kernel.org>
 <ce3e0ffb-abcd-2392-8767-db460bce4b4b@starfivetech.com>
 <20230721-passive-smoked-d02c88721754@spud>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230721-passive-smoked-d02c88721754@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2023/7/21 17:16:41, Conor Dooley wrote:
> On Fri, Jul 21, 2023 at 03:27:33PM +0800, Guo Samin wrote:
> 
>> Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
>> From: Conor Dooley <conor@kernel.org>
> 
>> to: Guo Samin <samin.guo@starfivetech.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
>> data: 2023/7/21
> 
> btw, please try and remove this stuff from your mails.
>

Sure
 
>>> On 21 July 2023 03:09:19 IST, Guo Samin <samin.guo@starfivetech.com> wrote:
> 
>>>> There is a question about the configuration of phy that I would like to consult you.
>>>>
>>>> Latest on motorcomm PHY V5[1]: Follow Rob Herring's advice
>>>> motorcomm,rx-xxx-driver-strength Changed to motorcomm,rx-xxx-drv-microamp .
>>>> V5 has already received a reviewed-by from Andrew Lunn, and it should not change again.
>>>>
>>>> Should I submit another pacthes based on riscv-dt-for-next? 
>>>
>>> Huh, dtbs_check passed for these patches,
>>> I didn't realise changes to the motorcomm stuff
>>> were a dep. for this. I'll take a look later.
> 
>> After discussing with HAL, I have prepared the code and considered adding the following patch to 
>> Motorcomm's patchsetes v6. (To fix some spelling errors in v5[1])
>> which will then send patches based on linux-next. What do you think? @Andrew @Conor
> 
> I think you are better off just sending the dts patch to me, adding a
> dts patch that will not apply to net-next to your motorcomm driver series
> will only really cause problems for the netdev patchwork automation.
>

Okay, I'll send you DTS separately.
 
>> [1] https://patchwork.kernel.org/project/netdevbpf/cover/20230720111509.21843-1-samin.guo@starfivetech.com
> 
> I meant to ack this yesterday, but it wasn't in my dt-binding review
> queue. I'll go do that now.


Best regards,
Samin
