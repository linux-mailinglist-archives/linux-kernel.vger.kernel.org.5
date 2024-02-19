Return-Path: <linux-kernel+bounces-72120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545385AF99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D65CB21D52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA056755;
	Mon, 19 Feb 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A837NWHH"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D6535AA;
	Mon, 19 Feb 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384051; cv=none; b=CADBn1rD3RnopIhO+JtR9TTkOfB8dheTeFABjt+VfhzYDczfV+gcdEevy2JSlpFpE/kB+EtCshGU8iTCVg5cGHOuRWauT/qeboGJIj5EcfABioHV6Ov7qIadde1sSbt+m/UYUp1dtqqG+ngSFF2V5FU/280fHTxyoI7zeBBIvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384051; c=relaxed/simple;
	bh=FrvtIm/dANqiXAWz+hg+znL2WjHyXAUvZqY+FidRgI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBgVlxT24dm2y8RGxgLCgdPoZ2AM7lC/dKyPXRBJodutX/WifOR9+B1c/r2voRPC0t+oE+uoaglVJLVjuJtCT0rEbzs8yDCBVBADnFWVC9rMOM6UlvYRfCGuCVDJHazYg8Q4NrpqtDmBbcPaJOIylidBtCwcpBC19PKyCQ7Rf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A837NWHH; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so2281618241.3;
        Mon, 19 Feb 2024 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708384049; x=1708988849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84QvXyb8JVXCLO3ZjIWmLqrLkWXTqbXVqFdIWOBeFqA=;
        b=A837NWHHUO99AQEdsRNyrrnOlZ5kD0uHzqbWFAd8/PhJpxwIlbNMUUV0HrS4X2COs2
         Kv0lotu6IK3E3etaa9UJHwPkgufd2KxPQRnwAjZ4I+fux/2SyYcl2G4tThjwCh8IKpyu
         SY2Sg5Rs/5Js2Flo67h1jI0DqSkYf3UI0gLxNu5ucm1T7rJIiBN2bqEa3xbXzj8o7hCo
         P8PzFcr4pjDFoGhzLqfasoDvFhTFubW1vMMegEq425F5z153rPDLWEUNG0noqnVBCp0/
         FHCIT9RHkEf4yi/ze0HfXOqWSviil5pDoLMLvXE0qHf7QeeyaiuxCoDsCE96LpG/mT/u
         RBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708384049; x=1708988849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84QvXyb8JVXCLO3ZjIWmLqrLkWXTqbXVqFdIWOBeFqA=;
        b=THGLY/R6LP9VOX8MVM9WcG1eFH+Mi/gC2H3Pc7PSXMLBnXrPa0gXhQYpF7ZV3CBRaV
         iNaG+5Fu1uk7i6e5WGaCe2toM5V3ziGWTVloUkLlsWCkrnuTO77onMHLPXX8XC6PQsaF
         fAH8KGMVBws3XhlfrI6ijxAecGMke0j5BREv/Ha5nkXCTS/k6sX3KbuxBfYUCF/Vuycm
         NSjMDHbqfkypux48XxuOtSzV9jin4KhCfFPCAKj1KbTNER1xsgLq+RxGgoOt0W3fsWDI
         v442I+YmLsFANwMamidaqeR20Zz1EQm3T/jf/+uxAI6J4i7cvdYOfD7V7hQuf1XYmlUI
         asTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5H6f5b/jVDu9lYygqpdJNLK1CCqnI+7Rzsr4NZKzqXl+TgX4g2XS7z12ae/R2ob266B1JdDZRIYhEE5ghWwmc+37B8ONx45Uno3kY8LRbEnLMHCrlfs4rdCxSnSUoAO9yukauH+bcjiHU
X-Gm-Message-State: AOJu0YwO92cMen1w7vjLFpsc2Ut2CNO9vRlsFTFXzB5stUpwmHSW+eK8
	W3W6ALcyd1CQDdc5Fl5Jm0kVwwxj+GgXB5biTAoFUIwctsJ2NdMbM/abWhBA8t9G8CW3EGgBPbW
	uRoqxkITyGf1bhz87k8ooslK8+Ds=
