Return-Path: <linux-kernel+bounces-96963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205888763DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87D81F21C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E5755E67;
	Fri,  8 Mar 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYyY1e8H"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11556471;
	Fri,  8 Mar 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899074; cv=none; b=T+B2R+2dJkAZFC5hy6Mj9dMDTKQvCV9H5l0CdI9rA6mF7Cb3422PdMRV8yznxwocZqCIyAn1V4Kf0iC5E1M2KrJmFH4Oh+1F+XbZGdJ/aHCOynDPVm+lNHGIE4kqohFIyfAWdTsvrTQ0U8V30ta4OBQw75zx9zbmR5tnECm1AxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899074; c=relaxed/simple;
	bh=R2I6P5DZQH2SX13IhgnDgZJqBst0fT5mk8J2V9I1+FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5WLay2f4hvTViA1Db3ewJh/1kOfPQ6s7WU9X/tuuYn0dNaaPVSOye+M72UhkYbVpxbY6QhcvMlthElEBtUuq3f/BBaAB0sDZdJP4E+cnO5gBphS69S5xRUIAoQuc+ksmqsC8LzeXvj48rmg12YJnnaWSJK7ari58vES7yVWc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYyY1e8H; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4729da13d05so677201137.3;
        Fri, 08 Mar 2024 03:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709899071; x=1710503871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpLZe2hcB9flMvKtGZYykmOP+UhfIqyfryfyFk51Q5A=;
        b=FYyY1e8HFFi+5MKREOuHPODN5clxjD75IMfRZEhRFd7qsH0fMJMAl8nwbncvFrwTwq
         1KyO4oFijrcIwfqdl4AJs0OHtKvmfDwmYkiZqpRo1U7eL5+l/n8lX3er09wNnNzIBxPL
         ysprxVGmDcciGKQJpavnTW+vRSPBjP7C8XRnTnl/Re9LsY70LAzWf5/27LI2XWUo73oe
         XU+5/HV8HrbtEDAEAzdy5xj/EAAVN32ZMLjogWvPnMD3q5W81CTLZ0j+U4VH0upHuuG5
         9XMm6X8vZ2a6PZGIQ6+F9ftkxemD52Cci5NTanocl/RT8RwDZh1k16oNOp4+XRWUh/Iy
         +Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899071; x=1710503871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpLZe2hcB9flMvKtGZYykmOP+UhfIqyfryfyFk51Q5A=;
        b=MBYX5Em8bxZXhFxZ9uxfaUWovdP6Gb++MOL4ZwencBa9YmcQEwZ+Y3TIolgD8y2AZr
         1TGWaqkEs0TeI1emU72oZ5bmXICtk3rag7duyFsk3D61le1ZjtKGw9+oNmhZCg3wud+U
         dHHcvatw/ChR5hvsd7qdZSbOi8Iv6DIRKta4/8Ia8f2fnEGM/mshR2aAaAR8qySMYtYM
         xfQ5hUjscGB7NYWf15yvlhPCDOuapg7tm2DXH0nf8ePhXXvfbTXx5zZKTApzojh0a03t
         5MozVj3d5ND2tLqr07ershrISwP04QDQiv4wA4KzdwFdMEU5ge8I9SOz/WuquTzPKstz
         3qIg==
X-Forwarded-Encrypted: i=1; AJvYcCXprxdUeAODpgKb2RZVmhW5skD1cMWn5cw0pAyNz0EGpeSrNh1CFYtSBJwRPQR0kl/8ccUmEAP67yofejWSYzHIxCCiJ/ocktxQHJXzv1YZEuYp8KirYK+f1s22e6tVx09P097iMNPuXwng
X-Gm-Message-State: AOJu0Yx7G5zeItpKvObW8TfZJFIJRrFgkJya/rJi9ztWaAHOnfFkqtYz
	gU9WJT0HI7TBhCPNJ4MRcoYtW5ZmkITAFwraJUw9lWLwPgh/ojGVLreJMZg0Cw+GL7y8QdPkC5z
	TTtzfK65HtcU9HDLRX9qCSeQ5RD4=
X-Google-Smtp-Source: AGHT+IHkaoOcEi8CFjru+qwmdcjDwYSPtHeTY6nRgbwgxx4xGSdOd/MnYct0qhYxQA/YYbOO6Brvkpi6ydOO0VshCEA=
X-Received: by 2002:a67:e952:0:b0:470:564e:a58e with SMTP id
 p18-20020a67e952000000b00470564ea58emr9877194vso.2.1709899069862; Fri, 08 Mar
 2024 03:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com>
In-Reply-To: <20240222081135.173040-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Mar 2024 19:57:38 +0800
Message-ID: <CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
To: akpm@linux-foundation.org, herbert@gondor.apana.org.au
Cc: chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org, 
	linux-kernel@vger.kernel.org, sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>, davem@davemloft.net, hannes@cmpxchg.org, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, zhouchengming@bytedance.com, 
	nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Feb 22, 2024 at 4:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> In zswap, if we use zsmalloc, we cannot sleep while we map the
> compressed memory, so we copy it to a temporary buffer. By
> knowing the alg won't sleep can help zswap to avoid the
> memcpy.
> Thus we introduce an API in crypto to expose if acomp is async,
> and zswap can use it to decide if it can remove copying to the
> tmp buffer.
>
> -v6:
>  * add acked-by of Herbert, Thanks!
>  * remove patch 3/3 from the series, as that one will go
>    through crypto

Can you please pull this into mm-tree? This used to have 3 patches.

3/3 was separated according to Herbert's requirements and has
been in a crypto tree.
crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/c=
ommit/?id=3D77292bb8ca

Two drivers fixes(patch 1 needs) have also been in crypto tree:
crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/c=
ommit/?id=3Ddb8ac88385

crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/c=
ommit/?id=3D30dd94dba35

So it should be quite safe to pull this series into mm-tree now.

>
> Barry Song (2):
>   crypto: introduce: acomp_is_async to expose if comp drivers might
>     sleep
>   mm/zswap: remove the memcpy if acomp is not sleepable
>
>  include/crypto/acompress.h | 6 ++++++
>  mm/zswap.c                 | 6 ++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> --
> 2.34.1

Thanks
Barry

