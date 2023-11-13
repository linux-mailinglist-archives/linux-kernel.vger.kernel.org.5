Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A47EA1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjKMRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKMRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:13:52 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962199
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:13:48 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5845213c583so2508727eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699895628; x=1700500428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYChTnpPFyQsAZFL2ca0QpZFOLSiThhIqgcO8z+32Lg=;
        b=RMZOTkE201HC/dtrHi3RTWo/imboidlimRvlXCxG7jkkIeYXNR76P2ifbw8ImdSl30
         EwANNG7yRg0fCRNyE5nz2+YcqG3SxItwPw/cdZQDvJGudXZg08P3RMXh7QaGmCQMl1Dj
         a0Qzrsar3BfXjOPGl3fjHPPIBC2QlymRqBaMjrZ2DAdrThopNB4EIbrhBopTKKWwNv4p
         veQUO3dPKkpKV5k9+dXvpYrY72ZHEMmKNsuGy+fRkJJ/hHOrnkM5kGgTrmt9ZSq4Vh4f
         2PGDTdS7975NjukoGwlu0AipfOaICDHEwnFj7vWRE59Lm4PVopONdkfm/EvQNLWmKRfj
         fPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699895628; x=1700500428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYChTnpPFyQsAZFL2ca0QpZFOLSiThhIqgcO8z+32Lg=;
        b=G2BIvW6rSlHJ59up7lEFM++tOpqMC1btpEYeTUtJT118Memk5A0y4lltWb97v+04Fn
         LKhm9vCkiJWX+B9UMMRZGEYkZyA4DqFOmgX4A+SgV+L+Bf+sEBf5ddESaIf5RyRTFFbj
         BphSrR2YzrrBhRNOvukO4aQRRFxlUgJm9TUicxI7EKL+9k1dumWtqcHWi0sDKiIkJfnD
         SK/lVHON2GFMpWlzd7Nb6A637YvSq+kvietY6nLTupa8BH9WgHKFmR7SduG4OaVpwuUp
         9ZPLSAjsfbkPzwnlHcbztUfFx/JsxuNczTdcB6yb37Ky+ElbTXAH4ECJoNLCt+48THb/
         WGhQ==
X-Gm-Message-State: AOJu0YwlrB7QdjlaheG+nU7+QZoIy+KwP84wetQtLr/vA4S1QBm52DMd
        j29Mss52w/vkY7bV/8igclFziEEY0/WdKSW32vy5XOAkUzZ1nABk
X-Google-Smtp-Source: AGHT+IGkldr0SEn/D9ImU8jzRlN0yagSNzdqwO/U36Itv8CCrRD60NlNW7iTrYzCPyFg98WXhCvv84qp8yeUxsCflbQ=
X-Received: by 2002:a05:6359:278e:b0:16b:c3ef:6045 with SMTP id
 ly14-20020a056359278e00b0016bc3ef6045mr7160414rwb.0.1699895627919; Mon, 13
 Nov 2023 09:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108102755.93079-1-jens.wiklander@linaro.org>
 <20231108102755.93079-2-jens.wiklander@linaro.org> <CAFA6WYPqkRdGc6R6Q=w0YJ=SN9FvQ48qDEc6d05gOyyV6x066g@mail.gmail.com>
In-Reply-To: <CAFA6WYPqkRdGc6R6Q=w0YJ=SN9FvQ48qDEc6d05gOyyV6x066g@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 13 Nov 2023 18:13:36 +0100
Message-ID: <CAHUa44F_WUuL+B5oFC=9rHrYZJ0P_LuPWK9SxjvQuY9nRd-tCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: add page list to kernel private shared memory
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
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

Hi Sumit,

