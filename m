Return-Path: <linux-kernel+bounces-34238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72483761A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463DF1C23F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2E11C8D;
	Mon, 22 Jan 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaXlsHjq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600210A04
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962721; cv=none; b=vAkeODrq2U6Xq1GoTOV6rD8000xfTvmVU+tPn+ABYo7l0TjHEtj2XRo55JsVzVVCaMHIWiyQNz49HjmULp2tIVGfFApp8uXdOJJ6ytxje5no0IkmG8mbZphr01NPJu9+fTBzZ/D5dbKfK2kxnvcS9hZqvGwL0AtSqzGe5uy3HEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962721; c=relaxed/simple;
	bh=ofMSKFhK198vEBaAAdyZGDEL17Gv+3HRdmRskVVZmhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfkD+IcuSUQhMoJjiW/XvEy49X84U90mL0/Xh/02REFOOE/XsdHuNRiYItOiIeC9+SsauKh3HXwBa6Z9+Bc4/Wt3WbV09kmGA24FaWko4fXaVNFCwd0TZePEv1yTKUlUrjs3LwEP+xz3ZmOf4X4PLtB7JpjUTkXQGlQkv0TgAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaXlsHjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA7CC433B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705962720;
	bh=ofMSKFhK198vEBaAAdyZGDEL17Gv+3HRdmRskVVZmhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KaXlsHjq7YSgNa4NvoBuBMiR2XWMa9/8iYk44I1UEaODSgn9wxqjhtrtah13UT/tx
	 6CHcsbcuW+EwPbnCeHCSAT38qy6ENGrtBLYqM1IeCGbf1U/AIJJFk/rNcZoHQEb8CZ
	 ee7y4Jc3wYpeZ4iCv0TxYb0jiUgRylQnpvpgP3AfmV9Q4RMPy0McUPMLiwigX5hkh4
	 d3+x5ML3P44HEVir/bVgeywCnJIYTPrPOt1G34cc700tHwYKOAKisO3ct3s5mECfnP
	 dFq+4syZdzzZn8tA3aR9bb0258AUzOJInG4nKb5MEefa9Rv2LGr48AO2Z/OglMMRMf
	 pniEKb+ET3aVw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso46353001fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:32:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxPBvrG8ENeB3NSZj8w1Jj036oPYplYBKtlTOcA1lCKVarrQBYY
	fzXCKpuuoZbrQytC1q93M8AJ6KoOwW6bcFTxiEA0KlvVs18gq1EeKjvwHUnnPpKeXaotT6FIg4Z
	egnNvmKZUaSgFElvgoBqd862f+Q==
X-Google-Smtp-Source: AGHT+IHJqbM48hx+HKEh4yWlPV8GWiN1SewFfLmZ6Pj2JL2rUrx960kMMAK7lYnUJ2Z9fXBulsE9a+1No6B3gttTksQ=
X-Received: by 2002:a05:651c:19a6:b0:2ce:f8d5:7750 with SMTP id
 bx38-20020a05651c19a600b002cef8d57750mr1815609ljb.11.1705962718823; Mon, 22
 Jan 2024 14:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com> <20240120024007.2850671-3-yosryahmed@google.com>
In-Reply-To: <20240120024007.2850671-3-yosryahmed@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 22 Jan 2024 14:31:46 -0800
X-Gmail-Original-Message-ID: <CANeU7QkdVX0rYZS+QLv58L+zP5ZrHiGjrhxjMuA21o++QTW1nA@mail.gmail.com>
Message-ID: <CANeU7QkdVX0rYZS+QLv58L+zP5ZrHiGjrhxjMuA21o++QTW1nA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:40=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> called for all swap entries before zswap_swapoff() is called. This means
> that all zswap entries should already be removed from the tree. Simplify
> zswap_swapoff() by removing the tree cleanup loop, and leaving an
> assertion in its place.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> Chengming, Chris, I think this should make the tree split and the xarray
> conversion patches simpler (especially the former). If others agree,
> both changes can be rebased on top of this.

I was wondering why those need to be there if all the zswap entries
should have been swapped in already. In my testing I never see this
delete of an entry so
think this is kind of just in case. Nice clean up and will help
simplify my zswap to xarray patch. Thanks for doing this.

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

> ---
>  mm/zswap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f8bc9e0892687..9675c3c27f9d1 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1790,17 +1790,12 @@ void zswap_swapon(int type)
>  void zswap_swapoff(int type)
>  {
>         struct zswap_tree *tree =3D zswap_trees[type];
> -       struct zswap_entry *entry, *n;
>
>         if (!tree)
>                 return;
>
> -       /* walk the tree and free everything */
> -       spin_lock(&tree->lock);
> -       rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbn=
ode)
> -               zswap_free_entry(entry);
> -       tree->rbroot =3D RB_ROOT;
> -       spin_unlock(&tree->lock);
> +       /* try_to_unuse() invalidated all entries already */
> +       WARN_ON_ONCE(!RB_EMPTY_ROOT(&tree->rbroot));
>         kfree(tree);
>         zswap_trees[type] =3D NULL;
>  }
> --
> 2.43.0.429.g432eaa2c6b-goog
>

