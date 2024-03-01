Return-Path: <linux-kernel+bounces-88322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0A86E007
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1342A1F237D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6286BFD4;
	Fri,  1 Mar 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FckhzRTP"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342820E6;
	Fri,  1 Mar 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291876; cv=none; b=baQMZuOrPBwW43LCA6i4uTld2CRlHszgW1JjzU3NtS4wbMS3n6F04Ia4TQX+uJXsuRbhMcXupYVXawUCJHiJzR8eQzs3Yu2Uo3N6f6PxqVBi6BKg6o2MK0zupBcAV4uYjb7P24uBbCK/c6lAx2UZVbrUN561D2z43GA/2i0U4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291876; c=relaxed/simple;
	bh=D4Yzpe7+BaiWIZI79CoBEFuH6u33sbHObSSwGbqQXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eiw2ECyPmKy3zdt2Ndocw5RoV3iHAwTV0ga/hXz8bkuqjYCIzkCZP0D+b5UuvhscE0SxoUkmdtJdCfGRFNSwjPUFkU79AulSU+L1D9l9NHkCmJ0QOjWppXOvEJR/r7ntpJrdn2svjsXYDo7e3iAaIW5hXhVVRAWELBKmRfwQWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FckhzRTP; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47265631782so444049137.0;
        Fri, 01 Mar 2024 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291874; x=1709896674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PIzBFt3045Qodp8Tc294RcaDOpUCULciO01suUMZ2Y=;
        b=FckhzRTPYbWyFXi9YY/sEKAy+XOj6ov05hbjcmLGM68HWsQ5jZs+s4CcF4O/d7Hz5z
         oT9TzAH4NWnBOATDnOsBsrvG+kXO6Arqk7qLxvPL17rs4WzzM8gbnpR8poKla+kPlhUu
         EQEzonpCDWC2TWipoxd1/7k6wwqKk5wNKLSehPkOW3lV96DSO2ALyznauTBDEnudkqgD
         qFFvjYTzAzkadBaQsWdZm2Gs7UOCGdy5YiL8qG1s0INwZZF/ces7NLgpgXa/Opzz+Ghb
         mWNurQqkkakAKixewxTn4nPiXqgTkPbzGnWRdeoASlWbrMH+utScjbCe+zxDzSew2aJm
         Kk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291874; x=1709896674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PIzBFt3045Qodp8Tc294RcaDOpUCULciO01suUMZ2Y=;
        b=RP7249RX6wzSILBsJ+9TGU5YlJe9jv1qVJN5ntkdLKV5/5NbllgaTcG3gDU8Es1LGG
         Fx/U20VYV8Z6ZgrnwdmMCfNWuoXxM40U6Vi2UMYlKuy3c42xaf6qvICgLwiwpQhZliiU
         cXl4/gTmN0Boz+6crZ5vkLBq6liGOSKahTOi4GSpOuD/p3OAM2uQMFdDdxGJzgvvuubz
         xJBACs8j1QJtfvQR8hNlMzC4AWl4SypNj+4h23v+Tt/n3ZYlGtdD2gPkQtTWX5v3rLTt
         +eji3nsVamfUUxeVwnsyiGzbp7N81D8+3jKwpfH4FhYqIYWw1x22uz+xuHtpFKaUONcd
         QoEg==
X-Forwarded-Encrypted: i=1; AJvYcCXuwpEwCeABbt7nrpzUOQEGLPzo4N2fnJFcCFENFZraNuYb9M1hG4D5rJdkVTWHm9O7/lBuEy/QGKdDmqK+QIZf9wdXcv1GTsIVTGisyb/dOG4UQP9tKIjP+dNfjl+43sKSjeQsG+7dCd2j
X-Gm-Message-State: AOJu0Yx+ZeuiX1uzZP5I2PJ5+GKHyO1dBCujMbKkPbJpU1iOr+QHCYxf
	bnXqKBzt+E57LgTRQqVioJy4XQrknSnRTIskiQ9kPtX0P8B9xuD2Tnr4MZiahnkOTm1OphKjJKj
	EQNDHc/hju1Mj3DaIC3EYGTYbs0w=
X-Google-Smtp-Source: AGHT+IEVUu5WnCqYzCDVF/JN8zQh7b9mKD8dIEo85xmhV+/TubfvNX658CQmk3ZrNVANuGIUx+iSoSocNWzV57UojK8=
X-Received: by 2002:a05:6102:134f:b0:470:3ade:7b99 with SMTP id
 j15-20020a056102134f00b004703ade7b99mr1036570vsl.23.1709291874194; Fri, 01
 Mar 2024 03:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222020617.31041-1-21cnbao@gmail.com> <ZeGtrvm9WGv5cxQV@gondor.apana.org.au>
In-Reply-To: <ZeGtrvm9WGv5cxQV@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Mar 2024 00:17:42 +1300
Message-ID: <CAGsJ_4wPeXMZTAQpXsqN0Q3E5_vvF83UzeoVqL01qjnDZACJzQ@mail.gmail.com>
Subject: Re: [PATCH v6] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>, Chris Li <chrisl@kernel.org>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:28=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Thu, Feb 22, 2024 at 03:06:17PM +1300, Barry Song wrote:
> >
> > -     scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0)=
;
> > +     if (sg_nents(req->src) =3D=3D 1 && !PageHighMem(sg_page(req->src)=
)) {
> > +             src =3D page_to_virt(sg_page(req->src)) + req->src->offse=
t;
>
> Incidentally this made me look at other uses of PageHighMem in
> the kernel.
>
> The one in copy_page_from_iter_atomic looks buggy because it assumes
> that the kmap never maps a page if PageHighMem is false, which is not
> the case for CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP.

You are right. This needs to be fixed.

>
> > @@ -152,8 +165,12 @@ static int scomp_acomp_comp_decomp(struct acomp_re=
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
> > +                     flush_dcache_page(sg_page(req->dst));
>
> I think this is still wrong for the > PAGE_SIZE case.  The existing
> code flushes each page sequentially  but the new code only flushes the
> first page.

right, can it be fixed like the below?

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 185d2359f28b..d85f0318f273 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -169,7 +169,11 @@ static int scomp_acomp_comp_decomp(struct
acomp_req *req, int dir)
                        scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
                                                 req->dlen, 1);
                } else {
-                       flush_dcache_page(sg_page(req->dst));
+                       int nr_pages =3D DIV_ROUND_UP(req->dst->offset +
req->dlen, PAGE_SIZE);
+                       int i;
+
+                       for (i =3D 0; i < nr_pages; i++)
+                               flush_dcache_page(sg_page(req->dst) + i);
                }
        }
 out:

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>

Thanks
Barry

