Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF880FA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjLLW6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLLW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:58:38 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5688AAD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:58:44 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b3a8366e13so261504039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702421923; x=1703026723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYI96oaJmpGgcxheV1xw9QQettrzMHe/j2ukeYjaYk=;
        b=M287BWsTBhEpqFXKf8JJuZDW3YuBqwtRUPfWXn/bnfz68g5FCLlZ/jKRUCpK9HeMn0
         00Pvb9OBrSQ5styTk9N2mIZGPNBYrOI6+ZtEwr2LJOLw4BMqUIkFOW4esm2ZZcLsrUoe
         B/hvGBT1LVJXb2V7PbcA93HSovrit/QP0IQs+GQWki98LRzFZwCuMkhNqfZ0jO/jqPUB
         y0b5HX1bjgwmmYMwDgrT9JXHe7l3EWGrI12QoVy7PHiogHfG8qDoNSe4aFrWur+Sg/lO
         HC7n0pRFhx919tWqZ4tHIr6ebSroocU8tXCxqwGAalietlxFveIG+rremI7rWc9mFRu4
         NxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421923; x=1703026723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYI96oaJmpGgcxheV1xw9QQettrzMHe/j2ukeYjaYk=;
        b=TvKyQ0nEdHrjFI5AyXwItEN/LaTd1RHDc0PUKgVnK6pNZK6qQldTXP2RVzmOiL9gVJ
         96XNGvnGgAeuRAB7nKNA5WT3qjL3jMinmlrp46AQBVoKFKcWQGjY1wMQeduqqUNVcH5g
         H4KlUINnkIrrPTREIRnDzMPFARvEaJ8S66B57S2vXxmHN4azRzqlgwY/DfD7Jf16/QhZ
         Q1LRqOSt49f04FbK1AYLNYcvgwVeh8GficoUOwnY3ZJ5X04DnpKfhvYC/x30If27JtOI
         +XBURAQa0ziP/UNEUpSaUgw/CzBLanUbhATsuOLCRQpEkfdz8lZZmEkIBZBSuQK1o4na
         6KHw==
X-Gm-Message-State: AOJu0Yz/yX1nnb7LgT4aonofp1gTN1hZ/XcVJxvUGlQ/aAptnMG1V7LU
        o+2833/lLMfNkJzr2btByM6pOvcrl96SYXrp6qI=
X-Google-Smtp-Source: AGHT+IEo3nL0+BNgvoIK9L9F0jhhXselB23K8CxULJ321pd/RaIoz7l7DofJD7jT38sewomLURycyi2344Fs/iRGr10=
X-Received: by 2002:a05:6602:342a:b0:7b7:5850:7d62 with SMTP id
 n42-20020a056602342a00b007b758507d62mr4505169ioz.19.1702421923589; Tue, 12
 Dec 2023 14:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com> <20231206-zswap-lock-optimize-v1-3-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-3-e25b059f9c3a@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 12 Dec 2023 14:58:32 -0800
Message-ID: <CAKEwX=NpYKqjAg+8oMqGWi_6Ue0ig5dTrCPxhTRWumKkKdXSeg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/zswap: reuse dstmem when decompress
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
> copy the entry->handle memory to a temporary memory, which is allocated
> using kmalloc.
>
> Obviously we can reuse the per-compressor dstmem to avoid allocating
> every time, since it's percpu-compressor and protected in mutex.

Ah this sounds like a good idea. We have to grab that mutex anyway -
might as well use the memory slot that is protected by that mutex.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a6b4859a0164..d93a7b58b5af 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1758,9 +1758,9 @@ bool zswap_load(struct folio *folio)
>         struct zswap_entry *entry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst, *tmp;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       u8 *src, *dst;
>         struct zpool *zpool;
> -       unsigned int dlen;
>         bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1782,27 +1782,18 @@ bool zswap_load(struct folio *folio)
>                 goto stats;
>         }
>
> -       zpool =3D zswap_find_zpool(entry);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> -               if (!tmp) {
> -                       ret =3D false;
> -                       goto freeentry;
> -               }
> -       }
> -
>         /* decompress */
> -       dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
>
> +       zpool =3D zswap_find_zpool(entry);
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;

We're moving handle (un)mapping and the memory copying inside the
critical section protected by the mutex. Seems fine to me -
zswap_store() already did this IIUC.

>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
> @@ -1813,15 +1804,13 @@ bool zswap_load(struct folio *folio)
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> -       else
> -               kfree(tmp);
>
>         ret =3D true;
>  stats:
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
> -freeentry:

So it reduces the chance of zswap_load() failure due to unable to
memory allocation failure? Nice!

> +
>         spin_lock(&tree->lock);
>         if (ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>
> --
> b4 0.10.1

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
