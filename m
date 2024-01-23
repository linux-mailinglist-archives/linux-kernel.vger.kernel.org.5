Return-Path: <linux-kernel+bounces-36024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093C839A47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE231F2A35A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71744403;
	Tue, 23 Jan 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF9NIAij"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C02570
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041856; cv=none; b=p+6iBCWcoh9qJvo1VfpDtN1MMUakAWL5z6uCGeV07v1Aer6TxHoAd9ed1GJSxvVg2InPaWdCMIgoB5mElcGpMF8qO05rbEAgbxuR9ZE+YSCUNaMH2EV6KbXR6j7JiA5HyzY5m79JWLwlUVnf3fbRtkg+QmCkYpfSUQuEVKC/Z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041856; c=relaxed/simple;
	bh=wwShGwrSxVvRVH2MVPGVGoc4y8eGUwyN/JdrvvgfaTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn5wkNbCwek/8O63075Xj0+qifYJF1+uiJyq9X2VJK0uo2sinqw6M2hOPU2Jo9Lwuo6HTRztgZsqRJ0ArA3546Wi/uU+yqpJard3Ic8e3246T/kMsmgkgFUUIJdChqEjHW7hC1ombHn6zGvRgxi3xBqCz1q5Y5yuj9T/Za6/wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF9NIAij; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7baa8da5692so211395739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706041853; x=1706646653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7q7qUlqkN3GVHKe++gcj+xeY1A8RNTSViGtBlrvvaw=;
        b=cF9NIAijN+t1lyqKRj+beESAzgccN7eFvbFBQKMff4jdja5WJdvz1gxiG5AWslNrYR
         ZAcsC28pXqRQMA5xCJFyk4wvFky2T5vs3kgsf/YxDVse1GaZnhpY60PvBOYYiUF82YOt
         ybwjuTJGQWuodhnnR1gO9bgikwGeOnjGq7PfQ2jUKRxJRsv1syYFr1Xs/CMIBrz2nKeA
         rbD5xtjReQBcPn5I7ZLMggvkTIt7zumqfd49Yr5ldWDMa4O3lcem3k8R43I/myuawVIz
         mb7XA+wikiUJ/nzvd+Kdg0SdQhIjAdzUjkrqQowXxrXfHyilcqBVZfd3Xze87/jsekA/
         CptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041853; x=1706646653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7q7qUlqkN3GVHKe++gcj+xeY1A8RNTSViGtBlrvvaw=;
        b=sAr2GDNGuJDAzUbk6Ywow+48aYXRCTUGI2+Tgz7lClM197I2Oi9NakG/Y0C7ENF/lH
         u6VTiEsgAIm/yIB99Xj4QjBhdKG3K93Ik0ueZIgHuPfi7yb8vVJqU9W/biXi2YbYiq4h
         vIlX2svz1VjTvg+jEZRcdDjQzH+Ij1awAk40cvnnsjKq6atYeFkr4CGskJ/clBM6s0En
         zZYFWpV8ZBAMqKXcqCePaiSH4Lt8SCKpcOWWqBJOXWZgACjvSn974saZhnNzBAYEKe/L
         BtZ4r8ymdT8n9DmmO2+cGXLpVTb4bOmDEEAh6qkk/RZfXbL0aNNFUtbrc1egALl5d6wt
         Ya7w==
X-Gm-Message-State: AOJu0Yybrp/wwpTvLqr/QoUmJfDSlvoRoi4wx4kLSIyzS6XMLBOnIlc9
	LPq1IGPVmVwqdD+S7Wlrpq+QTqmsCjL2OSKuzZLc+6PUVWyzodamrVxqVwmBrrQlg6GciF4sIne
	r3sy8dpc4TTHncaBqyG/iFn116HY=
X-Google-Smtp-Source: AGHT+IGMzVtdBkLpku9alykvvgGkiPNQSMkMvSc4Cych2kzUBsI2tv7er4jat+B/Mpj8fYKmTwUmq5Lj0IRrKsw8UHo=
X-Received: by 2002:a6b:7b49:0:b0:7be:de5e:b62f with SMTP id
 m9-20020a6b7b49000000b007bede5eb62fmr518686iop.35.1706041853489; Tue, 23 Jan
 2024 12:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
