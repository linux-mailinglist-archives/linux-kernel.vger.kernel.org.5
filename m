Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFA7EB56B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjKNRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjKNRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:16:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132BF1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:16:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e8b36e36e0so368858566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699982200; x=1700587000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAVNf+jCyvS75fkl/2NtoKz0DKo34v5WTcJW0Y9PyNU=;
        b=WX/8S6r5CDImn7t9gDH0KidZmrvIvXcmXu2Y2Q/LiyPMO11jpxAhvYBhi/ACgohtdN
         4SuhE2VLlf9PkbZIer8KGFezXcvu7jWqvrIHqIlmdmIYQiPfaoKA9ZnX41n96KZSmbgL
         bGs8ZJKAOQMU3e8MzI/rUhn2em13qHual/UYihE4ev9Rc9PEXTpg+VEdbFNKAfGyLxY+
         bDaBQMYftccYx4oBBUsIEUSSF3X7VrHw7zbfrh0H4GRnWEFp6OrE5zSGg3OaIUyQ172T
         g0Ke7j7xLpAmJIDSZdFouQ5pAJF6k4XdMW9kQUvMTGeCtKg0OkHgHGElA+A1AydYkclw
         FlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982200; x=1700587000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAVNf+jCyvS75fkl/2NtoKz0DKo34v5WTcJW0Y9PyNU=;
        b=Y1m0I3M6AlIQUeoAxLoMdXntE7tC4bPrjbVakvrcZ1OEF3PVlB0r5Db7SzzfjS9h+o
         y3Ldvk9WSuKVWjDuLfgZkdYiEoDOPBMxvuZdW6cWW3ZKAm2bj5rycGOYCiJuhWLoUtsm
         4i6ll5oLzBzR//qqJ0ivr22ZcvfJDwgpsrEXEP2mIB1a4ygswg8gaWUq3jRtj4w9AO7u
         PPyxgxSTkWtrQFwPCE1nqCqoNbxfvG3In2xQx+0v16gtKwaYA4Gd9oNaXjsEfXn0k6Pq
         Kfrq2PT8CNpGaLfE/ftnBTye44b2uAYEMiusCPPHUSMUY8gZy3ZJi5F7q+kJyoNj8qdw
         5akQ==
X-Gm-Message-State: AOJu0Yxx3xYQfbvzQwK/8IPDPEk9fRvustj9ZG/9yrc7qDHs7ILQWtmD
        YJnH+FNgVaRhyVwEEbC6mgU2GkBGy19EUhNM5W9TpQ==
X-Google-Smtp-Source: AGHT+IFl7JJuXtCC8JLjhkYFV4WBpMBnFEg5b5Xq+prOKKPQuzAcPjz8Bx8Mw0CAsJmq/tHmtx/SIJkiH9H2h7A0oKg=
X-Received: by 2002:a17:906:6d11:b0:9d0:2da2:ee64 with SMTP id
 m17-20020a1709066d1100b009d02da2ee64mr7685273ejr.70.1699982199571; Tue, 14
 Nov 2023 09:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Nov 2023 09:16:00 -0800
Message-ID: <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ying

On Mon, Nov 13, 2023 at 5:06=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> I recently found two scenarios where zswap entry could not be
> released, which will cause shrink_worker and active recycling
> to fail.
> 1)The swap entry has been freed, but cached in swap_slots_cache,
> no swap cache and swapcount=3D0.
> 2)When the option zswap_exclusive_loads_enabled disabled and
> zswap_load completed(page in swap_cache and swapcount =3D 0).

For case (1), I think a cleaner solution would be to move the
zswap_invalidate() call from swap_range_free() (which is called after
the cached slots are freed) to __swap_entry_free_locked() if the usage
goes to 0. I actually think conceptually this makes not just for
zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
Slots caching is a swapfile optimization that should be internal to
swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND
not in the swap cache), all the hooks should be called (memcg, zswap,
arch, ..) as the swap entry is effectively freed. The fact that
swapfile code internally batches and caches slots should be
transparent to other parts of MM. I am not sure if the calls can just
be moved or if there are underlying assumptions in the implementation
that would be broken, but it feels like the right thing to do.

For case (2), I don't think zswap can just decide to free the entry.

In that case, the page is in the swap cache pointing to a swp_entry
which has a corresponding zswap entry, and the page is clean because
it is already in swap/zswap, so we don't need to write it out again
unless it is redirtied. If zswap just drops the entry, and reclaim
tries to reclaim the page in the swap cache, it will drop the page
assuming that there is a copy in swap/zswap (because it is clean). Now
we lost all copies of the page.

Am I missing something?

>
> The above two cases need to be determined by swapcount=3D0,
> fix it.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  mm/zswap.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..db95491bcdd5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1063,11 +1063,12 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         struct mempolicy *mpol;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> +       struct swap_info_struct *si;
>         struct zpool *pool =3D zswap_find_zpool(entry);
>         bool page_was_allocated;
>         u8 *src, *tmp =3D NULL;
>         unsigned int dlen;
> -       int ret;
> +       int ret =3D 0;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
> @@ -1082,16 +1083,30 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated)=
;
> -       if (!page) {
> +       if (!page)
>                 ret =3D -ENOMEM;
> -               goto fail;
> -       }
> -
> -       /* Found an existing page, we raced with load/swapin */
> -       if (!page_was_allocated) {
> +       else if (!page_was_allocated) {
> +               /* Found an existing page, we raced with load/swapin */
>                 put_page(page);
>                 ret =3D -EEXIST;
> -               goto fail;
> +       }
> +
> +       if (ret) {
> +               si =3D get_swap_device(swpentry);
> +               if (!si)
> +                       goto out;
> +
> +               /* Two cases to directly release zswap_entry.
> +                * 1) -ENOMEM,if the swpentry has been freed, but cached =
in
> +                * swap_slots_cache(no page and swapcount =3D 0).
> +                * 2) -EEXIST, option zswap_exclusive_loads_enabled disab=
led and
> +                * zswap_load completed(page in swap_cache and swapcount =
=3D 0).
> +                */
> +               if (!swap_swapcount(si, swpentry))
> +                       ret =3D 0;
> +
> +               put_swap_device(si);
> +               goto out;
>         }
>
>         /*
> @@ -1106,7 +1121,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(page_folio(page));
>                 ret =3D -ENOMEM;
> -               goto fail;
> +               goto out;
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1151,7 +1166,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>
>         return ret;
>
> -fail:
> +out:
>         if (!zpool_can_sleep_mapped(pool))
>                 kfree(tmp);
>
> --
> 2.25.1
>
