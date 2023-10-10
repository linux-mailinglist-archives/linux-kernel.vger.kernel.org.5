Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259547BF714
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjJJJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:18:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1294C131
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:18:21 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66cfc96f475so612026d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696929500; x=1697534300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FT+EGoHiRbRz6J6XqyF0y/UuS8+2QnkmQ0W0034VfA=;
        b=pB1lO1i/QalwLbiMRoNmdrIC6jGNy5lJaWz21k2EYtp8119VV+ibNmAAr8agSWKUq5
         vpQSZzN0TD5Llq5Nx17Jqbsz42+L9yRgcNubU14CfaIogQkFkjpD6LXCZr+mOpmLl6SA
         F18DzBmYDU3ElDreMqeEWWa6o20Vfg4UCmLxHnlEWb6a6MG71GShPBxBTVWkPEUe88u3
         r4MQ2pFDzCRFYnJ21cGy+zkR+dMG94ko+TsMAeEOtQKXNiYgCJHbgI7p7pMNIf7FU2YZ
         fhs4E/5rxfW+r2aLD0agKT8QLXa+TkfVMwp1nAlzjXroolznqwSEQDKy8hb21Oc+OMHv
         Jj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929500; x=1697534300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FT+EGoHiRbRz6J6XqyF0y/UuS8+2QnkmQ0W0034VfA=;
        b=s5jdQQGJivNFIvEY39+9/GpulL1tS9K8e3hFofpBfSSmMYOWwVihC/8B8Dz1j51x5/
         jZ6/0zVdCRAVwXG6GpMr7E3LuLgt+9GrbG84cSzlLDcbQFvnwfCOglYZbueCHt4uDqZt
         k2tiCrAqofzOu4LODPxkfix1+l5syh29v5L89kOEtRPsUEFwRCOoKRnxe15ShutiZ8lh
         W9sWDGSTbJdiYgsz5hpjbLLGJtqKGVOvcrIE3WoKzzBlAWGG63BDnhuk3PBPqRxJ8u6F
         HgwTMeHkeoyDGLDBF8tyTKCW8rDPkfwtALigH2ZgoZWqKodsr+CWMwao6WRNWFmZs/mx
         CoYw==
X-Gm-Message-State: AOJu0YyfQn0PEzjkmOJD+GKGVmDMIzbPvFKkIVVdEWP97D3cqxQQQipK
        Dp6PWrqQfrV0R9gkHWIOVcGLSMNijnP2MLsJAA0pxw==
X-Google-Smtp-Source: AGHT+IEEhA5Zl7wE4jW+FMTZ0jZmoIzdCze0mS/KWhbVhdYz/1SmuBcUFXEW6TL1NQm6xr1kTloKJyzwTtm9U+kBk5U=
X-Received: by 2002:a0c:cc04:0:b0:66c:d8dd:ef5c with SMTP id
 r4-20020a0ccc04000000b0066cd8ddef5cmr4648198qvk.13.1696929500011; Tue, 10 Oct
 2023 02:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231006134529.2816540-1-glider@google.com> <20231006134529.2816540-2-glider@google.com>
 <ZSCLuCu9yMyDdHni@yury-ThinkPad>
In-Reply-To: <ZSCLuCu9yMyDdHni@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Oct 2023 11:17:39 +0200
Message-ID: <CAG_fn=XHiVyRO-JiOSFREgJjXWjU9Zc1CCMPYV2Xx4LA8P8tkA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + *
> > + *   for (bit = 0; bit < nbits; bit++)
> > + *           assign_bit(start + bit, bitmap, val & BIT(bit));
>
> __assign_bit()

Ack

>
> > + */
>
> 'behaves similarly' sounds like an understatement. I think, it behaves
> much faster because it can assign up to 64 bits at once, not mentioning
> the pressure on cache lines traffic.

My intent was to describe the visible behavior, of course the
generated code is better, and the number of memory accesses lower.

How about the following description:

 * The result of bitmap_write() is similar to @nbits calls of assign_bit(), i.e.
 * bits beyond @nbits are ignored:
 *
 *   for (bit = 0; bit < nbits; bit++)
 *           assign_bit(start + bit, bitmap, val & BIT(bit));

?

>
> How faster - that's a good question. I'd be really pleased if you add
> a performance test for bitmap_write/read. Or I can do it myself later.
> You can find examples in the same lib/test_bitmap.c.

I can add two separate functions doing some bitmap_read and
bitmap_write calls in a loop to measure their performance
independently - along the lines of what you did here:
https://lore.kernel.org/lkml/ZL9X0TZb%2FQhCbEiC@yury-ThinkPad/


> > +     if (unlikely(!nbits))
> > +             return;
>
> can you please add more empty lines to separate blocks visually?

Sure, will do.

>
> > +     mask = BITMAP_LAST_WORD_MASK(nbits);
> > +     value &= mask;
> > +     if (space >= nbits) {
> > +             map[index] &= ~(mask << offset);
> > +             map[index] |= value << offset;
> > +             return;
> > +     }
> > +     map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > +     map[index] |= value << offset;
> > +     map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > +     map[index + 1] |= (value >> space);
> > +}
>
> I compiled the below fix on spark64 BE machine:
>
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -608,7 +608,7 @@ static inline unsigned long bitmap_read(const unsigned long *map,
>         if (unlikely(!nbits))
>                 return 0;
>         if (space >= nbits)
> -               return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> +               return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
>         value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
>         value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
>         return (value_low >> offset) | (value_high << space);
> @@ -661,9 +661,9 @@ static inline void bitmap_write(unsigned long *map,
>                 map[index] |= value << offset;
>                 return;
>         }
> -       map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +       map[index] &= BITMAP_LAST_WORD_MASK(start);
>         map[index] |= value << offset;
> -       map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +       map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>         map[index + 1] |= (value >> space);
>  }
>
> All the tests are passed just as before, and there's no any difference
> reported by bloat-o-meter. Can you please use non-negation versions as
> they are more straightforward?

I am terribly sorry for this, but this code version is completely
different from what we've discussed here:
https://lore.kernel.org/lkml/CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com/

The correct version roughly looks as follows:

void bitmap_write(unsigned long *map, unsigned long value,
                      unsigned long start, unsigned long nbits)
{
        unsigned long offset, space, mask;
        size_t index;
        bool fit;

        if (unlikely(!nbits))
                return;

        mask = BITMAP_LAST_WORD_MASK(nbits);
        value &= mask;
        offset = start % BITS_PER_LONG;
        space = BITS_PER_LONG - offset;
        index = BIT_WORD(start);
        fit = space >= nbits;

        map[index] &= (fit ? (~(mask << offset)) :
~BITMAP_FIRST_WORD_MASK(start));
        map[index] |= value << offset;
        if (fit)
                return;

        map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
        map[index + 1] |= (value >> space);
}

Note that here replacing ~BITMAP_FIRST_WORD_MASK() with
BITMAP_LAST_WORD_MASK() costs us 25 bytes (116 bytes with
~BITMAP_FIRST_WORD_MASK() vs. 141 bytes without).
