Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222E57B4AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJBEGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJBEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:06:32 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A66D3;
        Sun,  1 Oct 2023 21:06:28 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-495cf1bf9f9so6026912e0c.2;
        Sun, 01 Oct 2023 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696219587; x=1696824387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7N14C5lw8nxoWs6YpUUkEHECVFntWCWWPn4SACIIVI=;
        b=J6+aKWyBHrlGKS5kgU8bzthrukW1+IuEJ8iyzJlzuXYXmeu1ulnj9HmHwh571jl++d
         7wQxAKXaEuQwJF+aeXZ7mGgkFlgovY94VVp5IzFr28O3lH+sdr1rMXLIJkO9XvNCzuJB
         Cl+eYktIyg+nRQzIgbtsUTF4SRgN74qEnMz4jEt+1wtumQgOFg1I6OmQK/YRlmvM2AcW
         SZ1Jgn0Bh6TRVrHvy0WUTQN71jAEQUFDohBO5CcYGpMrJ2ecQbCY41un+9szYScLaPNL
         +uQXU7XGov6dwDda4exeV4cRRnOiGhaNZohppiXZuzQJRXz2XJBphvzIYBM/gB5UREFn
         ebFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696219587; x=1696824387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7N14C5lw8nxoWs6YpUUkEHECVFntWCWWPn4SACIIVI=;
        b=WtqsJc+w29+G5NuS/JUHCJSywvcZhP7bMD7HE1Yf4Rw4EguY4Cl21w7jUptbFi27v+
         3uGtj+Ez2UBDtzlCPrqowq5hodKbz6S2qYKOyeLqQb9MBGsGFztkBWXgOk2WTlgtMr4Z
         V5Xhyc3Zx0OpPJQMvYMDsw01GnHCG9jGl/2kXtKeB5pW0dcu2zRs0h7/sDG1yuImwXrI
         3v3JnFu7h7m0YtcP+tYO+B6AZYzm7qt+QYH5qsmOGCCxxe8B82Zth8r6q6opHnXYaPq6
         gh+GGajJKOmRkI4dy167Ai6PsUXlUQuhhl5LyDVALcJ0nHEURhkqC1LBYF/VGj6fJyGx
         Ldqw==
X-Gm-Message-State: AOJu0YzCB3Qxc+5DyXpbCiZuTyS/kfYle2iUEvJUhOsPD608C0+uo/fC
        MGSigM5lJ1iV2DBhgOAn0IbI2gAe/DEaEQ==
X-Google-Smtp-Source: AGHT+IHpyA9ox0N97+86UDd7xs50XCnM7RzezJ8RYrQ9jbNn5sUxvlv6Q81SiiShZQVQsb/3chitIw==
X-Received: by 2002:a1f:e3c4:0:b0:49a:b737:4df7 with SMTP id a187-20020a1fe3c4000000b0049ab7374df7mr6283589vkh.5.1696219586025;
        Sun, 01 Oct 2023 21:06:26 -0700 (PDT)
Received: from localhost ([2607:fb90:beca:c7a7:dba8:3746:709f:6151])
        by smtp.gmail.com with ESMTPSA id f24-20020ac5c9b8000000b0049d20faf953sm800101vkm.55.2023.10.01.21.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 21:06:25 -0700 (PDT)
Date:   Sun, 1 Oct 2023 21:06:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZRpBwFznhl+pci/a@yury-ThinkPad>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
 <ZRN2adZZaGeqWNlY@yury-ThinkPad>
 <ZRQZ2m0Rb/4AkeQ3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQZ2m0Rb/4AkeQ3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:02:34PM +0300, Andy Shevchenko wrote:

[...]

> > It looks like those are designed complement to each other. Is that
> > true? If so, can you make your example showing that
> >         scatter -> gather -> scatter
> > would restore the original bitmap?
> 
> It looks like you stopped reading documentation somewhere on the middle.

What a wonderful week of strong statements... Whatever...

