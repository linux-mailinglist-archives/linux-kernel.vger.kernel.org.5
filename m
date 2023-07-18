Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E583757807
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjGRJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjGRJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:30:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEFAF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:30:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7835e2286c4so286062739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689672637; x=1692264637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI6gByPs+YOOC/r5eIiTeLuVS0+JRea6HBufEifbttg=;
        b=KTW3SoAiLgSKGk4jnI/NB2HrDZaxECcVL5Djd0MpTz6RpRYnPzIRXqegi2Zsvlzi5A
         h6s6PzxvcZFFyst/OhfJreOmip0CLWyg4MUmYCQR+NyiiAG99IE+U/Rwe27OGXVcqNsF
         b4M61AC+hnyDw0hEUs26wXl5coarTdHNPLw1Tw2DT4yqAwzw9Sxnd9R2Gz8bOAbkHCXg
         3jYReMSATjd1hRKXzafRTOIYW/GDyF0t2KoHaY29pmbB+GUOwOMl24Y/UJ8zt37yCB6e
         SKJRZODQHRmgS4HwfnqIXf5HFLRgZtq7cQNcKR7y+ta4nK6yeRaLbtv1ht8V5WVGNbay
         GD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689672637; x=1692264637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI6gByPs+YOOC/r5eIiTeLuVS0+JRea6HBufEifbttg=;
        b=E0pr9+/4FRyo4SR1GI8xiymbYWoWFBY1no0cDLA3n+0BMIWHs9Lvp7et5ZTVrt3Sxo
         4iVSq8sidp7Pubk7AgrMf4t5ccmwHtl16INKB7wyOYhwi/H+/f6rmyglldmyhDXEMx2N
         VVJSM2sv9Bdcpd8WcZYxTgCfgIH+eFEX8FmM54zHiROcXGcmGFKQudN4f4GX9G+hJWG4
         rqtOoiHCOFgyRvH5o9vYct5F8yAbsZ2ZJNpoyhOCc7sder9Ty6UYfUWRvHIdAHzaS6RR
         bJUIA7WvUpjy5VX4poPlD5qvzJyS7a0xl7EE4/7sS8P351JNkNWNjEGDW2OCsdYPBIgw
         5MFg==
X-Gm-Message-State: ABy/qLaXrWPd+2y3TmZfmutdOdj3Z2wwrgl03jXo69Wj6yILnNQ3M2Jd
        NSMeNee9qtr4yZIi+kZ1/wALtMYa6Zqip9KpuFhEmw==
X-Google-Smtp-Source: APBJJlGB9xUVQWBP9+byIV+86aVDRiG0ww0l3jU5yN8rqnNFuAMEX15wd+t3TPQ9mLgdI3A5ly34vBbr7iUriE8X1iY=
X-Received: by 2002:a6b:da1a:0:b0:780:c38e:e785 with SMTP id
 x26-20020a6bda1a000000b00780c38ee785mr1816281iob.17.1689672637382; Tue, 18
 Jul 2023 02:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-2-glider@google.com>
 <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
In-Reply-To: <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 18 Jul 2023 11:30:00 +0200
Message-ID: <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:51=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Jul 17, 2023 at 01:37:04PM +0200, Alexander Potapenko wrote:
> > The two new functions allow setting/getting values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro=
"
> > by Syed Nayyar Waris with a couple of minor changes:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value())
>
> Please preserve Syed's authorship ('From' field in git log).
Done

> >   *  bitmap_set_value8(map, value, start)        Set 8bit value to map =
at start
> > + *  bitmap_set_value(map, value, start, nbits)  Set bit value of size =
'nbits'
> > + *                                              of map at start
>
> The 'bit value of size' sounds more confusing than it should. The size
> of bit is actually a bit... Can you rephrase?
How about "Get an nbits-sized value from map at start" and "Set an
nbits-sized value to map at start"?

> Moreover, 'set bits' has
> a meaning of actually setting them, i.e. switching to '1'. Maybe:
> "Copy 'nbits' to bitmap starting at 'start'"?

Right now it is in line with the comment for bitmap_set_value8 (and
the names of the functions also have _set_ in them).
Shall I also change that comment?
WDYT about "Put an nbits-sized value to map at start"?


> > +/**
> > + * bitmap_get_value - get a value of n-bits from the memory region
> > + * @map: address to the bitmap memory region
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits
>
>
>  * @nbits: size of value in bits, up to BITS_PER_LONG
Ok

> > + *
> > + * Returns value of nbits located at the @start bit offset within the =
@map
> > + * memory region.
> > + */
> > +static inline unsigned long bitmap_get_value(const unsigned long *map,
> > +                                          unsigned long start,
> > +                                          unsigned long nbits)
> > +{
> > +     const size_t index =3D BIT_WORD(start);
> > +     const unsigned long offset =3D start % BITS_PER_LONG;
> > +     const unsigned long space =3D BITS_PER_LONG - offset;
> > +     unsigned long value_low, value_high;
> > +
> > +     if (space >=3D nbits)
> > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > +     value_low =3D map[index] & BITMAP_FIRST_WORD_MASK(start);
> > +     value_high =3D map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbi=
ts);
> > +     return (value_low >> offset) | (value_high << space);
> > +}
>
> When nbits =3D=3D 0, copy-like functions shouldn't touch any memory. See =
how
> other bitmap and find_bit functions hold it.

I think this is different from what other bitmap functions do, but it
should be enough to bail out on !nbits, i.e.:

    if (!nbits)
        return 0;

You probably meant adding a __builtin_constant_p() (which is used all
over the place in bitmap.h), but:
 - the compiler won't have problem optimizing away the code for a
constant nbits=3D0;
 - we anyway need a dynamic check for the case nbits is not constant
(for both bitmap_get_value() and bitmap_set_value(), I assume).

What do you think?
