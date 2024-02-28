Return-Path: <linux-kernel+bounces-84812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393E86ABE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC839286BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C04374DE;
	Wed, 28 Feb 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToUa9jT5"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F8374C2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114996; cv=none; b=dFfQCgLcQH5ShsvPGBVKTwRUtsPsjuv8V9YelaDkIV6jcbsOVaJxEQd+ShffC+7oimPV1YS52ZoN61z9+/thiOmdsSQGc57nOgf7VYuWJT/3ZLu8+0laDr02klgrH+mWzqs7fbv+p0f+g2eByIeOIxH6D93S7PIgCAOiw0v0LG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114996; c=relaxed/simple;
	bh=xDkKjxQpRUj82ppPpFRdT86UyQry3guk02MGD+qyIKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4mPD80RuCqZFgJXewxknMsqvLWrkvhH8y58/Uu5O0WOxFuQErZMFX/zsYWTCxECEv1I9CywIfZT7Q5M6yx9G58hWZshikxhGp8I39o2weeHsYH0e6bn+WUngCmrxU+z0J70qcaLUL/ofg+FFLLWT/F8G9cTTHTJ6lDGc44F2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToUa9jT5; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4704c69a3d9so829210137.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709114994; x=1709719794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkbZnM4zUKTeRZ6grRhqdDU4kcmxS6+jabdIxX7mZ+8=;
        b=ToUa9jT5iXLoWFlco3+Zzs5yAIdWhjD3kUjzLAhiTRJxerN0m6OyWCxEjnRaIkK7F+
         sNoEq0Km+e+TOr2ywFmzCq+JJ31f62jf4rlyrVYg6g6/lbrfv4XRGGleep8XzvM9WpR6
         RIhJhOiIB/TnHSUx/pNW9u6nMx892LRW919QhOY2o/O+LuCIya02GRoO8BJPRj4xfN7o
         TIpSyHbE3KPaa6BddoOpmTwW6VVvi7Qc3Nqf0aQvPw6+cI9g4O89iGKC9T+h1lZqt6mt
         scOg+zvrCyUZHI+YTdkutmCR5zDcgU2crmMFw4LzJTbu25EAcvwgC50wB2FhRMbn0OU0
         89/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114994; x=1709719794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkbZnM4zUKTeRZ6grRhqdDU4kcmxS6+jabdIxX7mZ+8=;
        b=RiVzxrqpu1AWry2mjpaxWQn4lqRef5wERKPHRP7zGoqCH3LrHLADsAVxq9yHRUHirT
         duj3Celt6NdSf3zXWE4XHypBM5A06K8Zi/IiBkDsmADDOlOTlOa+v4gEtjRIQ8Dp53wY
         1sH0jFQFlmzE1QWmBhvcuu04oglrUw5W6jYUvSRYqAUL1qumD9xQckpew8tXY4Hfzize
         EfIA8lssHUzaXQCcS6FiaSJoNSYiua6lGAlHdMv4BSCHQa7xsAbXtledCRTA37yiTSeD
         Mh6dttNxwjbBB+ATT6NJ/zGmkPXkotAxDYmyuxpCbQIwvFAmUPsgi1wece/s4dgZmLX3
         fhKw==
X-Forwarded-Encrypted: i=1; AJvYcCX0he1YsQ84l6i31keLAvDf6DpHZGE/NsiAAOrsC9hSym8N4Mdgn9Gt/zVqj13G/WvlUBPU/H5ucAmKBCtYBmQjNbjr8/DFRJIb7Bv1
X-Gm-Message-State: AOJu0YxG8TUJ5B5NhKlt/gye0XqdsDPh6ciNCNUhhxgCqU0QdQp4HxcI
	G39W6sR5YKj/ym9/EpFuEvcdUnbiRwhSwcgZijFWxXucM0aDdjxxlHcVBd1um3q+fRwQ92UyfyZ
	xFD4IbUKdqruev6VRgE2KlyzIaY4=
