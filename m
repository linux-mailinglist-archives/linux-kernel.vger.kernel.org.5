Return-Path: <linux-kernel+bounces-100424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31060879756
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC77B228E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400016439;
	Tue, 12 Mar 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxv0y2Zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8A33E5;
	Tue, 12 Mar 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256700; cv=none; b=u+6FPAvEuXo0n7nQ0aAVQNZfwF9vDukzuHECnDZeUJvv/Jh5AeoLHu/1XDtbwacenhS/Rt96uDJWMfKWnUBQtuorlDPeJ1bEjKYOkXUtPKYseAJ17atDjvoIsWsyrKJ994vMRTWAmbn2m6A7nTE6urgzL5cpkTVhD2bEwcJskgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256700; c=relaxed/simple;
	bh=eXtkhVp6w8XaPIrh/gC59EgLMCdR8bJ5MCc/7TCQTbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPKUYjI5u8rLjti//XwHT7kRJDbAvymc8MjS72WZi64a3JpbircU/VQxWHqWHi9NDxYAywZam4tAl1Yui07OjHwnI3Bd8uTsNarMWRQzFMi2w65p4KJBp7Pch+8EzwaW7T7LZ6puQpBIaq3STUsIgfgjKybLeP55OSAWIbKMMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxv0y2Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89AC433C7;
	Tue, 12 Mar 2024 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710256700;
	bh=eXtkhVp6w8XaPIrh/gC59EgLMCdR8bJ5MCc/7TCQTbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nxv0y2ZxaaPYTAT6ow9IxCbNVuNIwWnv8Xv8ShGEOBAN33Fc14oBFWKrG5ZaxPeIM
	 8J8UHbsljL2SCzk5fYD9/3eUYHpAFTdZvDUmxB/reD2oBjGUXyaR8CHa5HZgVwcPOc
	 nKid86ugCjPU8GF5EixC2JD/4z45C9/owEyDW+OVnw6RSW9JaZq02B+ctCBXEaNnxd
	 01DCgi3AewxB28vp6NwGFQkLIQwqUhkKAya8yI5LFAfMFypF6m8MUTW97fiLoOQ+/M
	 VpD34Rvw3DWDrB8KxioP3TBNm0/ooPX/Kv5APK+OhOKsW2obL6mcVYKm3k77fyUzbK
	 h4RYdY2yHjDEA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so63943251fa.2;
        Tue, 12 Mar 2024 08:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWruXUP7qQKPKMR3YUaTZy3w2iVmCXBecPSc0Ifjms+uqO1Lv5+Wi+SpvL+ZLTfpSrNem9V07cQbPp3d5HJsdM+MQsIkef5VzQ2L+sw
X-Gm-Message-State: AOJu0YyXimHS4cFWceM+QZtzaRow486SpIEM1r22Qdn87a0SXuxbw65m
	sTs99GCnLmZlxHiQo5GvDmcQhfCK+Gwy63Z8ghENmN3gdkAinbePvVxdYZtYy2wqGcCFjRFv91L
	TdYcuWU5GPJWvpcYUDSk8pL7u7GI=
X-Google-Smtp-Source: AGHT+IG1znAq0/jal+D+vEUxxYq92BGZ8RvqGbk5p9JAK86FNhSvbUKvbZeqsM81GXzNkWnWgnycZky1/AynJ1Jew5M=
X-Received: by 2002:a2e:bb90:0:b0:2d2:3915:cfc4 with SMTP id
 y16-20020a2ebb90000000b002d23915cfc4mr1597225lje.4.1710256698339; Tue, 12 Mar
 2024 08:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607053558.GC941@sol.localdomain> <20240311213232.128240-1-chang.seok.bae@intel.com>
 <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com> <7d463faa-94ae-4c62-b3bc-b4d1084e4600@intel.com>
In-Reply-To: <7d463faa-94ae-4c62-b3bc-b4d1084e4600@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 12 Mar 2024 16:18:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEr3egDCZ+DYrZt8ohG3fA3jEr_D2iLZp+c9yoj3mr5eQ@mail.gmail.com>
Message-ID: <CAMj1kXEr3egDCZ+DYrZt8ohG3fA3jEr_D2iLZp+c9yoj3mr5eQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, ebiggers@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 16:03, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 3/12/2024 12:46 AM, Ard Biesheuvel wrote:
> > On Mon, 11 Mar 2024 at 22:48, Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>
> >> @@ -241,7 +241,7 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
> >>                  err = aes_expandkey(ctx, in_key, key_len);
> >>          else {
> >>                  kernel_fpu_begin();
> >> -               err = aesni_set_key(ctx, in_key, key_len);
> >> +               aesni_set_key(ctx, in_key, key_len);
> >
> > This will leave 'err' uninitialized.
>
> Ah, right. Thanks for catching it.
>
> Also, upon reviewing aes_expandkey(), I noticed there's no error case,
> except for the key length sanity check.
>
> While addressing this, perhaps additional cleanup is considerable like:
>
> @@ -233,19 +233,20 @@ static int aes_set_key_common(struct
> crypto_aes_ctx *ctx,
>   {
>          int err;
>
> -       if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
> -           key_len != AES_KEYSIZE_256)
> -               return -EINVAL;
> +       err = aes_check_keylen(key_len);
> +       if (err)
> +               return err;
>
>          if (!crypto_simd_usable())
> -               err = aes_expandkey(ctx, in_key, key_len);
> +               /* no error with a valid key length  */
> +               aes_expandkey(ctx, in_key, key_len);
>          else {
>                  kernel_fpu_begin();
> -               err = aesni_set_key(ctx, in_key, key_len);
> +               aesni_set_key(ctx, in_key, key_len);
>                  kernel_fpu_end();
>          }
>
> -       return err;
> +       return 0;
>   }
>

I wonder whether we need aesni_set_key() at all.

