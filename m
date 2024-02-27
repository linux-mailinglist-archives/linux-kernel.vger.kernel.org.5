Return-Path: <linux-kernel+bounces-83543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BC869B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF93B2849A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF711474AD;
	Tue, 27 Feb 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrlNT/AV"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3091468F1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049003; cv=none; b=RddFyWmboxf/M7NVHyVAWot2mQMexeK27y0VF5eZ7u7650AIKifdRnPTwBXT9fwb4ceN/nvgM0BlR+HpJhaHnynVG+pEiqfcc9g3V3Q6JvGuMnUvUknMZmxx50BpAr4cn6qXUy25jujM2F8QOocmlDq5ECq4GOH8/mi7coa6GoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049003; c=relaxed/simple;
	bh=vIkQQpslZuckwTFsbaZ9JcwKjcTdPDrI3rJXKYsiiT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7BhJ3Jj2v0q/+gyrqY3vtUGMwa5yFsIcGWpvc6bXmjElP9FLHm5F7sDiEffS+ivoBsm16irZnJ66wOYLPasR3ngaBvjWShVWbwDqH0IWMAqpSdGpr6oer0ARBFE9v4Y2o5vS5FAOkRK1OY7FWeznC8li/hwcfUAZMK3ljLshpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrlNT/AV; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59fcb025b99so1854018eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709048999; x=1709653799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtuZKFPbk53MrmXfvLeh2XdFMq7EjplJgU6ouCpiVEc=;
        b=xrlNT/AVAxvD4sTlgKA1Y9lc0w9784grdtJLRWa+PnsvM6i2m2F2/eX23WOnGKPvX3
         xh5ZP6xJnJw5IUa7PBlQ8Ogd9stjTLqC/vx9qtpKy2FvO6N3s15Zm6U6V1swB27+7TTo
         lU/EpCFXWAgXiSTN50Ya/0S1oGLxNK9yxZ3MVsSXfXzCFX2ECHbU49Suqd4P+ACvcgrL
         uCu8nn3KuyFTi7YVDLwSaynxoS7Z1g3QIWlmRoh+qdJfyljGY47ilm0nZgWM4QI21xwr
         IgwnHX4BdIDID3oako+4Zfy958ZZez5o5UNzmtSa6vUAX7iV/LKEWDYUt6OqsvkNAT2o
         a46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048999; x=1709653799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtuZKFPbk53MrmXfvLeh2XdFMq7EjplJgU6ouCpiVEc=;
        b=gMn3VHOQqwZAOARE6qEu0Ve77rS9sP7a5MaNkBthbRZ1l9auqEOe9uSPehd00hGtj6
         BhkNfSCrjdUc+DCF+OIVbuWMUcfIV0MB1YTks5Z8rg73PR7bcLsnNPmQ4ry07fId3L9d
         xqMunNpGJxVQt0BfnxK/daOiFenNGn0FfTIfksZSa6ms+J4F+bJwxL0u8oE7BUZrEugC
         BdCE03yeWCv/8MO81qVO5+vwgomttgOVqoSO3Fq0DgDwRArJtXcpoCOC710BSGs89GKD
         /2LOhwGDYXrlsSacm86hUg2ghULQJUoNIOPeQ5LcpWZBB5z+4An3FRK28/gITg0O6O99
         Hbpw==
X-Forwarded-Encrypted: i=1; AJvYcCXrIJNRLti1/UOUfXoE7/ethaV8Dk+ana76zb1cBhADkgY0MazgDXHmq10gCxLlg7u0YeLiFysisBeO8+n05w8QKIGKzkKfSz7zOCgQ
X-Gm-Message-State: AOJu0YwYUTO53T/H7kSuzqXIEToLaJJuypcsCM2gDyXp2u3MyaO9I9Pp
	dYiycUUVK+Hj6jmLvhGEEIcfwjggSD5bhCIYsGqQb+b0Qb0yagMI8pkLXDusRwld3zar5ZruFHW
	XoQoFRRzZnh3OhRjKw/w0KeLosimDqIoQYp7Adg==
X-Google-Smtp-Source: AGHT+IFTqn0uGGW1Ksta/QYf76E2hpgCveYOh5cApCHYBXc/4krcUBwVqN0vqfNRuuh2crjF+7+P7Osxc0of4YqErDs=
X-Received: by 2002:a4a:2453:0:b0:5a0:be6c:9e0a with SMTP id
 v19-20020a4a2453000000b005a0be6c9e0amr406499oov.4.1709048999505; Tue, 27 Feb
 2024 07:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com> <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
