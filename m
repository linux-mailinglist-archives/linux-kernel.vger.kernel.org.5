Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7637D5F93
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJYBvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:51:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE2B9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:51:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso4898916b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698198676; x=1698803476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOKKG0CgjGN6zyzGsDHHzCAGDWujCIMfweGLdxpJv/0=;
        b=iQJyN1UoOT4ABPNokFjPmwoM+bJs2gDt005JqVgBz7DP2bl+5GEeJiGqX3OLna0bvt
         mLf8+NjJ5DlTEu1wy34Cjp2Q2boneElnnHUd91CWk9/dwKo1ZCzu7m0xAR5vn46rUaO8
         qSXSBZcGhBcw/wv+HcOunaXsM5wBnW9eEYAmCorS1Z6WGbRENM9SRYpIgXUyL8jd/PY+
         xNlTaIO+yhKkqHa7XOzF9pYPpVxZv9wVbRah8MUSxxMmFsxhckrIYXd0DsbR31K1ZhRU
         58XrvfXqk44iQ6/WkPszR6tErEg8NvF3ODY6nvsZBClxYxhDMdvjU6vmwWkDMqAeJM57
         hFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698198676; x=1698803476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOKKG0CgjGN6zyzGsDHHzCAGDWujCIMfweGLdxpJv/0=;
        b=SQD7S3ilwYV8gWzaSK5K6+a3NhnlLVzOt+pVloJEE5VS2fhShK72MvT6fjzdSbnXtU
         QtucNoDqufCZoDK0lO4sE9t51NMXh11TlgXu0v+dFlnQPqQDsCgpgb7X482onYh0VQDt
         7U0xbC46to2sNCiffnLfDfGZUOeBdeBGVEGL8YfSU6BAi7xQ5LK3naQUorg93N9LTq92
         qJYVCGE4zStbIWOM/0PTsuBDLbvnImm4q4J34dKn8t26y7EtqwoBZswZ9hL0Yr8x5leo
         9a5ZkbtF3jmXk6zA5rOdmDzLs+KL+K/2O5Ae2wtls3/JgbWYHg7/wcRAxrwWqy7XFDDY
         XmXQ==
X-Gm-Message-State: AOJu0Yx1zNjUVbUOuwRli4RrSAUh2a+1Q13tIpJDiut0/6j8s0t3M5B9
        x58EVav6q/wBjwRYYw0qjXrMxw==
X-Google-Smtp-Source: AGHT+IG7gggf3CdB7cn4+Kno5v6ImLdC4JHYDmnIzMEbnywNYNLqmtpUHLKjRHRNCAIri01OycpZyg==
X-Received: by 2002:a05:6a00:178e:b0:690:3793:17e5 with SMTP id s14-20020a056a00178e00b00690379317e5mr17276979pfg.4.1698198676463;
        Tue, 24 Oct 2023 18:51:16 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b00690cd981652sm8256267pfn.61.2023.10.24.18.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 18:51:16 -0700 (PDT)
Message-ID: <efe7e4ad-6ee8-08c3-d43f-d7c54de04045@bytedance.com>
Date:   Wed, 25 Oct 2023 09:51:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Content-Language: en-US
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
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
In-Reply-To: <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/25 07:42, Masami Hiramatsu (Google) wrote:
> On Tue, 24 Oct 2023 16:08:12 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
>>> in SH architecture because it does not implement arch_cmpxchg_local().
>>
>> I do not think this is correct.
>>
>> The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
>> disables interrupts), whereas arch/sh can be built SMP. We should probably add
>> some guards into <asm-generic/cmpxchg-local.h> for that as we have in
>> <asm-generic/cmpxchg.h>.
> 
> Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
> on local CPU?

asm-generic/cmpxchg.h is only for UP, will throw an error for SMP building:

#ifdef CONFIG_SMP
#error "Cannot use generic cmpxchg on SMP"
#endif

SH arch seems it does have SMP systems. The arch/sh/include/asm/cmpxchg.h has
the following codes:

#if defined(CONFIG_GUSA_RB)
#include <asm/cmpxchg-grb.h>
#elif defined(CONFIG_CPU_SH4A)
#include <asm/cmpxchg-llsc.h>
#elif defined(CONFIG_CPU_J2) && defined(CONFIG_SMP)
#include <asm/cmpxchg-cas.h>
#else
#include <asm/cmpxchg-irq.h>
#endif

> So I think it doesn't care about the other CPUs (IOW, it should not touched by
> other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
> defined as raw "cmpxchg" without lock prefix.
> 
> #define __cmpxchg_local(ptr, old, new, size)                            \
>          __raw_cmpxchg((ptr), (old), (new), (size), "")
> 
> 
> Thank you,
> 
> 
>>
>> I think the right thing to do here is to define arch_cmpxchg_local() in terms
>> of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:
>>
>> #define arch_cmpxchg_local              arch_cmpxchg

I agree too. Might not be performance optimized but guarantees correctness.

>> Mark.
>>
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>   arch/sh/include/asm/cmpxchg.h |    2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
>>> index 288f6f38d98f..e920e61fb817 100644
>>> --- a/arch/sh/include/asm/cmpxchg.h
>>> +++ b/arch/sh/include/asm/cmpxchg.h
>>> @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>>>   				    (unsigned long)_n_, sizeof(*(ptr))); \
>>>     })
>>>   
>>> +#include <asm-generic/cmpxchg-local.h>
>>> +
>>>   #endif /* __ASM_SH_CMPXCHG_H */
>>>
> 
> 

