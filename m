Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B67B4AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjJBCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJBCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:44:55 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B0BB8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 19:44:52 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49b289adca9so1338061e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214692; x=1696819492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLjWMNFAWqDPTKvhc5gdR9AFU5XRTZ7GYfHifI1+etw=;
        b=EfoFq1fndvrK7tNrKc4xPFBUgYAwMhTbot52A1SMElqCKIoTiFflH3qInGsPFdAPZP
         +ucd0xEJpSmwGa9D8nvxriucHnKIVNP9SgPH1fviOe2AQIayF5kJ+e6Tlw626/NIMn2e
         +9NM5AHTbCdpP+VTUL4VAhMMLCesqjSeW5BJIIsMLbhpBIYL7bijKr4HTInlNy2E+P6e
         qGAtYqfZOYvhJUKGqVxFuCdRr0EXLdKiXPlucCmxKebGl6kqR3VDd3Ts0ADtWaw+1ml1
         HdTLYkwDE1EjslktmbPWQNbffg+32sFl4njH8qIh0XGaYvRNrK6/OcZ4mi2jDs0OTe4I
         cJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214692; x=1696819492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLjWMNFAWqDPTKvhc5gdR9AFU5XRTZ7GYfHifI1+etw=;
        b=dpbwsEhG0kXBoBkn8jcR28GruXK0gz+hKpO3YXrPComzQ8NPt04CVd46syE7ejdqyG
         8TMEFmPkJn/zkqTb9qKvbpgNVBPD2EdON70+b7zmuQaKMiKUCMn/jkaHJTmN0GMEGmRl
         L5jBKfaMwnjACx7eq+CNfHiLrCn+RctJ7eKcf7MdbhWyett95EjTUdbTpL103noTg7rC
         8CgLhr1fvmqK/MN4yNdhMsh6cVrCQSfAnW7zqG0XAJU3uJ/sRyRzkVRM+D+qnIqwPJ8O
         xQ+Y6JboP8m18XAe9u1f8oyOIg/q9+vIb8qPuosGbvxb8N+m0wlfi/oVi4Qpw0jpqR7Z
         CGCA==
X-Gm-Message-State: AOJu0YwAPCenUPhKr5FiHdVwZIdFQ21sekc35exZAGBOcy0ekiaLnpPn
        +TXaQk+cYX7Asuy0P3/tpp5ME3Xi3zhvJg==
X-Google-Smtp-Source: AGHT+IHs46UNbvNMHYbLXGGeqLUI/8LKjELMiaHIg7sNU2N62noc/ioVarkkT5b7GTo20/glLXPbCg==
X-Received: by 2002:a1f:ec43:0:b0:496:2e22:29e3 with SMTP id k64-20020a1fec43000000b004962e2229e3mr7910406vkh.1.1696214691579;
        Sun, 01 Oct 2023 19:44:51 -0700 (PDT)
Received: from localhost ([2607:fb90:beca:c7a7:dba8:3746:709f:6151])
        by smtp.gmail.com with ESMTPSA id bj48-20020a0561220e7000b0049ab3a5160bsm1293593vkb.23.2023.10.01.19.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:44:51 -0700 (PDT)
Date:   Sun, 1 Oct 2023 19:44:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
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
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZRoukg5eWDHICiei@yury-ThinkPad>
References: <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
 <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
 <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com>
 <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
 <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
 <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com>
 <ZRXbOoKHHafCWQCW@yury-ThinkPad>
 <CAG_fn=VYRdk0KV5tZaakjLLczdWTvGp2gfLjXqpYR2ifh4S4vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=VYRdk0KV5tZaakjLLczdWTvGp2gfLjXqpYR2ifh4S4vA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:54:59AM +0200, Alexander Potapenko wrote:
> On Thu, Sep 28, 2023 at 10:02 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Thu, Sep 28, 2023 at 05:14:55PM +0200, Alexander Potapenko wrote:
> > >
> > > So e.g. for compressing something into a 16-byte buffer using bitmaps
> > > I'd need to:
> > >
> > > 1) Allocate the buffer: buf = kmem_cache_alloc(...)
> > > 2) Allocate the bitmap: bitmap = bitmap_alloc(16*8, ...)
> > > 3) Fill the bitmap: mte_compress_to_buf(..., bitmap, 16)
> > > 4) Copy the bitmap contents to the buffer: bitmap_to_arr64(buf, bitmap, 16*8)
> > > 5) Deallocate the bitmap: bitmap_free(bitmap)
> > >
> > > instead of:
> > >
> > > buf = kmem_cache_alloc(...)
> > > mte_compress_to_buf(..., (unsigned long *)buf, 16)
> > >
> > > , correct?
> > >
> > > Given that the buffer contents are opaque and its size is aligned on 8
> > > bytes, could it be possible to somehow adopt the `buf` pointer
> > > instead?
> >
> > I didn't find an explicit typecasting where you're using
> > mte_compress_to_buf(), but now after hard 2nd look I see...
> >
> > Firstly, now that in the documentation you are explicitly describing the
> > return value of mte_compress() as 64-bit frame, the right way to go would
> > be declaring the function as: u64 mte_compress(u8 *tags).
> 
> Ack.
> 
> > And the general pattern should be like this:
> >
> >   unsigned long mte_compress(u8 *tags)
> >   {
> >           DECLARE_BITMAP(tmp, MTECOMP_CACHES_MAXBITS);
> >           void *storage;
> >           ...
> >           if (alloc_size < MTE_PAGE_TAG_STORAGE) {
> >                   storage = kmem_cache_alloc(cache, GFP_KERNEL);
> >                   mte_compress_to_buf(r_len, r_tags, r_sizes, tmp, alloc_size);
> >
> >                   switch (alloc_size) {
> >                   case 16:
> >                           bitmap_to_arr16(storage, tmp, 16);
> 
> I might be missing something, but why do we need the switch at all?
> The buffers we are allocating always contain a whole number of u64's -
> cannot we just always call bitmap_to_arr64()?
> 
> Note that for cases where alloc_size is > 8 we never make any
> assumptions about the contents of @storage, and don't care much about
> the byte order as long as swap decompression is done with the same
> endianness (which is always the case).
> (The case where alloc_size==8 is somewhat special, and needs more
> accurate handling, because we do make assumptions about the bit layout
> there).

So, this is my fault, and I'm really sorry. I read that 16-byte as
16-bit, and mistaken everything else. Please scratch the above.

If you allocate word-aligned memory, and it's a multiple of words,
which is your case, and access it only using bitmap API like
bitmap_read/write, everything should be fine.

Sorry again.
