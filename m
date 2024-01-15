Return-Path: <linux-kernel+bounces-25789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761F82D5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93476281F60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11550EAD1;
	Mon, 15 Jan 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXGm8akh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C666F4E3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e80046263so650925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705310597; x=1705915397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcYPhRGd43b7CefS4mS1BKKH4ql6RBhdXWhyItNiInQ=;
        b=QXGm8akhWEgQgOgEnFYLpSCfAm69nd9/XgSfUGBwQ/26p9GN6IYNOFQiAensuENPdi
         Eqr4YvNFNVZCI2T0X37Y1a9UeIOQisi5oB5v0UcVdKPkdxA6z+iZmVii+pLps7XBN4FK
         FsLABLWEeDjTeSZMdrxRmTc7OcMJfn+5gGMW9FDSpJbDq2pK9SKMy1tB6YXQcljNKiOq
         +tZk4lLrB7TEMRPufugWKIBZYguFFsQJJBt8pc0iUFkr7rFzSl6DIco3TnhmN/fKYJXr
         4nBKRF2rg9Bth+HiwNb19iKn6DtqueegvPS7QV/49yDxo9pmzcROgaFSx5Uq3FLX8I9B
         KrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310597; x=1705915397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcYPhRGd43b7CefS4mS1BKKH4ql6RBhdXWhyItNiInQ=;
        b=S3lm/hd/tzaq9EgkSjorTHJIwdZB+rjJIAGQVZdCWzPxJn4thX2jIBkIbAjAE3sAT7
         HDvKMvLRpE1M/QUF7lBC9zTeojFN4PY2wkviSJVywSepKBo6e3NkbyzgVhOFrby4W5YY
         rin4YDtJEE8AMl+K6QUHKRQEoU2LZPs8MCMIEMemVLKNSDtzTJ6uTwmZkDvz7kAMg/Aw
         yJXl69yjfG5xedPRIS3cr52Kq/263uzMHcXJx4LyEqDwca38lVXSmsu9+WEgK27bud7N
         BfGWn5iPi9abPMymMARp0wvUxvaINqWp0+CDWx2nKU36zXw3tGnTTtd+0M/+k/c0oOdU
         gQyw==
X-Gm-Message-State: AOJu0YwaUC5jZmVVzpWoKPpDzMbj+CDoJKpgNfkCR5YvSvl84Akc4Qdk
	dSyvyLjmFI666+xzwRlwS20/DIEDUS/b42fhJoPDDtRKqr0=
X-Google-Smtp-Source: AGHT+IGeKmfI2DLg+B0avpu37AUIgzqNEQKAVus7WMtYV0i8ndcdKHSvZ/hVTfs72GwCpQmQhTFMYNdejIqpvBLI/Cw=
X-Received: by 2002:a05:600c:3151:b0:40e:67a9:5d1d with SMTP id
 h17-20020a05600c315100b0040e67a95d1dmr2277573wmo.149.1705310597141; Mon, 15
 Jan 2024 01:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
 <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
 <20240109074843.GI19790@gate.crashing.org> <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
 <20240109082647.GJ19790@gate.crashing.org> <CAJNi4rM_w5JKjug1PtV+tHyk11DUhRJ-K1pSDE6P1x8KSU2wrg@mail.gmail.com>
 <20240110141005.GL19790@gate.crashing.org> <CAJNi4rMw1rN64hGZbraoDwtOJOMOumVWL_8iLaCb=TYXAhD2Jg@mail.gmail.com>
 <ZZ_QaIrlKlFNdDbG@FVFF77S0Q05N>
In-Reply-To: <ZZ_QaIrlKlFNdDbG@FVFF77S0Q05N>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 15 Jan 2024 17:23:05 +0800
Message-ID: <CAJNi4rOKQ9DZHEJw=bMFEGUqqGDb_58Y6mxDMRbCPk2Kzwtx1Q@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Mark Rutland <mark.rutland@arm.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Xi Ruoyao <xry111@xry111.site>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Jan 11, 2024 at 7:26=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Thu, Jan 11, 2024 at 09:42:40AM +0800, richard clark wrote:
> > On Wed, Jan 10, 2024 at 10:12=E2=80=AFPM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Wed, Jan 10, 2024 at 01:59:53PM +0800, richard clark wrote:
> > > > A ported driver in linux kernel calls '__sync_val_compare_and_swap'=
,
> > >
> > > That is a builtin function.  It does not necessarily expand to an act=
ual
> > > function call.  aarch64 will typically expand it to inline code.
> > >
> > native gcc version:
> > gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> > cross-compiler gcc version:
> > aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> >
> > Interesting, the same '__sync_val_compare_and_swap' in the .c file
> > will be 'U __aarch64_cas4_sync' in the .o file compiled by native,
> > will be 't __cmpxchg_case_mb_32' in the .o file compiled by
> > aarch64-linux-gnu-gcc... don't know what the reason is
>
> The __cmpxchg_case_mb_32() function is kernel code from
> arch/arm64/include/asm/cmpxchg.h, so I do not believe that's being genera=
ted by
> the compiler from __sync_val_compare_and_swap().
>
> Are you certain that's being built from the exact same C file?
>
> Are you able to share the code in question? Where has it come from in the=
 first
> place?
>

Ah, double check and the misleading info about the native and cross
compiler, the native gcc(Ubuntu 11.4.0-1ubuntu1~22.04) and the
cross-compiler - aarch64-linux-gnu-gcc(Ubuntu 11.4.0-1ubuntu1~22.04)
will generate the same link error, but the cross-compiler -
aarch64-buildroot-linux-gnu-gcc.
(aarch64-buildroot-linux-gnu-gcc.br_real (Buildroot 2020.08) 9.3.0)
will not generate the link error, I believe it should be as you said,
the aarch64-buildroot-linux-gnu-gcc doesn't enable '-moutline-atomics'
by default.


>
> Thanks,
> Mark.