X-Google-Smtp-Source: AGHT+IHsJkS0eDTXGnGDk/orxdgfM0pOIAe0qiGz0+Zcgk7QU5Rw/T2eL0zVU2dUIrVeB3RVfeOVX1meaouewu947k0=
X-Received: by 2002:a05:6102:5110:b0:470:6d93:97fb with SMTP id
 bm16-20020a056102511000b004706d9397fbmr565960vsb.4.1708384049006; Mon, 19 Feb
 2024 15:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217045102.55339-1-21cnbao@gmail.com> <20240217045102.55339-2-21cnbao@gmail.com>
 <ZdLYE8mx0AJ7a7+t@gondor.apana.org.au>
In-Reply-To: <ZdLYE8mx0AJ7a7+t@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 12:07:17 +1300
Message-ID: <CAGsJ_4xo02oKGX5nBvaGsSiv+omjah0A5jCGc9wJeU467V8VuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] crypto: introduce acomp_is_sleepable to expose if
 comp drivers might sleep
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 5:25=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Sat, Feb 17, 2024 at 05:51:00PM +1300, Barry Song wrote:
> .
> > diff --git a/crypto/acompress.c b/crypto/acompress.c
> > index 1c682810a484..fa15df394a4c 100644
> > --- a/crypto/acompress.c
> > +++ b/crypto/acompress.c
> > @@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const=
 char *alg_name, u32 type,
> >  }
> >  EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
> >
> > +bool acomp_is_sleepable(struct crypto_acomp *acomp)
> > +{
> > +     struct crypto_tfm *tfm =3D crypto_acomp_tfm(acomp);
> > +
> > +     return tfm->__crt_alg->cra_type =3D=3D &crypto_acomp_type;
> > +}
> > +EXPORT_SYMBOL_GPL(acomp_is_sleepable);
>
> Just because something is of acomp_type it doesn't mean that it's
> async.  You should be testing the algorithm flags.

I guess I got your point, drivers using acomp framework might actually
be SYNC if they don't set CRYPTO_ALG_ASYNC.

>
> So introduce a helper crypto_acomp_get_flags (see the similar
> helper crypto_skcipher_get_flags) and test it against CRYPTO_ALG_ASYNC.

On the other hand, some drivers which are actually ASYNC, are lacking
CRYPTO_ALG_ASYNC for example:

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c
b/drivers/crypto/hisilicon/zip/zip_crypto.c
index c650c741a18d..94e2d66b04b6 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate =3D {
        .base                   =3D {
                .cra_name               =3D "deflate",
                .cra_driver_name        =3D "hisi-deflate-acomp",
+               .cra_flags              =3D CRYPTO_ALG_ASYNC,
                .cra_module             =3D THIS_MODULE,
                .cra_priority           =3D HZIP_ALG_PRIORITY,
                .cra_ctxsize            =3D sizeof(struct hisi_zip_ctx),
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c
b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index dfd3baf0a8d8..91adf9d76a2e 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate =3D {
        .base                   =3D {
                .cra_name               =3D "deflate",
                .cra_driver_name        =3D "deflate-iaa",
+               .cra_flags              =3D CRYPTO_ALG_ASYNC,
                .cra_ctxsize            =3D sizeof(struct iaa_compression_c=
tx),
                .cra_module             =3D THIS_MODULE,
                .cra_priority           =3D IAA_ALG_PRIORITY,
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..5b10bd075a07 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct
acomp_req *req,
        req->base.tfm =3D crypto_acomp_tfm(tfm);
 }

+static inline u32 crypto_acomp_get_flags(struct crypto_acomp *tfm)
+{
+       return crypto_tfm_get_flags(crypto_acomp_tfm(tfm));
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *r=
eq)
 {
        return __crypto_acomp_tfm(req->base.tfm);


Herbert, Is the above code what you would prefer?

>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry

