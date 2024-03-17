Return-Path: <linux-kernel+bounces-105595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CC87E129
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365401F22081
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA892206B;
	Sun, 17 Mar 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjSOhwpj"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A951D530;
	Sun, 17 Mar 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710719315; cv=none; b=tZJEB771uIvMwGN6b9tERTIGl9r9zjlUsOTChqcKdW5PLyTVZyRXLT5DhL912t+ZAABqYObRGLbEFaSelUQEPTGWC7t6U02iA78eT2Pu3smracUa5UMDj9OosjdVb8cDjXw06SNZfnhN7HqKdRVQ5veOnhF8w9XzI7BQhYhFdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710719315; c=relaxed/simple;
	bh=ha4B0JyJqZfkmKdYnAOTVN8AviIgf2IXn+5u7lPWhck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DM65czAQ34ToBeFHtZohaT64t0fF1+bnuLUmD7J+vjNaITaGnBPZmr/CTEV8wAiA8rhOIVp3ozVZr3BIw7xKi57BTygFGfYnhQK13y8wITumhgnpgNmLXH0jRme/9EI7mlMxvqPNq+nNn6nNtQdPk1XeTzMTFkgaHyxQdPvrMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjSOhwpj; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4767bf3e2a2so473072137.2;
        Sun, 17 Mar 2024 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710719312; x=1711324112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQpp+74tvU0a57ZrnFOzkp0hvnhi1SaTowYXx4QiuKQ=;
        b=OjSOhwpjqTSYbgY8yBHfhAMPUuLKc5jZJlEodNRFOaKFf1spFH04tGS0ytFHxNUYIq
         Y0CgJE6uTnDRTMMPX6r81pXVtHt3XXF7s7TZI4MCGDJAbkXOkPuLDmOHdMo4hpAV7UOl
         ECPjU1DtoPefG9+Vnnv+hyES9ILQhSn+vRd9b0fhzfLYT63g2v9/rOH32LWIVGZU3TuA
         gJncYGHkR2UDvd/o7kAgaU6No1enQyDHRBTbvaptxhC5KrlZzdDWAhAfoPdwZdkHjLm5
         iMcp/y/MIicQOiUBSGmM8mnym/4TZ9vpaQADzvlauFsY3sxdsKiaWJV83+giaxxuyear
         VTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710719312; x=1711324112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQpp+74tvU0a57ZrnFOzkp0hvnhi1SaTowYXx4QiuKQ=;
        b=wCCjINA7q5Tqaz+INIJdU/6ZFXHdAFGGP6rBJrTuE1N/nKUK+EBU8qxaAS0i1nWXLE
         2BkZwMTcaeArXhg3uqPsXpcidoVJnfSXAUAI5LF4K9YlKQ9aAmxmEwMGZ7cZ9CBaq0kz
         GtwesUKo9xXjeTkuOLehNpktkYhjEwF51TVykXbRLxj0LUIZwJVTWVCvQizE+hFCFZ7m
         7Yul4K1hwOtMa+hrYswaftsu6u/e/P6A/PfPWxTQ+vYWmeJUdSV2ikr0W7FXOJUau+fv
         8LNWrN1RizueXVEzeNrdRiJFJDChH5ewoE0K0cF82RML/UXxfqwHVySF9wlkDBnZw3nP
         aWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTMcaJ8iaN/TVi+y911lEKxkg8o9oq7jZGB4bb8zWCUSZcPWI7ibx5GTNTtGHmTfVtWyb6UDfMJvOsgRJ74wla0jIndCHiP8PV9ddTAZGVH9dSMChbrtXnRDNYPgLz/eLEFG+WKIqi3d6G
X-Gm-Message-State: AOJu0YzanAWVjjEp3xgfSV7OAkE5ulCmU8GLfaKAgG3yNC82KZI0BAIS
	FN6yCKzARV1WdpmWQ2BgsOwvIrzkhi2XhEQb7GZNmWcmCcrKOAKFgPU03vOdaxNLGvU9pZFqybJ
	v1paAqZXkg01hYBLCK3/Z2unULHs=
X-Google-Smtp-Source: AGHT+IFolsIKODEOLB5X/UdeXPTrBXkJY64Kf3qmdjcfxvYGfkAW29/5iyHh1nL3tKt1Toka9slu9L3Y3wcKrAWHO+U=
X-Received: by 2002:a67:f415:0:b0:474:c475:6cf3 with SMTP id
 p21-20020a67f415000000b00474c4756cf3mr9130062vsn.6.1710719312280; Sun, 17 Mar
 2024 16:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192745.14987-1-21cnbao@gmail.com> <aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net>
In-Reply-To: <aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Mar 2024 07:48:19 +0800
Message-ID: <CAGsJ_4wWEdxk0qNV89bL0zeGaXUBb7h92mdNeRCgcUCY5C84ww@mail.gmail.com>
Subject: Re: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
To: Guenter Roeck <linux@roeck-us.net>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:13=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
> [ ... ]
> > @@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_re=
q *req, int dir)
> >                       ret =3D -ENOSPC;
> >                       goto out;
> >               }
> > -             scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->=
dlen,
> > -                                      1);
> > +             if (dst =3D=3D scratch->dst) {
> > +                     scatterwalk_map_and_copy(scratch->dst, req->dst, =
0,
> > +                                              req->dlen, 1);
> > +             } else {
> > +                     int nr_pages =3D DIV_ROUND_UP(req->dst->offset + =
req->dlen, PAGE_SIZE);
> > +                     int i;
> > +                     struct page *dst_page =3D sg_page(req->dst);
> > +
> > +                     for (i =3D 0; i < nr_pages; i++)
> > +                             flush_dcache_page(dst_page + i);
>
> flush_dcache_page() is an empty macro on some architectures
> such as xtensa. This results in

Hi Guenter,

this is a bug of xtensa, could you test the patch:
https://lore.kernel.org/all/20240313045036.51065-1-21cnbao@gmail.com/


>
> Building xtensa:allmodconfig ... failed
> --------------
> Error log:
> crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> crypto/scompress.c:174:38: error: unused variable 'dst_page'
>
> on the affected architectures.
>
> Guenter

Thanks
Barry

