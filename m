Return-Path: <linux-kernel+bounces-90689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633E870369
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E5D1F26245
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383D3F8D0;
	Mon,  4 Mar 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLDRcz66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC63D97F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560535; cv=none; b=OHhb5zCdIkiJ/+fDNWNooXHKwK5RAamKPVisBjv6LR/UMgT+35lG9BAFyPhArlPQJa8K+am2u3T8VnFPnggiDcm1rzZTFgPUVk4+qmg/YQwCtBfyaedxlS8x+3rXn5ECuifxq8Fo+q/g9DfVfOl27EsPfAwukAFvfe60/0H8PO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560535; c=relaxed/simple;
	bh=3M+/bQX/v9G+J1KliPz9dmTJESbLCH9kKdvpsKmgcrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3tYYJfpM5s8E+G+hDKGUiPUjUvWJgZbOi97g1JOJNSIuwl1XR+OFQBTjOQsA4TYS4KpKYPgIMgqmLh5uC785U4KdDufBN3Nb1C23t3ePWvmxXM5wz1Tr/9v1M2MjwR/7b7J1ZVzrz24BKuUGfwsRfCoLtE5a1iY+sxiscJAtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLDRcz66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E74CC433B1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560535;
	bh=3M+/bQX/v9G+J1KliPz9dmTJESbLCH9kKdvpsKmgcrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FLDRcz66TGjYLfnsEHY5VDgqohIRmf+bAFveGtZvAn4+hJhHQg5WGAKNzH6bfQZj1
	 DvUaUGLWWkVLOoN60YANjjy73WlQwO/99pLjH8+WE5mXTLX37FyOh9XsVBmJJE78GI
	 DqHRBwU8SkM2SavBcA1NmPJhu4NoDzhTX+6aBztA5Wtmih3RlhDUnK+JJObdbfkxxf
	 oKovzk568dFn9R0JpJNKFeioKvOuMC93Ut6XAG04Y9xRv7/EIr1dRRBJrmhlewHb7Y
	 m8iiWKQxS6WxH9I4liCvcOi871N2fkBzIIefaou/q/d1nV/icVWgB/6+Xfm5xEDAF1
	 Q60Sx8A5gJdZA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d275e63590so63086041fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJfkhUVVUoFCqWThcSb9A60fqplU5cRVAgUx7uDeUNabAV0wUpO0XF4zd3Ai2zyJ92IVA/+RTBqSI97u+AKXO6mo8hqbwnuHQKrbor
X-Gm-Message-State: AOJu0Yw6cfsL5HOC1vUDBlb7U1dnBtC8RaZvmHjZLKzM29ZEjj2T33wY
	r4jdmdctRkvkzvh71TboTQ9D9lPdOv69Dop6v5sckB0GvXUSyVAkL5mqtTbi2LZ4s0lfzm9ftcy
	qIu9se9Cy6xwPNHBwgI1tyitvRgM=
X-Google-Smtp-Source: AGHT+IE+QL1WO9hZcI0G8tB67Le8/FxkZDw1z5pNxBYepTDS5xo90I/CnZ68GGFy2mS2ROSGYg+VgnhJAIoCgfv6/Wk=
X-Received: by 2002:a2e:a4ae:0:b0:2d3:4652:b2ff with SMTP id
 g14-20020a2ea4ae000000b002d34652b2ffmr5751566ljm.40.1709560533267; Mon, 04
 Mar 2024 05:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com> <20240304112441.707ded23@donnerap.manchester.arm.com>
 <1baf9a7f-b0e4-45d8-ac57-0727a213d82d@app.fastmail.com> <20240304114546.4e8e1e32@donnerap.manchester.arm.com>
 <badf279a-f1fa-4938-a5d2-492b89d7c27c@app.fastmail.com> <CAMj1kXENYqUx=esK9b_pGd4wpwE43fNaGRCUhJLK_4MQzrAQeg@mail.gmail.com>
 <61aa333f-aa13-4068-b73f-eeae615f4640@app.fastmail.com>
In-Reply-To: <61aa333f-aa13-4068-b73f-eeae615f4640@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Mar 2024 14:55:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF4biAW+FpxnkuTes5uK_G2h_pDj3kN-SMFCmLXqNCcug@mail.gmail.com>
Message-ID: <CAMj1kXF4biAW+FpxnkuTes5uK_G2h_pDj3kN-SMFCmLXqNCcug@mail.gmail.com>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko]
 undefined!
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, 
	Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 14:49, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 4, 2024, at 14:01, Ard Biesheuvel wrote:
> > On Mon, 4 Mar 2024 at 13:35, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Mon, Mar 4, 2024, at 12:45, Andre Przywara wrote:
> >> It's not critical if this is called infrequently, and as Maxime
> >> just replied, the 64-bit division is in fact required here.
> >> Since we are dividing by a constant value (200), there is a good
> >> chance that this will be get turned into fairly efficient
> >> multiply/shift code.
> >>
> >
> > Clang does not implement that optimization for 64-bit division. That
> > is how we ended up with this error in the first place.
>
> I meant it will use the optimization after the patch to convert
> the plain '/' to div_u64().
>

Ah ok.

I did not realize we implement the same optimization in our code as
the one that GCC will apply when encountering a compile-time constant
divisor.

> > Perhaps it is worthwhile to make div_u64() check its divisor, e.g.,
> >
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -127,6 +127,9 @@
> >  static inline u64 div_u64(u64 dividend, u32 divisor)
> >  {
> >         u32 remainder;
> > +
> > +       if (IS_ENABLED(CONFIG_CC_IS_GCC) && __builtin_constant_p(divisor))
> > +               return dividend / divisor;
> >         return div_u64_rem(dividend, divisor, &remainder);
> >  }
>
> I think the div_u64()->do_div()->__div64_const32()->__arch_xprod_64()
> optimization in asm-generic/div64.h already produces what we want
> on both compilers. Is there something missing there?
>

No, you are right. I thought we were relying on GCC for the optimization here.

