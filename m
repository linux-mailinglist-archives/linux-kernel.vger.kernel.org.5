Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46897E5828
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjKHNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjKHNyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:54:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171F1BEC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:54:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9beb865a40so7155126276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 05:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699451650; x=1700056450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cYboRq+M35wTbNdJL0FSmCOtXkJVGVeyh5BMqgRujHI=;
        b=3OC/NhOIj4Z2kwmiCBER6fYoRAlexEMhRPjup4Dz0H3uApIzD5DyKeW+/moN/yAx0Y
         dhjvixP145CfXpdZ56xu8YvzeFn14sQMMdW7UNxfGrxzWVVYGtA6o68yYdzSgcfQ0E0c
         AMSAlEVc9NvETacEVWwl4S6gceSwVWFF9BpJb1F3h/0iX+Y38n7ctM9LWAb/E8eGLiLJ
         RW51s/DyezOf6zsjJeobfMtkHT6b2uylSJHpFTao15aNxTajk9lT15Oja6IzHsjrjSyM
         Jj3Yuq6GU8Wyh5XRf1GRrUrlCNPycaqUBBug/+J9YHcETQoGQ5NGfQWOro7K1bOmcEW1
         UtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699451650; x=1700056450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYboRq+M35wTbNdJL0FSmCOtXkJVGVeyh5BMqgRujHI=;
        b=ToA/1wpQqMVElNc8Vvus4A7iyUYkOb7bpVgSK3oKpWpZlmLUXsmYHp8oscAH5602IV
         7W6IEd2tWwjHltJpa6jZVOzYyuhqESLnqUFk6y9iZmlDLNf8tfOcQRlrUEfv6CErLgwt
         9A6ZJlcWNX+Ng+EfYYCRFbRztcq2nXx9/WH+9Ci14vUnBaKdMzXHWXL5VL/ZSG1PWZ5/
         GFQz/73OjeV7FkKVeJXJKw1HEGklRgjdhHL3KVNS5ABp+QGOWS9gDvD9IV5GVcPN0QSN
         fDgG4t+6YMUNtS0JH34ID2c0dxnxrmkP09YAgOgBChJkC4Jc11ihPy+z2NIuSxRW4zHY
         SQxQ==
X-Gm-Message-State: AOJu0YxI58SV5X9UAwR1r/Sca8YZb7b2rz76kIS0YsazC7ocPwk+OZay
        FzCqt2XIJ218LnmHsdmJwZUWk1jpvYX4RlD3rPPjSg==
X-Google-Smtp-Source: AGHT+IE/5LhVQQJ7BrUnlkoyqQVtwMmGFBnAPQTR2KeI68Zg6nxzYvWq6ObNLk5J1YbEMRHVl5t3Mw7HsFdFbw5gLrk=
X-Received: by 2002:a25:2b01:0:b0:da0:84b2:5e3e with SMTP id
 r1-20020a252b01000000b00da084b25e3emr1440011ybr.21.1699451649844; Wed, 08 Nov
 2023 05:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20231103160335.2464561-1-glider@google.com> <20231103160335.2464561-4-glider@google.com>
 <ZUVulBKVYK7cq2rJ@yury-ThinkPad>
In-Reply-To: <ZUVulBKVYK7cq2rJ@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 8 Nov 2023 14:53:29 +0100
Message-ID: <CAG_fn=Vz9ihxLpkT9rxJB=3UfBdsn6HqYCn7aME6xz1SW1YSMg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] arm64: mte: add compression support to mteswap.c
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attemt to compress
>
> attempt?

Good catch!

> >
> >   # cat /sys/kernel/debug/mteswap/stats
> >   8 bytes: 102496 allocations, 67302 deallocations
> >   128 bytes: 212234 allocations, 178278 deallocations
> >   uncompressed tag storage size: 8851200
> >   compressed tag storage size: 4346368
>
> Can you align them like this:
>
>    # cat /sys/kernel/debug/mteswap/stats
>    8 bytes:      102496 allocations,    67302 deallocations
>    128 bytes:    212234 allocations,   178278 deallocations
>    uncompressed tag storage size:    8851200
>    compressed tag storage size:      4346368

