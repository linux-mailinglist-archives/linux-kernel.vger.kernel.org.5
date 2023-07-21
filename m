Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B342B75BFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGUH1w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:27:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC64189;
        Fri, 21 Jul 2023 00:27:47 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3FD3C24DD54;
        Fri, 21 Jul 2023 15:27:38 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 15:27:36 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 15:27:34 +0800
Message-ID: <ce3e0ffb-abcd-2392-8767-db460bce4b4b@starfivetech.com>
Date:   Fri, 21 Jul 2023 15:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
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
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <A0012BE7-8947-49C8-8697-1F879EE7B0B7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-------- 原始信息 --------
主题: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
From: Conor Dooley <conor@kernel.org>
收件人: Guo Samin <samin.guo@starfivetech.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
日期: 2023/7/21

> 
> 
> On 21 July 2023 03:09:19 IST, Guo Samin <samin.guo@starfivetech.com> wrote:
>>
>>
>> -------- 原始信息 --------
>> 主题: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
>> From: Conor Dooley <conor@kernel.org>
>> 收件人: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, Samin Guo <samin.guo@starfivetech.com>
>> 日期: 2023/7/21
>>
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> On Fri, 14 Jul 2023 18:45:19 +0800, Samin Guo wrote:
>>>> This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
>>>> and has been tested on StarFive VisionFive-2 v1.2A and v1.3B SBC boards.
>>>>
>>>> The first patch adds ethernet nodes for jh7110 SoC, the second patch
>>>> adds ethernet nodes for visionfive 2 SBCs.
>>>>
>>>> This series relies on xingyu's syscon patch[1].
>>>> For more information and support, you can visit RVspace wiki[2].
>>>>
>>>> [...]
>>>
>>> Applied to riscv-dt-for-next, thanks!
>>>
>>> [1/2] riscv: dts: starfive: jh7110: Add ethernet device nodes
>>>       https://git.kernel.org/conor/c/1ff166c97972
>>> [2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy
>>>       https://git.kernel.org/conor/c/b15a73c358d1
>>>
>>> Thanks,
>>> Conor.
>>
>>
>> Hi Conor，
>>
>> Thank you so much！ 
>>
>> There is a question about the configuration of phy that I would like to consult you.
>>
>> Latest on motorcomm PHY V5[1]: Follow Rob Herring's advice
>> motorcomm,rx-xxx-driver-strength Changed to motorcomm,rx-xxx-drv-microamp .
>> V5 has already received a reviewed-by from Andrew Lunn, and it should not change again.
>>
>> Should I submit another pacthes based on riscv-dt-for-next? 
> 
> Huh, dtbs_check passed for these patches,
> I didn't realise changes to the motorcomm stuff
> were a dep. for this. I'll take a look later.
>
Hi Conor,

Thanks for taking the time to follow this.

After discussing with HAL, I have prepared the code and considered adding the following patch to 
Motorcomm's patchsetes v6. (To fix some spelling errors in v5[1])
which will then send patches based on linux-next. What do you think? @Andrew @Conor

[1] https://patchwork.kernel.org/project/netdevbpf/cover/20230720111509.21843-1-samin.guo@starfivetech.com



--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
@@ -28,8 +28,8 @@
        motorcomm,tx-clk-adj-enabled;
        motorcomm,tx-clk-100-inverted;
        motorcomm,tx-clk-1000-inverted;
-       motorcomm,rx-clk-driver-strength = <3970>;
-       motorcomm,rx-data-driver-strength = <2910>;
+       motorcomm,rx-clk-drv-microamp = <3970>;
+       motorcomm,rx-data-drv-microamp = <2910>;
        rx-internal-delay-ps = <1500>;
        tx-internal-delay-ps = <1500>;
 };
@@ -37,8 +37,8 @@
 &phy1 {
        motorcomm,tx-clk-adj-enabled;
        motorcomm,tx-clk-100-inverted;
-       motorcomm,rx-clk-driver-strength = <3970>;
-       motorcomm,rx-data-driver-strength = <2910>;
+       motorcomm,rx-clk-drv-microamp = <3970>;
+       motorcomm,rx-data-drv-microamp = <2910>;
        rx-internal-delay-ps = <300>;
        tx-internal-delay-ps = <0>;
 };


Best regards,
Samin

>>
>> [1] https://patchwork.kernel.org/project/netdevbpf/cover/20230720111509.21843-1-samin.guo@starfivetech.com
>>
>>
>> Best regards,
>> Samin