In-Reply-To: <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 23 Jan 2024 12:30:42 -0800
Message-ID: <CAKEwX=OcyTXrLNYoBAJkWv0iUi5o6h1=bx1qaCH2CodWctc0Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:55=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 23, 2024 at 7:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
> > > On Mon, Jan 22, 2024 at 12:19=E2=80=AFPM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > > > > During swapoff, try_to_unuse() makes sure that zswap_invalidate()=
 is
> > > > > called for all swap entries before zswap_swapoff() is called. Thi=
s means
> > > > > that all zswap entries should already be removed from the tree. S=
implify
> > > > > zswap_swapoff() by removing the tree cleanup loop, and leaving an
> > > > > assertion in its place.
> > > > >
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > >
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > That's a great simplification.
> > > >
> > > > Removing the tree->lock made me double take, but at this point the
> > > > swapfile and its cache should be fully dead and I don't see how any=
 of
> > > > the zswap operations that take tree->lock could race at this point.
> > >
> > > It took me a while staring at the code to realize this loop is pointl=
ess.
> > >
> > > However, while I have your attention on the swapoff path, there's a
> > > slightly irrelevant problem that I think might be there, but I am not
> > > sure.
> > >
> > > It looks to me like swapoff can race with writeback, and there may be
> > > a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> > > races with shrink_memcg_cb(), I feel like we may free the tree as it
> > > is being used. For example if zswap_swapoff()->kfree(tree) happen
> > > right before shrink_memcg_cb()->list_lru_isolate(l, item).
> > >
> > > Please tell me that I am being paranoid and that there is some
> > > protection against zswap writeback racing with swapoff. It feels like
> > > we are very careful with zswap entries refcounting, but not with the
> > > zswap tree itself.
> >
> > Hm, I don't see how.
> >
> > Writeback operates on entries from the LRU. By the time
> > zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
> > will have emptied out the LRU and tree.
> >
> > Writeback could have gotten a refcount to the entry and dropped the
> > tree->lock. But then it does __read_swap_cache_async(), and while
> > holding the page lock checks the tree under lock once more; if that
> > finds the entry valid, it means try_to_unuse() hasn't started on this
> > page yet, and would be held up by the page lock/writeback state.
>
> Consider the following race:
>
> CPU 1                                 CPU 2
> # In shrink_memcg_cb()     # In swap_off
> list_lru_isolate()
>                                             zswap_invalidate()
>                                             ..
>                                             zswap_swapoff() -> kfree(tree=
)
> spin_lock(&tree->lock);
>
> Isn't this a UAF or am I missing something here?

I need to read this code closer. But this smells like a race to me as well.

Long term speaking, I think decoupling swap and zswap will fix this,
no? We won't need to kfree(tree) inside swapoff. IOW, if we have a
single zswap tree that is not tied down to any swapfile, then we can't
have this race. There might be other races introduced by the
decoupling that I might have not foreseen tho :)

Short term, no clue hmm. Let me think a bit more about this.


>
> >
> > > > > Chengming, Chris, I think this should make the tree split and the=
 xarray
> > > > > conversion patches simpler (especially the former). If others agr=
ee,
> > > > > both changes can be rebased on top of this.
> > > >
> > > > The resulting code is definitely simpler, but this patch is not a
> > > > completely trivial cleanup, either. If you put it before Chengming'=
s
> > > > patch and it breaks something, it would be difficult to pull out
> > > > without affecting the tree split.
> > >
> > > Are you suggesting I rebase this on top of Chengming's patches? I can
> > > definitely do this, but the patch will be slightly less
> > > straightforward, and if the tree split patches break something it
> > > would be difficult to pull out as well. If you feel like this patch i=
s
> > > more likely to break things, I can rebase.
> >
> > Yeah I think it's more subtle. I'd only ask somebody to rebase an
> > already tested patch on a newer one if the latter were an obvious,
> > low-risk, prep-style patch. Your patch is good, but it doesn't quite
> > fit into this particular category, so I'd say no jumping the queue ;)
>
> My intention was to reduce the diff in both this patch and the tree
> split patches, but I do understand this is more subtle. I can rebase
> on top of Chengming's patches instead.