X-Google-Smtp-Source: AGHT+IF/SEs+hX15r1XGp/VDiYdDgU0ARaAjEu/4Jr+jiImJahk5OhxM1h5WTeI+Kzyuae0ylWCRvDOq9tjbqwZ3aas=
X-Received: by 2002:a05:6102:1942:b0:472:5572:fe32 with SMTP id
 jl2-20020a056102194200b004725572fe32mr3525827vsb.13.1709114994045; Wed, 28
 Feb 2024 02:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com>
 <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com> <fd71a174-e4cf-425c-a619-0d7c15cd91f7@oppo.com>
In-Reply-To: <fd71a174-e4cf-425c-a619-0d7c15cd91f7@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 23:09:42 +1300
Message-ID: <CAGsJ_4xpJ2FtLRxJT1fORHXzEiajiUJ6q_Pz8pwjYmVOmnaP5Q@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
To: =?UTF-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>, 
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:02=E2=80=AFPM =E5=88=98=E6=B5=B7=E9=BE=99(LaoLiu=
) <liuhailong@oppo.com> wrote:
>
> On 2024/2/28 17:34, Barry Song wrote:
> > On Wed, Feb 28, 2024 at 9:51=E2=80=AFPM =E5=88=98=E6=B5=B7=E9=BE=99(Lao=
Liu) <liuhailong@oppo.com> wrote:
> >>
> >> If vm_map_ram(page, 0, 0) would cause panic by vmap_pages_range_noflus=
h, so
> >> change IS_ERR to IS_ERR_OR_NULL to fix this.
> >>
> >> Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
> >> ---
> >>  mm/vmalloc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index d12a17fc0c17..109732006cf7 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -2387,7 +2387,7 @@ void *vm_map_ram(struct page **pages, unsigned i=
nt
> >> count, int node)
> >>
> >>         if (likely(count <=3D VMAP_MAX_ALLOC)) {
> >>                 mem =3D vb_alloc(size, GFP_KERNEL);
> >> -               if (IS_ERR(mem))
> >> +               if (IS_ERR_OR_NULL(mem))
> >
> > it seems the only case for vb_alloc to return NULL is size =3D 0, isn't
> > it a bug of
> > caller?
> vb_alloc had already checked the size =3D=3D 0, so it should be return NU=
LL
> to caller or not panic here.
>
> In fact, we encounter z_erofs_lz4_decompress issue.
>
> [54032.383633][T25392]  vmap_pages_range_noflush+0x790/0x8f8
> [54032.383637][T25392]  vm_map_ram+0x1c8/0x10b0
> [54032.383642][T25392]  z_erofs_lz4_decompress+0x60/0x1e8
> [54032.383648][T25392]  z_erofs_decompress_pcluster+0x624/0x9fc
> [54032.383653][T25392]  z_erofs_decompress_kickoff+0x18c/0x224
> [54032.383658][T25392]  z_erofs_decompressqueue_endio+0x1a8/0x1e0
> [54032.383663][T25392]  bio_endio+0x188/0x47c
> [54032.383667][T25392]  clone_endio+0x1a0/0x550
> [54032.383674][T25392]  bio_endio+0x14c/0x47c
> [54032.383678][T25392]  verity_work.60258+0x7c/0x13c
> [54032.383682][T25392]  process_one_work+0x1b8/0xa98
> [54032.383687][T25392]  worker_thread+0x160/0x6c0
> [54032.383691][T25392]  kthread+0x15c/0x1d0
> [54032.383696][T25392]  ret_from_fork+0x10/0x20
>
> z_erofs_lz4_decompress has checked the return value, so it's reasonable
> to return NULL if size =3D=3D 0.

I agree. but there is no reason to activate a WARN_ON in vb_alloc as
obviously it doesn't like it. so fix it earlier.

I even feel z_erofs_lz4_decompress is a better place than vm_map_ram
according to your description. but at least vm_map_ram is better than
checking a vb_alloc's ret after it gives a parameter obviously hated and
causes complaints.

>
> Brs,
> Hailong.
> >
> >>                         return NULL;
> >>                 addr =3D (unsigned long)mem;
> >>         } else {
> >> --
> >> 2.34.1
> >

Thanks
Barry

