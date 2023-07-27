Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795EE7642DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjG0AOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG0AOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:14:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5461AD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:14:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686ea67195dso335304b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416889; x=1691021689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueENmT0DIXCVaUSH4rOLoKo2KUhTNxrToyXv/aFduM0=;
        b=kvy9161sn4Hxo1x6t+xx0pZ/ZoZymqHOCwF+5vDNn4ghPPfr6eQt0jnFx4qflvimfu
         wTAmHiEZwSt5N/fgXePw1BqbsQPe1lSZ7VkSwBpqcmoUbQvnWb/qFUxLwHUJVvmTeNoQ
         1tH9xWJhCmdPWUEmLpyLmcl8sfwtM8fPItox6Hdb1uhZnPvEQ0V4xbYfrzCS4XtKjR47
         cB5ndary9xxRVqEgtgwuB1Krssb0vSG6P87n9mrgESnGUNBWZ4SAcTupLBJIF8r0f+Fj
         DxEnCBbDAgQ8faKqJaoz/hMxbFi/B/kkHb/AvgHcUfdhf2izoK2d2fGi4Oh2lBbkUnT0
         ELRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416889; x=1691021689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueENmT0DIXCVaUSH4rOLoKo2KUhTNxrToyXv/aFduM0=;
        b=aNWQMy7/vgMpFWCC3lDF8LCdcV/9lltIishi/sDRakRgvpDhgtoAMk7okTI4cCs3IA
         rLup7VoR2Dj6rCoY+dxVjQ2v/rsNe6A3dblT25+HAugzIqPv/z8dmG4e3yZVgN+uZGiu
         GdG6BaVmsyk0kk8hAtksKv9G5PtZvpv3Uko/batStc6CkaWjy/5ISgQQgSfVQgsQHD2x
         WhsM8z11HnKVSAipC4o2Aet95ZedXCxl0FNB5McwjciYABE2qTO+cVEyqineqG/q0c3d
         HsSirZarH+SDtJ16f4ljujyYqjOku/Bqxz16nLR0vmWIvpOsumXxj31iORt20oTMmPug
         qR0w==
X-Gm-Message-State: ABy/qLaLs4/B3kdWKJjIOBAEafYQsNVzKqahwhx4UxK6OjNdJY2E6jF+
        cem7JulZFL7kFSpHbP/3hfI=
X-Google-Smtp-Source: APBJJlGzjFbtkfWUQBbmU2XWl86jGzZAIZEXjxcNS/2jYBgHjSVQCICnzOLt/PfvGlQLpvZluIEjyg==
X-Received: by 2002:a05:6a00:b4c:b0:680:98c:c58d with SMTP id p12-20020a056a000b4c00b00680098cc58dmr4336170pfo.2.1690416889150;
        Wed, 26 Jul 2023 17:14:49 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b00682c8637109sm185143pfv.34.2023.07.26.17.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:14:48 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:14:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZMG29WmwQFVgTSCv@yury-ThinkPad>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
 <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:08:28AM +0200, Alexander Potapenko wrote:
> On Sun, Jul 23, 2023 at 3:57 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:
> > > +/**
> > > + * bitmap_write - write n-bit value within a memory region
> > > + * @map: address to the bitmap memory region
> > > + * @value: value of nbits
> > > + * @start: bit offset of the n-bit value
> > > + * @nbits: size of value in bits, up to BITS_PER_LONG
> > > + */
> > > +static inline void bitmap_write(unsigned long *map,
> > > +                             unsigned long value,
> > > +                             unsigned long start, unsigned long nbits)
> > > +{
> > > +     size_t index = BIT_WORD(start);
> > > +     unsigned long offset = start % BITS_PER_LONG;
> > > +     unsigned long space = BITS_PER_LONG - offset;
> > > +
> > > +     if (unlikely(!nbits))
> > > +             return;
> > > +     value &= GENMASK(nbits - 1, 0);
> >
> > Strictly speaking, a 'value' shouldn't contain set bits beyond nbits
> > because otherwise it's an out-of-bonds type of error.
> 
> I can easily imagine someone passing -1 (or ~0) as a value, but
> wanting to only write n bits of n.

This is an abuse of new API because we've got a bitmap_set(). But
whatever, let's keep that masking.

...
 
> I like the idea of sharing the first write between the branches, and
> it can be made even shorter:
> 
> ===========================================================
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

        space >= nbits <=>
        BITS_PER_LONG - offset >= nbits <=> 
        offset + nbits <= BITS_PER_LONG

>         map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :

So here GENMASK(nbits + offset - 1, offset) is at max:
GENMASK(BITS_PER_LONG - 1, offset). And it never overflows, which is my
point. Does it make sense?

> ~BITMAP_FIRST_WORD_MASK(start));

As I said, ~BITMAP_FIRST_WORD_MASK() is the same as BITMAP_LAST_WORD_MASK()
and vise-versa.

>         map[index] |= value << offset;
>         if (fit)
>                 return;
> 
>         map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
>         map[index + 1] |= (value >> space);
> }
> ===========================================================
> 
> According to Godbolt (https://godbolt.org/z/n5Te779bf), this function
> is 32 bytes shorter than yours under x86 Clang, and 8 bytes - under
> GCC (which on the other hand does a poor job optimizing both).
> 
> Overall, given that there's currently a single user of these
> functions, isn't it premature to optimize them without knowing
> anything about their performance?
> 
> > In previous iteration, I asked you to share disassembly listings for the
> > functions. Can you please do that now?
> 
> Will godbolt work for you (see above)?

I don't know for how long an external resource will keep the reference
alive. My SSD keeps emails long enough.

...

> > You're mentioning that the compression ratio is 2 to 20x. Can you
> > share the absolute numbers? If it's 1k vs 2k, I think most people
> > just don't care...
> 
> I'll provide the exact numbers with the next patch series. Last time I
> checked, the order of magnitude was tens of megabytes.

That's impressive. Fruitful idea. It would be important for embedded guys
who may disable MTE because of memory overhead. I think it's worth to
mention that in Kconfig together with associate performance overhead,
if it ever measurable.

> > Can you share the code that you used to measure the compression ratio?
> > Would it make sense to export the numbers via sysfs?
> 
> For out-of-line allocations the data can be derived from
> /proc/slabinfo, but we don't calculate inline allocations.
> Agreed, a debugfs interface won't hurt.
