Return-Path: <linux-kernel+bounces-72332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DD85B216
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283541C2175D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408156B6D;
	Tue, 20 Feb 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGaetK9y"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491A45942;
	Tue, 20 Feb 2024 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405531; cv=none; b=bAwY7hP4aQVurH9YwAoIeykIFmFtL4phWpypiY8fPNi7Z1q7rDOQM5gsa+SmXIefF/vNp6BSkw399fDuMA4aMRjjHFv00jt0C4yTi9aPSzVaBeMwOKgtO69fLHW2AS0FN34FZ+CvwfSq/M9NmRd/dWfNSs2iH4gbuNmLzEPq0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405531; c=relaxed/simple;
	bh=DT/vBAZJD5cr26QdUgHDstmZsZjf1OUw8krDkaFZ4nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJUuoYeFdCgBwt6XNXXswIUx+X4NQYLj8rzyjyD1gx9S6l/0kG/flPCM0ALC/GEgWFLpvLbZhI4ADc3dVNCWq6ubHlXutu8Iw6TeIpBYNNh5OzdFXXOpLgpZDN2GD8cvOMMe3/sqtdok6eChoHVoCzgzg4izKJX2mC/JSGU4ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGaetK9y; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso2946742241.0;
        Mon, 19 Feb 2024 21:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708405528; x=1709010328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk8k0QjoPMjzPDhGJ3Q3tVXGO0o6Fb9cJe6VdL7s/5k=;
        b=eGaetK9y2etB3bVEa6yaVdwRHc0xvr4I98jKO4SD6HK259+G6A+hBq13feomwFvunS
         2/2eL78kbYBK96LRSPtRGVqTTM67nRJaAytl/Baa8dEFOLVbmk+5bq/RP2dfnu7RtBav
         rReTk9016Y3rQ4SWMfe9cCduzBP3YLUzAVwja5m1SShnRjYAEpc+VanXbv0WzxEzhB12
         5bjiHr1c8B+7rNWi1gGrJGtDNHm9pjIJyanQFMj820hO9kEMDHrg3JpqjA+NFzMous9C
         mN13dUZYxjOPzKtQGjjuBo4i+Vu1JbqBYQmxhJiQXQRc+/jEiLVaCMNB50y1iCw+c8mY
         WPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708405528; x=1709010328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk8k0QjoPMjzPDhGJ3Q3tVXGO0o6Fb9cJe6VdL7s/5k=;
        b=ir3CcI4tIuWaYzxXgMjhIt69xa5Su/qO8pRNlL0Kdre4c2/SEGpezaxVtxhNzDOVtk
         ye7vV41p6n+eGHlreAXKhtISymJx052ZaNpj70ZlOydVZqF0Mted+nODkqvxnR0QjvkT
         5P1EX5kVNip1KC/Y7hCYGZEIuIMjnSyXHeQ2fb/CYtZWdOZXXN0DczN2hiqNsVFSSJNt
         sOZfv/UPtTJhoVlmrqHv/LuMoj2uiWbVMcUM9cjdf/srLlNFVr6iUy2nm/p9QHLHUIKY
         qL9xn0U6Z5bSSyILa3a1Ms925TAyWP4P77zXXfZc+APR54aDVIsoptwhJn68WWJ+D6HV
         7RXg==
X-Forwarded-Encrypted: i=1; AJvYcCVDMxHbotwRb9+jiBtETe0gYEDgXEgrWP/tdGwKlqv6AyBnq+4SYxmdz2Zb2/ovAQjKWSerhZGM31SbbBSAJjuyN+wikorO3W2Om1O8CgautTVnA92h/R3BU3vcRzAE3gtXJJp7yQPQBvFA
X-Gm-Message-State: AOJu0YxgcFWNlReWBNzyco40gPrOc9YjHijF0/dYQorf/UOn90QHi0sx
	1q3sYu4hqcqU7GA3DNt7sy3+MMVehox07dsHxyqS35r6MVoDnIkOBQinye+5LYvyj/MmWinqP46
	HOXEn5jt9LtRfe7V1Rw3BT3EEzok=
