Return-Path: <linux-kernel+bounces-84385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E04986A61D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01351C23611
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B520B29;
	Wed, 28 Feb 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nofOtnos"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4B20B24
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084795; cv=none; b=eHlj6TKRpdqV4BIFl64Hy6CV0G6t9X7q+DZOwGgKwe/2vDfddGSj9/Qzp6TtN2N5b1Zda2kpg3nSjTEBT98/eCBcT63B5oaraz1A3IutRcOf/hWJEdazBR5RoT8VFIg52KI/E1G0spZ7z3XfZY0Sw+KJXS5ghU7cICWOBUulFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084795; c=relaxed/simple;
	bh=fs+l0pKd9Ov680ClR46avEPmjYi7OZu9E2GebkAwaIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGKtW85vfo2BhK4XkvY7p5lCgF/5xEooXGFeBuQHdtqg4xmGa7V5CI8TT6BK4IYJwDVLN5BZqroZEg8R3yVM9lS2zwMd9wpRSD9hhtwgOgiGKU/Q22NQ7vhv80oFMsy71s3DDav/8rLT5mlFmo5jNZWlNnd02UdlW3lCnsz8hL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nofOtnos; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60915328139so25246997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709084793; x=1709689593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66cn6DXc79Sno5wggi7HSXHWH/kH93OR0PebifMA0xQ=;
        b=nofOtnosutaXieGZfYL9Jt4f2+l95GBJiImfUz+Zg+4R8w5NUGEI16t8DKe+tKeRML
         ImowLBd2u8KcU52l+oKyAlhEa++EXbgBmtx79URJFRnLbkMci7bmFro5kiHRkCEaPWuh
         D0+qE8lmgKZzmUNfEwcOyZ7McFIANyFrmlgmRWws4ZYu9NF44NTl6yaDYPK5QgVofXbI
         bI7IShY0go0ey50EfteFWKjq775bONanoz6kHW/a7uZyb5mLIvk78gO2AbWIgrPsEU1m
         oVnRj0G/xEfN/v6hWvvqBROP7mLXxk64JmT/yeAlrbfyEs7XfpfsSPim//Ij5htSl2fq
         kdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709084793; x=1709689593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66cn6DXc79Sno5wggi7HSXHWH/kH93OR0PebifMA0xQ=;
        b=bFJXRDKVAMKDlMBjQ4ATUjjSCfIWUmuP52u32/bdH9oZeVyC34RpUlL/IUBdtXco1Z
         sf5P6+Sc8jrG4b9OsJ9h11jBBNVD6TzbHSk0vUB2yK3F5AfHU3TNhobEbTUeVTXeEVIz
         5am5efUAZySqiMcpD8G0fPw4Eh7LeTIvGBTL6M1cMIM13GvXj531q8RB7rycLJ70+jTf
         2Oeskbn3zrtR9ygJkWq/t2CtK43qkRQjgv9YVQRaAxivUB+Nm0N4Ia25sN+tRKJ6YYVh
         GbylOxJTx5icAWVP1wNkgJID9uCB7lRo80DZwv7NYnCrVF64H/HLf69uz/l1EKwPWH5v
         FadQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnFZLpZKr/6V+J8IaLbI+Xg/gsvu63Lr6jOJN20iiLlN1y+4nwLwXVJD4SJqjHqqwDYxMCuitTyA5VUR98I9wRoAyEijjhju2TqV22
X-Gm-Message-State: AOJu0YxGbpXVNQwLVkZYxB+Tm4jF2QPHF199VmJYlXaXzxWqqtAaDB0x
	C3DotzYUk1zFDk+aDzA5fN6/Hm1w3DnVhvEi6doNrdENZzJAsTxnHdBmK4VEIo5Sk6KTJTbUvHp
	1uLVrVu45WOH8UPn6vhV7eUY6V1/prfp2v+2sAsjG
X-Google-Smtp-Source: AGHT+IG4HucEn1faUd+ZF0DGwKqb+Hfz/1zlzPU3M8kGwG33MXRElqaYYlU9JFNAPbhH+FSW7G3DHMiyGL9JvXwflKw=
X-Received: by 2002:a05:690c:5:b0:608:d5b7:87b0 with SMTP id
 bc5-20020a05690c000500b00608d5b787b0mr4182816ywb.48.1709084793161; Tue, 27
 Feb 2024 17:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <Zd4HEjS6vpIvwfR9@infradead.org>
 <CAGsJ_4xTtLzUKSY7EzEK0Ho61mWH35kHkidBRpjLd+_3_yOaUQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xTtLzUKSY7EzEK0Ho61mWH35kHkidBRpjLd+_3_yOaUQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 28 Feb 2024 09:46:21 +0800
Message-ID: <CAK1f24mN2jTuhhAq-KAZczdp9OPf90b5JRNiyszWNRt+n0aK=g@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:02=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Feb 28, 2024 at 5:00=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Feb 27, 2024 at 03:40:50PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > madvise and some others might need folio_pte_batch to check if a rang=
e
> > > of PTEs are completely mapped to a large folio with contiguous physci=
al
> > > addresses. Let's export it for others to use.
> >
> > It doesn't look exported to me in the patch (and that's a good thing!).
> >
> > But even for making it non-static you probably want to include that in
> > the series actually making use of it.
>
> at least two parallel jobs[1][2] (maybe more ) need it right now.

+1

After kernel support for anonymous multi-size THP, PTE-mapped THP will
no longer be the exception. IMO, folio_pte_batch() is widely useful for che=
cking
whether we're mapping all subpages of the large folio or not.

Thanks,
Lance

> Getting this one pulled in early
> will help build a common base for them and avoid duplicates&conflicts in =
them.
>
> [1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail=
com/
> [2] https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gma=
il.com/
> >
> > > +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> > > +             pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> > > +             bool *any_writable);
> >
> > no need for the extern here.
>
> Yes. this has been moved to internal.h as "static inline" in v2:
> https://lore.kernel.org/linux-mm/20240227104201.337988-1-21cnbao@gmail.co=
m/
>
> Thanks
> Barry

