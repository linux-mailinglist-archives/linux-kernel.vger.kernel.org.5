Return-Path: <linux-kernel+bounces-118537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C288BC53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E1AB22238
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC6137743;
	Tue, 26 Mar 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy6k4Aux"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183581369B8;
	Tue, 26 Mar 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441691; cv=none; b=fyQT5esBLDD7m3InWuSV3mIxm3cBrOHFLgWZSTuCwOqLMXQGJnvFQv61kxhi8lt3Z0axIw0eRkAbh7wLolVAfkvX2PPbYUAJSIALBO10MJ5eTLj2ZhW97d77R6S2IqwIO7xEOEEV27rW9ZpfLuvB6+xm/sjJpeDtjyygn2f9qG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441691; c=relaxed/simple;
	bh=t0iWJMruOlJ5HYFTD4ws7v8xNI2DKAjyY+BDs8KRj5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpqHuiRWxo9R9D6fOToIYgWQYASvfXkEyiHi5n+mVw6xUsP5Q7SR+8EnFKFxUN4e68A+59PhKQjqoDw7ItDB+B5NX2nyzV+sabYzhVp7Tkizvk/XVTyzO6HH6GNByJkh6buGkM8Ow38F3ybHjkQ7+muVbn19xHsRWo0s5bCI2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy6k4Aux; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4644bde1d4so678657166b.3;
        Tue, 26 Mar 2024 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711441688; x=1712046488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW/LOG/NZ4fe0q0KmtRnjtmN6mbXirqfYRPhdIzo3gg=;
        b=Qy6k4Aux8obyvVRJrUncolOhgdblsGlSjjpCEhDtU4teD7Wcn0VHdwfUoSUTujbRBj
         sNm0bO0y+5b3R4zRc6GM+ggqmlFXd11cd2ivUAN3+5+YitXwngBYq/+fmQOdL4TbrjBq
         gR1eOujG8CgT+npA0HlhfMakPbE9oRbLxtJbZ58YjoHKQiCU5vwuaSdGiv75aKxlC046
         BPw5uk6+gJuFbrPUXsBngDn0r5QDQ6cmGvdBa1VCLQi6vYNHEVg4LEshmMXaxgnjCL1C
         uOHhHBl0z1/z1eTNBMLRYJ08MKCcAahzxmLSd6jw9BaKIfojwHWp5UffcvgmG1v01SzY
         Wrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441688; x=1712046488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW/LOG/NZ4fe0q0KmtRnjtmN6mbXirqfYRPhdIzo3gg=;
        b=GQkNYQUeHcQn7/cJ01S1EuMs/ZvGlQHSTt1g+Y9OXaoilNXcrPqw5co2qEDOv7m/u5
         jKtbdNmGWr8vpxa6ydcY8uPA8IB3jY/RHrHitOQJHhI5ZynSwO4BCjPqZKINCncU9MyL
         FCF7LFxKWNiiEgVDyQuyIVZGM/PxgqZaU/g7mSjmZI0ks6Sj2Q9hFcO0HW/pMODZ4s4k
         OpGTc9hzYeVgsRdNGVX/VDki8hV/x90EjQl1ipsIwJyx211upysyyOGWs/UR2MB0YxDx
         DdSGjafnCsNCzq0/mrXMTLHlP66DOyZAm+pvWx+TKjsV8R6YqyHbW2FFcuLWr+w6x20P
         iLBg==
X-Forwarded-Encrypted: i=1; AJvYcCWewBCShLoY6ZZtdJExvQRYxOnGzIrfZMdCXvB1r0uj+/7/NLwz3vmbxMraF0K4GTNCd9nRZFyDUXgdvNL/2avLBXGSi4i22B+w1PgS
X-Gm-Message-State: AOJu0YzVTydINUd9EtXGGSztIqpMIe5lweQNUQZPQX74JokRzIUyShok
	QiDZNEqfluIGDfF5RJryCXviUwoIhWODnEWFloIzDOAuoLzp9XIQ
X-Google-Smtp-Source: AGHT+IETdvnkbL7jBe5elzc9uKKjwOlbE3T5h1ObebIo7QkExO+mBM8E85ccmfRnI+eyxVbVMP7mmw==
X-Received: by 2002:a17:907:2ce4:b0:a4a:3557:6be8 with SMTP id hz4-20020a1709072ce400b00a4a35576be8mr3859430ejc.53.1711441688030;
        Tue, 26 Mar 2024 01:28:08 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b00a46ecbf9fd6sm3958979eju.116.2024.03.26.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:28:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:28:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 1/6] x86: add kconfig symbols for assembler VAES and
 VPCLMULQDQ support
Message-ID: <ZgKHFY/XaN2di1zy@gmail.com>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <20240326080305.402382-2-ebiggers@kernel.org>
 <ZgKC5dcqWSEkwuTX@gmail.com>
 <20240326081816.GA431948@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326081816.GA431948@sol.localdomain>


* Eric Biggers <ebiggers@kernel.org> wrote:

> On Tue, Mar 26, 2024 at 09:10:13AM +0100, Ingo Molnar wrote:
> > 
> > * Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Add config symbols AS_VAES and AS_VPCLMULQDQ that expose whether the
> > > assembler supports the vector AES and carryless multiplication
> > > cryptographic extensions.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  arch/x86/Kconfig.assembler | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> > > index 8ad41da301e5..59aedf32c4ea 100644
> > > --- a/arch/x86/Kconfig.assembler
> > > +++ b/arch/x86/Kconfig.assembler
> > > @@ -23,9 +23,19 @@ config AS_TPAUSE
> > >  config AS_GFNI
> > >  	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
> > >  	help
> > >  	  Supported by binutils >= 2.30 and LLVM integrated assembler
> > >  
> > > +config AS_VAES
> > > +	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
> > > +	help
> > > +	  Supported by binutils >= 2.30 and LLVM integrated assembler
> > 
> > Nit: any reason it isn't called AS_VAESENC, like the instruction itself?
> > 
> > The other new AS_ Kconfig symbols follow the same nomenclature:
> 
> The CPU feature flag is called VAES.  It guards the vaesenc, vaesenclast,
> vaesdec, and vaesdeclast instructions when used on ymm and zmm registers.

I see - fair enough:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