On Fri, Nov 10, 2023 at 3:36=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Jens,
>
> On Wed, 8 Nov 2023 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Until now has kernel private shared memory allocated as dynamic shared
> > memory (not from the static shared memory pool) been returned without a
> > list of physical pages on allocations via RPC. To support allocations
> > larger than one page add a list of physical pages for all allocations
> > larger than one page.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c    | 40 +++++++++++++++++++++++++--------
> >  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
> >  2 files changed, 52 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 2a258bd3b6b5..a425eca0173d 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -27,6 +27,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *p=
ool, struct tee_shm *shm,
> >                                                    unsigned long start)=
)
> >  {
> >         unsigned int order =3D get_order(size);
> > +       unsigned int nr_pages =3D 1 << order;
> >         struct page *page;
> >         int rc =3D 0;
> >
> > @@ -39,12 +40,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool =
*pool, struct tee_shm *shm,
> >                 return -ENOMEM;
> >
> >         shm->kaddr =3D page_address(page);
> > -       shm->paddr =3D page_to_phys(page);
> >         shm->size =3D PAGE_SIZE << order;
> >
> > -       if (shm_register) {
> > -               unsigned int nr_pages =3D 1 << order, i;
> > +       /*
> > +        * If memory is registered immediately use a temporary page lis=
t
> > +        * and free it directly after the registration is completed.
> > +        *
> > +        * Else, if we have allocated more than one page store a page
> > +        * list in the struct tee_shm.
> > +        *
> > +        * Else, store the physical address of the single page that was
> > +        * allocated.
> > +        *
> > +        * optee_pool_op_free_helper() is responsible for freeing the
> > +        * resourses allocated in this function.
> > +        */
>
> It looks a bit complex to me. Do we really need it to be conditional?
> I was thinking if we can simplify this API as follows:
>
> int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm =
*shm,
>                                size_t size, size_t align,
>                                int (*shm_register)(struct tee_shm *shm))
> {
>         unsigned int order =3D get_order(size);
>         unsigned int nr_pages =3D 1 << order, i;
>         struct page **pages;
>         struct page *page;
>         int rc =3D 0;
>
>         /*
>          * Ignore alignment since this is already going to be page aligne=
d
>          * and there's no need for any larger alignment.
>          */
>         page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>         if (!page)
>                 return -ENOMEM;
>
>         shm->kaddr =3D page_address(page);
>         shm->paddr =3D page_to_phys(page);
>         shm->size =3D PAGE_SIZE << order;
>
>         pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>         if (!pages) {
>                 rc =3D -ENOMEM;
>                 goto err;
>         }
>
>         for (i =3D 0; i < nr_pages; i++)
>                 pages[i] =3D page + i;
>
>         shm->pages =3D pages;
>         shm->num_pages =3D nr_pages;
>
>         if (shm_register) {
>                 rc =3D shm_register(shm);
>                 if (rc)
>                         goto err;
>         }
>
>         return 0;
>
> err:
>         kfree(pages);
>         free_pages((unsigned long)shm->kaddr, order);
>         return rc;
> }

Good idea, I'll try it in the v3.

Thanks,
Jens

>
> -Sumit
>
> > +       if (shm_register || nr_pages > 1) {
> >                 struct page **pages;
> > +               unsigned int i;
> >
> >                 pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL)=
;
> >                 if (!pages) {
> > @@ -55,17 +68,24 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool =
*pool, struct tee_shm *shm,
> >                 for (i =3D 0; i < nr_pages; i++)
> >                         pages[i] =3D page + i;
> >
> > -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > -                                 (unsigned long)shm->kaddr);
> > -               kfree(pages);
> > -               if (rc)
> > -                       goto err;
> > +               if (shm_register) {
> > +                       rc =3D shm_register(shm->ctx, shm, pages, nr_pa=
ges,
> > +                                         (unsigned long)shm->kaddr);
> > +                       kfree(pages);
> > +                       if (rc)
> > +                               goto err;
> > +               } else {
> > +                       shm->pages =3D pages;
> > +                       shm->num_pages =3D nr_pages;
> > +               }
> > +       } else {
> > +               shm->paddr =3D page_to_phys(page);
> >         }
> >
> >         return 0;
> > -
> >  err:
> >         free_pages((unsigned long)shm->kaddr, order);
> > +       shm->kaddr =3D NULL;
> >         return rc;
> >  }
> >
> > @@ -77,6 +97,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *p=
ool, struct tee_shm *shm,
> >                 shm_unregister(shm->ctx, shm);
> >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> >         shm->kaddr =3D NULL;
> > +       kfree(shm->pages);
> > +       shm->pages =3D NULL;
> >  }
> >
> >  static void optee_bus_scan(struct work_struct *work)
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index d5b28fd35d66..b69410c7cc0a 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct =
tee_context *ctx,
> >                                           struct optee_msg_arg *arg,
> >                                           struct optee_call_ctx *call_c=
tx)
> >  {
> > -       phys_addr_t pa;
> >         struct tee_shm *shm;
> >         size_t sz;
> >         size_t n;
> > +       struct page **pages;
> > +       size_t page_count;
> >
> >         arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> >
> > @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct =
tee_context *ctx,
> >                 return;
> >         }
> >
> > -       if (tee_shm_get_pa(shm, 0, &pa)) {
> > -               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > -               goto bad;
> > -       }
> > -
> > -       sz =3D tee_shm_get_size(shm);
> > -
> > -       if (tee_shm_is_dynamic(shm)) {
> > -               struct page **pages;
> > +       /*
> > +        * If there are pages it's dynamically allocated shared memory =
(not
> > +        * from the reserved shared memory pool) and needs to be
> > +        * registered.
> > +        */
> > +       pages =3D tee_shm_get_pages(shm, &page_count);
> > +       if (pages) {
> >                 u64 *pages_list;
> > -               size_t page_num;
> > -
> > -               pages =3D tee_shm_get_pages(shm, &page_num);
> > -               if (!pages || !page_num) {
> > -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > -                       goto bad;
> > -               }
> >
> > -               pages_list =3D optee_allocate_pages_list(page_num);
> > +               pages_list =3D optee_allocate_pages_list(page_count);
> >                 if (!pages_list) {
> >                         arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> >                         goto bad;
> >                 }
> >
> >                 call_ctx->pages_list =3D pages_list;
> > -               call_ctx->num_entries =3D page_num;
> > +               call_ctx->num_entries =3D page_count;
> >
> >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT=
 |
> >                                       OPTEE_MSG_ATTR_NONCONTIG;
> > @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct =
tee_context *ctx,
> >                 arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_li=
st) |
> >                         (tee_shm_get_page_offset(shm) &
> >                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > -               arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >
> > -               optee_fill_pages_list(pages_list, pages, page_num,
> > +               optee_fill_pages_list(pages_list, pages, page_count,
> >                                       tee_shm_get_page_offset(shm));
> >         } else {
> > +               phys_addr_t pa;
> > +
> > +               if (tee_shm_get_pa(shm, 0, &pa)) {
> > +                       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > +                       goto bad;
> > +               }
> > +
> >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT=
;
> >                 arg->params[0].u.tmem.buf_ptr =3D pa;
> > -               arg->params[0].u.tmem.size =3D sz;
> > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >         }
> > +       arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > +       arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> >
> >         arg->ret =3D TEEC_SUCCESS;
> >         return;
> > --
> > 2.34.1
> >
