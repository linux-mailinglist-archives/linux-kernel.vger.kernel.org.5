Return-Path: <linux-kernel+bounces-67992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723985740E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AC52857D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF712B95;
	Fri, 16 Feb 2024 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVd6kItc"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3010A08;
	Fri, 16 Feb 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055724; cv=none; b=NxHDc2+7QRzVZoNixMUDrQQBO5M9hS8tniZ/It2jYU7gKjA4qTt52DxvJHGWcj3eilxphszWwqWe5AIpRQPllxRhA9CXwsp4Z1or8qPAa+K71MSAQeCgv8yyci/YNcR5TmfPIZHEt+BsCsMizOyQgMOg1Gsx4JPTIvtBrZJJ304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055724; c=relaxed/simple;
	bh=6Fp2wjgOC/nAoMzGcntuhicS8v+wr/GQBkNxnoYVz0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCCbbuXDu+Ti/XSRWvfPzBkz3QGxHlLAscV+I+E0vFVnAFNqQClgd+1l0w9fY48+fpCZi3We6XUmqP13jNivSe7/GbFAnDBjIasIdonHabfzxBpu1NAUa3vNRYsjDFzOMfWktf+mdK0BlJg8JkQUr0OhtOYhcYWbhMMlq0q2wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVd6kItc; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso602720241.2;
        Thu, 15 Feb 2024 19:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708055721; x=1708660521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqCF2ZMQVeGmSlU3Ex8qv7o02hkUoFRiavSd1UVM5HI=;
        b=AVd6kItc0hEH+rAABThJMWR3cPaKkjj8DzpK+LD/Pl3JXOKg8r96AH1Chhn/1dn96F
         tvtdsSYYyM5/Ke2bl9cYlhF1U7fjeJyX20QqatcAxQcFPKIrSPBFJrzt48c9GLyjgLT4
         q4zI4zzZ4gJ1Zsw+FEQAeJ+MW+AFV2+bElGCKjFaDPEU7zyVH/pAyBXrmMXDiERvR+u/
         ikXR43GGZ8cfEMzzCx/RWQDbfjXmbjwlQoLjs+PUdhPf3djRI5nsg26VIBgFQfdm600a
         2qo+j8Gp/EEz5Ok5SQ+578lmNtkWyHO7ygOkXJjkxu66BguGv8JwS7F+H1iYYTgxQOEm
         NrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708055721; x=1708660521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqCF2ZMQVeGmSlU3Ex8qv7o02hkUoFRiavSd1UVM5HI=;
        b=nlBIDcsbtoPbzk6yWZ5Hxg6jsWOR5Oq8cVFdG9sw/RUzwoxc4jf1uL6tmME3ls4DcV
         Mi8+/VHRqw7oHVw4+OhTjs7vWoM+h607lRIJ+Tx/l7BwSN7jCJC9xJtyMSHx3THAQPv6
         0WPINIAMi0kGpWH7En8CL+2WiWNVkzG859A8ttQqF6zCXuI+v4iIBfXmopoMeXBc/mLh
         VMHONvwKxudNoqYipsU1ApBdt9+IScXsuiQOnvfr1x/qKR5EdsRBzGfJixsjfnW5rED6
         qRqgqz1xSInGuij0zpZ8dgA788f7L1ilbMNwQfk+NnIQmaK54zoGpboucWYsqfeSbLEq
         cNiA==
X-Forwarded-Encrypted: i=1; AJvYcCU0y0moWUiIx4E+nR7nN+33f8LwasXK1srMYAdcp8mvmOujvvzKgiuGv8og1Wz9D7HxLYD3MxfNGBASr8XDiamg7g2XHtgnB0t/OWoGv7v+q5kiPjsi5JiEaPluhlBcHgYemxYkjWltbSfH
X-Gm-Message-State: AOJu0YxAVYoQqM2RwlubKBBALohaJGQxlgYabwfSwv0VWKh1dv30klEA
	Q1BzZWHbP3JHrZGtUdOaP6Ll4XNG924OndVh6jdXOh4MkNrSvJKCF2rEJdXlgnd8iAb0ep8mDPF
	7zrTjeGmXuRq24CwPbkzfgUmr4nc=
