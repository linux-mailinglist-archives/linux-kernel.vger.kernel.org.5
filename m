Return-Path: <linux-kernel+bounces-45006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70329842A41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3E1286052
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE152128368;
	Tue, 30 Jan 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEaB2tMH"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFA1E4A1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634143; cv=none; b=Z92EVWpcWwucxrYxKXwKVh9NVoO8TVrJOqUuVfRb6ue9Dn6MlCE4QxgoA3ejLmP282NZXYUXm9FrWF8C3Ajo1azHAV3daQdF943wpQNnS0CLWcZKmzlXMh0eaK2K2JZ05OHcVbwIFw6IXwOL6WwVcyF+5/0tCxYVbIfK5JXGhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634143; c=relaxed/simple;
	bh=L/KdqVCV6Bzxc3SoLK/k21kGaOh5FQ6fpwBhCQsyUQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CkJUNxAEIsEQwXELOYotYr37MyLUoKCh9YREPLvM7YbeI37SgIFifjOmyR/9vK1+OBkJ1HKwCQ83FKnLfFSkC0yj5e7r3ltgKsYM6MwUE5/+crfYwjNjLbra1scDz4ApsNqtTFSz0XyoB78dh8vQ8S4ithj+vPPxiHZOSMQAl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEaB2tMH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ddb83a5deeso4487886b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706634141; x=1707238941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OxUoyIJ3bgXe6LBTsvCQjNpEhIzQfA+N+joEQUVhLo=;
        b=uEaB2tMHCWHFvNnko7C9pYhyUb3xDinTfDQHRPxWh7AwF8RGHdy6PtKoa+g8c703j/
         Z8O9J3XVjcEFFXzyuk/fKQm1NMAT1xJxKCPF4jHlxeoFrG8qvMLztaMjTUfWGXZtJHx5
         9eFKAAGwkSPVs8tJ5fRLMx19RYZefK9oFDYSkBaFuijSMemzcvnmE6jIUnkynNsAKQib
         DM9UbRQWdL7oYrKw3CZDUYHAAJayj6iboAbbI+ETaXWdM6CTJqIaGj+5GPH1B1yKoBpp
         BnbIjp4E26T17bdVrrdjBeg03tPk82h81BOe9r7co9QwkMc1a8RJ+sBJli2jKBi5epM8
         BRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634141; x=1707238941;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OxUoyIJ3bgXe6LBTsvCQjNpEhIzQfA+N+joEQUVhLo=;
        b=JLySpYSIxgHZaN3GPq65TszYhCJ0lBTR8KKKHkvQN/Mj9kMTEttjx3mKP8nbBt19Fv
         hqjCnMMDNl1c1LFnwqu0QWYkr4pNskK5C+7vGYBUCVYKmJhWNqIEAKu/LbCLTDv0tySi
         3XjsnmO9OBHv/kAaWyLmfcai4LaRHEKvdb62AZBM2/JN1cL/Mp+aRSevImua6S847OJu
         nETBY/cN44gpGWbLVjgjzbWm8Tuv6fLNXJ+YlVStEaB0DZ4bHtTBOchu1+keCTuPWvqh
         JGIysj09z0Mt+cfvn6T5W+8g3GLnLD2tcfJ34wHtXnuBeOGRuqpGk9pwjcTdzvg5no3Q
         mKJg==
X-Gm-Message-State: AOJu0YyPowTA/wfrfKtZ23dMT3SG44iinx270SuzB/q1ooinrI+Qp7qS
	SG1RC6y6FUDVFZuGiYCkfzIVFhX0TWsqWj5EgFJEG0hEW8s2cxPZ7tapIB1eLw2bWHJonBzPyY5
	/ArLTSKErShRrnpYhSg==
X-Google-Smtp-Source: AGHT+IFSJOITkX9FQ5vyk7lZp7iPUAfNUdn773OnngacDKk9fsVdQ25tPAEr+IEdrY3ZfMZZPLW/+Q0AOqb7g5YT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:27a5:b0:6de:39ef:7e05 with
 SMTP id bd37-20020a056a0027a500b006de39ef7e05mr408355pfb.3.1706634141087;
 Tue, 30 Jan 2024 09:02:21 -0800 (PST)
Date: Tue, 30 Jan 2024 17:02:18 +0000
In-Reply-To: <CAKEwX=NjgXOt1f1nb_T=2ZCSZMeCbTW7g5s9VejA_HzKxM-Pmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-6-hannes@cmpxchg.org>
 <Zbiqmi0KMo0zTJ-p@google.com> <CAKEwX=NjgXOt1f1nb_T=2ZCSZMeCbTW7g5s9VejA_HzKxM-Pmw@mail.gmail.com>
Message-ID: <Zbkrms4k100Hdu7Q@google.com>
Subject: Re: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:31:22AM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 11:51=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Mon, Jan 29, 2024 at 08:36:41PM -0500, Johannes Weiner wrote:
> > > Remove stale comment and unnecessary local variable.
> > >
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  mm/zswap.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 0c6adaf2fdb6..7a7e8da2b4f8 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -546,15 +546,11 @@ static void zswap_entry_get(struct zswap_entry =
*entry)
> > >       entry->refcount++;
> > >  }
> > >
> > > -/* caller must hold the tree lock
> > > -* remove from the tree and free it, if nobody reference the entry
> > > -*/
> > > +/* caller must hold the tree lock */
> >
> > We should replace all those "caller must hold the tree lock" comments
> > with lockdep_assert_held() or assert_spin_locked() or something.
> >
> > I can send follow up patches on top if you don't want to resend this
> > series.
>=20
> Agree. There's also this:
>=20
> /* should be called under RCU */
> #ifdef CONFIG_MEMCG
> static inline struct mem_cgroup *mem_cgroup_from_entry(struct
> zswap_entry *entry)
> {
> return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
> }
>=20
> which you pointed out in the per-cgroup zswap LRU review :)

I will send out a patch this week or so.

