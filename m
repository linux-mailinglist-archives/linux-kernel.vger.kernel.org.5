Return-Path: <linux-kernel+bounces-93422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D142872F85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E81DB274B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46505C908;
	Wed,  6 Mar 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVtI3sVH"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B85C5EB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709773; cv=none; b=qpudg3ElxE+V2JzlvDL55wucghdAmwQOOxK35P5YhkUfkaSokMYT1wVnC7otaEZSIkhBp70OGsUfJynKKQYUbxcj6VNpi76/7DMU5UUm49tX84orIpu1IseapI3ht7gDdWoUofgCQvd4broCZxHKvkgr0nn3hteNZeZSDD5g6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709773; c=relaxed/simple;
	bh=QHK8Z72uJL0SSMh0ktUYerHH/KE8nlgKIDvUzJ3vtc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buncOck1kFlwlQhne3DbffMCWlYzzjHKm5PrydLhe5Lq3+6WmMN4e9OHFx/R1YcwmoGF0LV4/pDtiKcEawuE+IwEWMtbes0k7DPoEKby2Ddhyj+YAtu1KnV/F7i83nfiAkGeESZ4CYGarzxt/rCkfmGrDeU3pIHswSkH4yO2dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVtI3sVH; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-472e7d23ffeso200830137.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709709771; x=1710314571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ulBOfDA6KKatRNYKBMl/Vz+UTRv4qUu7DN7qV5pdB4=;
        b=nVtI3sVHayTNYMDCK21sViWVVzXlEkRAMyDpA0m022wILD9aJYspHzYjsStsbyPyQH
         8LPGcZoim8gTE5wOZZfMPET7m7NgueHQP6Kwke/RDf9/htphMLtStVquPL9hjtKB9178
         J9SGLLITEga2JLGbhWp92t9WeyxFHjM5046VQG7ofT9jpnDlIrITKgJPEpVg0230dkZO
         TXqCMYmeX03taD+9WkHRViya2IaoxVtzgDoTKQkryZJ8xROlMPWkxJ1KoAiNg14fP1X7
         FtG9ARFsycf7qYp3sJ3D/rvgKeY5UiPkvucVh1+cBD+UEs3ZpTcQnduu94Xha63ENBMF
         PGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709771; x=1710314571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ulBOfDA6KKatRNYKBMl/Vz+UTRv4qUu7DN7qV5pdB4=;
        b=IitM8LAYtp+kjHJJK7+IdEN+J/vpzuEr6uqoskXqKHffcK48lZ8AmYjCjpntYG5qp2
         frmioVs9Z2+7IyK4ejOoKDTwJkfEzOkVISPgqfElWvO7E1bjrIKxAkQMpYImcdhx0gLK
         jD2BTn66WAB0jtHfk16pCB7zfm8R5uBjfC+N8RU3J1hvQAP9jwl6W/9P1GgZ20q8kLVQ
         7L4al1To69TWkukSPA+DYw9HYl90pOvXjUrAJR0jKah4PECz9OkIaKtEMbZTHRNucT70
         lCjRwGgXq3jgZ1ZGCAkY6ny4iNQgvfLgpNbFwHza/8wTtGANF6jE9v6CZQDr709j2um5
         50Og==
X-Forwarded-Encrypted: i=1; AJvYcCXN5OCzrKHj2DVlSUa4LxitvtvgnHIVjRDnMiO4KSpnqMWuEku+BqZoq/dFUIs11yrSKZ4nZ8FUam1kDgpCds4o/Q1EfaIdgDc6FwFO
X-Gm-Message-State: AOJu0YxGTzKG2sKmtes732Wio9sMO1BRGxO/Z69XQ6hroM02Cwu90hMm
	ZbSNn3NX+FSaFwpGAQM/did8creiGURRKldm1dWPYtSz8iJwKXpf7tGYtm3l46srkHe1UeZWB4r
	exzy98pysqZIduPfpz/zW/XKZPlihKxVLhiTfOw==
