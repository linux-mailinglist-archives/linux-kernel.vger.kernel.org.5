Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B97EF419
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjKQOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjKQOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:10:35 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF8D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:10:28 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58a7d13b00bso1124335eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700230228; x=1700835028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7htlQZjekHYgmlnpKHpQADSuFiF140l42S0f04AXoI=;
        b=Nj+92mLR+5NyMvX76AiKi4vCeK7aBE1Qa/PU5F5XJLNIgv3//j8wPuOUuv5pyUUPQq
         dsDVMsqVquDr8OKivlcm086yneBzTdzemff0t6bjfqBqM82aE/VtXWn7GuTRdAnrrdQQ
         ssYooAYWulszw2OWrixca3EVDROnwKCJfdOd/rhUHke/cMDjAkTROGRggJCFxiSQDYuX
         pe444Hn7sNefAl3+IZ5rypa89FZr4MRjRgs56hFRogcZf4f0HiX0OHPVqoVms9kyE3h1
         OQx1Fol2X+PINLK/FSN8NJ64VsX9E0Y3TFzPnHTlrnvRBmYs6Hqyi1TEi+HMiMuZMOqH
         NXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230228; x=1700835028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7htlQZjekHYgmlnpKHpQADSuFiF140l42S0f04AXoI=;
        b=eb7UDM8LAbLRtLFP3hf+Fhn82yjVEDdUi05w7/VJ5FcjyaMtSaBiT+9xiqv0KxhTdc
         NNhrf4Jz+ATHqgxr443H4T2FdIGzR33B4kwQOEG6DD3ABojkqIEQpaBTh2MlWIQE4a9x
         5SxbXJteazodPAotbiPiwXtgu3rVKjV36r4dfqcMWkqTrGP9oyHwhXzOkxCvF+K8bxcZ
         DhwEmS37Q+yUErHHUAKwuyq2qCp0OiR2hnFinkwsfhoYqoGXc8Yfon34zbq+o+iVUC5w
         j+EySkOBZmWAyTu5bfMEUfq5iaBV5HDIC7DkXg+2RwssXUpAFI6ep9LKJQo9FPIx0tqA
         LdyA==
X-Gm-Message-State: AOJu0YxAwfw9stjixpBNNkdMJdgIrs2Zga5vwISBHfFIVxwaTF8V/W7c
        GM+39KLSR1Lh+IyRNTKJt7b1MMm4ru/sHVQLBcOdfQRM37K3INFtcGo=
X-Google-Smtp-Source: AGHT+IH+QtJMAqqvHRNL5L/O8zkq+BbdunqE4yh7hnLQ/SqY+rKitfXNOmI62LEgLRPFueTZsvwmUvUd4yOo8stw+mM=
X-Received: by 2002:a05:6358:24a3:b0:16b:a950:8e3a with SMTP id
 m35-20020a05635824a300b0016ba9508e3amr13425524rwc.0.1700230227863; Fri, 17
 Nov 2023 06:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20231114095217.1142360-1-jens.wiklander@linaro.org>
 <20231114095217.1142360-2-jens.wiklander@linaro.org> <CAFA6WYOUZBLtkoy6fpsARYN==Eqr7JymskYDTxbvxxkUjEprfg@mail.gmail.com>
 <CAHUa44GRL-vkXH6CKoL-JamJpk+XV8mWyO+VaE8VVdmqSVa6EQ@mail.gmail.com>
In-Reply-To: <CAHUa44GRL-vkXH6CKoL-JamJpk+XV8mWyO+VaE8VVdmqSVa6EQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 17 Nov 2023 19:40:16 +0530
Message-ID: <CAFA6WYPf86cP5WUzrTOagMzt3qFhfFSGbA6LEWvpZv_wc9Zm8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] optee: add page list to kernel private shared memory
To:     Jens Wiklander <jens.wiklander@linaro.org>
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

On Fri, 17 Nov 2023 at 14:00, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Nov 16, 2023 at 1:28=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Tue, 14 Nov 2023 at 15:22, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Until now has kernel private shared memory allocated as dynamic share=
d
> > > memory (not from the static shared memory pool) been returned without=
 a
> > > list of physical pages on allocations via RPC. To support allocations
> > > larger than one page add a list of physical pages.
> >
> > Although this patch looks like a good cleanup, I can't find an ABI
> > change here. Wasn't a list of pages returned earlier too?
>
> No, because handle_rpc_func_cmd_shm_alloc() didn't take the path where
> optee_allocate_pages_list() is called.

Ah I see, so it is tee_shm_is_dynamic() check being removed here that
you are referring to. Feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c    | 28 +++++++++++++----------
> > >  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++------------------=
--
> > >  2 files changed, 37 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 2a258bd3b6b5..38ea2fecfc2e 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool=
 *pool, struct tee_shm *shm,
