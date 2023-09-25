Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA17ADDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjIYRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIYRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:17:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BE112
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:16:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b179b9baeso8521396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695662215; x=1696267015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6WHvOjAcf/c5Ip/HyecTcRYeWcZLGwYjO1msnpDojU=;
        b=Vv4SorPALn8zsbFYRJxwgK2mQjB+wA4DE/V5fOFS8h80+/1qG7dV0q6WaEebvqIvh5
         5UXiQsUhCMalOAnYwzVC3z5VZazUenxPdHIRdtxwCZgb9shaQx2SvnkTAZgnTrCfbUOz
         Uoy7JWgWyBW0ouJjelEhmyh1eSlON3itU05qmKV2cMKKQbqT/yU0sU9O4M9U7wj/KEz1
         L1W7CvQHuebZlABA+zqWVlc3Q749xHAovCs10yc+LLRljOtoU+6ivKpM441/nGIXXcZr
         EpM1H4By3XUoJaVZu3RfBipvoDrXoAtuMHJ1Khq/4xUy81DZmNlxuYjZvAGiwQDW9HY8
         G2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662215; x=1696267015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6WHvOjAcf/c5Ip/HyecTcRYeWcZLGwYjO1msnpDojU=;
        b=p0Qlgy8Bct76Cpo2o2rXM5ij80OZjXkMg8zvuSjfl4qsIE+vzljPqrF183ZIEHvAG4
         mPj9+xCZq11kcNvLQyS2rwfwQdmatPoMXd6GzfRL002ib4Fb6iiNrGsoq4pcM/j3kgp3
         fL48JWc+yPfORPZaPfQky5oWhCMtwONvw6VaGSG/uYqoUbwG5emQRMU4ic+KlgoGv6o+
         M0EkghWrvZZdXtJWlTok0VyAm+s0GLH0E4HWqxEOXCr32/bGIaAU8q/4h/Kgakh9RPFW
         B9bR3mipPISjR6ZHzqXPcqvtLCf5edkFco7tPwcPJ1pq94oImtWFqXjTrwXoZSN+lUBC
         xoFA==
X-Gm-Message-State: AOJu0YzhknNkHFX392Mgksj/AQ8ELEp693hkQQskp1YCwy9IyTVWCGvx
        P81Nji9QfKf+OR/hhPkjQTDmkR7bCTKJj2vVo1j3oQ==
X-Google-Smtp-Source: AGHT+IH+E8Ad3xepkqDRLXcyRIKTp1dGA8Q2dwGs5M7S4yb9rHbDheCfqlJ8OezEpTNoTIP1JVH76XJVejqmAz4zZWo=
X-Received: by 2002:a0c:b44a:0:b0:656:4ff8:691e with SMTP id
 e10-20020a0cb44a000000b006564ff8691emr6868611qvf.46.1695662215027; Mon, 25
 Sep 2023 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com> <ZRGv/5QNbYGIDkgw@yury-ThinkPad>
In-Reply-To: <ZRGv/5QNbYGIDkgw@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 25 Sep 2023 19:16:14 +0200
Message-ID: <CAG_fn=VuTtbm9x8Q2dfyYQJEiFZAQfNJ+ZaBtW_B_RwEzs3Kcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 6:06=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Sep 25, 2023 at 04:54:00PM +0200, Alexander Potapenko wrote:
> > On Mon, Sep 25, 2023 at 3:09=E2=80=AFPM Alexander Potapenko <glider@goo=
gle.com> wrote:
> > >
> > > On Mon, Sep 25, 2023 at 2:23=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Mon, Sep 25, 2023 at 02:16:37PM +0200, Alexander Potapenko wrote=
:
> > > >
> > > > ...
> > > >
> > > > > > +/*
> > > > > > + * Test bitmap should be big enough to include the cases when =
start is not in
> > > > > > + * the first word, and start+nbits lands in the following word=
.
> > > > > > + */
> > > > > > +#define TEST_BIT_LEN (1000)
> > > > >
> > > > > Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=
=3Dy
> > > > > kernel reports mismatches here, presumably because the last quad =
word
> > > > > ends up partially initialized.
> > > >
> > > > Hmm... But if designed and used correctly it shouldn't be the issue=
,
> > > > and 1000, I believe, is carefully chosen to be specifically not div=
idable
> > > > by pow-of-2 value.
> > > >
> > >
> > > The problem manifests already right after initialization:
> > >
> > > static void __init test_bit_len_1000(void)
> > > {
> > >         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> > >         DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> > >         memset(bitmap, 0x00, TEST_BYTE_LEN);
> > >         memset(exp_bitmap, 0x00, TEST_BYTE_LEN);
> > >         expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
> > > }
> >
> > The problem is that there's no direct analog of memset() that can be
> > used to initialize bitmaps on both BE and LE systems.
>
> memset fills an array of chars with the same value. In bitmap world we op=
erate
> on array of bits, and there are only 2 possible values: '0' and '1'. For =
those
> we've got bitmap_zero() and bitmap_fill().
>
> > bitmap_zero() and bitmap_set() work by rounding up the bitmap size to
> > BITS_TO_LONGS(nbits), but there's no bitmap_memset() that would do the
> > same for an arbitrary byte pattern.
> > We could call memset(..., ..., BITS_TO_LONGS(TEST_BIT_LEN)), but that
> > would be similar to declaring a bigger bitmap and not testing the last
> > 24 bits.
>
> No, you couldn't. On the test level, bitmap should be considered as a
> black box. memset()'ing it may (and did) damage internal structure.

You are right about this. bitmap_zero() and bitmap_fill() are calling
memset() under the hood, but I shouldn't have assumed doing raw memset
is safe.
Unfortunately lib/test_bitmap.c does a bunch of memsets already, which
probably led to the confusion.


> If you have some pattern in mind, you can use bitmap_parselist(). For exa=
mple,
> you can set every 2nd bit in your bitmap like this:
>
>         bitmap_parselist("all:1/2", bitmap, 1000);
>
> Check for almost 100 examples of bitmap_parselist usage in the test for
> bitmap_parselist in the same file.

Thanks! This solves my problem.
I am planning to use an intermediate bitmap to avoid parsing the
pattern multiple times.

>
> > Overall, unless allocating and initializing bitmaps with size
> > divisible by sizeof(long), most of bitmap.c is undefined behavior, so
> > I don't think it makes much sense to specifically test this case here
> > (given that we do not extend bitmap_equal() in the patch set).
>
> This is wrong statement. People spent huge amount of time making bitmap
> API working well for all combinations of lengths and endiannesses,
> including Andy and me.

Please accept my apologies for that, I didn't mean to insult you,
Andy, or anyone else.
My understanding of the comment at the top of lib/bitmap.c was that
the bitmap API is expected to work in the presence of uninitialized
values, which is actually not what the comment says.
bitmap_zero() and such do ensure that none of the tail bytes remain
uninitialized, so we are safe as long as those functions are used.


>
> NAK for this and for ignoring my other comment to v4.

If you are talking about this comment:
https://lore.kernel.org/lkml/ZQ2WboApqYyEkjjG@yury-ThinkPad/, I was
going to incorporate it in v6 (as it was sent after I published v5).
I am fine with not mandating the return value for reading/writing zero byte=
s.
