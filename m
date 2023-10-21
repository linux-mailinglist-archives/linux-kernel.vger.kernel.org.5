Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD37D1EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjJUR44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:56:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C8D6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so277323466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697911008; x=1698515808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILprG4exMXJZBE2W/AdcWEmO8g6abjcQF7Y2TjAbtlE=;
        b=T0oCKoRQtuH5grcYxKY+vMgU58ZaLoL5RWKB+2eXYCYBaOUkHxCtKh9SVUGQzwZUiM
         dLu+ZsOLJXUHHtsmppJOW6UkloD3uFLZS7+SPn0lndQDTT6L38kcAklgZdbOhyvKYjxT
         faohfxTW6QfiN2if5lJtv6l4lcvNTBVCVLf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697911008; x=1698515808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILprG4exMXJZBE2W/AdcWEmO8g6abjcQF7Y2TjAbtlE=;
        b=NnDLzA3cwtaWDMZeeRHFZA/PaUCUmPAJHxP/DeBPengdJPBfpEdooLb6MuNr5Z58Mb
         n1CK1vbnD0b/eWOFKxI2qTSTT47vP90U+3YIvzjG7Nu886oAHX7dkl8MdVjnR0EqG1mH
         OS1ioxBNAO+KnWakpMm/TLcreCEPf62e48Ksq8l465T/654/7pcYI9/M1GAY6VKYYwFR
         cFtk+AvPKEqDhJ17bVtlXVoLobNat0YAK56QUMqpqnMVJKorxOjxBowLOoM/EXeA0zKc
         7rfjKHbsmeufmPonAXFYV/J+b20yTI/0XbkOyeCK4s59iLvlfvshrfJY5lTZTsKhHOiX
         uw7Q==
X-Gm-Message-State: AOJu0YyRp+mi+XMOjR9jsv311b+ZLXVFdC08+dM6IaDQJcfUrZ5KFH+H
        l4PLj9TR7M0RTTRlqk1+AhXXP2X81t2/ZEKUzpmU5kFX
X-Google-Smtp-Source: AGHT+IFRIKZzzJ60A1T6QaT4olUaYet3TEEHoi84aDvliGvzQipmoojGocFl6VwT1Si3vklBba42EQ==
X-Received: by 2002:a17:907:80e:b0:9b2:aa2f:ab69 with SMTP id wv14-20020a170907080e00b009b2aa2fab69mr3810573ejb.30.1697911007611;
        Sat, 21 Oct 2023 10:56:47 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906089100b009c3f8f46c22sm3944196eje.77.2023.10.21.10.56.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:56:47 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso2782744a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:56:47 -0700 (PDT)
X-Received: by 2002:a05:6402:2553:b0:53d:b52a:5f4b with SMTP id
 l19-20020a056402255300b0053db52a5f4bmr3519347edb.41.1697911006627; Sat, 21
 Oct 2023 10:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
In-Reply-To: <your-ad-here.call-01697881440-ext-2458@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Oct 2023 10:56:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
Message-ID: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2023 at 02:44, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> please pull s390 fixes for 6.6-rc7.

Pulled. HOWEVER.

> - Fix IOMMU bitmap allocation in s390 PCI to avoid out of bounds access
>   when IOMMU pages aren't a multiple of 64.

Please don't do this kind of thing.

And I quote:

    static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
    {
        size_t n = BITS_TO_LONGS(bits);
        size_t bytes;

        if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
                return NULL;

        return vzalloc(bytes);
    }

the above overflow handling is *not* "defensive and good programming".

The above is just "unreadable mindless boiler plate".

Seriously, you're taking a 'size_t' of number of bits, turning it into
number of longs, and you're then turning *that* into number of bytes,
AND YOU ADD OVERFLOW CHECKING?!??!!!

Now, to make matters worse, the above calculation can actually
overflow in theory - but not in the place where you added the
protection!

Because the "longs to bytes" sure as hell can't overflow. We know
that, because the number of longs is guaranteed to have a much smaller
range, since it came from a calculation of bits.

But what can actually overflow? BITS_TO_LONGS(bits) will overflow, and
turn ~0ul to 0, because it does the __KERNEL_DIV_ROUND_UP thing, which
is the simplistic

    #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))

so that code added overflow protection that doesn't make sense, in all
the wrong places.

You need to verify the sanity of the number of bits first anyway.

Of course, in your use-case, the number of bits is also not unlimited,
because the source is

        zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;

so it turns out that no, the BITS_TO_LONGS() won't overflow either,
but at least in some other situations - and only looking at that
bitmap_vzalloc() in a vacuum - it *could* have.

Now, I will argue that you always need range checking on the number of
bits *anyway* for other reasons - trying to just blindly allocate some
random amount of memory isn't acceptable, so there should to be some
range checking before anyway.

But that code is wrong, because the overflow is simply not an issue.
Adding overflow handling code is literally only actively misleading,
making the code harder to read, for no reason, and making people
*think* it's being careful when it is anything *but* careful.

I suspect that the compiler actually sees "that is stupid" and turns
the overflow into just a single left-shift again because it has seen
the (bigger) right-shift and knows it cannot overflow, but the problem
I'm ranting against is mindlessly adding boiler plate code that makes
the code harder to read for *humans*.

If you *do* want to add proper overflow handling, you'd need to either
fix BITS_TO_LONGS() some way (which is actually non-trivial since it
needs to be able to stay a constant and only use the argument once),
or you do something like

        if (!bits)
                return ZERO_SIZE_PTR;
        longs = BITS_TO_LONG(bits);
        if (!longs)
                return NULL;
        return vzalloc(longs * sizeof(long));

and I'd suggest maybe we should

 (a) do the above checking in our bitmap_alloc() routines

 (b) also change our bitmap_alloc() routines to take 'size_t' instead
of 'unsigned int' bit counts

 (c) and finally, add that vzalloc() case, but simply using

        kvmalloc_array(n, size, flags | __GFP_ZERO);

instead.

(And yes, kvmalloc_array() will actually then also do that
check_mul_overflow() thing, but now it's not pointless boiler plate
any more, now it's actually meaningful for *other* cases than the
bitmap allocation one that cannot overflow).

Hmm?

           Linus
