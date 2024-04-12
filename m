Return-Path: <linux-kernel+bounces-143412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F668A389A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B80C1F22E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B92C683;
	Fri, 12 Apr 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BPgCQh/k"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A94DA13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712961443; cv=none; b=cw1EaVoWxAWCHzSQ6rblPhQdBp+X63aylGYl75TwxmoCcALP99SLnJdUS2gGD/MFxjpxvWQlpy1K78QHV2sF/z7AGXNj24NvOgi0p5tDN7L4/6QMTVnU+ojzAHz92bn/WSGlE8d4o7jI5fusyFcFs8XvYQTEY0lu9AabmZ012EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712961443; c=relaxed/simple;
	bh=AAQQiOP+zTxgw859Qwy68m1EG7SPBqIf9+JwqKoC7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icbCnVU8EMUDWWuYofabSsFnG/uEIstu3VEJjfeWkqKyMn0MyNaoOBelj8w6x+JD1aZVPsuF5xJ8ib5k21H5zjoPUEqZfe1buADRcKQLPk1wW+uzHrhuRbaypSF8Jry1f8/Rmnvf9Uha6ABSndGrMCvO1FIk6QNO9wl0pUJXGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BPgCQh/k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e50a04c317so8376235ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712961440; x=1713566240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKc5QOf/ZMb9xWTXmeJjFB5DhU65yjVEdJ5QMQR8HHA=;
        b=BPgCQh/k+T/ncnUuo7UVhPwLSk62LaFQt0e4yBgT9XpNAD3eFCqhmObvV2pXfa3Tt8
         BCnPytgp1mwAMVQf6GmS+bIWQogo/voMYhxT0CFWdsxznLFP9SgCb1Gv+BehpkhGx3G+
         VsX1G04meUMprjfhMSOq49TFVp8mRD2kAJThZrTonwGFAN6SksdFyW4m9g5TEZmTRV0b
         RuekWT04mI2dcQYCIQdYj7lVcby3MKSEsi7GyVApnsJosdCVf8dhg1tGdcMiS9gAk7Xp
         dExSV0cB78dOxdNyNiZHNSrxk7GNsb6SU9B100cyPGTC/xjwcaIDs0YrojUNCQit6fFI
         /ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712961440; x=1713566240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKc5QOf/ZMb9xWTXmeJjFB5DhU65yjVEdJ5QMQR8HHA=;
        b=mFDDJWkmKFvfER/dVoXMXkQgz7IjK2OXOCdSDGcUeWE83978d/ZkncLwdBfKHKrpBh
         pOJzPEvECf51lcDr9fVF3r2y5fzPaODS5tv6ToNkUn5art5rlPhvncyWf6bZ9NcfJhbY
         DnmM+SAS6M3KOklyWWSUrxmCWtPmt5/DCzslAGdDQY/uUWsBer0PWAvqL/FMf49uKrTL
         kyt2SqcLp5SqYsqKMkEX4dr8Iljmxw1nfHHo6vltxYvWafXBg0oKLE4L0qnNAXLKU1nk
         61nyd/gKQc1Uc6ADREk1nHUE1DTBMp7AU14ZYDcQJG7lZ/7YYNzpPO/mxYrboV2UzLBP
         U0/w==
X-Forwarded-Encrypted: i=1; AJvYcCX5Tdgqe0O3c11UDo/kywgfECjVc1d/hP7SZXWc4DMHmX4JfYXtd/H/pjhDJqdLex4XMGbV0kk5+geeeybcMlAqpH6xc/p049S2i9a7
X-Gm-Message-State: AOJu0YwTNPkSqokoFu/5zm6X7EooGpHZR+od0rWdMOo7m+MUA1Zn3/7I
	59Nl0u1R2fNVQ9aAgHTLei2FpeV/1KwCnxteGh0AWpE5ihOgk1jFph0fqoXkbcw=
X-Google-Smtp-Source: AGHT+IEjBUFJuPCaqfHwY1NRFXkkjNtUpEOC6DeTaS2W69mFFwgwmcA7KU2icsnyyk7nr0iryOxGtg==
X-Received: by 2002:a17:902:e5cd:b0:1e4:952c:fafb with SMTP id u13-20020a170902e5cd00b001e4952cfafbmr5259647plf.2.1712961439988;
        Fri, 12 Apr 2024 15:37:19 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b001ddc83fda95sm3492795plq.186.2024.04.12.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 15:37:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:37:17 -0700
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
Message-ID: <Zhm3nflMIuue2/RS@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>
 <20240412-moonshine-acting-0df1a90b86d2@wendy>
 <CALs-HsviR8E-sRvzz7pd5eVGb4+XsAdG1hhbZOPf+m3Cu4JP_Q@mail.gmail.com>
 <Zhl717rsQ7XLBe2F@ghost>
 <CALs-HsuL8A87mCRU2+1F2sEPYmZWTz_MFwAys0h=1uKhb7EYqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsuL8A87mCRU2+1F2sEPYmZWTz_MFwAys0h=1uKhb7EYqg@mail.gmail.com>

On Fri, Apr 12, 2024 at 03:08:31PM -0700, Evan Green wrote:
> On Fri, Apr 12, 2024 at 11:22 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Apr 12, 2024 at 10:04:42AM -0700, Evan Green wrote:
> > > On Fri, Apr 12, 2024 at 4:35 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2024 at 09:11:20PM -0700, Charlie Jenkins wrote:
> > > > > Ensure that hwprobe does not flag "v" when xtheadvector is present.
> > > > >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/kernel/sys_hwprobe.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > > index 8cae41a502dd..e0a42c851511 100644
> > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > @@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > > > >       if (riscv_isa_extension_available(NULL, c))
> > > > >               pair->value |= RISCV_HWPROBE_IMA_C;
> > > > >
> > > > > -     if (has_vector())
> > > > > +     if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > >
> > > > Hmm, I think this is "dangerous". has_vector() is used across the kernel
> > > > now in several places for the in-kernel vector. I don't think that
> > > > has_vector() should return true for the T-Head stuff given that &
> > > > has_vector() should represent the ratified spec. I'll have to think
> > > > about this one and how nasty this makes any of the save/restore code
> > > > etc.
> > >
> > > Yeah, my nose crinkled here as well. If you're having to do a
> > > vendorish thing in this generic spot, then others may too, suggesting
> > > perhaps this isn't the cleanest way to go about it. Ideally extensions
> > > are all additive, rather than subtractive, I guess?
> >
> > This was the "easiest" way to support this but I agree this is not
> > ideal. The vector code is naturally coupled with having support for
> > "v" and I wanted to leverage that. The other concern is all of the
> > ifdefs for having V enabled. I can make all of those V or XTHEADVECTOR;
> > that will increase the surface area of xtheadvector but it is probably
> > the right(?) way to go.
> 
> For the ifdefs, if you've got a Kconfig somewhere for THEAD_VECTOR,
> can't that just depend on the V config? We'd end up with the
> limitation that you can't add V 0.7 support without also dragging in
> V1.0 support, but that's probably fine, right?

That's a great idea, thank you for the suggestion.

- Charlie

> 
> -Evan

