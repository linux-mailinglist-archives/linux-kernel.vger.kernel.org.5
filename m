Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582137BCE81
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbjJHNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbjJHNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:09:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9AB6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:09:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064867903cso36299925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696770572; x=1697375372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4T2Z7SYLg4F7zYTghrx8Dfmvyt8d+HUgwBGlBRzhxsY=;
        b=Hwv3xHsLKycMAh1xz8KQ2al3jmOWg2sVw3HGcwDlK1d/AzY149s2YhjZK3YFNAz6xt
         eyqtB04+FhUwt5nW9L/8kOK4PIZHQdJeL+FzTNXG36zpKKyCc+9yjC2C+cGAbZYxyhRW
         IvLlXzxsbQGZ6juo0WtQe8kwKzKiUjXhBDMY+mlSTQUEWCCr1z+i6yCIe/WThNLHsd49
         NuiKyevW+ROiXwIN8/kSYCJowLdCog9UZ/wOwZrf4vKmfEuzqGbQGoriydQ9JxI5FUst
         armp+TLOhSID0WUfKBdMf3cEJRJvwqCdyXpL9H3cx1+Uc+vSvW8vooo6sNXKam1E860J
         dCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696770572; x=1697375372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T2Z7SYLg4F7zYTghrx8Dfmvyt8d+HUgwBGlBRzhxsY=;
        b=Hsl4IHy6nLlbmP/wOryN45+aevvXCyg/72cYMiZye7kD+HXcqTpuVB9aWtdJKPU0AB
         F2ysXuZvZx4Oj8gBoXDiLnOC4WuF4XXXZNR+0FmdWKW0elYqs5wuaoX5n/SmMhKjocPU
         yIZ4Wj3Ui0UVeUttlN8bwGDxfBRj6XZ1A3kjnjr0EAToJqq4JJ2+bbzpGDJS9M1+Rpd3
         whF41iGS1QfH9hQxMzvfEc6IDBPc2EvqAyEbJso+B+ifixmhSbbJ10CRdemKpvA+296O
         r4SSUk3hcCAFojwC3ep20IG6fWjldY7nl9jF7GuxZIClkknfauDmG5RYa4SeWI5kcBc6
         eHwA==
X-Gm-Message-State: AOJu0YyH5BcmYET63OuVsZt6molZMq34epqdSOkAimca+rYjcJ09sYhk
        hRbJ3IRVXmj9oS0caTor4qgUoQ==
X-Google-Smtp-Source: AGHT+IEECcUbhP+SmHk2UsmpP/hLROulV1e7rcjBMqTB5kOUEgGwvUhi0BoAxzLCvWtP9ODyCM/1rw==
X-Received: by 2002:a05:600c:ac4:b0:406:599f:f934 with SMTP id c4-20020a05600c0ac400b00406599ff934mr12096596wmr.12.1696770571922;
        Sun, 08 Oct 2023 06:09:31 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040747010f8csm2174054wmo.40.2023.10.08.06.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 06:09:31 -0700 (PDT)
Message-ID: <04260159-f5a8-47f7-b267-33f4ea19b8a6@linaro.org>
Date:   Sun, 8 Oct 2023 15:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO
 base warning
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Mateusz Majewski <m.majewski2@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
 <20231006125557.212681-1-m.majewski2@samsung.com>
 <CAPLW+4kmA6iYDPFxyASHLJifz63DRxT9gqQ-AsMAVy0RzoaFRw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPLW+4kmA6iYDPFxyASHLJifz63DRxT9gqQ-AsMAVy0RzoaFRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 04:14, Sam Protsenko wrote:
> On Fri, Oct 6, 2023 at 8:01 AM Mateusz Majewski <m.majewski2@samsung.com> wrote:
>>
>> The object of this work is fixing the following warning, which appears
>> on all targets using that driver:
>>
>> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
>>
>> This needs a small refactor to how we interact with the pinctrl
>> subsystem. Finally, we remove some bookkeeping that has only been
>> necessary to allocate GPIO bases correctly.
>>
>> Mateusz Majewski (4):
>>   pinctrl: samsung: defer pinctrl_enable
>>   pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
>>   pinctrl: samsung: choose GPIO numberspace base dynamically
>>   pinctrl: samsung: do not offset pinctrl numberspaces
>>
>>  drivers/pinctrl/samsung/pinctrl-samsung.c | 56 ++++++++++++-----------
>>  drivers/pinctrl/samsung/pinctrl-samsung.h |  4 +-
>>  2 files changed, 31 insertions(+), 29 deletions(-)
>>
>> --
> 
> Hi Mateusz,
> 
> Thank you for handling this! Those deprecation warnings have been
> bugging me for some time :) While testing this series on my E850-96
> board (Exynos850 based), I noticed some changes in
> /sys/kernel/debug/gpio file, like these:
> 
> 8<------------------------------------------------------------------------------------------>8
> -gpiochip0: GPIOs 0-7, parent: platform/11850000.pinctrl, gpa0:
> - gpio-7   (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
> +gpiochip0: GPIOs 512-519, parent: platform/11850000.pinctrl, gpa0:
> + gpio-519 (                    |Volume Up           ) in  hi IRQ ACTIVE LOW
> 
> -gpiochip1: GPIOs 8-15, parent: platform/11850000.pinctrl, gpa1:
> - gpio-8   (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
> +gpiochip1: GPIOs 520-527, parent: platform/11850000.pinctrl, gpa1:
> + gpio-520 (                    |Volume Down         ) in  hi IRQ ACTIVE LOW
> 
> -gpiochip2: GPIOs 16-23, parent: platform/11850000.pinctrl, gpa2:
> +gpiochip2: GPIOs 528-535, parent: platform/11850000.pinctrl, gpa2:
> 
> ...
> 8<------------------------------------------------------------------------------------------>8
> 
> So basically it looks like all line numbers were offset by 512. Can
> you please comment on this? Is it an intentional change, and why it's
> happening?
> 
> Despite of that change, everything seems to be working fine. But I
> kinda liked the numeration starting from 0 better :)

Could it be the reason of dynamic allocation?


Best regards,
Krzysztof

