Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4E81243B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442922AbjLNBC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjLNBC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:02:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED952DB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:03:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so9823631a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702515781; x=1703120581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji9gsamS820IMXZAe1wwCTwbZsGtkwSCHUz+iDwSsEg=;
        b=iEiopjjOFK0Y3Z5q/75A6BimMJRPELV9YGx+HXiFY3lWPNcx3gwxKDAX4toDNAseYP
         r37cBwpO4hYBUNr4wprw1YW0DwiXg16pDbs5rsxpCmpU8HZ6rNLU7LiTZGDUNhLF0bkm
         hACdcHsCUbM+jDLghlQfBtZLwNO9ZQRXpm1s9LtSahZvJ0RzdDbzjc4TyugeckDJpa74
         IAsSR4ApUxjmLxAf4ofEw9sjqo4Ck5xX36bGo7gE9icXgq7Hkh6hRj6Ug/zvbTljFsK3
         Lrb8xyw6wJmEY02KAdM4Z12nTEWw+rljbR0RMm7A+OlOv+tlXGVGdT1zc06EVBOVP5uh
         qERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515781; x=1703120581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji9gsamS820IMXZAe1wwCTwbZsGtkwSCHUz+iDwSsEg=;
        b=AUmfL30/l6pZ8PYTt6yk7NBLtVk3zTOgVgKerNsSZIflzuPhmn5USOC0FxyVeqRY5S
         Do+6szMLawRBPVaEVcXP1QISe326+TAYaKZbuFELRrs93JcYOPBJwOmlLtJPQyXCuMyf
         65eXeuFDQtusURlwTKVxXuuU0ahMxqfdB/Ardh2eQPM/jffFpbTTgOkFaiIzrp6SkDor
         ttqj1hENxbBSGJC4bw7Bk4I1+tciwv9EyaBAs6LVhFBDxMlKXhKGqotsqjQuYQc8gmlY
         pt8dcAibXssOrOcYq+fy85pPObYKn9Mu+dlmMBA4gSZ4utKDCM4dSZglF98/WSjPyNBf
         b9fA==
X-Gm-Message-State: AOJu0YxYZpp7kwTTB7mpT6OPSQOKy5KgFfKkCk8p45QRHSRq/Jr5r9iy
        Yx3WWUeHk/E91dV1bLb89bNYkSSV5pbubjdVuONlwQ==
X-Google-Smtp-Source: AGHT+IGCXp7l+p2bw8UolM3Tbii6wJqMr6qwWmsomfLuAeWAjCiDqNL4k8KSR2pS0iCrVkRB2e0jYH061csNxiP07qQ=
X-Received: by 2002:a17:907:86a4:b0:a19:a1ba:da56 with SMTP id
 qa36-20020a17090786a400b00a19a1bada56mr5588649ejc.125.1702515781311; Wed, 13
 Dec 2023 17:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 17:02:25 -0800
Message-ID: <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Also after the common decompress part goes to __zswap_load(), we can
> cleanup the zswap_reclaim_entry() a little.

I think you mean zswap_writeback_entry(), same for the commit title.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0476e1c553c2..9c709368a0e6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1449,7 +1449,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         struct page *page;
>         struct mempolicy *mpol;
>         bool page_was_allocated;
> -       int ret;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
> @@ -1458,16 +1457,13 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated,=
 true);
> -       if (!page) {
> -               ret =3D -ENOMEM;
> -               goto fail;
> -       }
> +       if (!page)
> +               return -ENOMEM;
>
>         /* Found an existing page, we raced with load/swapin */
>         if (!page_was_allocated) {
>                 put_page(page);
> -               ret =3D -EEXIST;
> -               goto fail;
> +               return -EEXIST;
>         }
>
>         /*
> @@ -1481,8 +1477,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) !=
=3D entry) {
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(page_folio(page));
> -               ret =3D -ENOMEM;
> -               goto fail;
> +               return -ENOMEM;
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1503,15 +1498,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         __swap_writepage(page, &wbc);
>         put_page(page);
>
> -       return ret;
> -
> -fail:
> -       /*
> -        * If we get here because the page is already in swapcache, a
> -        * load may be happening concurrently. It is safe and okay to
> -        * not free the entry. It is also okay to return !0.
> -        */

This comment should be moved above the failure check of
__read_swap_cache_async() above, not completely removed. With that:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Feel free to squash this patch into the one creating __zswap_load() or
leaving it as-is.
