Return-Path: <linux-kernel+bounces-97435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FA876A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C978BB21B33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A553E17;
	Fri,  8 Mar 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nH6RN648"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9C4879B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921109; cv=none; b=ZqbaX4DszqnLqpkE/8JxNMVyNkVr0o1p/0Av0JOj4d630VT3NoapVsOH0Y8mnrnDG+rQ750qH/GstiM3snsKUgktIfNGPqVF0j0Bxv0lyGCqT9uX0H1rogfzrpL7n8CkfGE9EAH3qQF+HQmqIWKjVUrP+Jk9pStpPwDWlhOL45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921109; c=relaxed/simple;
	bh=/aIrNO8xFlwugwx4fBrTPk+mSw79iBQ4+5XToAQE04Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liderQhKx7RLksyK7AKVirS/Ia/stOgLvVFgxTOoIx5bxtRhF6Oiy0+u0fJh/vAUZtZBjf+QdVL3hFx1CyrPMd8qnbWHddjdoC0hZlvt0L7+MMVYyiTXRsc2kxbdB4r+CMYUAKBlMPlCSK4ctABQrtXPa3iKw4CixOw5k89n1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nH6RN648; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1726675a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709921107; x=1710525907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLs3kZ5OblOBLvikyewkAB+57eMxN1fpqXGCrqHaNUI=;
        b=nH6RN648rqUA/+EvSV0DtjXWXDoT98tYcXX3lxXjTR67qczy5H4Ey2tYY0sERBqtih
         ovb+pFrcldV1R2EXz+enuwdZNh6APbbX0o4zlrCch1T8sN1e+jeaxCsnQaFPbS7z4TpI
         vZyAYPYKmDWscKxtYv4UHeYHfqNsRrYrcFMTA9nPiH/28QQpCwf5JZCNJzv633efstM5
         PbqHpHZyQ5xgcebBjDiSJ1bzFl+fLGMbrgPKWDHqLhBEHJasB76uJgIgBmAwonGc8Kj+
         4XKUh1sy2CfBJPiKZQ46y3YMRMdryEm3PoxOWJFOpYx6HVBhr+7pd5kzBbao01Um+oRd
         Xc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921107; x=1710525907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLs3kZ5OblOBLvikyewkAB+57eMxN1fpqXGCrqHaNUI=;
        b=UAfSltqe7ow8Aksv1/lljExOT8X5Kq6bIU3IyLz3tOgqjNVOOEGZslGwAsCKB0KTru
         a4Q1JTMKwBOfWVz3FPJsjKLLKMCm4EkVuc0kO+6Qac94zxVqPZ44V0ReUcgRydafSOHm
         6CpDWE6bAFFuuz9qW7jddo2aVPEG9dWgv3CVekaaRHIzZBJdqbZ6BCZE3jvEQ6H7+h6G
         AuhKTFPzFgn5EEbVlPiQ4nSsUqTRyhPJFGxLJ+p0bjyinf5P5yIqIGBj+IE4LUFYAp1x
         X+mwA+ZL76QyaPMcsalNVionLocVM0PHdK59c59DA1P114ugiIeGFpEa4AHkcSBUXM6z
         SNaA==
X-Forwarded-Encrypted: i=1; AJvYcCXyDkcvgRe/cCjhNCZ6b2h0IRyJnxqWXcnIFzEmBB7VKDFDpwfUVZQtIKefRmLWgIlF+I8w/IVZK1v3PILx+rEA5Bt1sLBBfAPQUb6T
X-Gm-Message-State: AOJu0Yyw5LrB9mGNmY/g1+HiJSde1LehMt/OsVUtlatYPD4LvXbqNeUL
	823nCdR/HZEhgHwEm2HCK/cKw6zCp6VdhTjIfFb++tEae5CUVQdW/6PGsReUitc=
X-Google-Smtp-Source: AGHT+IENQYcM6sGyM8j6pDoEai9UQoUvp+q5q0Z2Rg+MMx+kdD4QbDMnrmI/tcug7Njwiwm+KSu6Qg==
X-Received: by 2002:a17:90b:914:b0:29b:976d:b5b2 with SMTP id bo20-20020a17090b091400b0029b976db5b2mr758045pjb.17.1709921106862;
        Fri, 08 Mar 2024 10:05:06 -0800 (PST)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id a24-20020a631a18000000b005dc491ccdcesm14313052pga.14.2024.03.08.10.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:05:06 -0800 (PST)
