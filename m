Return-Path: <linux-kernel+bounces-143192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D78A3587
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F492841FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642914EC6A;
	Fri, 12 Apr 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O/zY5m5F"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAC14E2ED
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946141; cv=none; b=JrrkHQSX97rrCRzjdqtdusqlpUtBlcFOI6liFmcEMzgm9Mt22LSeIADdvDqdG2QizvIj+FHjfJ97qGr2SJZZmhBbE324Lx2fZMKd9r5V0OkHGV3gXc3wj1fHzYVURPAMHNsaUoh+ooHM06GObAyjeMND8IRKIv77+/NM0KR1iOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946141; c=relaxed/simple;
	bh=3GwZHEj4k5rWl1wxWnzlMV8+5rajQDaKeZirl4b7xhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiFBvBho620I3E+4AYWmjvxP9pp1tEtLuwIZqk3ZJmbLVVnoBXbWzRMhgfW6XheizCj80b9r0dyu/K7PpAZxv1O4tgWKanZYRzqepvl5PsFVm6rQwDOeDCMMTjJUtfCYdtZD5ClzaJEDmim+Zde+8TyV8q3jhFOxiuKX2UTAN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O/zY5m5F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1096980b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712946140; x=1713550940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCHPnhyTcC9ocJWJcXngwPv4ks2H4M0UEeE7J2w7Lsc=;
        b=O/zY5m5FP2CbA5DKvp1DxqyQU5vjyJIfhmYRAMR1srJ03P9LX+Cik8eWvtXS8cBXcg
         j9SIKdGSk0waJ9EqWN9rkAish3Hzr8bYwlXGUpEM1Xy36eEcD7XEjv1n03jzXmzNLmsR
         Xg9rHKeyWNqjVXFIwBCq0UdiroJYK9JioKBY64S/rKqPdTDcxLY7h7SQZZ+hogqfuFFr
         c/epbC++2jkJbPVmhk05GyhF5PxkH0ksfIx1SEVnCQP2qDWxfdFzQa3Kh7n2yp9GZJtc
         cDStlAGmtm/cYpOn0b08RUINTly1lpoKokjSWdkhjv0rcE0ZlpHsmjvx0OoArQWPXywW
         FyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946140; x=1713550940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCHPnhyTcC9ocJWJcXngwPv4ks2H4M0UEeE7J2w7Lsc=;
        b=mZoW4RNNMM9Sb95t0VujvWw2f9pxsM3NciTkSAEUNrjDaj8nNr6Rw3rAoajGqL3qaX
         r4pSsa/ZXoUv4XClJUKJB3mOedfRN6zz4KPui9liT3OjZrEHbTKwX5A6tzj2GjmaQvN1
         clKc3wqOJWLxVtwoUMfe2DoK7OJkWDB0BM2t8bTLxwa1GRB9zSYWKg5IgqoZRrKxQdxK
         QBqbJB2njlekNGaJLi/TV6MlHJK0ul8iRqVzvtQ5jZNAjZ14e3Eh1si1+py19yJX3IVR
         p6MTSIvQK9/q8Qm6U4/3TC6RIxXBTBQ3ouWKXxn70hu7Q0Wvtt7PGTnst4dgf7PnaZSu
         oJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVpTKB++pLKZGHNfJFz3EO1SCN2BUtC2zI63/h9PZmubcJFF0/FrIIOhgNuHXZOYwEjJxY1dzc/H3aIuLrZ3hBDI/yuY1BGExoxcZqG
X-Gm-Message-State: AOJu0Yz1cb6JnQKMn750EIYcsEZ2dO+IPiEYvHWlYN2whHoyU5LwfVyd
	lBZkuYBf5AJBd+1SsodPJdx/124fVnjalGSBpIgngtU+6e2sprBHIwLRUJqTTjM=
X-Google-Smtp-Source: AGHT+IH3pC+f8pzqqXv0EovOv3q0ogIpnNxixUGOjWjSEXDo/maroqpNMt/5YXZL0hJP+QvlDJt4Ag==
X-Received: by 2002:a05:6a20:3244:b0:1a7:59b5:4276 with SMTP id hm4-20020a056a20324400b001a759b54276mr3112304pzc.54.1712946139775;
        Fri, 12 Apr 2024 11:22:19 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id t21-20020aa78f95000000b006ed4aa9d48esm3179455pfs.212.2024.04.12.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:22:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:22:15 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 14/19] riscv: hwprobe: Disambiguate vector and
 xtheadvector in hwprobe
Message-ID: <Zhl717rsQ7XLBe2F@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>
 <20240412-moonshine-acting-0df1a90b86d2@wendy>
 <CALs-HsviR8E-sRvzz7pd5eVGb4+XsAdG1hhbZOPf+m3Cu4JP_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsviR8E-sRvzz7pd5eVGb4+XsAdG1hhbZOPf+m3Cu4JP_Q@mail.gmail.com>

On Fri, Apr 12, 2024 at 10:04:42AM -0700, Evan Green wrote:
> On Fri, Apr 12, 2024 at 4:35 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 09:11:20PM -0700, Charlie Jenkins wrote:
> > > Ensure that hwprobe does not flag "v" when xtheadvector is present.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/kernel/sys_hwprobe.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > index 8cae41a502dd..e0a42c851511 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > >       if (riscv_isa_extension_available(NULL, c))
> > >               pair->value |= RISCV_HWPROBE_IMA_C;
> > >
> > > -     if (has_vector())
> > > +     if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> >
> > Hmm, I think this is "dangerous". has_vector() is used across the kernel
> > now in several places for the in-kernel vector. I don't think that
> > has_vector() should return true for the T-Head stuff given that &
> > has_vector() should represent the ratified spec. I'll have to think
> > about this one and how nasty this makes any of the save/restore code
> > etc.
> 
> Yeah, my nose crinkled here as well. If you're having to do a
> vendorish thing in this generic spot, then others may too, suggesting
> perhaps this isn't the cleanest way to go about it. Ideally extensions
> are all additive, rather than subtractive, I guess?

This was the "easiest" way to support this but I agree this is not
ideal. The vector code is naturally coupled with having support for
"v" and I wanted to leverage that. The other concern is all of the
ifdefs for having V enabled. I can make all of those V or XTHEADVECTOR;
that will increase the surface area of xtheadvector but it is probably
the right(?) way to go.

- Charlie

> 
> 
> >
> > >               pair->value |= RISCV_HWPROBE_IMA_V;
> > >
> > >       /*
> > > @@ -112,7 +112,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > >               EXT_KEY(ZACAS);
> > >               EXT_KEY(ZICOND);
> > >
> > > -             if (has_vector()) {
> > > +             if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > >                       EXT_KEY(ZVBB);
> > >                       EXT_KEY(ZVBC);
> > >                       EXT_KEY(ZVKB);
> > >
> > > --
> > > 2.44.0
> > >

