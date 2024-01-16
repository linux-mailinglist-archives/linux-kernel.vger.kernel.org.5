Return-Path: <linux-kernel+bounces-28276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7882FC70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BED1F295F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54FE5A7AB;
	Tue, 16 Jan 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QynPxRht"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B828DCB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438614; cv=none; b=eY0DCiQ3cSzsq5qmvVx9rWrGYUoZ2JvqQS+e68AI9aDhWvKuaWX0ju6qtNnr9v6c38k6QXIlWfcyFddXXlc36x/M6G9TxHtfebX1Pwaet2/aC/j0pDdlmhPuf1WTeNdidN5CD4wdiJbW393dQMxMGDZ9ApYVA28sF2W4z/WJ22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438614; c=relaxed/simple;
	bh=99MkrrCzFkqckJarNvVYpCquuSKUh+NKcSIugNOwZLw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=uqHJhdGBvX5tvoRdqn06mw6tNxaT0xNyocoUkRDza3QjtR4UlX3QTpoLqS6Z3AsNhs9BZb2+8ZVYnUHfFER6B7UeIiyONP/9fRQKLXP5BSQhNA5R5yRPQtGN8YoGxOZCyNL+dO8ErBGRP0qRBfA1T9tKy9M4FZBfnTGxV2VOGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QynPxRht; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d629b4d91fso4336515ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705438612; x=1706043412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXa6+TpZrtg87/kEjfGIsGhnnsc5MTVIdja7FTE/y+I=;
        b=QynPxRhtCMsrY1wWzlCrU+LrtpEqv0vL/ePUv6/BRrGANyM6LccMIcZbT5d2IrOfrh
         XmLl/NvalCwKsktEL9Mdylh/hhen8Z1lopCEWmbN2bWXvRWQlnqTymsuqvY1Fal0I/D6
         7KcsqtOgLt+9lYRbDG3jGlD6qKHMNtpjpD9IUtCWf+7GtIWWItluUaFHth6rDsyqUv7o
         2Kt1x39pSf9mYN2x8CYcx6Z8nUKpHarcC6vpqIKZUjW4kE3dxYriUF7+ZgC/IxJrktJh
         QaKlYTdNC9Ne9JB88Mhvl0vo5KnGSFc3Kivrtdv5Q8CKMYP0yMMYiVISd+j3j+TKt398
         YVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438612; x=1706043412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXa6+TpZrtg87/kEjfGIsGhnnsc5MTVIdja7FTE/y+I=;
        b=nAAkBu/6Nn51qkY97tl9PP+8Wg1XhI/XqNbMo1gwt/OnOduoLsaYH//3im/zPP7hAu
         p/7R+GR7ODXG2VdIeLs5qzUVLLldpEniy7e2vGbZguMAz4mTSxoVFBCAzrG4+DW9QB++
         L7xAqniR1gFCzFKroO+Z8KentJqClU1N6+whKCaI425Sacg//TgYAjKHjdPCBkBth/Nr
         rnDUJJW44UpFssQHsTcWtmKgqKVKapk7B9uNk/jWw1RRQHjakUcqhawLxo2LUrY+IwxL
         FVXG/ChHn8NIZKSy+y6rp8I/QNLBf+R+gp73IkarHXHM/dj5COL4DGPQVSSAXXLn1vsa
         lalQ==
X-Gm-Message-State: AOJu0YxQZ5e4dYdSxJCuIXRD3zfno6ufPgQpLQDMGKwTqZtMZn+6l838
	zQTVeQonX5+G93v+r3/1xzw6M1/s8ngsslGC1sE=
X-Google-Smtp-Source: AGHT+IHwi5fr9VKyP4HZdqlhg4wbFo7sU598VraNXGHYnq2J7Ci9/FA875680Ks7HPxj+FDyjtfAlLI+dLnBJ2PaXHU=
X-Received: by 2002:a17:90b:1086:b0:28e:1b1b:6239 with SMTP id
 gj6-20020a17090b108600b0028e1b1b6239mr2861673pjb.38.1705438611936; Tue, 16
 Jan 2024 12:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 12:56:40 -0800
Message-ID: <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >
> > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > Hi,
> > >
> > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > >> Align larger anonymous memory mappings on THP boundaries by
> > >> going through thp_get_unmapped_area if THPs are enabled for
> > >> the current process.
> > >>
> > >> With this patch, larger anonymous mappings are now THP aligned.
> > >> When a malloc library allocates a 2MB or larger arena, that
> > >> arena can now be mapped with THPs right from the start, which
> > >> can result in better TLB hit rates and execution time.
> > >
> > > This appears to break 32bit processes on x86_64 (at least). In
> > > particular, 32bit kernel or firefox builds in our build system.
> > >
> > > Reverting this on top of 6.7 makes it work again.
> > >
> > > Downstream report:
> > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > >
> > > So running:
> > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlin=
ux.btf
> > >
> > > crashes or errors out with some random errors:
> > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 type=
=3D181346
> > > Error emitting field
> > >
> > > strace shows mmap() fails with ENOMEM right before the errors:
> > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > ...
> > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot allocat=
e
> > > memory)
> > >
> > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > > enough. For reference, one is available at:
> > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > >
> > > Any ideas?
> >
> > This works around the problem, of course (but is a band-aid, not a fix)=
:
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned lon=
g
> > addr, unsigned long len,
> >                   */
> >                  pgoff =3D 0;
> >                  get_area =3D shmem_get_unmapped_area;
> > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > !in_32bit_syscall()) {
> >                  /* Ensures that larger anonymous mappings are THP
> > aligned. */
> >                  get_area =3D thp_get_unmapped_area;
> >          }
> >
> >
> > thp_get_unmapped_area() does not take care of the legacy stuff...
>
> This change also affects the entropy of allocations. With this patch
> Android test [1] started failing and it requires only 8 bits of
> entropy. The feedback from our security team:
>
> 8 bits of entropy is already embarrassingly low, but was necessary for
> 32 bit ARM targets with low RAM at the time. It's definitely not
> acceptable for 64 bit targets.

Thanks for the report. Is it 32 bit only or 64 bit is also impacted?
If I understand the code correctly, it expects the address allocated
by malloc() is kind of randomized, right?

>
> Could this change be either reverted or made optional (opt-in/opt-out)?
> Thanks,
> Suren.
>
> [1] https://cs.android.com/android/platform/superproject/main/+/main:cts/=
tests/aslr/src/AslrMallocTest.cpp;l=3D130
>
> >
> > regards,
> > --
> > js
> > suse labs
> >
> >