X-Google-Smtp-Source: AGHT+IF1mkXE/cTsTY/hiUFsCDpenaGNFc93A+ucBcvJUF+nUzX9aZITEoEAcrQBQ+FZrs5ZVHzIV82mbbNltp/O5iY=
X-Received: by 2002:a05:6102:5492:b0:472:60b3:d4a4 with SMTP id
 bk18-20020a056102549200b0047260b3d4a4mr5023876vsb.27.1709709770838; Tue, 05
 Mar 2024 23:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305101745.213933-1-balint.dobszay@arm.com> <20240305101745.213933-3-balint.dobszay@arm.com>
In-Reply-To: <20240305101745.213933-3-balint.dobszay@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 12:52:39 +0530
Message-ID: <CAFA6WYMt1GNzrdkGc6_AU_KSOVaMFK4MONHwmWchzNb97GJWvg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] tee: optee: Move pool_op helper functions
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 15:49, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> Move the pool alloc and free helper functions from the OP-TEE driver to
> the TEE subsystem, since these could be reused in other TEE drivers.
> This patch is not supposed to change behavior, it's only reorganizing
> the code.
>
> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  drivers/tee/optee/core.c          | 64 -------------------------------
>  drivers/tee/optee/ffa_abi.c       |  6 +--
>  drivers/tee/optee/optee_private.h | 12 ------
>  drivers/tee/optee/smc_abi.c       |  9 ++---
>  drivers/tee/tee_shm.c             | 64 +++++++++++++++++++++++++++++++
>  include/linux/tee_core.h          | 10 +++++
>  6 files changed, 81 insertions(+), 84 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index f762e3a25119..39e688d4e974 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -9,7 +9,6 @@
>  #include <linux/crash_dump.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> -#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -17,69 +16,6 @@
>  #include <linux/types.h>
>  #include "optee_private.h"
>
> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              size_t size, size_t align,
> -                              int (*shm_register)(struct tee_context *ctx,
> -                                                  struct tee_shm *shm,
> -                                                  struct page **pages,
> -                                                  size_t num_pages,
> -                                                  unsigned long start))
> -{
> -       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
> -       struct page **pages;
> -       unsigned int i;
> -       int rc = 0;
> -
> -       /*
> -        * Ignore alignment since this is already going to be page aligned
> -        * and there's no need for any larger alignment.
> -        */
> -       shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
> -                                      GFP_KERNEL | __GFP_ZERO);
> -       if (!shm->kaddr)
> -               return -ENOMEM;
> -
> -       shm->paddr = virt_to_phys(shm->kaddr);
> -       shm->size = nr_pages * PAGE_SIZE;
> -
> -       pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> -       if (!pages) {
> -               rc = -ENOMEM;
> -               goto err;
> -       }
> -
> -       for (i = 0; i < nr_pages; i++)
> -               pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
> -
> -       shm->pages = pages;
> -       shm->num_pages = nr_pages;
> -
> -       if (shm_register) {
> -               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> -                                 (unsigned long)shm->kaddr);
> -               if (rc)
> -                       goto err;
> -       }
> -
> -       return 0;
> -err:
> -       free_pages_exact(shm->kaddr, shm->size);
> -       shm->kaddr = NULL;
> -       return rc;
> -}
> -
> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              int (*shm_unregister)(struct tee_context *ctx,
> -                                                    struct tee_shm *shm))
> -{
> -       if (shm_unregister)
> -               shm_unregister(shm->ctx, shm);
> -       free_pages_exact(shm->kaddr, shm->size);
> -       shm->kaddr = NULL;
> -       kfree(shm->pages);
> -       shm->pages = NULL;
> -}
> -
>  static void optee_bus_scan(struct work_struct *work)
>  {
>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index cee8ccb84cb8..3235e1c719e8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
>  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>                              struct tee_shm *shm, size_t size, size_t align)
>  {
> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> -                                         optee_ffa_shm_register);
> +       return tee_dyn_shm_alloc_helper(shm, size, align,
> +                                       optee_ffa_shm_register);
>  }
>
>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>                              struct tee_shm *shm)
>  {
> -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
> +       tee_dyn_shm_free_helper(shm, optee_ffa_shm_unregister);
>  }
>
>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index a0698ac18993..429cc20be5cc 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  int optee_enumerate_devices(u32 func);
>  void optee_unregister_devices(void);
>
> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              size_t size, size_t align,
> -                              int (*shm_register)(struct tee_context *ctx,
> -                                                  struct tee_shm *shm,
> -                                                  struct page **pages,
> -                                                  size_t num_pages,
> -                                                  unsigned long start));
> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> -                              int (*shm_unregister)(struct tee_context *ctx,
> -                                                    struct tee_shm *shm));
> -
> -
>  void optee_remove_common(struct optee *optee);
>  int optee_open(struct tee_context *ctx, bool cap_memref_null);
>  void optee_release(struct tee_context *ctx);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 9c296b887dc1..734c484ed0f6 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -592,19 +592,18 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
>          * to be registered with OP-TEE.
>          */
>         if (shm->flags & TEE_SHM_PRIV)
> -               return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
> +               return tee_dyn_shm_alloc_helper(shm, size, align, NULL);
>
> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> -                                         optee_shm_register);
> +       return tee_dyn_shm_alloc_helper(shm, size, align, optee_shm_register);
>  }
>
>  static void pool_op_free(struct tee_shm_pool *pool,
>                          struct tee_shm *shm)
>  {
>         if (!(shm->flags & TEE_SHM_PRIV))
> -               optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
> +               tee_dyn_shm_free_helper(shm, optee_shm_unregister);
>         else
> -               optee_pool_op_free_helper(pool, shm, NULL);
> +               tee_dyn_shm_free_helper(shm, NULL);
>  }
>
>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 96a45c817427..5bf76c35cd9e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -202,6 +202,70 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
> +                            int (*shm_register)(struct tee_context *ctx,
> +                                                struct tee_shm *shm,
> +                                                struct page **pages,
> +                                                size_t num_pages,
> +                                                unsigned long start))
> +{
> +       size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
> +       struct page **pages;
> +       unsigned int i;
> +       int rc = 0;
> +
> +       /*
> +        * Ignore alignment since this is already going to be page aligned
> +        * and there's no need for any larger alignment.
> +        */
> +       shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
> +                                      GFP_KERNEL | __GFP_ZERO);
> +       if (!shm->kaddr)
> +               return -ENOMEM;
> +
> +       shm->paddr = virt_to_phys(shm->kaddr);
> +       shm->size = nr_pages * PAGE_SIZE;
> +
> +       pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +       if (!pages) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       for (i = 0; i < nr_pages; i++)
> +               pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
> +
> +       shm->pages = pages;
> +       shm->num_pages = nr_pages;
> +
> +       if (shm_register) {
> +               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> +                                 (unsigned long)shm->kaddr);
> +               if (rc)
> +                       goto err;
> +       }
> +
> +       return 0;
> +err:
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr = NULL;
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_dyn_shm_alloc_helper);
> +
> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
> +                            int (*shm_unregister)(struct tee_context *ctx,
> +                                                  struct tee_shm *shm))
> +{
> +       if (shm_unregister)
> +               shm_unregister(shm->ctx, shm);
> +       free_pages_exact(shm->kaddr, shm->size);
> +       shm->kaddr = NULL;
> +       kfree(shm->pages);
> +       shm->pages = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tee_dyn_shm_free_helper);
> +
>  static struct tee_shm *
>  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>                     int id)
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index d9b3ba8e8fa9..efd16ed52315 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -232,6 +232,16 @@ void *tee_get_drvdata(struct tee_device *teedev);
>   */
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>
> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
> +                            int (*shm_register)(struct tee_context *ctx,
> +                                                struct tee_shm *shm,
> +                                                struct page **pages,
> +                                                size_t num_pages,
> +                                                unsigned long start));
> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
> +                            int (*shm_unregister)(struct tee_context *ctx,
> +                                                  struct tee_shm *shm));
> +
>  /**
>   * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
>   * @shm:       Shared memory handle
> --
> 2.34.1
>

