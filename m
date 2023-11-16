Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8755C7EE0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjKPM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjKPM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:28:50 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7D187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:28:47 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4acf9dd3d35so327037e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700137726; x=1700742526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzQBXso3bqrccwF0VtaA0JDZLW259lYTZ8PxDTsTutk=;
        b=zhKVF90zUXG1FvICnpwQNT3BIgxJte0Ceqo3fENNo7iPmpus4LQsJRQ5ohKIegVRyp
         4eA08UW7zOePDD/5gNEOToo/ll4qUj2pf/todvDmMhE+tdag1EQMRjawDO4rN96JJK9F
         FKuE6XIEu2IhzJVGj88ochUC5B2jWSsln4OGB6PAi2zkUyIcW3ETJZ3cyAfBvJbwZFCH
         PyhyBcRE/y0B7S+vZ6fzfWe1sH4L3vpIx3c0DG0mAoC7TV6Y7uJxwCbLqynh414e505m
         l80u61rodfMOxnJSXOLwv33QJ1KQfrwb0d7WTLqQyQWwWzrpIMki0sj4qLDC38yaRxaP
         uiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700137726; x=1700742526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzQBXso3bqrccwF0VtaA0JDZLW259lYTZ8PxDTsTutk=;
        b=WXF0s8WhJcStbBg2iYYrg7JbINe1bIQCTl+N3xNiRDa74oK5wUTorqFKEl7b2GYQtT
         gmznERN57/AElIixJm24zPkmdW/E0eAzQ8J7Bkh1ePQlhCJmzKpwrNW9tSG66r9xP9pg
         xEVjsXIgQtb1d49+0YUQtIgVtsQMAoURrI3LkxYCLPeB/8/qZUi2nDU/z/P7kKZwrfY2
         QUZtCdHM3SVHxyaUpMqp2GdWxNu6aUudFCzvIwbjBwNxPW9nDk8pP+Hxsf4yjRqFU/+2
         DPSn3inWVR3hdIwkSuoC49I1YMohjwTDVMb3rf1lMnxihMhzmLY7Pg1NKyDmJHxvcvxO
         PzyA==
X-Gm-Message-State: AOJu0Yzu8jwGdS9LWjRYd7bbg5RcC8HaTAZywkzdvCQr6ecoTTZum9Gt
        qdvK1Wj8UUXpFLIPWtra3l08aI+0SrPFPTyM/aZTfA==
X-Google-Smtp-Source: AGHT+IH543TTj3PDoNs3KNT6Dx9KM215+s3wImnd4gcGciJ6TjasdcGeHtZjbvWgXEsbYdXknhhThS3ZF+C94Zm8Y50=
X-Received: by 2002:a1f:9c8c:0:b0:49a:9146:ec02 with SMTP id
 f134-20020a1f9c8c000000b0049a9146ec02mr14464019vke.1.1700137726522; Thu, 16
 Nov 2023 04:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20231114095217.1142360-1-jens.wiklander@linaro.org> <20231114095217.1142360-2-jens.wiklander@linaro.org>
In-Reply-To: <20231114095217.1142360-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 16 Nov 2023 17:58:35 +0530
Message-ID: <CAFA6WYOUZBLtkoy6fpsARYN==Eqr7JymskYDTxbvxxkUjEprfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] optee: add page list to kernel private shared memory
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:22, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Until now has kernel private shared memory allocated as dynamic shared
> memory (not from the static shared memory pool) been returned without a
> list of physical pages on allocations via RPC. To support allocations
> larger than one page add a list of physical pages.

Although this patch looks like a good cleanup, I can't find an ABI
change here. Wasn't a list of pages returned earlier too?

