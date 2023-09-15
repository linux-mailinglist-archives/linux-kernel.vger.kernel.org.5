Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB87A207D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjIOOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjIOOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:07:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FF1FC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:07:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34fcd1b9892so70195ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694786871; x=1695391671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u/pB+M0aDtpWHsMhpYrzo00VPhkLWHr0lTc8MpzDk2M=;
        b=lMh6QVScN/CV6w1xwGwW8kJhqyWXUaKkrbjckyiJps/vRsR++DhjbYrNS1dQNv90wc
         0pkLCcbB8LHv57/y98JYb9aF8na7pL31PBVTYBD/jMakMf6Ygoax8ekrflFAGegNOnav
         2TgRFnNgq+7xg7WL61EBT7tl0fTMGBmCrPE6BuAWorSsZe5z1j1qNn7NLl8k5XGps1GS
         4lBbYWrJTfD/zcKX54K9ztLpvHHy+yuH/bcCgAlSiA8s1pDvABZT0Ohv6+UPEgv1mopv
         tU4c5y2ClWWHaErgHWyjuYzS0cdM1KV+Cm57GjgpbP8hxQJ28Yb6GAJ2ttp5AviHw62F
         g/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694786871; x=1695391671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/pB+M0aDtpWHsMhpYrzo00VPhkLWHr0lTc8MpzDk2M=;
        b=VD7GJQesW7iynZ8lDYsHkxTkFPT+kyZiZLS5NuQvhBaFXdV36ei4AuQ3MuTyKAwxDY
         Y1wpZdw2UyjqmDJiFHz2VDFuhijGnqV1vdmX8w5CNi+eiS+2cVTbWhnxvPpWo7r2sGB1
         SMTzyxWXaSF0fp/ByWfUIByvc9D730JLjuxxq+thqiFWH1rHmZ6Il5t3Oy9tXUw1KgF5
         PxMN7porHDA9zXCVOmga5/90QNAQRsZkVSRmt8JDkl9IPh2LD+8P8xnLQpSxm+2NGT5o
         rjYRDG3C1ryICPcbDXQP34P6Cbp6IOcxEtMbDjqfPaAraWJT9EI4fYzt/foA8v1HtRx5
         5teA==
X-Gm-Message-State: AOJu0YyRSlo6He3qEBVftTLUTsEbHy+FVnNYAbALDmysB/ruFrWGY+80
        8dCiQ6k+No6xWfD8/lqMknY=
X-Google-Smtp-Source: AGHT+IHud5W4qEZjlFOpVsN13RUhttvgNY0/SSNMXp4ya/CDZ+mMQ2Dk7AykTejQO6Q9I4cd8I0kdg==
X-Received: by 2002:a05:6e02:c74:b0:34c:e6e6:80d5 with SMTP id f20-20020a056e020c7400b0034ce6e680d5mr1953714ilj.26.1694786870958;
        Fri, 15 Sep 2023 07:07:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e02080f00b00345d10ea524sm125643ilm.65.2023.09.15.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:07:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <644b77db-7214-88c3-7ba6-9c805a134e63@roeck-us.net>
Date:   Fri, 15 Sep 2023 07:07:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <ZQC5jS/Kc/JiBEOa@p100>
 <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
 <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
 <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
 <1160d063-8396-b126-15ca-a46807ec4258@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1160d063-8396-b126-15ca-a46807ec4258@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On 9/15/23 03:10, Helge Deller wrote:
> On 9/15/23 11:23, Huacai Chen wrote:
>> On Fri, Sep 15, 2023 at 4:16 PM Helge Deller <deller@gmx.de> wrote:
>>>
>>> On 9/15/23 05:22, Huacai Chen wrote:
>>>> Hi Helge,
>>>>
>>>> On Wed, Sep 13, 2023 at 3:18 AM Helge Deller <deller@gmx.de> wrote:
>>>>>
>>>>> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
>>>>> more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
>>>>> and init_section_contains() to verify if a lock is located inside a
>>>>> kernel static data section.
>>>>>
>>>>> This change triggers a failure on LoongArch, for which the vmlinux.lds.S
>>>>> script misses to put the locks (as part of in the .data.rel symbols)
>>>>> into the Linux data section.
>>>>> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
>>>>> into the kernel data section (from _sdata to _edata).
>>>>>
>>>>> Additionally, move other wrongly assigned symbols too:
>>>>> - altinstructions into the _initdata section,
>>>
>>>> I think altinstructions cannot  be put into _initdata because it will
>>>> be used by modules.
>>>
>>> No.
>>> arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of the kernel
>>> and altinstructions are replaced before modules are loaded.
>>> For altinstructions in modules the linker script scripts/module.lds.S is used.
> 
>> OK, then what about .got/.plt? It seems arm64 also doesn't put them in
>> the data section.
> 
> arm64 seems to throw away all plt entries already at link time (and just keeps
> the got.plt in the read-only data section).
> It even checks at link time, that there are no plt entries in the binary:
>          ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
> 
> I don't know for loongarch, but if you need the plt entries for loongarch, it's
> safest & best to put them into the read-only data section too, which is what my patch does.
> Up to now, you have them completely outside of code & data sections.
> 
> In the end you need to decide for your platform. My patch is a suggestion, which I think
> is correct (untested by me, but Guenter replied he tested it).
> But to fix the lockdep problem at minimum the move of the .data.rel section
> is needed.
> 

Just my $0.02 .. it might make sense to concentrate on the minimum to get the immediate
problem fixed. Loongarch maintainers can then decide at their own pace if they want
to apply any of the other changes you suggested. After all, unless I am missing
something, those additional changes are not really needed in stable releases.

Thanks,
Guenter

