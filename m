Return-Path: <linux-kernel+bounces-36596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED083A390
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC1B292423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF2171CD;
	Wed, 24 Jan 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjz3HyVu"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17C171A2;
	Wed, 24 Jan 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082846; cv=none; b=fnyHV31PE1JKSSg1thYQujNmhlB+0JtopLNx8MibwMsWILHGqNa7ivxqmxHW6rwtM8vKMatGAybr975La7ApID182D1IZOAlGyuL8Qrlhs1nyR6cPdqmdhv+whOBah8jh1r4ifG2gmch6lGgt6ue+GWYyyR1BFLprVFO1LPAQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082846; c=relaxed/simple;
	bh=3t6xH3QbW5FMmzWRwU4q1T3GJ8BzpO16CpDp0xXh9LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2t8i58UsObUP4/QiAJdqJ1XEQ/ZKQjwNIrMLW/r1C6hFFE0bj6s2KUeDXp/phkn/K33rquuD7ceMFe3PkWs/C7TECq0+yN1R8LwmM0cNPDkzZDZ0qaghlV7+7ByitaJhWnOZR+LrXiI6V2x9jj8x6DhWG+b7g45Guv+t5GHEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjz3HyVu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100b424f8fso1242140e87.0;
        Tue, 23 Jan 2024 23:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706082842; x=1706687642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzlYpDM5q2ItPg3GY2j9GxLh93+1lpjpq8xQsFJhc/Y=;
        b=Pjz3HyVuLaTt6aqgu+cLnpC2hLjRtfQ4RQgPyakOB75GHuw6EeTwrF7GCYAwuat/9B
         sEJ3Z4Ojl/n8EjesevEp2xvLEalt+quuNhm3UjTkarFFiudKglVQN4UX5rcctrt1zeV1
         zvmGV8HxDWhj3wLD3gnobWz0p8c/D9lMxVJi89LH5lub5dfHsnL+RPuG91AYeiji18dp
         XQMF3ZF7f5etaxujXjwK9/R65WH6lXs797RQfY/o1N5PeyifIp1SGkYRKVG6gfY+j9W1
         npPSiBV5QUwX7dvyGyUxpSQUD5ZzXc+WsFDDzOTMwQEHvk9Ns4Y/grtnTXZ+ZEwWATB2
         PFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082842; x=1706687642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzlYpDM5q2ItPg3GY2j9GxLh93+1lpjpq8xQsFJhc/Y=;
        b=urdBUJTUDB+Dy3UGIVYAs0lXKbbyfz4ZBQwbQ7ca3j6KYMFU3kbHtWAioDMkCvA78p
         IfudmIhRYNSyppGL0Z6kEdPF4iMLLL1H+nFT5Mj7zrscax3/eDuHL0KdXvcF1LGhFk0w
         eSdzPl7xqy4t1pSTYcuw3Hfq5+9tjgZEFNkO8v4cIAqR691P6OZDnqVa/OdO778eWSpX
         PS3vTwhnsN4CFySERaRc+hzPZtPTgeg3xAmJNvGgQ2B7AFecjxDA7zUwxHbfWQ3lK44t
         iXxJ6NgaWhe9F8FdA4q8YDbbggmyYju/73pJuqt5MwgAMYaiBSWLmpGg/4xgEWuOqbYN
         TuYw==
X-Gm-Message-State: AOJu0YzD+K1TA9mIFRfi0YrhYzphXLdVfh3wtVnse8jjcjREOv6luTH9
	foIYUKzNa/cSGjVx4AqXcdMdHL56CnU6uVUTMeMj5Py1vgApQqxB7k8LNUjgmJovreLK2UOpiRC
	QSVS7kgPpd7ZGuOIEqeuogVYrMcNQMncb
X-Google-Smtp-Source: AGHT+IHzMasL7hD1TBMeJJAKJBMXLqBHrgDkRbfINdmnbYWspCldchti2DFDIAWqmZv9FFaEISvj6Gg9pe25h/ADf/k=
X-Received: by 2002:a05:6512:6c2:b0:50e:c642:3aed with SMTP id
 u2-20020a05651206c200b0050ec6423aedmr4218396lff.43.1706082842020; Tue, 23 Jan
 2024 23:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com> <Za+5uEpmNWbT8tXt@infradead.org>
In-Reply-To: <Za+5uEpmNWbT8tXt@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 24 Jan 2024 15:53:50 +0800
Message-ID: <CAGWkznEu5u1-MgK1XoexDkRetp34b_D1KvmDLfaOayY959BBOw@mail.gmail.com>
Subject: Re: [PATCH] block: introduce content activity based ioprio
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:06=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jan 23, 2024 at 05:33:52PM +0800, zhaoyang.huang wrote:
> >  #define ALLOC_CACHE_MAX              256
> > @@ -1069,12 +1070,21 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
> >  void __bio_add_page(struct bio *bio, struct page *page,
> >               unsigned int len, unsigned int off)
> >  {
> > +     int class, level, hint, activity;
> > +
> > +     class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +     level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +     hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +     activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> > +
> >       WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
> >       WARN_ON_ONCE(bio_full(bio, len));
> >
> >       bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
> >       bio->bi_iter.bi_size +=3D len;
> >       bio->bi_vcnt++;
> > +     activity +=3D (bio->bi_vcnt <=3D IOPRIO_NR_ACTIVITY && PageWorkin=
gset(page)) ? 1 : 0;
>
> The block layer must not look at page bits.  I've fixed all this crap
> with a lot of work and we're not going to re-add it for another qute
> hack.  The place to figure out any kind of I/O priority is the file
> system (preferably using generic helpers).
ok, will use helper function in next version
>

