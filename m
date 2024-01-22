Return-Path: <linux-kernel+bounces-34176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC743837525
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB701C23D27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F284879A;
	Mon, 22 Jan 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAIqIXqo"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9124878C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958524; cv=none; b=Z/DyYG3NfqTOyYkQpgX0glbh9KWJ5jd2ysFk5jlKmHstCNA/0QUQAIYk47KcISxUqQ+sO+Hsll9+XLcE0vvrlc1YzF11Jq+XCvdYWviT8Qtf4ERcU5qyiA9fyTey0YWykPGLKkoWG7EXxWUsdfgnTV20EU8b2znJlicDSw0iHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958524; c=relaxed/simple;
	bh=pLoVzKrJkz7ffzxvQ4WrwdjXabs4IMmp0KiOtzfxPzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSzEOM33bn3xquSXbMBUsees3yHqSQ6pWdr0lOItLlFDRbFWBjoaSnObNdvrvkvjXYo4sDBh+PySo6KRgWOpsFAEAnkgh9rHrx7kDpAa0b7IyopBjrKXclr0O6cYsm2Nqsb/VdwjnKTgYYLuj3mwslKwG08D6gTLUOxIbfQygdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAIqIXqo; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bf2ab2c4caso144958839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958520; x=1706563320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2XOI0NMjef1ZYVplLac7re7Ka9S53/xQ299RZ4EXi8=;
        b=YAIqIXqoh8MjGMo7Q9IrPEmJgLp6V1584FoUJuGg6N/66cX184hkfnDyTyR5Lf9yua
         hfZ0bnrk6MAEL7rqKRDQSgmDgmp6bohjQ4y8ZQ98AaENNdNCOCN2yY+rPImWgPt2tSyc
         FB2OF3k0XliBd+dN0gY1MbMLL435iLs2Bj3siYH4hMS2uuJLlh308iPzrXXUKW4CuEmH
         4JWmm3V9KCoKtPlbB1NkZRzwooCVdpPzrQ3aGfVx97bf3BrYFzalPpBk2OqY8wHLAMBC
         aCvclOEsI/dpJHEPg9EnuCwtRnNFUCKla6mG0zUb2hWRaXYF8eIXzsa1XEzsphPyIAeR
         eI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958520; x=1706563320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2XOI0NMjef1ZYVplLac7re7Ka9S53/xQ299RZ4EXi8=;
        b=hett3qpvgdkzb/wb6oLFClKPKqBSiv/ENigVXckmcAnFqwvO+KUl1YA1ltiomXhcvQ
         jeDvnKM4MEdCnRZNhfo3IJlGhc9DovdlcG4hvjDKeIDR78h6Qozn911KetmroVN2H+M7
         fNsMwdS9dwVKWAYZlQVQcJloY3jqqW3VsszMWWWs4yEudjCJdQBhlCL76XOF8PYfzRBC
         HKRfqysp6izoAuPDPoXui588lGhqZ9q0VrBtHfS4CwgH+oaD7ZcrrnYbdvp77CrTCuVH
         xNOwhqOAd8AKFiD2kB7NUv7t1vbDB8nW3UwnxSQfdAM6xaX9wbxZPQ8hKk/5u88Frhxw
         nhZQ==
X-Gm-Message-State: AOJu0YxQtbh+DmzBkFIsH7x2xvuimjKPPjLz3n4UEwSllgUKo7TcwNj8
	mrpHdimnPS+2yIziBMiIY52XCWfp0fY+DGy3bdkEHt32r5bsgi904d8NBLFxCs5HRe9dF5jje3b
	+EjZ1SdbRz7/8CUaH115gFHXQmTg=
X-Google-Smtp-Source: AGHT+IH3pjoNgX5d01NdPGZf4VD9LwjjUINwgfSHJD7ey9x4XFZxpUj0eVqYnRuZe2QrYd/fEjzz5GuANi4KMhcJo0w=
X-Received: by 2002:a5d:8e0b:0:b0:7bf:8e8d:3412 with SMTP id
 e11-20020a5d8e0b000000b007bf8e8d3412mr5904993iod.20.1705958519832; Mon, 22
 Jan 2024 13:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com> <20240120024007.2850671-3-yosryahmed@google.com>
In-Reply-To: <20240120024007.2850671-3-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 22 Jan 2024 13:21:48 -0800
Message-ID: <CAKEwX=MFYpSv26X_XO7cvH0vbGX70FNGK1ZaBgNm+7wKGDAfAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
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

Oh man this is sweet! FWIW:
Acked-by: Nhat Pham <nphamcs@gmail.com>

