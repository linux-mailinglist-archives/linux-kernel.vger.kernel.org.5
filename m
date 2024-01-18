Return-Path: <linux-kernel+bounces-30607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B58321A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D965B21EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228991EB4C;
	Thu, 18 Jan 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZKfB18HB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F61DA51
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617531; cv=none; b=Bgw5pH06y0UAgh+MAv6XWELRVZmeN6HU4smIDudgcZKXm3Dt2CM6BCvAUsUJmDaR1BCmaoONR9VCYe696rqELbmDRvXONuEWjJtPimklm7HUEAHDaLgSUIyiJLoWRT03XK3Cu9vG/BSUTnS24/vGPVf1VRr2z9pCIeqQ60laYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617531; c=relaxed/simple;
	bh=CF1N170Fl+LcG30fBCcDsbK+WyNrr/XTNDsE6pZFJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/u8jNFb8jv1/GvL/EsyH2BJUZNti2enPzFviUUUV643ldAwvSb/VwXhDmb7ebj7yVobnlSDG9iWwq20CaEYlxulvJMGHLP2UWVZPDPkbHmRcoYUGgJsXnGRO0QJZvSycyXkqzjlEA6D9E6aO+AeYkmj05jPtikUWKPJommL6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZKfB18HB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71e24845aso931785ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705617529; x=1706222329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndKDXGOrFoFDHZB7HOpUvkKYbiRqvsxm4yVW9VD7xiI=;
        b=ZKfB18HBVp2FriuC0ftdzE12WyqE3fKja0tzB/ih8TfSHirmpj78K1mzRED7P3KoWx
         OfOY6NwvWM5eTXIUIUNmT/hwkrW2DKBHD1cDEVoybA6j1CIKZqmRTf67gl6l66SbYgle
         VI9pvDCFkla9n1wGT94Y2gQrk5FlRAdHNndAMFkLIUQh/NIoe4xOhMCCs/ZFv61uGCSo
         /h1AwqfuutlTVri4t1lP3E4UjFpCdYK24rStXcjb5qThU/8TtiKCugesQbYdz9/QWd7m
         TzeS2uU5MjapYzVBfYdyYbXM9SGEL63MExnfHy1KUU6XTUBqKYhb4iT+uZKcTSeewqI1
         sQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617529; x=1706222329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndKDXGOrFoFDHZB7HOpUvkKYbiRqvsxm4yVW9VD7xiI=;
        b=tPJnMDvj9B5n5EXMcNXgyMQMvbZWx+pdSb5n8km9Xq4ayNw/Wg9EKUEbYhIZKZqfFO
         W+1mUwl4k98xb+ErsvZ3G77KnBuuWXWQ0YigDFCEs8w/AyStAe+bAA5ZYY6ROEHKVPNS
         HEKAwNkoggUYCK331XgW4DyDjmXMcErUgIvvYevQ0XKE6wnJ26xF1UvHONDqxSQpv5cq
         fwg8B76MPCScp2XAm7+0AuU/E1KhELrYtLNCCIck+E3UmOjq5Hv4EZrpWc6dE5K12bci
         QwUow3l71WpUmoxmZ+O+VvnPkp18nj6ys72O71KUaxhujRJX9Gf6f500gPqLAwXEPhld
         tI9g==
X-Gm-Message-State: AOJu0Yw7+sy4viF3NZj7GOs5zcED+7nC8JCcmQeGZN34uHyfHctKXfR7
	xn9ZK10R19WIkMJ/nTrOyxQOQnxPHoMLLoodCkriq8NWH8z+zExxM2E4HdSEipA=
X-Google-Smtp-Source: AGHT+IFGJdorMTyT9FVqn3Vii6en9OD33KxlGDMFNpOa4DgkXv8dWhTvsYKpyhTyfW5huuwKp1n6Kw==
X-Received: by 2002:a17:902:efd2:b0:1d4:c98a:2ceb with SMTP id ja18-20020a170902efd200b001d4c98a2cebmr1387341plb.8.1705617528948;
        Thu, 18 Jan 2024 14:38:48 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id e17-20020a170902cf5100b001d052d1aaf2sm1859084plg.101.2024.01.18.14.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:38:48 -0800 (PST)
Date: Thu, 18 Jan 2024 14:38:46 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: lib: Support csum on GCC <11
Message-ID: <ZamodtvgqscAqW8N@ghost>
References: <20240118-museum-ample-11d649f95de8@spud>
 <mhng-6127df88-9768-4f9d-8d78-a1aeb4213451@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6127df88-9768-4f9d-8d78-a1aeb4213451@palmer-ri-x1c9>

On Thu, Jan 18, 2024 at 02:20:42PM -0800, Palmer Dabbelt wrote:
> On Thu, 18 Jan 2024 14:05:44 PST (-0800), Conor Dooley wrote:
> > On Thu, Jan 18, 2024 at 01:53:59PM -0800, Charlie Jenkins wrote:
> > > The OutputOperands field for asm goto statements is only supported
> > > starting from GCC 11. Split the asm goto to remove the use of this
> > > feature.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > Fixes: a04c192eabfb ("riscv: Add checksum library")
> > > ---
> > > The OutputOperands field for asm goto statements is only supported
> > > starting from GCC 11. Split the asm goto to remove the use of this
> > > feature.
> > 
> > Maybe this is a super naive question, but is it possible to just not
> > use the custom csum code for gcc older than 11?
> 
> Charlie and I were talking, these old GCC versions also don't support ZBB.
> So I think we can get away with something like

