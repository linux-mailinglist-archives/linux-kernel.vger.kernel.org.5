Return-Path: <linux-kernel+bounces-72133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4485AFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0543282F76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF856778;
	Mon, 19 Feb 2024 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7h1/DEA"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F850A98;
	Mon, 19 Feb 2024 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385668; cv=none; b=MeUTM/7OzC9S2Oo8iVf42dISh+9J6QL0iiGntCgTxkVMMzd4YmT3LWECMbd91Cs0GttpvfS7S3EF5aeU7WjNLbPEVaTbQaJcnXyG5WgTjopLKGaN70ZvE/euFIXBEcUoJCm39ZM1WFvtU7etjO1EoNaH5kOlmI+Twci50lTiyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385668; c=relaxed/simple;
	bh=CzieSxkoG1zST6hxWsw+rZeYFiANR8Mb9+qCQ/dMX5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQIcb7l6jCLaHbZYqjznEwmC5OaiXfxtCTJ6xm5QsYQJs2FOmgLohN2Y8WMUw3RfIzFAWk1AtAkdU4yGFCbLPyFkY8727BI04RyGbOQBjULwhHvWB0FkNkw1iWv2ikucsIf+pci8zNcRqziPhi4LjzwVAcKOCTVlMLh5q3sY94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7h1/DEA; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso2827013241.1;
        Mon, 19 Feb 2024 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708385665; x=1708990465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYfQRgerInCmwNvZqW81uhkqssL/LY3qNELwtrgooew=;
        b=U7h1/DEADhmxMTDpEfFzwMGatEjqTjnAAFn7o61lhBuzo/Hlxt/75d96Ci2ltEgSdB
         WkXjPxeUZvHIq9wvzZfLSOtOlWUWvPue1mqX4DI74RqaXzhDFSvb38Fd9SqvfIP8JvyY
         1dQiKlDOHRz5xzirYRHexP2v0IRVOufGpcAEhl7sOXTbMzLR1eDPnFu7u6z6gqaTE/Py
         wsQJVnMSg1DrNcoaHvf/gJFAW2x/JTplkkVUk7Xt9oZtuURRYVYw+hIwc7dm3YNIA0jU
         sEeC/DK67S9U26WuXqvvEq5uXrSGF9VZSm4D+puJlGnqjDs3M9iVXLwg3JFrEzKt6c7S
         /RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708385665; x=1708990465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYfQRgerInCmwNvZqW81uhkqssL/LY3qNELwtrgooew=;
        b=KCwSLMmC7XRaUbbk3oQKVXJVdVRVvdHrDlDkXhS+1On5ikrepQBcfqaoMssA1iwiMH
         gLgeA+XgD76khTBxPNj7nnoAFlpOhMLhmTdV9gTcTbT2ZjWfNbvfhJcFU8RmmnNsxWrA
         zY1n8nbrmZJqMkMVhIKaSajo/m0REJG9ehhDRIml7ey/qRfxrrfc5QJXnlhhAbCBnOEM
         lgYh38rvSKKQUt8NeilnPL7ROdvSur+ND1OoyL6SujjLAGJqbSzvOkt7K8zVmqZd6u9a
         V4MdmcQpsk7ti3SukSBekLEI8nXhj8n6oEdh8dPPwmZIbPGlPe+Syluw6U+YN5O2gfCd
         z/7A==
X-Forwarded-Encrypted: i=1; AJvYcCXCd6o2ckm+RzxT+PZQsQupbEqGmpelRB4I8NKd8YwNniGrF5Ion/ZBlPlwbIBjWWTqnq+PpBAbmuEZWJzboSPG1E2Pv3FELRg+BqbWel0CxJ7TMYnCaNyxJJ0+O03JCAOIRSN4183JJfz5
X-Gm-Message-State: AOJu0Yx+nNHpWWxh18fmgRrRLeuKkc/0Brg4M4z/hc+wbf9Gtrge5cGM
	vvc7M1WPtu/7DQolADMPB86lYE9hlCUNjDYEqppNRyC9kuFvzYlQhs9u8G56PhUBk8kmqQ4bSZz
	XT2KRtFCxVoJgqcvNNAn0KsVswmA=
X-Google-Smtp-Source: AGHT+IHwkTvyF1TswRoNzdISthd89fzuOxw7pUd6Bks5jp9D6WExL/64dz8lBAZZTYmsoQTyR5kerUTdbLJ6xL08xHE=
X-Received: by 2002:a05:6102:a4f:b0:46d:2956:6b11 with SMTP id
 i15-20020a0561020a4f00b0046d29566b11mr14474307vss.16.1708385665377; Mon, 19
 Feb 2024 15:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217045102.55339-1-21cnbao@gmail.com> <20240217045102.55339-2-21cnbao@gmail.com>
 <ZdLYE8mx0AJ7a7+t@gondor.apana.org.au> <CAGsJ_4xo02oKGX5nBvaGsSiv+omjah0A5jCGc9wJeU467V8VuQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xo02oKGX5nBvaGsSiv+omjah0A5jCGc9wJeU467V8VuQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 12:34:14 +1300
