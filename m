Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532C79E548
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjIMKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjIMKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:50:41 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B7CA;
        Wed, 13 Sep 2023 03:50:37 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BEFB424E337;
        Wed, 13 Sep 2023 18:50:33 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 18:50:33 +0800
Received: from [192.168.120.76] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 18:50:32 +0800
Message-ID: <d6bf4465-28a7-418f-47c9-7189fa746ca0@starfivetech.com>
Date:   Wed, 13 Sep 2023 18:50:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Drop unused properties and
 limit frquency
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
 <20230912081402.51477-7-william.qiu@starfivetech.com>
 <CAJM55Z-_V6Ty61u1bF=BziBRwn7bzTygE02g_4B3UW9tG4yikw@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z-_V6Ty61u1bF=BziBRwn7bzTygE02g_4B3UW9tG4yikw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/12 21:23, Emil Renner Berthing wrote:
> William Qiu wrote:
>> Drop unused properties and limit cclk_in to 50M, thus cancelling the
>> internal frequency and adopting the by-pass mode.
> 
> That's two unrelated changes which should really be in different patches. But
> again the hardware still has the relevant field in the syscon registers even if
> the driver doesn't use it, so maybe just leave them and just keep this patch
> adding the assigned-clock* properties.
> 
> /Emil
> 
>>
Will update.

Best Regards,
William
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi                      | 2 --
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index d79f94432b27..d1f2ec308bca 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -205,6 +205,8 @@ &i2c6 {
>>
>>  &mmc0 {
>>  	max-frequency = <100000000>;
>> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>> +	assigned-clock-rates = <50000000>;
>>  	bus-width = <8>;
>>  	cap-mmc-highspeed;
>>  	mmc-ddr-1_8v;
>> @@ -221,6 +223,8 @@ &mmc0 {
>>
>>  &mmc1 {
>>  	max-frequency = <100000000>;
>> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
>> +	assigned-clock-rates = <50000000>;
>>  	bus-width = <4>;
>>  	no-sdio;
>>  	no-mmc;
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index e85464c328d0..7b8e841aeef8 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -870,7 +870,6 @@ mmc0: mmc@16010000 {
>>  			fifo-depth = <32>;
>>  			fifo-watermark-aligned;
>>  			data-addr = <0>;
>> -			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
>>  			status = "disabled";
>>  		};
>>
>> @@ -886,7 +885,6 @@ mmc1: mmc@16020000 {
>>  			fifo-depth = <32>;
>>  			fifo-watermark-aligned;
>>  			data-addr = <0>;
>> -			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
>>  			status = "disabled";
>>  		};
>>
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
