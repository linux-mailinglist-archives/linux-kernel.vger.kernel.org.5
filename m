Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C977E528A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjKHJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjKHJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:19:51 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551B92
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:19:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so6494747a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699435188; x=1700039988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyrG+cFAVN5jg5Jo1F6r2dVbGw0u1mOKqzoU068LPAM=;
        b=xTFipj33wvepS5gVE2Xi5sOeomfZGrmoINcjnp2Hhkbi4kbE3NFmD5Jkolla9xPoZ0
         QSMBvMVFRtF8WTRufN8ac+9Bxb49ABkV3bEi7yAj0QRKK6oaw4e8NoxvYYxuswEeIhJl
         rmhVrKdL3m84YoCoxYF79ZPA8rFs5+hK86DahVKx4VB/pFD43OvjxX0PLSXfF8542NSw
         EZmxiT+4/bdGQWiv7A0BOXqCbh90didiDRPMrKuGgP3IYKZcfVoVPHjS+7BhPyVGC+kI
         cCihowQ6+fhYcEhrJ3PgJVc1f1Aaq3x1S1g035Ljb4lQFyiGtmj+RokOow/beoAOcTqI
         3WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699435188; x=1700039988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyrG+cFAVN5jg5Jo1F6r2dVbGw0u1mOKqzoU068LPAM=;
        b=o0NdNiV42Q1325Wgajk6Byb/h667Gr2pAa++W08wHKESZ9ejMcgzzF+SKyC3yEKCqf
         CounK3HSE89h91h0oZLq0zu6gnWsKt/ueiwvpkjqN8Lc3SzwYtfA2KnIc0N4ODWmR5bp
         wCLugxTK3VSqEoficNBKn/7KjbLnjQeei/dKXajG0jU8G0cX6Xs6zXiUBaiM3VXpfg0P
         scQBdYJJz4nT9s7NjIABNLgB2mO0fE2nrgEuIBC4aq0szEj2d1ijTfGwLw9RN3Pf3Nk7
         tbZL1QjCbNA5X/Ejgd/MaQ3ztJA8aUkJzJP8U3WwcaO8NTHLuc+3XtqJ7i4XCPUhlNKE
         1bYg==
X-Gm-Message-State: AOJu0YxPMDxx8tJPbWVUwfQkymmTt51a2GctIZ9vqLqR8J0tTSfHV6bD
        nMpoFH84QP93BUEVilZshYyiBg==
X-Google-Smtp-Source: AGHT+IHTdP1613Y91hdIWZfh03+1/CmzaPgIhPEFiDtPwWJZZ/PrETf6OUCID4XUyCASfcN8OeViPQ==
X-Received: by 2002:a17:907:7ea9:b0:9c6:10d4:d09f with SMTP id qb41-20020a1709077ea900b009c610d4d09fmr1027225ejc.63.1699435187606;
        Wed, 08 Nov 2023 01:19:47 -0800 (PST)
Received: from [192.168.1.70] ([86.71.62.58])
        by smtp.gmail.com with ESMTPSA id pv15-20020a170907208f00b009dd98089a48sm735807ejb.43.2023.11.08.01.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 01:19:47 -0800 (PST)
Message-ID: <2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com>
Date:   Wed, 8 Nov 2023 10:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] TPS65224 PMIC driver
Content-Language: en-US
To:     Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org
References: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
 <20231107113740.1034738-1-sirisha.gairuboina@Ltts.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20231107113740.1034738-1-sirisha.gairuboina@Ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 12:37, Gairuboina Sirisha wrote:
> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
>
>> On 10/26/23 15:32, Gairuboina Sirisha wrote:
>>> Added support for TPS65224 PMIC in linux.
>>> This patch set includes driver for core, i2c and pfsm.
>>> The driver was tested on TI's custom AM62A EVM.
>>>
>>> Gairuboina Sirisha (3):
>>>     drivers: mfd: Add support for TPS65224
>>>     drivers: mfd: Add support for TPS65224 i2c driver
>>>     drivers: misc: Add support for TPS65224 pfsm driver
>>>
>>>    drivers/mfd/Kconfig                |  19 +
>>>    drivers/mfd/Makefile               |   2 +
>>>    drivers/mfd/tps65224-core.c        | 291 ++++++++++++
>>>    drivers/mfd/tps65224-i2c.c         | 245 ++++++++++
>>>    drivers/misc/Kconfig               |  12 +
>>>    drivers/misc/Makefile              |   1 +
>>>    drivers/misc/tps65224-pfsm.c       | 290 ++++++++++++
>>>    include/linux/mfd/tps65224.h       | 735 +++++++++++++++++++++++++++++
>>>    include/uapi/linux/tps65224_pfsm.h |  36 ++
>>>    9 files changed, 1631 insertions(+)
>>>    create mode 100644 drivers/mfd/tps65224-core.c
>>>    create mode 100644 drivers/mfd/tps65224-i2c.c
>>>    create mode 100644 drivers/misc/tps65224-pfsm.c
>>>    create mode 100644 include/linux/mfd/tps65224.h
>>>    create mode 100644 include/uapi/linux/tps65224_pfsm.h
>> Hi Sirisha,
>>
>> These drivers strongly look like TPS6594 drivers.
>>
>> Instead of submitting new drivers, you should consider reusing and
>> modifying the existing ones for TPS6594. You might add your new 'compatible'
>> entry ("ti,tps65224-q1") in TPS6594 dt-bindings (see 'ti,tps6594.yaml' file)
>> to identify your TPS65224 PMIC. This new 'compatible' would also be added
>> in the existing 'tps6594_i2c_of_match_table'. You can have a look at
>> 'tps->chip_id' in 'tps6594-core.c' and see how we use it to deal with slight
>> differences between different PMIC IDs.
> Thanks for the response. While the TPS65224 drivers follow the format and
> structure of TPS6594, the register maps, masks, and ADC feature differ.
> The two PMICs have overlapping features but TPS65224 is not treated as a subset.
> TPS65224 is treated as a separate and independent driver instead of adding
> compatibility to the existing TPS6594 driver that would then support 3 PMICS.
> This separation will better support our differing PMICs.
>
> Thanks & Regards,
> Sirisha G.

I compared 'tps65224.h' with 'tps6594.h', especially register mapping.
There are less resources in TPS65224, but I don't see any incompatibility
between both PMIC register mappings. Some registers are not used by
your TPS65224, and some interrupts are not used either (that's not a
problem, they will not trigger, so). Beyond that, I2C and PFSM drivers
perform the same things for both PMICs. That's why according to me,
nothing prevents from re-using TPS6594 drivers. Even for ADC, which is
specific to your TPS65224 indeed, the register range does not overlap
with any of TPS6594 registers. You could conditionally add this driver
(that's what we did in  'tps6594-core.c' for RTC driver, which is not used
for one of the compatibles: you can do something similar for ADC).
You will probably add support for others TPS65224 drivers over the next
weeks: SPI, ESM, RTC, GPIOs, regulators, watchdog, and ADC. Most of them
should be compatible with both TPS6594 and TPS65224, I think (even
watchdog driver, which was not developed for TPS6594). ADC will not,
but as explained above you can easily deal with this one thanks to
the compatible.
For 'tps65224-core.c' only, a little bit of work might be necessary to
handle your TPS65224 specific functionalities. By using a different DT
compatible string, your driver can then select different options (or maybe
even different register ranges) for some features based on the compatible.
But except for 'tps65xx-core.c', there is "sufficient overlap" to justify
sharing as much as possible between TPS65224 and TPS6594, in my
opinion.

