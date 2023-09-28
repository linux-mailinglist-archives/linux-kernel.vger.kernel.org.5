Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0B7B20AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjI1PPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjI1PPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:15:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D5195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:15:36 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65afae9e51fso56757166d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695914136; x=1696518936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQIXs+qq48cDvCc1t0NQ5MJGV2EjrkwfbJepFnNhtqs=;
        b=Vg1l1V2Pwso3KfnK72QbKfGw+w7xCGXC8mffztVQe16pQsewCcuGhmoKS0wB++6SFb
         kHhbmSaV3idtOBVklbx6X72kJWqV67Aw2q+o+dGlIYpJSzYhZv77ocfp1Pso+p4kxILn
         tEF/voBrnIX4tT2FMPtfOSWVteX09YNAVMe2f7nuddBF4DoV76VWuqLoQgw7tP211Rwr
         e+OGMVnkoUFJbLRC9IbCl7+rjRMKNPBQ+gDY+/Ufkb7SRHfTm0qWJJ2tZF6pizbSCJTB
         47hmi6fskwT9zjivwa3BgLdpN6NyxPblgbD9ePX0EEReCYH6x0Y7MqLkvUTvZpAzLdo3
         9+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914136; x=1696518936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQIXs+qq48cDvCc1t0NQ5MJGV2EjrkwfbJepFnNhtqs=;
        b=vgnIEzIV2YuEVViPQfnFBNwwk4tVHgeSSBxgpUBWONXCXvMN1Ozz3IHfnP0U2R1EnM
         gDRViwS1eNS08IJus/Gxr5eIktZAqPu/Hy4cdgvKitTC9wuj6laoq2JF22K4RdvgoRGW
         8De4riA1goWMRKkERbScU9MJMWWyWQ7NRS7jWy+l9QD4r3yfotFqufY+Nkgu05Y9DK8E
         6hZezb2OiskJyLvxmjH7/o5+aUmPnN5C/Xk0YdK2B1CgJ9DbrR6aa+JhreHfQp61OxIm
         a+pITJ+U3KqOcgCSrst4ncnJ6cTxUKIMWwguzpmm7CPBbs3LaXkYpGrPO1cQCMuOVFYY
         A7qA==
X-Gm-Message-State: AOJu0YybNlRVw8T13EP0GXchpyCFdmA5xlDWl/QcilGBXD7nE0SIROOV
        uJiwnpIE01kGiy6HBy2Tup1kEF5i4gYUz+yuIlcbyA==
X-Google-Smtp-Source: AGHT+IHnuIbgk51dz9A0cvjjUL3dAUoeN59yoVGxHqdk0D8LF9IE8x0Lfs+iBii3nAaP1Y2zGvWi4KRqtpiubqe0DxE=
X-Received: by 2002:ad4:58ac:0:b0:65b:8ef:e4ea with SMTP id
 ea12-20020ad458ac000000b0065b08efe4eamr1271556qvb.56.1695914135738; Thu, 28
 Sep 2023 08:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
 <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com> <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
 <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
In-Reply-To: <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 28 Sep 2023 17:14:55 +0200
Message-ID: <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com>
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

On Thu, Sep 28, 2023 at 4:43=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
>
>
> On Thu, Sep 28, 2023, 10:20 AM Alexander Potapenko <glider@google.com> wr=
ote:
>>
>> On Wed, Sep 27, 2023 at 9:51=E2=80=AFAM David Laight <David.Laight@acula=
b.com> wrote:
>> >
>> > ...
>> > > Overall, unless allocating and initializing bitmaps with size
>> > > divisible by sizeof(long), most of bitmap.c is undefined behavior, s=
o
>> > > I don't think it makes much sense to specifically test this case her=
e
>> > > (given that we do not extend bitmap_equal() in the patch set).
>> >
>> > Bitmaps are arrays of unsigned long.
>> > Using any of the APIs on anything else is a bug.
>> > So it is always wrong to try to initialise 'a number of bytes'.
>> > The size used in the definition need not be a multiple of 8 (on 64bit)
>> > but the allocated data is always a multiple of 8.
>> >
>> > Any calls to the functions that have a cast of the bitmap
>> > parameter are likely to be buggy.
>> > And yes, there are loads of them, and many are buggy.
>>
>> I got rid of the casts in the bitmap test, but they remain in
>> mtecomp.c, where 16-, 32-, 64-byte buffers allocated by
>> kmem_cache_alloc() are treated as bitmaps:
>> https://lore.kernel.org/linux-arm-kernel/20230922080848.1261487-6-glider=
@google.com/T/#mdb0d636d2d357f8ffe6ac79cef1145df3440f659
>>
>> Having them allocated by bitmap_alloc() won't work, because on Android
>> bitmap_alloc() will allocate the buffers from the kmalloc-64 cache,
>> defeating the purpose of the compression.
>>
>> Would it be better to extend the bitmap.h API so that it is possible
>> to allocate from a kmem cache (which would in turn require
>> bitmap_kmem_cache_create() to ensure the alignment requirements)?
>
>
> So all that is wrong then. Bad on me, I'd spend more time looking into yo=
ur driver code...
>
> We already have bitmap_(from,to)_u(64,32),
> And you can use them. For 16-bit you have to add helpers yourself. But it=
's not a rocket science.
>

So e.g. for compressing something into a 16-byte buffer using bitmaps
I'd need to:

1) Allocate the buffer: buf =3D kmem_cache_alloc(...)
2) Allocate the bitmap: bitmap =3D bitmap_alloc(16*8, ...)
3) Fill the bitmap: mte_compress_to_buf(..., bitmap, 16)
4) Copy the bitmap contents to the buffer: bitmap_to_arr64(buf, bitmap, 16*=
8)
5) Deallocate the bitmap: bitmap_free(bitmap)

instead of:

buf =3D kmem_cache_alloc(...)
mte_compress_to_buf(..., (unsigned long *)buf, 16)

, correct?

Given that the buffer contents are opaque and its size is aligned on 8
bytes, could it be possible to somehow adopt the `buf` pointer
instead?

> I'm AFK at the moment. I'll take a close look at your machinery at the we=
ekend.

Thanks and take your time!
