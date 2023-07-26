Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF8762F95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjGZIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGZIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:20:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50435A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-78847bb8940so324923039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690358946; x=1690963746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV4uzZWE/PRKHuYfTo/slDuHO0BgZ0cdYFMAXLwf3OU=;
        b=qvMV+pIFKlRN6nup8t+G3jwXjSJAm69+bXNb0Kk/5o+xH4KsOz+lMkHpnQRlZloOTZ
         Qd6eJ3eXJzX1p+p7bPniUN1ppz10mKhs9euIH1DQ6uZKZpT86CKEgpaRgFkLhm1Mn2xR
         wg3AiU3dcDkFPtnI+MaVdbwSCB1kzldi9pT0/vyM+p9NTLcA7OAA+pAASKBp0tIM1H/5
         DzHzBMiDrJY4XCKjfrkkLZeMIIYRThHN/PY6Z+DUjtu4ELzIucbvvl9H/F59YI/qd1e8
         fDD29+wDXEeoTtFrpIlG8C9eL/v+0AS6oJvwmCzEQj+onSHYYqL2da/hFEM/CNRPf19v
         tsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358946; x=1690963746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV4uzZWE/PRKHuYfTo/slDuHO0BgZ0cdYFMAXLwf3OU=;
        b=akC3RlUGJLiymQapArEPcccy2K9bD18a9w1nHxA+JL986W2D19aUt+EI3Bg5BI2UXx
         Zvi707LqnDi/3oxE+UOX63ox/Rq/9QOO8eocx7rNVcXjWVxz7iuJrlFb7E34lBDh+3in
         fLg83FTW1h+BJ3x55KDkyeSzcfQRLQyk3IqVIm976xk3elmfrn9Ix7b1KmNqLq/6aPY2
         fFJ+RZetn5WNgSlHVE6f9PHyD0d5RI3CNCJIBR/bZaLYY64DyfCsoMytu3o2nhNVYaJ/
         NwEEvcToplsslilqxlmz7DsjQX9mVXBXJpdKkxwa3HdeGbJjScN16inTOm87LRBrL8+3
         Q93A==
X-Gm-Message-State: ABy/qLaqNbcAMYrTKz6Wo6CmSG0Xmgq/8xF8zb0iRHQRN/nNtcoupiLo
        n5tkT71GlSuA3q6R8tnvDFipjgRBqn8ahY/F9xVOBA==
X-Google-Smtp-Source: APBJJlHyNtvilHHA0Rg8StmLt/5ymK7GGGqUG9bm2mf2cQ+BE5ASzuHuh70FLIBqp9o4rs0tF/4fZZzYGUDZafzzzFg=
X-Received: by 2002:a6b:dc08:0:b0:787:8cf:fd08 with SMTP id
 s8-20020a6bdc08000000b0078708cffd08mr1219510ioc.17.1690358946178; Wed, 26 Jul
 2023 01:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
