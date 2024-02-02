Return-Path: <linux-kernel+bounces-50703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D022847D13
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF61C2445E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723712C7E6;
	Fri,  2 Feb 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X65pWUkI"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6063103
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915616; cv=none; b=l8TCJY99OkVQxdIiAxWwt9KgtekytZ0vFs4r5mm+NCDMG3ZJn7a2NXn/Idvy/izZAi9UVv4lZ2CfcyDenXNk33WIzof4AVBGg6DTB2vRJTjTGmOej7edkrVIKAAauTqlx3WnejgYeYm7tBDSfxZsMKxaM2c4S6NOAk+h9qjSTj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915616; c=relaxed/simple;
	bh=zl4j+AaEv8Vgs1eQrhwVDTcs4FxjXQxfIHhHX8agKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8X6M8CYwY3CDeISOEv32j466OWWE+BznJAepIpehdHNQqPElf5EQuRO0auI+Za2iyPL5bck3dXgGqsMlO0akEOOtnTIKDz7HqiGvxyFW9va9it6i6JqX8EwcGYoFLTD3Gq0aqfRMpDsx4lJM9CWoE78c1ZN4Krw5Q6uGUh3VrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X65pWUkI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7393de183so20326365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706915614; x=1707520414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TsmrtpZilFHjgl5uRHHuRHDPg55n9buxc3ptU+YVsk=;
        b=X65pWUkIjznyAm0d3cq4JzqxJaXDcmNk0Nz3cVVLEuGP6bMz6mQSttmaMgYomBQbxl
         OD6P8WzbvQVbJTyMs15rjLTNB35lbtKvre+yD556Pu++WU0DY7McqAT69ujiTYpxMKfC
         8RmpqETitVREvCzPA85OP+TniTjsZoRMwsTsXRBFzM8RwAFDZVeOwCCbMtoPed5hzOJ4
         g6iyod8gvGCHL4F/yI/akOohGV6tv/CdBlgm/kV7yCJjSFsrHbR4HnaKqaz1sTecj1pA
         gf6op5YmcqsQDdrOpH2yFW/viRiHOh9kD50M0rhPQbBIFLETOiDpgdrygfr2VtgJ7lSe
         ih+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706915614; x=1707520414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TsmrtpZilFHjgl5uRHHuRHDPg55n9buxc3ptU+YVsk=;
        b=RhM7li1iKY1Ft3pmVDVIUikSR3ZKW2N1mYEpOy+XlNFcdPbFq83aEbmLxoL4R0p6FH
         kT0lc308uueDEVGmYkHeJkUKk3teyRJQcdWxsgEiywNyuzbK1TLqbdLgrTotXS7n6bgX
         itgypGwDkyfYkmnFEfpz+mhG92dPxaPZPah9zg2LkYzitnbryALEzp13+jmSKXjVUSyV
         fFPzpzAuwb+GtLplXBLHWmx4dvCQPNHS90/Ipi2Y1EzJyHvUIrDdx33gK+aaICb0BVMg
         uRZdDg3CnoaR/lzAoxITX6ohVyYuj6wLmUfMod1/nMGESFNEAc9Pyygvwii8PEfpeiU/
         t4JQ==
X-Gm-Message-State: AOJu0YxcUff9owWF4zgG67Bv7w+guoXfNqAlw5iNSnZO8v6jLAclAo5U
	a/Q5EEFF2Y9etUo+M2ypusthDYodtGVxhJn1lpdm26/XufoYurNs82zev0JnLag=
X-Google-Smtp-Source: AGHT+IH8nwiq4NK5BqTN1VawRr1fSln7uMlRP6FsI8/AgF5/rnSGgmpgRr29akVnyYbZ/pdsMqXwXA==
X-Received: by 2002:a17:903:248:b0:1d9:657c:2769 with SMTP id j8-20020a170903024800b001d9657c2769mr5780377plh.19.1706915614379;
        Fri, 02 Feb 2024 15:13:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+SGgqwEfx19PBs8fHvAMKLSdqMYN36KZd3TpRH+cEFO4JT9WvVgr1NS9UwGhtPQRRDToWcP66E+L9gqzeNj3KoooChAVA/doSfKB1LmUp9aSZkRa0yeWvwmQEiHMpjOxQnWzZnzLV0ehGjfsGmN3us7dxEtEZaRiUyqcsBTjQUoBjfocy2+YmjPRPrEuBtrU7D87vVFr+36JhiI93fkl5m4PRrkRWFoD9r4GTg9AZze5L3YyvoHZbw8JHa59g3lDkbuf470vKVEk0dUpkuaFx+XtWtg==
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902ef0500b001d8ee46170dsm2139216plx.84.2024.02.02.15.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:13:33 -0800 (PST)
Date: Fri, 2 Feb 2024 15:13:31 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <Zb13G6ESgxCa4vhG@ghost>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>
 <20240202230101.GB2055@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202230101.GB2055@sol.localdomain>

On Fri, Feb 02, 2024 at 03:01:01PM -0800, Eric Biggers wrote:
> On Thu, Feb 01, 2024 at 03:30:46PM -0800, Charlie Jenkins wrote:
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index eb3ac304fc42..3a29d8e30e05 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -51,6 +51,7 @@ static inline bool check_unaligned_access_emulated(int cpu)
> >  static inline void unaligned_emulation_finish(void) {}
> >  #endif
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> #ifdef..#else..#endif is more readable than #ifndef..#else..#endif.
> 
> > diff --git a/arch/riscv/include/asm/misaligned_access_speed.h b/arch/riscv/include/asm/misaligned_access_speed.h
> > new file mode 100644
> > index 000000000000..81df2aa6fa6b
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/misaligned_access_speed.h
> 
> This new header file isn't included from anywhere.
> 

I thought I deleted that...

> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f71910718053..8be7f17da9ab 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -62,6 +62,9 @@ obj-y	+= tests/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >  
> >  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> > +ifneq ($(RISCV_EFFICIENT_UNALIGNED_ACCESS), y)
> > +obj-y	+= misaligned_access_speed.o
> > +endif
> 
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index a7c56b41efd2..3f1a6edfdb08 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> >  
> >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  {
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	int cpu;
> >  	u64 perf = -1ULL;
> >  
> > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> >  
> >  	return perf;
> > +#else
> > +	return RISCV_HWPROBE_MISALIGNED_FAST;
> > +#endif
> 
> #ifdef..#else..#endif is more readable than #ifndef..#else..#endif.
> 
> - Eric

Thanks for pointing these out, I will send a v3.

- Charlie