> The two APIs are documented with the same example which makes it clear
> that they are data-loss transformations.
> 
> Do you need something like this to be added (in both documentations):
> 
>   The bitmap_scatter(), when executed over the @dst bitmap, will
>   restore the @src one if the @mask is kept the same, see the example
>   in the function description.
> 
> ?
> 
> > If I'm wrong, can you please underline that they are not complement,
> > and why?
> 
> No, you are not.

I should be confused even more. You're saying that I'm not wrong here, and few
lines above you're saying it's a data loss...

I don't mind this new 3-liners, but I'd like you to have a well better
wording and testing around them because those bitmap_scatter/gather are
all about performance, readability and usability.

To begin with, the whole name of the series: "get rid of bitmap_remap() and
bitmap_biremap() uses" is wrong because the functions are still here, and are
still used.

Even worse, instead of getting rid of some useless code, you're
bloating the kernel with something that duplicates existing
functionality.

This is an example of a series that 'gets rid of' something for true:

https://yhbt.net/lore/all/20230925023817.782509-7-yury.norov@gmail.com/T/

(And unfortunately it's still unreviewed.)

But I understand your motivation, and as I already said, I like this
series in general. So let's please figure out a better wording before
moving forward?

Below are some my of thought.

1. Stop saying that you're getting rid of something when you're not.
   I'd suggest something like: "add simple and verbose alternatives to
   bitmap_remap(), and use them where appropriate".

2. Don't blame people considering a parameter named 'mask' as a mask.
   I mean this sentence: 

   > You should get the mask meaning. It's not the bit provider, it's a bit
   > positions provider.

   If it's a 'bit position provider', please give it a proper name,
   for example 'pos'. I'd suggest something like:
        unsigned long bitmap_scatter(unsigned long *dst, unsigned long *pos,
                                                          unsigned long *val)

3. If you're saying that new API is a simplified replacement for
   something, I'd like to see the full contract, i.e. explicit list of all
   simplifications and limitations implied:
   - val == dst is not handled;
   - when 'pos' is empty, val is not copied to dst;
   - new API doesn't wrap around 0, like bitmap_remap() does;
   - set bits in 'val' are not copied to 'dst' when not in 'pos' (?)'
   - anything else else?

4. Similarly to previous item, I'd like to have explicit understanding
   and examples where and how bitmap_remap may be replaced. You're
   only saying that it is possible when either 'new' or 'old' are
   dense. Is that the only case? Can you add a test that explicitly
   checks that bitmap_remap and bitmap_scatter/gather produce the same
   output. Something like this:
        bitmap_remap(dst1, val, dense_map, pos, nbits);
        bitmap_scatter(dst2, val, pos, nbits);
        check_eq_bitmap(dst1, dst2, nbits);

5. Can you add a picture like this to explain the algorithm even more:

        mask:    ...v..vv..v...vv
        bits:    0000001100000010
        1.          ^  ^^  ^    0
        2.          |  ||  |   10
        3.          |  ||  +> 010
        4.          |  |+--> 1010
        5.          |  +--> 11010
        6.          +----> 011010
        gather:  ..........011010

5. Regarding my confusion, I had to draw the picture above to realise
   how it's possible that scatter/gather are inverse and data-loss
   (i.e. not inverse) at the same time. Can you explain it with a
   wording like this: "For bits selected by 'pos' bitmap, gathering a
   'val' bitmap with the following scattering restores the original map.
   All other bits values are lost and replaced with zeros." Similarly
   for gathering. And please add a test case.

6. Regarding performance. I think it's wrong to say that that your
   code is better optimized then some other, and then ask your
   reviewers to figure out how to measure the difference. If you make
   such statement, you should already have some test or real-life
   measurement.

   However, if you ask me, I can suggest you to pull this patch:
   https://lore.kernel.org/lkml/20230828184353.5145-4-yury.norov@gmail.com/

   and modify/extend it in a way that both bitmap_remap and
   bitmap_scatter/gather take the same 'val' and 'pos' bitmaps,
   produce the same output, and then see which code is faster.

   Worth to mention that since all current users of your API are working
   on 64-bit maps, performance is doubty an issue. So you can drop the
   'optimization' part of your wording, and don't add performance test.

Thanks,
Yury
