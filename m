Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48896781DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHTMs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjHTMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:48:53 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DE44BA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:46:28 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bba7717d3bso1591755fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692535587; x=1693140387;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf/mokhlkVqnyRN8z9yUgvzp3OgmnpyJfx27efmYiTE=;
        b=f07wCTHQ+dy4IKEPOQPmXY3h/FC23o6NaydedluJ/g/BTsqMPJR1Fpfj0MRlaGxaQl
         QfvEY3/OFUowt5MBU4rXfJ9UIhawPpovJLqjaeDyf/n4Y8YKRxODRFdQYOvx1gCgVI/o
         A75BJvfZvICysy/duLp/d5fWCL2LSEnyNSPSIw2buVSbXFzcymUuYL2iaMGNx+MyjhZE
         WEotunRHzoHD7633k8iMNqbScFHLPVG9UVX/+lQfyiC2Pg+zNVIDbTzCZIm5XETt2qSL
         Tfcuir6L0Gf1nKURM0/qngyQroSNIDVJgl0JoF5UWreeimRQId5yfFC7xHeS9wRy1tm4
         ti6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692535587; x=1693140387;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf/mokhlkVqnyRN8z9yUgvzp3OgmnpyJfx27efmYiTE=;
        b=a2eVv8oiHt2V9jX8WhEOXVSWKS63RItyHWxSGTxKD2AzD+YPvDUyWwcro8F7oFTg9m
         71xGDFfNlUf+s3op5a5gMqLLbVO3o5PiA193abn3jhP66sLgN1S7pAwtXqJVelY/1ZYa
         nwTEyqzOw6N5r5f57LBYDZtFS34F9Et/hdkJY3Oi8N+lYMcpTQhUXyn1G2Bn4vi5kTZ6
         RIDut4MdhMIAFMAi1gFucEaP1Di/yYcwl9SkxHy9Rh7mb32rbnLKoVCyLlIST/y4fLF/
         CMiul9+lTuZzfRhU72c3WYUUKwszIo7J0kAbxdynyBVn9Fl1EsO6KvMxRAAiXU0HTntJ
         mxLA==
X-Gm-Message-State: AOJu0YwQz5uNOSPrFqSH9TxtNDzXE8B+tvXgD8Gxxl9tnrOaLCuTtxO1
        CaIIf7zKVBTo2nJZM8g5H5C4ic3kMserOK+fl0sVWpqwk0U=
X-Google-Smtp-Source: AGHT+IHSn0+Siyc3vbPr66XdN7GDgF5EwoxPCMGwId2foVng2aVg5afz4gNmRDgzgKuhXWkGH87RHxwSVnTEKghrIpM=
X-Received: by 2002:a05:6870:8288:b0:1bf:e703:f727 with SMTP id
 q8-20020a056870828800b001bfe703f727mr5101148oae.34.1692535587363; Sun, 20 Aug
 2023 05:46:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:79d9:0:b0:4f0:1250:dd51 with HTTP; Sun, 20 Aug 2023
 05:46:26 -0700 (PDT)
In-Reply-To: <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOH62Zi/yao/oC8y@casper.infradead.org>
 <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 20 Aug 2023 14:46:26 +0200
Message-ID: <CAGudoHFRoE0Wxjj9mp6ggMJDfVyu45AMeRPHLTyyq7HusgWs-g@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in get_mmap_lock_carefully
To:     Matthew Wilcox <willy@infradead.org>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 8/20/23, Matthew Wilcox <willy@infradead.org> wrote:
>> On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
>>> Should the trylock succeed (and thus blocking was avoided), the routine
>>> wants to ensure blocking was still legal to do. However, the method
>>> used ends up calling __cond_resched injecting a voluntary preemption
>>> point with the freshly acquired lock.
>>>
>>> One can hack around it using __might_sleep instead of mere might_sleep,
>>> but since threads keep going off CPU here, I figured it is better to
>>> accomodate it.
>>
>> Except now we search the exception tables every time we call it.
>> The now-deleted comment (c2508ec5a58d) suggests this is slow:
>>
>
> I completely agree it a rather unfortunate side-effect.
>
>> -       /*
>> -        * Kernel-mode access to the user address space should only occur
>> -        * on well-defined single instructions listed in the exception
>> -        * tables.  But, an erroneous kernel fault occurring outside one
>> of
>> -        * those areas which also holds mmap_lock might deadlock
>> attempting
>> -        * to validate the fault against the address space.
>> -        *
>> -        * Only do the expensive exception table search when we might be
>> at
>> -        * risk of a deadlock.  This happens if we
>> -        * 1. Failed to acquire mmap_lock, and
>> -        * 2. The access did not originate in userspace.
>> -        */
>>
>> Now, this doesn't mean we're doing it on every page fault.  We skip
>> all of this if we're able to handle the fault under the VMA lock,
>> so the effect is probably much smaller than it was.  But I'm surprised
>> not to see you send any data quantifying the effect of this change!
>>
>
> Going off CPU *after* taking the lock sounds like an obviously bad
> thing to happen and as such I did not think it warrants any
> measurements.
>
> My first patch looked like this:
> diff --git a/mm/memory.c b/mm/memory.c
> index 1ec1ef3418bf..8662fd69eae8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5259,7 +5259,9 @@ static inline bool
> get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs
>  {
>         /* Even if this succeeds, make it clear we *might* have slept */
>         if (likely(mmap_read_trylock(mm))) {
> -               might_sleep();
> +#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
> +               __might_sleep(__FILE__, __LINE__);
> +#endif
>                 return true;
>         }
>
> This keeps assertions while dodging __cond_resched.
>
> But then I figured someone may complain about scheduling latency which
> was not there prior to the patch.
>
> Between the 2 not so great choices I rolled with what I considered the
> safer one.
>
> However, now that I said it, I wonder if perhaps the search could be
> circumvented on x86-64? The idea would be to check if SMAP got
> disabled (and assuming the CPU supports it) -- if so and the faulting
> address belongs to userspace, assume it's all good. This is less
> precise in that SMAP can be disabled over the intended users access
> but would be fine as far as I'm concerned if the search is such a big
> deal.
>

Oof, hit send too fast.

This is less precise in that SMAP can be disabled over A LARGER AREA
THAN the intended users access but would be fine as far as I'm
concerned if the search is such a big.

there :)

Anyhow I don't feel strongly about any of this, I was mostly
interested in what happens with VFS on the off-CPU front and this one
is just a random thing I needed to check.

Now that I elaborated on my $0,03 I'm happy to respin with the
__might_sleep variant. If someone wants a different fix altogether
they are welcome to ignore these patches.

I do claim the current state *is* a problem though -- it can block
down_write for no good reason.

-- 
Mateusz Guzik <mjguzik gmail.com>