X-Google-Smtp-Source: AGHT+IFTy+laXX+oRg5/omXGQg3uJcAt19c+6WAcGgFfpTneHrbyZH3LUAe8HUBrDAS2gWl1liNEkkgl6pfN4ghdAqc=
X-Received: by 2002:a1f:dec1:0:b0:4cb:d4a:3da2 with SMTP id
 v184-20020a1fdec1000000b004cb0d4a3da2mr4585852vkg.6.1708405528454; Mon, 19
 Feb 2024 21:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220025545.194886-1-21cnbao@gmail.com> <20240220025545.194886-2-21cnbao@gmail.com>
 <ZdQm7n6Jc3tqsg1F@gondor.apana.org.au>
In-Reply-To: <ZdQm7n6Jc3tqsg1F@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 18:05:16 +1300
Message-ID: <CAGsJ_4yP1Z4xAy5DEiaPB14YsOSYuYa80C-UY6SC2_eT7vhK9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] crypto: introduce crypto_acomp_get_alg_flags to
 expose algorithm flags
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>, Yang Shen <shenyang39@huawei.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:14=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Tue, Feb 20, 2024 at 03:55:43PM +1300, Barry Song wrote:
> >
> > diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto=
/hisilicon/zip/zip_crypto.c
> > index c650c741a18d..94e2d66b04b6 100644
> > --- a/drivers/crypto/hisilicon/zip/zip_crypto.c
> > +++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
> > @@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate =3D =
{
> >       .base                   =3D {
> >               .cra_name               =3D "deflate",
> >               .cra_driver_name        =3D "hisi-deflate-acomp",
> > +             .cra_flags              =3D CRYPTO_ALG_ASYNC,
> >               .cra_module             =3D THIS_MODULE,
> >               .cra_priority           =3D HZIP_ALG_PRIORITY,
> >               .cra_ctxsize            =3D sizeof(struct hisi_zip_ctx),
> > diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypt=
o/intel/iaa/iaa_crypto_main.c
> > index dfd3baf0a8d8..91adf9d76a2e 100644
> > --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> > +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> > @@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate =
=3D {
> >       .base                   =3D {
> >               .cra_name               =3D "deflate",
> >               .cra_driver_name        =3D "deflate-iaa",
> > +             .cra_flags              =3D CRYPTO_ALG_ASYNC,
> >               .cra_ctxsize            =3D sizeof(struct iaa_compression=
_ctx),
> >               .cra_module             =3D THIS_MODULE,
> >               .cra_priority           =3D IAA_ALG_PRIORITY,
>
> Good catch.  I think this should go into a separate bug-fix patch.

done.

>
> > diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> > index 574cffc90730..07bd8f6bc79a 100644
> > --- a/include/crypto/acompress.h
> > +++ b/include/crypto/acompress.h
> > @@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct ac=
omp_req *req,
> >       req->base.tfm =3D crypto_acomp_tfm(tfm);
> >  }
> >
> > +static inline u32 crypto_acomp_get_alg_flags(struct crypto_acomp *tfm)
> > +{
> > +     return crypto_tfm_alg_flags(crypto_acomp_tfm(tfm));
> > +}
>
> Sorry, my mistake.  I shouldn't have suggested copying skcipher
> since that gets the tfm flags as opposed to the alg flags which
> you've found out.

no worries, Herbert :-)

>
> I think you should just go with your original function acomp_is_async
> but do it like this:
>
> static inline bool acomp_is_async(struct crypto_acomp *tfm)
> {
>         return crypto_comp_alg_common(tfm)->base.cra_flags &
>                CRYPTO_ALG_ASYNC;
> }

ok, I will do that. Besides, i'm also curious if we can open a
discussion, for example, letting offload drivers be able to work
in both sync mode and async.  A scenario I can imagine is as
below,

for zswap, and page size is configured as 4KiB. in this
case, offload hardware might be able to compress/decompress
much faster than CPU, but the event-wait, wake-up, schedule
latency might add the total time for a compression and
decompression. thus offload might work worse than CPU
though hardware-accelerator is much faster than CPU.
In this case, it seems good to let offload drivers poll
the completion of compression and decompression
compared with sleep and wait.

On the other hand, when PAGE SIZE is big, for example,
ARM64's PAGE_SIZE could be 64KiB. in the future,
mTHP/large folios project might also ask for larger data
to be swapped as a whole. we will only need a schedule/
wake-up for 64KiB or larger data,  the  compression/
decompression time is much longer, in this case, async
mode might help to decrease CPU usage while providing
lower comp/decomp latency.

So it could be something like:
if data is short, acomp driver works by polling; if data is
long, acomp driver works by sleeping and waiting.

it would be perfect if Zhou or Yang Shen can help collect some
data to back up the discussion.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry

