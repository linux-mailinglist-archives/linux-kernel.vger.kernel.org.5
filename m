Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DE781DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjHTMnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjHTMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:43:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8B46B0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:41:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c504386374so1811427fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692535262; x=1693140062;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/UepjmmwRqS7wRG3YQoZ+ltBfUkEu+XD/qNnf6ViU0=;
        b=ZsidU9/X+P/PzRHunU6Bd7XtG5EssCI6MAUaWwYrHjuZ9fHHiQTx6/GnDA6cqBQVjG
         0w/wuzSne2VhN/9MXOxHdUJy8+0CFZhA5cUnWGhIXsiXLI5fPK4fcdEQC17BYofL+7CC
         NsHYlcXjpAeyo5F3b9DAu5H+lEHSvPp5GG7/Y3jdgDKF10aZODYX45fNFbR9CiD3ThHj
         ykpfi4u+s3zwnZsfAmygGMLHD1JoD96ga17E/UN6ijCNkcMyrHwNVNLOgJ5GtJ1DeXFo
         U4cBPPYzMRHyjR+JVaXNWiakg413ZbvB8uWU9nPSQCAgCkLLlt93+/za0wn9ygUadY4V
         6HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692535262; x=1693140062;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/UepjmmwRqS7wRG3YQoZ+ltBfUkEu+XD/qNnf6ViU0=;
        b=XaAqPxmGJ3uW8lQz+ADoLrKlJGi6Hw4Nloel9FvRO1d3ea4RkUOPndm4fpH47Y9+NX
         QNgtlARUw3ozpjSqKX3s3E3yqI5a6RSoJUdFeyfgHEp5GOlHmlDaTQJBHkMTYO2MZyQh
         LrEryk9JStOF6L2+cT17xvf9njsci0WcYHEHY99jHYiFZboab4F/MvsocnTFGUBT0QiH
         B9jJHCLWpn4YVkqNnJvIMdpo9AX/duytJerikwuRJ0yzxCWkRg0TTzT/LlSuNyMJaQIS
         D9inVeLBZyoveJVxMNnRsmgRB9WcutibYVWCTkeVkcXKervRqUTTKmISGzSqsVwT0KNu
         PfnQ==
X-Gm-Message-State: AOJu0YzkgSKYYOZH2KTN/+qN5woY6+PWCQ0b/Ep+NXqFX6+5BiI/95oJ
        pXq+XlR0KVOhlQoeziSnIFJ1VrWthtZB6WB67lYoJy3RELM=
X-Google-Smtp-Source: AGHT+IE6Q88za12cPfRq5zLNMe+6KhWwXIiXJplCCvztczGO+VmrrdULPBZKovrTBIGqz/TVvWP/ADbPxrWZjmLV9VU=
X-Received: by 2002:a05:6871:5227:b0:1bb:b4a2:958f with SMTP id
 ht39-20020a056871522700b001bbb4a2958fmr6643668oac.53.1692535261844; Sun, 20
 Aug 2023 05:41:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:79d9:0:b0:4f0:1250:dd51 with HTTP; Sun, 20 Aug 2023
 05:41:01 -0700 (PDT)
In-Reply-To: <ZOH62Zi/yao/oC8y@casper.infradead.org>
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOH62Zi/yao/oC8y@casper.infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 20 Aug 2023 14:41:01 +0200
Message-ID: <CAGudoHG3OxoYKSwDmJYEDOj6LmDMsQDs3SD5nBdrzA5Vc1_H0A@mail.gmail.com>
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

On 8/20/23, Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
>> Should the trylock succeed (and thus blocking was avoided), the routine
>> wants to ensure blocking was still legal to do. However, the method
>> used ends up calling __cond_resched injecting a voluntary preemption
>> point with the freshly acquired lock.
>>
>> One can hack around it using __might_sleep instead of mere might_sleep,
>> but since threads keep going off CPU here, I figured it is better to
>> accomodate it.
>
> Except now we search the exception tables every time we call it.
> The now-deleted comment (c2508ec5a58d) suggests this is slow:
>

I completely agree it a rather unfortunate side-effect.

> -       /*
> -        * Kernel-mode access to the user address space should only occur
> -        * on well-defined single instructions listed in the exception
> -        * tables.  But, an erroneous kernel fault occurring outside one of
> -        * those areas which also holds mmap_lock might deadlock attempting
> -        * to validate the fault against the address space.
> -        *
> -        * Only do the expensive exception table search when we might be at
> -        * risk of a deadlock.  This happens if we
> -        * 1. Failed to acquire mmap_lock, and
> -        * 2. The access did not originate in userspace.
> -        */
>
> Now, this doesn't mean we're doing it on every page fault.  We skip
> all of this if we're able to handle the fault under the VMA lock,
> so the effect is probably much smaller than it was.  But I'm surprised
> not to see you send any data quantifying the effect of this change!
>

Going off CPU *after* taking the lock sounds like an obviously bad
thing to happen and as such I did not think it warrants any
measurements.

My first patch looked like this:
diff --git a/mm/memory.c b/mm/memory.c
index 1ec1ef3418bf..8662fd69eae8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5259,7 +5259,9 @@ static inline bool
get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs
 {
        /* Even if this succeeds, make it clear we *might* have slept */
        if (likely(mmap_read_trylock(mm))) {
-               might_sleep();
+#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
+               __might_sleep(__FILE__, __LINE__);
+#endif
                return true;
        }

This keeps assertions while dodging __cond_resched.

But then I figured someone may complain about scheduling latency which
was not there prior to the patch.

Between the 2 not so great choices I rolled with what I considered the
safer one.

However, now that I said it, I wonder if perhaps the search could be
circumvented on x86-64? The idea would be to check if SMAP got
disabled (and assuming the CPU supports it) -- if so and the faulting
address belongs to userspace, assume it's all good. This is less
precise in that SMAP can be disabled over the intended users access
but would be fine as far as I'm concerned if the search is such a big
deal.

-- 
Mateusz Guzik <mjguzik gmail.com>