Message-ID: <CAGsJ_4zGnsD+f9+yQ0N0v=9nTJtQAUL3177vWQoSUzUOn-mYVA@mail.gmail.com>
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

On Tue, Feb 20, 2024 at 12:07=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Mon, Feb 19, 2024 at 5:25=E2=80=AFPM Herbert Xu <herbert@gondor.apana.=
org.au> wrote:
> >
> > On Sat, Feb 17, 2024 at 05:51:00PM +1300, Barry Song wrote:
> > .
> > > diff --git a/crypto/acompress.c b/crypto/acompress.c
> > > index 1c682810a484..fa15df394a4c 100644
> > > --- a/crypto/acompress.c
> > > +++ b/crypto/acompress.c
> > > @@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(con=
st char *alg_name, u32 type,
> > >  }
> > >  EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
> > >
> > > +bool acomp_is_sleepable(struct crypto_acomp *acomp)
> > > +{
> > > +     struct crypto_tfm *tfm =3D crypto_acomp_tfm(acomp);
> > > +
> > > +     return tfm->__crt_alg->cra_type =3D=3D &crypto_acomp_type;
> > > +}
> > > +EXPORT_SYMBOL_GPL(acomp_is_sleepable);
> >
> > Just because something is of acomp_type it doesn't mean that it's
> > async.  You should be testing the algorithm flags.
>
> I guess I got your point, drivers using acomp framework might actually
> be SYNC if they don't set CRYPTO_ALG_ASYNC.
>
> >
> > So introduce a helper crypto_acomp_get_flags (see the similar
> > helper crypto_skcipher_get_flags) and test it against CRYPTO_ALG_ASYNC.
>
> On the other hand, some drivers which are actually ASYNC, are lacking
> CRYPTO_ALG_ASYNC for example:
>
> diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c
> b/drivers/crypto/hisilicon/zip/zip_crypto.c
> index c650c741a18d..94e2d66b04b6 100644
> --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> @@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate =3D {
>         .base                   =3D {
>                 .cra_name               =3D "deflate",
>                 .cra_driver_name        =3D "hisi-deflate-acomp",
> +               .cra_flags              =3D CRYPTO_ALG_ASYNC,
>                 .cra_module             =3D THIS_MODULE,
>                 .cra_priority           =3D HZIP_ALG_PRIORITY,
>                 .cra_ctxsize            =3D sizeof(struct hisi_zip_ctx),
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index dfd3baf0a8d8..91adf9d76a2e 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate =3D=
 {
>         .base                   =3D {
>                 .cra_name               =3D "deflate",
>                 .cra_driver_name        =3D "deflate-iaa",
> +               .cra_flags              =3D CRYPTO_ALG_ASYNC,
>                 .cra_ctxsize            =3D sizeof(struct iaa_compression=
_ctx),
>                 .cra_module             =3D THIS_MODULE,
>                 .cra_priority           =3D IAA_ALG_PRIORITY,
> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index 574cffc90730..5b10bd075a07 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct
> acomp_req *req,
>         req->base.tfm =3D crypto_acomp_tfm(tfm);
>  }
>
> +static inline u32 crypto_acomp_get_flags(struct crypto_acomp *tfm)
> +{
> +       return crypto_tfm_get_flags(crypto_acomp_tfm(tfm));
> +}

This seems to be wrong. we are expecting cra_flags not crt_flags. should be
the below?

diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..07bd8f6bc79a 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct
acomp_req *req,
        req->base.tfm =3D crypto_acomp_tfm(tfm);
 }

+static inline u32 crypto_acomp_get_alg_flags(struct crypto_acomp *tfm)
+{
+       return crypto_tfm_alg_flags(crypto_acomp_tfm(tfm));
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *r=
eq)
 {
        return __crypto_acomp_tfm(req->base.tfm);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index b164da5e129e..811bfaf8b6f8 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -467,6 +467,11 @@ static inline unsigned int
crypto_tfm_alg_blocksize(struct crypto_tfm *tfm)
        return tfm->__crt_alg->cra_blocksize;
 }

+static inline unsigned int crypto_tfm_alg_flags(struct crypto_tfm *tfm)
+{
+       return tfm->__crt_alg->cra_flags;
+}
+
 static inline unsigned int crypto_tfm_alg_alignmask(struct crypto_tfm *tfm=
)
 {
        return tfm->__crt_alg->cra_alignmask;

> +
>  static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req =
*req)
>  {
>         return __crypto_acomp_tfm(req->base.tfm);
>
>
> Herbert, Is the above code what you would prefer?
>
> >
> > Cheers,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>
Thanks
Barry

