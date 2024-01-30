Return-Path: <linux-kernel+bounces-44915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22A842906
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1525283F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2D1272CA;
	Tue, 30 Jan 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaBLD1//"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9928612D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631861; cv=none; b=hBb/Ix8nJthMMjnkzg/IEl9baEDDgCerrqvHEp4MeWxlMsAx1LNu1eiOpGkI9l/jpvQZJq1YcxHYjmTYD8/Eev65fW6PuFhWElFhuwGfwt4vnpX1j4qp55wG9ISZ0nsNDfPOqJEaTaeFfxIHBaSk4oWrj8BosZTMF+ZQyU4Kqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631861; c=relaxed/simple;
	bh=lV6EKe1I+XkO7pZy2o93mHyRnJfNobhhVULqs638RuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdROG+icR8Lr/4AbNW6kJBoyzoTLH0oplcHjD+y7Vns+iRg6kH2IcoYY79ksxWFBMPscW07zEIHSnLDhrO9Mgoilfq41AF84F3vMdjTuytmbMYPPmn2kMnwJkPkZTm/T5FXwIX6f68qTu9FjJzz2ui6nXqaRJZJUX6smo5ZjF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaBLD1//; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-363890b20dfso5358325ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706631858; x=1707236658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dba6uelI/Pt12oWUnYeD+Bi5QPsgCSQU0LSONHBBbbA=;
        b=SaBLD1//o+MomKY/gQm8iryKE6hiiuXttn63Z7nvjqJD3PtSK4T4rNhAKbY17i4z2/
         AZZKFh7ShqaTixdMMuOnRW3QvIMrC/PP4e2Mu3dtpXtjIagP+pL/FYYf3zdaMuqcC+61
         e6J+cvMqz0IttxTxBU+HBe2IP+pns1rPiI3wDDgujMNKUR+XqusbdraW+MU9aYc9nPXt
         xQdB+a+vEUjZcqkyStpWi1xKfpGauhF404c35g5PT6k1GnUTRVrsBe9AfI9G+siNNkMz
         /0e2Qx1nPrimklaZsmcwQHfFcNubVc3ZiqYHcelX7zOjg7LoKYXrKyX/glnHi0bhE0VZ
         A43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631858; x=1707236658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dba6uelI/Pt12oWUnYeD+Bi5QPsgCSQU0LSONHBBbbA=;
        b=jzXccLON1OLef4WpSMGbMktl1I++aLztlr0nMblSwX5R03nO5OgvBTUgS1BUPKmD5Q
         piGSeQLw1iMhqudIF17nOhxgaO/n1opkO/o082Q/IZRwgMzAlvEVuslT3T+X0zcylD6r
         aZexSGfhKO3Feqlgv00U1vWLPJ8X6XaCAyUhhiIinJxw4G1qxZVLTfns0Vgq6WaoGWQh
         CNCIXys9BnFaI1/piO3zlvvXX8tH5kRnmBtZ2fTcvTiQEuJ3ZdpiLixL3KSn4bjREbd7
         tE7KLzryPoxIAvJUvv1H2BLPimCQSLC7A0gWpnFrW2cdErOkX3VfDQe+r4a67wrKpbum
         7anQ==
X-Gm-Message-State: AOJu0Yzk8Jz+/WLgz7wnX1iToOiCQ7RnsBPIqMuVJg8d3tjgsKhb/GYa
	hNgXQWoizanJLpasSasKfo/ulttjBtCANWAjTWd+xcI8m/hG2FWMbTD/LpIOxgADogpT9U+yVrM
	liMLmmMTiPSt9Yh6MNuq6UnKdKtY=
X-Google-Smtp-Source: AGHT+IGpe7HgiUvf/Lj799SoBnc5h/K070DePQI0aL08WWLNad0H/Pod83NcS7YC2j8iLS1GaKYNcUbZJVD+Wkt6vlE=
X-Received: by 2002:a05:6e02:1d8a:b0:363:7d74:a780 with SMTP id
 h10-20020a056e021d8a00b003637d74a780mr8678717ila.23.1706631858553; Tue, 30
 Jan 2024 08:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-3-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-3-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:24:07 -0800
Message-ID: <CAKEwX=OcjhqjjZ9yYd38oNgk56q41qUt8_gJMjyRw=VCqveReA@mail.gmail.com>
Subject: Re: [PATCH 02/20] mm: zswap: inline and remove zswap_entry_find_get()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> There is only one caller and the function is trivial. Inline it.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 173f2e6657de..cf864aaa214d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -559,19 +559,6 @@ static void zswap_entry_put(struct zswap_entry *entr=
y)
>         }
>  }
>
> -/* caller must hold the tree lock */
> -static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
> -                               pgoff_t offset)
> -{
> -       struct zswap_entry *entry;
> -
> -       entry =3D zswap_rb_search(root, offset);
> -       if (entry)
> -               zswap_entry_get(entry);
> -
> -       return entry;
> -}
> -
>  /*********************************
>  * shrinker functions
>  **********************************/
> @@ -1708,13 +1695,13 @@ bool zswap_load(struct folio *folio)
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> -       /* find */
>         spin_lock(&tree->lock);
> -       entry =3D zswap_entry_find_get(&tree->rbroot, offset);
> +       entry =3D zswap_rb_search(&tree->rbroot, offset);
>         if (!entry) {
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> +       zswap_entry_get(entry);

Neat.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> --
> 2.43.0
>

