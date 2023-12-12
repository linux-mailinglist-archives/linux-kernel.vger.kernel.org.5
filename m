Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466080E77C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjLLJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjLLJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:23:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E090C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:23:33 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f43042268so367123385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702373012; x=1702977812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3WTDcSg3hjiuLZWlh46feJrUmObnKSFrpOjiFHpKFA=;
        b=CTQN9Rx14xKe3nLQhvJhztDDQ5WZsi6XYLURwDvOddMGlUk7pwKWjYMbgtD53+MeC1
         xXAkmwrhazWEOyiq0FxP+onLORuzkkJ6qQIUz1IpL5BElQ+v2CFqPjtpB8nFvLKbyEYD
         0UblfY3afVTHOIImqxCZHIjzkPkA29boyg2kpKwEKKYdLYw8mTVK6cRT7ZQDWIfuP9ly
         G+TMP1YGbnlFT+p1/GXEVgosyn0AwmlYgtjf0M7cjw2AS0foZ6f4EhgWF50fSa2b/hao
         MtKsUg7RoPfXJ2kCpSMta5IKk/5HnXg+UeOiZ+VXOV7+Rq780wQOjg5sAD/BFiVNzoXK
         ixIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373012; x=1702977812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3WTDcSg3hjiuLZWlh46feJrUmObnKSFrpOjiFHpKFA=;
        b=iA2xw/mNNb/DDw+KQzfvu3tVPppKGmDFFhufTwr2b5FFOzBVq9j7IT8DNaDbIktuHj
         uCyzRaE97yjGSLuIl9UuKqYzKnwf5C3cdnuGO9jfF04tgd+gt+1vMas/YH/yO9Bbp7hc
         ZynQ+I6I9hf7CS4CBLskq8bbgORNKrdk5bPPY159Zq9NOdj49gdmuA5TiircInHOwrfi
         6o9peESIXVrNQJiw43559OCCBhgJWECIEf5gDxBcrqQXIQrnc80IogEe5QOMnZwXMaTs
         AKKZbaM/giYVgJZtDU0O53h6NMdZsDmuh8xrtPRgtZQeIm13d6za9guud7JzLyDDJ17C
         ksOw==
X-Gm-Message-State: AOJu0YxwTM8Jo1KHRM6UvxlFD1D6q0s8KdLCo/THHZTbZOB90qG2XwoP
        XiZ7UupOCpiv0Nrlv2jnzdcDte4U7wZq/IdlsrNaxs2kxbd0fex+
X-Google-Smtp-Source: AGHT+IGFu+hef1fL5foqzeT4K7qJD0Uc6Tv7AWxRqvCNepr2BfymodJ7b9qT0/XMzbkw1Ttyzfh+u/DGbmkswo8lvPo=
X-Received: by 2002:a05:620a:3f08:b0:77f:383f:8ac0 with SMTP id
 tx8-20020a05620a3f0800b0077f383f8ac0mr7784692qkn.35.1702373012437; Tue, 12
 Dec 2023 01:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20231205162330.196259-1-arnaud.pouliquen@foss.st.com> <CAFA6WYMYQDe-g9P_Gck2mH2Pn=B-8m2dzvK7of6djCp=wBjjUw@mail.gmail.com>
