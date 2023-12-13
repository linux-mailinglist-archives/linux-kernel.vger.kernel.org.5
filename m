Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011D78122CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjLMX17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:27:57 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6230A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:28:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b701b75f36so292970939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510083; x=1703114883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCQLPrefVcHlxEB9xcYo+7fvtFuP79Fvjg4xN8jDkH8=;
        b=gsa8cXysnqjFcQemv/MsRV7SRTu/zQtktUw2SDSEtmJfo2jvAt6AnYQSHj54qQzdBL
         zwvdwxLVxjrFZp1GspKMnHuXGCn++nJ6uXwG4z2oEiN1P7cLFC8ffKR1Ad4UatrZm3DB
         YEuflZQigrBqlehAMiro++Rx6C4WaT9J13KbTmJtiEcbXKYjonX49c76Z1fBv25iIs4S
         axir1HOB/claZquc57Uyohlt248gGK8MNaji2+4uMl7OHsA0wf6bLyxA34DOjqxx9j/1
         AezXKAxkaDy96Hk2YkQDJTvdFA8d827MccMNoLQDrYViGD2O8H6sXtLLczFo2LRrsu7F
         u3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510083; x=1703114883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCQLPrefVcHlxEB9xcYo+7fvtFuP79Fvjg4xN8jDkH8=;
        b=IsvClSIMxToByYjtsZXLtoMJEG3kftVPCw56bn8NgW3ZVaIpsbDRTbwrsPIKmN7Kc4
         rKmgiY3VvsuUORpV3QAnvKh8qlEo1cdvO++6sqTI6hWf+IVvQ4SyoB9Wi3njL0T4Y9HR
         E3mEocIpU0pqkBD3+RDykWXH7H65aklgzgYtu3JfDEsS3VETkrHGMy3MBq/7bt6BmY5v
         Gmh1cnyoKLKD+vMYehCdSP4IZsLQhUlFk2hPtIU2ginee2P8R7vRdAWKocldX1uInrPC
         INlyK0RubOUQRkl696afYSD9ueYEqMnX50PzWW5MMOOdElFbxKkFd9/jTvwsp3tw1a11
         r4xw==
X-Gm-Message-State: AOJu0YwQKB1fU3UX3ZH/o3EYnXo9qU1QNhFAvA/uzQDxFPNGyXlMM71M
        wp4hknjEL/I/Wo5jXxra/WUTKptRUgBPhYEsv3IISzF6b14=
X-Google-Smtp-Source: AGHT+IFThW4wWQCZmeA9BepKM0r57vtZa6lcWFu91dKLYn+swsEtDUm+7sVntK3LyATSpIVpSmEu62ohVzWlfaXGr+s=
X-Received: by 2002:a05:6602:3352:b0:7b7:3ba4:8944 with SMTP id
 c18-20020a056602335200b007b73ba48944mr9287398ioz.16.1702510082968; Wed, 13
 Dec 2023 15:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 13 Dec 2023 15:27:51 -0800
Message-ID: <CAKEwX=NnURt0_Ub-5as+N6dz4Y23u2mEUaBRnaj3Gfh0RcvXOQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Also after the common decompress part goes to __zswap_load(), we can
> cleanup the zswap_reclaim_entry() a little.
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
> -       return ret;
> +       return 0;
>  }
>
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
>
> --
> b4 0.10.1

LGTM. The fail label was primarily to free the temporary memory. Since
we're re-using dstmem, this isn't really needed anymore. Nice cleanup.
So, FWIW:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
