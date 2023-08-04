Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE334770936
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHDTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHDTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:55:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DCBE6B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:55:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8b4749013so21219695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691178905; x=1691783705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxDcgNPb4ALqTI8jFdG+ikFtI22FTqRf7jA6o2d1Mzw=;
        b=JvvN8QUWoWu5TF9/EpmB2K2W2Xmu617fpS/88f+ly5El2N1YwGqzjlSbs2vlUjLrZL
         QWIlzyPc6AFFqDX2wGOJHZNFuGnJ2VcFtp9QnDS8qIwi7f0F669maFvI0D0mchfcdgUe
         5iBi3SVwJne+drd52ePSB2aGteLuE6AoDKeguqpjEgqYHeV5Gxiksj4SPxewSCKSrRWV
         4nR/9IQjSLYD8evXauCCVq3YVQs+jOFsKkLw0FekG29Qv6MY0GHoS/oTODJGoEDZJwc6
         m/U0cNBcxn/nfoqLUw1299ePWQqwPUGTj0yT3DGfY5TgbSSK9E7q/brVkykxEIx7Ldi5
         J+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691178905; x=1691783705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxDcgNPb4ALqTI8jFdG+ikFtI22FTqRf7jA6o2d1Mzw=;
        b=QTKptCDQf9ffMMeaKKluocaU/pN37yG74+fS4fKfDplFAqmgLNSrXBpqko3eNIEuaJ
         r+jJI3D6zCVjb/MYojJvAvKm8hrSOFJ0iPQ4cWk0VMkrxvSGvAWQzsyrR81TYQmEt6Pm
         DEwihTiyVLALyV5HaK7o+BKg7P7/ys/LGEcXbFTeu6Kxr8og7QuR/gPt0i9EtAHdpgNz
         XlNKuScaKHokmsuG6D/Aov+AelgtxLQSArP+ANAc2G4dZuyCYWLR6x0dB4KyXwjto4rc
         8pBltr4SGYQEHDZNAwYbq/hB/wTL0bPVKqR0yeVJphXueZ96ZEEuL5+6oTfHt/L9A2UJ
         mvnA==
X-Gm-Message-State: AOJu0Yz+x5lSBylexdpE9EcS1WynabT8/cZHnU4WaqZvu9ux4ncZNTW0
        AofytBUPqWv/abwlG3lsq2c=
X-Google-Smtp-Source: AGHT+IEWFFIZJuRZ9SRFhjjxP9+mcq7PLSDqlvQMu6U2RGPevd+juI2lb4OGfFpd+aAiauKr6eJ2hQ==
X-Received: by 2002:a17:903:493:b0:1bb:cf4e:ccd with SMTP id jj19-20020a170903049300b001bbcf4e0ccdmr2937804plb.28.1691178904791;
        Fri, 04 Aug 2023 12:55:04 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001bbb22652a4sm2119616plb.226.2023.08.04.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:55:04 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:55:01 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZM1XlUbAJ7Qpd6OO@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
 <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
 <ZMG29WmwQFVgTSCv@yury-ThinkPad>
 <CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:07:00PM +0200, Alexander Potapenko wrote:
> >         space >= nbits <=>
> >         BITS_PER_LONG - offset >= nbits <=>
> >         offset + nbits <= BITS_PER_LONG
> >
> > >         map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
> >
> > So here GENMASK(nbits + offset - 1, offset) is at max:
> > GENMASK(BITS_PER_LONG - 1, offset). And it never overflows, which is my
> > point. Does it make sense?
> 
> It indeed does. Perhaps pulling offset inside GENMASK is not a bug
> after all (a simple test does not show any difference between their
> behavior.
> But `GENMASK(nbits - 1 + offset, offset)` blows up the code (see below).
> My guess is that this happens because the compiler fails to reuse the
> value of `GENMASK(nbits - 1, 0)` used to clamp the value to write, and
> calculates `GENMASK(nbits - 1 + offset, offset)` from scratch.

OK. Can you put a comment explaining this? Or maybe would be even
better to use BITMAP_LAST_WORD_MASK() here:

         mask = BITMAP_LAST_WORD_MASK(nbits);
         value &= mask;
         ...
         map[index] &= (fit ? (~mask << offset)) :

> > > ~BITMAP_FIRST_WORD_MASK(start));
> >
> > As I said, ~BITMAP_FIRST_WORD_MASK() is the same as BITMAP_LAST_WORD_MASK()
> > and vise-versa.
> 
> Surprisingly, ~BITMAP_FIRST_WORD_MASK() generates better code than
> BITMAP_LAST_WORD_MASK().
 
Wow... If that's consistent across different compilers/arches, we'd
just drop the latter. Thanks for pointing that. I'll check.

> > >         map[index] |= value << offset;
> > >         if (fit)
> > >                 return;
> > >
> > >         map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> 
> OTOH I managed to shave three more bytes off by replacing
> ~BITMAP_LAST_WORD_MASK with a BITMAP_FIRST_WORD_MASK here.
> 
> > >         map[index + 1] |= (value >> space);
> > > }
> 
> I'll post the implementations together with the disassembly below.
> I used some Clang 17.0.0 version that is a couple months behind
> upstream, but that still produces sustainably shorter code (~48 bytes
> less) than the trunk GCC on Godbolt.
> 
> 1. Original implementation of bitmap_write() from this patch - 164
> bytes (interestingly, it's 157 bytes with Clang 14.0.6)

I spotted that too in some other case. Newer compilers tend to
generate bigger code, but the result usually works faster. One
particular reason for my case was a loop unrolling.

[...]

> 3. My improved version built on top of yours and mentioned above under
> the name bitmap_write_new() - 116 bytes:

30% better in size - that's impressive!
 
> ==================================================================
> void bitmap_write_new(unsigned long *map, unsigned long value,
>                       unsigned long start, unsigned long nbits)
> {
>         unsigned long offset;
>         unsigned long space;
>         size_t index;
>         bool fit;
> 
>         if (unlikely(!nbits))
>                 return;
> 
>         value &= GENMASK(nbits - 1, 0);
>         offset = start % BITS_PER_LONG;
>         space = BITS_PER_LONG - offset;
>         index = BIT_WORD(start);
>         fit = space >= nbits;
> 
>         map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
> ~BITMAP_FIRST_WORD_MASK(start));
>         map[index] |= value << offset;
>         if (fit)
>                 return;
> 
>         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>         map[index + 1] |= (value >> space);
> }

Thanks,
Yury