Ok, will do in v9.

> And also, can you mention a new file in the documentation?

Sure.

> IIRC, it was my suggestion to measure some stats... If so, can you add:
>
> Suggested-by: Yury Norov <yury.norov@gmail.com> # for stats

Will do.


> > +static atomic_long_t alloc_counters[MTESWAP_CTR_SIZE];
> > +static atomic_long_t dealloc_counters[MTESWAP_CTR_SIZE];
>
> I think it's worth to add them and all the book keeping code in
> a separate patch? Also can you consider making them configurable,
> maybe depending on CONFIG_ARM64_MTE_SWAP_STAT?..

Sounds fine, I'll split this code into a separate patch.

> >  static DEFINE_XARRAY(mte_pages);
> >
> >  void *mte_allocate_tag_storage(void)
> >  {
> > -     /* tags granule is 16 bytes, 2 tags stored per byte */
> > -     return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
> > +     void *ret;
> > +
> > +     ret = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
> > +     if (ret)
> > +             atomic_long_inc(&alloc_counters[MTESWAP_CTR_NOINLINE]);
> > +     return ret;
> >  }
> >
> >  void mte_free_tag_storage(char *storage)
>
> If you use a term 'free' here, the counter name should probably
> reflect that.

I still want to keep the terms "allocation/deallocation" in the
user-facing code (in the /sys/ file) though.
So renaming the counter here will cause a mismatch between its name
and the stats output.

>
> >  {
> > -     kfree(storage);
> > +     if (!mte_is_compressed(storage)) {
> > +             kfree(storage);
> > +             atomic_long_dec(&alloc_counters[MTESWAP_CTR_NOINLINE]);
>
> s/NOINLINE/OUTLINE ?

Done.

> >       mte_save_page_tags(page_address(page), tag_storage);
> > +     compressed = mte_compress(tag_storage);
> > +     if (compressed) {
> > +             mte_free_tag_storage(tag_storage);
> > +             tag_storage = (void *)compressed;
>
> But 'compressed' is already 'void *', what for typecasting?

Yeah, it used to be unsigned long or something like that. Removed the cast.

> Also, it's a bad naming - adjective implies bool type. I'd name it
> 'compressed_tag', or similar.
>
> > +             atomic_long_inc(&alloc_counters[MTESWAP_CTR_INLINE]);
> > +     }
>
> Is it possible to move all this conditional inside the function call?
> I feel like it should be a single-line:
>
>         tag_storage = mte_compress(tag_storage);
>
> So that client code will be free of housekeeping details.

The problem is that this assignment destroys the current value of
tag_storage, which means mte_compress() will have to deal with memory
deallocation.
That, in turn, will introduce an unnecessary dependency between
mtecomp.c and mteswap.c (so that the former can call
mte_free_tag_storage()).
Given that we still have to deal with allocations in mteswap.c, I
don't think it's worth the hassle.

>
> >
> >       /* lookup the swap entry.val from the page */
> >       ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
> > @@ -50,13 +76,20 @@ int mte_save_tags(struct page *page)
> >  void mte_restore_tags(swp_entry_t entry, struct page *page)
> >  {
> >       void *tags = xa_load(&mte_pages, entry.val);
> > +     void *tag_storage = NULL;
> >
> >       if (!tags)
> >               return;
> >
> >       if (try_page_mte_tagging(page)) {
> > +             if (mte_is_compressed(tags)) {
> > +                     tag_storage = mte_allocate_tag_storage();
> > +                     mte_decompress(tags, tag_storage);
> > +                     tags = tag_storage;
> > +             }
>
> Same here, if it's possible, I'd prefer a single line call instead of
> the above chunk:
>
>         tags = mte_decompress(tags);
>         if (!tags)
>                 return;

Same here, we'd have to make mte_decompress() allocate/deallocate
memory in a way consistent with mteswap.c allocations.