> > >                                                    unsigned long star=
t))
> > >  {
> > >         unsigned int order =3D get_order(size);
> > > +       unsigned int nr_pages =3D 1 << order;
> > > +       struct page **pages;
> > >         struct page *page;
> > > +       unsigned int i;
> > >         int rc =3D 0;
> > >
> > >         /*
> > > @@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_poo=
l *pool, struct tee_shm *shm,
> > >         shm->paddr =3D page_to_phys(page);
> > >         shm->size =3D PAGE_SIZE << order;
> > >
> > > -       if (shm_register) {
> > > -               unsigned int nr_pages =3D 1 << order, i;
> > > -               struct page **pages;
> > > +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > > +       if (!pages) {
> > > +               rc =3D -ENOMEM;
> > > +               goto err;
> > > +       }
> > >
> > > -               pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNE=
L);
> > > -               if (!pages) {
> > > -                       rc =3D -ENOMEM;
> > > -                       goto err;
> > > -               }
> > > +       for (i =3D 0; i < nr_pages; i++)
> > > +               pages[i] =3D page + i;
> > >
> > > -               for (i =3D 0; i < nr_pages; i++)
> > > -                       pages[i] =3D page + i;
> > > +       shm->pages =3D pages;
> > > +       shm->num_pages =3D nr_pages;
> > >
> > > +       if (shm_register) {
> > >                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > >                                   (unsigned long)shm->kaddr);
> > > -               kfree(pages);
> > >                 if (rc)
> > >                         goto err;
> > >         }
> > >
> > >         return 0;
> > > -
> > >  err:
> > >         free_pages((unsigned long)shm->kaddr, order);
> > > +       shm->kaddr =3D NULL;
> > >         return rc;
> > >  }
> > >
> > > @@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool =
*pool, struct tee_shm *shm,
> > >                 shm_unregister(shm->ctx, shm);
> > >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > >         shm->kaddr =3D NULL;
> > > +       kfree(shm->pages);
> > > +       shm->pages =3D NULL;
> > >  }
> > >
> > >  static void optee_bus_scan(struct work_struct *work)
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.=
c
> > > index d5b28fd35d66..b69410c7cc0a 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struc=
t tee_context *ctx,
> > >                                           struct optee_msg_arg *arg,
> > >                                           struct optee_call_ctx *call=
_ctx)
> > >  {
> > > -       phys_addr_t pa;
> > >         struct tee_shm *shm;
> > >         size_t sz;
> > >         size_t n;
> > > +       struct page **pages;
> > > +       size_t page_count;
> > >
> > >         arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > >
> > > @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struc=
t tee_context *ctx,
> > >                 return;
> > >         }
> > >
> > > -       if (tee_shm_get_pa(shm, 0, &pa)) {
> > > -               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > -               goto bad;
> > > -       }
> > > -
> > > -       sz =3D tee_shm_get_size(shm);
> > > -
> > > -       if (tee_shm_is_dynamic(shm)) {
> > > -               struct page **pages;
> > > +       /*
> > > +        * If there are pages it's dynamically allocated shared memor=
y (not
> > > +        * from the reserved shared memory pool) and needs to be
> > > +        * registered.
> > > +        */
> > > +       pages =3D tee_shm_get_pages(shm, &page_count);
> > > +       if (pages) {
> > >                 u64 *pages_list;
> > > -               size_t page_num;
> > > -
> > > -               pages =3D tee_shm_get_pages(shm, &page_num);
> > > -               if (!pages || !page_num) {
> > > -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > > -                       goto bad;
> > > -               }
> > >
> > > -               pages_list =3D optee_allocate_pages_list(page_num);
> > > +               pages_list =3D optee_allocate_pages_list(page_count);
> > >                 if (!pages_list) {
> > >                         arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > >                         goto bad;
> > >                 }
> > >
> > >                 call_ctx->pages_list =3D pages_list;
> > > -               call_ctx->num_entries =3D page_num;
> > > +               call_ctx->num_entries =3D page_count;
> > >
> > >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTP=
UT |
> > >                                       OPTEE_MSG_ATTR_NONCONTIG;
> > > @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struc=
t tee_context *ctx,
> > >                 arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_=
list) |
> > >                         (tee_shm_get_page_offset(shm) &
> > >                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > > -               arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> > >
> > > -               optee_fill_pages_list(pages_list, pages, page_num,
> > > +               optee_fill_pages_list(pages_list, pages, page_count,
> > >                                       tee_shm_get_page_offset(shm));
> > >         } else {
> > > +               phys_addr_t pa;
> > > +
> > > +               if (tee_shm_get_pa(shm, 0, &pa)) {
> > > +                       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > +                       goto bad;
> > > +               }
> > > +
> > >                 arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTP=
UT;
> > >                 arg->params[0].u.tmem.buf_ptr =3D pa;
> > > -               arg->params[0].u.tmem.size =3D sz;
> > > -               arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> > >         }
> > > +       arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
> > > +       arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
> > >
> > >         arg->ret =3D TEEC_SUCCESS;
> > >         return;
> > > --
> > > 2.34.1
> > >