Date: Fri, 8 Mar 2024 10:05:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>, Evan Green <evan@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, Charles Lohr <lohr85@gmail.com>
Subject: Re: [PATCH v8 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <ZetTThVgR0U29EN4@ghost>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
 <20240307-disable_misaligned_probe_config-v8-4-55d696cb398b@rivosinc.com>
 <CAJM55Z9SYA=QMg0Wg-e0Q8nOTP6qSKkc+kxHMGOmmmWrEcVf7w@mail.gmail.com>
 <20240308-docile-pretense-b44c3a84d8b2@wendy>
 <CAJM55Z8EX5D0HZ1xKTkaQEL1RF46DrBynUoTSMP5q8kmDGY_=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z8EX5D0HZ1xKTkaQEL1RF46DrBynUoTSMP5q8kmDGY_=w@mail.gmail.com>

On Fri, Mar 08, 2024 at 05:35:03AM -0800, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > On Fri, Mar 08, 2024 at 01:52:24AM -0800, Emil Renner Berthing wrote:
> > > Charlie Jenkins wrote:
> >
> > > >  config RISCV_MISALIGNED
> > > > -	bool "Support misaligned load/store traps for kernel and userspace"
> > > > +	bool
> > > >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > > > -	default y
> > > >  	help
> > > > -	  Say Y here if you want the kernel to embed support for misaligned
> > > > -	  load/store for both kernel and userspace. When disable, misaligned
> > > > -	  accesses will generate SIGBUS in userspace and panic in kernel.
> > > > +	  Embed support for misaligned load/store for both kernel and userspace.
> > > > +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> > > > +	  and panic in the kernel.
> > >
> > > Hmm.. this is *may* generate SIGBUS in userspace and panic the kernel. The CPU
> > > could support unaligned access natively or there might be a handler in M-mode,
> > > right?
> >
> > Correct. The last sentence could become "When disabled, and there is no
> > support in hardware or firmware, unsigned accesses will...". That said,
> > this option is no longer user visible, so we could really simplify the
> > hell out of this option to just mention that it controls building the
> > in-kernel emulator.
> >
> > > > +choice
> > > > +	prompt "Unaligned Accesses Support"
> > > > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > > > +	help
> > > > +	  This determines the level of support for unaligned accesses. This
> > > > +	  information is used by the kernel to perform optimizations. It is also
> > > > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > > > +	  probed at boot by default.
> > > > +
> > > > +config RISCV_PROBE_UNALIGNED_ACCESS
> > > > +	bool "Probe for hardware unaligned access support"
> > > > +	select RISCV_MISALIGNED
> > > > +	help
> > > > +	  During boot, the kernel will run a series of tests to determine the
> > > > +	  speed of unaligned accesses. This probing will dynamically determine
> > > > +	  the speed of unaligned accesses on the underlying system. If unaligned
> > > > +	  memory accesses trap into the kernel as they are not supported by the
> > > > +	  system, the kernel will emulate the unaligned accesses to preserve the
> > > > +	  UABI.
> > > > +
> > > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > > +	bool "Emulate unaligned access where system support is missing"
> > > > +	select RISCV_MISALIGNED
> > > > +	help
> > > > +	  If unaligned memory accesses trap into the kernel as they are not
> > > > +	  supported by the system, the kernel will emulate the unaligned
> > > > +	  accesses to preserve the UABI. When the underlying system does support
> > > > +	  unaligned accesses, the unaligned accesses are assumed to be slow.
> > >
> > > It's still not quite clear to me when you'd want to choose this over probing
> > > above. Assuming the probe measures correctly this can only result in a kernel
> > > that behaves the same or slower than with the option above, right?
> >
> > Aye, mostly the same - some people don't want the boot-time overhead
> > of actually running the profiling code, so this option is for them.
> > Maybe that's not such a big deal anymore with the improvements to do it
> > in parallel, but given how bad performance on some of the systems is
> > when firmware does the emulation, it is definitely still noticeable.
> > I know we definitely have customers that care about their boot time very
> > strongly, so I can imagine they'd be turning this off.
> 
> Ah, that makes sense. So maybe a help text more along the lines of "Disable
> probing and optimizations for CPUs with fast unaligned memory access" would be
> a better description of this choice?

It does cause probing/optimizations to not be enabled, but it does not
"disable" them. For maximal optimizations for fast unaligned accesses,
the user must select RISCV_EFFICIENT_UNALIGNED_ACCESS before and after
this change. For probing, the user must select
RISCV_PROBE_UNALIGNED_ACCESS.

- Charlie

> 
> > > > +
> > > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > > +	bool "Assume the system supports slow unaligned memory accesses"
> > > > +	depends on NONPORTABLE
> > > > +	help
> > > > +	  Assume that the system supports slow unaligned memory accesses. The
> > > > +	  kernel and userspace programs may not be able to run at all on systems
> > > > +	  that do not support unaligned memory accesses.
> > >
> > > Again you're just explicitly saying no to the optimizations the kernel might do
> > > if it detects fast unaligned access, only here you'll also crash if they're not
> > > handled by the CPU or M-mode. Why would you want that?
> > >
> > > I'm probably missing something, but the only reason I can think of is if you
> > > want build a really small kernel and save the few bytes for the handler and
> > > probing code.
> >
> > Aye, just to allow you to disable the in-kernel emulator. That's
> > currently a choice that is presented to people, so this option preserves
> > that. IMO this is by far the least useful option and is locked behind
> > NONPORTABLE anyway. Maybe we could delete it, and if someone really wants
> > it, it would not be all that much of a hassle to add back in the future?
> 
> Yeah, if noone really needs this less config options is better, but I don't
> feel strongly about this option either way.
> 
> /Emil