In-Reply-To: <CAFA6WYMYQDe-g9P_Gck2mH2Pn=B-8m2dzvK7of6djCp=wBjjUw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 12 Dec 2023 10:23:20 +0100
Message-ID: <CAHUa44E9Bj1xjywx9yJ04miC5YkM5fAuHNqxvbCjqJZxjwyO5w@mail.gmail.com>
Subject: Re: [PATCH v5] tee: Use iov_iter to better support shared buffer registration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 6:25=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 5 Dec 2023 at 21:53, Arnaud Pouliquen
> <arnaud.pouliquen@foss.st.com> wrote:
> >
> > Currently it's not possible to register kernel buffers with TEE
> > which are allocated via vmalloc.
> >
> > Use iov_iter and associated helper functions to manage the page
> > registration for all type of memories.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > ---
> > Update from V4 to V5:
> > - replace import_ubuf() by iov_iter_ubuf(),
> > - fix comment in register_shm_helper() function.
> >
>
> Looks good to me, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> > Update from V3 to V4:
> > - improve commit message,
> > - use import_ubuf() instead of iov_iter_init(),
> > - move shm_get_kernel_pages in register_shm_helper,
> > - put back untagged_addr in register_shm_helper(),
> > - move the comment related to pin pages from shm_get_kernel_pages()
> >   to register_shm_helper().
> >
> > Update from V2 to V3:
> > - break lines longer than 80 columns.
> >
> > Update from V1 to V2:
> > - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
> > - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_b=
uf().
> >
> > V1:
> > The support of buffer registration allocated with vmalloc is no more
> > available since c83900393aa1 ("tee: Remove vmalloc page support").
> >
> > This patch is an alternative to a revert and resulted from a discussion
> > with Christopher Hellwig [1].
> >
> > This patch has been tested using xtest tool in optee qemu environment [=
2]
> > and using the series related to the remoteproc tee that should be
> > proposed soon [3].
> >
> > References:
> > [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5e=
e47dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
> > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#b=
uild-instructions
> > [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5e=
e47dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
> > ---
> >  drivers/tee/tee_shm.c | 78 +++++++++++++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 673cf0359494..731d9028b67f 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **page=
s, size_t page_count)
> >                 put_page(pages[n]);
> >  }
> >
> > -static int shm_get_kernel_pages(unsigned long start, size_t page_count=
,
> > -                               struct page **pages)
> > +static void shm_get_kernel_pages(struct page **pages, size_t page_coun=
t)
> >  {
> > -       struct page *page;
> >         size_t n;
> >
> > -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> > -                        is_kmap_addr((void *)start)))
> > -               return -EINVAL;
> > -
> > -       page =3D virt_to_page((void *)start);
> > -       for (n =3D 0; n < page_count; n++) {
> > -               pages[n] =3D page + n;
> > +       for (n =3D 0; n < page_count; n++)
> >                 get_page(pages[n]);
> > -       }
> > -
> > -       return page_count;
> >  }
> >
> >  static void release_registered_pages(struct tee_shm *shm)
> > @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee=
_context *ctx, size_t size)
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> >
> >  static struct tee_shm *
> > -register_shm_helper(struct tee_context *ctx, unsigned long addr,
> > -                   size_t length, u32 flags, int id)
> > +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u3=
2 flags,
> > +                   int id)
> >  {
> >         struct tee_device *teedev =3D ctx->teedev;
> >         struct tee_shm *shm;
> > -       unsigned long start;
> > -       size_t num_pages;
> > +       unsigned long start, addr;
> > +       size_t num_pages, off;
> > +       ssize_t len;
> >         void *ret;
> >         int rc;
> >
> > @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsi=
gned long addr,
> >         shm->flags =3D flags;
> >         shm->ctx =3D ctx;
> >         shm->id =3D id;
> > -       addr =3D untagged_addr(addr);
> > +       addr =3D untagged_addr((unsigned long)iter_iov_addr(iter));
> >         start =3D rounddown(addr, PAGE_SIZE);
> > -       shm->offset =3D addr - start;
> > -       shm->size =3D length;
> > -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAG=
E_SIZE;
> > +       num_pages =3D iov_iter_npages(iter, INT_MAX);
> > +       if (!num_pages) {
> > +               ret =3D ERR_PTR(-ENOMEM);
> > +               goto err_ctx_put;
> > +       }
> > +
> >         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERN=
EL);
> >         if (!shm->pages) {
> >                 ret =3D ERR_PTR(-ENOMEM);
> >                 goto err_free_shm;
> >         }
> >
> > -       if (flags & TEE_SHM_USER_MAPPED)
> > -               rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE=
,
> > -                                        shm->pages);
> > -       else
> > -               rc =3D shm_get_kernel_pages(start, num_pages, shm->page=
s);
> > -       if (rc > 0)
> > -               shm->num_pages =3D rc;
> > -       if (rc !=3D num_pages) {
> > -               if (rc >=3D 0)
> > -                       rc =3D -ENOMEM;
> > -               ret =3D ERR_PTR(rc);
> > -               goto err_put_shm_pages;
> > +       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num=
_pages, 0,
> > +                                    &off);
> > +       if (unlikely(len <=3D 0)) {
> > +               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
> > +               goto err_free_shm_pages;
> >         }
> >
> > +       /*
> > +        * iov_iter_extract_kvec_pages does not get reference on the pa=
ges,
> > +        * get a reference on them.
> > +        */
> > +       if (iov_iter_is_kvec(iter))
> > +               shm_get_kernel_pages(shm->pages, num_pages);
> > +
> > +       shm->offset =3D off;
> > +       shm->size =3D len;
> > +       shm->num_pages =3D num_pages;
> > +
> >         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
> >                                              shm->num_pages, start);
> >         if (rc) {
> > @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsi=
gned long addr,
> >
> >         return shm;
> >  err_put_shm_pages:
> > -       if (flags & TEE_SHM_USER_MAPPED)
> > +       if (!iov_iter_is_kvec(iter))
> >                 unpin_user_pages(shm->pages, shm->num_pages);
> >         else
> >                 shm_put_kernel_pages(shm->pages, shm->num_pages);
> > +err_free_shm_pages:
> >         kfree(shm->pages);
> >  err_free_shm:
> >         kfree(shm);
> > @@ -307,6 +305,7 @@ struct tee_shm *tee_shm_register_user_buf(struct te=
e_context *ctx,
> >         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
> >         struct tee_device *teedev =3D ctx->teedev;
> >         struct tee_shm *shm;
> > +       struct iov_iter iter;
> >         void *ret;
> >         int id;
> >
> > @@ -319,7 +318,8 @@ struct tee_shm *tee_shm_register_user_buf(struct te=
e_context *ctx,
> >         if (id < 0)
> >                 return ERR_PTR(id);
> >
> > -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
> > +       iov_iter_ubuf(&iter, ITER_DEST,  (void __user *)addr, length);
> > +       shm =3D register_shm_helper(ctx, &iter, flags, id);
> >         if (IS_ERR(shm)) {
> >                 mutex_lock(&teedev->mutex);
> >                 idr_remove(&teedev->idr, id);
> > @@ -352,8 +352,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct=
 tee_context *ctx,
> >                                             void *addr, size_t length)
> >  {
> >         u32 flags =3D TEE_SHM_DYNAMIC;
> > +       struct kvec kvec;
> > +       struct iov_iter iter;
> > +
> > +       kvec.iov_base =3D addr;
> > +       kvec.iov_len =3D length;
> > +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
> >
> > -       return register_shm_helper(ctx, (unsigned long)addr, length, fl=
ags, -1);
> > +       return register_shm_helper(ctx, &iter, flags, -1);
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
> >
> > --
> > 2.25.1
> >