I sent an updated version that uses CC_HAS_ASM_GOTO_TIED_OUTPUT since
there may exist a compiler that supports ZBB but doesn't support output
in asm goto.

- Charlie

> 
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 06ce8e7250d9..17f883b612c9 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -158,10 +158,16 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> 
> 	/*
> 	 * Zbb support saves 6 instructions, so not worth checking without
> -	 * alternatives if supported
> +	 * alternatives if supported.
> +	 *
> +	 * Note that we pull the check for ZBB into the preprocessor proper
> +	 * here, as otherwise GCC will attempt to compile the code inside the
> +	 * "if (IS_ENABLED(ZBB)" block which fails because GCC10 doesn't
> +	 * support ASM goto output operands.  GCC 10 also doesn't support ZBB,
> +	 * so we're safe with that check here.
> 	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +#if defined(CONFIG_RISCV_ISA_ZBB)
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> 		unsigned long fold_temp;
> 
> 		/*
> @@ -213,6 +219,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> end:
> 		return csum >> 16;
> 	}
> +#endif /*CONFIG_RISCV_ISA_ZBB*/
> no_zbb:
> #ifndef CONFIG_32BIT
> 	csum += ror64(csum, 32);
> @@ -244,10 +251,11 @@ do_csum_no_alignment(const unsigned char *buff, int len)
> 
> 	/*
> 	 * Zbb support saves 6 instructions, so not worth checking without
> -	 * alternatives if supported
> +	 * alternatives if supported.  See above for the ZBB preprocessor
> +	 * check.
> 	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +#if defined(CONFIG_RISCV_ISA_ZBB)
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> 		unsigned long fold_temp;
> 
> 		/*
> @@ -287,6 +295,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
> #endif /* !CONFIG_32BIT */
> 		return csum >> 16;
> 	}
> +#endif /*CONFIG_RISCV_ISA_ZBB*/
> no_zbb:
> #ifndef CONFIG_32BIT
> 	csum += ror64(csum, 32);
> 
> which is building for me on GCC-10/defconfig.
> 
> > 
> > > ---
> > >  arch/riscv/lib/csum.c | 42 ++++++++++++++++++++++++++++++------------
> > >  1 file changed, 30 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > > index 06ce8e7250d9..23be289f52b6 100644
> > > --- a/arch/riscv/lib/csum.c
> > > +++ b/arch/riscv/lib/csum.c
> > > @@ -177,22 +177,35 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> > >  				  : no_zbb);
> > >  #ifdef CONFIG_32BIT
> > > -		asm_volatile_goto(".option push			\n\
> > > +		/*
> > > +		 * OutputOperands in asm goto is not supported until GCC 11, so
> > > +		 * this asm has to be split to be compatible.
> > > +		 */
> > > +		asm (".option push				\n\
> > >  		.option arch,+zbb				\n\
> > >  			rori	%[fold_temp], %[csum], 16	\n\
> > >  			andi	%[offset], %[offset], 1		\n\
> > >  			add	%[csum], %[fold_temp], %[csum]	\n\
> > > -			beq	%[offset], zero, %l[end]	\n\
> > > -			rev8	%[csum], %[csum]		\n\
> > >  		.option pop"
> > >  			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > > -			: [offset] "r" (offset)
> > > -			:
> > > -			: end);
> > > +			: [offset] "r" (offset));
> > > +
> > > +		if (offset == 0)
> > > +			goto end;
> > > +
> > > +		asm (".option push				\n\
> > > +		.option arch, +zbb				\n\
> > > +			rev8	%[csum], %[csum]		\n\
> > > +		.option pop"
> > > +			: [csum] "+r" (csum));
> > >  		return (unsigned short)csum;
> > >  #else /* !CONFIG_32BIT */
> > > -		asm_volatile_goto(".option push			\n\
> > > +		/*
> > > +		 * OutputOperands in asm goto is not supported until GCC 11, so
> > > +		 * this asm has to be split to be compatible.
> > > +		 */
> > > +		asm (".option push				\n\
> > >  		.option arch,+zbb				\n\
> > >  			rori	%[fold_temp], %[csum], 32	\n\
> > >  			add	%[csum], %[fold_temp], %[csum]	\n\
> > > @@ -200,13 +213,18 @@ do_csum_with_alignment(const unsigned char *buff, int len)
> > >  			roriw	%[fold_temp], %[csum], 16	\n\
> > >  			addw	%[csum], %[fold_temp], %[csum]	\n\
> > >  			andi	%[offset], %[offset], 1		\n\
> > > -			beq	%[offset], zero, %l[end]	\n\
> > > -			rev8	%[csum], %[csum]		\n\
> > >  		.option pop"
> > >  			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
> > > -			: [offset] "r" (offset)
> > > -			:
> > > -			: end);
> > > +			: [offset] "r" (offset));
> > > +
> > > +		if (offset == 0)
> > > +			goto end;
> > > +
> > > +		asm (".option push				\n\
> > > +		.option arch, +zbb				\n\
> > > +			rev8	%[csum], %[csum]		\n\
> > > +		.option pop"
> > > +			: [csum] "+r" (csum));
> > >  		return (csum << 16) >> 48;
> > >  #endif /* !CONFIG_32BIT */
> > > 
> > > ---
> > > base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
> > > change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
> > > -- 
> > > - Charlie
> > > 
> > > 

