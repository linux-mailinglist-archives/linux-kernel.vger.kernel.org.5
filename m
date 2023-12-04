Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32BF80333C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjLDMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjLDMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:42:10 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E590
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:42:17 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-46442e22afcso3326884137.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701693736; x=1702298536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPmEujfkGgLd6YScn/4T73eFY2WjHqTTuoaWymL+wUA=;
        b=XDmxewI3mbAbrVWnghFV0O8ErrAYbxkCQoaRDsrnEihvRDV7WDfzloIdIVyE+AdFYV
         2VDzu6uzLDtDzt3hjHYwvjiuGKZzf2b7WG6ZGutCWM0ZFxy+nW+o31+kLRffoIvwbOZl
         9ZHDSKr3e3TXNGDNcD3aWzwaYA2SbXSfjrPcdtoKgejGY4nGn25GVB8zBewyHP7yLl6L
         Tp6nuOKgC8bv8UA7eu4AzqwMstr+1c/wIwvuO4AbZRAUd4I5zQmJLJFSRWTtWWTEi4PM
         Gb/EXxalLOTBQAD9IgGb5RgW2G91s5BjturOSh7pIVmbswpkEC1nybuznnjDvlUjPKwW
         pZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693736; x=1702298536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPmEujfkGgLd6YScn/4T73eFY2WjHqTTuoaWymL+wUA=;
        b=LVa8fvHG4t/q8+PIvFDV9dgF/YK/agkDhUGEU2xVz/7bLniQUULYO//b7BEeIrDUio
         rYQaQnG5qah4L4+oVOBP1+1QzJwOUN4YktCoDOWru6gTRdhc8hI6yZETdOSZaC4BpcMd
         1Iv8wXJDa1mKIr/VvKkeHz6DmFnsSx0IeZ51uhcg8vnkBTfpcViSddBrCREtEIYlBsJ+
         3BTHAgcPwoPmHWXCehUOuzU/4+mXuci1lujZRJCcvOMLUHpxTQ0Ih0l/OdS/XTKyUII7
         EclXD7EE3spIiveLdiCzLOL5v3FwVPl7uZnHfzBS+WgfxChip3ifk/xbr4vmq+E6sN3g
         i8uw==
X-Gm-Message-State: AOJu0Yzz9NVJgpzDT8lohP8yRT/bZz06EsdRjbHzvczNz4w8iZRuK80f
        zHtidWD3bN6HACyYZop8F05GAIiYIW/DtsneCgDb+A==
X-Google-Smtp-Source: AGHT+IGHyQ2w7WZnkB45mWsp6WuthKL/KskQXZHMV21aJ8vWGZvKaslEPk6Ge3pNVM8FFgeKSZWG0fEPiNU0ZUDXDuw=
X-Received: by 2002:a05:6102:c90:b0:464:7ee8:2fd7 with SMTP id
 f16-20020a0561020c9000b004647ee82fd7mr2138574vst.32.1701693735909; Mon, 04
 Dec 2023 04:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com> <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
In-Reply-To: <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 4 Dec 2023 18:12:04 +0530
Message-ID: <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Al Viro <viro@zeniv.linux.org.uk>, axboe@kernel.dk
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jens A., Al Viro

<snip>