X-Google-Smtp-Source: AGHT+IEnqBVjFHpxPK9mH1okTBVmVH62qZ+PmjPj0sEpxqtIjmDFLINSkENjUffAWo3Gjet5gF13u1wY7CkBGdj833s=
X-Received: by 2002:a1f:ca47:0:b0:4c0:3b05:75cb with SMTP id
 a68-20020a1fca47000000b004c03b0575cbmr3186113vkg.10.1708055721190; Thu, 15
 Feb 2024 19:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095006.608744-1-21cnbao@gmail.com> <20240103095006.608744-3-21cnbao@gmail.com>
 <CAKEwX=MDNuW72OS81mXgAKMdBnT2MCTGJtXx8cgMLh=J_Nv-ew@mail.gmail.com>
In-Reply-To: <CAKEwX=MDNuW72OS81mXgAKMdBnT2MCTGJtXx8cgMLh=J_Nv-ew@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 16:55:10 +1300
Message-ID: <CAGsJ_4xfQow4bGiyxVRN7xDN3Hu=jPSZA+XpK9XdAb9pjWXcRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: remove the memcpy if acomp is not asynchronous
To: Nhat Pham <nphamcs@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	akpm@linux-foundation.org, ddstreet@ieee.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, linux-crypto@vger.kernel.org, chriscli@google.com, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, yosryahmed@google.com, zhouchengming@bytedance.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:38=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, Jan 3, 2024 at 1:50=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Most compressors are actually CPU-based and won't sleep during
> > compression and decompression. We should remove the redundant
> > memcpy for them.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
>

Hi Nhat,
Thanks for reviewing!

> nit: it might help to include the test numbers in the changelog in
> this patch here too. Save a couple of clicks to dig out the original
> patch cover for the numbers :)

Chengming's test data is for the whole series. so i can't find the
proper commit to put the data. but it seems Andrew does have
a good habit to collect some important cover-letter info to commits,
so in v2, i'd keep the commit message as is.

>
> > ---
> >  mm/zswap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index ca25b676048e..36898614ebcc 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
> >         struct crypto_wait wait;
> >         u8 *buffer;
> >         struct mutex mutex;
> > +       bool is_async; /* if acomp can sleep */
>
> nit: seems like this comment isn't necessary. is_async is pretty
> self-explanatory to me. But definitely not a show stopper tho :)

Thanks. I am changing the name to is_sleepable according to
Yosry's suggestion. As a result, the comment is removed as well.

>
> >  };
> >
> >  /*
> > @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
> >                 goto acomp_fail;
> >         }
> >         acomp_ctx->acomp =3D acomp;
> > +       acomp_ctx->is_async =3D acomp_is_async(acomp);
> >
> >         req =3D acomp_request_alloc(acomp_ctx->acomp);
> >         if (!req) {
> > @@ -1370,7 +1372,7 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
> >         mutex_lock(&acomp_ctx->mutex);
> >
> >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > -       if (!zpool_can_sleep_mapped(zpool)) {
> > +       if (acomp_ctx->is_async && !zpool_can_sleep_mapped(zpool)) {
> >                 memcpy(acomp_ctx->buffer, src, entry->length);
> >                 src =3D acomp_ctx->buffer;
> >                 zpool_unmap_handle(zpool, entry->handle);
> > @@ -1384,7 +1386,7 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
> >         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> >         mutex_unlock(&acomp_ctx->mutex);
> >
> > -       if (zpool_can_sleep_mapped(zpool))
> > +       if (!acomp_ctx->is_async || zpool_can_sleep_mapped(zpool))
> >                 zpool_unmap_handle(zpool, entry->handle);
> >  }
> >
> > --
> > 2.34.1
> >
>
> The zswap side looks good to me. I don't have expertise/authority to
> ack the crypto API change (but FWIW it LGTM too based on a cursory
> code read).
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!
Barry

