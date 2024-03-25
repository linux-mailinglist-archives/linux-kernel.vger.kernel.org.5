Return-Path: <linux-kernel+bounces-118042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E76B88B2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23981FA2B89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616F6FE16;
	Mon, 25 Mar 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQcB5Pz0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B56F520
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402194; cv=none; b=BO+RRtyGJOMb+YBL3SfQrEFjGXUgDOLGMF1Ti/ClglQg06L/7JtCSdSgNqiNIgI/8MlMLd+LxSkeU4VLzarz7L01oveIlH2JHx/8Lh7kJJPpAit0wK2rYou0vJXxARgc5fu+xhew1Y3xS3Tb4mvM7kO7hQkkVFfUVlufcfzeJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402194; c=relaxed/simple;
	bh=1lnSa8EaNX8MXlNYG3Qt6kVt761yhy3NR6trhzbBYg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxWmw0LunJU+/iSdhZHDdaDs8BZ/yUY5gCBzV66Ogxu0dHfqy9meDOkiD0CShzEleYlNN2ozWm6ec4Oloo0T9xbqOaMqzxpjdhhrVjA+p+dtuxyVyd2uz1LC2yS3RawCk5R18zfrdrnRvt3fgSsWn+FMyu9j/fTvx//vic7/ZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQcB5Pz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3290C4166C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711402193;
	bh=1lnSa8EaNX8MXlNYG3Qt6kVt761yhy3NR6trhzbBYg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZQcB5Pz0y5artKZz3sO1MKzvSHSvnB9HerkEl0eqg7wgEKqtQLNpcxZi45jDlLfpD
	 gyEEvmYb54jcPhYYApSSKpuC6xbda5zFaGoj3eLI2dfsYk01J/3/8vgGGoRCxqL76+
	 QjSagz3MhIuKxSTl8LhXeK0k/vQA+D1ZP1yfW+IppSsgLliZp9pDS0MLYevFBzwa7o
	 +27rPP36ZKMOnJzyG9XzU3DZCDs9jjhZRxAzGB4cmaaTfbmc3t2Q3UBYwBlD3EEPSy
	 8VsXZY+Z0E0z5QCCi0xGra/Ksy7IYoZkXK/t4U7tkfJDozIz9vHViF6+Ilu7juzFYg
	 /iXVLWgeIrjjg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so69660091fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:29:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywe89ddPSyqfv0XtFstWeO8j8oztHTv0b+gJZhJyIg/wdNdA8Lx
	d38j1vxvUTacQiQqzWFuFbK07wUz3DR48pNj5mKfvpfYINC2QstW9A/UQ4Tr0AeixuC1Axpcopt
	x0Tkj77roKtNo3OgBY2LeTQCJ8w==
X-Google-Smtp-Source: AGHT+IEAuc3qFqNG3zeOUiQ9n0VITEhtqdIVKjV0hOnfHR5tLGIlRdias/H8XF8Dlo7T2c6bTE7X6G/YXvLdhOWiKiQ=
X-Received: by 2002:a05:651c:2c9:b0:2d4:a232:757 with SMTP id
 f9-20020a05651c02c900b002d4a2320757mr4659418ljo.7.1711402192564; Mon, 25 Mar
 2024 14:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320-zswap-xarray-v8-1-dc08ee9f8744@kernel.org> <20240325133546.ffd728d1c309ba58eadb179c@linux-foundation.org>
In-Reply-To: <20240325133546.ffd728d1c309ba58eadb179c@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 25 Mar 2024 14:29:41 -0700
X-Gmail-Original-Message-ID: <CANeU7QkDuXeR8MzKvnPcN5odkpDQJ3bMW_nSRHbZGffPkiXW-Q@mail.gmail.com>
Message-ID: <CANeU7QkDuXeR8MzKvnPcN5odkpDQJ3bMW_nSRHbZGffPkiXW-Q@mail.gmail.com>
Subject: Re: [PATCH v8] zswap: replace RB tree with xarray
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:35=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 20 Mar 2024 12:31:38 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > Very deep RB tree requires rebalance at times. That
> > contributes to the zswap fault latencies. Xarray does not
> > need to perform tree rebalance. Replacing RB tree to xarray
> > can have some small performance gain.
> >
> > One small difference is that xarray insert might fail with
> > ENOMEM, while RB tree insert does not allocate additional
> > memory.
> >
> > The zswap_entry size will reduce a bit due to removing the
> > RB node, which has two pointers and a color field. Xarray
> > store the pointer in the xarray tree rather than the
> > zswap_entry. Every entry has one pointer from the xarray
> > tree. Overall, switching to xarray should save some memory,
> > if the swap entries are densely packed.
> >
> > Notice the zswap_rb_search and zswap_rb_insert always
> > followed by zswap_rb_erase. Use xa_erase and xa_store
> > directly. That saves one tree lookup as well.
> >
> > Remove zswap_invalidate_entry due to no need to call
> > zswap_rb_erase any more. Use zswap_free_entry instead.
> >
> > The "struct zswap_tree" has been replaced by "struct xarray".
> > The tree spin lock has transferred to the xarray lock.
> >
> > Run the kernel build testing 10 times for each version, averages:
> > (memory.max=3D2GB, zswap shrinker and writeback enabled,
> > one 50GB swapfile, 24 HT core, 32 jobs)
> >
>
> So this conflits with Johannes's "mm: zswap: fix data loss on
> SWP_SYNCHRONOUS_IO devices", right in the critical part of
> zswap_load().  Naive resolution of that conflict would have resulted in
> basically reverting Johannes's fix.
>
> That fix is cc:stable so we do want it to have a clean run in
> linux-next before sending it upstream.  So I'll drop this patch
> ("zswap: replace RB tree with xarray") for now.  Please redo it against
> latest mm-unstable and of course, be sure to preserve Johannes's fix,
> thanks.

Sure, I will wait for your mm-unstable update that contains Jonanne's
fix then re-submit a new version.

Chris