In-Reply-To: <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 27 Feb 2024 16:49:48 +0100
Message-ID: <CAHUa44G70L9CnQD6V3ivWf1hYfK0iWFt-cfg98-JGB-s8TVd-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Balint Dobszay <balint.dobszay@arm.com>, op-tee@lists.trustedfirmware.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Balint,
>
> On Fri, 23 Feb 2024 at 15:22, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
> >
> > Move the pool alloc and free helper functions from the OP-TEE driver to
> > the TEE subsystem, since these could be reused in other TEE drivers.
> > This patch is not supposed to change behavior, it's only reorganizing
> > the code.
> >
> > Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > ---
> >  drivers/tee/optee/core.c          | 64 ------------------------------
> >  drivers/tee/optee/ffa_abi.c       |  6 +--
> >  drivers/tee/optee/optee_private.h | 12 ------
> >  drivers/tee/optee/smc_abi.c       | 11 +++---
> >  drivers/tee/tee_shm.c             | 65 +++++++++++++++++++++++++++++++
> >  include/linux/tee_drv.h           | 11 ++++++
> >  6 files changed, 85 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 3aed554bc8d8..9390f21f9902 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -9,7 +9,6 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > -#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -17,69 +16,6 @@
> >  #include <linux/types.h>
> >  #include "optee_private.h"
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > -                              size_t size, size_t align,
> > -                              int (*shm_register)(struct tee_context *=
ctx,
> > -                                                  struct tee_shm *shm,
> > -                                                  struct page **pages,
> > -                                                  size_t num_pages,
> > -                                                  unsigned long start)=
)
> > -{
> > -       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
> > -       struct page **pages;
> > -       unsigned int i;
> > -       int rc =3D 0;
> > -
> > -       /*
> > -        * Ignore alignment since this is already going to be page alig=
ned
> > -        * and there's no need for any larger alignment.
> > -        */
> > -       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> > -                                      GFP_KERNEL | __GFP_ZERO);
> > -       if (!shm->kaddr)
> > -               return -ENOMEM;
> > -
> > -       shm->paddr =3D virt_to_phys(shm->kaddr);
> > -       shm->size =3D nr_pages * PAGE_SIZE;
> > -
> > -       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > -       if (!pages) {
> > -               rc =3D -ENOMEM;
> > -               goto err;
> > -       }
> > -
> > -       for (i =3D 0; i < nr_pages; i++)
> > -               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_S=
IZE);
> > -
> > -       shm->pages =3D pages;
> > -       shm->num_pages =3D nr_pages;
> > -
> > -       if (shm_register) {
> > -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > -                                 (unsigned long)shm->kaddr);
> > -               if (rc)
> > -                       goto err;
> > -       }
> > -
> > -       return 0;
> > -err:
> > -       free_pages_exact(shm->kaddr, shm->size);
> > -       shm->kaddr =3D NULL;
> > -       return rc;
> > -}
> > -
> > -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > -                              int (*shm_unregister)(struct tee_context=
 *ctx,
> > -                                                    struct tee_shm *sh=
m))
> > -{
> > -       if (shm_unregister)
> > -               shm_unregister(shm->ctx, shm);
> > -       free_pages_exact(shm->kaddr, shm->size);
> > -       shm->kaddr =3D NULL;
> > -       kfree(shm->pages);
> > -       shm->pages =3D NULL;
> > -}
> > -
> >  static void optee_bus_scan(struct work_struct *work)
> >  {
> >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index ecb5eb079408..ee11918a2b35 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct t=
ee_context *ctx,
> >  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
> >                              struct tee_shm *shm, size_t size, size_t a=
lign)
> >  {
> > -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > -                                         optee_ffa_shm_register);
> > +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> > +                                           optee_ffa_shm_register);
> >  }
> >
> >  static void pool_ffa_op_free(struct tee_shm_pool *pool,
> >                              struct tee_shm *shm)
> >  {
> > -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
> > +       tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister=
);
> >  }
> >
> >  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index 7a5243c78b55..a153285a1919 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 =
cancel_id, u32 session);
> >  int optee_enumerate_devices(u32 func);
> >  void optee_unregister_devices(void);
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > -                              size_t size, size_t align,
> > -                              int (*shm_register)(struct tee_context *=
ctx,
> > -                                                  struct tee_shm *shm,
> > -                                                  struct page **pages,
> > -                                                  size_t num_pages,
> > -                                                  unsigned long start)=
);
> > -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > -                              int (*shm_unregister)(struct tee_context=
 *ctx,
> > -                                                    struct tee_shm *sh=
m));
> > -
> > -
> >  void optee_remove_common(struct optee *optee);
> >  int optee_open(struct tee_context *ctx, bool cap_memref_null);
> >  void optee_release(struct tee_context *ctx);
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a37f87087e5c..b0c616b6870d 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -592,19 +592,20 @@ static int pool_op_alloc(struct tee_shm_pool *poo=
l,
> >          * to be registered with OP-TEE.
> >          */
> >         if (shm->flags & TEE_SHM_PRIV)
> > -               return optee_pool_op_alloc_helper(pool, shm, size, alig=
n, NULL);
> > +               return tee_shm_pool_op_alloc_helper(pool, shm, size, al=
ign,
> > +                                                   NULL);
> >
> > -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > -                                         optee_shm_register);
> > +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> > +                                           optee_shm_register);
> >  }
> >
> >  static void pool_op_free(struct tee_shm_pool *pool,
> >                          struct tee_shm *shm)
> >  {
> >         if (!(shm->flags & TEE_SHM_PRIV))
> > -               optee_pool_op_free_helper(pool, shm, optee_shm_unregist=
er);
> > +               tee_shm_pool_op_free_helper(pool, shm, optee_shm_unregi=
ster);
> >         else
> > -               optee_pool_op_free_helper(pool, shm, NULL);
> > +               tee_shm_pool_op_free_helper(pool, shm, NULL);
> >  }
> >T
> >  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 731d9028b67f..641aad92ffe2 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_=
context *ctx, size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> >
> > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
>
> I don't see the first argument (struct tee_shm_pool *pool) being used,
> so drop that. Also, we can just rename it as
> tee_dyn_shm_alloc_helper().
>
> > +                                size_t size, size_t align,
> > +                                int (*shm_register)(struct tee_context=
 *ctx,
> > +                                                    struct tee_shm *sh=
m,
> > +                                                    struct page **page=
s,
> > +                                                    size_t num_pages,
> > +                                                    unsigned long star=
t))
> > +{
> > +       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
> > +       struct page **pages;
> > +       unsigned int i;
> > +       int rc =3D 0;
> > +
> > +       /*
> > +        * Ignore alignment since this is already going to be page alig=
ned
> > +        * and there's no need for any larger alignment.
> > +        */
> > +       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> > +                                      GFP_KERNEL | __GFP_ZERO);
> > +       if (!shm->kaddr)
> > +               return -ENOMEM;
> > +
> > +       shm->paddr =3D virt_to_phys(shm->kaddr);
> > +       shm->size =3D nr_pages * PAGE_SIZE;
> > +
> > +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +       if (!pages) {
> > +               rc =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +
> > +       for (i =3D 0; i < nr_pages; i++)
> > +               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_S=
IZE);
> > +
> > +       shm->pages =3D pages;
> > +       shm->num_pages =3D nr_pages;
> > +
> > +       if (shm_register) {
> > +               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > +                                 (unsigned long)shm->kaddr);
> > +               if (rc)
> > +                       goto err;
> > +       }
> > +
> > +       return 0;
> > +err:
> > +       free_pages_exact(shm->kaddr, shm->size);
> > +       shm->kaddr =3D NULL;
> > +       return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
> > +
> > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
>
> Ditto tee_shm_pool_op_free_helper() -> tee_dyn_shm_free_helper()
>
> > +                                int (*shm_unregister)(struct tee_conte=
xt *ctx,
> > +                                                      struct tee_shm *=
shm))
> > +{
> > +       if (shm_unregister)
> > +               shm_unregister(shm->ctx, shm);
> > +       free_pages_exact(shm->kaddr, shm->size);
> > +       shm->kaddr =3D NULL;
> > +       kfree(shm->pages);
> > +       shm->pages =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
> > +
> >  static struct tee_shm *
> >  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u3=
2 flags,
> >                     int id)
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 911ddf92dcee..4cf402424e71 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t=
 size);
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size=
_t size);
> >
> > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
> > +                                size_t size, size_t align,
> > +                                int (*shm_register)(struct tee_context=
 *ctx,
> > +                                                    struct tee_shm *sh=
m,
> > +                                                    struct page **page=
s,
> > +                                                    size_t num_pages,
> > +                                                    unsigned long star=
t));
> > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
> > +                                int (*shm_unregister)(struct tee_conte=
xt *ctx,
> > +                                                      struct tee_shm *=
shm));
> > +
>
> These rather belong to drivers/tee/tee_private.h as we shouldn't
> expose them to other kernel client drivers.

This is the right place, this .h file is for TEE drivers too.

Cheers,
Jens

>
> -Sumit
>
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >                                             void *addr, size_t length);
> >
> > --
> > 2.34.1
> >

