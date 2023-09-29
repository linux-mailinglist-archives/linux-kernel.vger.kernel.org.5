Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68CA7B2E85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjI2Izq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2Izm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:55:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C79180
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:55:40 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65d5a6230fcso7186146d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695977740; x=1696582540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VeBEBUpncpaXfVVMzC6PEpAWTbScZL5Kaim95vVlaE=;
        b=0vboW9H/LdW33pjFlXgLevJIkfQrV7dDjVGiP3w/VABWdqj9oQcr3NWXVolAL2GtOD
         FBu3D2r0V5CgQY0cSybvjTTfY0kHPmHRx7PXMX19ANHODZWcLZrjl88TggDVN9sDbvCs
         p1KNtwLhkmsHqee9cAC1KVs7tAyixbF/3HwRqdeceQMLOicKy85Ri8vgP2xTx/HoLjhq
         lb/09L6pR3dNqn9wheWPQefquWRelBXlFS+hwHsHa94NID1K6ofDUGyiklpIze9hgD9C
         Wz0+kawzzEm+EldJmNtTzwF2iOdQAOhIE//X7HcYfpYGLO3i+aDrynfL1HSXHYetoO3+
         ac5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695977740; x=1696582540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VeBEBUpncpaXfVVMzC6PEpAWTbScZL5Kaim95vVlaE=;
        b=vOqboGXkaFOfebYITf+TAWelnxt6YCNrtiBTQmd5qBPPbMl6qG7MteKMCZGhR+rKvn
         mJQ0/ivD54ASM6BULFnGxcjDDM1FEXsdJBZUPylMjQ5qaMDrRn5Wj+bXM8J9j/Hk5Fe/
         8ZzI7pgRqImVIAPPIKmKQlDkxavSavNNUuCjb/fNO3OxzKWaVl3Fel2NBSWjadB5T5rB
         sAoXKbLQ3NnYvV9Hj9znoglUor8wblG0BQ9FK2aNs8k5Uv5EffRInq4uAP/T+T0FG/6d
         5ROuI/8ltNM3jiL+MUkwb2tU0Do3N4uWawzSFn03918JD/yXJ5+SshL8r8uCzVs6v0B2
         ZydA==
X-Gm-Message-State: AOJu0Yzt3DQP8JEgOWrJMZpUDHsx+b8u+zO580hK79UkaXMewwQ0oJd8
        rrKm1fDHnYKC5y08/lSyJKv6RAiiH5olmvM8zXK+HQ==
X-Google-Smtp-Source: AGHT+IF74Bxju3fjrGbISzGXZFMYFknK4+t3Su3et1gEk0NEDQ2t5Igsp6X00eFeHkT7tGrV7wFkjtk+8rv18qA18fM=
X-Received: by 2002:a0c:cb10:0:b0:65a:fa53:ed11 with SMTP id
 o16-20020a0ccb10000000b0065afa53ed11mr3442130qvk.65.1695977739910; Fri, 29
 Sep 2023 01:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
 <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com> <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
 <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
 <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com> <ZRXbOoKHHafCWQCW@yury-ThinkPad>
In-Reply-To: <ZRXbOoKHHafCWQCW@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 29 Sep 2023 10:54:59 +0200
Message-ID: <CAG_fn=VYRdk0KV5tZaakjLLczdWTvGp2gfLjXqpYR2ifh4S4vA@mail.gmail.com>
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

On Thu, Sep 28, 2023 at 10:02=E2=80=AFPM Yury Norov <yury.norov@gmail.com> =
wrote:
>
> On Thu, Sep 28, 2023 at 05:14:55PM +0200, Alexander Potapenko wrote:
> >
> > So e.g. for compressing something into a 16-byte buffer using bitmaps
> > I'd need to:
> >
> > 1) Allocate the buffer: buf =3D kmem_cache_alloc(...)
> > 2) Allocate the bitmap: bitmap =3D bitmap_alloc(16*8, ...)
> > 3) Fill the bitmap: mte_compress_to_buf(..., bitmap, 16)
> > 4) Copy the bitmap contents to the buffer: bitmap_to_arr64(buf, bitmap,=
 16*8)
> > 5) Deallocate the bitmap: bitmap_free(bitmap)
> >
> > instead of:
> >
> > buf =3D kmem_cache_alloc(...)
> > mte_compress_to_buf(..., (unsigned long *)buf, 16)
> >
> > , correct?
> >
> > Given that the buffer contents are opaque and its size is aligned on 8
> > bytes, could it be possible to somehow adopt the `buf` pointer
> > instead?
>
> I didn't find an explicit typecasting where you're using
> mte_compress_to_buf(), but now after hard 2nd look I see...
>
> Firstly, now that in the documentation you are explicitly describing the
> return value of mte_compress() as 64-bit frame, the right way to go would
> be declaring the function as: u64 mte_compress(u8 *tags).

Ack.

> And the general pattern should be like this:
>
>   unsigned long mte_compress(u8 *tags)
>   {
>           DECLARE_BITMAP(tmp, MTECOMP_CACHES_MAXBITS);
>           void *storage;
>           ...
>           if (alloc_size < MTE_PAGE_TAG_STORAGE) {
>                   storage =3D kmem_cache_alloc(cache, GFP_KERNEL);
>                   mte_compress_to_buf(r_len, r_tags, r_sizes, tmp, alloc_=
size);
>
>                   switch (alloc_size) {
>                   case 16:
>                           bitmap_to_arr16(storage, tmp, 16);

I might be missing something, but why do we need the switch at all?
The buffers we are allocating always contain a whole number of u64's -
cannot we just always call bitmap_to_arr64()?

Note that for cases where alloc_size is > 8 we never make any
assumptions about the contents of @storage, and don't care much about
the byte order as long as swap decompression is done with the same
endianness (which is always the case).
(The case where alloc_size=3D=3D8 is somewhat special, and needs more
accurate handling, because we do make assumptions about the bit layout
there).

>                           break;
>                   case 32:
>                           bitmap_to_arr32(storage, tmp, 32);
>                           break;
>                   case 64:
>                           bitmap_to_arr64(storage, tmp, 64);
>                           break;
>                   default:
>                           pr_err("error\n");
>                   }
>                   result =3D ((u64)storage | cache_id) & MTE_HANDLE_MASK;
>                   goto ret;
>           }
>           ...
>   }
>
> Yeah, it looks cumbersome, but this is the right way to go if you need a
> reliable BE-compatible driver.

What is the BE compatibility problem that you are anticipating here?

The issue that came up during testing was that on systems with
different endianness we cannot treat unaligned buffers as bitmaps,
because bitmap_write() might be touching memory past the allocation
size.
I agree therefore with the general approach of encapsulating all
bitmap operations in bitmap.h and hiding the implementation details
behind the API.
But in this particular case it seems to complicate the otherwise
trivial application of bitmap_read()/bitmap_write() to an external
buffer with guaranteed 64-bit alignment: we'll end up allocating this
temporary bitmap and doing a hard-to-optimize memcpy() between it and
the final storage.

A straightforward solution for this would be to fork u64* versions of
bitmap_read()/bitmap_write() implementations in mtecomp.c and apply
them to u64* buffers allocated in that file.
This would remove the need for the temporary bitmap (because there's
no encapsulation that mandates using bitmap.h now) and the extra
memcpy().
But I don't like this either, because forking code that exists in
headers is just wrong.

> I think it will be less scary if you wrap
> the switch with a helper, and/or move it inside mte_compress_to_buf(),
> so that the mte_compress will stay unchanged.
>
> Anyways, hope the above helped.
>
> Thanks,
> Yury


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
