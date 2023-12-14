Return-Path: <linux-kernel+bounces-203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422C813D69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465091C21E53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA13FE5B;
	Thu, 14 Dec 2023 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5owp0Ma"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D08944C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4662a125b64so19586137.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702593723; x=1703198523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTV9Y9MaaXX2DDdqBdZh/37gFFt+TicObNRgfbQpB+c=;
        b=k5owp0MaQnKWOpd0IsMjN1mb1b6ZdlVn8VubLJl9I3K98Qrj+vUacQmdEOGVBag+Gb
         9Y5/xg9sAJXDQlelIdE03Ir1ZbgGaUXGBpt2ZKjG2p94i6VqVqnQ6gIrGd1+5w3GmGHs
         TXmQk8FL9d2S/SK+eSP6lmsVtnHQd6qGloAVj6fmrNV+YJ4MzDMkVj4q6iOQHrFibrh8
         JeWjCFrTDyxfUH78/O7SgJfmPGhLRJSCwButsMS1JPS26eZdLPfbiRKrvofvzwuoaqDn
         d08YwQcSqdcae7yIL7iPwHjuBFlclVIdzUOdGUfd0MV6SDz38jV7mNP59vc3ayN+5EyQ
         tr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593723; x=1703198523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTV9Y9MaaXX2DDdqBdZh/37gFFt+TicObNRgfbQpB+c=;
        b=P6fJLwcUAi/P9gyqpD+C4f7kQ5NocGVwciPf1XMmQZohBJBj5u7QcZ/v3m31kv2tZx
         vveVP5/K3KwUj4ayk/77uVoBLfLCs8KfLUGiQNRuGoxGo89bUN1OzqzKoHHRTzfV9Ik/
         FKEkjem33c1jP5cKQpOt2ShM0m2O+M/OONlfqNBYsOnSyr9V54xYzaOCGT1Kdg0ttat5
         TLZJc/tx0iF+VsaSBvC6CWBAF6LZ87SOEv05mHopIggwuBe0a7qPlT7qCunXUVXE/Spd
         XpsRO8lLTSE7vO3g5x8/yNXWlpTH8PAr+w2xhA9ge0O1H7AEzCdSbtpFfWpm8mjeb3+T
         92sQ==
X-Gm-Message-State: AOJu0YwPLRy1gmKomFPPX9kln62spIX+Sl8QU2XR+qLUfsJc+7tprjJd
	z/mRdLyDWdluzkgKLz2yqGjQFrcjlhugZ9WKNLxDyA==
X-Google-Smtp-Source: AGHT+IH3wqfhEK/RJ4zlhn3zTpIBajIQIVFGmO9Ie6pz+DcSBFS4OVm6rEiwv5xaui/Tt7eJBX/bNzIQiwXmZd6FSK8=
X-Received: by 2002:a05:6102:4414:b0:464:5d7c:a82a with SMTP id
 df20-20020a056102441400b004645d7ca82amr9292044vsb.13.1702593723171; Thu, 14
 Dec 2023 14:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com> <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
In-Reply-To: <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 14 Dec 2023 14:41:26 -0800
Message-ID: <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chriscli@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:23=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > Also after the common decompress part goes to __zswap_load(), we can
> > > cleanup the zswap_reclaim_entry() a little.
> >
> > I think you mean zswap_writeback_entry(), same for the commit title.
>
> I updated my copy of the changelog, thanks.
>
> > > -       /*
> > > -        * If we get here because the page is already in swapcache, a
> > > -        * load may be happening concurrently. It is safe and okay to
> > > -        * not free the entry. It is also okay to return !0.
> > > -        */
> >
> > This comment should be moved above the failure check of
> > __read_swap_cache_async() above, not completely removed.
>
> This?

Yes, thanks a lot. Although I think a new version is needed anyway to
address other comments.

>
> --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
> +++ a/mm/zswap.c
> @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated,=
 true);
> -       if (!page)
> +       if (!page) {
> +               /*
> +                * If we get here because the page is already in swapcach=
e, a
> +                * load may be happening concurrently. It is safe and oka=
y to
> +                * not free the entry. It is also okay to return !0.
> +                */
>                 return -ENOMEM;
> +       }
>
>         /* Found an existing page, we raced with load/swapin */
>         if (!page_was_allocated) {
>

