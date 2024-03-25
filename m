Return-Path: <linux-kernel+bounces-118038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08AE88B2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B11C3B20A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AB6F085;
	Mon, 25 Mar 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY7Ucymb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AD481A3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402038; cv=none; b=M21ZMHL4NhriHyqph0Qx0nkKe2+gVNbQofOqiS5RVvAKbXH66KIYChEYxV4C6JKf228xDlrw/iSfsbpwfDKpDw7stTo+q08fdHWIgEt6NapLUY198D76IPlEXUznhwB6INlQT9yDSDCtjAd2cKIHy45yz9/6RWjeNPZbeNSnCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402038; c=relaxed/simple;
	bh=5ctn4tCGtOBPpLyO5cQkET48bTFsSSdnlO7Caok7PN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRitYJZgOzF6rv5OcDDZFgeM0MH7BjDRCnZndK/7xkyr9kK1EqPBelAtZKI7NJC7xyO3hO+JhE4Jfn9jF90+RtYuP4VfohJQeZ9/yqmZpsOICV0XGn2S5Qqk4Oha5mzR/xLmJtpw7XB5jYMc5zC4YhpgYxIV+SfpcthkkCdyVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY7Ucymb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E598C43390
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711402038;
	bh=5ctn4tCGtOBPpLyO5cQkET48bTFsSSdnlO7Caok7PN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eY7Ucymbw8xyt+iJMtV2V6oP4lW1Wb5kBCNA89Gx0Ucv9LpZc/EyX84c5PUXgEGvz
	 rjDYiPuysewZn/PwunU0g3a7Pivmd4TGljiLnJLZ4matF+gxuKDdAIFmO4ijvHRRaj
	 S/2iEbziKH6EnIcm9TNmGW8dTLJYEXqlQ8xalsHdR4dW03NMQhUIYpuOYUPIPmI7ls
	 CAsHWGvejqkiX4QNiLvy+RceJlwAxRuL2UseRoocjOGTQypjgyScMyxgsAkGZR5n7m
	 7SK1MVrVEvK7knkwg8UqI/Dsd7/TyspEW4z/ewJIKus8UR02T8UBQtdxTJfmQBhRqI
	 7k/plhlh146TA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so64446841fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:27:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa/ldg9xOl3xUwsuh46FVfUZu8wwBJyMfRwMfiUT0AL7+XJqauLx5/DOA+4YdYzyo1PJxJHatNLPZxwXI4gpDObW9J8hH2F825wu+5
X-Gm-Message-State: AOJu0YwKY1l9QLDYdlAbiAUxptxgQA9oZ2JCFMruf1+MJfqWOIynWYQd
	DJr7gRxHVXgcV0B/xdCaVRVZiuqj+sjNRb+N8QptUsL5r+JdFWmbCUUvvcuXBxwh55X43dD59kP
	W6oMwFR4dxYit/7joyDHx9i3aQw==
X-Google-Smtp-Source: AGHT+IF7pI04jgEaSWWd2GtNnmxq3xX2vtnRzH2ivXclPvBPUwEX33O7CxGqZ8AjFD6vSqZc2OuXWrHCfqJL+WVzUS8=
X-Received: by 2002:a2e:3111:0:b0:2d6:c0eb:41cb with SMTP id
 x17-20020a2e3111000000b002d6c0eb41cbmr4397935ljx.3.1711402036973; Mon, 25 Mar
 2024 14:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org>
In-Reply-To: <20240324210447.956973-1-hannes@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 25 Mar 2024 14:27:05 -0700
X-Gmail-Original-Message-ID: <CANeU7QmbXQOS19kmyXUY=X+VGpzstNRbWv1k9dhro+OTp6U0PA@mail.gmail.com>
Message-ID: <CANeU7QmbXQOS19kmyXUY=X+VGpzstNRbWv1k9dhro+OTp6U0PA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Barry Song <21cnbao@gmail.com>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 2:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Zhongkun He reports data corruption when combining zswap with zram.
>
> The issue is the exclusive loads we're doing in zswap. They assume
> that all reads are going into the swapcache, which can assume
> authoritative ownership of the data and so the zswap copy can go.
>
> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> to bypass the swapcache. This results in an optimistic read of the
> swap data into a page that will be dismissed if the fault fails due to
> races. In this case, zswap mustn't drop its authoritative copy.
>
> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33erwOXNT=
mEaUbi9DrDeJzw@mail.gmail.com/
> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Cc: stable@vger.kernel.org      [6.5+]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

The change looks good to me. Thanks for the cleaner solution.
It has conflict with the zswap rb-tree to xarray patch though.
I will resolve the conflict and resubmit the zswap xarray patch.

Acked-by: Chris Li <chrisl@kernel.org>

Chris
> ---
>  mm/zswap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 535c907345e0..41a1170f7cfe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> +       bool swapcache =3D folio_test_swapcache(folio);
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
> @@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> -       zswap_rb_erase(&tree->rbroot, entry);
> +       /*
> +        * When reading into the swapcache, invalidate our entry. The
> +        * swapcache can be the authoritative owner of the page and
> +        * its mappings, and the pressure that results from having two
> +        * in-memory copies outweighs any benefits of caching the
> +        * compression work.
> +        *
> +        * (Most swapins go through the swapcache. The notable
> +        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> +        * files, which reads into a private page and may free it if
> +        * the fault fails. We remain the primary owner of the entry.)
> +        */
> +       if (swapcache)
> +               zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> @@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
> -       zswap_entry_free(entry);
> -
> -       folio_mark_dirty(folio);
> +       if (swapcache) {
> +               zswap_entry_free(entry);
> +               folio_mark_dirty(folio);
> +       }
>
>         return true;
>  }
> --
> 2.44.0
>

