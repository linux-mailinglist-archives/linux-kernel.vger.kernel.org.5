Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4D7B4C91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjJBHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjJBHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:35:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4A83
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:35:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-664bd97692dso14215276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696232106; x=1696836906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxS5zIJtibRbCh5vK1xQq6wWfoxr2oLcV1k3s8vlyNA=;
        b=un5UBiwXqyrE+EJRcT5lQS5qgBxT53qfxrLv2WyzL5c3sMufs8w75QXWuTKgSogE8i
         +LLs4+dooT0BWxrRDo+ATadANUrzIKhbrTLzhwswHCpLRzbCjojos1CYDdDQNXkZG6P3
         Oij9NDRdMGR9wfZ85SLkFWSf8V9kUFKVFH7h59BbhRLtwUemQ+FMX/Bx9NLEJg/RFNqh
         ehE/FZ7DCSC1PZHk63m2x/68cMJzo/85wGQ2ad2Z2dP1dtKb5gSp0pC349OkMUzrFvlC
         /76AOt16e1oIV438YDiyhOw03/Esro54pZgWALcPra5BlCnfLHUUgnsvwR2GTRQxloVK
         sBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232106; x=1696836906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxS5zIJtibRbCh5vK1xQq6wWfoxr2oLcV1k3s8vlyNA=;
        b=gZ/gonpV1w809bB6cOKm+2EyhkkSSj7v+BGT9JAuXF+FUgGCV/u8q6wvEOtDy2OIkq
         xEUVvmf6eLJwV7Xo5CJY/NXWs7kHKmw/lROvpNAFSw2nz955tv9TYE8Ea8IKopmen4yl
         TzPcM2pZm1Cg1eq5TeW//YXW4iUMc9K686C4iaumRj75lmk0a0e7jjYczJFZbjvTAmsz
         tiLihMPe3+xQT9MydlAndJoJFiJ1kT6nDSzScjyT/qyMyR+VzFZgroP343cnTxqCbrJe
         xhWJoVgOp1ztmrHet2GMcL6D/p3z8Q6qc2J3NrY+99jhhaey2NNmtQJCJI7n2oalsAIO
         33NQ==
X-Gm-Message-State: AOJu0YzG3kcikRmvdAVvCQuFGzBk2nwBwD/awjZX6QClCWAj4GhjFPRb
        qOehiMmOe4TEqqfy+pZZPPKoCa+bF5IvEXlV6A6rdw==
X-Google-Smtp-Source: AGHT+IFj57Th9WhoHQH1MQFok8YfX19y4QhFpLQDK4grB8F/KQXLEa9Iz03MCQLlcgLc1Cvf3IiDVW+iiR2d/20F+dU=
X-Received: by 2002:a0c:db93:0:b0:64f:8d4c:1c0b with SMTP id
 m19-20020a0cdb93000000b0064f8d4c1c0bmr11335901qvk.43.1696232105529; Mon, 02
 Oct 2023 00:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
 <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com> <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
 <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
 <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com>
 <ZRXbOoKHHafCWQCW@yury-ThinkPad> <CAG_fn=VYRdk0KV5tZaakjLLczdWTvGp2gfLjXqpYR2ifh4S4vA@mail.gmail.com>
 <ZRoukg5eWDHICiei@yury-ThinkPad>
In-Reply-To: <ZRoukg5eWDHICiei@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 Oct 2023 09:34:24 +0200
Message-ID: <CAG_fn=V3CKzEkuFujHzsMR4vxd26C0ZvxooUPYiH49bzY=jf5g@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, pcc@google.com,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        eugenis@google.com, Syed Nayyar Waris <syednwaris@gmail.com>,
        william.gray@linaro.org
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

On Mon, Oct 2, 2023 at 4:44=E2=80=AFAM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> On Fri, Sep 29, 2023 at 10:54:59AM +0200, Alexander Potapenko wrote:
> > On Thu, Sep 28, 2023 at 10:02=E2=80=AFPM Yury Norov <yury.norov@gmail.c=
om> wrote:
> > >
> > > On Thu, Sep 28, 2023 at 05:14:55PM +0200, Alexander Potapenko wrote:
> > > >
> > > > So e.g. for compressing something into a 16-byte buffer using bitma=
ps
> > > > I'd need to:
> > > >
> > > > 1) Allocate the buffer: buf =3D kmem_cache_alloc(...)
> > > > 2) Allocate the bitmap: bitmap =3D bitmap_alloc(16*8, ...)
> > > > 3) Fill the bitmap: mte_compress_to_buf(..., bitmap, 16)
> > > > 4) Copy the bitmap contents to the buffer: bitmap_to_arr64(buf, bit=
map, 16*8)
> > > > 5) Deallocate the bitmap: bitmap_free(bitmap)
> > > >
> > > > instead of:
> > > >
> > > > buf =3D kmem_cache_alloc(...)
> > > > mte_compress_to_buf(..., (unsigned long *)buf, 16)
> > > >
> > > > , correct?
> > > >
> > > > Given that the buffer contents are opaque and its size is aligned o=
n 8
> > > > bytes, could it be possible to somehow adopt the `buf` pointer
> > > > instead?
> > >
> > > I didn't find an explicit typecasting where you're using
> > > mte_compress_to_buf(), but now after hard 2nd look I see...
> > >
> > > Firstly, now that in the documentation you are explicitly describing =
the
> > > return value of mte_compress() as 64-bit frame, the right way to go w=
ould
> > > be declaring the function as: u64 mte_compress(u8 *tags).
> >
> > Ack.
> >
> > > And the general pattern should be like this:
> > >
> > >   unsigned long mte_compress(u8 *tags)
> > >   {
> > >           DECLARE_BITMAP(tmp, MTECOMP_CACHES_MAXBITS);
> > >           void *storage;
> > >           ...
> > >           if (alloc_size < MTE_PAGE_TAG_STORAGE) {
> > >                   storage =3D kmem_cache_alloc(cache, GFP_KERNEL);
> > >                   mte_compress_to_buf(r_len, r_tags, r_sizes, tmp, al=
loc_size);
> > >
> > >                   switch (alloc_size) {
> > >                   case 16:
> > >                           bitmap_to_arr16(storage, tmp, 16);
> >
> > I might be missing something, but why do we need the switch at all?
> > The buffers we are allocating always contain a whole number of u64's -
> > cannot we just always call bitmap_to_arr64()?
> >
> > Note that for cases where alloc_size is > 8 we never make any
> > assumptions about the contents of @storage, and don't care much about
> > the byte order as long as swap decompression is done with the same
> > endianness (which is always the case).
> > (The case where alloc_size=3D=3D8 is somewhat special, and needs more
> > accurate handling, because we do make assumptions about the bit layout
> > there).
>
> So, this is my fault, and I'm really sorry. I read that 16-byte as
> 16-bit, and mistaken everything else. Please scratch the above.
>
> If you allocate word-aligned memory, and it's a multiple of words,
> which is your case, and access it only using bitmap API like
> bitmap_read/write, everything should be fine.

Ok, fine, I'll stick to the current implementation then.