In-Reply-To: <ZLyI+0EL1VztnHLe@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 26 Jul 2023 10:08:28 +0200
Message-ID: <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 3:57=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:
> > +/**
> > + * bitmap_write - write n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value of nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits, up to BITS_PER_LONG
> > + */
> > +static inline void bitmap_write(unsigned long *map,
> > +                             unsigned long value,
> > +                             unsigned long start, unsigned long nbits)
> > +{
> > +     size_t index =3D BIT_WORD(start);
> > +     unsigned long offset =3D start % BITS_PER_LONG;
> > +     unsigned long space =3D BITS_PER_LONG - offset;
> > +
> > +     if (unlikely(!nbits))
> > +             return;
> > +     value &=3D GENMASK(nbits - 1, 0);
>
> Strictly speaking, a 'value' shouldn't contain set bits beyond nbits
> because otherwise it's an out-of-bonds type of error.

I can easily imagine someone passing -1 (or ~0) as a value, but
wanting to only write n bits of n.

>
> This is kind of gray zone to me, because it's a caller's responsibility
> to provide correct input. But on the other hand, it would be a great
> headache debugging corrupted bitmaps.
>
> Now that we've got a single user of the bitmap_write, and even more,
> it's wrapped with a helper, I think it would be reasonable to trim a
> 'value' in the helper, if needed.
>
> Anyways, the comment must warn about that loudly...
>
> > +     if (space >=3D nbits) {
> > +             map[index] &=3D ~(GENMASK(nbits - 1, 0) << offset);
>
> 'GENMASK(nbits - 1, 0) << offset' looks really silly.

As noted in the other patch discussion, pulling offset into GENMASK is
actually not an identity transformation, because nbits + offset may
exceed 64, producing an invalid mask.

>
> > +             map[index] |=3D value << offset;
>
> Here you commit 2 reads and 2 writes for a word instead of one.

There won't be two reads and two writes.
The compiler will read map[index] to a register, apply the mask, then
write value << offset to it, then perform the write.
Unless map[] is a volatile, repeated reads/writes will be optimized
out by any decent compiler.

>
> > +             return;
> > +     }
> > +     map[index] &=3D ~BITMAP_FIRST_WORD_MASK(start);
>
> ~FIRST_WORD is the same as LAST WORD. I tried to replace, and it saves
> ~25 bytes of .text on x86_64.
>
> > +     map[index] |=3D value << offset;
> > +     map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +     map[index + 1] |=3D (value >> space);
> > +}
>
> With all that I think the implementation should look something like
> this:
>
>         unsigned long w, mask;
>
>         if (unlikely(nbits =3D=3D 0))
>                 return 0;
>
>         map +=3D BIT_WORD(start);
>         start %=3D BITS_PER_LONG;
>         end =3D start + nbits - 1;
>
>         w =3D *map & (end < BITS_PER_LONG ? ~GENMASK(end, start) : BITMAP=
_LAST_WORD_MASK(start));
>         *map =3D w | (value << start);
>
>         if (end < BITS_PER_LONG)
>                 return;
>
>         w =3D *++map & BITMAP_FIRST_WORD_MASK(end);
>         *map =3D w | (value >> BITS_PER_LONG * 2 - end);
>
> It's not tested, except the /s/~FIRST_WORD/LAST_WORD/ part, but I expect
> it should be more efficient.
>
> Alexander, can you please try the above and compare?

I like the idea of sharing the first write between the branches, and
it can be made even shorter:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
void bitmap_write_new(unsigned long *map, unsigned long value,
                      unsigned long start, unsigned long nbits)
{
        unsigned long offset;
        unsigned long space;
        size_t index;
        bool fit;

        if (unlikely(!nbits))
                return;

        value &=3D GENMASK(nbits - 1, 0);
        offset =3D start % BITS_PER_LONG;
        space =3D BITS_PER_LONG - offset;
        index =3D BIT_WORD(start);
        fit =3D space >=3D nbits;

        map[index] &=3D (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
~BITMAP_FIRST_WORD_MASK(start));
        map[index] |=3D value << offset;
        if (fit)
                return;

        map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nbits);
        map[index + 1] |=3D (value >> space);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

According to Godbolt (https://godbolt.org/z/n5Te779bf), this function
is 32 bytes shorter than yours under x86 Clang, and 8 bytes - under
GCC (which on the other hand does a poor job optimizing both).

Overall, given that there's currently a single user of these
functions, isn't it premature to optimize them without knowing
anything about their performance?

> In previous iteration, I asked you to share disassembly listings for the
> functions. Can you please do that now?

Will godbolt work for you (see above)?


>
> Regarding the rest of the series:
>  - I still see Evgenii's name in mtecomp.c, and EA0 references;
Will fix, thanks!

>  - git-am throws warning about trailing line;
Interesting, I generate the patches using `git format-patch`, I
thought `git am` should be the inversion of it. I'll check.

>  - checkpatch warns 7 times;

Indeed, there were warnings that I ignored (e.g. one of them was
caused by me adding extern symbols to the test module, as requested
during the review process). I think I can fix all of them.

>
> Can you fix all the above before sending the new version?
>
> Have you tested generic part against BE32, BE64 and LE32 architectures;
> and arch part against BE64? If not, please do.

BE64 works, I'll also need to check the 32-bit versions as well.
Note that MTE is an ARM64 feature (yet we still need to ensure
bitops.h works on 32 bits).

>
> You're mentioning that the compression ratio is 2 to 20x. Can you
> share the absolute numbers? If it's 1k vs 2k, I think most people
> just don't care...

I'll provide the exact numbers with the next patch series. Last time I
checked, the order of magnitude was tens of megabytes.

> Can you share the code that you used to measure the compression ratio?
> Would it make sense to export the numbers via sysfs?

For out-of-line allocations the data can be derived from
/proc/slabinfo, but we don't calculate inline allocations.
Agreed, a debugfs interface won't hurt.