-Sumit

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c    | 28 +++++++++++++----------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
>  2 files changed, 37 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a258bd3b6b5..38ea2fecfc2e 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                                                    unsigned long start))
>  {
>         unsigned int order = get_order(size);
> +       unsigned int nr_pages = 1 << order;
> +       struct page **pages;
>         struct page *page;
> +       unsigned int i;
>         int rc = 0;
>
>         /*
> @@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>         shm->paddr = page_to_phys(page);
>         shm->size = PAGE_SIZE << order;
>
> -       if (shm_register) {
> -               unsigned int nr_pages = 1 << order, i;
> -               struct page **pages;
> +       pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +       if (!pages) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
>
> -               pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> -               if (!pages) {
> -                       rc = -ENOMEM;
> -                       goto err;
> -               }
> +       for (i = 0; i < nr_pages; i++)
> +               pages[i] = page + i;
>
> -               for (i = 0; i < nr_pages; i++)
> -                       pages[i] = page + i;
> +       shm->pages = pages;
> +       shm->num_pages = nr_pages;
>
> +       if (shm_register) {
>                 rc = shm_register(shm->ctx, shm, pages, nr_pages,
>                                   (unsigned long)shm->kaddr);
> -               kfree(pages);
>                 if (rc)
>                         goto err;
>         }
>
>         return 0;
> -
>  err:
>         free_pages((unsigned long)shm->kaddr, order);
> +       shm->kaddr = NULL;
>         return rc;
>  }
>
> @@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                 shm_unregister(shm->ctx, shm);
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>         shm->kaddr = NULL;
> +       kfree(shm->pages);
> +       shm->pages = NULL;
>  }
>
>  static void optee_bus_scan(struct work_struct *work)
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index d5b28fd35d66..b69410c7cc0a 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                                           struct optee_msg_arg *arg,
>                                           struct optee_call_ctx *call_ctx)
>  {
> -       phys_addr_t pa;
>         struct tee_shm *shm;
>         size_t sz;
>         size_t n;
> +       struct page **pages;
> +       size_t page_count;
>
>         arg->ret_origin = TEEC_ORIGIN_COMMS;
>
> @@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 return;
>         }
>
> -       if (tee_shm_get_pa(shm, 0, &pa)) {
> -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> -               goto bad;
> -       }
> -
> -       sz = tee_shm_get_size(shm);
> -
> -       if (tee_shm_is_dynamic(shm)) {
> -               struct page **pages;
> +       /*
> +        * If there are pages it's dynamically allocated shared memory (not
> +        * from the reserved shared memory pool) and needs to be
> +        * registered.
> +        */
> +       pages = tee_shm_get_pages(shm, &page_count);
> +       if (pages) {
>                 u64 *pages_list;
> -               size_t page_num;
> -
> -               pages = tee_shm_get_pages(shm, &page_num);
> -               if (!pages || !page_num) {
> -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> -                       goto bad;
> -               }
>
> -               pages_list = optee_allocate_pages_list(page_num);
> +               pages_list = optee_allocate_pages_list(page_count);
>                 if (!pages_list) {
>                         arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
>                         goto bad;
>                 }
>
>                 call_ctx->pages_list = pages_list;
> -               call_ctx->num_entries = page_num;
> +               call_ctx->num_entries = page_count;
>
>                 arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
>                                       OPTEE_MSG_ATTR_NONCONTIG;
> @@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_list) |
>                         (tee_shm_get_page_offset(shm) &
>                          (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> -               arg->params[0].u.tmem.size = tee_shm_get_size(shm);
> -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>
> -               optee_fill_pages_list(pages_list, pages, page_num,
> +               optee_fill_pages_list(pages_list, pages, page_count,
>                                       tee_shm_get_page_offset(shm));
>         } else {
> +               phys_addr_t pa;
> +
> +               if (tee_shm_get_pa(shm, 0, &pa)) {
> +                       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +                       goto bad;
> +               }
> +
>                 arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
>                 arg->params[0].u.tmem.buf_ptr = pa;
> -               arg->params[0].u.tmem.size = sz;
> -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>         }
> +       arg->params[0].u.tmem.size = tee_shm_get_size(shm);
> +       arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
>
>         arg->ret = TEEC_SUCCESS;
>         return;
> --
> 2.34.1
>
