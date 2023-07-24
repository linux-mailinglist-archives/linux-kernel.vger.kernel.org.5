Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0D75F2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjGXKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjGXKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:23:10 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC249D0;
        Mon, 24 Jul 2023 03:16:53 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0988C24E35D;
        Mon, 24 Jul 2023 18:16:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 18:16:52 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 18:16:51 +0800
Message-ID: <eb258dcd-a8f0-26ed-2d77-f49269ebb469@starfivetech.com>
Date:   Mon, 24 Jul 2023 18:16:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/4] StarFive's Pulse Width Modulation driver support
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230601085154.36938-1-william.qiu@starfivetech.com>
 <c3c7fb8a-7c0c-5966-88cd-e004db69de83@starfivetech.com>
In-Reply-To: <c3c7fb8a-7c0c-5966-88cd-e004db69de83@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/27 15:46, William Qiu wrote:
> 
> 
> On 2023/6/1 16:51, William Qiu wrote:
>> Hi,
>> 
>> This patchset adds initial rudimentary support for the StarFive
>> Pulse Width Modulation controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board.The first patch add
>> Documentations for the device and Patch 2 adds device probe for
>> the module.
>> 
>> Changes v2->v3:
>> - Rebased to v6.4rc3.
>> - Sorted the header files in alphabetic order.
>> - Changed iowrite32() to writel().
>> - Added a way to turn off.
>> - Moified polarity inversion implementation.
>> - Added 7100 support.
>> - Added dts patches.
>> - Used the various helpers in linux/math.h.
>> - Corrected formatting problems.
>> - Renamed dtbinding  to 'starfive,jh7100-pwm.yaml'.
>> - Dropped the redundant code.
>> 
>> Changes v2->v3:
>> - Fixed some formatting issues.
>> 
>> Changes v1->v2:
>> - Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml'.
>> - Dropped the compatible's Items.
>> - Dropped the unuse defines.
>> - Modified the code to follow the Linux coding style.
>> - Changed return value to dev_err_probe.
>> - Dropped the unnecessary local variable.
>> 
>> The patch series is based on v6.4rc3.
>> 
>> William Qiu (4):
>>   dt-bindings: pwm: Add StarFive PWM module
>>   pwm: starfive: Add PWM driver support
>>   riscv: dts: starfive: jh7110: Add PWM node and pins configuration
>>   riscv: dts: starfive: jh7100: Add PWM node and pins configuration
>> 
>>  .../bindings/pwm/starfive,jh7100-pwm.yaml     |  55 +++++
>>  MAINTAINERS                                   |   7 +
>>  .../boot/dts/starfive/jh7100-common.dtsi      |  24 +++
>>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |   9 +
>>  .../jh7110-starfive-visionfive-2.dtsi         |  22 ++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   9 +
>>  drivers/pwm/Kconfig                           |   9 +
>>  drivers/pwm/Makefile                          |   1 +
>>  drivers/pwm/pwm-starfive-ptc.c                | 192 ++++++++++++++++++
>>  9 files changed, 328 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/starfive,jh7100-pwm.yaml
>>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
>> 
>> --
>> 2.34.1
>> 
> Hi everyone,
> 
> Could you please help me review this patch series to see if there is
> anything that needs to be modified?
> Thanks for taking time to review this patch series.
> 
> Best Regards,
> William

Hi Thierry Reding,

Could you please help me review this patch series to see if there is
anything that needs to be modified?
Thanks for taking time to review this patch series.
 
Best Regards,
William
