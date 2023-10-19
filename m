Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD58E7CF453
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbjJSJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345161AbjJSJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:47:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BB12D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:46:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so23464455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697708813; x=1698313613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gSJI0J4GVtq5z4H+Knjyf89xMlTd2iwihqRslO1XxI=;
        b=HxG9jh2YSbKcrYpvYPgdTAzTrkF7JRmMMryd7TPOvEH7gNU6VZ2fwEcZSguRMNKXNL
         Mc4TsHhgYllcUdLUH7fKsPK52cBe/wfg0PCeFdPgcaNGnUdAKtYwa6DaHdtX5JZ4DBXA
         E14nLlG8K/nthYjtGYJY6xxFaJpKnfDqVB8W70hfj1L1RgtDjQhZzBEojX4lHyXqBaCv
         gPNFTl1mk6S7drqYZ/G7uyNn6aw/MofWF5ZEzUkk/y6imTje4++0qZETnFhxEg/GR5zG
         2lbk4fn0NnN2j0y6qnGJtyaj9tPeWBS6NYKYS5v2GsY/hEwtlwVUNdxhWXAd7YafbLy8
         8DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697708813; x=1698313613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gSJI0J4GVtq5z4H+Knjyf89xMlTd2iwihqRslO1XxI=;
        b=GJMTZqyV9ffdaBhcUxegvyOO3VtoDhYi/fqbFsXtq3Ys7do/we22Qm7csmV5R8RciI
         NAsvo/kMuffY2qA3QtRoaijeLlesA5ecK6hsDPnUkKgAKFpHY7diro5CQTZGEne0gA8J
         jWnARGXtDtjkbgcVBQYsIYssrRFVOfeLm6wG6KnEzo4NQ/xUfdWgSPvwHDHr0YJU8VH7
         IpYvjFnV4//j+xnDVn9UU2LCRwqFk+SBeoSALcyWn5dI+IACjYGcdXMWB7HLc6yFTjzM
         ehP9c2myr5GcaP4iubxQ0X8RVkKpyYcXHMiK/FK1PCvP1EotPFRH5FBzbltfUsoo7/H8
         CfWw==
X-Gm-Message-State: AOJu0YxwnjVSNrkO7CB6Zn9fyBa8xWvc+jC9kgvDBIhHgvIUbJuiKwTy
        FwyWBmq8/GV5fpsp7wzZFu10tA==
X-Google-Smtp-Source: AGHT+IEp9cwDS7FugsmOGBik6CpcSD683Pjyk9iGSH5JgL5wJaPC9ldFPHVkXXRlgk5VZqa1+0FRyg==
X-Received: by 2002:a5d:5956:0:b0:32d:d8ea:47ac with SMTP id e22-20020a5d5956000000b0032dd8ea47acmr1140369wri.0.1697708812764;
        Thu, 19 Oct 2023 02:46:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6933:1fe3:b858:3dde? ([2a01:e0a:999:a3a0:6933:1fe3:b858:3dde])
        by smtp.gmail.com with ESMTPSA id z3-20020adfe543000000b0031f82743e25sm4053835wrm.67.2023.10.19.02.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 02:46:51 -0700 (PDT)
Message-ID: <0b2cbc89-7892-4c43-898c-03757eaaf3b7@rivosinc.com>
Date:   Thu, 19 Oct 2023 11:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud>
 <20231018-flagpole-footpad-07a6228485f3@spud>
 <CALs-HsteDO0PvAKKQje7wU0f4z8w2V3f7WiHh5+LvQeVaSua1w@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HsteDO0PvAKKQje7wU0f4z8w2V3f7WiHh5+LvQeVaSua1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2023 19:45, Evan Green wrote:
> On Wed, Oct 18, 2023 at 10:37 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Wed, Oct 18, 2023 at 06:33:34PM +0100, Conor Dooley wrote:
>>> On Wed, Oct 18, 2023 at 10:24:15AM -0700, Evan Green wrote:
>>>> On Tue, Oct 17, 2023 at 6:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>>
>>>>> Factorize ISA extension reporting by using a macro rather than
>>>>> copy/pasting extension names. This will allow adding new extensions more
>>>>> easily.
>>>>>
>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>> ---
>>>>>  arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
>>>>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>>>>> index 473159b5f303..e207874e686e 100644
>>>>> --- a/arch/riscv/kernel/sys_riscv.c
>>>>> +++ b/arch/riscv/kernel/sys_riscv.c
>>>>> @@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>>>>>         for_each_cpu(cpu, cpus) {
>>>>>                 struct riscv_isainfo *isainfo = &hart_isa[cpu];
>>>>>
>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBA))
>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBA;
>>>>> -               else
>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBA;
>>>>> -
>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBB))
>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBB;
>>>>> -               else
>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBB;
>>>>> -
>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBS))
>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBS;
>>>>> -               else
>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBS;
>>>>> +#define CHECK_ISA_EXT(__ext)                                                   \
>>>>> +               do {                                                            \
>>>>> +                       if (riscv_isa_extension_available(isainfo->isa, __ext)) \
>>>>> +                               pair->value |= RISCV_HWPROBE_EXT_##__ext;       \
>>>>> +                       else                                                    \
>>>>> +                               missing |= RISCV_HWPROBE_EXT_##__ext;           \
>>>>> +               } while (false)
>>>>> +
>>>>> +               /*
>>>>> +                * Only use CHECK_ISA_EXT() for extensions which can be exposed
>>>>> +                * to userspace, regardless of the kernel's configuration, as no
>>>>> +                * other checks, besides presence in the hart_isa bitmap, are
>>>>> +                * made.
>>>>
>>>> This comment alludes to a dangerous trap, but I'm having trouble
>>>> understanding what it is.
>>>
>>> You cannot, for example, use this for communicating the presence of F or
>>> D, since they require a config option to be set before their use is
>>> safe.
>>
>> Funnily enough, this comment is immediately contradicted by the vector
>> subset extensions, where these CHECK_ISA_EXT() macros are used wrapped
>> in has_vector(). The code looks valid to me, since has_vector() contains
>> the Kconfig check, but does fly in the face of this comment.
> 
> 
> Ohh, got it. The word "can" is doing a lot of heavy lifting in that
> comment. So maybe something like: "This macro performs little in the
> way of extension-specific kernel readiness checks. It's assumed other
> gating factors like required Kconfig settings have already been
> confirmed to support exposing the given extension to usermode". ...
> But, you know, make it sparkle.

Hi Even,

Indeed the comment was a bit misleading, is this more clear ?

/*
 * Only use CHECK_ISA_EXT() for extensions which are usable by
 * userspace with respect to the kernel current configuration.
 * For instance, ISA extensions that uses float operations
 * should not be exposed when CONFIG_FPU is not set.
 */

Clément

> 
> -Evan
