Return-Path: <linux-kernel+bounces-128666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67337895DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C283281CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD54C15E1E4;
	Tue,  2 Apr 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SeOJbR7P"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB415D5D1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090288; cv=none; b=iO3QCWrCoZXotK2SYxwzF1qD3nCgzGzU7Onhz8rE2JhNyqwXb4E9G9a6+BJpFynYtVqzEBnhPqSPR7avo4TXGlXzr9GMR8A2yr61vjXn7aPERejCzTkRBE5mdUXXaoBtJd0j6PX12IOQ0asiLh3if+gwoE/GNiTWaKltHaVyKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090288; c=relaxed/simple;
	bh=nxnmxPC3C9zYn+4ca6Q0vG1p7C/0qUhhKmUNnMvJJsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyRk5qh3cQO/EzEiLDKjOW/jj+XJaeOlewj0OEhNyrNT2NIAbY0T1pFl3DdoNzgy+k/MPrLNbVd/W4of0nftwyuYRTDX0mStKJ9jp8GW9bkBBaA0jiTrzoMS4qq0vMvWSw4AVbEgGK+klPqWnRXoUXEjhWuFNbGX01p8M04ONnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SeOJbR7P; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E894E411BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712090277;
	bh=0A2dorI0UhCriNbj5TIcNe9TX01IpfR2gwAQGQ2g8Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=SeOJbR7PQKQy9WhSKmm94GYNRvaT7m+13MH9zdaT3KJpxdbNL2z1bO9hjrzxN3N2Y
	 RITP81qyc08ja0hgxk79Mo0zAjEtKi8ES3FfJvSZVX4KVE/mSJO/6FjVqg2TCpUFpd
	 sCRvoMCN1OIyZAS7PjEAcWjLbc762VkOOarvZM47ddfFPpQCtyL18xk/lAQCiALBFz
	 dv4lBtmmcFnJ2HLKGelLETXHKzXklDO/6FbERZItDAkj7pm0teMdiI0FjD5uZ2ZpHj
	 u892m+xzIzEejeVWjNgf7m1OcVWscK+euOb4EO/T0r0jhiu2nXpbk4iaaUGJI51Klv
	 Ntrc5j/SDYNTg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so4692664a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090277; x=1712695077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0A2dorI0UhCriNbj5TIcNe9TX01IpfR2gwAQGQ2g8Sg=;
        b=N/8rkL6fnolsIe3RmFGDd+juXCDG+PQtJZfUhZIvGJ9vfBHRsfaR9zGzICoi1v5d3Y
         c7N8Bm+mttsiqxcTfPvBVFYZpswpgi8Ne+upTiyOh2HVDMEp6+JW2P6BeBjPjPs2TOIG
         uPeip4xwW5SURJFNcD4zg8moeQWH6eU5zqEHrfswTjvJMayoJB7BD9VlnT7Q8Kl5SsUm
         dVKcr/iU3iH7TgRRvEIvxkz8ijQc8mzH4OLZ3Jy+vl/YtB64mOXVijVLYKJiqQT1Op+l
         gZMk0+KDbABqkUVZF+i82CkAJzw1i0mtokqPCpNG8pjjOCcr9+Ty31EhtyUl7zH3SVcl
         tw+A==
X-Forwarded-Encrypted: i=1; AJvYcCUqWSZPuaPon7IQSvcX7KmIhFqdHS0NSPm+gx1NZTHZwlnfkKTq8mlKscUuuI0AldGH7iVytskFj11L/qjFiNRiGPPOWUzF+KQyIYoe
X-Gm-Message-State: AOJu0YypLZ/GM/PrhZ0z69Ua8VQ9xoKxgR5FCYkCOTw2mx9t1ehxd0E/
	jp9W++FCRtufSJgoiW7VeqsbV/NJsw1FmYXQ342YrQ75sUpubV2BT+HrRQmTB4qO5Gg7evsSBA1
	5GvxBSsFBtsRDqMkHeDivpyYjf9P1biCcRkOO/h/TFzy810FLzJ5+sgHZB+BD7i8/mbULZbvDOL
	X8gQ==
