Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F337A04E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjINNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjINNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:04:36 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E61FD5;
        Thu, 14 Sep 2023 06:04:32 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 672F724E1D4;
        Thu, 14 Sep 2023 21:04:17 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 21:04:17 +0800
Received: from [192.168.125.113] (113.72.145.181) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 21:04:16 +0800
Message-ID: <1a9d2905-b0e8-1775-e44f-39d3693a1dad@starfivetech.com>
Date:   Thu, 14 Sep 2023 21:04:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
To:     Conor Dooley <conor.dooley@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20230914111904.586744-1-ulf.hansson@linaro.org>
 <20230914-delegator-dimple-51b9414caa28@wendy>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230914-delegator-dimple-51b9414caa28@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.181]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/14 19:59, Conor Dooley wrote:
> Hey,
> 
> 
> On Thu, Sep 14, 2023 at 01:19:04PM +0200, Ulf Hansson wrote:
>> The Kconfig belongs closer to the corresponding implementation, hence let's
>> move it from the soc subsystem to the pmdomain subsystem.
>> 
>> Cc: Walker Chen <walker.chen@starfivetech.com>
>> Cc: Conor Dooley <conor@kernel.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Thanks for doing this, saved me having to!
> The series appears to have broken threading though, which can be seen
> pretty easily on lore:
> https://lore.kernel.org/all/20230914111904.586744-1-ulf.hansson@linaro.org/
> Dunno if something is borked with your process while sending patches to
> only a subset of the total recipient list.
> 
>> ---
>>  MAINTAINERS                                | 2 +-
>>  drivers/pmdomain/Kconfig                   | 1 +
>>  drivers/{soc => pmdomain}/starfive/Kconfig | 0
>>  drivers/soc/Kconfig                        | 1 -
>>  4 files changed, 2 insertions(+), 2 deletions(-)
>>  rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6b491ebcf790..b8eae18f0fb1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20523,7 +20523,7 @@ M:	Conor Dooley <conor@kernel.org>
>>  S:	Maintained
>>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>>  F:	Documentation/devicetree/bindings/soc/starfive/
>> -F:	drivers/soc/starfive/
>> +F:	drivers/pmdomain/starfive/
> 
> This isn't the correct change, just remove the drivers/soc/starfive
> bit entirely from this entry. 
> I've just been doing some review & sending PRs to Arnd for this stuff
> (or failing to send the PRs as you saw), I don't have particular
> interest in this driver other than helping out the starfive people with
> actually getting the code merged.
> Instead I think you should generalise the existing entry for the driver
> to cover the whole directory, so that it includes the Kconfig bits too:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa7487b7729b..22c1a5e5b130 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20564,7 +20564,7 @@ M:      Walker Chen <walker.chen@starfivetech.com>
>  M:     Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/starfive*
> -F:     drivers/pmdomain/starfive/jh71xx-pmu.c
> +F:     drivers/pmdomain/starfive/
>  F:     include/dt-bindings/power/starfive,jh7110-pmu.h
>  
>  STARFIVE SOC DRIVERS
> 

Hi Conor,

Anyway, thank you for helping maintain this driver as starfive people lack of experience in this area. 
You have indeed helped us a lot during this period.

Best regards,
Walker

> Thanks,
> Conor.
> 
>>  
>>  STARFIVE TRNG DRIVER
>>  M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
>> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
>> index cfe9ea754062..67049ebf7265 100644
>> --- a/drivers/pmdomain/Kconfig
>> +++ b/drivers/pmdomain/Kconfig
>> @@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
>>  source "drivers/pmdomain/rockchip/Kconfig"
>>  source "drivers/pmdomain/samsung/Kconfig"
>>  source "drivers/pmdomain/st/Kconfig"
>> +source "drivers/pmdomain/starfive/Kconfig"
>>  
>>  endmenu
>> diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kconfig
>> similarity index 100%
>> rename from drivers/soc/starfive/Kconfig
>> rename to drivers/pmdomain/starfive/Kconfig
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 8b46da40f107..10a9ff84ff41 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
>>  source "drivers/soc/rockchip/Kconfig"
>>  source "drivers/soc/samsung/Kconfig"
>>  source "drivers/soc/sifive/Kconfig"
>> -source "drivers/soc/starfive/Kconfig"
>>  source "drivers/soc/sunxi/Kconfig"
>>  source "drivers/soc/tegra/Kconfig"
>>  source "drivers/soc/ti/Kconfig"
>> -- 
>> 2.34.1
>> 