> >>>> +        */
> >>>> +       if (iov_iter_is_kvec(iter))
> >>>> +               shm_get_kernel_pages(shm->pages, num_pages);
> >>>> +
> >>>> +       shm->offset = off;
> >>>> +       shm->size = len;
> >>>> +       shm->num_pages = num_pages;
> >>>> +
> >>>>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
> >>>>                                              shm->num_pages, start);
> >>>>         if (rc) {
> >>>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
> >>>>
> >>>>         return shm;
> >>>>  err_put_shm_pages:
> >>>> -       if (flags & TEE_SHM_USER_MAPPED)
> >>>> +       if (!iov_iter_is_kvec(iter))
> >>>>                 unpin_user_pages(shm->pages, shm->num_pages);
> >>>>         else
> >>>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
> >>>> +err_free_shm_pages:
> >>>>         kfree(shm->pages);
> >>>>  err_free_shm:
> >>>>         kfree(shm);
> >>>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >>>>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
> >>>>         struct tee_device *teedev = ctx->teedev;
> >>>>         struct tee_shm *shm;
> >>>> +       struct iov_iter iter;
> >>>>         void *ret;
> >>>> -       int id;
> >>>> +       int id, err;
> >>>>
> >>>>         if (!access_ok((void __user *)addr, length))
> >>>>                 return ERR_PTR(-EFAULT);
> >>>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >>>>         if (id < 0)
> >>>>                 return ERR_PTR(id);
> >>>>
> >>>> -       shm = register_shm_helper(ctx, addr, length, flags, id);
> >>>> +       err = import_ubuf(ITER_DEST, (void __user *)addr, length, &iter);
> >>>
> >>> As I mentioned in a previous review, import_ubuf() already does the
> >>> access_ok() check, so we don't need the extra access_ok() check above.
> >>> Also, you should move import_ubuf() to be the first invocation within
> >>> this API.
> >>
> >> My apologies, I re-added import_ubuf() during testing to debug an issue and
> >
> > I suppose you intended to mention access_ok() here, BTW, no worries :).
>
> Re-running xtest after removing the access_ok() I have a crash in
> regression_5006.3 Allocate_out_of_memory
>
> [   89.258100] ------------[ cut here ]------------
> [   89.258377] WARNING: CPU: 1 PID: 134 at mm/page_alloc.c:4402
> __alloc_pages+0x674/0xd14
> [   89.258988] Modules linked in:
> [   89.259554] CPU: 1 PID: 134 Comm: xtest Not tainted 6.6.0-g1ebcc18a80d7-dirty #69
> [   89.259763] Hardware name: linux,dummy-virt (DT)
> [   89.259977] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   89.260143] pc : __alloc_pages+0x674/0xd14
> [   89.260252] lr : alloc_pages+0xac/0x160
> [   89.260364] sp : ffff8000803f3a30
> [   89.260437] x29: ffff8000803f3a30 x28: ffff8000803f3d70 x27: 0000000000000000
> [   89.260705] x26: 000000000000000b x25: 0000000000000000 x24: ffff000000178000
> [   89.260847] x23: ffff00003f52b720 x22: ffff000001442720 x21: 0000000000000000
> [   89.261022] x20: 000000000000000b x19: 0000000000000000 x18: ffff8000803f3b78
> [   89.261162] x17: 0000000000000000 x16: ffffa7a428b67660 x15: 0000ffff63ffffff
> [   89.261348] x14: 0000000000000008 x13: 1fffe00000a4c421 x12: ffff8000803f3b78
> [   89.261528] x11: ffff000005262100 x10: ffff000005262108 x9 : ffff00000526210c
> [   89.261739] x8 : 0000aaab0a97c000 x7 : 0000aaab0a90e000 x6 : ffff000005262150
> [   89.261920] x5 : 0000000000000000 x4 : ffff000000976740 x3 : 0000000000000000
> [   89.262098] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffa7a429daf000
> [   89.262340] Call trace:
> [   89.262921]  __alloc_pages+0x674/0xd14
> [   89.263262]  alloc_pages+0xac/0x160
> [   89.263373]  alloc_pages_exact+0x48/0x94
> [   89.263464]  optee_shm_register+0xa8/0x1f4
> [   89.263591]  register_shm_helper+0x1bc/0x28c
> [   89.263687]  tee_shm_register_user_buf+0xb8/0x128
> [   89.263816]  tee_ioctl+0xbc/0xfa0
> [   89.263915]  __arm64_sys_ioctl+0xa8/0xec
> [   89.264053]  invoke_syscall+0x48/0x114
> [   89.264173]  el0_svc_common.constprop.0+0x40/0xe8
> [   89.264321]  do_el0_svc+0x20/0x2c
> [   89.264488]  el0_svc+0x40/0xf4
> [   89.264578]  el0t_64_sync_handler+0x13c/0x158
> [   89.264714]  el0t_64_sync+0x190/0x194
> [   89.265003] ---[ end trace 0000000000000000 ]---
>
>
> The issue is that, in import_ubuf(), it updates the length [1], making the
>
> access_ok() succeed and leading to an issue later in the page allocation process.
>
> To fix, I propose to add a test in tee_shm_register_user_buf() after calling
>
> import_ubuf()
>
>         if (length != iter_iov_len(&iter))
>                 return ERR_PTR(-EFAULT);
>
>
> Would it be ok for you ? I'm afraid of side effects if I update import_ubuf()...

IMO, access_ok() should be the first thing that import_ubuf() or
import_single_range() should do, something as follows:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8ff6824a1005..4aee0371824c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);

 int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
 {
-       if (len > MAX_RW_COUNT)
-               len = MAX_RW_COUNT;
        if (unlikely(!access_ok(buf, len)))
                return -EFAULT;
+       if (len > MAX_RW_COUNT)
+               len = MAX_RW_COUNT;

        iov_iter_ubuf(i, rw, buf, len);
        return 0;

Jens A., Al Viro,

Was there any particular reason which I am unaware of to perform
access_ok() check on modified input length?

-Sumit

>
> [1] https://elixir.bootlin.com/linux/latest/source/lib/iov_iter.c#L1553
>