X-Received: by 2002:a50:9fc3:0:b0:56b:ff5b:c49c with SMTP id c61-20020a509fc3000000b0056bff5bc49cmr758479edf.33.1712090277413;
        Tue, 02 Apr 2024 13:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZu7tB9wIBVWKHIAgm8IR5Yuc1blVm4zKBHSxAQ/cztTTl9uwjgDDaZPfhqkVz2EEMO9/jKw==
X-Received: by 2002:a50:9fc3:0:b0:56b:ff5b:c49c with SMTP id c61-20020a509fc3000000b0056bff5bc49cmr758460edf.33.1712090276886;
        Tue, 02 Apr 2024 13:37:56 -0700 (PDT)
Received: from localhost (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id bx25-20020a0564020b5900b0056db8d09436sm5312514edb.94.2024.04.02.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:37:56 -0700 (PDT)
Date: Tue, 2 Apr 2024 22:37:55 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] libbpf: ringbuf: allow to consume up to a certain
 amount of items
Message-ID: <Zgxsow3M3iHXX-k0@gpd>
References: <20240401073159.16668-1-andrea.righi@canonical.com>
 <20240401073159.16668-2-andrea.righi@canonical.com>
 <CAEf4BzbJE-Y72VqYXCDfwRXjhknVK+GHYjRfxdajzAEwjUkwUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbJE-Y72VqYXCDfwRXjhknVK+GHYjRfxdajzAEwjUkwUg@mail.gmail.com>

On Tue, Apr 02, 2024 at 10:58:33AM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 1, 2024 at 12:32 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > In some cases, instead of always consuming all items from ring buffers
> > in a greedy way, we may want to consume up to a certain amount of items,
> > for example when we need to copy items from the BPF ring buffer to a
> > limited user buffer.
> >
> > This change allows to set an upper limit to the amount of items consumed
> > from one or more ring buffers.
> >
> > Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/lib/bpf/ringbuf.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index aacb64278a01..81df535040d1 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
> >         return (len + 7) / 8 * 8;
> >  }
> >
> > -static int64_t ringbuf_process_ring(struct ring *r)
> > +static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
> >  {
> >         int *len_ptr, len, err;
> >         /* 64-bit to avoid overflow in case of extreme application behavior */
> > @@ -264,7 +264,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
> >                                                           cons_pos);
> >                                         return err;
> >                                 }
> > -                               cnt++;
> > +                               if (++cnt >= max_items) {
> > +                                       /* update consumer pos and return the
> > +                                        * total amount of items consumed.
> > +                                        */
> > +                                       smp_store_release(r->consumer_pos,
> > +                                                         cons_pos);
> 
> Does this fit on a single line under 100 characters? If yes, please
> keep it as a single line
> 
> but actually it seems cleaner to keep cnt++ intact, let
> smp_store_release() below happen, and then check the exit condition.
> Were you afraid to do unnecessary checks on discarded samples? I
> wouldn't worry about that.

Ok, it makes sense, I'll change it.

> 
> > +                                       goto done;
> > +                               }
> >                         }
> >
> >                         smp_store_release(r->consumer_pos, cons_pos);
> > @@ -281,19 +288,18 @@ static int64_t ringbuf_process_ring(struct ring *r)
> >   */
> >  int ring_buffer__consume(struct ring_buffer *rb)
> >  {
> > -       int64_t err, res = 0;
> > +       int64_t err, res = 0, max_items = INT_MAX;
> 
> I'm wondering if it might be better to have a convention that zero
> means "no limit", which might allow the compiler to eliminate the
> condition in ringbuf_process_ring altogether due to constant
> propagation. WDYT?

Indeed, in this way we won't add any potential overhead to the existing
code that doesn't care about max_items. Will add that.

-Andrea

