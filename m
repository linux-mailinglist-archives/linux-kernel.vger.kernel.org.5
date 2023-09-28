Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8102C7B1F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjI1OUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjI1OUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:20:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76370F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:20:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77574c2cffdso143051285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695910836; x=1696515636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOEFHJN8GV3YDZ8D45YRrX0IKDksNN0ayNy/fn6AF3U=;
        b=4pSTNfycYV379eqYLPfTP+xP077NADXi8g5EW3ZMevAaGOPWT5I2kWC+uYye7/PJiT
         Y+NM/9r6RPHph1Ya1aUNLXhchFPDKvQadeaHASykHBTXUPSgTVC8ZOClthdH/cBtNrNr
         wtlj6njUBjwLE+lrxtLl4UZCmCWoEL1oo+pxkus0WomgV7IQu5e9w/EXvxMvaYMv9tJi
         MHzcuJkXnQxIQIe2KU10lNjFn/781chm9NByw3wLpBi6w08EIBe2o+yYCWCqJcJxw7n1
         olrD387gSSIB7LAalsSnFWsuAe4mb6voxiJkd1RkMNg1PcPB1nd/gjUQNl2Lf6KXYrZ+
         RRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695910836; x=1696515636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOEFHJN8GV3YDZ8D45YRrX0IKDksNN0ayNy/fn6AF3U=;
        b=guOfUwEpBs9TEt3gZV1iA9L57GGYRZwAaj/l/7Hgm4r47js1NeAvjmfO4pr78PSOPs
         rheHEEqqdWnIAsKDjSg1Ezf//H8BTRuLF6V9PrQ62cIuRCfz6P6/6XM8tTRJaO9Q8GUy
         qRDQ2jFWoxg050vxRxiHNT3cl6kvy9r74xRWOMAliMfvVPbBQjAQrcON7SBH7nIRjPrK
         629Nlqdy91FpgEd3P/XIKLR6aOgX7POJL1+8xhvQMaLYNDkT0OWlHGiNz0hV1poLMLhl
         yMzYTltwx39R4OwPxIcub02DZjiccn66upp6MM6GquG7ZyOkGeK8/kQZzl0rAXkrCDlI
         jR1w==
X-Gm-Message-State: AOJu0YyJm5INfAcO6Q6YvUHPqEbFz2vGmGAMQebf41LU5hOTPXXfeyOr
        2LBemSgSc7XDOCuMWfQ1yLnbk1orlvu14OXjEaEDcA==
X-Google-Smtp-Source: AGHT+IGmle6ZVdDgJ47XPZGqYpkRDtGpt42WyMM2qF7GnvSWgZ1Wf+2NVQ/HrmKgBJfOr5etF9fpGBg0QLoOk3OjPEQ=
X-Received: by 2002:a05:620a:4081:b0:774:3933:1f2c with SMTP id
 f1-20020a05620a408100b0077439331f2cmr1411409qko.22.1695910836443; Thu, 28 Sep
 2023 07:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com> <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com> <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com> <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com>
In-Reply-To: <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 28 Sep 2023 16:19:56 +0200
Message-ID: <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "syednwaris@gmail.com" <syednwaris@gmail.com>,
        "william.gray@linaro.org" <william.gray@linaro.org>
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

On Wed, Sep 27, 2023 at 9:51=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> ...
> > Overall, unless allocating and initializing bitmaps with size
> > divisible by sizeof(long), most of bitmap.c is undefined behavior, so
> > I don't think it makes much sense to specifically test this case here
> > (given that we do not extend bitmap_equal() in the patch set).
>
> Bitmaps are arrays of unsigned long.
> Using any of the APIs on anything else is a bug.
> So it is always wrong to try to initialise 'a number of bytes'.
> The size used in the definition need not be a multiple of 8 (on 64bit)
> but the allocated data is always a multiple of 8.
>
> Any calls to the functions that have a cast of the bitmap
> parameter are likely to be buggy.
> And yes, there are loads of them, and many are buggy.

I got rid of the casts in the bitmap test, but they remain in
mtecomp.c, where 16-, 32-, 64-byte buffers allocated by
kmem_cache_alloc() are treated as bitmaps:
https://lore.kernel.org/linux-arm-kernel/20230922080848.1261487-6-glider@go=
ogle.com/T/#mdb0d636d2d357f8ffe6ac79cef1145df3440f659

Having them allocated by bitmap_alloc() won't work, because on Android
bitmap_alloc() will allocate the buffers from the kmalloc-64 cache,
defeating the purpose of the compression.

Would it be better to extend the bitmap.h API so that it is possible
to allocate from a kmem cache (which would in turn require
bitmap_kmem_cache_create() to ensure the alignment requirements)?

> On LE you mostly get away with shorter memory allocations.
> But still get errors when trying to do locked operations
> on misaligned addresses.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
