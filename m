Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7677CF8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjJSMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbjJSMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:30:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AF3189
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a3af69d8so1894707e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697718594; x=1698323394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPQidXa+OYvo5Cuog4USzNI+/Xa6NAbmqLzTVYeaaGI=;
        b=hsm+NgS2yLAar//ppYO0VkxpBnkq8TSc6tnuRl7T6GUofmZPCnZjWTje/1bxR5XHlj
         ZkBHJJEDe8IPHMFhEugPVQPlBv3beRKtjpnU0qxTdGqAEPAN9zMTzOjzjbbCPqsTMDhr
         XbPwN1Z0S9n0DEG9ZWXdL6DMSn3a2bMQTNk6Md0tq/spBhcCe7DskF+L5z7HfgndNLEr
         VK0LmzRPemoIsd1FPPLE+xuIk2yGJ7ltS/5TGf7rJwqB3WEuzlRhD9QmbH7yg4WMiy8D
         aU29IQAbBEi7djprTVQAG4XOiJlgsYm3Nqh77kajAbHkA/xT2ujGrrIEsT6gQF6oDyvT
         PC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718594; x=1698323394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPQidXa+OYvo5Cuog4USzNI+/Xa6NAbmqLzTVYeaaGI=;
        b=rFNLf7D1k2jLp5oLNhJ053Cc5lrl+3SheouODNMbZoBFJcib/mNz5E+Un1qg2M68xs
         EyqbmsdxF/0kIECWa1xNrTlt/+xDrEG1KlLu32vDX0cAnY62IdA1EDPj8wbCjEqsc7vo
         DwHFl2cozA43cyZcVOiL/Kr2Br4ZkL89IYJwv1ThxPq70MDx+fZ4m40zmzKlv/18EmZo
         H/4WxXkClhPaQJhmucFq84D8KssRogyVMmdWiYNmhAAXIMxKGS+8UG0BuWQB68VgvA13
         coY8tOYlT4p0PnjX7JenWclgitMOtIc7qAcCh4wZ2cNjzbPP8parwvA8LSewKzFHg0oL
         rTSQ==
X-Gm-Message-State: AOJu0YwE3vrhDAu+R9glOTr2LZ52lzPj8g1PmaBvIlqXzjLIWduos5T/
        90H4HkvVuaXy8KQm1Xz+pLapuw==
X-Google-Smtp-Source: AGHT+IHg7eVr9Vk42wp0GedexaXWPTTyyGtHpNE6XUvTGWZvO8GRkwynRbYeb/jJvG9OO4I66LWpjA==
X-Received: by 2002:a2e:870a:0:b0:2c5:6ab:b817 with SMTP id m10-20020a2e870a000000b002c506abb817mr1417727lji.5.1697718593993;
        Thu, 19 Oct 2023 05:29:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6933:1fe3:b858:3dde? ([2a01:e0a:999:a3a0:6933:1fe3:b858:3dde])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b004063cced50bsm4266895wme.23.2023.10.19.05.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:29:53 -0700 (PDT)
Message-ID: <acd4c737-49ee-4038-890b-b2eba29f6460@rivosinc.com>
Date:   Thu, 19 Oct 2023 14:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension
 reporting
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
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
 <844f6f35-3125-4014-852c-9ad7aee19ddc@rivosinc.com>
 <20231019-flatten-showbiz-127b2e917a7a@spud>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231019-flatten-showbiz-127b2e917a7a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/2023 12:22, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 09:26:31AM +0200, Clément Léger wrote:
>>
>>
>> On 18/10/2023 19:36, Conor Dooley wrote:
>>> On Wed, Oct 18, 2023 at 06:33:34PM +0100, Conor Dooley wrote:
>>>> On Wed, Oct 18, 2023 at 10:24:15AM -0700, Evan Green wrote:
>>>>> On Tue, Oct 17, 2023 at 6:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>>>
>>>>>> Factorize ISA extension reporting by using a macro rather than
>>>>>> copy/pasting extension names. This will allow adding new extensions more
>>>>>> easily.
>>>>>>
>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>> ---
>>>>>>  arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
>>>>>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>>>>>> index 473159b5f303..e207874e686e 100644
>>>>>> --- a/arch/riscv/kernel/sys_riscv.c
>>>>>> +++ b/arch/riscv/kernel/sys_riscv.c
>>>>>> @@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>>>>>>         for_each_cpu(cpu, cpus) {
>>>>>>                 struct riscv_isainfo *isainfo = &hart_isa[cpu];
>>>>>>
>>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBA))
>>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBA;
>>>>>> -               else
>>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBA;
>>>>>> -
>>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBB))
>>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBB;
>>>>>> -               else
>>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBB;
>>>>>> -
>>>>>> -               if (riscv_isa_extension_available(isainfo->isa, ZBS))
>>>>>> -                       pair->value |= RISCV_HWPROBE_EXT_ZBS;
>>>>>> -               else
>>>>>> -                       missing |= RISCV_HWPROBE_EXT_ZBS;
>>>>>> +#define CHECK_ISA_EXT(__ext)                                                   \
>>>>>> +               do {                                                            \
>>>>>> +                       if (riscv_isa_extension_available(isainfo->isa, __ext)) \
>>>>>> +                               pair->value |= RISCV_HWPROBE_EXT_##__ext;       \
>>>>>> +                       else                                                    \
>>>>>> +                               missing |= RISCV_HWPROBE_EXT_##__ext;           \
>>>>>> +               } while (false)
>>>>>> +
>>>>>> +               /*
>>>>>> +                * Only use CHECK_ISA_EXT() for extensions which can be exposed
>>>>>> +                * to userspace, regardless of the kernel's configuration, as no
>>>>>> +                * other checks, besides presence in the hart_isa bitmap, are
>>>>>> +                * made.
>>>>>
>>>>> This comment alludes to a dangerous trap, but I'm having trouble
>>>>> understanding what it is.
>>>>
>>>> You cannot, for example, use this for communicating the presence of F or
>>>> D, since they require a config option to be set before their use is
>>>> safe.
>>>
>>> Funnily enough, this comment is immediately contradicted by the vector
>>> subset extensions, where these CHECK_ISA_EXT() macros are used wrapped
>>> in has_vector(). The code looks valid to me, since has_vector() contains
>>> the Kconfig check, but does fly in the face of this comment.
> 
>> Yes, the KConfig checks are already done by the headers, adding #ifdef
>> would be redundant even if more coherent with the comment
> 
> I don't really understand what the first part of this means, or why using
> avoidable ifdeffery here would be desirable.

Sorry, I was not clear enough. What I meant is that the has_fpu() and
has_vector() functions are already ifdef'd in headers based on the
KConfig options for their support (CONFIG_FPU/CONFIG_RISCV_ISA_V) So in
the end, using ifdef here in hwprobe_isa_ext0() would be redundant.

> 
>> BTW, wouldn't
>> it make more sense to get rid out of the unsupported extensions directly
>> at ISA string parsing ? ie, if kernel is compiled without V support,
>> then do not set the bits corresponding to these in the riscv_isa_ext[]
>> array ? But the initial intent was probably to be able to report the
>> full string through cpuinfo.
> 
> Yeah, hysterical raisins I guess, it's always been that way. I don't
> think anyone originally thought about such configurations and that is
> how the cpuinfo stuff behaves. I strongly dislike the
> riscv_isa_extension_available() interface, but one of Drew's patches
> does at least improve things a bit. Kinda waiting for some of the
> patches in flight to settle down before deciding if I want to refactor
> stuff to be less of a potential for shooting oneself in the foot.

Make sense.

Clément
