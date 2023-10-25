Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660B7D69C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJYLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:06:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E853EBB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:06:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb85afef4so4774303b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698232005; x=1698836805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmF6vIOKAFLoIxJ+NOBZUX7LWmsqyNwmedqxH+oWpHU=;
        b=QPuBJdw5uKLYH7tZ/upXDmSQ/cGz/y4fNHEjUHwAFbhNKQZMZsp8PYKe1iYCxKlFpz
         C1QHQLtMEqG8/IA0FougIKD2SoeaZVH2K5GlZ4G74TJdXM560hb5SLc+hatwBjhPoRwl
         xiMpiakYRkwaBBYh7HELARtOZAqRStmSLHEJKFWtN8reNjHbswjmCr47obgJlA3hdDVS
         tjZWVGqeOGE8ZCAtM9Ng8E0qj40W22Jya1r+65rc8zeWJP07uDxqt2sw6WMEsExdRvd2
         xMAU0HFda0+xGidEnJ6kDu3pjYTbfXI29TInduHU5Se99w0yc0nZRclFEIJh9wwDbDbK
         qelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698232005; x=1698836805;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmF6vIOKAFLoIxJ+NOBZUX7LWmsqyNwmedqxH+oWpHU=;
        b=YhaUhIbQYbwEfzG5k+GiO7NY2z/U2EiToLpqe9WlqSCiCuXmQxeUEPkOOPEb1mksOs
         iOUS/LNogN11mGBpTh8Q3Raoo5zTtURnBIw1WAlJmGP8g6knKiiOmzAcPGe4bZf4JBaQ
         RGV3qao9OacTB3HITHsqsuqRUSGOI6J6mZVYsNKphem3sdDVlna52cA8MGXKBluWgcsJ
         qHYsgBxMXPx//paQZAyXdREt6dcqshtOc2bJB3HFIH0MF/C5EDBDHWV63KIm1mCVmgUP
         nxySSILZ1btMlnUUSFfmnJ7I/gkfcDxAecFBftipwoUilr9B7Pq/LsPlBi+QIOAOAXu9
         pLew==
X-Gm-Message-State: AOJu0Yw1nrgW1v/BPOLfuTEasNB3U0WjnzR1yG58Echv5u7VHmQQ6igT
        PqaAJgGHCl/ekQKc+VXOm+cEwA==
X-Google-Smtp-Source: AGHT+IHZOlfXaDxEfREdyePwswftBZddQgjLhnw9Mvlypk5+BA1mS89IKQDUwz3NF12BNvbAF42tCw==
X-Received: by 2002:a05:6a20:3d08:b0:174:373b:4381 with SMTP id y8-20020a056a203d0800b00174373b4381mr6732397pzi.49.1698232005331;
        Wed, 25 Oct 2023 04:06:45 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id w2-20020a636202000000b00578b40a4903sm8779554pgb.22.2023.10.25.04.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:06:45 -0700 (PDT)
Message-ID: <0f48e36b-b8c1-443a-f7c3-b9ddea2c503c@bytedance.com>
Date:   Wed, 25 Oct 2023 19:06:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Content-Language: en-US
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
 <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
 <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
 <efe7e4ad-6ee8-08c3-d43f-d7c54de04045@bytedance.com>
In-Reply-To: <efe7e4ad-6ee8-08c3-d43f-d7c54de04045@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/25 09:51, wuqiang.matt wrote:
> On 2023/10/25 07:42, Masami Hiramatsu (Google) wrote:
>> On Tue, 24 Oct 2023 16:08:12 +0100
>> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>>> On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
>>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>
>>>> Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
>>>> in SH architecture because it does not implement arch_cmpxchg_local().
>>>
>>> I do not think this is correct.
>>>
>>> The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
>>> disables interrupts), whereas arch/sh can be built SMP. We should probably add
>>> some guards into <asm-generic/cmpxchg-local.h> for that as we have in
>>> <asm-generic/cmpxchg.h>.
>>
>> Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
>> on local CPU?
> 
> asm-generic/cmpxchg.h is only for UP, will throw an error for SMP building:
> 
> #ifdef CONFIG_SMP
> #error "Cannot use generic cmpxchg on SMP"
> #endif

Sorry that I just noticed Masami's patch has asm-generic/cmpxchg-local.h
included, not asm-generic/cmpxchg.h. cmpxchg.h does throw an error for SMP
configs, but cmpxchg-local.h doesn't.

> SH arch seems it does have SMP systems. The arch/sh/include/asm/cmpxchg.h has
> the following codes:
> 
> #if defined(CONFIG_GUSA_RB)
> #include <asm/cmpxchg-grb.h>
> #elif defined(CONFIG_CPU_SH4A)
> #include <asm/cmpxchg-llsc.h>
> #elif defined(CONFIG_CPU_J2) && defined(CONFIG_SMP)
> #include <asm/cmpxchg-cas.h>
> #else
> #include <asm/cmpxchg-irq.h>
> #endif
> 
>> So I think it doesn't care about the other CPUs (IOW, it should not touched by
>> other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
>> defined as raw "cmpxchg" without lock prefix.
>>
>> #define __cmpxchg_local(ptr, old, new, size)                            \
>>          __raw_cmpxchg((ptr), (old), (new), (size), "")
>>
>>
>> Thank you,
>>
>>
>>>
>>> I think the right thing to do here is to define arch_cmpxchg_local() in terms
>>> of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:
>>>
>>> #define arch_cmpxchg_local              arch_cmpxchg
> 
> I agree too. Might not be performance optimized but guarantees correctness.
> 
>>> Mark.
>>>
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: 
>>>> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
>>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>> ---
>>>>   arch/sh/include/asm/cmpxchg.h |    2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
>>>> index 288f6f38d98f..e920e61fb817 100644
>>>> --- a/arch/sh/include/asm/cmpxchg.h
>>>> +++ b/arch/sh/include/asm/cmpxchg.h
>>>> @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * 
>>>> ptr, unsigned long old,
>>>>                       (unsigned long)_n_, sizeof(*(ptr))); \
>>>>     })
>>>> +#include <asm-generic/cmpxchg-local.h>
>>>> +
>>>>   #endif /* __ASM_SH_CMPXCHG_H */
>>>>
>>
>>
> 

