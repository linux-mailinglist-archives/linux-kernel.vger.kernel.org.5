Return-Path: <linux-kernel+bounces-67990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F9857404
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6963F1C22747
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BAFC12;
	Fri, 16 Feb 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9TDQNNn"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C81FBE9;
	Fri, 16 Feb 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055373; cv=none; b=frhPbE0UI/G/N1sFHiRK3LLIXL+1pKUsxKZU/cLlN3Qh8hIlNnv0DqmZRXs4wwQ09HR3v8Xi/0/5bZ2VX+0THjnXBZNGZT3ullGoqLfcslq/LzNEgkCa+haFy2yCQKBaXGD8UoFeI+O+FGQMlKN+g+bUbwvBPQ1HPxjVFzN4pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055373; c=relaxed/simple;
	bh=Ke9EEEkJAR+xCvjBnRDraJRBtBjI8aGfAXJ3+AxKWrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om7nmBBb0Bbspn5Lfnt4GYEtyv7J3eQQchxO6x+6y0r+xOaXf6LSb768OtToa9uqZyYvycxH7oilV8wFUQn9NxzjOf6Y6FpU/qHLJq7hu185pQBfDH9LT48FiL+/rYIVRVtBycdFrFpzoZ4Alik+kCwnwv+6/rl7MFKmhUeYpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9TDQNNn; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso1137504241.1;
        Thu, 15 Feb 2024 19:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708055370; x=1708660170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynJp+7Vxm22bnOg8hZ+WSOoKLsoGOJ1+wiJ+YkWFQ5A=;
        b=B9TDQNNnzNQwijS7/w2ivwAdzRPH58hUThiICK8PUmjATkx/++Q9SSnueR6OAnxTS+
         lUj0VOIXy7FkbAvDd0YjS5VDJJn6pY+q+Q3G+XEywgdt1SZk11N5S8ksthy8Ip8n7h+W
         T+Iu+V2939MkJ8cZyKp6dge4BL8bVwWCKcHWR2jZ+Lft0BwPOndlA2H13PanaBfRe3Eq
         sINuI+dlUIvxoxzOaz+wpbGzJ2R/3WI710RAHjas7zpiCpmFosAVyIFYKCHqwAB09JB3
         hpTX6glVbpBApRZBYzkTlchxRpPbg8LdoAXBrCyf9W+BWEdiMWQOvnctmui2SrFP36IF
         yjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708055370; x=1708660170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynJp+7Vxm22bnOg8hZ+WSOoKLsoGOJ1+wiJ+YkWFQ5A=;
        b=m0oW7lWjEk5Vb+l+RuBTc/Zfgu5sGm+aUlOF17w2IH6RzcUYd6ACyk7WdMVlKnOB1L
         rVw3h/GF/hYi7ewT+V5Au+7/tVK/EhowhhiGEVN54g5Z6afWAqRkFqyPdKy9o8e9eNh5
         2TCuHhpfkiRK1glML+p0A4CNABbR5jnA7hjfiYYXoFUlU4tQT61z1yoLdGGj759slpWV
         BvzJFjSOjrwgvBfDQUR0N8TCrV8uY+2SXoz/C0rlBzg6zsGItJNCaSdTtB149mICZLDn
         Lue3gjQFid5miWMTkNTW3OFsD0elMMZRenTx/h58pdfN2Ty1PnJ4zsl88J6CphNfcfQT
         PjXw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJwcOrDQ9e9xSppIGJuwUe6KL8Xv+wN99nmCMg3daKb/di0eJJMpV1w7Z/P55PjuMRuO3A9RVvfo9g4cDQEI6xnvkeNIIbkKBbQcgmAPZUH/q15bZ+xiNlx+jEHUGYhvLZjiX35ddGFjm
X-Gm-Message-State: AOJu0Yxx0KA6ot0Y4Ca8zM/LrEagalfQSWWFOIwK+NxvipaZ7xnLcPht
	MP3kmiqTNfmosVLEXs5+I37cayxlQgfGrRvsslc7MadubFbfN4ovcXKjyQXcduYCef+uZeUkzA0
	PZEUhvkf8LbwKvK8NNhZa73JEig4=
X-Google-Smtp-Source: AGHT+IFJMBHDEmoYFbj4D8vAke8PJiuwK4ICXcIhb/lGj6DYvC6T3PNFKGCvOmKyZRUhc57NI9Ke3MJ1XVmYkdNVMpk=
X-Received: by 2002:a05:6102:a4c:b0:46d:263a:31ae with SMTP id
 i12-20020a0561020a4c00b0046d263a31aemr4000539vss.1.1708055370436; Thu, 15 Feb
 2024 19:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095006.608744-1-21cnbao@gmail.com> <20240103095006.608744-4-21cnbao@gmail.com>
 <ZbIwqFJ/uBvG2SQf@gondor.apana.org.au>
In-Reply-To: <ZbIwqFJ/uBvG2SQf@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 16:49:19 +1300
Message-ID: <CAGsJ_4wf+PF-HVnyARTuAhS4bEe-SZ_pSKzPLp2YQcHp4Aftiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: scompress: remove memcpy if sg_nents is 1
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, akpm@linux-foundation.org, ddstreet@ieee.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, linux-crypto@vger.kernel.org, 
	chriscli@google.com, chrisl@kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:58=E2=80=AFPM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:
>
> On Wed, Jan 03, 2024 at 10:50:06PM +1300, Barry Song wrote:
> >
> > +     if (dst !=3D scratch->dst)
> > +             kunmap_local(dst);
>
> This is missing a flush_dcache_page.

Thanks, Herbert!  I'd rather add flush_dcache_page()
to the below place so that we can avoid one redundant
flush for ENOSPC/ENOMEM case:

        if (!ret) {
                if (!req->dst) {
                        req->dst =3D sgl_alloc(req->dlen, GFP_ATOMIC, NULL)=
;
                        if (!req->dst) {
                                ret =3D -ENOMEM;
                                goto out;
                        }
                } else if (req->dlen > dlen) {
                        ret =3D -ENOSPC;
                        goto out;
                }
                if (dst =3D=3D scratch->dst) {
                        scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
                                                 req->dlen, 1);
                } else {
+                        flush_dcache_page(sg_page(req->dst));
                }
        }
out:
        if (src !=3D scratch->src)
                kunmap_local(src);
        if (dst !=3D scratch->dst)
                kunmap_local(dst);

>
> It may not matter for zswap, but this is API code and needs to
> work for every single case.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>

Thanks
Barry

