Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3317ADAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjIYOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjIYOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:54:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D42103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:54:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f1dff5298so71105207b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695653681; x=1696258481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMM01kiwaxKUMxnR/M9Y0QmF3h8m7wvhYsKJnRgfe9k=;
        b=0Kflo8EM0+vlk0cZ8GiG5IcRwX63lFYE5sCDHYGB14Zg7LhpJ4UTClPjYE1B38jmvm
         jCOHVMY+g4c7sGeXyZWzj/y4DeBh2KIHm1hkCj1gytrvYMS55KFoU91M//jzZq2OkoZ6
         tSrZb18tDvVxWpgWw6ruT/pHno0O2pOjPLpPrBbSzox0wQVYNX9lnsnPWQVhRXqWBucR
         tXd4Pi0mkJ17ZO/44CCFJLsAGdt2cKJ8fV5Ix8GuS9irrXxNdQRia4gV4Q9Y8AHG8uBL
         qU2i3Kcu+F8LukRgp1hK5Z4m9MgWlp9p6F2xY4Y1ukA7I+ed7ly+2Lx1x1m6VBe5K6yB
         HeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653681; x=1696258481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMM01kiwaxKUMxnR/M9Y0QmF3h8m7wvhYsKJnRgfe9k=;
        b=W94chC2OtoLBrz6+nkpVuvG5UfZOH/hJxlo4lIYBG4snRcsDrJQYnO2uqWsmB1WSxu
         fB+DRUmZGV0VZus5oX6P/hICN0OBJWioNtyvvdyixD10oA4PgodJVqhxjft+OVbb2QBQ
         2wrxpDq58JmoPc28SdvlzZQGeblGVAP4v587krO4pAgXhch3+VoDySfypVrBsEE3Ze7p
         QOxosnUtAP43WS2oFAU5F4H71orfWh1f+NtaO77S9R9/YDHt434BhxG598njKQOy+9hY
         wq03HZLxKwUKVvXqLJghStaDgn+qQh6EeA5TGnxuLB3I5/ToXJH8iU9oDy2lUOAwtxTd
         x3YQ==
X-Gm-Message-State: AOJu0Yx7B94Qp7+c3jyZA1X7Bk4EvaLPfYHEkmQOaA0pPR5xTJNhKOuF
        WRw28SDHm4eylcpZd2BNf1TZZ60E4eDyVloqJesXKA==
X-Google-Smtp-Source: AGHT+IH/bYyxsgwE112qsYhFUH4/Wo4XcCy4LoENOhk+kW6Putb0p3CB1goOJJV3pBItTqSwzcIVmEP2Vyaky6nqUGQ=
X-Received: by 2002:a0d:f685:0:b0:59b:eb5b:fbbb with SMTP id
 g127-20020a0df685000000b0059beb5bfbbbmr6793186ywf.12.1695653680896; Mon, 25
 Sep 2023 07:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
In-Reply-To: <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 25 Sep 2023 16:54:00 +0200
Message-ID: <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 25, 2023 at 3:09=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Mon, Sep 25, 2023 at 2:23=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 02:16:37PM +0200, Alexander Potapenko wrote:
> >
> > ...
> >
> > > > +/*
> > > > + * Test bitmap should be big enough to include the cases when star=
t is not in
> > > > + * the first word, and start+nbits lands in the following word.
> > > > + */
> > > > +#define TEST_BIT_LEN (1000)
> > >
> > > Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=3Dy
> > > kernel reports mismatches here, presumably because the last quad word
> > > ends up partially initialized.
> >
> > Hmm... But if designed and used correctly it shouldn't be the issue,
> > and 1000, I believe, is carefully chosen to be specifically not dividab=
le
> > by pow-of-2 value.
> >
>
> The problem manifests already right after initialization:
>
> static void __init test_bit_len_1000(void)
> {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
>         memset(bitmap, 0x00, TEST_BYTE_LEN);
>         memset(exp_bitmap, 0x00, TEST_BYTE_LEN);
>         expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
> }

The problem is that there's no direct analog of memset() that can be
used to initialize bitmaps on both BE and LE systems.
bitmap_zero() and bitmap_set() work by rounding up the bitmap size to
BITS_TO_LONGS(nbits), but there's no bitmap_memset() that would do the
same for an arbitrary byte pattern.
We could call memset(..., ..., BITS_TO_LONGS(TEST_BIT_LEN)), but that
would be similar to declaring a bigger bitmap and not testing the last
24 bits.

Overall, unless allocating and initializing bitmaps with size
divisible by sizeof(long), most of bitmap.c is undefined behavior, so
I don't think it makes much sense to specifically test this case here
(given that we do not extend bitmap_equal() in the patch set).
