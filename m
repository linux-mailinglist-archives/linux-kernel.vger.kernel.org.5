Return-Path: <linux-kernel+bounces-108498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D2880B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C121C220FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F2EC5;
	Wed, 20 Mar 2024 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czpL0F2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C157FB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916465; cv=none; b=Q7nk6XUCD/w35MQZMRL+XwIaIn+g5aYOYefcWIZn97DKDmlnFS1qoxe5nRPdRXYO8BpxVh1i9u6IH5qUS01qGqrUIDxkJTnFu/3zQWvempz/CxrA26vr5p9lfXup5UnzjCCBc7oJsPp5KLXdoqquYdkRRIbhfcArSbjgJ7Sa3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916465; c=relaxed/simple;
	bh=8YIsJhztsQo4cn+hAiQEWTFMgbIPhMPSRmYKdPK3qFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrqkVzs3yfK/AtqUFdh9NWul7q0QwGIl7v3M/0HSSeRXfVj8Li1F4e1DTkKbM0VJ+Xk+ObScTzQ/DJe9O9RG2cESX/eoeIDI17t3DnJhnSYk8PbAJmFEyR8XbD1I2eBeHr/vRIeMDhVdNsKbg+b1hXIn6XqxU1RCAOSreeG7eNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czpL0F2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383C1C433C7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710916465;
	bh=8YIsJhztsQo4cn+hAiQEWTFMgbIPhMPSRmYKdPK3qFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czpL0F2d2Hd2etmc/VPeVMWnDVPTEXWI4QiUzE2meqhqN9m5J48bb8T6kpmbfS03g
	 Xz7kChQeqPSj+Ros32TFCVxyaJNkt00pI6oo8KDSAli78foTkKFaFZidzuzEqaa0Ey
	 bg8dO21QYVNTCcbRupximb8LT1PkpFWfIH0mLgDEhGd+QvWX9OT0vNoH6eMEYDMB3C
	 tgNLbbyJsoXA6yAgBEnyWRKRZWncO6xfS6LkMS7hIoeoKmhdrL3uvr1TN6XdgUrsUA
	 K2/IUAOZxnorlYWg1CCuDgdTSbXJgUk43SbJN7qZARuTyJ7CDeEgYJiK94SM4J13sZ
	 j/Fji4eZokX7A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so85156051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCsAJxSFQ5o1rJ6cUvyjPCOB9HT8Nnc8npAkwOfbO6VCnGLLnksRXWn3PISjBvPYKgOu5xU8nOB3E7VA6sNdt2rjhW2hAQIDcNM4cG
X-Gm-Message-State: AOJu0YyO+BaprA0v1JOsE/s7N3cHlsgrT6LBkAPCvL4hIMf6Q6kvd5tD
	ywgu0Z+dFXIsXF4YhpKoQqc/JLQVWRF4QXpJCptvcDiimjOTzvaycn+9mp8620S/i8tNQXr60QN
	Du7EDY7f4ZUnvwpYn4UeFMZw63w==
X-Google-Smtp-Source: AGHT+IGJ6/WTNTLkpCgBE1HGeVyLIaTs55r9cXEfvXhnpD34wDATWmklKNEPBCa8Yb9gfgnWgEhFob9fbm3DOe0H41U=
X-Received: by 2002:a2e:9093:0:b0:2d2:6608:3d05 with SMTP id
 l19-20020a2e9093000000b002d266083d05mr709889ljg.52.1710916463813; Tue, 19 Mar
 2024 23:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org> <Zfp-iWaDfqeCOElt@google.com>
In-Reply-To: <Zfp-iWaDfqeCOElt@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Mar 2024 23:34:11 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
Message-ID: <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Mar 19, 2024 at 10:52:26PM -0700, Chris Li wrote:
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
> > mm-unstable-a824831a082f     xarray v7
> > user       3547.264                   3541.509
> > sys        531.176                      526.111
> > real       200.752                      201.334
> >
> > ---
>
> I believe there shouldn't be a separator before Rb and Sb below.

Ack.

>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
>
> I have some comments below, with them addressed:
>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>
> [..]
> > @@ -1556,28 +1474,43 @@ bool zswap_store(struct folio *folio)
> >  insert_entry:
> >       entry->swpentry =3D swp;
> >       entry->objcg =3D objcg;
> > +
> > +     old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> > +     if (xa_is_err(old)) {
> > +             int err =3D xa_err(old);
>
> There should be a blank line after the declaration.
>
> > +             WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> > +             zswap_reject_alloc_fail++;
> > +             goto store_failed;
> > +     }
> > +
> > +        /*
> > +         * We may have had an existing entry that became stale when
> > +         * the folio was redirtied and now the new version is being
> > +         * swapped out. Get rid of the old.
> > +         */
>
> This comment is mis-indented.

Ah, there is some space instead of a tab because the comment was
copied from an email. Will fix it.


>
> checkpatch would have caught these btw.
>
> > +     if (old)
> > +             zswap_entry_free(old);
> > +
> >       if (objcg) {
> >               obj_cgroup_charge_zswap(objcg, entry->length);
> > -             /* Account before objcg ref is moved to tree */
> >               count_objcg_event(objcg, ZSWPOUT);
> >       }
> >
> > -     /* map */
> > -     spin_lock(&tree->lock);
> >       /*
> > -      * The folio may have been dirtied again, invalidate the
> > -      * possibly stale entry before inserting the new entry.
> > +      * We finish initializing the entry while it's already in xarray.
> > +      * This is safe because:
> > +      *
> > +      * 1. Concurrent stores and invalidations are excluded by folio l=
ock.
> > +      *
> > +      * 2. Writeback is excluded by the entry not being on the LRU yet=
.
> > +      *    The publishing order matters to prevent writeback from seei=
ng
> > +      *    an incoherent entry.
>
> As I mentioned before, writeback is also protected by the folio lock.
> Concurrent writeback will find the folio in the swapcache and abort. The
> fact that the entry is not on the LRU yet is just additional protection,
> so I don't think the publishing order actually matters here. Right?

Right. This comment is explaining why this publishing order does not
matter. I think we are talking about the same thing here?

Chris

