Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070007EED8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKQIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:30:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D962A7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:30:03 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6705379b835so9515336d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700209802; x=1700814602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE3x8Je1GtPE/cdhBuD5VpOAYsIE+Hb1O7sGDllMALo=;
        b=LJpC4pKqPLyVhTxISd03YaHPqf/qH0Jzu0Q6JGHXNjY1pDoPNycd5p9zAZNJzWw6Qn
         ZyjcqwXbQb3HI8tG2eAE8u74CLMCvmzjqFpsxBS4lqIWCV9Kd2/PcT+V00vBYsiH3F/V
         2mhpYwQNhgFG1BDnEl4YSf26+jeo2taV/+h+TggOaxe3lIkidnM8eXipg4VlfdSsMBc7
         EbZXNYTBKP12r70wFoU3Nk1KrY4P9Ki+biS9LsoGiqdtUB9q5flHIFmFJaopN4etEQ5U
         u9qq4RLwveVTkNZuXZzCFzQVeMiDHKUt+E1uizRRFR5R2kQxAG5t3AgSXar/62f/YNBX
         kTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700209802; x=1700814602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE3x8Je1GtPE/cdhBuD5VpOAYsIE+Hb1O7sGDllMALo=;
        b=ssLytILsBg3eF7jP2Qk1B0c8naSIn2an8T8Eww8tgrGrpjhtGRS538CDVArRKckzAK
         NjgfTYb3DC7D6iwcnQ7aVEI5IPdNZes+DeRdzRKqM5yqdglUVL3pP4Gj2o137T+AS6xd
         kSvr0BBSh2ivC3FNuvYGeemGYXgScm8RllBihi3ceSSV7FPSjwML+Ofp8KebhI264NXc
         Qecwvp6UPInxv/gf17yBBZw9Wgjh9UPxpvqRfO4FC3PW9frQX6X0RggQm55KNh9O+46i
         t5VJO8WGJBqaK8lVZs9m1ucH4ZA4kw+guN3M5m2zql8gV2i4zM1CP0yaUASG4tRqTE0p
         eS/w==
X-Gm-Message-State: AOJu0YzYfXmSiiXE/pY66yziE2F66MRBfO4FIULDqvdG5N6tVrZ/cTtB
        JfXTB6jpRbejRjtE9YhIkHbvAiZsRrZtyHCOBAsBhQ==
X-Google-Smtp-Source: AGHT+IGevvzdE8fxZtAzb8nsMoCrT0RGZ3HOOrFLj7uAww3kgAP25WzY15+7LT5JNoczopqtHC7ywSG1xzN/6xiXaKY=
X-Received: by 2002:a05:6214:5493:b0:66d:138f:95df with SMTP id
 lg19-20020a056214549300b0066d138f95dfmr11297595qvb.56.1700209802237; Fri, 17
 Nov 2023 00:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20231114095217.1142360-1-jens.wiklander@linaro.org>
 <20231114095217.1142360-2-jens.wiklander@linaro.org> <CAFA6WYOUZBLtkoy6fpsARYN==Eqr7JymskYDTxbvxxkUjEprfg@mail.gmail.com>
In-Reply-To: <CAFA6WYOUZBLtkoy6fpsARYN==Eqr7JymskYDTxbvxxkUjEprfg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 17 Nov 2023 09:29:51 +0100
Message-ID: <CAHUa44GRL-vkXH6CKoL-JamJpk+XV8mWyO+VaE8VVdmqSVa6EQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] optee: add page list to kernel private shared memory
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 1:28=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 14 Nov 2023 at 15:22, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Until now has kernel private shared memory allocated as dynamic shared
> > memory (not from the static shared memory pool) been returned without a
> > list of physical pages on allocations via RPC. To support allocations
> > larger than one page add a list of physical pages.
>
> Although this patch looks like a good cleanup, I can't find an ABI
> change here. Wasn't a list of pages returned earlier too?

No, because handle_rpc_func_cmd_shm_alloc() didn't take the path where
optee_allocate_pages_list() is called.

Cheers,
Jens

>
> -Sumit
>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c    | 28 +++++++++++++----------
> >  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
> >  2 files changed, 37 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 2a258bd3b6b5..38ea2fecfc2e 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *=
pool, struct tee_shm *shm,
> >                                                    unsigned long start)=
)
> >  {
> >         unsigned int order =3D get_order(size);
> > +       unsigned int nr_pages =3D 1 << order;
> > +       struct page **pages;
> >         struct page *page;
> > +       unsigned int i;
> >         int rc =3D 0;
> >
> >         /*
> > @@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool =
*pool, struct tee_shm *shm,
> >         shm->paddr =3D page_to_phys(page);
> >         shm->size =3D PAGE_SIZE << order;
> >
> > -       if (shm_register) {
> > -               unsigned int nr_pages =3D 1 << order, i;
> > -               struct page **pages;
> > +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +       if (!pages) {
> > +               rc =3D -ENOMEM;
> > +               goto err;
> > +       }
> >
> > -               pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL)=
;
> > -               if (!pages) {
> > -                       rc =3D -ENOMEM;
> > -                       goto err;
> > -               }
> > +       for (i =3D 0; i < nr_pages; i++)
> > +               pages[i] =3D page + i;
> >
> > -               for (i =3D 0; i < nr_pages; i++)
> > -                       pages[i] =3D page + i;
> > +       shm->pages =3D pages;
> > +       shm->num_pages =3D nr_pages;
> >
> > +       if (shm_register) {
> >                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> >                                   (unsigned long)shm->kaddr);
> > -               kfree(pages);
> >                 if (rc)
> >                         goto err;
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
> > @@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *p=
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
